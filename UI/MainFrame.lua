local addonName, addonTable = ...

-- Créer le module UI si il n'existe pas
addonTable.UI = addonTable.UI or {}

-- Références aux modules
local Core = addonTable.Core
local ModelViewer

-- Module MainFrame
local MainFrame = {}
addonTable.UI.MainFrame = MainFrame

-------------------------------------------------
-- Gestion de la sélection
-------------------------------------------------
function MainFrame:ClearSelection()
    if selectedItem then
        -- Restaurer l'apparence normale
        local isCollected = Core.HasMount(selectedItem.mountData.spellId)
        if isCollected then
            selectedItem:SetBackdropColor(0.0, 0.15, 0.0, 0.8)
            selectedItem:SetBackdropBorderColor(0.0, 0.5, 0.0, 1)
        else
            selectedItem:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
            selectedItem:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
        end
        selectedItem = nil
    end
end

function MainFrame:SelectItem(item, mountName, mountData)
    selectedItem = item
    -- Couleur de sélection
    item:SetBackdropColor(0.2, 0.3, 0.5, 0.9)
    item:SetBackdropBorderColor(0.4, 0.6, 1.0, 1)
end

-------------------------------------------------
-- Variables locales
-------------------------------------------------
local frame
local currentFilter = "all"
local searchText = ""
local selectedItem = nil -- Item actuellement sélectionné

-------------------------------------------------
-- Interface de gestion
-------------------------------------------------
function MainFrame:Show()
    if not Core or not Core.isLoaded then
        print("|cffff0000[SmartMounts]|r Base de données non chargée")
        return
    end
    
    if not frame then
        self:CreateFrame()
    end
    
    frame:Show()
    self:RefreshMountList()
    self:UpdateStats()
end

function MainFrame:Hide()
    if frame then
        frame:Hide()
    end
end

function MainFrame:Toggle()
    if frame and frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

function MainFrame:IsVisible()
    return frame and frame:IsShown()
end

-------------------------------------------------
-- Création de l'interface
-------------------------------------------------
function MainFrame:CreateFrame()
    -- Récupérer ModelViewer après création
    ModelViewer = addonTable.UI.ModelViewer
    
    -- Récupérer les paramètres sauvegardés
    local savedWidth = SmartMountsDB.window.width or 950
    local savedHeight = SmartMountsDB.window.height or 700
    
    -- Création de la frame principale
    frame = CreateFrame("Frame", "SmartMountsMainFrame", UIParent, "BackdropTemplate")
    frame:SetSize(savedWidth, savedHeight)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 6, right = 6, top = 6, bottom = 6 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.95)
    frame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)

    -- Bouton de fermeture
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -5, -5)

    -- Titre
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("SmartMounts")
    title:SetTextColor(1, 0.8, 0)
    
    -- Statistiques
    local statsText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statsText:SetPoint("TOP", title, "BOTTOM", 0, -5)
    frame.statsText = statsText

    -- Créer la section modèle (côté gauche)
    if ModelViewer then
        ModelViewer:CreateModelSection(frame)
    end

    -- Créer les contrôles (côté droit)
    self:CreateControls(frame)
    
    -- Créer la liste des montures (côté droit)
    self:CreateMountList(frame)
    
    -- Sauvegarder la taille quand elle change
    frame:SetScript("OnSizeChanged", function(self, width, height)
        SmartMountsDB.window.width = width
        SmartMountsDB.window.height = height
    end)
end

