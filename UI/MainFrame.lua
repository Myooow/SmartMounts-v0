local addonName, addonTable = ...

-- Créer le module UI si il n'existe pas
addonTable.UI = addonTable.UI or {}

-- Références aux modules
local Core = addonTable.Core
local Constants = addonTable.Utils and addonTable.Utils.Constants
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
local searchTimer -- Timer pour la recherche différée

-------------------------------------------------
-- Interface de gestion
-------------------------------------------------
function MainFrame:Show()
    if not Core or not Core.isLoaded then
        local errorMsg = Constants and Constants:GetErrorMessage("DATABASE_NOT_LOADED") or "Base de données non chargée"
        print(Constants and Constants.ADDON.PREFIX or "|cffff8800[SmartMounts]|r", errorMsg)
        return
    end
    
    if not frame then
        self:CreateFrame()
    end
    
    frame:Show()
    self:RefreshMountList()
    self:UpdateStats()
    
    -- Enregistrer pour la fermeture avec Échap
    table.insert(UISpecialFrames, frame:GetName())
end

function MainFrame:Hide()
    if frame then
        frame:Hide()
        -- Retirer de UISpecialFrames pour éviter les doublons
        for i = #UISpecialFrames, 1, -1 do
            if UISpecialFrames[i] == frame:GetName() then
                table.remove(UISpecialFrames, i)
                break
            end
        end
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
    
    -- Récupérer les paramètres sauvegardés ou utiliser les constantes
    local defaultSize = Constants and Constants.UI.WINDOW_SIZES.MAIN or {width = 950, height = 700}
    local savedWidth = SmartMountsDB.window.width or defaultSize.width
    local savedHeight = SmartMountsDB.window.height or defaultSize.height
    
    -- Création de la frame principale avec nom unique pour UISpecialFrames
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
    title:SetText(Constants and Constants.ADDON.NAME or "SmartMounts")
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
    -- Barre de recherche avec recherche différée
    local searchBox = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    searchBox:SetSize(200, 20)
    searchBox:SetPoint("TOPLEFT", 420, -70)
    searchBox:SetAutoFocus(false)
    searchBox:SetText(SmartMountsDB.filters.searchText or "")
    
    -- Recherche différée pour éviter le lag
    local function DelayedSearch()
        if searchTimer then
            searchTimer:Cancel()
        end
        searchTimer = C_Timer.NewTimer(0.3, function()
            MainFrame:RefreshMountList()
            searchTimer = nil
        end)
    end
    
    searchBox:SetScript("OnTextChanged", function(self)
        local newText = self:GetText():lower()
        if newText ~= searchText then
            searchText = newText
            SmartMountsDB.filters.searchText = newText
            DelayedSearch() -- Recherche différée au lieu d'immédiate
        end
    end)
    searchBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
        -- Forcer la recherche immédiate quand on appuie sur Entrée
        if searchTimer then
            searchTimer:Cancel()
            searchTimer = nil
        end
        MainFrame:RefreshMountList()
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
        
        -- Filtres par catégories (cache pour performance)
        if Core and Core.isLoaded then
            if not filterDropdown._categoriesCache then
                filterDropdown._categoriesCache = Core.GetCategories()
            end
            for _, category in ipairs(filterDropdown._categoriesCache) do
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
    
    -- Invalider le cache des catégories pour forcer un refresh
    if frame.filterDropdown then
        frame.filterDropdown._categoriesCache = nil
    end
    
    self:RefreshMountList()
end

