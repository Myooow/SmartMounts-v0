local addonName, addonTable = ...

-- Récupération de la base de données
local MountDatabase = addonTable.MountDatabase

-- Libraries
local LDB = LibStub:GetLibrary("LibDataBroker-1.1", true)
local DBIcon = LibStub("LibDBIcon-1.0", true)

-------------------------------------------------
-- Variables globales
-------------------------------------------------
local SmartMountsFrame
local currentFilter = "all"
local searchText = ""

-------------------------------------------------
-- Minimap icon
-------------------------------------------------
local dataobj
if LDB then
    dataobj = LDB:NewDataObject("SmartMounts", {
        type = "data source",
        text = "SmartMounts",
        icon = "Interface\\Icons\\Ability_Mount_WhiteDireWolf",
        OnClick = function()
            if SmartMountsFrame and SmartMountsFrame:IsShown() then
                SmartMountsFrame:Hide()
            else
                SmartMounts_ShowMainFrame()
            end
        end,
        OnEnter = function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
            GameTooltip:AddLine("SmartMounts")
            GameTooltip:AddLine("|cffFFFFFFClique gauche:|r Ouvrir la fenêtre", 1, 1, 1)
            local collected = MountDatabase.GetCollectedCount()
            local total = MountDatabase.GetTotalCount()
            GameTooltip:AddLine(string.format("|cff00FF00%d|r / |cffFFFF00%d|r montures collectées", collected, total), 1, 1, 1)
            GameTooltip:Show()
        end,
        OnLeave = function()
            GameTooltip:Hide()
        end,
    })
end

-------------------------------------------------
-- Création de la fenêtre principale
-------------------------------------------------
function SmartMounts_ShowMainFrame()
    if SmartMountsFrame then
        SmartMountsFrame:Show()
        SmartMounts_UpdateMountList()
        return
    end

    -- Création de la frame principale
    SmartMountsFrame = CreateFrame("Frame", "SmartMountsFrame", UIParent, "BackdropTemplate")
    SmartMountsFrame:SetSize(450, 600)
    SmartMountsFrame:SetPoint("CENTER")
    SmartMountsFrame:SetMovable(true)
    SmartMountsFrame:EnableMouse(true)
    SmartMountsFrame:SetClampedToScreen(true)
    SmartMountsFrame:RegisterForDrag("LeftButton")
    SmartMountsFrame:SetScript("OnDragStart", SmartMountsFrame.StartMoving)
    SmartMountsFrame:SetScript("OnDragStop", SmartMountsFrame.StopMovingOrSizing)

    SmartMountsFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 16,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    SmartMountsFrame:SetBackdropColor(0, 0, 0, 0.95)
    SmartMountsFrame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)

    -- Bouton de fermeture
    local closeButton = CreateFrame("Button", nil, SmartMountsFrame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -5, -5)

    -- Titre
    local title = SmartMountsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("SmartMounts")
    title:SetTextColor(1, 0.8, 0)

    -- Statistiques
    local statsText = SmartMountsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statsText:SetPoint("TOP", title, "BOTTOM", 0, -5)
    local collected = MountDatabase.GetCollectedCount()
    local total = MountDatabase.GetTotalCount()
    statsText:SetText(string.format("|cff00FF00%d|r / |cffFFFF00%d|r montures collectées (%.1f%%)", 
        collected, total, (collected/total)*100))
    SmartMountsFrame.statsText = statsText

    -- Barre de recherche
    local searchBox = CreateFrame("EditBox", nil, SmartMountsFrame, "InputBoxTemplate")
    searchBox:SetSize(200, 20)
    searchBox:SetPoint("TOPLEFT", 20, -70)
    searchBox:SetAutoFocus(false)
    searchBox:SetScript("OnTextChanged", function(self)
        searchText = self:GetText():lower()
        SmartMounts_UpdateMountList()
    end)
    searchBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)
    SmartMountsFrame.searchBox = searchBox

    local searchLabel = SmartMountsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    searchLabel:SetPoint("BOTTOMLEFT", searchBox, "TOPLEFT", 0, 5)
    searchLabel:SetText("Recherche:")

    -- Dropdown pour les filtres
    local filterDropdown = CreateFrame("Frame", "SmartMountsFilterDropdown", SmartMountsFrame, "UIDropDownMenuTemplate")
    filterDropdown:SetPoint("TOPRIGHT", -20, -65)
    
    local function FilterDropdown_Initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        
        -- Option "Toutes"
        info.text = "Toutes les montures"
        info.value = "all"
        info.func = function()
            currentFilter = "all"
            UIDropDownMenu_SetSelectedValue(filterDropdown, "all")
            SmartMounts_UpdateMountList()
        end
        info.checked = (currentFilter == "all")
        UIDropDownMenu_AddButton(info)
        
        -- Option "Collectées"
        info.text = "Collectées seulement"
        info.value = "collected"
        info.func = function()
            currentFilter = "collected"
            UIDropDownMenu_SetSelectedValue(filterDropdown, "collected")
            SmartMounts_UpdateMountList()
        end
        info.checked = (currentFilter == "collected")
        UIDropDownMenu_AddButton(info)
        
        -- Option "Manquantes"
        info.text = "Manquantes seulement"
        info.value = "missing"
        info.func = function()
            currentFilter = "missing"
            UIDropDownMenu_SetSelectedValue(filterDropdown, "missing")
            SmartMounts_UpdateMountList()
        end
        info.checked = (currentFilter == "missing")
        UIDropDownMenu_AddButton(info)
        
        -- Séparateur
        info = UIDropDownMenu_CreateInfo()
        info.text = ""
        info.isTitle = true
        info.notCheckable = true
        UIDropDownMenu_AddButton(info)
        
        -- Filtres par extension
        local expansions = MountDatabase.GetExpansions()
        for _, expansion in ipairs(expansions) do
            info = UIDropDownMenu_CreateInfo()
            info.text = expansion
            info.value = expansion
            info.func = function()
                currentFilter = expansion
                UIDropDownMenu_SetSelectedValue(filterDropdown, expansion)
                SmartMounts_UpdateMountList()
            end
            info.checked = (currentFilter == expansion)
            UIDropDownMenu_AddButton(info)
        end
    end
    
    UIDropDownMenu_Initialize(filterDropdown, FilterDropdown_Initialize)
    UIDropDownMenu_SetWidth(filterDropdown, 150)
    UIDropDownMenu_SetSelectedValue(filterDropdown, "all")
    UIDropDownMenu_SetText(filterDropdown, "Toutes les montures")

    -- Scroll Frame pour la liste
    local scrollFrame = CreateFrame("ScrollFrame", "SmartMountsScrollFrame", SmartMountsFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 20, -110)
    scrollFrame:SetPoint("BOTTOMRIGHT", -40, 20)
    
    local scrollChild = CreateFrame("Frame")
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetWidth(380)
    scrollChild:SetHeight(1)
    SmartMountsFrame.scrollChild = scrollChild
    SmartMountsFrame.scrollFrame = scrollFrame

    SmartMountsFrame:Show()
    SmartMounts_UpdateMountList()
