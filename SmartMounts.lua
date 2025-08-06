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
local Constants

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
            GameTooltip:AddLine(Constants and Constants.ADDON.NAME or "SmartMounts")
            GameTooltip:AddLine("|cffFFFFFFClique gauche:|r Ouvrir la fenêtre", 1, 1, 1)
   
            GameTooltip:Show()
        end,
        OnLeave = function()
            GameTooltip:Hide()
        end,
    })
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
            -- Initialiser les paramètres sauvegardés avec les constantes
            local defaultWindowSize = {width = 950, height = 700} -- Fallback si Constants pas encore chargé
            
            SmartMountsDB = SmartMountsDB or { 
                minimap = { hide = false },
                filters = {
                    currentFilter = "all",
                    searchText = ""
                },
                window = defaultWindowSize
            }
            
            -- Garantie qu'aucune sous-table n'est absente
            SmartMountsDB.minimap = SmartMountsDB.minimap or { hide = false }
            SmartMountsDB.filters = SmartMountsDB.filters or { currentFilter = "all", searchText = "" }
            SmartMountsDB.window  = SmartMountsDB.window  or defaultWindowSize
            
            -- Récupérer les modules
            Core = addonTable.Core
            MainFrame = addonTable.UI.MainFrame
            Constants = addonTable.Utils and addonTable.Utils.Constants
        end
    elseif event == "PLAYER_LOGIN" then
        -- Enregistrer l'icône minimap
        if DBIcon and dataobj then
            DBIcon:Register("SmartMounts", dataobj, SmartMountsDB.minimap)
        end
    end
end)

-------------------------------------------------
-- Commandes slash
-------------------------------------------------
SLASH_SMARTMOUNTS1 = "/smartmounts"
SLASH_SMARTMOUNTS2 = "/sm"
SlashCmdList["SMARTMOUNTS"] = function(msg)
    if not Core or not Core.isLoaded then
        local errorMsg = Constants and Constants:GetErrorMessage("DATABASE_NOT_LOADED") or 
            "|cffff0000[SmartMounts]|r Base de données non chargée, veuillez patienter..."
        print(errorMsg)
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
        local errorMsg = Constants and Constants:FormatMessage("Module Core non disponible", "ERROR") or 
            "|cffff0000[SmartMounts]|r Module Core non disponible"
        print(errorMsg)
    end
end

-- Commande pour nettoyer les caches (debug)
SLASH_SMOUNTCACHE1 = "/smcache"
SlashCmdList["SMOUNTCACHE"] = function()
    if Core then
        Core._statsCache = nil
        Core._searchCache = nil
    end
    
    if MainFrame and MainFrame:IsVisible() then
        -- Invalider le cache de la liste
        if MainFrame.scrollChild then
            MainFrame.scrollChild._mountsCache = nil
            MainFrame.scrollChild._lastFilter = nil
            MainFrame.scrollChild._lastSearch = nil
        end
        MainFrame:RefreshMountList()
    end
    
    print("|cff00ff00[SmartMounts]|r Caches nettoyés")
end

-- Fonction globale pour l'accès externe
function SmartMounts_ShowMainFrame()
    if MainFrame then
        MainFrame:Show()
    end
end