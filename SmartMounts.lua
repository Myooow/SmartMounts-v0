local addonName, addonTable = ...

-- Initialisation du système SmartMounts
SM = SM or {}
SM.DB = SM.DB or {}

-- Libraries
local LDB = LibStub:GetLibrary("LibDataBroker-1.1", true)
local DBIcon = LibStub("LibDBIcon-1.0", true)

-- Modules
local Core
local MainFrame

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
            if MainFrame then
                MainFrame:Toggle()
            end
        end,
        OnEnter = function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
            GameTooltip:AddLine("SmartMounts")
            GameTooltip:AddLine("|cffFFFFFFClique gauche:|r Ouvrir la fenêtre", 1, 1, 1)
            
            if Core and Core.isLoaded then
                local collected = Core.GetCollectedCount()
                local total = Core.GetTotalCount()
                local percentage = total > 0 and math.floor((collected / total) * 100) or 0
                GameTooltip:AddLine(string.format("|cff00FF00%d|r / |cffFFFF00%d|r montures collectées (%d%%)", 
                    collected, total, percentage), 1, 1, 1)
            else
                GameTooltip:AddLine("|cffff8800Base de données en cours de chargement...|r", 1, 1, 1)
            end
            
            GameTooltip:Show()
        end,
        OnLeave = function()
            GameTooltip:Hide()
        end,
    })
end

-------------------------------------------------
-- Fonctions utilitaires
-------------------------------------------------
local function UpdateMinimapTooltip()
    if dataobj and Core and Core.isLoaded then
        local collected = Core.GetCollectedCount()
        local total = Core.GetTotalCount()
        local percentage = total > 0 and math.floor((collected / total) * 100) or 0
        dataobj.text = string.format("%d/%d (%d%%)", collected, total, percentage)
    end
end

-------------------------------------------------
-- Event handling
-------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("LEARNED_SPELL_IN_TAB")
eventFrame:RegisterEvent("NEW_MOUNT_ADDED")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local loadedAddonName = ...
        if loadedAddonName == addonName then
            -- Initialiser les paramètres sauvegardés
            SmartMountsDB = SmartMountsDB or { 
                minimap = { hide = false },
                filters = {
                    currentFilter = "all",
                    searchText = ""
                },
                window = {
                    width = 950,
                    height = 700
                }
            }
            -- ① AJOUTEZ CE BLOC JUSTE EN DESSOUS
            ---------------------------------------------
            -- Garantie qu’aucune sous-table n’est absente
            ---------------------------------------------
            SmartMountsDB.minimap = SmartMountsDB.minimap or { hide = false }
            SmartMountsDB.filters = SmartMountsDB.filters or { currentFilter = "all", searchText = "" }
            SmartMountsDB.window  = SmartMountsDB.window  or { width = 950, height = 700 }
            -- Récupérer les modules
            Core = addonTable.Core
            MainFrame = addonTable.UI.MainFrame
        end
    elseif event == "PLAYER_LOGIN" then
        -- Enregistrer l'icône minimap
        if DBIcon and dataobj then
            DBIcon:Register("SmartMounts", dataobj, SmartMountsDB.minimap)
        end
        
        -- Attendre que le Core soit chargé
        C_Timer.After(1, function()
            if Core and Core.isLoaded then
                local collected = Core.GetCollectedCount()
                local total = Core.GetTotalCount()
                local percentage = total > 0 and math.floor((collected / total) * 100) or 0
                print(string.format("|cff00ff00[SmartMounts]|r Interface chargée - %d/%d montures (%.1f%%)", 
                    collected, total, percentage))
                UpdateMinimapTooltip()
            else
                print("|cffff8800[SmartMounts]|r Interface chargée - Base de données en cours de chargement...")
                -- Réessayer dans 3 secondes
                C_Timer.After(3, function()
                    if Core and Core.isLoaded then
                        UpdateMinimapTooltip()
                        print("|cff00ff00[SmartMounts]|r Base de données maintenant disponible")
                    end
                end)
            end
        end)
        
    elseif event == "LEARNED_SPELL_IN_TAB" or event == "NEW_MOUNT_ADDED" then
        -- Mettre à jour l'interface si une nouvelle monture est apprise
        if MainFrame and MainFrame:IsVisible() then
            MainFrame:RefreshMountList()
        end
        UpdateMinimapTooltip()
    end
end)

-------------------------------------------------
-- Commandes slash
-------------------------------------------------
SLASH_SMARTMOUNTS1 = "/smartmounts"
SLASH_SMARTMOUNTS2 = "/sm"
SlashCmdList["SMARTMOUNTS"] = function(msg)
    if not Core or not Core.isLoaded then
        print("|cffff0000[SmartMounts]|r Base de données non chargée, veuillez patienter...")
        return
    end
    
    if MainFrame then
        MainFrame:Show()
    end
end

SLASH_SMOUNTDEBUG1 = "/smdebug"
SlashCmdList["SMOUNTDEBUG"] = function()
    if Core and Core.DebugPrint then
        Core.DebugPrint()
    else
        print("|cffff0000[SmartMounts]|r Module Core non disponible")
    end
end

-- Fonction globale pour l'accès externe
function SmartMounts_ShowMainFrame()
    if MainFrame then
        MainFrame:Show()
    end
end