-------------------------------------------------
-- Création des contrôles
-------------------------------------------------
function MainFrame:CreateControls(parent)
    -- Barre de recherche
    local searchBox = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    searchBox:SetSize(200, 20)
    searchBox:SetPoint("TOPLEFT", 420, -70)
    searchBox:SetAutoFocus(false)
    searchBox:SetText(SmartMountsDB.filters.searchText or "")
    searchBox:SetScript("OnTextChanged", function(self)
        local newText = self:GetText():lower()
        if newText ~= searchText then
            searchText = newText
            SmartMountsDB.filters.searchText = newText
            MainFrame:RefreshMountList()
        end
    end)
    searchBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)
    frame.searchBox = searchBox

    local searchLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    searchLabel:SetPoint("BOTTOMLEFT", searchBox, "TOPLEFT", 0, 5)
    searchLabel:SetText("Recherche:")

    -- Dropdown pour les filtres
    local filterDropdown = CreateFrame("Frame", "SmartMountsFilterDropdown", parent, "UIDropDownMenuTemplate")
    filterDropdown:SetPoint("TOPRIGHT", -20, -65)
    
    local function FilterDropdown_Initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        
        -- Option "Toutes"
        info.text = "Toutes les montures"
        info.value = "all"
        info.func = function()
            MainFrame:SetFilter("all")
        end
        info.checked = (currentFilter == "all")
        UIDropDownMenu_AddButton(info)
        
        -- Option "Collectées"
        info.text = "Collectées seulement"
        info.value = "collected"
        info.func = function()
            MainFrame:SetFilter("collected")
        end
        info.checked = (currentFilter == "collected")
        UIDropDownMenu_AddButton(info)
        
        -- Option "Manquantes"
        info.text = "Manquantes seulement"
        info.value = "missing"
        info.func = function()
            MainFrame:SetFilter("missing")
        end
        info.checked = (currentFilter == "missing")
        UIDropDownMenu_AddButton(info)
        
        -- Séparateur
        info = UIDropDownMenu_CreateInfo()
        info.text = ""
        info.isTitle = true
        info.notCheckable = true
        UIDropDownMenu_AddButton(info)
        
        -- Filtres par catégories
        if Core and Core.isLoaded then
            local categories = Core.GetCategories()
            for _, category in ipairs(categories) do
                info = UIDropDownMenu_CreateInfo()
                info.text = category
                info.value = category
                info.func = function()
                    MainFrame:SetFilter(category)
                end
                info.checked = (currentFilter == category)
                UIDropDownMenu_AddButton(info)
            end
        end
    end
    
    UIDropDownMenu_Initialize(filterDropdown, FilterDropdown_Initialize)
    UIDropDownMenu_SetWidth(filterDropdown, 150)
    
    -- Restaurer le filtre sauvegardé
    currentFilter = SmartMountsDB.filters.currentFilter or "all"
    searchText = SmartMountsDB.filters.searchText or ""
    UIDropDownMenu_SetSelectedValue(filterDropdown, currentFilter)
    
    if currentFilter == "all" then
        UIDropDownMenu_SetText(filterDropdown, "Toutes les montures")
    elseif currentFilter == "collected" then
        UIDropDownMenu_SetText(filterDropdown, "Collectées seulement")
    elseif currentFilter == "missing" then
        UIDropDownMenu_SetText(filterDropdown, "Manquantes seulement")
    else
        UIDropDownMenu_SetText(filterDropdown, currentFilter)
    end
    
    frame.filterDropdown = filterDropdown
end

-------------------------------------------------
-- Création de la liste des montures
-------------------------------------------------
function MainFrame:CreateMountList(parent)
    -- Scroll Frame pour la liste
    local scrollFrame = CreateFrame("ScrollFrame", "SmartMountsScrollFrame", parent, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 420, -110)
    scrollFrame:SetPoint("BOTTOMRIGHT", -40, 20)
    
    local scrollChild = CreateFrame("Frame")
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetWidth(480)
    scrollChild:SetHeight(1)
    
    frame.scrollChild = scrollChild
    frame.scrollFrame = scrollFrame
    scrollChild.mountItems = {}
end

-------------------------------------------------
-- Gestion des filtres
-------------------------------------------------
function MainFrame:SetFilter(filterValue)
    currentFilter = filterValue
    SmartMountsDB.filters.currentFilter = filterValue
    
    UIDropDownMenu_SetSelectedValue(frame.filterDropdown, filterValue)
    
    if filterValue == "all" then
        UIDropDownMenu_SetText(frame.filterDropdown, "Toutes les montures")
    elseif filterValue == "collected" then
        UIDropDownMenu_SetText(frame.filterDropdown, "Collectées seulement")
    elseif filterValue == "missing" then
        UIDropDownMenu_SetText(frame.filterDropdown, "Manquantes seulement")
    else
        UIDropDownMenu_SetText(frame.filterDropdown, filterValue)
    end
    
    self:RefreshMountList()
end

