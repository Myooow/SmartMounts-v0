local addonName, addonTable = ...

-- Base de données consolidée des montures rares
local MountDatabase = {}

-- Structure des données des montures
MountDatabase.mounts = {
    -- CLASSIC MOUNTS
    ["Deathcharger's Reins"] = {
        expansion = "Classic",
        name = "Deathcharger's Reins",
        spellId = 17481,
        itemId = 13335,
        source = "Boss",
        boss = "Baron Rivendare",
        location = "Stratholme",
        difficulty = "Any",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 317, x = 38.6, y = 20 },
        description = "Dropped by Baron Rivendare in Stratholme",
        icon = "Interface\\Icons\\Ability_Mount_Undeadhorse",
        guide = {
            {
                step = 1,
                title = "Se rendre à Stratholme",
                description = "Voyagez vers les Maleterres de l'Est et trouvez l'entrée de Stratholme",
                coords = { mapId = 23, x = 27.5, y = 12.1 },
                type = "travel"
            },
            {
                step = 2,
                title = "Entrer dans Stratholme",
                description = "Utilisez l'entrée Service pour un accès plus rapide au Baron",
                coords = { mapId = 317, x = 66.8, y = 73.4 },
                type = "dungeon"
            },
            {
                step = 3,
                title = "Tuer Baron Rivendare",
                description = "Traversez le donjon et tuez Baron Rivendare. La monture a 1% de chance de drop.",
                coords = { mapId = 317, x = 38.6, y = 20 },
                type = "boss"
            }
        }
    },
    ["Red Qiraji Resonating Crystal"] = {
        expansion = "Classic",
        name = "Red Qiraji Resonating Crystal",
        spellId = 26054,
        itemId = 21321,
        source = "Raid",
        location = "Temple of Ahn'Qiraj",
        difficulty = "40-man",
        dropChance = "Very Rare",
        coords = { mapId = 319 },
        description = "Dropped by various bosses in AQ40",
        icon = "Interface\\Icons\\INV_Jewelry_Necklace_19"
    },

    -- THE BURNING CRUSADE MOUNTS
    ["Ashes of Al'ar"] = {
        expansion = "The Burning Crusade",
        name = "Ashes of Al'ar",
        spellId = 40192,
        itemId = 32458,
        source = "Boss",
        boss = "Kael'thas Sunstrider",
        location = "Tempest Keep: The Eye",
        difficulty = "25-man",
        dropChance = "1.7%",
        blackMarket = true,
        coords = { mapId = 334, x = 50.6, y = 15.2 },
        description = "Dropped by Kael'thas Sunstrider in Tempest Keep",
        icon = "Interface\\Icons\\Ability_Mount_PhoenixMount",
        guide = {
            {
                step = 1,
                title = "Se rendre en Outreterre",
                description = "Passez par la Porte des Ténèbres dans les Terres Foudroyées",
                coords = { mapId = 4, x = 58.3, y = 55.8 },
                type = "travel"
            },
            {
                step = 2,
                title = "Aller à Netherstorm",
                description = "Voyagez vers Netherstorm depuis Shattrath",
                coords = { mapId = 109, x = 74.5, y = 57.9 },
                type = "travel"
            },
            {
                step = 3,
                title = "Entrer dans Tempest Keep",
                description = "L'entrée se trouve au centre de Netherstorm. Utilisez votre monture volante.",
                coords = { mapId = 109, x = 74.5, y = 57.9 },
                type = "dungeon"
            },
            {
                step = 4,
                title = "Tuer Kael'thas Sunstrider",
                description = "Progressez à travers The Eye et tuez Kael'thas. La monture a 1.7% de chance de drop.",
                coords = { mapId = 334, x = 50.6, y = 15.2 },
                type = "boss"
            }
        }
    },
    ["Fiery Warhorse's Reins"] = {
        expansion = "The Burning Crusade",
        name = "Fiery Warhorse's Reins",
        spellId = 36702,
        itemId = 30480,
        source = "Boss",
        boss = "Attumen the Huntsman",
        location = "Karazhan",
        difficulty = "10-man",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 350, x = 46.6, y = 82.6 },
        description = "Dropped by Attumen the Huntsman in Karazhan",
        icon = "Interface\\Icons\\Ability_Mount_Nightmarehorse",
        guide = {
            {
                step = 1,
                title = "Se rendre en Outreterre",
                description = "Passez par la Porte des Ténèbres dans les Terres Foudroyées",
                coords = { mapId = 4, x = 58.3, y = 55.8 },
                type = "travel"
            },
            {
                step = 2,
                title = "Aller à Deadwind Pass",
                description = "Voyagez vers Deadwind Pass depuis Duskwood ou Stranglethorn",
                coords = { mapId = 42, x = 47, y = 75 },
                type = "travel"
            },
            {
                step = 3,
                title = "Entrer dans Karazhan",
                description = "L'entrée de Karazhan se trouve au sommet de la tour",
                coords = { mapId = 42, x = 47, y = 75 },
                type = "dungeon"
            },
            {
                step = 4,
                title = "Tuer Attumen the Huntsman",
                description = "Premier boss de Karazhan. La monture a 1% de chance de drop.",
                coords = { mapId = 350, x = 46.6, y = 82.6 },
                type = "boss"
            }
        }
    },
    ["Reins of the Raven Lord"] = {
        expansion = "The Burning Crusade",
        name = "Reins of the Raven Lord",
        spellId = 41252,
        itemId = 32768,
        source = "Boss",
        boss = "Anzu",
        location = "Sethekk Halls",
        difficulty = "Heroic",
        dropChance = "1.5%",
        blackMarket = true,
        coords = { mapId = 258, x = 32.6, y = 54.5 },
        description = "Dropped by Anzu in Sethekk Halls (Heroic)"
    },
    ["Swift White Hawkstrider"] = {
        expansion = "The Burning Crusade",
        name = "Swift White Hawkstrider",
        spellId = 46628,
        itemId = 35513,
        source = "Boss",
        boss = "Kael'thas Sunstrider",
        location = "Magisters' Terrace",
        difficulty = "Heroic",
        dropChance = "3%",
        blackMarket = true,
        description = "Dropped by Kael'thas in Magisters' Terrace (Heroic)"
    },

    -- WRATH OF THE LICH KING MOUNTS
    ["Invincible's Reins"] = {
        expansion = "Wrath of the Lich King",
        name = "Invincible's Reins",
        spellId = 72286,
        itemId = 50818,
        source = "Boss",
        boss = "The Lich King",
        location = "Icecrown Citadel",
        difficulty = "25 Heroic",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 191, x = 49.8, y = 52.8 },
        description = "Dropped by The Lich King in ICC 25 Heroic",
        icon = "Interface\\Icons\\Ability_Mount_Nightmarehorse",
        guide = {
            {
                step = 1,
                title = "Se rendre en Norfendre",
                description = "Prenez un bateau vers Hurlevent ou Orgrimmar puis vers Norfendre",
                coords = { mapId = 113, x = 15.6, y = 42.3 },
                type = "travel"
            },
            {
                step = 2,
                title = "Aller à la Couronne de Glace",
                description = "Voyagez vers la Couronne de Glace depuis Dalaran",
                coords = { mapId = 118, x = 53.9, y = 86.3 },
                type = "travel"
            },
            {
                step = 3,
                title = "Entrer dans la Citadelle de la Couronne de Glace",
                description = "L'entrée du raid se trouve au sud de la zone",
                coords = { mapId = 118, x = 53.9, y = 86.3 },
                type = "dungeon"
            },
            {
                step = 4,
                title = "Progresser jusqu'au Roi-Liche",
                description = "Traversez les 4 ailes du raid pour atteindre la Flèche de Glace",
                type = "progress"
            },
            {
                step = 5,
                title = "Tuer le Roi-Liche (25 Héroïque)",
                description = "Uniquement en difficulté 25 Héroïque. La monture a 1% de chance de drop.",
                coords = { mapId = 191, x = 49.8, y = 52.8 },
                type = "boss"
            }
        }
    },
    ["Mimiron's Head"] = {
        expansion = "Wrath of the Lich King",
        name = "Mimiron's Head",
        spellId = 63796,
        itemId = 45693,
        source = "Boss",
        boss = "Yogg-Saron",
        location = "Ulduar",
        difficulty = "Hard Mode",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 150, x = 68, y = 40.8 },
        description = "Dropped by Yogg-Saron (0 Keepers) in Ulduar",
        icon = "Interface\\Icons\\INV_Gizmo_Khoriumpowercore",
        guide = {
            {
                step = 1,
                title = "Se rendre en Norfendre",
                description = "Prenez un bateau vers Borean Tundra ou Howling Fjord",
                coords = { mapId = 114, x = 58.5, y = 68.4 },
                type = "travel"
            },
            {
                step = 2,
                title = "Aller au Storm Peaks",
                description = "Voyagez vers Storm Peaks depuis Dalaran ou K3",
                coords = { mapId = 120, x = 41.6, y = 18 },
                type = "travel"
            },
            {
                step = 3,
                title = "Entrer dans Ulduar",
                description = "L'entrée d'Ulduar se trouve dans le sud des Storm Peaks",
                coords = { mapId = 120, x = 41.6, y = 18 },
                type = "dungeon"
            },
            {
                step = 4,
                title = "Progresser jusqu'à Yogg-Saron",
                description = "Traversez Ulduar jusqu'au hall de Yogg-Saron",
                type = "progress"
            },
            {
                step = 5,
                title = "Tuer Yogg-Saron sans Gardiens",
                description = "Activez le Hard Mode en ne parlant à AUCUN Gardien. La monture est garantie.",
                coords = { mapId = 150, x = 68, y = 40.8 },
                type = "boss"
            }
        }
    },
    ["Reins of the Blue Drake"] = {
        expansion = "Wrath of the Lich King",
        name = "Reins of the Blue Drake",
        spellId = 59568,
        itemId = 43953,
        source = "Boss",
        boss = "Malygos",
        location = "The Eye of Eternity",
        difficulty = "Any",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 141, x = 39, y = 51.8 },
        description = "Dropped by Malygos in Eye of Eternity",
        icon = "Interface\\Icons\\Ability_Mount_Drake_Blue"
    },
    ["Reins of the Azure Drake"] = {
        expansion = "Wrath of the Lich King",
        name = "Reins of the Azure Drake",
        spellId = 59567,
        itemId = 43952,
        source = "Boss",
        boss = "Malygos",
        location = "The Eye of Eternity",
        difficulty = "Any",
        dropChance = "4%",
        blackMarket = true,
        coords = { mapId = 141, x = 39, y = 51.8 },
        description = "Dropped by Malygos in Eye of Eternity",
        icon = "Interface\\Icons\\Ability_Mount_Drake_Azure"
    },
    ["Reins of the Blue Proto-Drake"] = {
        expansion = "Wrath of the Lich King",
        name = "Reins of the Blue Proto-Drake",
        spellId = 59996,
        itemId = 44151,
        source = "Boss",
        boss = "Skadi the Ruthless",
        location = "Utgarde Pinnacle",
        difficulty = "Heroic",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 136, x = 68.4, y = 36.2 },
        description = "Dropped by Skadi in Utgarde Pinnacle (Heroic)"
    },
    ["Reins of the Green Proto-Drake"] = {
        expansion = "Wrath of the Lich King",
        name = "Reins of the Green Proto-Drake",
        spellId = 61294,
        itemId = 44707,
        source = "Quest Item",
        location = "Sholazar Basin",
        dropChance = "5%",
        blackMarket = true,
        coords = { mapId = 119, x = 54.6, y = 56.2 },
        description = "From Cracked Egg (Oracles reputation reward)"
    },
    ["Reins of the Onyxian Drake"] = {
        expansion = "Wrath of the Lich King",
        name = "Reins of the Onyxian Drake",
        spellId = 69395,
        itemId = 49636,
        source = "Boss",
        boss = "Onyxia",
        location = "Onyxia's Lair",
        difficulty = "Any",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 248, x = 68, y = 31.4 },
        description = "Dropped by Onyxia in Onyxia's Lair"
    },
    ["Reins of the White Polar Bear"] = {
        expansion = "Wrath of the Lich King",
        name = "Reins of the White Polar Bear",
        spellId = 54753,
        itemId = 43962,
        source = "Daily Quest",
        location = "Storm Peaks",
        dropChance = "3%",
        blackMarket = true,
        coords = { mapId = 120, x = 50.8, y = 65.6 },
        description = "From Hyldnir Spoils (daily quest reward)"
    },
    ["Sea Turtle"] = {
        expansion = "Wrath of the Lich King",
        name = "Sea Turtle",
        spellId = 64731,
        itemId = 46109,
        source = "Fishing",
        location = "Any expansion zone pools",
        dropChance = "0.01%",
        description = "Extremely rare catch from fishing pools",
        icon = "Interface\\Icons\\Ability_Hunter_Pet_Turtle"
    },

    -- CATACLYSM MOUNTS
    ["Armored Razzashi Raptor"] = {
        expansion = "Cataclysm",
        name = "Armored Razzashi Raptor",
        spellId = 96491,
        itemId = 68823,
        source = "Boss",
        boss = "Bloodlord Mandokir",
        location = "Zul'Gurub",
        difficulty = "Heroic",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 337, x = 60.4, y = 79.9 },
        description = "Dropped by Bloodlord Mandokir in ZG (Heroic)"
    },
    ["Swift Zulian Panther"] = {
        expansion = "Cataclysm",
        name = "Swift Zulian Panther",
        spellId = 96499,
        itemId = 68824,
        source = "Boss",
        boss = "High Priestess Kilnara",
        location = "Zul'Gurub",
        difficulty = "Heroic",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 337, x = 48, y = 20 },
        description = "Dropped by High Priestess Kilnara in ZG (Heroic)"
    },
    ["Experiment 12-B"] = {
        expansion = "Cataclysm",
        name = "Experiment 12-B",
        spellId = 110039,
        itemId = 78919,
        source = "Boss",
        boss = "Ultraxion",
        location = "Dragon Soul",
        difficulty = "Any",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 409, x = 49.6, y = 57.6 },
        description = "Dropped by Ultraxion in Dragon Soul"
    },
    ["Flametalon of Alysrazor"] = {
        expansion = "Cataclysm",
        name = "Flametalon of Alysrazor",
        spellId = 101542,
        itemId = 71665,
        source = "Boss",
        boss = "Alysrazor",
        location = "Firelands",
        difficulty = "Any",
        dropChance = "2%",
        blackMarket = true,
        coords = { mapId = 367, x = 64.3, y = 38 },
        description = "Dropped by Alysrazor in Firelands",
        icon = "Interface\\Icons\\Ability_Mount_Fireravensummon",
        guide = {
            {
                step = 1,
                title = "Se rendre au Mont Hyjal",
                description = "Utilisez votre pierre de foyer ou voyagez vers le Mont Hyjal",
                coords = { mapId = 198, x = 47.2, y = 78.3 },
                type = "travel"
            },
            {
                step = 2,
                title = "Localiser l'entrée du Firelands",
                description = "L'entrée du raid se trouve dans le Sanctuaire de Malorne",
                coords = { mapId = 198, x = 47.2, y = 78.3 },
                type = "dungeon"
            },
            {
                step = 3,
                title = "Progresser jusqu'à Alysrazor",
                description = "Traversez les premiers boss jusqu'à Alysrazor (3ème boss)",
                type = "progress"
            },
            {
                step = 4,
                title = "Tuer Alysrazor",
                description = "Combattez Alysrazor en utilisant les plumes volantes. La monture a 2% de chance de drop.",
                coords = { mapId = 367, x = 64.3, y = 38 },
                type = "boss"
            }
        }
    },
    ["Life-Binder's Handmaiden"] = {
        expansion = "Cataclysm",
        name = "Life-Binder's Handmaiden",
        spellId = 107845,
        itemId = 77069,
        source = "Boss",
        boss = "Madness of Deathwing",
        location = "Dragon Soul",
        difficulty = "Heroic",
        dropChance = "100% (Limited time)",
        blackMarket = true,
        coords = { mapId = 409 },
        description = "Dropped by Madness of Deathwing (Heroic) - was guaranteed"
    },
    ["Reins of the Blazing Drake"] = {
        expansion = "Cataclysm",
        name = "Reins of the Blazing Drake",
        spellId = 107842,
        itemId = 77067,
        source = "Boss",
        boss = "Madness of Deathwing",
        location = "Dragon Soul",
        difficulty = "Any",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 409 },
        description = "Dropped by Madness of Deathwing in Dragon Soul"
    },
    ["Fossilized Raptor"] = {
        expansion = "Cataclysm",
        name = "Fossilized Raptor",
        spellId = 84751,
        itemId = 60954,
        source = "Archaeology",
        location = "Fossil dig sites",
        dropChance = "Rare project",
        description = "Rare Fossil archaeology project"
    },
    ["Scepter of Azj'Aqir"] = {
        expansion = "Cataclysm",
        name = "Scepter of Azj'Aqir",
        spellId = 92155,
        itemId = 64883,
        source = "Archaeology",
        location = "Uldum",
        dropChance = "Very rare project",
        coords = { mapId = 249 },
        description = "Very rare Tol'vir archaeology project"
    },
    ["Reins of the Grey Riding Camel"] = {
        expansion = "Cataclysm",
        name = "Reins of the Grey Riding Camel",
        spellId = 88750,
        itemId = 63046,
        source = "Special",
        location = "Uldum",
        dropChance = "5%",
        coords = { mapId = 249 },
        description = "From Dormus via Mysterious Camel Figurine"
    },

    -- MISTS OF PANDARIA MOUNTS
    ["Clutch of Ji-Kun"] = {
        expansion = "Mists of Pandaria",
        name = "Clutch of Ji-Kun",
        spellId = 139448,
        itemId = 95059,
        source = "Boss",
        boss = "Ji-Kun",
        location = "Throne of Thunder",
        difficulty = "Normal/Heroic",
        dropChance = "2%",
        blackMarket = true,
        coords = { mapId = 510, x = 49.7, y = 41.6 },
        description = "Dropped by Ji-Kun in Throne of Thunder"
    },
    ["Kor'kron Juggernaut"] = {
        expansion = "Mists of Pandaria",
        name = "Kor'kron Juggernaut",
        spellId = 148417,
        itemId = 104253,
        source = "Boss",
        boss = "Garrosh Hellscream",
        location = "Siege of Orgrimmar",
        difficulty = "Mythic",
        dropChance = "100% (Limited time)",
        blackMarket = true,
        coords = { mapId = 567, x = 49.4, y = 71.3 },
        description = "Dropped by Garrosh (Mythic) - was guaranteed"
    },
    ["Reins of the Astral Cloud Serpent"] = {
        expansion = "Mists of Pandaria",
        name = "Reins of the Astral Cloud Serpent",
        spellId = 127170,
        itemId = 87777,
        source = "Boss",
        boss = "Elegon",
        location = "Mogu'shan Vaults",
        difficulty = "Normal/Heroic",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 471, x = 21.7, y = 51.1 },
        description = "Dropped by Elegon in Mogu'shan Vaults",
        icon = "Interface\\Icons\\Ability_Mount_Celestialdragonflydragon",
        guide = {
            {
                step = 1,
                title = "Se rendre en Pandarie",
                description = "Utilisez le portail de Stormwind/Orgrimmar vers le Sanctuaire de Jade",
                coords = { mapId = 371, x = 56.0, y = 58.0 },
                type = "travel"
            },
            {
                step = 2,
                title = "Aller à Kun-Lai Summit",
                description = "Voyagez vers le nord jusqu'à Kun-Lai Summit",
                coords = { mapId = 379, x = 60, y = 38 },
                type = "travel"
            },
            {
                step = 3,
                title = "Entrer dans les Caveaux Mogu'shan",
                description = "L'entrée du raid se trouve dans le nord de Kun-Lai Summit",
                coords = { mapId = 379, x = 60, y = 38 },
                type = "dungeon"
            },
            {
                step = 4,
                title = "Progresser jusqu'à Elegon",
                description = "Traversez les premiers boss jusqu'à la chambre d'Elegon",
                type = "progress"
            },
            {
                step = 5,
                title = "Tuer Elegon",
                description = "Combattez Elegon, le dernier boss. La monture a 1% de chance de drop en Normal/Héroïque.",
                coords = { mapId = 471, x = 21.7, y = 51.1 },
                type = "boss"
            }
        }
    },
    ["Spawn of Horridon"] = {
        expansion = "Mists of Pandaria",
        name = "Spawn of Horridon",
        spellId = 136471,
        itemId = 93666,
        source = "Boss",
        boss = "Horridon",
        location = "Throne of Thunder",
        difficulty = "Normal/Heroic",
        dropChance = "1.5%",
        blackMarket = true,
        coords = { mapId = 508, x = 26.8, y = 78.7 },
        description = "Dropped by Horridon in Throne of Thunder"
    },
    ["Reins of the Heavenly Onyx Cloud Serpent"] = {
        expansion = "Mists of Pandaria",
        name = "Reins of the Heavenly Onyx Cloud Serpent",
        spellId = 127158,
        itemId = 87771,
        source = "World Boss",
        boss = "Sha of Anger",
        location = "Kun-Lai Summit",
        difficulty = "World Boss",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 379, x = 53.7, y = 64.7 },
        description = "Dropped by Sha of Anger world boss"
    },
    ["Son of Galleon's Saddle"] = {
        expansion = "Mists of Pandaria",
        name = "Son of Galleon's Saddle",
        spellId = 130965,
        itemId = 89783,
        source = "World Boss",
        boss = "Galleon",
        location = "Valley of the Four Winds",
        difficulty = "World Boss",
        dropChance = "1%",
        blackMarket = true,
        coords = { mapId = 376, x = 71.6, y = 64.4 },
        description = "Dropped by Galleon world boss"
    },
    -- Primordial Direhorns (Warbringers)
    ["Reins of the Amber Primordial Direhorn"] = {
        expansion = "Mists of Pandaria",
        name = "Reins of the Amber Primordial Direhorn",
        spellId = 138424,
        itemId = 94230,
        source = "Rare Elite",
        boss = "Zandalari Warbringer",
        location = "Various Pandaria zones",
        dropChance = "5%",
        blackMarket = true,
        description = "Dropped by Zandalari Warbringers"
    }
}

