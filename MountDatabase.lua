local addonName, addonTable = ...


-- Base de données consolidée des montures rares
local MountDatabase = {}

MountDatabase.EXPANSION_ORDER = {
    ["Classic"] = 1, 
    ["The Burning Crusade"] = 2,
    ["Wrath of the Lich King"] = 3,
    ["Cataclysm"] = 4,
    ["Mists of Pandaria"] = 5
 }

-- Structure des données des montures
MountDatabase.mounts = {

        ---------------------------------------------------------------------------
    -- CLASSIC (2004-2006) – VENDOR & RÉPUTATION
    --   • Prix indicatifs : 1 g (monture 60 %) / 100 g (monture 100 %)
    --   • Les champs "icon" sont volontairement omis : SmartMounts le déduit.
    ---------------------------------------------------------------------------

    --------------------------
    -- Alliance — Stormwind  |
    --------------------------
    ["Brown Horse"] = {
        expansion   = "Classic",
        name        = "Brown Horse",
        spellId     = 458,
        itemId      = 5656,
        source      = "Vendor",
        location    = "Elwynn Forest / Stormwind City",
        dropChance  = "Vendor (1 g)",
        coords      = { mapId = 37 },
        description = "Sold by Katie Hunter (Eastvale) or Katie Stokx (Old Town, SW).",
    },
    ["Chestnut Mare"] = {
        expansion = "Classic", name = "Chestnut Mare",
        spellId = 6648, itemId = 5655, source = "Vendor",
        location = "Elwynn Forest / Stormwind City",
        dropChance = "Vendor (1 g)", coords = { mapId = 37 },
        description = "Standard horse mount for Alliance riders.",
    },
    ["Pinto"] = {
        expansion = "Classic", name = "Pinto",
        spellId = 472, itemId = 2414, source = "Vendor",
        location = "Elwynn Forest / Stormwind City",
        dropChance = "Vendor (1 g)", coords = { mapId = 37 },
        description = "Spotted horse sold by SW breeders.",
    },
    ["Black Stallion"] = {
        expansion = "Classic", name = "Black Stallion",
        spellId = 470, itemId = 2411, source = "Vendor",
        location = "Menethil Harbor (Wetlands)",
        dropChance = "Vendor (1 g)", coords = { mapId = 50 },
        description = "Only Unger Statforth in Menethil sells this dark mount.",
    },
    ["Palomino"] = {
        expansion = "Classic", name = "Palomino",
        spellId = 16082, itemId = 12354, source = "Vendor",
        location = "Elwynn Forest",
        dropChance = "Vendor (1 g)", coords = { mapId = 37 },
        description = "Golden coat; same speed as other lvl 40 horses.",
    },
    ["White Stallion"] = {
        expansion = "Classic", name = "White Stallion",
        spellId = 16083, itemId = 12353, source = "Vendor",
        location = "Elwynn Forest / Stormwind City",
        dropChance = "Vendor (100 g)", coords = { mapId = 37 },
        description = "Epic pre-1.4 horse still purchasable from horse breeders.",
    },
    ["Swift Brown Steed"] = {
        expansion = "Classic", name = "Swift Brown Steed",
        spellId = 23229, itemId = 18777, source = "Vendor",
        location = "Elwynn Forest / Stormwind City",
        dropChance = "Vendor (100 g)", coords = { mapId = 37 },
        description = "Epic (100 %) brown horse.",
    },
    ["Swift Palomino"] = {
        expansion = "Classic", name = "Swift Palomino",
        spellId = 23227, itemId = 18776, source = "Vendor",
        location = "Elwynn Forest / Stormwind City",
        dropChance = "Vendor (100 g)", coords = { mapId = 37 },
        description = "Epic palomino variant.",
    },
    ["Swift White Steed"] = {
        expansion = "Classic", name = "Swift White Steed",
        spellId = 23228, itemId = 18778, source = "Vendor",
        location = "Elwynn Forest / Stormwind City",
        dropChance = "Vendor (100 g)", coords = { mapId = 37 },
        description = "Epic white horse sold by SW breeders.",
    },

    --------------------------
    -- Alliance — Ironforge  |
    --------------------------
    ["Gray Ram"] = {
        expansion="Classic", name="Gray Ram",
        spellId=6777, itemId=5864, source="Vendor",
        location="Dun Morogh / Ironforge",
        dropChance="Vendor (1 g)", coords={ mapId = 87 },
        description="Basic gray ram from Veron Amberstill.",
    },
    ["Brown Ram"] = {
        expansion="Classic", name="Brown Ram",
        spellId=6899, itemId=5872, source="Vendor",
        location="Dun Morogh / Ironforge",
        dropChance="Vendor (1 g)", coords={ mapId = 87 },
        description="Standard brown ram.",
    },
    ["White Ram"] = {
        expansion="Classic", name="White Ram",
        spellId=6898, itemId=5873, source="Vendor",
        location="Dun Morogh / Ironforge",
        dropChance="Vendor (1 g)", coords={ mapId = 87 },
        description="Snow-white ram.",
    },
    ["Swift Brown Ram"] = {
        expansion="Classic", name="Swift Brown Ram",
        spellId=23238, itemId=18786, source="Vendor",
        location="Dun Morogh / Ironforge",
        dropChance="Vendor (100 g)", coords={ mapId = 87 },
        description="Epic brown ram.",
    },
    ["Swift Gray Ram"] = {
        expansion="Classic", name="Swift Gray Ram",
        spellId=23239, itemId=18787, source="Vendor",
        location="Dun Morogh / Ironforge",
        dropChance="Vendor (100 g)", coords={ mapId = 87 },
        description="Epic gray ram.",
    },
    ["Swift White Ram"] = {
        expansion="Classic", name="Swift White Ram",
        spellId=23240, itemId=18785, source="Vendor",
        location="Dun Morogh / Ironforge",
        dropChance="Vendor (100 g)", coords={ mapId = 87 },
        description="Epic white ram.",
    },

    --------------------------
    -- Alliance — Darnassus |
    --------------------------
    ["Striped Frostsaber"] = {
        expansion="Classic", name="Striped Frostsaber",
        spellId=8394, itemId=8631, source="Vendor",
        location="Darnassus",
        dropChance="Vendor (1 g)", coords={ mapId = 89 },
        description="Blue-striped mount sold by Lelanai.",
    },
    ["Spotted Frostsaber"] = {
        expansion="Classic", name="Spotted Frostsaber",
        spellId=10789, itemId=8632, source="Vendor",
        location="Darnassus",
        dropChance="Vendor (1 g)", coords={ mapId = 89 },
        description="Green-spotted sabercat.",
    },
    ["Striped Nightsaber"] = {
        expansion="Classic", name="Striped Nightsaber",
        spellId=10793, itemId=8629, source="Vendor",
        location="Darnassus",
        dropChance="Vendor (1 g)", coords={ mapId = 89 },
        description="Purple nightsaber.",
    },
    ["Swift Frostsaber"] = {
        expansion="Classic", name="Swift Frostsaber",
        spellId=23221, itemId=18766, source="Vendor",
        location="Darnassus",
        dropChance="Vendor (100 g)", coords={ mapId = 89 },
        description="Epic frostsaber.",
    },
    ["Swift Mistsaber"] = {
        expansion="Classic", name="Swift Mistsaber",
        spellId=23219, itemId=18767, source="Vendor",
        location="Darnassus",
        dropChance="Vendor (100 g)", coords={ mapId = 89 },
        description="Epic mistsaber.",
    },
    ["Swift Stormsaber"] = {
        expansion="Classic", name="Swift Stormsaber",
        spellId=23338, itemId=18902, source="Vendor",
        location="Darnassus",
        dropChance="Vendor (100 g)", coords={ mapId = 89 },
        description="Epic stormsaber.",
    },
    -- Réputation Winterspring
    ["Winterspring Frostsaber"] = {
        expansion="Classic", name="Winterspring Frostsaber",
        spellId=17229, itemId=13086, source="Reputation",
        location="Winterspring",
        dropChance="Vendor (100 g) – Exalted Wintersaber Trainers",
        coords={ mapId = 83 },
        description="Iconic 20-day grind mount (Alliance only).",
    },

    -------------------------------
    -- Alliance — Mechanostrider |
    -------------------------------
    ["Blue Mechanostrider"] = {
        expansion="Classic", name="Blue Mechanostrider",
        spellId=10969, itemId=8595, source="Vendor",
        location="Dun Morogh (Kharanos)",
        dropChance="Vendor (1 g)", coords={ mapId = 27 },
        description="Sold by Milli Featherwhistle.",
    },
    ["Red Mechanostrider"] = {
        expansion="Classic", name="Red Mechanostrider",
        spellId=10873, itemId=8563, source="Vendor",
        location="Dun Morogh (Kharanos)",
        dropChance="Vendor (1 g)", coords={ mapId = 27 },
        description="Standard red strider.",
    },
    ["Green Mechanostrider"] = {
        expansion="Classic", name="Green Mechanostrider",
        spellId=17453, itemId=13321, source="Vendor",
        location="Dun Morogh (Kharanos)",
        dropChance="Vendor (1 g)", coords={ mapId = 27 },
        description="Green strider, requires Gnome or exalted IF.",
    },
    ["Unpainted Mechanostrider"] = {
        expansion="Classic", name="Unpainted Mechanostrider",
        spellId=17454, itemId=13322, source="Vendor",
        location="Dun Morogh (Kharanos)",
        dropChance="Vendor (1 g)", coords={ mapId = 27 },
        description="Bare-metal version for collectors.",
    },
    ["Swift Green Mechanostrider"] = {
        expansion="Classic", name="Swift Green Mechanostrider",
        spellId=23225, itemId=18772, source="Vendor",
        location="Dun Morogh (Kharanos)",
        dropChance="Vendor (100 g)", coords={ mapId = 27 },
        description="Epic green strider.",
    },
    ["Swift White Mechanostrider"] = {
        expansion="Classic", name="Swift White Mechanostrider",
        spellId=23223, itemId=18773, source="Vendor",
        location="Dun Morogh (Kharanos)",
        dropChance="Vendor (100 g)", coords={ mapId = 27 },
        description="Epic white strider.",
    },
    ["Swift Yellow Mechanostrider"] = {
        expansion="Classic", name="Swift Yellow Mechanostrider",
        spellId=23222, itemId=18774, source="Vendor",
        location="Dun Morogh (Kharanos)",
        dropChance="Vendor (100 g)", coords={ mapId = 27 },
        description="Epic yellow strider.",
    },

    --------------------------
    -- Horde — Orgrimmar    |
    --------------------------
    ["Brown Wolf"] = {
        expansion="Classic", name="Brown Wolf",
        spellId=6654, itemId=5668, source="Vendor",
        location="Orgrimmar",
        dropChance="Vendor (1 g)", coords={ mapId = 85 },
        description="Sold by Ogunaro Wolfrunner.",
    },
    ["Dire Wolf"] = {
        expansion="Classic", name="Dire Wolf",
        spellId=6653, itemId=5665, source="Vendor",
        location="Orgrimmar",
        dropChance="Vendor (1 g)", coords={ mapId = 85 },
        description="Gray-fur dire wolf.",
    },
    ["Timber Wolf"] = {
        expansion="Classic", name="Timber Wolf",
        spellId=580, itemId=1132, source="Vendor",
        location="Orgrimmar",
        dropChance="Vendor (1 g)", coords={ mapId = 85 },
        description="Brown-gray timber wolf.",
    },
    ["Black Wolf"] = {
        expansion   = "Classic",
        name        = "Black Wolf",
        spellId     = 64658,          -- sort (MoP-Classic)
        itemId      = 46099,          -- ✅ Horn of the Black Wolf (MoP-Classic)
        source      = "Vendor",
        location    = "Orgrimmar",    -- Ogunaro Wolfrunner
        dropChance  = "Vendor (1 g)",
        coords      = { mapId = 85 }, -- Vallée de l’Honneur
        description = "Vendu par Ogunaro Wolfrunner. Exalté Orgrimmar requis si tu n’es pas Orc."
    },
    ["Red Wolf"] = {
        expansion="Classic", name="Red Wolf",
        spellId=16080, itemId=12330, source="Vendor",
        location="Orgrimmar",
        dropChance="Vendor (1 g)", coords={ mapId = 85 },
        description="Rare red-fur wolf mount.",
    },
    ["Swift Brown Wolf"] = {
        expansion="Classic", name="Swift Brown Wolf",
        spellId=23250, itemId=18796, source="Vendor",
        location="Orgrimmar",
        dropChance="Vendor (100 g)", coords={ mapId = 85 },
        description="Epic brown wolf.",
    },
    ["Swift Gray Wolf"] = {
        expansion="Classic", name="Swift Gray Wolf",
        spellId=23252, itemId=18798, source="Vendor",
        location="Orgrimmar",
        dropChance="Vendor (100 g)", coords={ mapId = 85 },
        description="Epic gray wolf.",
    },
    ["Swift Timber Wolf"] = {
        expansion="Classic", name="Swift Timber Wolf",
        spellId=23251, itemId=18797, source="Vendor",
        location="Orgrimmar",
        dropChance="Vendor (100 g)", coords={ mapId = 85 },
        description="Epic timber wolf.",
    },

    --------------------------
    -- Horde — Thunder Bluff |
    --------------------------
    ["Brown Kodo"] = {
        expansion="Classic", name="Brown Kodo",
        spellId=18990, itemId=15290, source="Vendor",
        location="Mulgore / Thunder Bluff",
        dropChance="Vendor (10 g)", coords={ mapId = 88 },
        description="Sold by Harb Clawhoof near TB.",
    },
    ["Gray Kodo"] = {
        expansion="Classic", name="Gray Kodo",
        spellId=18989, itemId=15277, source="Vendor",
        location="Mulgore / Thunder Bluff",
        dropChance="Vendor (10 g)", coords={ mapId = 88 },
        description="Standard gray kodo.",
    },
    ["Green Kodo"] = {
        expansion="Classic", name="Green Kodo",
        spellId=18991, itemId=15292, source="Vendor",
        location="Mulgore / Thunder Bluff",
        dropChance="Vendor (10 g)", coords={ mapId = 88 },
        description="Green-skinned kodo.",
    },
    ["Teal Kodo"] = {
        expansion="Classic", name="Teal Kodo",
        spellId=18992, itemId=15293, source="Vendor",
        location="Mulgore / Thunder Bluff",
        dropChance="Vendor (10 g)", coords={ mapId = 88 },
        description="Teal variant.",
    },
    ["Great Brown Kodo"] = {
        expansion="Classic", name="Great Brown Kodo",
        spellId=23249, itemId=18794, source="Vendor",
        location="Mulgore / Thunder Bluff",
        dropChance="Vendor (100 g)", coords={ mapId = 88 },
        description="Epic brown kodo.",
    },
    ["Great Gray Kodo"] = {
        expansion="Classic", name="Great Gray Kodo",
        spellId=23248, itemId=18795, source="Vendor",
        location="Mulgore / Thunder Bluff",
        dropChance="Vendor (100 g)", coords={ mapId = 88 },
        description="Epic gray kodo.",
    },
    ["Great White Kodo"] = {
        expansion="Classic", name="Great White Kodo",
        spellId=23247, itemId=18793, source="Vendor",
        location="Mulgore / Thunder Bluff",
        dropChance="Vendor (100 g)", coords={ mapId = 88 },
        description="Epic white kodo.",
    },

    --------------------------
    -- Horde — Darkspear     |
    --------------------------
    ["Emerald Raptor"] = {
        expansion="Classic", name="Emerald Raptor",
        spellId=8395, itemId=8588, source="Vendor",
        location="Durotar / Orgrimmar",
        dropChance="Vendor (1 g)", coords={ mapId = 1 },
        description="Green raptor sold by Zjolnir.",
    },
    ["Turquoise Raptor"] = {
        expansion="Classic", name="Turquoise Raptor",
        spellId=10796, itemId=8591, source="Vendor",
        location="Durotar / Orgrimmar",
        dropChance="Vendor (1 g)", coords={ mapId = 1 },
        description="Turquoise raptor.",
    },
    ["Violet Raptor"] = {
        expansion="Classic", name="Violet Raptor",
        spellId=10799, itemId=8592, source="Vendor",
        location="Durotar / Orgrimmar",
        dropChance="Vendor (1 g)", coords={ mapId = 1 },
        description="Purple raptor.",
    },
    ["Mottled Red Raptor"] = {
        expansion="Classic", name="Mottled Red Raptor",
        spellId=16084, itemId=8586, source="Vendor",
        location="Durotar / Orgrimmar",
        dropChance="Vendor (1 g)", coords={ mapId = 1 },
        description="Red-spotted variant.",
    },
    ["Ivory Raptor"] = {
        expansion="Classic", name="Ivory Raptor",
        spellId=17450, itemId=13317, source="Vendor",
        location="Durotar / Orgrimmar",
        dropChance="Vendor (1 g)", coords={ mapId = 1 },
        description="Ivory-colored raptor.",
    },
    ["Swift Blue Raptor"] = {
        expansion="Classic", name="Swift Blue Raptor",
        spellId=23241, itemId=18788, source="Vendor",
        location="Durotar / Orgrimmar",
        dropChance="Vendor (100 g)", coords={ mapId = 1 },
        description="Epic blue raptor.",
    },
    ["Swift Olive Raptor"] = {
        expansion="Classic", name="Swift Olive Raptor",
        spellId=23242, itemId=18789, source="Vendor",
        location="Durotar / Orgrimmar",
        dropChance="Vendor (100 g)", coords={ mapId = 1 },
        description="Epic olive raptor.",
    },
    ["Swift Orange Raptor"] = {
        expansion="Classic", name="Swift Orange Raptor",
        spellId=23243, itemId=18790, source="Vendor",
        location="Durotar / Orgrimmar",
        dropChance="Vendor (100 g)", coords={ mapId = 1 },
        description="Epic orange raptor.",
    },

    --------------------------
    -- Horde — Undercity     |
    --------------------------
    ["Brown Skeletal Horse"] = {
        expansion="Classic", name="Brown Skeletal Horse",
        spellId=17464, itemId=13333, source="Vendor",
        location="Tirisfal Glades / Undercity",
        dropChance="Vendor (1 g)", coords={ mapId = 90 },
        description="Sold by Zachariah Post.",
    },
    ["Blue Skeletal Horse"] = {
        expansion="Classic", name="Blue Skeletal Horse",
        spellId=17463, itemId=13332, source="Vendor",
        location="Tirisfal Glades / Undercity",
        dropChance="Vendor (1 g)", coords={ mapId = 90 },
        description="Blue bones and barding.",
    },
    ["Red Skeletal Horse"] = {
        expansion="Classic", name="Red Skeletal Horse",
        spellId=17462, itemId=13331, source="Vendor",
        location="Tirisfal Glades / Undercity",
        dropChance="Vendor (1 g)", coords={ mapId = 90 },
        description="Red variant.",
    },
    ["Green Skeletal Warhorse"] = {
        expansion="Classic", name="Green Skeletal Warhorse",
        spellId=17465, itemId=13334, source="Vendor",
        location="Tirisfal Glades / Undercity",
        dropChance="Vendor (100 g)", coords={ mapId = 90 },
        description="Epic green warhorse.",
    },
    ["Purple Skeletal Warhorse"] = {
        expansion="Classic", name="Purple Skeletal Warhorse",
        spellId=23246, itemId=18791, source="Vendor",
        location="Tirisfal Glades / Undercity",
        dropChance="Vendor (100 g)", coords={ mapId = 90 },
        description="Epic purple warhorse.",
    },

    ----------------------------------
    -- Horde – Quête / Réputation    |
    ----------------------------------
    ["Venomhide Ravasaur"] = {
        expansion="Classic", name="Venomhide Ravasaur",
        spellId=64659, itemId=46102, source="Quest",
        location="Un'Goro Crater",
        dropChance="20 dailies – Horde only",
        coords={ mapId = 78 },
        description="Earned via the ‘They Grow Up So Fast’ quest line.",
    },
    
    ---------------------------------------------------------------------------
    -- THE BURNING CRUSADE (2007) – VENDOR & REPUTATION
    ---------------------------------------------------------------------------

    -------------------------------------------------
    -- ALLIANCE – Gryphon Keeper (Outland / Stormwind)
    -------------------------------------------------
    ["Golden Gryphon"]       = { expansion="The Burning Crusade", name="Golden Gryphon",       spellId=32235, itemId=25470, source="Vendor", location="Hellfire / Shadowmoon / SW", dropChance="Vendor (50 g)",  coords={mapId=465}, description="Basic 150 % flying mount." }, -- :contentReference[oaicite:0]{index=0}
    ["Ebon Gryphon"]         = { expansion="The Burning Crusade", name="Ebon Gryphon",         spellId=32239, itemId=25471, source="Vendor", location="Hellfire / Shadowmoon / SW", dropChance="Vendor (50 g)",  coords={mapId=465}, description="Basic 150 % flying mount." }, -- :contentReference[oaicite:1]{index=1}
    ["Snowy Gryphon"]        = { expansion="The Burning Crusade", name="Snowy Gryphon",        spellId=32240, itemId=25472, source="Vendor", location="Hellfire / Shadowmoon / SW", dropChance="Vendor (50 g)",  coords={mapId=465}, description="Basic 150 % flying mount." }, -- :contentReference[oaicite:2]{index=2}

    ["Swift Blue Gryphon"]   = { expansion="The Burning Crusade", name="Swift Blue Gryphon",   spellId=32242, itemId=25473, source="Vendor", location="Hellfire / Shadowmoon / SW", dropChance="Vendor (100 g)", coords={mapId=465}, description="Epic 280 % gryphon." }, -- :contentReference[oaicite:3]{index=3}
    ["Swift Red Gryphon"]    = { expansion="The Burning Crusade", name="Swift Red Gryphon",    spellId=32289, itemId=25527, source="Vendor", location="Hellfire / Shadowmoon / SW", dropChance="Vendor (100 g)", coords={mapId=465}, description="Epic 280 % gryphon." }, -- :contentReference[oaicite:4]{index=4}
    ["Swift Green Gryphon"]  = { expansion="The Burning Crusade", name="Swift Green Gryphon",  spellId=32290, itemId=25528, source="Vendor", location="Hellfire / Shadowmoon / SW", dropChance="Vendor (100 g)", coords={mapId=465}, description="Epic 280 % gryphon." }, -- :contentReference[oaicite:5]{index=5}
    ["Swift Purple Gryphon"] = { expansion="The Burning Crusade", name="Swift Purple Gryphon", spellId=32292, itemId=25529, source="Vendor", location="Hellfire / Shadowmoon / SW", dropChance="Vendor (100 g)", coords={mapId=465}, description="Epic 280 % gryphon." }, -- :contentReference[oaicite:6]{index=6}

    -------------------------------------------------
    -- HORDE – Wind Rider Keeper (Outland / Orgrimmar)
    -------------------------------------------------
    ["Tawny Wind Rider"]     = { expansion="The Burning Crusade", name="Tawny Wind Rider",     spellId=32243, itemId=25474, source="Vendor", location="Hellfire / Shadowmoon / Org", dropChance="Vendor (50 g)",  coords={mapId=465}, description="Basic 150 % flying mount." }, -- :contentReference[oaicite:7]{index=7}
    ["Blue Wind Rider"]      = { expansion="The Burning Crusade", name="Blue Wind Rider",      spellId=32244, itemId=25475, source="Vendor", location="Hellfire / Shadowmoon / Org", dropChance="Vendor (50 g)",  coords={mapId=465}, description="Basic 150 % flying mount." }, -- :contentReference[oaicite:8]{index=8}
    ["Green Wind Rider"]     = { expansion="The Burning Crusade", name="Green Wind Rider",     spellId=32245, itemId=25476, source="Vendor", location="Hellfire / Shadowmoon / Org", dropChance="Vendor (50 g)",  coords={mapId=465}, description="Basic 150 % flying mount." }, -- :contentReference[oaicite:9]{index=9}

    ["Swift Red Wind Rider"]   = { expansion="The Burning Crusade", name="Swift Red Wind Rider",   spellId=32246, itemId=25530, source="Vendor", location="Hellfire / Shadowmoon / Org", dropChance="Vendor (100 g)", coords={mapId=465}, description="Epic 280 % wind rider." }, -- :contentReference[oaicite:10]{index=10}
    ["Swift Green Wind Rider"] = { expansion="The Burning Crusade", name="Swift Green Wind Rider", spellId=32295, itemId=25531, source="Vendor", location="Hellfire / Shadowmoon / Org", dropChance="Vendor (100 g)", coords={mapId=465}, description="Epic 280 % wind rider." }, -- :contentReference[oaicite:11]{index=11}
    ["Swift Yellow Wind Rider"]= { expansion="The Burning Crusade", name="Swift Yellow Wind Rider",spellId=32296, itemId=25532, source="Vendor", location="Hellfire / Shadowmoon / Org", dropChance="Vendor (100 g)", coords={mapId=465}, description="Epic 280 % wind rider." }, -- :contentReference[oaicite:12]{index=12}
    ["Swift Purple Wind Rider"]= { expansion="The Burning Crusade", name="Swift Purple Wind Rider",spellId=32297, itemId=25533, source="Vendor", location="Hellfire / Shadowmoon / Org", dropChance="Vendor (100 g)", coords={mapId=465}, description="Epic 280 % wind rider." }, -- :contentReference[oaicite:13]{index=13}

    -------------------------------------------------
    -- NEUTRAL – Sha'tari Skyguard (Terokkar / Skettis)
    -------------------------------------------------
    ["Green Riding Nether Ray"]  = { expansion="The Burning Crusade", name="Green Riding Nether Ray",  spellId=39798, itemId=32314, source="Vendor", reputation="Sha'tari Skyguard – Exalted", location="Skettis, Terokkar", dropChance="Vendor (200 g)", description="Epic 280 % nether ray." }, -- :contentReference[oaicite:14]{index=14}
    ["Red Riding Nether Ray"]    = { expansion="The Burning Crusade", name="Red Riding Nether Ray",    spellId=39800, itemId=32317, source="Vendor", reputation="Sha'tari Skyguard – Exalted", location="Skettis, Terokkar", dropChance="Vendor (200 g)", description="Epic 280 % nether ray." }, -- :contentReference[oaicite:15]{index=15}
    ["Purple Riding Nether Ray"] = { expansion="The Burning Crusade", name="Purple Riding Nether Ray", spellId=39801, itemId=32316, source="Vendor", reputation="Sha'tari Skyguard – Exalted", location="Skettis, Terokkar", dropChance="Vendor (200 g)", description="Epic 280 % nether ray." }, -- :contentReference[oaicite:16]{index=16}
    ["Silver Riding Nether Ray"] = { expansion="The Burning Crusade", name="Silver Riding Nether Ray", spellId=39802, itemId=32318, source="Vendor", reputation="Sha'tari Skyguard – Exalted", location="Skettis, Terokkar", dropChance="Vendor (200 g)", description="Epic 280 % nether ray." }, -- :contentReference[oaicite:17]{index=17}
    ["Blue Riding Nether Ray"]   = { expansion="The Burning Crusade", name="Blue Riding Nether Ray",   spellId=39803, itemId=32319, source="Vendor", reputation="Sha'tari Skyguard – Exalted", location="Skettis, Terokkar", dropChance="Vendor (200 g)", description="Epic 280 % nether ray." }, -- :contentReference[oaicite:18]{index=18}

    -------------------------------------------------
    -- NEUTRAL – Netherwing (Shadowmoon Valley)
    -------------------------------------------------
    ["Azure Netherwing Drake"]   = { expansion="The Burning Crusade", name="Azure Netherwing Drake",   spellId=41514, itemId=32858, source="Vendor", reputation="Netherwing – Exalted", location="Netherwing Ledge", dropChance="Vendor (200 g)", description="Epic 280 % drake." }, -- :contentReference[oaicite:19]{index=19}
    ["Cobalt Netherwing Drake"]  = { expansion="The Burning Crusade", name="Cobalt Netherwing Drake",  spellId=41515, itemId=32857, source="Vendor", reputation="Netherwing – Exalted", location="Netherwing Ledge", dropChance="Vendor (200 g)", description="Epic 280 % drake." },
    ["Onyx Netherwing Drake"]    = { expansion="The Burning Crusade", name="Onyx Netherwing Drake",    spellId=41516, itemId=32859, source="Vendor", reputation="Netherwing – Exalted", location="Netherwing Ledge", dropChance="Vendor (200 g)", description="Epic 280 % drake." },
    ["Purple Netherwing Drake"]  = { expansion="The Burning Crusade", name="Purple Netherwing Drake",  spellId=41517, itemId=32860, source="Vendor", reputation="Netherwing – Exalted", location="Netherwing Ledge", dropChance="Vendor (200 g)", description="Epic 280 % drake." },
    ["Veridian Netherwing Drake"]= { expansion="The Burning Crusade", name="Veridian Netherwing Drake",spellId=41518, itemId=32861, source="Vendor", reputation="Netherwing – Exalted", location="Netherwing Ledge", dropChance="Vendor (200 g)", description="Epic 280 % drake." },
    ["Violet Netherwing Drake"]  = { expansion="The Burning Crusade", name="Violet Netherwing Drake",  spellId=41519, itemId=32862, source="Vendor", reputation="Netherwing – Exalted", location="Netherwing Ledge", dropChance="Vendor (200 g)", description="Epic 280 % drake." },

    -------------------------------------------------
    -- NEUTRAL – Cenarion Expedition (Zangarmarsh)
    -------------------------------------------------
    ["Cenarion War Hippogryph"] = { expansion="The Burning Crusade", name="Cenarion War Hippogryph", spellId=43927, itemId=33999, source="Vendor", reputation="Cenarion Expedition – Exalted", location="Zangarmarsh", dropChance="Vendor (1600 g)", description="First-ever hippogryph mount." }, -- :contentReference[oaicite:20]{index=20}

    -------------------------------------------------
    -- ALL FACTIONS – Kurenai / Mag'har (Nagrand)
    -------------------------------------------------
    ["White War Talbuk"]  = { expansion="The Burning Crusade", name="White War Talbuk",  spellId=34897, itemId=29231, source="Vendor", reputation="Kurenai / Mag'har – Exalted", location="Nagrand", dropChance="Vendor (100 g)", description="Epic ground talbuk." }, -- :contentReference[oaicite:21]{index=21}
    ["Tan War Talbuk"]    = { expansion="The Burning Crusade", name="Tan War Talbuk",    spellId=34899, itemId=29229, source="Vendor", reputation="Kurenai / Mag'har – Exalted", location="Nagrand", dropChance="Vendor (100 g)", description="Epic ground talbuk." }, -- :contentReference[oaicite:22]{index=22}
    ["Silver War Talbuk"] = { expansion="The Burning Crusade", name="Silver War Talbuk", spellId=34898, itemId=29230, source="Vendor", reputation="Kurenai / Mag'har – Exalted", location="Nagrand", dropChance="Vendor (100 g)", description="Epic ground talbuk." }, -- :contentReference[oaicite:23]{index=23}
    ["Cobalt War Talbuk"] = { expansion="The Burning Crusade", name="Cobalt War Talbuk", spellId=34896, itemId=31830, source="Vendor", reputation="Kurenai / Mag'har – Exalted", location="Nagrand", dropChance="Vendor (100 g)", description="Epic ground talbuk." }, -- :contentReference[oaicite:24]{index=24}

    -------------------------------------------------
    -- HALAA PVP – Nagrand (World PvP Tokens)
    -------------------------------------------------
    ["Dark Riding Talbuk"] = { expansion="The Burning Crusade", name="Dark Riding Talbuk", spellId=39316, itemId=28915, source="Vendor", reputation="Halaa – Battle + Research Tokens", location="Nagrand", dropChance="Vendor (70 Battle, 15 Research)", description="Ground talbuk (150 %)." }, -- :contentReference[oaicite:25]{index=25}
    ["Dark War Talbuk"]   = { expansion="The Burning Crusade", name="Dark War Talbuk",   spellId=34790, itemId=29228, source="Vendor", reputation="Halaa – Battle + Research Tokens", location="Nagrand", dropChance="Vendor (100 Battle, 20 Research)", description="Epic ground talbuk." }, -- :contentReference[oaicite:26]{index=26}

    -------------------------------------------------
    -- DRAENEI – Exodar Elekks
    -------------------------------------------------
    ["Brown Elekk"]  = { expansion="The Burning Crusade", name="Brown Elekk",  spellId=34406, itemId=28481, source="Vendor", location="Azuremyst Isle", dropChance="Vendor (1 g)",   coords={mapId=97}, description="60 % ground elekk." },
    ["Gray Elekk"]   = { expansion="The Burning Crusade", name="Gray Elekk",   spellId=35710, itemId=29743, source="Vendor", location="Azuremyst Isle", dropChance="Vendor (1 g)",   coords={mapId=97}, description="60 % ground elekk." },
    ["Purple Elekk"] = { expansion="The Burning Crusade", name="Purple Elekk", spellId=35711, itemId=29744, source="Vendor", location="Azuremyst Isle", dropChance="Vendor (1 g)",   coords={mapId=97}, description="60 % ground elekk." },
    ["Great Blue Elekk"]  = { expansion="The Burning Crusade", name="Great Blue Elekk",  spellId=35713, itemId=29746, source="Vendor", location="Azuremyst Isle", dropChance="Vendor (100 g)", coords={mapId=97}, description="Epic ground elekk." }, -- :contentReference[oaicite:27]{index=27}
    ["Great Green Elekk"] = { expansion="The Burning Crusade", name="Great Green Elekk", spellId=35712, itemId=29745, source="Vendor", location="Azuremyst Isle", dropChance="Vendor (100 g)", coords={mapId=97}, description="Epic ground elekk." }, -- :contentReference[oaicite:28]{index=28}
    ["Great Purple Elekk"]= { expansion="The Burning Crusade", name="Great Purple Elekk",spellId=35714, itemId=29747, source="Vendor", location="Azuremyst Isle", dropChance="Vendor (100 g)", coords={mapId=97}, description="Epic ground elekk." },

    -------------------------------------------------
    -- BLOOD ELF – Silvermoon Hawkstriders
    -------------------------------------------------
    ["Blue Hawkstrider"]      = { expansion="The Burning Crusade", name="Blue Hawkstrider",      spellId=35020, itemId=29220, source="Vendor", location="Eversong / Silvermoon", dropChance="Vendor (1 g)",   coords={mapId=94}, description="60 % ground hawkstrider." }, -- :contentReference[oaicite:29]{index=29}
    ["Purple Hawkstrider"]    = { expansion="The Burning Crusade", name="Purple Hawkstrider",    spellId=35018, itemId=29221, source="Vendor", location="Eversong / Silvermoon", dropChance="Vendor (1 g)",   coords={mapId=94}, description="60 % ground hawkstrider." },
    ["Red Hawkstrider"]       = { expansion="The Burning Crusade", name="Red Hawkstrider",       spellId=34795, itemId=28936, source="Vendor", location="Eversong / Silvermoon", dropChance="Vendor (1 g)",   coords={mapId=94}, description="60 % ground hawkstrider." },
    ["Black Hawkstrider"]     = { expansion="The Burning Crusade", name="Black Hawkstrider",     spellId=35022, itemId=29222, source="Vendor", location="Eversong / Silvermoon", dropChance="Vendor (1 g)",   coords={mapId=94}, description="60 % ground hawkstrider." },

    ["Swift Green Hawkstrider"]  = { expansion="The Burning Crusade", name="Swift Green Hawkstrider",  spellId=35025, itemId=29102, source="Vendor", location="Eversong / Silvermoon", dropChance="Vendor (100 g)", coords={mapId=94}, description="Epic ground hawkstrider." },
    ["Swift Purple Hawkstrider"] = { expansion="The Burning Crusade", name="Swift Purple Hawkstrider", spellId=35027, itemId=29103, source="Vendor", location="Eversong / Silvermoon", dropChance="Vendor (100 g)", coords={mapId=94}, description="Epic ground hawkstrider." },
    ["Swift Pink Hawkstrider"]   = { expansion="The Burning Crusade", name="Swift Pink Hawkstrider",   spellId=33660, itemId=29224, source="Vendor", location="Eversong / Silvermoon", dropChance="Vendor (100 g)", coords={mapId=94}, description="Epic ground hawkstrider." }, -- :contentReference[oaicite:30]{index=30}
    ["Swift Warstrider"]         = { expansion="The Burning Crusade", name="Swift Warstrider",         spellId=35028, itemId=28907, source="Vendor", location="Eversong / Silvermoon", dropChance="Vendor (100 g)", coords={mapId=94}, description="Epic ground hawkstrider." },

    ---------------------------------------------------------------------------
    -- WRATH OF THE LICH KING (2008) – VENDOR & RÉPUTATION
    ---------------------------------------------------------------------------

    -------------------------------------------------
    -- Dalaran (Mei Francis)
    -------------------------------------------------
    ["Armored Brown Bear"] = {
        expansion   = "Wrath of the Lich King",
        name        = "Armored Brown Bear",
        spellId     = 60114,
        itemId      = 44225,
        source      = "Vendor",
        location    = "Dalaran (Magical Menagerie)",
        dropChance  = "Vendor (750 g – Kirin Tor discount)",
        coords      = { mapId = 125 },
        description = "Epic 100 % ground mount sold by Mei Francis.",    
    }, -- :contentReference[oaicite:0]{index=0}

    ["Wooly Mammoth (Alliance)"] = {
        expansion = "Wrath of the Lich King",
        name      = "Wooly Mammoth",
        spellId   = 60116,
        itemId    = 44226,
        source    = "Vendor",
        location  = "Dalaran (Magical Menagerie)",
        dropChance= "Vendor (10 000 g – Kirin Tor discount)",
        coords    = { mapId = 125 },
        description = "Alliance-coloured 100 % ground mammoth.",    
    }, -- :contentReference[oaicite:1]{index=1}

    ["Wooly Mammoth (Horde)"] = {
        expansion = "Wrath of the Lich King",
        name      = "Wooly Mammoth",
        spellId   = 61229,        -- variante Horde
        itemId    = 44230,
        source    = "Vendor",
        location  = "Dalaran (Magical Menagerie)",
        dropChance= "Vendor (10 000 g – Kirin Tor discount)",
        coords    = { mapId = 125 },
        description = "Horde-trim version of the Wooly Mammoth.",    
    }, -- :contentReference[oaicite:2]{index=2}

    ["Traveler's Tundra Mammoth"] = {
        expansion = "Wrath of the Lich King",
        name      = "Traveler's Tundra Mammoth",
        spellId   = 61447,
        itemId    = 44234,
        source    = "Vendor",
        location  = "Dalaran (Magical Menagerie)",
        dropChance= "Vendor (20 000 g – Kirin Tor discount)",
        coords    = { mapId = 125 },
        description = "Three-passenger vendor mount (repair + marchand).",
    }, -- :contentReference[oaicite:3]{index=3}

    -------------------------------------------------
    -- Sons of Hodir (Storm Peaks)
    -------------------------------------------------
    ["Ice Mammoth"] = {
        expansion  = "Wrath of the Lich King",
        name       = "Ice Mammoth",
        spellId    = 59785,
        itemId     = 43961,
        source     = "Vendor",
        reputation = "Sons of Hodir – Revered",
        location   = "Dun Niffelem, Storm Peaks",
        dropChance = "Vendor (1 000 g)",
        coords     = { mapId = 495 },
        description= "Passenger-less version, 100 % ground.",
    }, -- :contentReference[oaicite:4]{index=4}

    ["Grand Ice Mammoth"] = {
        expansion  = "Wrath of the Lich King",
        name       = "Grand Ice Mammoth",
        spellId    = 59799,
        itemId     = 43962,
        source     = "Vendor",
        reputation = "Sons of Hodir – Exalted",
        location   = "Dun Niffelem, Storm Peaks",
        dropChance = "Vendor (10 000 g)",
        coords     = { mapId = 495 },
        description= "Three-seat passenger mammoth (sans vendeurs).",
    }, -- :contentReference[oaicite:5]{index=5}

    -------------------------------------------------
    -- Wyrmrest Accord (Dragonblight)
    -------------------------------------------------
    ["Red Drake"] = {
        expansion  = "Wrath of the Lich King",
        name       = "Red Drake",
        spellId    = 59570,
        itemId     = 43955,
        source     = "Vendor",
        reputation = "Wyrmrest Accord – Exalted",
        location   = "Wyrmrest Temple, Dragonblight",
        dropChance = "Vendor (1 600 g)",
        coords     = { mapId = 488 },
        description= "280 % flying drake sold by Cielstrasza.",
    }, -- :contentReference[oaicite:6]{index=6}

    -------------------------------------------------
    -- Argent Tournament (Icecrown)
    -------------------------------------------------
    ["Argent Hippogryph"] = {
        expansion  = "Wrath of the Lich King",
        name       = "Argent Hippogryph",
        spellId    = 63844,
        itemId     = 45725,
        source     = "Vendor",
        location   = "Argent Tournament, Icecrown",
        dropChance = "Vendor (150 Champion's Seals)",
        coords     = { mapId = 492 },
        description= "Account-wide 280 % flying hippogryph.",
    }, -- :contentReference[oaicite:7]{index=7}

    -- Les montures « miroir de faction » (Swift Gray Steed, Swift Red Hawkstrider, etc.)
    -- réutilisent les mêmes itemId/spellId que leurs variantes Classic déjà
    -- dans ta base ; elles n’ont donc pas besoin d’entrées séparées ici.

    -------------------------------------------------
    -- Wintergrasp (JcJ)
    -------------------------------------------------
    ["Black War Mammoth"] = {
        expansion  = "Wrath of the Lich King",
        name       = "Black War Mammoth",
        spellId    = 59788,
        itemId     = 43956,
        source     = "Vendor",
        location   = "Wintergrasp Fortress",
        dropChance = "15 Marks of Honor (contrôle de la forteresse)",
        coords     = { mapId = 501 },
        description= "PvP mammoth, 100 % ground.",
    }, -- :contentReference[oaicite:8]{index=8}

    ---------------------------------------------------------------------------
    -- CATACLYSM (2010) – VENDOR & RÉPUTATION
    ---------------------------------------------------------------------------

    ["Brown Riding Camel"] = {               -- Ramkahen (Exalté)
        expansion   = "Cataclysm",
        name        = "Brown Riding Camel",
        spellId     = 88748,
        itemId      = 63044,
        source      = "Vendor",
        reputation  = "Ramkahen – Exalted",
        location    = "Uldum",
        dropChance  = "Vendor (80 g)",
        description = "Sold by Blacksmith Abasi once you reach Exalted with Ramkahen.",
    }, -- :contentReference[oaicite:0]{index=0}

    ["Tan Riding Camel"] = {                 -- Ramkahen (Exalté)
        expansion = "Cataclysm", name = "Tan Riding Camel",
        spellId   = 88749, itemId = 63045,
        source    = "Vendor", reputation = "Ramkahen – Exalted",
        location  = "Uldum", dropChance = "Vendor (80 g)",
        description = "Second colour variant from Blacksmith Abasi.",
    }, -- :contentReference[oaicite:1]{index=1}

    ["Drake of the West Wind"] = {           -- Tol Barad (Exalté + 200 Commendations)
        expansion = "Cataclysm", name = "Drake of the West Wind",
        spellId   = 88741, itemId = 65356,
        source    = "Vendor",
        reputation= "Baradin's Wardens / Hellscream's Reach – Exalted",
        location  = "Tol Barad Peninsula",
        dropChance= "Vendor (200 Tol Barad Commendations)",
        description= "Purchased from Brazie (Alliance) or Pogg (Horde) after the long Tol Barad grind.",
    }, -- :contentReference[oaicite:2]{index=2}

    ["Spectral Steed"] = {                   -- Tol Barad (Alliance)
        expansion = "Cataclysm", name = "Spectral Steed",
        spellId   = 92231, itemId = 64998,
        source    = "Vendor",
        reputation= "Baradin's Wardens – Exalted",
        location  = "Tol Barad Peninsula",
        dropChance= "Vendor (165 Tol Barad Commendations)",
        description= "Alliance-only ghost horse sold by Quartermaster Brazie.",
    }, -- :contentReference[oaicite:3]{index=3}

    ["Spectral Wolf"] = {                    -- Tol Barad (Horde)
        expansion = "Cataclysm", name = "Spectral Wolf",
        spellId   = 92232, itemId = 64999,
        source    = "Vendor",
        reputation= "Hellscream's Reach – Exalted",
        location  = "Tol Barad Peninsula",
        dropChance= "Vendor (165 Tol Barad Commendations)",
        description= "Horde-only ghost wolf sold by Pogg.",
    }, -- :contentReference[oaicite:4]{index=4}

    ["Golden King"] = {                      -- Monture de guilde (Alliance)
        expansion = "Cataclysm", name = "Golden King",
        spellId   = 90621, itemId = 62298,
        source    = "Vendor",
        reputation= "Guild – Exalted",
        location  = "Stormwind / toutes capitales Alliance",
        dropChance= "Vendor (3 000 g, après niveau 25 de guilde)",
        description= "Alliance guild lion mount unlocked at guild level 25.",
    }, -- :contentReference[oaicite:5]{index=5}

    ["Kor'kron Annihilator"] = {             -- Monture de guilde (Horde)
        expansion = "Cataclysm", name = "Kor'kron Annihilator",
        spellId   = 93644, itemId = 62286,
        source    = "Vendor",
        reputation= "Guild – Exalted",
        location  = "Orgrimmar / capitales Horde",
        dropChance= "Vendor (3 000 g, après niveau 25 de guilde)",
        description= "Horde scorpion mount unlocked at guild level 25.",
    }, -- :contentReference[oaicite:6]{index=6}

    ["Dark Phoenix"] = {                     -- Monture de guilde (vol 310 %)
        expansion = "Cataclysm", name = "Dark Phoenix",
        spellId   = 88990, itemId = 63128,
        source    = "Vendor",
        reputation= "Guild – Exalted",
        location  = "Toutes capitales",
        dropChance= "Vendor (2 000 g, après succès « Guilde – Gloire du Cataclysm Raider »)",
        description= "310 % flying phoenix available from guild vendor once the Cataclysm raid meta is complete.",
    }, -- :contentReference[oaicite:7]{index=7}

    ---------------------------------------------------------------------------
    -- MISTS OF PANDARIA (2012) – VENDOR & RÉPUTATION
    ---------------------------------------------------------------------------

    -------------------------------------------------
    -- Order of the Cloud Serpent (Jade Forest)
    -------------------------------------------------
    ["Golden Cloud Serpent"] = {
        expansion   = "Mists of Pandaria",
        name        = "Golden Cloud Serpent",
        spellId     = 123993,
        itemId      = 85429,
        source      = "Vendor / Quest",
        reputation  = "Order of the Cloud Serpent – Exalted",
        location    = "The Arboretum, Jade Forest",
        dropChance  = "Vendor (3 000 g) ou quête « Riding the Skies »",
        description = "One of three colour variants sold by San Redscale after training your own serpent.",
    }, -- :contentReference[oaicite:8]{index=8}

    ["Azure Cloud Serpent"] = {
        expansion="Mists of Pandaria", name="Azure Cloud Serpent",
        spellId = 123992, itemId = 85430,
        source  = "Vendor / Quest", reputation = "Order of the Cloud Serpent – Exalted",
        location= "The Arboretum, Jade Forest",
        dropChance = "Vendor (3 000 g) ou quête « Riding the Skies »",
        description = "Blue variant of the Cloud Serpent family.",
    }, -- :contentReference[oaicite:9]{index=9}

    ["Jade Cloud Serpent"] = {
        expansion="Mists of Pandaria", name="Jade Cloud Serpent",
        spellId = 124089, itemId = 79802,
        source  = "Vendor / Quest", reputation = "Order of the Cloud Serpent – Exalted",
        location= "The Arboretum, Jade Forest",
        dropChance = "Vendor (3 000 g) ou quête « Riding the Skies »",
        description = "Green variant available from the same quartermaster.",
    }, -- :contentReference[oaicite:10]{index=10}

    -------------------------------------------------
    -- August Celestials (Shrines – Vale of Eternal Blossoms)
    -------------------------------------------------
    ["Thundering August Cloud Serpent"] = {
        expansion="Mists of Pandaria", name="Thundering August Cloud Serpent",
        spellId = 129918, itemId = 89362,
        source  = "Vendor",
        reputation = "August Celestials – Exalted",
        location = "Shrine of Seven Stars / Two Moons",
        dropChance = "Vendor (10 000 g)",
        description = "Electric-blue serpent unlocked at Exalted with the August Celestials.",
    }, -- :contentReference[oaicite:11]{index=11}

    -------------------------------------------------
    -- The Anglers (Krasarang Wilds)
    -------------------------------------------------
    ["Azure Water Strider"] = {
        expansion="Mists of Pandaria", name="Azure Water Strider",
        spellId = 124408,
        itemId  = 81354,
        source  = "Vendor",
        reputation = "The Anglers – Exalted",
        location = "Krasarang Wilds",
        dropChance = "Vendor (5 000 g)",
        description = "Water-walking strider sold by Nat Pagle – once a must-have for gatherers.",
    }, -- :contentReference[oaicite:12]{index=12}

    -------------------------------------------------
    -- Shado-Pan (Townlong Steppes)
    -------------------------------------------------
    ["Blue Shado-Pan Riding Tiger"] = {
        expansion="Mists of Pandaria", name="Blue Shado-Pan Riding Tiger",
        spellId = 129934, itemId = 89307,
        source  = "Vendor",
        reputation = "Shado-Pan – Exalted",
        location = "Rushi the Fox, Townlong Steppes",
        dropChance = "Vendor (500 g)",
        description = "Armoured tiger mount – blue version.",
    }, -- :contentReference[oaicite:13]{index=13}

    ["Green Shado-Pan Riding Tiger"] = {
        expansion="Mists of Pandaria", name="Green Shado-Pan Riding Tiger",
        spellId = 129932, itemId = 89305,
        source  = "Vendor",
        reputation = "Shado-Pan – Exalted",
        location = "Rushi the Fox, Townlong Steppes",
        dropChance = "Vendor (500 g)",
        description = "Green variant from the same quartermaster.",
    }, -- :contentReference[oaicite:14]{index=14}

    ["Red Shado-Pan Riding Tiger"] = {
        expansion="Mists of Pandaria", name="Red Shado-Pan Riding Tiger",
        spellId = 129935, itemId = 89306,
        source  = "Vendor",
        reputation = "Shado-Pan – Exalted",
        location = "Rushi the Fox, Townlong Steppes",
        dropChance = "Vendor (2 500 g)",
        description = "Red variant – the most expensive of the three tigers.",
    }, -- :contentReference[oaicite:15]{index=15}

    -------------------------------------------------
    -- Tillers (Valley of the Four Winds)
    -------------------------------------------------
    ["Brown Riding Goat"] = {
        expansion="Mists of Pandaria", name="Brown Riding Goat",
        spellId = 130086, itemId = 89362,
        source  = "Vendor",
        reputation = "The Tillers – Exalted",
        location = "Halfhill Market, Valley of the Four Winds",
        dropChance = "Vendor (500 g)",
        description = "Quirky goat mount sold by Gina Mudclaw once you befriend the Tillers.",
    }, -- :contentReference[oaicite:16]{index=16}

    -------------------------------------------------
    -- Kun-Lai Summit (Neutral – Grummles)
    -------------------------------------------------
    ["Grand Expedition Yak"] = {
        expansion="Mists of Pandaria", name="Grand Expedition Yak",
        spellId = 122708, itemId = 84101,
        source  = "Vendor",
        location = "Grummle Bazaar, Kun-Lai Summit",
        dropChance = "Vendor (120 000 g)",
        description = "Three-seat yak with repair & transmog NPCs – ultimate traveller’s mount.",
    }, -- :contentReference[oaicite:17]{index=17}

    ---------------------------------------------------------------------------
    -- CATACLYSM (2010) – VENDOR & RÉPUTATION
    ---------------------------------------------------------------------------

    ["Brown Riding Camel"] = {               -- Ramkahen (Exalté)
        expansion   = "Cataclysm",
        name        = "Brown Riding Camel",
        spellId     = 88748,
        itemId      = 63044,
        source      = "Vendor",
        reputation  = "Ramkahen – Exalted",
        location    = "Uldum",
        dropChance  = "Vendor (80 g)",
        description = "Sold by Blacksmith Abasi once you reach Exalted with Ramkahen.",
    }, -- :contentReference[oaicite:0]{index=0}

    ["Tan Riding Camel"] = {                 -- Ramkahen (Exalté)
        expansion = "Cataclysm", name = "Tan Riding Camel",
        spellId   = 88749, itemId = 63045,
        source    = "Vendor", reputation = "Ramkahen – Exalted",
        location  = "Uldum", dropChance = "Vendor (80 g)",
        description = "Second colour variant from Blacksmith Abasi.",
    }, -- :contentReference[oaicite:1]{index=1}

    ["Drake of the West Wind"] = {           -- Tol Barad (Exalté + 200 Commendations)
        expansion = "Cataclysm", name = "Drake of the West Wind",
        spellId   = 88741, itemId = 65356,
        source    = "Vendor",
        reputation= "Baradin's Wardens / Hellscream's Reach – Exalted",
        location  = "Tol Barad Peninsula",
        dropChance= "Vendor (200 Tol Barad Commendations)",
        description= "Purchased from Brazie (Alliance) or Pogg (Horde) after the long Tol Barad grind.",
    }, -- :contentReference[oaicite:2]{index=2}

    ["Spectral Steed"] = {                   -- Tol Barad (Alliance)
        expansion = "Cataclysm", name = "Spectral Steed",
        spellId   = 92231, itemId = 64998,
        source    = "Vendor",
        reputation= "Baradin's Wardens – Exalted",
        location  = "Tol Barad Peninsula",
        dropChance= "Vendor (165 Tol Barad Commendations)",
        description= "Alliance-only ghost horse sold by Quartermaster Brazie.",
    }, -- :contentReference[oaicite:3]{index=3}

    ["Spectral Wolf"] = {                    -- Tol Barad (Horde)
        expansion = "Cataclysm", name = "Spectral Wolf",
        spellId   = 92232, itemId = 64999,
        source    = "Vendor",
        reputation= "Hellscream's Reach – Exalted",
        location  = "Tol Barad Peninsula",
        dropChance= "Vendor (165 Tol Barad Commendations)",
        description= "Horde-only ghost wolf sold by Pogg.",
    }, -- :contentReference[oaicite:4]{index=4}

    ["Golden King"] = {                      -- Monture de guilde (Alliance)
        expansion = "Cataclysm", name = "Golden King",
        spellId   = 90621, itemId = 62298,
        source    = "Vendor",
        reputation= "Guild – Exalted",
        location  = "Stormwind / toutes capitales Alliance",
        dropChance= "Vendor (3 000 g, après niveau 25 de guilde)",
        description= "Alliance guild lion mount unlocked at guild level 25.",
    }, -- :contentReference[oaicite:5]{index=5}

    ["Kor'kron Annihilator"] = {             -- Monture de guilde (Horde)
        expansion = "Cataclysm", name = "Kor'kron Annihilator",
        spellId   = 93644, itemId = 62286,
        source    = "Vendor",
        reputation= "Guild – Exalted",
        location  = "Orgrimmar / capitales Horde",
        dropChance= "Vendor (3 000 g, après niveau 25 de guilde)",
        description= "Horde scorpion mount unlocked at guild level 25.",
    }, -- :contentReference[oaicite:6]{index=6}

    ["Dark Phoenix"] = {                     -- Monture de guilde (vol 310 %)
        expansion = "Cataclysm", name = "Dark Phoenix",
        spellId   = 88990, itemId = 63128,
        source    = "Vendor",
        reputation= "Guild – Exalted",
        location  = "Toutes capitales",
        dropChance= "Vendor (2 000 g, après succès « Guilde – Gloire du Cataclysm Raider »)",
        description= "310 % flying phoenix available from guild vendor once the Cataclysm raid meta is complete.",
    }, -- :contentReference[oaicite:7]{index=7}

    ---------------------------------------------------------------------------
    -- CATACLYSM (2010) – MOUNTS DROPPABLES
    ---------------------------------------------------------------------------

    ["Reins of the Drake of the North Wind"] = {
        expansion = "Cataclysm",
        name      = "Reins of the Drake of the North Wind",
        spellId   = 88718,
        itemId    = 63040,
        source    = "Boss",
        boss      = "Altairus",
        location  = "The Vortex Pinnacle",
        difficulty= "Heroic (Lvl 85)",
        dropChance= "≈0.8%",
        blackMarket = true,
        description = "Dropped by Altairus at the top of Vortex Pinnacle (Uldum)."
    },

    ["Reins of the Vitreous Stone Drake"] = {
        expansion = "Cataclysm",
        name      = "Reins of the Vitreous Stone Drake",
        spellId   = 88962,
        itemId    = 63043,
        source    = "Boss",
        boss      = "Slabhide",
        location  = "The Stonecore",
        difficulty= "Heroic",
        dropChance= "≈0.8%",
        blackMarket = true,
        description = "Dropped by Slabhide in Deepholm’s Stonecore."
    },

    ["Reins of the Phosphorescent Stone Drake"] = {
        expansion = "Cataclysm",
        name      = "Reins of the Phosphorescent Stone Drake",
        spellId   = 96491,
        itemId    = 63047,
        source    = "World Rare",
        boss      = "Aeonaxx",
        location  = "Deepholm",
        dropChance= "Very rare",
        description = "Drops from the rare spawn Aeonaxx flying around Deepholm."
    },

    ["Reins of the Drake of the South Wind"] = {
        expansion = "Cataclysm",
        name      = "Reins of the Drake of the South Wind",
        spellId   = 88954,
        itemId    = 63041,
        source    = "Boss",
        boss      = "Al'Akir",
        location  = "Throne of the Four Winds",
        difficulty= "Any",
        dropChance= "≈1%",
        blackMarket = true,
        description = "Drops from Al'Akir in the Throne of the Four Winds (Uldum)."
    },

    ["Smoldering Egg of Millagazor"] = {
        expansion = "Cataclysm",
        name      = "Smoldering Egg of Millagazor",
        spellId   = 101542,
        itemId    = 69224,
        source    = "Boss",
        boss      = "Ragnaros",
        location  = "Firelands",
        difficulty= "Heroic-only",
        dropChance= "≈1–2%",
        blackMarket = true,
        description = "Heroic Ragnaros drop (Firelands, Hyjal)."
    },

    ["Flametalon of Alysrazor"] = {
        expansion = "Cataclysm",
        name      = "Flametalon of Alysrazor",
        spellId   = 101573,
        itemId    = 69213,
        source    = "Boss",
        boss      = "Alysrazor",
        location  = "Firelands",
        difficulty= "Any",
        dropChance= "≈2%",
        blackMarket = true,
        description = "Drops from Alysrazor inside Firelands."
    },

    ["Experiment 12-B"] = {
        expansion = "Cataclysm",
        name      = "Experiment 12-B",
        spellId   = 102533,
        itemId    = 78919,
        source    = "Boss",
        boss      = "Ultraxion",
        location  = "Dragon Soul",
        difficulty= "10/25 – N & H",
        dropChance= "≈2%",
        blackMarket = true,
        description = "Drops from Ultraxion (Dragon Soul, Caverns of Time)."
    },

    ["Reins of the Blazing Drake"] = {
        expansion = "Cataclysm",
        name      = "Reins of the Blazing Drake",
        spellId   = 107842,
        itemId    = 77067,
        source    = "Boss",
        boss      = "Madness of Deathwing",
        location  = "Dragon Soul",
        difficulty= "Any",
        dropChance= "≈1–2%",
        blackMarket = true,
        description = "Normal-mode drop from Madness of Deathwing."
    },

    ["Life-Binder's Handmaiden"] = {
        expansion = "Cataclysm",
        name      = "Life-Binder's Handmaiden",
        spellId   = 102480,
        itemId    = 77069,
        source    = "Boss",
        boss      = "Madness of Deathwing",
        location  = "Dragon Soul",
        difficulty= "25 Héroïque",
        dropChance= "≈1%",
        blackMarket = true,
        description = "Heroic-only drop, 100 % until MoP puis ≈1 %."
    },
    ---------------------------------------------------------------------------
    -- MISTS OF PANDARIA (2012) – MOUNTS DROPPABLES
    ---------------------------------------------------------------------------

    ["Son of Galleon's Saddle"] = {
        expansion = "Mists of Pandaria",
        name      = "Son of Galleon",
        spellId   = 130965,
        itemId    = 89783,
        source    = "World Boss",
        boss      = "Galleon",
        location  = "Valley of the Four Winds",
        difficulty= "Any",
        dropChance= "≈0.1 %",
        blackMarket = true,
        description = "Drops from the world-boss Galleon (respawn ≈15 min)."
    },

    ["Reins of the Thundering Onyx Cloud Serpent"] = {
        expansion = "Mists of Pandaria",
        name      = "Heavenly Onyx Cloud Serpent",
        spellId   = 132036,
        itemId    = 87771,
        source    = "World Boss",
        boss      = "Sha of Anger",
        location  = "Kun-Lai Summit",
        dropChance= "≈0.01 %",
        blackMarket = true,
        description = "Ultra-rare Sha of Anger drop."
    },

    ["Reins of the Thundering Cobalt Cloud Serpent"] = {
        expansion = "Mists of Pandaria",
        name      = "Thundering Cobalt Cloud Serpent",
        spellId   = 139407,
        itemId    = 95057,
        source    = "World Boss",
        boss      = "Nalak",
        location  = "Isle of Thunder",
        dropChance= "≈0.05 %",
        description = "Drops from Nalak (one roll / semaine)."
    },

    ["Reins of the Thundering Ruby Cloud Serpent"] = {
        expansion = "Mists of Pandaria",
        name      = "Thundering Ruby Cloud Serpent",
        spellId   = 123886,
        itemId    = 90655,
        source    = "Outdoor Rare",
        boss      = "Alani (Vale)",
        location  = "Vale of Eternal Blossoms",
        dropChance= "100 % (nécessite 10 clés Cristal)",
        description = "Guaranteed after shattering Alani’s shield with 10 Skyshards."
    },

    ["Reins of the Astral Cloud Serpent"] = {
        expansion = "Mists of Pandaria",
        name      = "Astral Cloud Serpent",
        spellId   = 127174,
        itemId    = 87777,
        source    = "Boss",
        boss      = "Elegon",
        location  = "Mogu'shan Vaults",
        difficulty= "Any",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Drops from Elegon (first MoP raid tier)."
    },

    ["Clutch of Ji-Kun"] = {
        expansion = "Mists of Pandaria",
        name      = "Clutch of Ji-Kun",
        spellId   = 138424,
        itemId    = 95059,
        source    = "Boss",
        boss      = "Ji-Kun",
        location  = "Throne of Thunder",
        difficulty= "Any",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Drops from Ji-Kun in ToT (Isle of Thunder)."
    },

    ["Spawn of Horridon"] = {
        expansion = "Mists of Pandaria",
        name      = "Spawn of Horridon",
        spellId   = 136471,
        itemId    = 93666,
        source    = "Boss",
        boss      = "Horridon",
        location  = "Throne of Thunder",
        difficulty= "Any",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Drops from Horridon (second boss, ToT)."
    },

    ["Kor'kron Juggernaut"] = {
        expansion = "Mists of Pandaria",
        name      = "Kor'kron Juggernaut",
        spellId   = 148392,
        itemId    = 104253,
        source    = "Boss",
        boss      = "Garrosh Hellscream",
        location  = "Siege of Orgrimmar",
        difficulty= "Mythic (ex-Héroïque)",
        dropChance= "≈1 %",
        description = "Drops from Mythic Garrosh (100 % avant WoD 6.0)."
    },

    ["Reins of the Cobalt Primordial Direhorn"] = {
        expansion = "Mists of Pandaria",
        name      = "Cobalt Primordial Direhorn",
        spellId   = 138640,
        itemId    = 94228,
        source    = "World Boss",
        boss      = "Oondasta",
        location  = "Isle of Giants",
        dropChance= "≈1 %",
        description = "Drops from Oondasta (semaine reset)."
    },

    ["Reins of the Slate Primordial Direhorn"] = {
        expansion = "Mists of Pandaria",
        name      = "Slate Primordial Direhorn",
        spellId   = 138642,
        itemId    = 94230,
        source    = "Rare (Zandalari Warbringer)",
        location  = "Pandaria Zones",
        dropChance= "≈5 %",
        description = "From the grey Zandalari Warbringer (mount colour depends on spawn)."
    },

    ["Reins of the Amber Primordial Direhorn"] = {
        expansion = "Mists of Pandaria",
        name      = "Amber Primordial Direhorn",
        spellId   = 138641,
        itemId    = 94229,
        source    = "Rare (Zandalari Warbringer)",
        location  = "Pandaria Zones",
        dropChance= "≈5 %",
        description = "Orange-hued direhorn from the same Warbringer spawn rotation."
    },
    ---------------------------------------------------------------------------
    -- CLASSIC (2004-2006) – MOUNTS DROPPABLES
    ---------------------------------------------------------------------------

    ["Swift Zulian Tiger"] = {
        expansion = "Classic",
        name      = "Swift Zulian Tiger",
        spellId   = 24242,
        itemId    = 19902,
        source    = "Boss",
        boss      = "High Priest Thekal",
        location  = "Zul'Gurub",
        difficulty= "20-man",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Iconic rare drop from pre-TBC Zul'Gurub raid."
    },

    ["Swift Razzashi Raptor"] = {
        expansion = "Classic",
        name      = "Swift Razzashi Raptor",
        spellId   = 24244,
        itemId    = 19872,
        source    = "Boss",
        boss      = "Bloodlord Mandokir",
        location  = "Zul'Gurub",
        difficulty= "20-man",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Sister drop to the Zulian Tiger."
    },

    ["Deathcharger's Reins"] = {
        expansion = "Classic",
        name      = "Deathcharger's Reins",
        spellId   = 17481,
        itemId    = 13335,
        source    = "Boss",
        boss      = "Baron Rivendare",
        location  = "Stratholme Dead Side",
        difficulty= "5-man",
        dropChance= "≈0.8 %",
        blackMarket = true,
        description = "Undead horse from the last boss of Stratholme."
    },

    ["Red Qiraji Resonating Crystal"] = {
        expansion = "Classic",
        name      = "Red Qiraji Resonating Crystal",
        spellId   = 26054,
        itemId    = 21321,
        source    = "Boss",
        location  = "Temple of Ahn'Qiraj",
        difficulty= "40-man",
        dropChance= "≈5 % on any boss",
        description = "One-use then permanent battle-tank usable only in AQ40."
    },

    ["Blue Qiraji Resonating Crystal"] = {
        expansion = "Classic",
        name      = "Blue Qiraji Resonating Crystal",
        spellId   = 26055,
        itemId    = 21218,
        source    = "Boss",
        location  = "Temple of Ahn'Qiraj",
        difficulty= "40-man",
        dropChance= "≈5 %",
        description = "Mount usable exclusively inside AQ40."
    },

    ["Yellow Qiraji Resonating Crystal"] = {
        expansion = "Classic",
        name      = "Yellow Qiraji Resonating Crystal",
        spellId   = 26056,
        itemId    = 21324,
        source    = "Boss",
        location  = "Temple of Ahn'Qiraj",
        difficulty= "40-man",
        dropChance= "≈5 %",
        description = "Yellow AQ battle-tank."
    },

    ["Green Qiraji Resonating Crystal"] = {
        expansion = "Classic",
        name      = "Green Qiraji Resonating Crystal",
        spellId   = 26064,
        itemId    = 21323,
        source    = "Boss",
        location  = "Temple of Ahn'Qiraj",
        difficulty= "40-man",
        dropChance= "≈5 %",
        description = "Green AQ battle-tank."
    },

    ["The Horseman's Reins"] = {
        expansion = "Classic",
        name      = "Headless Horseman's Mount",
        spellId   = 48025,
        itemId    = 37012,
        source    = "World Event",
        location  = "Scarlet Monastery Graveyard (Hallow's End)",
        difficulty= "Daily encounter",
        dropChance= "≈0.5 %",
        description = "Flying ground-speed mount, only during Hallow's End."
    },

    ["Great Brewfest Kodo"] = {
        expansion = "Classic",
        name      = "Great Brewfest Kodo",
        spellId   = 49379,
        itemId    = 33977,
        source    = "World Event",
        location  = "Blackrock Depths (Coren Direbrew)",
        difficulty= "Brewfest daily",
        dropChance= "≈2 %",
        description = "Horde-flavoured Brewfest ground mount."
    },

    ["Swift Brewfest Ram"] = {
        expansion = "Classic",
        name      = "Swift Brewfest Ram",
        spellId   = 43900,
        itemId    = 33976,
        source    = "World Event",
        location  = "Blackrock Depths (Coren Direbrew)",
        difficulty= "Brewfest daily",
        dropChance= "≈2 %",
        description = "Alliance-flavoured Brewfest ground mount."
    },
    ---------------------------------------------------------------------------
    -- THE BURNING CRUSADE (2007) – MOUNTS DROPPABLES
    ---------------------------------------------------------------------------

    ["Fiery Warhorse's Reins"] = {
        expansion = "The Burning Crusade",
        name      = "Fiery Warhorse",
        spellId   = 36702,
        itemId    = 30480,
        source    = "Boss",
        boss      = "Attumen the Huntsman",
        location  = "Karazhan",
        difficulty= "10-man",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "First boss of Karazhan – very low drop."
    },

    ["Reins of the Raven Lord"] = {
        expansion = "The Burning Crusade",
        name      = "Raven Lord",
        spellId   = 41252,
        itemId    = 32768,
        source    = "Boss",
        boss      = "Anzu",
        location  = "Sethekk Halls (Heroic)",
        difficulty= "Heroic 5-man",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Druid-focused dungeon mount, later open to all."
    },

    ["Ashes of Al'ar"] = {
        expansion = "The Burning Crusade",
        name      = "Ashes of Al'ar",
        spellId   = 40192,
        itemId    = 32458,
        source    = "Boss",
        boss      = "Kael'thas Sunstrider",
        location  = "Tempest Keep: The Eye",
        difficulty= "25-man",
        dropChance= "≈1-2 %",
        blackMarket = true,
        description = "Legendary phoenix, still sought-after for its looks."
    },

    ["Swift White Hawkstrider"] = {
        expansion = "The Burning Crusade",
        name      = "Swift White Hawkstrider",
        spellId   = 46628,
        itemId    = 35513,
        source    = "Boss",
        boss      = "Kael'thas Sunstrider",
        location  = "Magisters' Terrace (Heroic)",
        difficulty= "Heroic 5-man",
        dropChance= "≈4 %",
        description = "Kael'thas encore drop after Tempest Keep story."
    },

    ["Amani War Bear"] = {
        expansion = "The Burning Crusade",
        name      = "Amani War Bear",
        spellId   = 43688,
        itemId    = 33809,
        source    = "Timed Event",
        location  = "Zul'Aman",
        difficulty= "10-man (timed chest)",
        dropChance= "Guaranteed if timer beaten",
        description = "Legacy timed-run reward; later unobtainable in retail.",
    },

    ["Swift Zulian Panther"] = {
        expansion = "The Burning Crusade",
        name      = "Swift Zulian Panther",
        spellId   = 96491,  -- placeholder (same model; retail reuse)
        itemId    = 68824,
        source    = "Boss",
        boss      = "High Priestess Kilnara",
        location  = "Zul'Gurub (Revamp, patch 4.1)",
        description = "Added late TBC as panther-themed raptor replacement."
    },
    ---------------------------------------------------------------------------
    -- WRATH OF THE LICH KING (2008) – MOUNTS DROPPABLES
    ---------------------------------------------------------------------------

    ["Blue Proto-Drake"] = {
        expansion = "Wrath of the Lich King",
        name      = "Blue Proto-Drake",
        spellId   = 59996,
        itemId    = 44151,
        source    = "Boss",
        boss      = "Skadi the Ruthless",
        location  = "Utgarde Pinnacle (Heroic)",
        difficulty= "Heroic 5-man",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Iconic farm – drops from Skadi after the gauntlet."
    },

    ["Bronze Drake"] = {
        expansion = "Wrath of the Lich King",
        name      = "Bronze Drake",
        spellId   = 59569,
        itemId    = 43951,
        source    = "Timed Event",
        location  = "Culling of Stratholme (Heroic)",
        difficulty= "Heroic 5-man (≤ 25 min)",
        dropChance= "100 % if timer beaten",
        description = "Guaranteed from Infinite Corruptor’s cache when timer is met."
    },

    ["Time-Lost Proto-Drake"] = {
        expansion = "Wrath of the Lich King",
        name      = "Time-Lost Proto-Drake",
        spellId   = 60025,
        itemId    = 44168,
        source    = "World Rare",
        boss      = "Time-Lost Proto-Drake",
        location  = "Storm Peaks",
        dropChance= "100 % (rare spawn every ~4-8 h)",
        description = "Infamously camped rare in the Storm Peaks."
    },

    ["Invincible's Reins"] = {
        expansion = "Wrath of the Lich King",
        name      = "Invincible",
        spellId   = 72286,
        itemId    = 50818,
        source    = "Boss",
        boss      = "The Lich King",
        location  = "Icecrown Citadel",
        difficulty= "25-man Heroic",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Arthas’ undead horse – pinnacle of WotLK prestige."
    },

    ["Mimiron's Head"] = {
        expansion = "Wrath of the Lich King",
        name      = "Mimiron's Head",
        spellId   = 63796,
        itemId    = 45693,
        source    = "Boss",
        boss      = "Yogg-Saron (0 Keepers)",
        location  = "Ulduar",
        difficulty= "Any (0-light only)",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Drop requires defeating Yogg with no Keepers assisting."
    },

    ["Onyxian Drake"] = {
        expansion = "Wrath of the Lich King",
        name      = "Onyxian Drake",
        spellId   = 69395,
        itemId    = 49636,
        source    = "Boss",
        boss      = "Onyxia",
        location  = "Onyxia's Lair (Level-80 revamp)",
        difficulty= "Any",
        dropChance= "≈1 %",
        blackMarket = true,
        description = "Added in the 5-year anniversary revamp of Onyxia."
    },

    ["Azure Drake"] = {
        expansion = "Wrath of the Lich King",
        name      = "Azure Drake",
        spellId   = 59567,
        itemId    = 43952,
        source    = "Boss",
        boss      = "Malygos",
        location  = "Eye of Eternity (25-man)",
        dropChance= "≈3 %",
        description = "One of two possible drakes from Malygos."
    },

    ["Blue Drake"] = {
        expansion = "Wrath of the Lich King",
        name      = "Blue Drake",
        spellId   = 59568,
        itemId    = 43953,
        source    = "Boss",
        boss      = "Malygos",
        location  = "Eye of Eternity (10-man) ou bag de Satchel of Spoils",
        dropChance= "≈3 %",
        description = "Alternate colour to the Azure Drake."
    },

    ["Grand Black War Mammoth"] = {
        expansion = "Wrath of the Lich King",
        name      = "Grand Black War Mammoth",
        spellId   = 59791,
        itemId    = 43959,
        source    = "Boss",
        boss      = "Vault of Archavon bosses",
        location  = "Wintergrasp",
        difficulty= "10 & 25-man",
        dropChance= "≈1 %",
        description = "Can drop from any Vault boss; two-passenger PvP mammoth."
    },

    ["Reins of the Black Drake"] = {
        expansion = "Wrath of the Lich King",
        name      = "Black Drake",
        spellId   = 60002,
        itemId    = 43986,
        source    = "Boss",
        boss      = "Sartharion (3 Drakes)",
        location  = "Obsidian Sanctum (10-man)",
        dropChance= "100 % (once per lockout)",
        description = "Guaranteed when you defeat Sartharion +3 adds on 10-man."
    },

    ["Reins of the Twilight Drake"] = {
        expansion = "Wrath of the Lich King",
        name      = "Twilight Drake",
        spellId   = 60021,
        itemId    = 43954,
        source    = "Boss",
        boss      = "Sartharion (3 Drakes)",
        location  = "Obsidian Sanctum (25-man)",
        dropChance= "100 % (once per lockout)",
        description = "25-man equivalent reward for OS +3."
    },


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
    -- 1) Collecte les extensions présentes dans la base
    local found = {}
    for _, data in pairs(MountDatabase.mounts) do
        found[data.expansion] = true
    end

    -- 2) Passe le set en liste
    local list = {}
    for expansion in pairs(found) do
        table.insert(list, expansion)
    end

    -- 3) Trie selon l’ordre défini, puis par nom si même rang
    local order = MountDatabase.EXPANSION_ORDER or {}
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

-----------------------------------------------------------------
--  Détecter les montures collectées
-----------------------------------------------------------------
-- Renvoie true si la monture est collectée sur le compte (aucun cache)
MountDatabase.HasMount = function(spellId)

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

-- 1. Montures connues (grimoire) → 16
MountDatabase.GetKnownCount = function()
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
-----------------------------------------------------------------
-- 1) Montures réellement visibles par CE personnage (utilisables)
-----------------------------------------------------------------
MountDatabase.GetUsableCount = function()
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

-----------------------------------------------------------------
-- 2) Montures possédées sur le compte (collectées)
--    ≈ nombre affiché par Blizzard en haut du journal
-----------------------------------------------------------------
MountDatabase.GetCollectedCount = function()
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
-----------------------------------------------------------------
-- Nombre total d’entrées dans la base
-----------------------------------------------------------------
MountDatabase.GetTotalCount = function()
    local c = 0
    for _ in pairs(MountDatabase.mounts) do c = c + 1 end
    return c
end

-- Export de la base de données
addonTable.MountDatabase = MountDatabase
return MountDatabase