end

-------------------------------------------------
-- Création de la modal de guide
-------------------------------------------------
function SmartMounts_ShowGuideModal(mountName, mountData)
    if SmartMountsGuideModal then
        SmartMountsGuideModal:Show()
        SmartMounts_UpdateGuideModal(mountName, mountData)
        return
    end

    -- Création de la modal
    SmartMountsGuideModal = CreateFrame("Frame", "SmartMountsGuideModal", UIParent, "BackdropTemplate")
    SmartMountsGuideModal:SetSize(500, 600)
    SmartMountsGuideModal:SetPoint("CENTER")
    SmartMountsGuideModal:SetMovable(true)
    SmartMountsGuideModal:EnableMouse(true)
    SmartMountsGuideModal:SetClampedToScreen(true)
    SmartMountsGuideModal:RegisterForDrag("LeftButton")
    SmartMountsGuideModal:SetScript("OnDragStart", SmartMountsGuideModal.StartMoving)
    SmartMountsGuideModal:SetScript("OnDragStop", SmartMountsGuideModal.StopMovingOrSizing)
    SmartMountsGuideModal:SetFrameStrata("DIALOG")

    -- Fond semi-transparent pour bloquer l'interaction
    local overlay = CreateFrame("Frame", nil, UIParent)
    overlay:SetAllPoints()
    overlay:SetFrameStrata("DIALOG")
    overlay:SetFrameLevel(SmartMountsGuideModal:GetFrameLevel() - 1)
    overlay:EnableMouse(true)
    overlay:SetScript("OnMouseDown", function() end) -- Bloque les clics
    SmartMountsGuideModal.overlay = overlay

    overlay:SetScript("OnShow", function()
        overlay:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"})
        overlay:SetBackdropColor(0, 0, 0, 0.7)
    end)

    SmartMountsGuideModal:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 16,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    SmartMountsGuideModal:SetBackdropColor(0.05, 0.05, 0.15, 0.98)
    SmartMountsGuideModal:SetBackdropBorderColor(0.6, 0.4, 0.8, 1)

    -- Bouton de fermeture
    local closeButton = CreateFrame("Button", nil, SmartMountsGuideModal, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function()
        SmartMountsGuideModal:Hide()
        SmartMountsGuideModal.overlay:Hide()
    end)

    -- Header avec icône et nom
    SmartMountsGuideModal.headerFrame = CreateFrame("Frame", nil, SmartMountsGuideModal)
    SmartMountsGuideModal.headerFrame:SetSize(480, 80)
    SmartMountsGuideModal.headerFrame:SetPoint("TOP", 0, -15)

    SmartMountsGuideModal.mountIcon = SmartMountsGuideModal.headerFrame:CreateTexture(nil, "ARTWORK")
    SmartMountsGuideModal.mountIcon:SetSize(64, 64)
    SmartMountsGuideModal.mountIcon:SetPoint("LEFT", 20, 0)

    SmartMountsGuideModal.mountName = SmartMountsGuideModal.headerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    SmartMountsGuideModal.mountName:SetPoint("LEFT", SmartMountsGuideModal.mountIcon, "RIGHT", 15, 10)
    SmartMountsGuideModal.mountName:SetTextColor(1, 0.8, 0)

    SmartMountsGuideModal.mountInfo = SmartMountsGuideModal.headerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    SmartMountsGuideModal.mountInfo:SetPoint("TOPLEFT", SmartMountsGuideModal.mountName, "BOTTOMLEFT", 0, -5)
    SmartMountsGuideModal.mountInfo:SetTextColor(0.8, 0.8, 1)

    -- Zone de contenu avec scroll
    local contentFrame = CreateFrame("Frame", nil, SmartMountsGuideModal, "BackdropTemplate")
    contentFrame:SetPoint("TOPLEFT", 20, -110)
    contentFrame:SetPoint("BOTTOMRIGHT", -20, 60)
    contentFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 8,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    contentFrame:SetBackdropColor(0, 0, 0, 0.4)
    contentFrame:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)

    local scrollFrame = CreateFrame("ScrollFrame", nil, contentFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 8)

    local scrollChild = CreateFrame("Frame")
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetWidth(420)
    SmartMountsGuideModal.scrollChild = scrollChild

    -- Boutons d'action
    local actionFrame = CreateFrame("Frame", nil, SmartMountsGuideModal)
    actionFrame:SetSize(480, 50)
    actionFrame:SetPoint("BOTTOM", 0, 10)

    local waypointButton = CreateFrame("Button", nil, actionFrame, "UIPanelButtonTemplate")
    waypointButton:SetSize(120, 25)
    waypointButton:SetPoint("LEFT", 20, 0)
    waypointButton:SetText("Waypoint")
    SmartMountsGuideModal.waypointButton = waypointButton

    local wowheadButton = CreateFrame("Button", nil, actionFrame, "UIPanelButtonTemplate")
    wowheadButton:SetSize(120, 25)
    wowheadButton:SetPoint("CENTER", 0, 0)
    wowheadButton:SetText("Wowhead")
    SmartMountsGuideModal.wowheadButton = wowheadButton

    local closeModalButton = CreateFrame("Button", nil, actionFrame, "UIPanelButtonTemplate")
    closeModalButton:SetSize(120, 25)
    closeModalButton:SetPoint("RIGHT", -20, 0)
    closeModalButton:SetText("Fermer")
    closeModalButton:SetScript("OnClick", function()
        SmartMountsGuideModal:Hide()
        SmartMountsGuideModal.overlay:Hide()
    end)

    SmartMounts_UpdateGuideModal(mountName, mountData)
    SmartMountsGuideModal.overlay:Show()
    SmartMountsGuideModal:Show()