-------------------------------------------------
-- Mise à jour de la liste des montures
-------------------------------------------------
function MainFrame:RefreshMountList()
    if not frame or not frame.scrollChild or not Core or not Core.isLoaded then
        return
    end

    local scrollChild = frame.scrollChild
    
    -- Nettoyer les anciens éléments
    for i = 1, #scrollChild.mountItems do
        scrollChild.mountItems[i]:Hide()
    end

    -- Obtenir les montures filtrées
    local filteredMounts = self:GetFilteredMounts()
    
    -- Trier les montures
    self:SortMounts(filteredMounts)
    
    -- Créer les éléments de la liste
    local yOffset = -5
    for i, mount in ipairs(filteredMounts) do
        local item = scrollChild.mountItems[i]
        if not item then
            item = self:CreateMountItem(scrollChild)
            scrollChild.mountItems[i] = item
        end
        
        self:SetupMountItem(item, mount.name, mount.data)
        item:SetPoint("TOPLEFT", 0, yOffset)
        item:Show()
        yOffset = yOffset - 80
    end
    
    scrollChild:SetHeight(math.abs(yOffset) + 10)
    self:UpdateStats()
end

-------------------------------------------------
-- Filtrage des montures
-------------------------------------------------
function MainFrame:GetFilteredMounts()
    local filteredMounts = {}
    
    if not Core or not Core.mounts then
        return filteredMounts
    end
    
    for mountId, mountData in pairs(Core.mounts) do
        local shouldShow = true
        
        -- Filtre de recherche
        if searchText ~= "" then
            local searchResults = Core.SearchMounts(searchText)
            shouldShow = (searchResults[mountId] ~= nil)
        end
        
        -- Filtre par catégorie/état
        if shouldShow then
            if currentFilter == "collected" then
                shouldShow = Core.HasMount(mountData.spellId)
            elseif currentFilter == "missing" then
                shouldShow = not Core.HasMount(mountData.spellId)
            elseif currentFilter ~= "all" then
                shouldShow = (mountData.category == currentFilter)
            end
        end
        
        if shouldShow then
            table.insert(filteredMounts, {
                id = mountId, 
                name = mountData.name, 
                data = mountData
            })
        end
    end
    
    return filteredMounts
end

-------------------------------------------------
-- Tri des montures
-------------------------------------------------
function MainFrame:SortMounts(mounts)
    local order = Core.CATEGORY_ORDER or {}
    table.sort(mounts, function(a, b)
        local oa = order[a.data.category] or math.huge
        local ob = order[b.data.category] or math.huge
        if oa == ob then
            return a.name < b.name
        else
            return oa < ob
        end
    end)
end

-------------------------------------------------
-- Mise à jour des statistiques
-------------------------------------------------
function MainFrame:UpdateStats()
    if not frame or not frame.statsText or not Core or not Core.isLoaded then
        return
    end
    
    local collected = Core.GetCollectedCount()
    local total = Core.GetTotalCount()
    local usable = Core.GetUsableCount()
    local known = Core.GetKnownCount()
    local percentage = total > 0 and math.floor((collected / total) * 100) or 0
    
    frame.statsText:SetText(string.format(
        "|cffffffff%d|r utilisables |cffffffff%d|r connues |cff00ff00%d|r collectées |cff999999%d|r possibles |cffaaaaaa(%d%%)|r",
        known, usable, collected, total, percentage
    ))
end

-------------------------------------------------
-- Création d'un élément de monture
-------------------------------------------------
function MainFrame:CreateMountItem(parent)
    local item = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    item:SetSize(480, 75)
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
    
    -- Source détaillée
    item.sourceText = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    item.sourceText:SetPoint("TOPLEFT", item.infoText, "BOTTOMLEFT", 0, -5)
    item.sourceText:SetPoint("TOPRIGHT", item.infoText, "BOTTOMRIGHT", 0, -5)
    item.sourceText:SetJustifyH("LEFT")
    
    -- Status
    item.statusText = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    item.statusText:SetPoint("TOPRIGHT", -10, -5)
    
    return item
end