-- Fonctions utilitaires
MountDatabase.GetMountsByExpansion = function(expansion)
    local mounts = {}
    for name, data in pairs(MountDatabase.mounts) do
        if data.expansion == expansion then
            mounts[name] = data
        end
    end
    return mounts
end

MountDatabase.GetMountsBySource = function(source)
    local mounts = {}
    for name, data in pairs(MountDatabase.mounts) do
        if data.source == source then
            mounts[name] = data
        end
    end
    return mounts
end

MountDatabase.GetMountByItemId = function(itemId)
    for name, data in pairs(MountDatabase.mounts) do
        if data.itemId == itemId then
            return data
        end
    end
    return nil
end

MountDatabase.GetMountBySpellId = function(spellId)
    for name, data in pairs(MountDatabase.mounts) do
        if data.spellId == spellId then
            return data
        end
    end
    return nil
end

MountDatabase.GetExpansions = function()
    local expansions = {}
    for name, data in pairs(MountDatabase.mounts) do
        if not expansions[data.expansion] then
            expansions[data.expansion] = true
        end
    end
    local sortedExpansions = {}
    for expansion in pairs(expansions) do
        table.insert(sortedExpansions, expansion)
    end
    table.sort(sortedExpansions)
    return sortedExpansions
end

MountDatabase.GetSources = function()
    local sources = {}
    for name, data in pairs(MountDatabase.mounts) do
        if not sources[data.source] then
            sources[data.source] = true
        end
    end
    local sortedSources = {}
    for source in pairs(sources) do
        table.insert(sortedSources, source)
    end
    table.sort(sortedSources)
    return sortedSources
end

-- Vérifier si le joueur possède une monture
MountDatabase.HasMount = function(spellId)
    return IsSpellKnown(spellId)
end

-- Obtenir le nombre de montures collectées
MountDatabase.GetCollectedCount = function()
    local count = 0
    for name, data in pairs(MountDatabase.mounts) do
        if MountDatabase.HasMount(data.spellId) then
            count = count + 1
        end
    end
    return count
end

-- Obtenir le nombre total de montures
MountDatabase.GetTotalCount = function()
    local count = 0
    for _ in pairs(MountDatabase.mounts) do
        count = count + 1
    end
    return count
end

-- Export de la base de données
addonTable.MountDatabase = MountDatabase
return MountDatabase