end

-------------------------------------------------
-- Mise à jour de la modal de guide
-------------------------------------------------
function SmartMounts_UpdateGuideModal(mountName, mountData)
    if not SmartMountsGuideModal then return end

    -- Header
    local iconPath = mountData.icon or "Interface\\Icons\\Ability_Mount_WhiteDireWolf"
    SmartMountsGuideModal.mountIcon:SetTexture(iconPath)
    SmartMountsGuideModal.mountName:SetText(mountName)
    
    local infoText = string.format("%s - %s", mountData.expansion or "Unknown", mountData.location or "Unknown")
    if mountData.dropChance then
        infoText = infoText .. string.format(" (%s)", mountData.dropChance)
    end
    SmartMountsGuideModal.mountInfo:SetText(infoText)

    -- Nettoyer les anciennes étapes
    local scrollChild = SmartMountsGuideModal.scrollChild
    if scrollChild.steps then
        for _, step in ipairs(scrollChild.steps) do
            step:Hide()
        end
    end
    scrollChild.steps = {}

    -- Créer les étapes du guide
    if mountData.guide then
        local yOffset = -10
        for i, stepData in ipairs(mountData.guide) do
            local step = SmartMounts_CreateGuideStep(scrollChild, i, stepData)
            step:SetPoint("TOPLEFT", 0, yOffset)
            table.insert(scrollChild.steps, step)
            yOffset = yOffset - step:GetHeight() - 10
        end
        scrollChild:SetHeight(math.abs(yOffset) + 20)
    else
        -- Guide par défaut si pas de guide spécifique
        local defaultStep = SmartMounts_CreateGuideStep(scrollChild, 1, {
            title = "Obtenir " .. mountName,
            description = mountData.description or "Aucun guide détaillé disponible pour cette monture.",
            type = "info"
        })
        defaultStep:SetPoint("TOPLEFT", 0, -10)
        table.insert(scrollChild.steps, defaultStep)
        scrollChild:SetHeight(100)
    end

    -- Configurer les boutons
    SmartMountsGuideModal.wowheadButton:SetScript("OnClick", function()
        local url = string.format("https://www.wowhead.com/item=%d", mountData.itemId)
        print(string.format("|cffFFD700[SmartMounts]|r Lien Wowhead: |cff87CEEB%s|r", url))
    end)

    if mountData.coords then
        SmartMountsGuideModal.waypointButton:SetScript("OnClick", function()
            local x, y = mountData.coords.x or 50, mountData.coords.y or 50
            print(string.format("|cffFFD700[SmartMounts]|r Waypoint: %.1f, %.1f", x, y))
            -- Ici vous pourriez intégrer avec TomTom ou un autre addon de waypoint
        end)
        SmartMountsGuideModal.waypointButton:Enable()
    else
        SmartMountsGuideModal.waypointButton:Disable()
    end