-------------------------------------------------
-- Mise à jour de la liste des montures - OPTIMISÉE
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

    -- Cache des résultats pour éviter les recalculs
    local filteredMounts
    if not scrollChild._mountsCache or scrollChild._lastFilter ~= currentFilter or scrollChild._lastSearch ~= searchText then
        filteredMounts = self:GetFilteredMounts()
        self:SortMounts(filteredMounts)
        
        -- Mise à jour du cache
        scrollChild._mountsCache = filteredMounts
        scrollChild._lastFilter = currentFilter
        scrollChild._lastSearch = searchText
    else
        filteredMounts = scrollChild._mountsCache
    end
    
    -- Créer les éléments de la liste (maximum 50 à la fois pour éviter le freeze)
    local yOffset = -5
    local maxItems = math.min(#filteredMounts, 50)
    
    for i = 1, maxItems do
        local mount = filteredMounts[i]
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
    
    -- Si plus de 50 montures, utiliser une pagination ou lazy loading
    if #filteredMounts > 50 then
        -- Ajouter un texte indiquant qu'il y a plus de résultats
        local moreText = scrollChild.moreText
        if not moreText then
            moreText = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            moreText:SetPoint("TOPLEFT", 0, yOffset)
            moreText:SetTextColor(0.7, 0.7, 0.7)
            scrollChild.moreText = moreText
        end
        moreText:SetText(string.format("... et %d autres montures (affinez votre recherche)", #filteredMounts - 50))
        moreText:Show()
        yOffset = yOffset - 30
    else
        if scrollChild.moreText then
            scrollChild.moreText:Hide()
        end
    end
    
    scrollChild:SetHeight(math.abs(yOffset) + 10)
    self:UpdateStats()
end

-------------------------------------------------
-- Filtrage des montures - OPTIMISÉ avec cache
-------------------------------------------------
function MainFrame:GetFilteredMounts()
    local filteredMounts = {}
    
    if not Core or not Core.mounts then
        return filteredMounts
    end
    
    -- Cache des résultats de recherche pour éviter les recalculs
    local searchResults = nil
    if searchText ~= "" then
        if not Core._searchCache or Core._searchCache.query ~= searchText then
            searchResults = Core.SearchMounts(searchText)
            Core._searchCache = {query = searchText, results = searchResults}
        else
            searchResults = Core._searchCache.results
        end
    end
    
    for mountId, mountData in pairs(Core.mounts) do
        local shouldShow = true
        
        -- Filtre de recherche
        if searchText ~= "" then
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
-- Mise à jour des statistiques - OPTIMISÉE
-------------------------------------------------
function MainFrame:UpdateStats()
    if not frame or not frame.statsText or not Core or not Core.isLoaded then
        return
    end
    
    -- Cache des statistiques pour éviter les recalculs fréquents
    if not Core._statsCache or (GetTime() - (Core._lastStatsUpdate or 0)) > 2 then
        local collected = Core.GetCollectedCount()
        local total = Core.GetTotalCount()
        local usable = Core.GetUsableCount()
        local known = Core.GetKnownCount()
        local percentage = total > 0 and math.floor((collected / total) * 100) or 0
        
        Core._statsCache = {
            collected = collected,
            total = total,
            usable = usable,
            known = known,
            percentage = percentage
        }
        Core._lastStatsUpdate = GetTime()
    end
    
    local stats = Core._statsCache
    frame.statsText:SetText(string.format(
        "|cffffffff%d|r utilisables |cffffffff%d|r connues |cff00ff00%d|r collectées |cff999999%d|r possibles |cffaaaaaa(%d%%)|r",
        stats.known, stats.usable, stats.collected, stats.total, stats.percentage
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
    -- Icône principale (cache pour éviter les GetSpellInfo répétés)
    local iconTexture = mountData.icon
    if not iconTexture or iconTexture == "" then
        if not mountData._cachedIcon then
            mountData._cachedIcon = select(3, GetSpellInfo(mountData.spellId)) or "Interface\\Icons\\INV_Misc_QuestionMark"
        end
        iconTexture = mountData._cachedIcon
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
        
        -- Cache de la texture de faction
        if not mountData._cachedFactionTexture then
            local factionTexture = Constants and Constants:GetFactionTexture(mountData.faction)
            if factionTexture then
                mountData._cachedFactionTexture = factionTexture
            else
                -- Fallback vers les anciennes textures
                mountData._cachedFactionTexture = mountData.faction == "Alliance" and 
                    "Interface\\PVPFrame\\PVP-Currency-Alliance" or 
                    "Interface\\PVPFrame\\PVP-Currency-Horde"
            end
        end
        item.factionIcon:SetTexture(mountData._cachedFactionTexture)
        item.factionIcon:Show()
    else
        if item.factionIcon then
            item.factionIcon:Hide()
        end
    end

    -- Nom avec couleur selon le statut
    local isCollected = Core.HasMount(mountData.spellId)
    local nameColor = Constants and Constants:GetCollectionStatusColor(isCollected) or (isCollected and "|cff4CAF50" or "|cffFFFFFF")
    item.nameText:SetText(nameColor .. mountName)
    
    -- Cache des strings formatées pour éviter les string.format répétés
    if not mountData._cachedInfoStr then
        local primaryColor = Constants and Constants.COLORS.PRIMARY or "|cffFFD700"
        local infoColor = Constants and Constants.COLORS.INFO or "|cff87CEEB"
        
        mountData._cachedInfoStr = string.format("%s%s|r", primaryColor, mountData.category or "Unknown")
        if mountData.sourceTypeLocalized then
            mountData._cachedInfoStr = mountData._cachedInfoStr .. string.format(" - %s%s|r", infoColor, mountData.sourceTypeLocalized)
        end
    end
    item.infoText:SetText(mountData._cachedInfoStr)
    
    -- Source détaillée (cache aussi)
    if not mountData._cachedSourceStr then
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
        mountData._cachedSourceStr = sourceStr
    end
    item.sourceText:SetText(mountData._cachedSourceStr)
    
    -- Status et apparence
    local collectedText = Constants and Constants.MESSAGES.LABELS.COLLECTED or "COLLECTÉ"
    local missingText = Constants and Constants.MESSAGES.LABELS.MISSING or "MANQUANT"
    local collectedColor = Constants and Constants.COLORS.COLLECTED or "|cff4CAF50"
    local warningColor = Constants and Constants.COLORS.WARNING or "|cffFF5722"
    
    if isCollected then
        item.statusText:SetText(collectedColor .. collectedText)
        item:SetBackdropColor(0.0, 0.15, 0.0, 0.8)
        item:SetBackdropBorderColor(0.0, 0.5, 0.0, 1)
    else
        item.statusText:SetText(warningColor .. missingText)
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
        local details = Constants and Constants.MESSAGES.DETAILS or {}
        if mountData.source then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine((details.SOURCE or "|cffFFD700Source:|r") .. " " .. mountData.source, 1, 1, 1, true)
        end
        if mountData.boss then
            GameTooltip:AddLine((details.BOSS or "|cffFFD700Boss:|r") .. " " .. mountData.boss, 1, 1, 1, true)
        end
        if mountData.dropChance then
            GameTooltip:AddLine((details.DROP_RATE or "|cffFFD700Taux de drop:|r") .. " " .. mountData.dropChance, 1, 1, 1, true)
        end
        if mountData.difficulty then
            GameTooltip:AddLine((details.DIFFICULTY or "|cffFFD700Difficulté:|r") .. " " .. mountData.difficulty, 1, 1, 1, true)
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