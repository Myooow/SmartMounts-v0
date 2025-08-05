local addonName, addonTable = ...

-- Initialisation du système SmartMounts
SM = SM or {}
SM.DB = SM.DB or {}

-- Créer le module Core
local Core = {}
addonTable.Core = Core

-- Table principale des montures
Core.mounts = {}
Core.isLoaded = false

-- Configuration des expansions et leurs ordres
Core.EXPANSIONS = {
    {key = "Achievements", name = "Achievements", order = 1},
    {key = "Racial", name = "Racial", order = 2},
    {key = "Professions", name = "Professions", order = 3},
    {key = "Other", name = "Other", order = 4},
    {key = "Classic", name = "Classic", order = 5},
    {key = "The_Burning_Crusade", name = "The Burning Crusade", order = 6},
    {key = "Wrath_of_the_Lich_King", name = "Wrath of the Lich King", order = 7},
    {key = "Cataclysm", name = "Cataclysm", order = 8},
    {key = "Mists_of_Pandaria", name = "Mists of Pandaria", order = 9}
}

-- Ordre des catégories pour le tri
Core.CATEGORY_ORDER = {
    ["Achievements"] = 1,
    ["Racial"] = 2,
    ["Professions"] = 3,
    ["Other"] = 4,
    ["Classic"] = 5,
    ["The Burning Crusade"] = 6,
    ["Wrath of the Lich King"] = 7,
    ["Cataclysm"] = 8,
    ["Mists of Pandaria"] = 9,
    ["Unknown"] = 99
}

-- Types de sources avec traductions françaises
Core.SOURCE_TYPES = {
    ["ACHIEVEMENT"] = "Haut fait",
    ["DROP"] = "Butin",
    ["VENDOR"] = "Marchand",
    ["QUEST"] = "Quête",
    ["REPUTATION"] = "Réputation",
    ["PROFESSION"] = "Métier",
    ["PVP"] = "JcJ",
    ["WORLD_EVENT"] = "Événement mondial",
    ["PROMOTION"] = "Promotion",
    ["UNKNOWN"] = "Inconnu"
}

-------------------------------------------------
-- Fonctions de chargement
-------------------------------------------------

-- Charger toutes les bases de données
local function LoadAllDatabases()
    Core.mounts = {}
    
    -- Fonction helper pour ajouter des montures depuis une DB
    local function AddMountsFromDB(dbTable, expansionName, categoryName)
        if not dbTable then return 0 end
        
        local count = 0
        for mountId, mountData in pairs(dbTable) do
            -- Créer une entrée enrichie
            local enrichedData = {}
            
            -- Copier toutes les données originales
            for key, value in pairs(mountData) do
                enrichedData[key] = value
            end
            
            -- Ajouter les métadonnées SmartMounts
            enrichedData.expansion = expansionName
            enrichedData.category = categoryName
            enrichedData.sourceTypeLocalized = Core.SOURCE_TYPES[mountData.sourceType] or Core.SOURCE_TYPES["UNKNOWN"]
            enrichedData.factionText = ""
            
            if enrichedData.isFactionSpecific then
                enrichedData.factionText = enrichedData.faction == "Alliance" and "Alliance" or "Horde"
            end
            
            -- Récupérer l'icône du sort si elle n'existe pas
            if not enrichedData.icon and enrichedData.spellId then
                local spellIcon = select(3, GetSpellInfo(enrichedData.spellId))
                enrichedData.icon = spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark"
            end
            
            Core.mounts[mountId] = enrichedData
            count = count + 1
        end
        
        return count
    end
    
    -- Charger chaque base de données
    local totalLoaded = 0
    local loadResults = {}
    
    for _, expansion in ipairs(Core.EXPANSIONS) do
        local dbTable = SM.DB[expansion.key]
        local categoryName = expansion.name
        
        -- Garder les noms originaux pour toutes les catégories
        local count = AddMountsFromDB(dbTable, expansion.name, categoryName)
        totalLoaded = totalLoaded + count
        
        if count > 0 then
            table.insert(loadResults, string.format("%s: %d montures", expansion.name, count))
        end
    end
    
    Core.isLoaded = true
    
    -- Afficher le résultat du chargement
    if totalLoaded > 0 then
        print(string.format("|cff00ff00[SmartMounts]|r Base de données chargée: %d montures", totalLoaded))
        print("|cff888888Détail: " .. table.concat(loadResults, ", ") .. "|r")
    else
        print("|cffff0000[SmartMounts]|r Aucune monture chargée - vérifiez vos fichiers de base de données")
    end
    
    return totalLoaded
end

-------------------------------------------------
-- API publique
-------------------------------------------------