end

-------------------------------------------------
-- Création d'une étape de guide
-------------------------------------------------
function SmartMounts_CreateGuideStep(parent, stepNumber, stepData)
    local step = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    step:SetSize(420, 80)
    
    step:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 8,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    
    -- Couleur selon le type d'étape
    local typeColors = {
        travel = {0.2, 0.4, 0.8, 0.7},     -- Bleu pour voyage
        dungeon = {0.8, 0.4, 0.2, 0.7},    -- Orange pour donjon
        boss = {0.8, 0.2, 0.2, 0.7},       -- Rouge pour boss
        quest = {0.2, 0.8, 0.4, 0.7},      -- Vert pour quête
        progress = {0.6, 0.4, 0.8, 0.7},   -- Violet pour progression
        info = {0.4, 0.4, 0.4, 0.7}        -- Gris pour info
    }
    
    local color = typeColors[stepData.type] or typeColors.info
    step:SetBackdropColor(color[1], color[2], color[3], color[4])
    step:SetBackdropBorderColor(color[1] + 0.2, color[2] + 0.2, color[3] + 0.2, 1)

    -- Numéro de l'étape
    local stepNum = step:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    stepNum:SetPoint("TOPLEFT", 10, -10)
    stepNum:SetText(stepNumber)
    stepNum:SetTextColor(1, 1, 1)

    -- Titre de l'étape
    local title = step:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", stepNum, "TOPRIGHT", 10, 0)
    title:SetPoint("TOPRIGHT", -10, -10)
    title:SetJustifyH("LEFT")
    title:SetText(stepData.title or "Étape " .. stepNumber)
    title:SetTextColor(1, 0.9, 0.6)

    -- Description
    local desc = step:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    desc:SetPoint("TOPRIGHT", title, "BOTTOMRIGHT", 0, -8)
    desc:SetJustifyH("LEFT")
    desc:SetText(stepData.description or "")
    desc:SetTextColor(0.9, 0.9, 0.9)

    -- Coordonnées si disponibles
    if stepData.coords then
        local coords = step:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        coords:SetPoint("BOTTOMRIGHT", -10, 8)
        coords:SetText(string.format("%.1f, %.1f", stepData.coords.x or 0, stepData.coords.y or 0))
        coords:SetTextColor(0.7, 0.7, 1)
    end

    -- Icône du type d'étape
    local typeIcon = step:CreateTexture(nil, "ARTWORK")
    typeIcon:SetSize(16, 16)
    typeIcon:SetPoint("TOPRIGHT", -10, -10)
    
    local typeIcons = {
        travel = "Interface\\Icons\\Ability_Druid_FlightForm",
        dungeon = "Interface\\Icons\\Achievement_Dungeon_GloryoftheRaider",
        boss = "Interface\\Icons\\Achievement_Boss_Illidan",
        quest = "Interface\\Icons\\INV_Letter_18",
        progress = "Interface\\Icons\\Ability_Warrior_VictoryRush",
        info = "Interface\\Icons\\INV_Misc_Note_01"
    }
    
    typeIcon:SetTexture(typeIcons[stepData.type] or typeIcons.info)

    return step
