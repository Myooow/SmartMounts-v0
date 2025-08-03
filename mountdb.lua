local addonName, addonTable = ...


-- Base de données consolidée des montures rares
local MountDB = {}

MountDB.CATEGORY_ORDER = {
    ["Achievements"] = 1,
    ["Racial"] = 2,
    ["Professions"] = 3,
    ["Other"] = 4,
    ["Classic"] = 5,
    ["The Burning Crusade"] = 6,
    ["Wrath of the Lich King"] = 7,
    ["Cataclysm"] = 8,
    ["Mists of Pandaria"] = 9
 }

MountDB = {
    [268] = {
        name = "Albino Drake",
        spellId = 60025,
        mountId = 268,
        creatureDisplayId = 25836,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Achievements"
    },
    [292] = {
        name = "Red Dragonhawk",
        spellId = 61997,
        mountId = 292,
        creatureDisplayId = 28402,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Achievements"
    },
    [291] = {
        name = "Blue Dragonhawk",
        spellId = 61996,
        mountId = 291,
        creatureDisplayId = 27525,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Achievements"
    },
    [521] = {
        name = "Jade Pandaren Kite",
        spellId = 133023,
        mountId = 521,
        creatureDisplayId = 42147,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Achievements"
    },
    [549] = {
        name = "Armored Blue Dragonhawk",
        spellId = 142478,
        mountId = 549,
        creatureDisplayId = 48816,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Achievements"
    },
    [548] = {
        name = "Armored Red Dragonhawk",
        spellId = 142266,
        mountId = 548,
        creatureDisplayId = 48815,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Achievements"
    },
    [416] = {
        name = "Felfire Hawk",
        spellId = 97501,
        mountId = 416,
        creatureDisplayId = 38032,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Achievements"
    },
    [477] = {
        name = "Heavenly Azure Cloud Serpent",
        spellId = 127169,
        mountId = 477,
        creatureDisplayId = 43697,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Achievements"
    },
    [450] = {
        name = "Pandaren Kite",
        spellId = 118737,
        mountId = 450,
        creatureDisplayId = 41903,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Mists of Pandaria"
    },
    [516] = {
        name = "Pandaren Kite",
        spellId = 130985,
        mountId = 516,
        creatureDisplayId = 45271,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Mists of Pandaria"
    },
    [472] = {
        name = "Crimson Cloud Serpent",
        spellId = 127156,
        mountId = 472,
        creatureDisplayId = 41592,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [474] = {
        name = "Heavenly Crimson Cloud Serpent",
        spellId = 127161,
        mountId = 474,
        creatureDisplayId = 43692,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [530] = {
        name = "Armored Skyscreamer",
        spellId = 136400,
        mountId = 530,
        creatureDisplayId = 47256,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [557] = {
        name = "Spawn of Galakras",
        spellId = 148392,
        mountId = 557,
        creatureDisplayId = 51479,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [503] = {
        name = "Crimson Pandaren Phoenix",
        spellId = 129552,
        mountId = 503,
        creatureDisplayId = 44633,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [518] = {
        name = "Ashen Pandaren Phoenix",
        spellId = 132117,
        mountId = 518,
        creatureDisplayId = 45521,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [519] = {
        name = "Emerald Pandaren Phoenix",
        spellId = 132118,
        mountId = 519,
        creatureDisplayId = 45520,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [520] = {
        name = "Violet Pandaren Phoenix",
        spellId = 132119,
        mountId = 520,
        creatureDisplayId = 45522,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [479] = {
        name = "Azure Riding Crane",
        spellId = 127174,
        mountId = 479,
        creatureDisplayId = 43704,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [480] = {
        name = "Golden Riding Crane",
        spellId = 127176,
        mountId = 480,
        creatureDisplayId = 43705,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [481] = {
        name = "Regal Riding Crane",
        spellId = 127177,
        mountId = 481,
        creatureDisplayId = 43706,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [464] = {
        name = "Azure Cloud Serpent",
        spellId = 123992,
        mountId = 464,
        creatureDisplayId = 41989,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [465] = {
        name = "Golden Cloud Serpent",
        spellId = 123993,
        mountId = 465,
        creatureDisplayId = 41991,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [448] = {
        name = "Jade Cloud Serpent",
        spellId = 113199,
        mountId = 448,
        creatureDisplayId = 40590,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [505] = {
        name = "Green Shado-Pan Riding Tiger",
        spellId = 129932,
        mountId = 505,
        creatureDisplayId = 44759,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [507] = {
        name = "Red Shado-Pan Riding Tiger",
        spellId = 129935,
        mountId = 507,
        creatureDisplayId = 44757,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [506] = {
        name = "Blue Shado-Pan Riding Tiger",
        spellId = 129934,
        mountId = 506,
        creatureDisplayId = 43900,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [486] = {
        name = "Grey Riding Yak",
        spellId = 127216,
        mountId = 486,
        creatureDisplayId = 43711,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [487] = {
        name = "Blonde Riding Yak",
        spellId = 127220,
        mountId = 487,
        creatureDisplayId = 43712,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [460] = {
        name = "Grand Expedition Yak",
        spellId = 122708,
        mountId = 460,
        creatureDisplayId = 42703,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [508] = {
        name = "Brown Riding Goat",
        spellId = 130086,
        mountId = 508,
        creatureDisplayId = 44807,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [510] = {
        name = "White Riding Goat",
        spellId = 130137,
        mountId = 510,
        creatureDisplayId = 44837,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [511] = {
        name = "Black Riding Goat",
        spellId = 130138,
        mountId = 511,
        creatureDisplayId = 44836,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [538] = {
        name = "Red Primal Raptor",
        spellId = 138641,
        mountId = 538,
        creatureDisplayId = 47826,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [539] = {
        name = "Black Primal Raptor",
        spellId = 138642,
        mountId = 539,
        creatureDisplayId = 47828,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [540] = {
        name = "Green Primal Raptor",
        spellId = 138643,
        mountId = 540,
        creatureDisplayId = 47827,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [528] = {
        name = "Grand Gryphon",
        spellId = 136163,
        mountId = 528,
        creatureDisplayId = 47166,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Mists of Pandaria"
    },
    [529] = {
        name = "Grand Wyvern",
        spellId = 136164,
        mountId = 529,
        creatureDisplayId = 47165,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Mists of Pandaria"
    },
    [471] = {
        name = "Onyx Cloud Serpent",
        spellId = 127154,
        mountId = 471,
        creatureDisplayId = 41990,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [537] = {
        name = "Bone-White Primal Raptor",
        spellId = 138640,
        mountId = 537,
        creatureDisplayId = 47825,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [478] = {
        name = "Astral Cloud Serpent",
        spellId = 127170,
        mountId = 478,
        creatureDisplayId = 46087,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [531] = {
        name = "Spawn of Horridon",
        spellId = 136471,
        mountId = 531,
        creatureDisplayId = 47238,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [543] = {
        name = "Clutch of Ji-Kun",
        spellId = 139448,
        mountId = 543,
        creatureDisplayId = 47983,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [559] = {
        name = "Kor'kron Juggernaut",
        spellId = 148417,
        mountId = 559,
        creatureDisplayId = 51485,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [558] = {
        name = "Kor'kron War Wolf",
        spellId = 148396,
        mountId = 558,
        creatureDisplayId = 51482,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [517] = {
        name = "Thundering Ruby Cloud Serpent",
        spellId = 132036,
        mountId = 517,
        creatureDisplayId = 45797,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [535] = {
        name = "Slate Primordial Direhorn",
        spellId = 138425,
        mountId = 535,
        creatureDisplayId = 47715,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [534] = {
        name = "Amber Primordial Direhorn",
        spellId = 138424,
        mountId = 534,
        creatureDisplayId = 47718,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [536] = {
        name = "Jade Primordial Direhorn",
        spellId = 138426,
        mountId = 536,
        creatureDisplayId = 47717,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [561] = {
        name = "Thundering Onyx Cloud Serpent",
        spellId = 148476,
        mountId = 561,
        creatureDisplayId = 51488,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [533] = {
        name = "Cobalt Primordial Direhorn",
        spellId = 138423,
        mountId = 533,
        creatureDisplayId = 47716,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [473] = {
        name = "Heavenly Onyx Cloud Serpent",
        spellId = 127158,
        mountId = 473,
        creatureDisplayId = 43689,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [515] = {
        name = "Son of Galleon",
        spellId = 130965,
        mountId = 515,
        creatureDisplayId = 45264,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [542] = {
        name = "Thundering Cobalt Cloud Serpent",
        spellId = 139442,
        mountId = 542,
        creatureDisplayId = 47981,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [526] = {
        name = "Grand Armored Gryphon",
        spellId = 135416,
        mountId = 526,
        creatureDisplayId = 46929,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Mists of Pandaria"
    },
    [527] = {
        name = "Grand Armored Wyvern",
        spellId = 135418,
        mountId = 527,
        creatureDisplayId = 46930,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Mists of Pandaria"
    },
    [546] = {
        name = "Crimson Primal Direhorn",
        spellId = 140250,
        mountId = 546,
        creatureDisplayId = 48101,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Mists of Pandaria"
    },
    [545] = {
        name = "Golden Primal Direhorn",
        spellId = 140249,
        mountId = 545,
        creatureDisplayId = 48100,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Mists of Pandaria"
    },
    [449] = {
        name = "Azure Water Strider",
        spellId = 118089,
        mountId = 449,
        creatureDisplayId = 41711,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [504] = {
        name = "Thundering August Cloud Serpent",
        spellId = 129918,
        mountId = 504,
        creatureDisplayId = 43686,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [463] = {
        name = "Amber Scorpion",
        spellId = 123886,
        mountId = 463,
        creatureDisplayId = 43090,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [509] = {
        name = "Red Flying Cloud",
        spellId = 130092,
        mountId = 509,
        creatureDisplayId = 44808,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [475] = {
        name = "Heavenly Golden Cloud Serpent",
        spellId = 127164,
        mountId = 475,
        creatureDisplayId = 43693,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Mists of Pandaria"
    },
    [413] = {
        name = "Flameward Hippogryph",
        spellId = 97359,
        mountId = 413,
        creatureDisplayId = 38018,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [391] = {
        name = "Volcanic Stone Drake",
        spellId = 88331,
        mountId = 391,
        creatureDisplayId = 35551,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [392] = {
        name = "Drake of the East Wind",
        spellId = 88335,
        mountId = 392,
        creatureDisplayId = 35757,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [417] = {
        name = "Corrupted Fire Hawk",
        spellId = 97560,
        mountId = 417,
        creatureDisplayId = 38046,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [443] = {
        name = "Twilight Harbinger",
        spellId = 107844,
        mountId = 443,
        creatureDisplayId = 39562,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [373] = {
        name = "Vashj'ir Seahorse",
        spellId = 75207,
        mountId = 373,
        creatureDisplayId = 34956,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [394] = {
        name = "Drake of the West Wind",
        spellId = 88741,
        mountId = 394,
        creatureDisplayId = 35754,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [405] = {
        name = "Spectral Steed",
        spellId = 92231,
        mountId = 405,
        creatureDisplayId = 37160,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Cataclysm"
    },
    [406] = {
        name = "Spectral Wolf",
        spellId = 92232,
        mountId = 406,
        creatureDisplayId = 37159,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Cataclysm"
    },
    [398] = {
        name = "Brown Riding Camel",
        spellId = 88748,
        mountId = 398,
        creatureDisplayId = 35136,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [399] = {
        name = "Tan Riding Camel",
        spellId = 88749,
        mountId = 399,
        creatureDisplayId = 35134,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [395] = {
        name = "Drake of the North Wind",
        spellId = 88742,
        mountId = 395,
        creatureDisplayId = 35553,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [397] = {
        name = "Vitreous Stone Drake",
        spellId = 88746,
        mountId = 397,
        creatureDisplayId = 35751,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [419] = {
        name = "Amani Battle Bear",
        spellId = 98204,
        mountId = 419,
        creatureDisplayId = 38261,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [410] = {
        name = "Armored Razzashi Raptor",
        spellId = 96491,
        mountId = 410,
        creatureDisplayId = 14341,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [411] = {
        name = "Swift Zulian Panther",
        spellId = 96499,
        mountId = 411,
        creatureDisplayId = 37799,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [396] = {
        name = "Drake of the South Wind",
        spellId = 88744,
        mountId = 396,
        creatureDisplayId = 35755,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [425] = {
        name = "Flametalon of Alysrazor",
        spellId = 101542,
        mountId = 425,
        creatureDisplayId = 38783,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [415] = {
        name = "Pureblood Fire Hawk",
        spellId = 97493,
        mountId = 415,
        creatureDisplayId = 38031,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [445] = {
        name = "Experiment 12-B",
        spellId = 110039,
        mountId = 445,
        creatureDisplayId = 39229,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [442] = {
        name = "Blazing Drake",
        spellId = 107842,
        mountId = 442,
        creatureDisplayId = 39561,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [444] = {
        name = "Life-Binder's Handmaiden",
        spellId = 107845,
        mountId = 444,
        creatureDisplayId = 39563,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [420] = {
        name = "Subdued Seahorse",
        spellId = 98718,
        mountId = 420,
        creatureDisplayId = 34955,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [393] = {
        name = "Phosphorescent Stone Drake",
        spellId = 88718,
        mountId = 393,
        creatureDisplayId = 35740,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [400] = {
        name = "Grey Riding Camel",
        spellId = 88750,
        mountId = 400,
        creatureDisplayId = 35135,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Cataclysm"
    },
    [262] = {
        name = "Red Proto-Drake",
        spellId = 59961,
        mountId = 262,
        creatureDisplayId = 28044,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [306] = {
        name = "Ironbound Proto-Drake",
        spellId = 63956,
        mountId = 306,
        creatureDisplayId = 28953,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [307] = {
        name = "Rusted Proto-Drake",
        spellId = 63963,
        mountId = 307,
        creatureDisplayId = 28954,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [365] = {
        name = "Bloodbathed Frostbrood Vanquisher",
        spellId = 72808,
        mountId = 365,
        creatureDisplayId = 31156,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [364] = {
        name = "Icebound Frostbrood Vanquisher",
        spellId = 72807,
        mountId = 364,
        creatureDisplayId = 31154,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [237] = {
        name = "White Polar Bear",
        spellId = 54753,
        mountId = 237,
        creatureDisplayId = 28428,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [366] = {
        name = "Crimson Deathcharger",
        spellId = 73313,
        mountId = 366,
        creatureDisplayId = 25279,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [276] = {
        name = "Armored Snowy Gryphon",
        spellId = 61229,
        mountId = 276,
        creatureDisplayId = 27913,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [277] = {
        name = "Armored Blue Wind Rider",
        spellId = 61230,
        mountId = 277,
        creatureDisplayId = 27914,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [256] = {
        name = "Wooly Mammoth",
        spellId = 59791,
        mountId = 256,
        creatureDisplayId = 27243,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [257] = {
        name = "Wooly Mammoth",
        spellId = 59793,
        mountId = 257,
        creatureDisplayId = 27244,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [284] = {
        name = "Traveler's Tundra Mammoth",
        spellId = 61447,
        mountId = 284,
        creatureDisplayId = 27238,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [280] = {
        name = "Traveler's Tundra Mammoth",
        spellId = 61425,
        mountId = 280,
        creatureDisplayId = 27237,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [269] = {
        name = "Armored Brown Bear",
        spellId = 60114,
        mountId = 269,
        creatureDisplayId = 27820,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [270] = {
        name = "Armored Brown Bear",
        spellId = 60116,
        mountId = 270,
        creatureDisplayId = 27821,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [321] = {
        name = "Swift Gray Steed",
        spellId = 65640,
        mountId = 321,
        creatureDisplayId = 29043,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [294] = {
        name = "Stormwind Steed",
        spellId = 63232,
        mountId = 294,
        creatureDisplayId = 28912,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [324] = {
        name = "Swift Violet Ram",
        spellId = 65643,
        mountId = 324,
        creatureDisplayId = 28612,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [296] = {
        name = "Ironforge Ram",
        spellId = 63636,
        mountId = 296,
        creatureDisplayId = 29258,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [323] = {
        name = "Turbostrider",
        spellId = 65642,
        mountId = 323,
        creatureDisplayId = 14375,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [298] = {
        name = "Gnomeregan Mechanostrider",
        spellId = 63638,
        mountId = 298,
        creatureDisplayId = 28571,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [318] = {
        name = "Great Red Elekk",
        spellId = 65637,
        mountId = 318,
        creatureDisplayId = 28606,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [299] = {
        name = "Exodar Elekk",
        spellId = 63639,
        mountId = 299,
        creatureDisplayId = 29255,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [319] = {
        name = "Swift Moonsaber",
        spellId = 65638,
        mountId = 319,
        creatureDisplayId = 14333,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [297] = {
        name = "Darnassian Nightsaber",
        spellId = 63637,
        mountId = 297,
        creatureDisplayId = 29256,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [322] = {
        name = "Great Golden Kodo",
        spellId = 65641,
        mountId = 322,
        creatureDisplayId = 28556,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [301] = {
        name = "Thunder Bluff Kodo",
        spellId = 63641,
        mountId = 301,
        creatureDisplayId = 29259,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [325] = {
        name = "Swift Purple Raptor",
        spellId = 65644,
        mountId = 325,
        creatureDisplayId = 14343,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [295] = {
        name = "Darkspear Raptor",
        spellId = 63635,
        mountId = 295,
        creatureDisplayId = 29261,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [327] = {
        name = "Swift Burgundy Wolf",
        spellId = 65646,
        mountId = 327,
        creatureDisplayId = 14335,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [300] = {
        name = "Orgrimmar Wolf",
        spellId = 63640,
        mountId = 300,
        creatureDisplayId = 29260,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [320] = {
        name = "Swift Red Hawkstrider",
        spellId = 65639,
        mountId = 320,
        creatureDisplayId = 28607,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [302] = {
        name = "Silvermoon Hawkstrider",
        spellId = 63642,
        mountId = 302,
        creatureDisplayId = 29262,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [326] = {
        name = "White Skeletal Warhorse",
        spellId = 65645,
        mountId = 326,
        creatureDisplayId = 28605,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [303] = {
        name = "Forsaken Warhorse",
        spellId = 63643,
        mountId = 303,
        creatureDisplayId = 29257,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [331] = {
        name = "Quel'dorei Steed",
        spellId = 66090,
        mountId = 331,
        creatureDisplayId = 28888,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [329] = {
        name = "Silver Covenant Hippogryph",
        spellId = 66087,
        mountId = 329,
        creatureDisplayId = 22474,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [332] = {
        name = "Sunreaver Hawkstrider",
        spellId = 66091,
        mountId = 332,
        creatureDisplayId = 28889,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [330] = {
        name = "Sunreaver Dragonhawk",
        spellId = 66088,
        mountId = 330,
        creatureDisplayId = 29696,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [341] = {
        name = "Argent Warhorse",
        spellId = 67466,
        mountId = 341,
        creatureDisplayId = 28918,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [305] = {
        name = "Argent Hippogryph",
        spellId = 63844,
        mountId = 305,
        creatureDisplayId = 22471,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [259] = {
        name = "Ice Mammoth",
        spellId = 59799,
        mountId = 259,
        creatureDisplayId = 27248,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [289] = {
        name = "Grand Ice Mammoth",
        spellId = 61470,
        mountId = 289,
        creatureDisplayId = 27242,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [258] = {
        name = "Ice Mammoth",
        spellId = 59797,
        mountId = 258,
        creatureDisplayId = 27246,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [288] = {
        name = "Grand Ice Mammoth",
        spellId = 61469,
        mountId = 288,
        creatureDisplayId = 27239,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [249] = {
        name = "Red Drake",
        spellId = 59570,
        mountId = 249,
        creatureDisplayId = 25835,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [278] = {
        name = "Green Proto-Drake",
        spellId = 61294,
        mountId = 278,
        creatureDisplayId = 28053,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [248] = {
        name = "Bronze Drake",
        spellId = 59569,
        mountId = 248,
        creatureDisplayId = 25833,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [264] = {
        name = "Blue Proto-Drake",
        spellId = 59996,
        mountId = 264,
        creatureDisplayId = 28041,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [246] = {
        name = "Azure Drake",
        spellId = 59567,
        mountId = 246,
        creatureDisplayId = 27785,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [247] = {
        name = "Blue Drake",
        spellId = 59568,
        mountId = 247,
        creatureDisplayId = 25832,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [250] = {
        name = "Twilight Drake",
        spellId = 59571,
        mountId = 250,
        creatureDisplayId = 27796,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [253] = {
        name = "Black Drake",
        spellId = 59650,
        mountId = 253,
        creatureDisplayId = 25831,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [286] = {
        name = "Grand Black War Mammoth",
        spellId = 61465,
        mountId = 286,
        creatureDisplayId = 27241,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Wrath of the Lich King"
    },
    [287] = {
        name = "Grand Black War Mammoth",
        spellId = 61467,
        mountId = 287,
        creatureDisplayId = 27240,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Wrath of the Lich King"
    },
    [304] = {
        name = "Mimiron's Head",
        spellId = 63796,
        mountId = 304,
        creatureDisplayId = 28890,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [349] = {
        name = "Onyxian Drake",
        spellId = 69395,
        mountId = 349,
        creatureDisplayId = 30346,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [363] = {
        name = "Invincible",
        spellId = 72286,
        mountId = 363,
        creatureDisplayId = 31007,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [265] = {
        name = "Time-Lost Proto-Drake",
        spellId = 60002,
        mountId = 265,
        creatureDisplayId = 28045,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Wrath of the Lich King"
    },
    [203] = {
        name = "Cenarion War Hippogryph",
        spellId = 43927,
        mountId = 203,
        creatureDisplayId = 22473,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [153] = {
        name = "Cobalt War Talbuk",
        spellId = 34896,
        mountId = 153,
        creatureDisplayId = 19375,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [154] = {
        name = "White War Talbuk",
        spellId = 34897,
        mountId = 154,
        creatureDisplayId = 19377,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [155] = {
        name = "Silver War Talbuk",
        spellId = 34898,
        mountId = 155,
        creatureDisplayId = 19378,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [156] = {
        name = "Tan War Talbuk",
        spellId = 34899,
        mountId = 156,
        creatureDisplayId = 19376,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [170] = {
        name = "Cobalt Riding Talbuk",
        spellId = 39315,
        mountId = 170,
        creatureDisplayId = 21073,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [172] = {
        name = "Silver Riding Talbuk",
        spellId = 39317,
        mountId = 172,
        creatureDisplayId = 21075,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [173] = {
        name = "Tan Riding Talbuk",
        spellId = 39318,
        mountId = 173,
        creatureDisplayId = 21077,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [174] = {
        name = "White Riding Talbuk",
        spellId = 39319,
        mountId = 174,
        creatureDisplayId = 21076,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [187] = {
        name = "Azure Netherwing Drake",
        spellId = 41514,
        mountId = 187,
        creatureDisplayId = 21521,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [188] = {
        name = "Cobalt Netherwing Drake",
        spellId = 41515,
        mountId = 188,
        creatureDisplayId = 21525,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [186] = {
        name = "Onyx Netherwing Drake",
        spellId = 41513,
        mountId = 186,
        creatureDisplayId = 21520,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [189] = {
        name = "Purple Netherwing Drake",
        spellId = 41516,
        mountId = 189,
        creatureDisplayId = 21523,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [190] = {
        name = "Veridian Netherwing Drake",
        spellId = 41517,
        mountId = 190,
        creatureDisplayId = 21522,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [191] = {
        name = "Violet Netherwing Drake",
        spellId = 41518,
        mountId = 191,
        creatureDisplayId = 21524,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [180] = {
        name = "Blue Riding Nether Ray",
        spellId = 39803,
        mountId = 180,
        creatureDisplayId = 21156,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [176] = {
        name = "Green Riding Nether Ray",
        spellId = 39798,
        mountId = 176,
        creatureDisplayId = 21152,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [178] = {
        name = "Purple Riding Nether Ray",
        spellId = 39801,
        mountId = 178,
        creatureDisplayId = 21155,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [177] = {
        name = "Red Riding Nether Ray",
        spellId = 39800,
        mountId = 177,
        creatureDisplayId = 21158,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [179] = {
        name = "Silver Riding Nether Ray",
        spellId = 39802,
        mountId = 179,
        creatureDisplayId = 21157,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [132] = {
        name = "Swift Blue Gryphon",
        spellId = 32242,
        mountId = 132,
        creatureDisplayId = 17759,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "The Burning Crusade"
    },
    [136] = {
        name = "Swift Red Wind Rider",
        spellId = 32246,
        mountId = 136,
        creatureDisplayId = 17719,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "The Burning Crusade"
    },
    [137] = {
        name = "Swift Red Gryphon",
        spellId = 32289,
        mountId = 137,
        creatureDisplayId = 17718,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "The Burning Crusade"
    },
    [138] = {
        name = "Swift Green Gryphon",
        spellId = 32290,
        mountId = 138,
        creatureDisplayId = 17703,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "The Burning Crusade"
    },
    [139] = {
        name = "Swift Purple Gryphon",
        spellId = 32292,
        mountId = 139,
        creatureDisplayId = 17717,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "The Burning Crusade"
    },
    [140] = {
        name = "Swift Green Wind Rider",
        spellId = 32295,
        mountId = 140,
        creatureDisplayId = 17720,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "The Burning Crusade"
    },
    [141] = {
        name = "Swift Yellow Wind Rider",
        spellId = 32296,
        mountId = 141,
        creatureDisplayId = 17722,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "The Burning Crusade"
    },
    [142] = {
        name = "Swift Purple Wind Rider",
        spellId = 32297,
        mountId = 142,
        creatureDisplayId = 17721,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "The Burning Crusade"
    },
    [129] = {
        name = "Golden Gryphon",
        spellId = 32235,
        mountId = 129,
        creatureDisplayId = 17697,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "The Burning Crusade"
    },
    [130] = {
        name = "Ebon Gryphon",
        spellId = 32239,
        mountId = 130,
        creatureDisplayId = 17694,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "The Burning Crusade"
    },
    [131] = {
        name = "Snowy Gryphon",
        spellId = 32240,
        mountId = 131,
        creatureDisplayId = 17696,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "The Burning Crusade"
    },
    [133] = {
        name = "Tawny Wind Rider",
        spellId = 32243,
        mountId = 133,
        creatureDisplayId = 17699,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "The Burning Crusade"
    },
    [134] = {
        name = "Blue Wind Rider",
        spellId = 32244,
        mountId = 134,
        creatureDisplayId = 17700,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "The Burning Crusade"
    },
    [135] = {
        name = "Green Wind Rider",
        spellId = 32245,
        mountId = 135,
        creatureDisplayId = 17701,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = true,
        faction = "Horde",
        category = "The Burning Crusade"
    },
    [185] = {
        name = "Raven Lord",
        spellId = 41252,
        mountId = 185,
        creatureDisplayId = 21473,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [213] = {
        name = "Swift White Hawkstrider",
        spellId = 46628,
        mountId = 213,
        creatureDisplayId = 19483,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [183] = {
        name = "Ashes of Al'ar",
        spellId = 40192,
        mountId = 183,
        creatureDisplayId = 17890,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [168] = {
        name = "Fiery Warhorse",
        spellId = 36702,
        mountId = 168,
        creatureDisplayId = 19250,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "The Burning Crusade"
    },
    [311] = {
        name = "Venomhide Ravasaur",
        spellId = 64659,
        mountId = 311,
        creatureDisplayId = 29102,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Classic"
    },
    [55] = {
        name = "Winterspring Frostsaber",
        spellId = 17229,
        mountId = 55,
        creatureDisplayId = 10426,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Classic"
    },
    [69] = {
        name = "Rivendare's Deathcharger",
        spellId = 17481,
        mountId = 69,
        creatureDisplayId = 10718,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Classic"
    },
    [117] = {
        name = "Blue Qiraji Battle Tank",
        spellId = 25953,
        mountId = 117,
        creatureDisplayId = 15672,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Classic"
    },
    [118] = {
        name = "Red Qiraji Battle Tank",
        spellId = 26054,
        mountId = 118,
        creatureDisplayId = 15681,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Classic"
    },
    [120] = {
        name = "Green Qiraji Battle Tank",
        spellId = 26056,
        mountId = 120,
        creatureDisplayId = 15679,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Classic"
    },
    [119] = {
        name = "Yellow Qiraji Battle Tank",
        spellId = 26055,
        mountId = 119,
        creatureDisplayId = 15680,
        source = "Butin",
        sourceType = "DROP",
        isFactionSpecific = false,
        faction = "",
        category = "Classic"
    },
    [91] = {
        name = "Swift Palomino",
        spellId = 23227,
        mountId = 91,
        creatureDisplayId = 14582,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [93] = {
        name = "Swift Brown Steed",
        spellId = 23229,
        mountId = 93,
        creatureDisplayId = 14583,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [92] = {
        name = "Swift White Steed",
        spellId = 23228,
        mountId = 92,
        creatureDisplayId = 14338,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [18] = {
        name = "Chestnut Mare",
        spellId = 6648,
        mountId = 18,
        creatureDisplayId = 2405,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [9] = {
        name = "Black Stallion",
        spellId = 470,
        mountId = 9,
        creatureDisplayId = 2402,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [11] = {
        name = "Pinto",
        spellId = 472,
        mountId = 11,
        creatureDisplayId = 2409,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [6] = {
        name = "Brown Horse",
        spellId = 458,
        mountId = 6,
        creatureDisplayId = 2404,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [96] = {
        name = "Swift White Ram",
        spellId = 23240,
        mountId = 96,
        creatureDisplayId = 14346,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [94] = {
        name = "Swift Brown Ram",
        spellId = 23238,
        mountId = 94,
        creatureDisplayId = 14347,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [95] = {
        name = "Swift Gray Ram",
        spellId = 23239,
        mountId = 95,
        creatureDisplayId = 14576,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [21] = {
        name = "Gray Ram",
        spellId = 6777,
        mountId = 21,
        creatureDisplayId = 2736,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [25] = {
        name = "Brown Ram",
        spellId = 6899,
        mountId = 25,
        creatureDisplayId = 2785,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [24] = {
        name = "White Ram",
        spellId = 6898,
        mountId = 24,
        creatureDisplayId = 2786,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [87] = {
        name = "Swift Frostsaber",
        spellId = 23221,
        mountId = 87,
        creatureDisplayId = 14331,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [85] = {
        name = "Swift Mistsaber",
        spellId = 23219,
        mountId = 85,
        creatureDisplayId = 14332,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [107] = {
        name = "Swift Stormsaber",
        spellId = 23338,
        mountId = 107,
        creatureDisplayId = 14632,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [34] = {
        name = "Striped Nightsaber",
        spellId = 10793,
        mountId = 34,
        creatureDisplayId = 6448,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [26] = {
        name = "Striped Frostsaber",
        spellId = 8394,
        mountId = 26,
        creatureDisplayId = 6080,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [31] = {
        name = "Spotted Frostsaber",
        spellId = 10789,
        mountId = 31,
        creatureDisplayId = 6444,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [337] = {
        name = "Striped Dawnsaber",
        spellId = 66847,
        mountId = 337,
        creatureDisplayId = 29755,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [90] = {
        name = "Swift Green Mechanostrider",
        spellId = 23225,
        mountId = 90,
        creatureDisplayId = 14374,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [89] = {
        name = "Swift White Mechanostrider",
        spellId = 23223,
        mountId = 89,
        creatureDisplayId = 14376,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [88] = {
        name = "Swift Yellow Mechanostrider",
        spellId = 23222,
        mountId = 88,
        creatureDisplayId = 14377,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [39] = {
        name = "Red Mechanostrider",
        spellId = 10873,
        mountId = 39,
        creatureDisplayId = 9473,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [40] = {
        name = "Blue Mechanostrider",
        spellId = 10969,
        mountId = 40,
        creatureDisplayId = 6569,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [58] = {
        name = "Unpainted Mechanostrider",
        spellId = 17454,
        mountId = 58,
        creatureDisplayId = 9476,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [57] = {
        name = "Green Mechanostrider",
        spellId = 17453,
        mountId = 57,
        creatureDisplayId = 10661,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [166] = {
        name = "Great Blue Elekk",
        spellId = 35713,
        mountId = 166,
        creatureDisplayId = 19871,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [165] = {
        name = "Great Green Elekk",
        spellId = 35712,
        mountId = 165,
        creatureDisplayId = 19873,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [167] = {
        name = "Great Purple Elekk",
        spellId = 35714,
        mountId = 167,
        creatureDisplayId = 19872,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [147] = {
        name = "Brown Elekk",
        spellId = 34406,
        mountId = 147,
        creatureDisplayId = 17063,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [164] = {
        name = "Purple Elekk",
        spellId = 35711,
        mountId = 164,
        creatureDisplayId = 19870,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [163] = {
        name = "Gray Elekk",
        spellId = 35710,
        mountId = 163,
        creatureDisplayId = 19869,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [436] = {
        name = "Swift Mountain Horse",
        spellId = 103196,
        mountId = 436,
        creatureDisplayId = 39095,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [435] = {
        name = "Mountain Horse",
        spellId = 103195,
        mountId = 435,
        creatureDisplayId = 39096,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Racial"
    },
    [453] = {
        name = "Great Red Dragon Turtle",
        spellId = 120822,
        mountId = 453,
        creatureDisplayId = 42352,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [497] = {
        name = "Great Green Dragon Turtle",
        spellId = 127293,
        mountId = 497,
        creatureDisplayId = 43722,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [498] = {
        name = "Great Black Dragon Turtle",
        spellId = 127295,
        mountId = 498,
        creatureDisplayId = 43723,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [499] = {
        name = "Great Blue Dragon Turtle",
        spellId = 127302,
        mountId = 499,
        creatureDisplayId = 43724,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [500] = {
        name = "Great Brown Dragon Turtle",
        spellId = 127308,
        mountId = 500,
        creatureDisplayId = 43725,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [501] = {
        name = "Great Purple Dragon Turtle",
        spellId = 127310,
        mountId = 501,
        creatureDisplayId = 43726,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [452] = {
        name = "Green Dragon Turtle",
        spellId = 120395,
        mountId = 452,
        creatureDisplayId = 42250,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [492] = {
        name = "Black Dragon Turtle",
        spellId = 127286,
        mountId = 492,
        creatureDisplayId = 43717,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [493] = {
        name = "Blue Dragon Turtle",
        spellId = 127287,
        mountId = 493,
        creatureDisplayId = 43718,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [494] = {
        name = "Brown Dragon Turtle",
        spellId = 127288,
        mountId = 494,
        creatureDisplayId = 43719,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [495] = {
        name = "Purple Dragon Turtle",
        spellId = 127289,
        mountId = 495,
        creatureDisplayId = 43720,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [496] = {
        name = "Red Dragon Turtle",
        spellId = 127290,
        mountId = 496,
        creatureDisplayId = 43721,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [1683] = {
        name = "Crimson Vorquin",
        spellId = 394216,
        mountId = 1683,
        creatureDisplayId = 110112,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [1684] = {
        name = "Sapphire Vorquin",
        spellId = 394218,
        mountId = 1684,
        creatureDisplayId = 110115,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [1685] = {
        name = "Bronze Vorquin",
        spellId = 394219,
        mountId = 1685,
        creatureDisplayId = 110113,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [1686] = {
        name = "Obsidian Vorquin",
        spellId = 394220,
        mountId = 1686,
        creatureDisplayId = 110114,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [1665] = {
        name = "Swift Armored Vorquin",
        spellId = 385134,
        mountId = 1665,
        creatureDisplayId = 108731,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [1667] = {
        name = "Armored Vorquin Leystrider",
        spellId = 385131,
        mountId = 1667,
        creatureDisplayId = 108730,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [1668] = {
        name = "Majestic Armored Vorquin",
        spellId = 385115,
        mountId = 1668,
        creatureDisplayId = 108732,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [1664] = {
        name = "Guardian Vorquin",
        spellId = 384963,
        mountId = 1664,
        creatureDisplayId = 108729,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Racial"
    },
    [104] = {
        name = "Swift Brown Wolf",
        spellId = 23250,
        mountId = 104,
        creatureDisplayId = 14573,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [106] = {
        name = "Swift Gray Wolf",
        spellId = 23252,
        mountId = 106,
        creatureDisplayId = 14574,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [105] = {
        name = "Swift Timber Wolf",
        spellId = 23251,
        mountId = 105,
        creatureDisplayId = 14575,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [310] = {
        name = "Black Wolf",
        spellId = 64658,
        mountId = 310,
        creatureDisplayId = 207,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [20] = {
        name = "Brown Wolf",
        spellId = 6654,
        mountId = 20,
        creatureDisplayId = 2328,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [19] = {
        name = "Dire Wolf",
        spellId = 6653,
        mountId = 19,
        creatureDisplayId = 2327,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [14] = {
        name = "Timber Wolf",
        spellId = 580,
        mountId = 14,
        creatureDisplayId = 247,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [68] = {
        name = "Green Skeletal Warhorse",
        spellId = 17465,
        mountId = 68,
        creatureDisplayId = 10720,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [100] = {
        name = "Purple Skeletal Warhorse",
        spellId = 23246,
        mountId = 100,
        creatureDisplayId = 10721,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [65] = {
        name = "Red Skeletal Horse",
        spellId = 17462,
        mountId = 65,
        creatureDisplayId = 10670,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [66] = {
        name = "Blue Skeletal Horse",
        spellId = 17463,
        mountId = 66,
        creatureDisplayId = 10671,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [67] = {
        name = "Brown Skeletal Horse",
        spellId = 17464,
        mountId = 67,
        creatureDisplayId = 10672,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [314] = {
        name = "Black Skeletal Horse",
        spellId = 64977,
        mountId = 314,
        creatureDisplayId = 29130,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [336] = {
        name = "Ochre Skeletal Warhorse",
        spellId = 66846,
        mountId = 336,
        creatureDisplayId = 29754,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [101] = {
        name = "Great White Kodo",
        spellId = 23247,
        mountId = 101,
        creatureDisplayId = 14349,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [103] = {
        name = "Great Brown Kodo",
        spellId = 23249,
        mountId = 103,
        creatureDisplayId = 14578,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [102] = {
        name = "Great Gray Kodo",
        spellId = 23248,
        mountId = 102,
        creatureDisplayId = 14579,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [71] = {
        name = "Gray Kodo",
        spellId = 18989,
        mountId = 71,
        creatureDisplayId = 12246,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [72] = {
        name = "Brown Kodo",
        spellId = 18990,
        mountId = 72,
        creatureDisplayId = 11641,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [309] = {
        name = "White Kodo",
        spellId = 64657,
        mountId = 309,
        creatureDisplayId = 12241,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [97] = {
        name = "Swift Blue Raptor",
        spellId = 23241,
        mountId = 97,
        creatureDisplayId = 14339,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [98] = {
        name = "Swift Olive Raptor",
        spellId = 23242,
        mountId = 98,
        creatureDisplayId = 14344,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [99] = {
        name = "Swift Orange Raptor",
        spellId = 23243,
        mountId = 99,
        creatureDisplayId = 14342,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [27] = {
        name = "Emerald Raptor",
        spellId = 8395,
        mountId = 27,
        creatureDisplayId = 4806,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [36] = {
        name = "Turquoise Raptor",
        spellId = 10796,
        mountId = 36,
        creatureDisplayId = 6472,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [38] = {
        name = "Violet Raptor",
        spellId = 10799,
        mountId = 38,
        creatureDisplayId = 6473,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [389] = {
        name = "Goblin Turbo-Trike",
        spellId = 87091,
        mountId = 389,
        creatureDisplayId = 35250,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [388] = {
        name = "Goblin Trike",
        spellId = 87090,
        mountId = 388,
        creatureDisplayId = 35249,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [146] = {
        name = "Swift Pink Hawkstrider",
        spellId = 33660,
        mountId = 146,
        creatureDisplayId = 18697,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [160] = {
        name = "Swift Green Hawkstrider",
        spellId = 35025,
        mountId = 160,
        creatureDisplayId = 19484,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [161] = {
        name = "Swift Purple Hawkstrider",
        spellId = 35027,
        mountId = 161,
        creatureDisplayId = 19482,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [152] = {
        name = "Red Hawkstrider",
        spellId = 34795,
        mountId = 152,
        creatureDisplayId = 18696,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [158] = {
        name = "Blue Hawkstrider",
        spellId = 35020,
        mountId = 158,
        creatureDisplayId = 19480,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [159] = {
        name = "Black Hawkstrider",
        spellId = 35022,
        mountId = 159,
        creatureDisplayId = 19478,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [157] = {
        name = "Purple Hawkstrider",
        spellId = 35018,
        mountId = 157,
        creatureDisplayId = 19479,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [1600] = {
        name = "Elusive Emerald Hawkstrider",
        spellId = 370620,
        mountId = 1600,
        creatureDisplayId = 106262,
        source = "Quête",
        sourceType = "QUEST",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Racial"
    },
    [407] = {
        name = "Sandstone Drake",
        spellId = 93326,
        mountId = 407,
        creatureDisplayId = 35750,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [386] = {
        name = "Fossilized Raptor",
        spellId = 84751,
        mountId = 386,
        creatureDisplayId = 34410,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [404] = {
        name = "Ultramarine Qiraji Battle Tank",
        spellId = 92155,
        mountId = 404,
        creatureDisplayId = 15672,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [779] = {
        name = "Spirit of Eche'ro",
        spellId = 196681,
        mountId = 779,
        creatureDisplayId = 70874,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [205] = {
        name = "Flying Machine",
        spellId = 44153,
        mountId = 205,
        creatureDisplayId = 22719,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [204] = {
        name = "Turbo-Charged Flying Machine",
        spellId = 44151,
        mountId = 204,
        creatureDisplayId = 22720,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [275] = {
        name = "Mekgineer's Chopper",
        spellId = 60424,
        mountId = 275,
        creatureDisplayId = 25870,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Professions"
    },
    [240] = {
        name = "Mechano-Hog",
        spellId = 55531,
        mountId = 240,
        creatureDisplayId = 25871,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Professions"
    },
    [469] = {
        name = "Depleted-Kyparium Rocket",
        spellId = 126507,
        mountId = 469,
        creatureDisplayId = 43637,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [470] = {
        name = "Geosynchronous World Spinner",
        spellId = 126508,
        mountId = 470,
        creatureDisplayId = 43638,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [522] = {
        name = "Sky Golem",
        spellId = 134359,
        mountId = 522,
        creatureDisplayId = 46686,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [1028] = {
        name = "Mecha-Mogul Mk2",
        spellId = 261437,
        mountId = 1028,
        creatureDisplayId = 80864,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [999] = {
        name = "Xiwyllag ATV",
        spellId = 256123,
        mountId = 999,
        creatureDisplayId = 80513,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [2158] = {
        name = "Crowd Pummeler 2-30",
        spellId = 448186,
        mountId = 2158,
        creatureDisplayId = 119383,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [312] = {
        name = "Sea Turtle",
        spellId = 64731,
        mountId = 312,
        creatureDisplayId = 29161,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [125] = {
        name = "Riding Turtle",
        spellId = 30174,
        mountId = 125,
        creatureDisplayId = 17158,
        source = "Jeu de cartes à collectionner",
        sourceType = "TCG",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [982] = {
        name = "Pond Nettle",
        spellId = 253711,
        mountId = 982,
        creatureDisplayId = 79613,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [1166] = {
        name = "Great Sea Ray",
        spellId = 278803,
        mountId = 1166,
        creatureDisplayId = 73253,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [2188] = {
        name = "Kah, Legend of the Deep",
        spellId = 448850,
        mountId = 2188,
        creatureDisplayId = 119507,
        source = "Comptoir",
        sourceType = "TRADINGPOST",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [457] = {
        name = "Jade Panther",
        spellId = 121837,
        mountId = 457,
        creatureDisplayId = 42502,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [458] = {
        name = "Ruby Panther",
        spellId = 121838,
        mountId = 458,
        creatureDisplayId = 42499,
        source = "Promotion",
        sourceType = "PROMOTION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [456] = {
        name = "Sapphire Panther",
        spellId = 121836,
        mountId = 456,
        creatureDisplayId = 42500,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [459] = {
        name = "Sunstone Panther",
        spellId = 121839,
        mountId = 459,
        creatureDisplayId = 42501,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [451] = {
        name = "Jeweled Onyx Panther",
        spellId = 120043,
        mountId = 451,
        creatureDisplayId = 42185,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [2502] = {
        name = "Void-Crystal Panther",
        spellId = 1218317,
        mountId = 2502,
        creatureDisplayId = 127586,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [285] = {
        name = "Flying Carpet",
        spellId = 61451,
        mountId = 285,
        creatureDisplayId = 28082,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [375] = {
        name = "Frosty Flying Carpet",
        spellId = 75596,
        mountId = 375,
        creatureDisplayId = 28063,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [279] = {
        name = "Magnificent Flying Carpet",
        spellId = 61309,
        mountId = 279,
        creatureDisplayId = 28060,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [603] = {
        name = "Creeping Carpet",
        spellId = 169952,
        mountId = 603,
        creatureDisplayId = 46453,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [650] = {
        name = "Dustmane Direwolf",
        spellId = 171844,
        mountId = 650,
        creatureDisplayId = 59762,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [854] = {
        name = "Great Northern Elderhorn",
        spellId = 213339,
        mountId = 854,
        creatureDisplayId = 67042,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [797] = {
        name = "Steelbound Devourer",
        spellId = 213209,
        mountId = 797,
        creatureDisplayId = 70099,
        source = "Métier",
        sourceType = "PROFESSION",
        isFactionSpecific = false,
        faction = "",
        category = "Professions"
    },
    [401] = {
        name = "Dark Phoenix",
        spellId = 88990,
        mountId = 401,
        creatureDisplayId = 37145,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Other"
    },
    [403] = {
        name = "Golden King",
        spellId = 90621,
        mountId = 403,
        creatureDisplayId = 36213,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Alliance",
        category = "Other"
    },
    [409] = {
        name = "Kor'kron Annihilator",
        spellId = 93644,
        mountId = 409,
        creatureDisplayId = 37138,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = true,
        faction = "Horde",
        category = "Other"
    },
    [466] = {
        name = "Thundering Jade Cloud Serpent",
        spellId = 124408,
        mountId = 466,
        creatureDisplayId = 43562,
        source = "Vendeur",
        sourceType = "VENDOR",
        isFactionSpecific = false,
        faction = "",
        category = "Other"
    },
    [619] = {
        name = "Blacksteel Battleboar",
        spellId = 171627,
        mountId = 619,
        creatureDisplayId = 59349,
        source = "Haut fait",
        sourceType = "ACHIEVEMENT",
        isFactionSpecific = false,
        faction = "",
        category = "Other"
    },
}

-------------------------------------------------
-- Fonctions utilitaires pour mountdb2
-------------------------------------------------
MountDB.HasMount = function(spellId)
    local mountID = C_MountJournal.GetMountFromSpell(spellId)
    return mountID and select(11, C_MountJournal.GetMountInfoByID(mountID)) or IsPlayerSpell(spellId)
end

-- 1. Montures connues (grimoire) → 16
MountDB.GetKnownCount = function()
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

MountDB.GetCollectedCount = function()
    if not (C_MountJournal and C_MountJournal.GetMountIDs) then return 0 end
    local n = 0
    for _, id in ipairs(C_MountJournal.GetMountIDs()) do
        local _, _, _, _, _, _, _, _, _, _, isCollected =
              C_MountJournal.GetMountInfoByID(id)
        if isCollected then                     -- **peu importe hideOnChar**
            n = n + 1
        end
    end
    return n
end

MountDB.GetUsableCount = function()
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

MountDB.GetTotalCount = function()
    local count = 0
    for _, _ in pairs(MountDB) do
        count = count + 1
    end
    return count
end

-- Fonctions utilitaires
MountDB.GetMountsByCategory = function(category)
    local mounts = {}
    for name, data in pairs(MountDB) do
        if data.category == category then
            mounts[name] = data
        end
    end
    return mounts
end

MountDB.GetMountsBySource = function(source)
    local mounts = {}
    for name, data in pairs(MountDB) do
        if data.source == source then
            mounts[name] = data
        end
    end
    return mounts
end

MountDB.GetMountByItemId = function(itemId)
    for name, data in pairs(MountDB) do
        if data.itemId == itemId then
            return data
        end
    end
    return nil
end

MountDB.GetMountBySpellId = function(spellId)
    for _, data in pairs(MountDB) do
        if data.spellId == spellId then
            return data
        end
    end
    return nil
end

MountDB.GetCategories = function()
    -- 1) Collecte les extensions présentes dans la base
    local found = {}
    for _, entry in pairs(MountDB) do
        if type(entry) == "table" and type(entry.category) == "string" then
            found[entry.category] = true
        end
    end

    -- 2) Passe le set en liste
    local list = {}
    for category in pairs(found) do
        table.insert(list, category)
    end

    -- 3) Trie selon l’ordre défini, puis par nom si même rang
    local order = MountDB.CATEGORY_ORDER or {}
    table.sort(list, function(a, b)
        local oa = order[a] or math.huge   -- inconnues vont à la fin
        local ob = order[b] or math.huge
        if oa == ob then                   -- même rang ? -> alphabétique
            return a < b
        else
            return oa < ob                 -- plus petit rang = plus ancien
        end
    end)

    return list
end

MountDB.GetSources = function()
    local sources = {}
    for name, data in pairs(MountDB) do
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

-- Export de la base de données
addonTable.MountDB = MountDB
return MountDB