-------------------------------------------------
-- Configuration d'un élément de monture
-------------------------------------------------
function MainFrame:SetupMountItem(item, mountName, mountData)
    -- Icône principale
    local iconTexture = mountData.icon
    if not iconTexture or iconTexture == "" then
        iconTexture = select(3, GetSpellInfo(mountData.spellId))
            or "Interface\\Icons\\INV_Misc_QuestionMark"
    end
    item.icon:SetTexture(iconTexture)

    -- Icône de faction en arrière-plan si nécessaire
    if mountData.isFactionSpecific and mountData.faction then
        if not item.factionIcon then
            item.factionIcon = item:CreateTexture(nil, "BACKGROUND")
            item.factionIcon:SetSize(20, 20)
            item.factionIcon:SetPoint("TOPRIGHT", item.icon, "TOPRIGHT", -2, -2)
            item.factionIcon:SetAlpha(0.7)
        end
        
        if mountData.faction == "Alliance" then
            item.factionIcon:SetTexture("Interface\\PVPFrame\\PVP-Currency-Alliance")
        else
            item.factionIcon:SetTexture("Interface\\PVPFrame\\PVP-Currency-Horde")
        end
        item.factionIcon:Show()
    else
        if item.factionIcon then
            item.factionIcon:Hide()
        end
    end

    -- Nom avec couleur selon le statut (vert plus sobre)
    local isCollected = Core.HasMount(mountData.spellId)
    local nameColor = isCollected and "|cff4CAF50" or "|cffFFFFFF"  -- Vert plus sobre
    item.nameText:SetText(nameColor .. mountName)
    
    -- Informations de base (sans afficher la faction en texte)
    local infoStr = string.format("|cffFFD700%s|r", mountData.category or "Unknown")
    if mountData.sourceTypeLocalized then
        infoStr = infoStr .. string.format(" - |cff87CEEB%s|r", mountData.sourceTypeLocalized)
    end
    item.infoText:SetText(infoStr)
    
    -- Source détaillée
    local sourceStr = ""
    if mountData.source then
        sourceStr = string.format("|cffFFA500%s|r", mountData.source)
    end
    if mountData.boss then
        sourceStr = sourceStr .. string.format(" |cff888888(%s)|r", mountData.boss)
    end
    if mountData.dropChance then
        sourceStr = sourceStr .. string.format(" - |cffFF6347%s|r", mountData.dropChance)
    end
    if mountData.difficulty then
        sourceStr = sourceStr .. string.format(" - |cffDDA0DD%s|r", mountData.difficulty)
    end
    item.sourceText:SetText(sourceStr)
    
    -- Status et apparence
    if isCollected then
        item.statusText:SetText("|cff4CAF50COLLECTÉ")  -- Vert plus sobre
        item:SetBackdropColor(0.0, 0.15, 0.0, 0.8)     -- Vert de fond plus sobre
        item:SetBackdropBorderColor(0.0, 0.5, 0.0, 1)   -- Bordure verte plus sobre
    else
        item.statusText:SetText("|cffFF5722MANQUANT")   -- Orange au lieu de rouge pur
        item:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
        item:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
    end
    
    -- Événements de survol et clic
    item:EnableMouse(true)
    item:SetScript("OnEnter", function(self)
        -- Tooltip seulement
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink("spell:" .. mountData.spellId)
        
        -- Ajouter des informations supplémentaires
        if mountData.source then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("|cffFFD700Source:|r " .. mountData.source, 1, 1, 1, true)
        end
        if mountData.boss then
            GameTooltip:AddLine("|cffFFD700Boss:|r " .. mountData.boss, 1, 1, 1, true)
        end
        if mountData.dropChance then
            GameTooltip:AddLine("|cffFFD700Taux de drop:|r " .. mountData.dropChance, 1, 1, 1, true)
        end
        if mountData.difficulty then
            GameTooltip:AddLine("|cffFFD700Difficulté:|r " .. mountData.difficulty, 1, 1, 1, true)
        end
        
        GameTooltip:Show()
    end)
    
    item:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    
    -- Clic pour sélectionner et afficher le modèle
    item:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then
            -- Désélectionner l'ancien item
            MainFrame:ClearSelection()
            
            -- Sélectionner le nouvel item
            MainFrame:SelectItem(self, mountName, mountData)
            
            -- Afficher le modèle 3D
            if ModelViewer then
                ModelViewer:UpdateModel(mountName, mountData)
            end
        end
    end)
    
    -- Stocker les données pour la sélection
    item.mountName = mountName
    item.mountData = mountData
end

return MainFrame