end
function SmartMounts_UpdateMountList()
    if not SmartMountsFrame or not SmartMountsFrame.scrollChild then
        return
    end

    local scrollChild = SmartMountsFrame.scrollChild
    
    -- Nettoyer les anciens éléments
    for i = 1, #(scrollChild.mountItems or {}) do
        scrollChild.mountItems[i]:Hide()
    end
    scrollChild.mountItems = scrollChild.mountItems or {}

    -- Filtrer les montures
    local filteredMounts = {}
    for mountName, mountData in pairs(MountDatabase.mounts) do
        local shouldShow = true
        
        -- Filtre de recherche
        if searchText ~= "" then
            if not string.find(mountName:lower(), searchText) and 
               not string.find(mountData.location:lower(), searchText) and
               not string.find((mountData.boss or ""):lower(), searchText) then
                shouldShow = false
            end
        end
        
        -- Filtre par catégorie
        if shouldShow then
            if currentFilter == "collected" then
                shouldShow = MountDatabase.HasMount(mountData.spellId)
            elseif currentFilter == "missing" then
                shouldShow = not MountDatabase.HasMount(mountData.spellId)
            elseif currentFilter ~= "all" then
                shouldShow = (mountData.expansion == currentFilter)
            end
        end
        
        if shouldShow then
            table.insert(filteredMounts, {name = mountName, data = mountData})
        end
    end
    
    -- Trier par nom
    table.sort(filteredMounts, function(a, b) return a.name < b.name end)
    
    -- Créer les éléments de la liste
    local yOffset = -5
    for i, mount in ipairs(filteredMounts) do
        local item = scrollChild.mountItems[i]
        if not item then
            item = SmartMounts_CreateMountItem(scrollChild)
            scrollChild.mountItems[i] = item
        end
        
        SmartMounts_SetupMountItem(item, mount.name, mount.data)
        item:SetPoint("TOPLEFT", 0, yOffset)
        item:Show()
        yOffset = yOffset - 80
    end
    
    scrollChild:SetHeight(math.abs(yOffset) + 10)
    
    -- Mettre à jour les stats
    if SmartMountsFrame.statsText then
        local collected = MountDatabase.GetCollectedCount()
        local total = MountDatabase.GetTotalCount()
        SmartMountsFrame.statsText:SetText(string.format("|cff00FF00%d|r / |cffFFFF00%d|r montures collectées (%.1f%%)", 
            collected, total, (collected/total)*100))
    end
end

