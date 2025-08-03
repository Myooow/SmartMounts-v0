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
        edgeSize = 32,
        insets = { left = 6, right = 6, top = 6, bottom = 6 }
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
    local usable    = MountDatabase.GetKnownCount()
    local journal    = MountDatabase.GetUsableCount()
    local collected = MountDatabase.GetCollectedCount()
    local total     = MountDatabase.GetTotalCount()
    statsText:SetText(string.format("|cffffffff%d|r utilisables |cffffffff%d|r dans le journal  |cff00ff00%d|r collectées  |cff999999%d|r possibles",
                                usable, journal, collected, total, (collected/total)*100))
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
-- Mise à jour de la liste des montures
-------------------------------------------------
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
    
    -- Trier par extension PUIS par nom
    local order = MountDatabase.EXPANSION_ORDER or {}
    table.sort(filteredMounts, function(a, b)
        local oa = order[a.data.expansion] or math.huge
        local ob = order[b.data.expansion] or math.huge
        if oa == ob then
            return a.name < b.name          -- même extension → ordre alpha
        else
            return oa < ob                  -- sinon plus ancien d'abord
        end
    end)
    
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
        local usable    = MountDatabase.GetKnownCount()
        local journal    = MountDatabase.GetUsableCount()
        local collected = MountDatabase.GetCollectedCount()
        local total     = MountDatabase.GetTotalCount()
        SmartMountsFrame.statsText:SetText(string.format("|cffffffff%d|r utilisables |cffffffff%d|r dans le journal  |cff00ff00%d|r collectées  |cff999999%d|r possibles",
                                    usable, journal, collected, total, (collected/total)*100))
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
    local iconTexture = mountData.icon                                  -- chemin fourni dans MountDatabase
    if not iconTexture or iconTexture == "" then                        -- fallback si champ manquant
        iconTexture = select(3, GetSpellInfo(mountData.spellId))           -- ou celle du sort
                or "Interface\\Icons\\INV_Misc_QuestionMark"            -- secours
    end
    item.icon:SetTexture(iconTexture)

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
        item.statusText:SetText("|cff00FF00COLLECTÉ")
        item:SetBackdropColor(0.0, 0.2, 0.0, 0.8)
        item:SetBackdropBorderColor(0.0, 0.8, 0.0, 1)
    else
        item.statusText:SetText("|cffFF0000MANQUANT")
        item:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
        item:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
    end
    
    -- Tooltip au survol
    item:SetScript("OnEnter", function(self)
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
        GameTooltip:Show()
    end)
    
    item:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
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