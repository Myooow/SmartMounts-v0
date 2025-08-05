local addonName, addonTable = ...

-- Créer le module Utils si il n'existe pas
addonTable.Utils = addonTable.Utils or {}

-- Module des constantes générales de l'addon
local Constants = {}
addonTable.Utils.Constants = Constants

-------------------------------------------------
-- Informations générales de l'addon
-------------------------------------------------

Constants.ADDON = {
    NAME = "SmartMounts",
    PREFIX = "|cffff8800[SmartMounts]|r",
    VERSION = "1.0.0"
}

-------------------------------------------------
-- Constantes des montures
-------------------------------------------------

-- Textures pour les icônes de faction
Constants.MOUNT = {
    FACTION_TEXTURES = {
        [0] = "Interface\\MountJournalIcons-Horde",
        [1] = "Interface\\MountJournalIcons-Alliance"
    },
    
    -- Index des factions
    FACTION_INDEX = {
        HORDE = 0,
        ALLIANCE = 1
    },
    
    -- Noms des factions
    FACTION_NAMES = {
        [0] = "Horde",
        [1] = "Alliance"
    }
}

-------------------------------------------------
-- Couleurs de l'interface
-------------------------------------------------

Constants.COLORS = {
    -- Couleurs principales
    PRIMARY = "|cffFFD700",        -- Or (titres, labels)
    SECONDARY = "|cff4CAF50",      -- Vert sobre (collecté)
    
    -- Statuts
    COLLECTED = "|cff4CAF50",      -- Vert sobre
    MISSING = "|cffFFFFFF",        -- Blanc
    WARNING = "|cffFF5722",        -- Orange
    ERROR = "|cffFF0000",          -- Rouge
    SUCCESS = "|cff00FF00",        -- Vert vif
    INFO = "|cff87CEEB",           -- Bleu clair
    
    -- Interface
    BACKGROUND = "|cff1E1E1E",     -- Gris très foncé
    BORDER = "|cff4A4A4A",         -- Gris moyen
    TEXT_NORMAL = "|cffFFFFFF",    -- Blanc
    TEXT_DISABLED = "|cff808080",  -- Gris
    TEXT_HIGHLIGHT = "|cffFFD700"  -- Or
}

-------------------------------------------------
-- Constantes de l'interface utilisateur
-------------------------------------------------

Constants.UI = {
    -- Tailles de fenêtres
    WINDOW_SIZES = {
        MAIN = { width = 1000, height = 700 },
        MODEL_VIEWER = { width = 380, height = 620 },
        MOUNT_LIST = { width = 580, height = 620 }
    },
    
    -- Espacement
    PADDING = {
        SMALL = 5,
        MEDIUM = 10,
        LARGE = 20
    },
    
    -- Tailles de boutons
    BUTTON_SIZES = {
        SMALL = { width = 80, height = 25 },
        MEDIUM = { width = 120, height = 30 },
        LARGE = { width = 160, height = 35 }
    }
}

-------------------------------------------------
-- Messages et textes
-------------------------------------------------

Constants.MESSAGES = {
    -- Messages d'erreur
    ERROR = {
        NO_MOUNT_SELECTED = "Aucune monture sélectionnée",
        MOUNT_NOT_OWNED = "Vous ne possédez pas cette monture",
        CANNOT_SUMMON = "Impossible d'invoquer cette monture",
        DATABASE_NOT_LOADED = "Base de données non chargée"
    },
    
    -- Messages de succès
    SUCCESS = {
        MOUNT_SUMMONED = "Invocation de %s",
        INTERFACE_LOADED = "Interface chargée avec succès",
        DATABASE_AVAILABLE = "Base de données maintenant disponible"
    },
    
    -- Labels d'interface
    LABELS = {
        MOUNT_PREVIEW = "Aperçu Monture",
        HOVER_TO_DISPLAY = "Survolez une monture pour l'afficher",
        MOUSE_WHEEL_INSTRUCTION = "Molette de la souris pour faire tourner",
        MOUSE_DRAG_INSTRUCTION = "Clic gauche + glisser pour faire tourner",
        SHOW_DETAILS = "Afficher détails",
        SUMMON = "Invoquer",
        NOT_OBTAINED = "Non obtenue",
        COLLECTED = "COLLECTÉ",
        MISSING = "MANQUANT"
    },
    
    -- Détails des montures
    DETAILS = {
        NAME = "Nom:",
        SPELL_ID = "ID Sort:",
        CATEGORY = "Catégorie:",
        EXPANSION = "Expansion:",
        SOURCE = "Source:",
        BOSS = "Boss:",
        DROP_RATE = "Taux de drop:",
        DIFFICULTY = "Difficulté:",
        MODEL_ID = "ID Modèle:",
        COLLECTED_STATUS = "Collecté:",
        TYPE = "Type:",
        STATUS = "Statut:"
    }
}

-------------------------------------------------
-- Fonctions utilitaires
-------------------------------------------------

-- Obtenir l'index de faction à partir du nom
function Constants:GetFactionIndex(factionName)
    if factionName == "Alliance" then
        return self.MOUNT.FACTION_INDEX.ALLIANCE
    elseif factionName == "Horde" then
        return self.MOUNT.FACTION_INDEX.HORDE
    end
    return nil
end

-- Obtenir la texture de faction
function Constants:GetFactionTexture(factionName)
    local index = self:GetFactionIndex(factionName)
    return index and self.MOUNT.FACTION_TEXTURES[index] or nil
end

-- Obtenir la couleur selon le statut de collection
function Constants:GetCollectionStatusColor(isCollected)
    return isCollected and self.COLORS.COLLECTED or self.COLORS.MISSING
end

-- Formater un message avec le préfixe de l'addon
function Constants:FormatMessage(message, messageType)
    local color = messageType and self.COLORS[messageType] or self.COLORS.TEXT_NORMAL
    return self.ADDON.PREFIX .. " " .. color .. message .. "|r"
end

-- Obtenir un message d'erreur formaté
function Constants:GetErrorMessage(errorKey, ...)
    local message = self.MESSAGES.ERROR[errorKey]
    if message and ... then
        message = string.format(message, ...)
    end
    return message and self:FormatMessage(message, "ERROR") or nil
end

-- Obtenir un message de succès formaté
function Constants:GetSuccessMessage(successKey, ...)
    local message = self.MESSAGES.SUCCESS[successKey]
    if message and ... then
        message = string.format(message, ...)
    end
    return message and self:FormatMessage(message, "SUCCESS") or nil
end

return Constants