-------------------------------------------------
-- Création d'un élément de monture
-------------------------------------------------
function SmartMounts_CreateMountItem(parent)
    local item = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    item:SetSize(380, 75)
    item:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    item:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
    item:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
    
    -- Icône
    item.icon = item:CreateTexture(nil, "ARTWORK")
    item.icon:SetSize(60, 60)
    item.icon:SetPoint("LEFT", 8, 0)
    item.icon:SetTexture("Interface\\Icons\\Ability_Mount_WhiteDireWolf")
    
    -- Cadre pour l'icône (effet de sélection)
    item.iconFrame = CreateFrame("Frame", nil, item, "BackdropTemplate")
    item.iconFrame:SetPoint("CENTER", item.icon, "CENTER", 0, 0)
    item.iconFrame:SetSize(64, 64)
    item.iconFrame:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 2,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    item.iconFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8)
    
    -- Nom de la monture
    item.nameText = item:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    item.nameText:SetPoint("TOPLEFT", item.icon, "TOPRIGHT", 10, 0)
    item.nameText:SetPoint("TOPRIGHT", -10, 0)
    item.nameText:SetJustifyH("LEFT")
    
    -- Informations
    item.infoText = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    item.infoText:SetPoint("TOPLEFT", item.nameText, "BOTTOMLEFT", 0, -5)
    item.infoText:SetPoint("TOPRIGHT", item.nameText, "BOTTOMRIGHT", 0, -5)
    item.infoText:SetJustifyH("LEFT")
    
    -- Drop rate
    item.dropText = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    item.dropText:SetPoint("TOPLEFT", item.infoText, "BOTTOMLEFT", 0, -5)
    item.dropText:SetPoint("TOPRIGHT", item.infoText, "BOTTOMRIGHT", 0, -5)
    item.dropText:SetJustifyH("LEFT")
    
    -- Status (collecté ou non)
    item.statusText = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    item.statusText:SetPoint("TOPRIGHT", -10, -5)
    
    return item
end

-------------------------------------------------
-- Configuration d'un élément de monture
-------------------------------------------------
function SmartMounts_SetupMountItem(item, mountName, mountData)
    -- Icône
    local iconPath = mountData.icon or "Interface\\Icons\\Ability_Mount_WhiteDireWolf"
    item.icon:SetTexture(iconPath)
    
    -- Nom
    local nameColor = MountDatabase.HasMount(mountData.spellId) and "|cff00FF00" or "|cffFFFFFF"
    item.nameText:SetText(nameColor .. mountName)
    
    -- Informations
    local infoStr = string.format("|cffFFD700%s|r - |cff87CEEB%s|r", 
        mountData.expansion or "Unknown", 
        mountData.location or "Unknown location")
    if mountData.boss then
        infoStr = infoStr .. string.format(" (%s)", mountData.boss)
    end
    item.infoText:SetText(infoStr)
    
    -- Drop rate et source
    local dropStr = string.format("|cffFFA500Source:|r %s", mountData.source or "Unknown")
    if mountData.dropChance then
        dropStr = dropStr .. string.format(" - |cffFF6347Taux:|r %s", mountData.dropChance)
    end
    if mountData.difficulty then
        dropStr = dropStr .. string.format(" - |cffDDA0DDDifficulté:|r %s", mountData.difficulty)
    end
    item.dropText:SetText(dropStr)
    
    -- Status
    if MountDatabase.HasMount(mountData.spellId) then
        item.statusText:SetText("|cff00FF00✓ COLLECTÉ")
        item:SetBackdropColor(0.0, 0.2, 0.0, 0.8)
        item:SetBackdropBorderColor(0.0, 0.8, 0.0, 1)
    else
        item.statusText:SetText("|cffFF0000✗ MANQUANT")
        item:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
        item:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
    end
    
    -- Clic pour ouvrir le guide
    item:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            SmartMounts_ShowGuideModal(mountName, mountData)
        end
    end)
end
    -- Effet de survol
item:SetScript("OnEnter", function(self)
    item.iconFrame:SetBackdropBorderColor(1, 0.8, 0, 1)
    item:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
    
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetHyperlink("item:" .. mountData.itemId)
    if mountData.description then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(mountData.description, 1, 1, 1, true)
    end
    if mountData.coords and mountData.coords.mapId then
        GameTooltip:AddLine(string.format("Coordonnées: %.1f, %.1f", 
            mountData.coords.x or 0, mountData.coords.y or 0), 0.7, 0.7, 1)
    end
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("|cffFFD700Clic gauche:|r Ouvrir le guide", 0.5, 1, 0.5)
    GameTooltip:Show()
end)

item:SetScript("OnLeave", function()
    item.iconFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8)
    item:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
    GameTooltip:Hide()
end)