-- Vérifier si le joueur possède une monture
function Core.HasMount(spellId)
    if not spellId then return false end
    
 -- ----------------------------------------------------------------
    -- -- 1) Retail / Wrath / Cata+ : API directe par spell-ID
    -- ----------------------------------------------------------------
    if C_MountJournal and C_MountJournal.GetMountInfoBySpellID then
        local _, _, _, _, _, _, _, _, _, _, isCollected =
              C_MountJournal.GetMountInfoBySpellID(spellId)
        if isCollected ~= nil then              -- l’API existe et a répondu
            return isCollected                  -- true / false
        end
        -- Si isCollected vaut nil, on continue (spell inconnu ici)
    end

    ----------------------------------------------------------------
    -- 2) Fallback : boucle sur tous les mountIDs
    --    (fonctionne aussi sur Classic Era / TBC Classic)
    ----------------------------------------------------------------
    if C_MountJournal and C_MountJournal.GetMountIDs then
        for _, mountID in ipairs(C_MountJournal.GetMountIDs()) do
            local _, sID, _, _, _, _, _, _, _, _, isCollected =
                  C_MountJournal.GetMountInfoByID(mountID)
            if sID == spellId then
                return isCollected              -- true / false
            end
        end
    end

    ----------------------------------------------------------------
    -- 3) Client très ancien : on retombe sur IsPlayerSpell
    ----------------------------------------------------------------
    return IsPlayerSpell and IsPlayerSpell(spellId)
end

-- Obtenir le nombre de montures collectées
function Core.GetCollectedCount()
    local count = 0
    for _, mountData in pairs(Core.mounts) do
        if Core.HasMount(mountData.spellId) then
            count = count + 1
        end
    end
    return count
end

-- Obtenir le nombre total de montures dans la DB
function Core.GetTotalCount()
    local count = 0
    for _ in pairs(Core.mounts) do
        count = count + 1
    end
    return count
end

-- Obtenir le nombre de montures utilisables (dans le journal)
Core.GetUsableCount = function()
    if not (C_MountJournal and C_MountJournal.GetMountIDs) then return 0 end
    local n = 0
    for _, id in ipairs(C_MountJournal.GetMountIDs()) do
        -- name, spellID, icon, active, usable, sourceType,
        -- isFavorite, isFactionSpecific, faction, hideOnChar, isCollected
        local _, _, _, _, _, _, _, _, _, hideOnChar, isCollected =
              C_MountJournal.GetMountInfoByID(id)
        if isCollected and not hideOnChar then   -- **doit être visible + possédée**
            n = n + 1
        end
    end
    return n
end

-- Obtenir le nombre de montures connues (sorts connus)
Core.GetKnownCount = function()
    local n = 0
    for _, id in ipairs(C_MountJournal.GetMountIDs()) do
        local _, spellID, _, _, _, _, _, _, _, _, isCollected =
              C_MountJournal.GetMountInfoByID(id)
        if isCollected and IsPlayerSpell(spellID) then
            n = n + 1
        end
    end
    return n
end

-- Obtenir toutes les catégories disponibles
function Core.GetCategories()
    local categories = {}
    local seen = {}
    
    for _, mountData in pairs(Core.mounts) do
        local category = mountData.category or "Unknown"
        if not seen[category] then
            seen[category] = true
            table.insert(categories, category)
        end
    end
    
    -- Trier selon l'ordre défini
    table.sort(categories, function(a, b)
        local orderA = Core.CATEGORY_ORDER[a] or 999
        local orderB = Core.CATEGORY_ORDER[b] or 999
        if orderA == orderB then
            return a < b
        end
        return orderA < orderB
    end)
    
    return categories
end

-- Obtenir les montures par filtre
function Core.GetMountsByFilter(filterType, filterValue)
    local mounts = {}
    for mountId, mountData in pairs(Core.mounts) do
        local match = false
        
        if filterType == "sourceType" then
            match = (mountData.sourceType == filterValue)
        elseif filterType == "expansion" then
            match = (mountData.expansion == filterValue)
        elseif filterType == "category" then
            match = (mountData.category == filterValue)
        elseif filterType == "collected" then
            match = Core.HasMount(mountData.spellId)
        elseif filterType == "missing" then
            match = not Core.HasMount(mountData.spellId)
        elseif filterType == "faction" then
            if filterValue == "neutral" then
                match = not mountData.isFactionSpecific
            else
                match = mountData.isFactionSpecific and mountData.faction == filterValue
            end
        end
        
        if match then
            mounts[mountId] = mountData
        end
    end
    return mounts
end