-- CORRECTION COMPLÈTE DE LA FONCTION SmartMounts_SetupMountItem
function SmartMounts_SetupMountItem(item, mountName, mountData)
    -- Icône
    local iconPath = mountData.icon or "Interface\\Icons\\Ability_Mount_WhiteDireWolf"
    item.icon:SetTexture(iconPath)
    
    -- Nom
    local nameColor = MountDatabase.HasMount(mountData.spellId) and "|cff00FF00" or "|cffFFFFFF"
    item.nameText:SetText(nameColor .. mountName)
    
    -- Informations
    local infoStr = string.format("|cffFFD700%s|r - |cff87CEEB%s|r", 
        mountData.expansion or "Unknown", 
        mountData.location or "Unknown location")
    if mountData.boss then
        infoStr = infoStr .. string.format(" (%s)", mountData.boss)
    end
    item.infoText:SetText(infoStr)
    
    -- Drop rate et source
    local dropStr = string.format("|cffFFA500Source:|r %s", mountData.source or "Unknown")
    if mountData.dropChance then
        dropStr = dropStr .. string.format(" - |cffFF6347Taux:|r %s", mountData.dropChance)
    end
    if mountData.difficulty then
        dropStr = dropStr .. string.format(" - |cffDDA0DDDifficulté:|r %s", mountData.difficulty)
    end
    item.dropText:SetText(dropStr)
    
    -- Status
    if MountDatabase.HasMount(mountData.spellId) then
        item.statusText:SetText("|cff00FF00✓ COLLECTÉ")
        item:SetBackdropColor(0.0, 0.2, 0.0, 0.8)
        item:SetBackdropBorderColor(0.0, 0.8, 0.0, 1)
    else
        item.statusText:SetText("|cffFF0000✗ MANQUANT")
        item:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
        item:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
    end
    
    -- Clic pour ouvrir le guide
    item:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            SmartMounts_ShowGuideModal(mountName, mountData)
        end
    end)
    
    -- Effet de survol - UTILISER 'self' AU LIEU DE 'item'
    item:SetScript("OnEnter", function(self)
        -- 'self' fait référence à l'item sur lequel on survole
        self.iconFrame:SetBackdropBorderColor(1, 0.8, 0, 1)
        self:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
        
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink("item:" .. mountData.itemId)
        if mountData.description then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(mountData.description, 1, 1, 1, true)
        end
        if mountData.coords and mountData.coords.mapId then
            GameTooltip:AddLine(string.format("Coordonnées: %.1f, %.1f", 
                mountData.coords.x or 0, mountData.coords.y or 0), 0.7, 0.7, 1)
        end
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("|cffFFD700Clic gauche:|r Ouvrir le guide", 0.5, 1, 0.5)
        GameTooltip:Show()
    end)
    
    -- Effet de fin de survol - UTILISER 'self' AU LIEU DE 'item'
    item:SetScript("OnLeave", function(self)
        -- 'self' fait référence à l'item qu'on quitte
        self.iconFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8)
        self:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
        GameTooltip:Hide()
    end)
end

function SmartMounts_DebugItem(item)
    if not item then
        print("ERROR: item is nil")
        return false
    end
    
    if not item.iconFrame then
        print("ERROR: item.iconFrame is nil")
        return false
    end
    
    print("DEBUG: item and item.iconFrame are valid")
    return true
end
-------------------------------------------------
-- Event handling
-------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("LEARNED_SPELL_IN_TAB")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "SmartMounts" then
            -- Initialiser les paramètres sauvegardés
            SmartMountsDB = SmartMountsDB or { minimap = { hide = false } }
        end
    elseif event == "PLAYER_LOGIN" then
        -- Enregistrer l'icône minimap
        if DBIcon and dataobj then
            DBIcon:Register("SmartMounts", dataobj, SmartMountsDB.minimap)
        end
        
        local collected = MountDatabase.GetCollectedCount()
        local total = MountDatabase.GetTotalCount()
        print(string.format("|cff00ff00[SmartMounts]|r Chargé avec %d/%d montures (%.1f%%)", 
            collected, total, (collected/total)*100))
    elseif event == "LEARNED_SPELL_IN_TAB" then
        -- Mettre à jour la liste si une nouvelle monture est apprise
        if SmartMountsFrame and SmartMountsFrame:IsShown() then
            SmartMounts_UpdateMountList()
        end
    end
end)

-------------------------------------------------
-- Commandes slash
-------------------------------------------------
SLASH_SMARTMOUNTS1 = "/smartmounts"
SLASH_SMARTMOUNTS2 = "/sm"
SlashCmdList["SMARTMOUNTS"] = function(msg)
    SmartMounts_ShowMainFrame()
end