-- Rechercher des montures
function Core.SearchMounts(query)
    if not query or query == "" then
        return Core.mounts
    end
    
    query = query:lower()
    local results = {}
    
    for mountId, mountData in pairs(Core.mounts) do
        local searchable = {
            (mountData.name or ""):lower(),
            (mountData.source or ""):lower(),
            (mountData.category or ""):lower(),
            (mountData.expansion or ""):lower(),
            (mountData.sourceTypeLocalized or ""):lower(),
            (mountData.factionText or ""):lower()
        }
        
        local found = false
        for _, text in ipairs(searchable) do
            if text:find(query, 1, true) then -- true = plain text search
                found = true
                break
            end
        end
        
        if found then
            results[mountId] = mountData
        end
    end
    
    return results
end

-- Obtenir les statistiques par expansion
function Core.GetExpansionStats()
    local stats = {}
    
    for _, expansion in ipairs(Core.EXPANSIONS) do
        stats[expansion.key] = {
            name = expansion.name,
            total = 0,
            collected = 0,
            percentage = 0
        }
    end
    
    for _, mountData in pairs(Core.mounts) do
        local expKey = nil
        for _, expansion in ipairs(Core.EXPANSIONS) do
            if mountData.expansion == expansion.name then
                expKey = expansion.key
                break
            end
        end
        
        if expKey and stats[expKey] then
            stats[expKey].total = stats[expKey].total + 1
            if Core.HasMount(mountData.spellId) then
                stats[expKey].collected = stats[expKey].collected + 1
            end
        end
    end
    
    -- Calculer les pourcentages
    for key, stat in pairs(stats) do
        if stat.total > 0 then
            stat.percentage = math.floor((stat.collected / stat.total) * 100)
        end
    end
    
    return stats
end

-------------------------------------------------
-- Fonctions de debug
-------------------------------------------------

function Core.DebugPrint()
    if not Core.isLoaded then
        print("|cffff0000[SmartMounts Debug]|r Base de données non chargée")
        return
    end
    
    print("|cff00ff00=== DEBUG SmartMounts Core ===|r")
    print(string.format("Total montures: %d", Core.GetTotalCount()))
    print(string.format("Collectées: %d", Core.GetCollectedCount()))
    print(string.format("Dans le journal: %d", Core.GetUsableCount()))
    print(string.format("Sorts connus: %d", Core.GetKnownCount()))
    
    -- Statistiques par expansion
    print("\n|cff00ff00=== Statistiques par expansion ===|r")
    local expansionStats = Core.GetExpansionStats()
    for _, expansion in ipairs(Core.EXPANSIONS) do
        local stat = expansionStats[expansion.key]
        if stat and stat.total > 0 then
            print(string.format("%s: %d/%d (%d%%)", 
                stat.name, stat.collected, stat.total, stat.percentage))
        end
    end
    
    -- Catégories disponibles
    print("\n|cff00ff00=== Catégories ===|r")
    local categories = Core.GetCategories()
    for i, category in ipairs(categories) do
        local count = 0
        for _, mountData in pairs(Core.mounts) do
            if mountData.category == category then
                count = count + 1
            end
        end
        print(string.format("%d. %s (%d montures)", i, category, count))
    end
    
    -- Exemples de montures
    print("\n|cff00ff00=== Exemples de montures ===|r")
    local count = 0
    for mountId, mountData in pairs(Core.mounts) do
        if count >= 5 then break end
        local collected = Core.HasMount(mountData.spellId) and "|cff00ff00OUI|r" or "|cffff0000NON|r"
        print(string.format("- %s |cff888888(ID:%d, Sort:%d)|r - %s - Collecté: %s", 
            mountData.name, mountId, mountData.spellId, mountData.category, collected))
        count = count + 1
    end
end

-- Alias pour la compatibilité
Core.testdebug = Core.DebugPrint

-------------------------------------------------
-- Initialisation
-------------------------------------------------

local function Initialize()
    -- Vérifier que les APIs sont disponibles
    if not C_MountJournal or not C_MountJournal.GetNumMounts then
        -- Réessayer dans 2 secondes
        C_Timer.After(2, Initialize)
        return
    end
    
    -- Charger les bases de données
    local loaded = LoadAllDatabases()
    
    if loaded == 0 then
        -- Aucune monture chargée, réessayer dans 3 secondes
        C_Timer.After(3, function()
            local retryLoaded = LoadAllDatabases()
            if retryLoaded == 0 then
                print("|cffff8800[SmartMounts]|r Attention: Aucune base de données trouvée")
                print("|cff888888Catégories attendues: Achievements, Racial, Professions, Other, Classic, TBC, WotLK, Cataclysm, MoP|r")
            end
        end)
    end
end

-- Event handler pour l'initialisation
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")

eventFrame:SetScript("OnEvent", function(self, event, loadedAddonName)
    if event == "ADDON_LOADED" and loadedAddonName == addonName then
        -- L'addon est chargé
        Initialize()
    elseif event == "PLAYER_LOGIN" then
        -- Le joueur est connecté, s'assurer que tout est bien initialisé
        if not Core.isLoaded then
            Initialize()
        end
    end
end)

return Core