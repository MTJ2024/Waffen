Config = {}

-- ════════════════════════════════════════════════════════════════
-- WICHTIG: Wie finde ich meine License ID?
-- ════════════════════════════════════════════════════════════════
-- 1. Starte deinen FiveM Server
-- 2. Verbinde dich mit dem Server  
-- 3. Schaue in die Server Console (F8 im Terminal)
-- 4. Suche nach: "Player Connecting: DeinName (license:xxxxx...)"
-- 5. Kopiere die komplette license ID (z.B. license:abc123def456...)
-- 6. Füge sie unten in die Liste ein
--
-- Beispiel in der Console:
-- [system] Player Connecting: MaxMustermann (license:1a2b3c4d5e6f7g8h9i0j...)
--
-- Dann kopiere: license:1a2b3c4d5e6f7g8h9i0j...
-- ════════════════════════════════════════════════════════════════

Config.AuthorizedPlayers = {
    -- Füge hier deine License ID oder Steam ID ein:
    -- "license:1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t",
    -- "steam:110000xxxxxxxx",
    
    -- Mehrere IDs möglich:
    -- "license:abc123...",
    -- "license:def456...",
}

Config.OpenKey = 'F9'
Config.DefaultAmmo = 250

-- Unendliche Munition für autorisierte Spieler
-- Wenn aktiviert, wird Munition nicht verbraucht und Nachladen ist nicht nötig
Config.InfiniteAmmo = true

-- Munitions-Mapping: Welche Waffe nutzt welche Munition
Config.WeaponAmmo = {
    -- Pistolen
    ["WEAPON_PISTOL"] = "AMMO_PISTOL",
    ["WEAPON_PISTOL_MK2"] = "AMMO_PISTOL",
    ["WEAPON_COMBATPISTOL"] = "AMMO_PISTOL",
    ["WEAPON_APPISTOL"] = "AMMO_PISTOL",
    ["WEAPON_PISTOL50"] = "AMMO_PISTOL",
    ["WEAPON_SNSPISTOL"] = "AMMO_PISTOL",
    ["WEAPON_SNSPISTOL_MK2"] = "AMMO_PISTOL",
    ["WEAPON_HEAVYPISTOL"] = "AMMO_PISTOL",
    ["WEAPON_VINTAGEPISTOL"] = "AMMO_PISTOL",
    ["WEAPON_MARKSMANPISTOL"] = "AMMO_PISTOL",
    ["WEAPON_REVOLVER"] = "AMMO_PISTOL",
    ["WEAPON_REVOLVER_MK2"] = "AMMO_PISTOL",
    ["WEAPON_DOUBLEACTION"] = "AMMO_PISTOL",
    ["WEAPON_CERAMICPISTOL"] = "AMMO_PISTOL",
    ["WEAPON_NAVYREVOLVER"] = "AMMO_PISTOL",
    ["WEAPON_GADGETPISTOL"] = "AMMO_PISTOL",
    ["WEAPON_PISTOLXM3"] = "AMMO_PISTOL",
    
    -- SMGs
    ["WEAPON_MICROSMG"] = "AMMO_SMG",
    ["WEAPON_SMG"] = "AMMO_SMG",
    ["WEAPON_SMG_MK2"] = "AMMO_SMG",
    ["WEAPON_ASSAULTSMG"] = "AMMO_SMG",
    ["WEAPON_COMBATPDW"] = "AMMO_SMG",
    ["WEAPON_MACHINEPISTOL"] = "AMMO_SMG",
    ["WEAPON_MINISMG"] = "AMMO_SMG",
    ["WEAPON_TECPISTOL"] = "AMMO_SMG",
    
    -- Schrotflinten
    ["WEAPON_PUMPSHOTGUN"] = "AMMO_SHOTGUN",
    ["WEAPON_PUMPSHOTGUN_MK2"] = "AMMO_SHOTGUN",
    ["WEAPON_SAWNOFFSHOTGUN"] = "AMMO_SHOTGUN",
    ["WEAPON_ASSAULTSHOTGUN"] = "AMMO_SHOTGUN",
    ["WEAPON_BULLPUPSHOTGUN"] = "AMMO_SHOTGUN",
    ["WEAPON_MUSKET"] = "AMMO_SHOTGUN",
    ["WEAPON_HEAVYSHOTGUN"] = "AMMO_SHOTGUN",
    ["WEAPON_DBSHOTGUN"] = "AMMO_SHOTGUN",
    ["WEAPON_AUTOSHOTGUN"] = "AMMO_SHOTGUN",
    ["WEAPON_COMBATSHOTGUN"] = "AMMO_SHOTGUN",
    
    -- Sturmgewehre
    ["WEAPON_ASSAULTRIFLE"] = "AMMO_RIFLE",
    ["WEAPON_ASSAULTRIFLE_MK2"] = "AMMO_RIFLE",
    ["WEAPON_CARBINERIFLE"] = "AMMO_RIFLE",
    ["WEAPON_CARBINERIFLE_MK2"] = "AMMO_RIFLE",
    ["WEAPON_ADVANCEDRIFLE"] = "AMMO_RIFLE",
    ["WEAPON_SPECIALCARBINE"] = "AMMO_RIFLE",
    ["WEAPON_SPECIALCARBINE_MK2"] = "AMMO_RIFLE",
    ["WEAPON_BULLPUPRIFLE"] = "AMMO_RIFLE",
    ["WEAPON_BULLPUPRIFLE_MK2"] = "AMMO_RIFLE",
    ["WEAPON_COMPACTRIFLE"] = "AMMO_RIFLE",
    ["WEAPON_MILITARYRIFLE"] = "AMMO_RIFLE",
    ["WEAPON_HEAVYRIFLE"] = "AMMO_RIFLE",
    ["WEAPON_TACTICALRIFLE"] = "AMMO_RIFLE",
    ["WEAPON_BATTLERIFLE"] = "AMMO_RIFLE",
    
    -- Maschinengewehre
    ["WEAPON_MG"] = "AMMO_MG",
    ["WEAPON_COMBATMG"] = "AMMO_MG",
    ["WEAPON_COMBATMG_MK2"] = "AMMO_MG",
    ["WEAPON_GUSENBERG"] = "AMMO_MG",
    
    -- Scharfschützengewehre
    ["WEAPON_SNIPERRIFLE"] = "AMMO_SNIPER",
    ["WEAPON_HEAVYSNIPER"] = "AMMO_SNIPER_50CAL",
    ["WEAPON_HEAVYSNIPER_MK2"] = "AMMO_SNIPER_50CAL",
    ["WEAPON_MARKSMANRIFLE"] = "AMMO_SNIPER",
    ["WEAPON_MARKSMANRIFLE_MK2"] = "AMMO_SNIPER",
    ["WEAPON_PRECISIONRIFLE"] = "AMMO_SNIPER",
    
    -- Schwere Waffen
    ["WEAPON_RPG"] = "AMMO_ROCKET",
    ["WEAPON_GRENADELAUNCHER"] = "AMMO_GRENADE_LAUNCHER",
    ["WEAPON_COMPACTLAUNCHER"] = "AMMO_GRENADE_LAUNCHER",
    ["WEAPON_MINIGUN"] = "AMMO_MG",
    ["WEAPON_FIREWORK"] = "AMMO_ROCKET",
    ["WEAPON_RAILGUN"] = "AMMO_RAILGUN",
    ["WEAPON_HOMINGLAUNCHER"] = "AMMO_ROCKET",
    ["WEAPON_RAYMINIGUN"] = "AMMO_MG",
}

Config.Weapons = {
    -- ═══ PISTOLEN ═══
    {name = "WEAPON_PISTOL", label = "Pistol", category = "Pistolen"},
    {name = "WEAPON_PISTOL_MK2", label = "Pistol Mk II", category = "Pistolen"},
    {name = "WEAPON_COMBATPISTOL", label = "Combat Pistol", category = "Pistolen"},
    {name = "WEAPON_APPISTOL", label = "AP Pistol", category = "Pistolen"},
    {name = "WEAPON_STUNGUN", label = "Stun Gun", category = "Pistolen"},
    {name = "WEAPON_PISTOL50", label = "Pistol .50", category = "Pistolen"},
    {name = "WEAPON_SNSPISTOL", label = "SNS Pistol", category = "Pistolen"},
    {name = "WEAPON_SNSPISTOL_MK2", label = "SNS Pistol Mk II", category = "Pistolen"},
    {name = "WEAPON_HEAVYPISTOL", label = "Heavy Pistol", category = "Pistolen"},
    {name = "WEAPON_VINTAGEPISTOL", label = "Vintage Pistol", category = "Pistolen"},
    {name = "WEAPON_FLAREGUN", label = "Flare Gun", category = "Pistolen"},
    {name = "WEAPON_MARKSMANPISTOL", label = "Marksman Pistol", category = "Pistolen"},
    {name = "WEAPON_REVOLVER", label = "Heavy Revolver", category = "Pistolen"},
    {name = "WEAPON_REVOLVER_MK2", label = "Heavy Revolver Mk II", category = "Pistolen"},
    {name = "WEAPON_DOUBLEACTION", label = "Double Action Revolver", category = "Pistolen"},
    {name = "WEAPON_RAYPISTOL", label = "Up-n-Atomizer", category = "Pistolen"},
    {name = "WEAPON_CERAMICPISTOL", label = "Ceramic Pistol", category = "Pistolen"},
    {name = "WEAPON_NAVYREVOLVER", label = "Navy Revolver", category = "Pistolen"},
    {name = "WEAPON_GADGETPISTOL", label = "Perico Pistol", category = "Pistolen"},
    {name = "WEAPON_PISTOLXM3", label = "WM 29 Pistol", category = "Pistolen"},
    
    -- ═══ SMGs ═══
    {name = "WEAPON_MICROSMG", label = "Micro SMG", category = "SMGs"},
    {name = "WEAPON_SMG", label = "SMG", category = "SMGs"},
    {name = "WEAPON_SMG_MK2", label = "SMG Mk II", category = "SMGs"},
    {name = "WEAPON_ASSAULTSMG", label = "Assault SMG", category = "SMGs"},
    {name = "WEAPON_COMBATPDW", label = "Combat PDW", category = "SMGs"},
    {name = "WEAPON_MACHINEPISTOL", label = "Machine Pistol", category = "SMGs"},
    {name = "WEAPON_MINISMG", label = "Mini SMG", category = "SMGs"},
    {name = "WEAPON_RAYCARBINE", label = "Unholy Hellbringer", category = "SMGs"},
    {name = "WEAPON_TECPISTOL", label = "Tactical SMG", category = "SMGs"},
    
    -- ═══ SCHROTFLINTEN ═══
    {name = "WEAPON_PUMPSHOTGUN", label = "Pump Shotgun", category = "Schrotflinten"},
    {name = "WEAPON_PUMPSHOTGUN_MK2", label = "Pump Shotgun Mk II", category = "Schrotflinten"},
    {name = "WEAPON_SAWNOFFSHOTGUN", label = "Sawed-Off Shotgun", category = "Schrotflinten"},
    {name = "WEAPON_ASSAULTSHOTGUN", label = "Assault Shotgun", category = "Schrotflinten"},
    {name = "WEAPON_BULLPUPSHOTGUN", label = "Bullpup Shotgun", category = "Schrotflinten"},
    {name = "WEAPON_MUSKET", label = "Musket", category = "Schrotflinten"},
    {name = "WEAPON_HEAVYSHOTGUN", label = "Heavy Shotgun", category = "Schrotflinten"},
    {name = "WEAPON_DBSHOTGUN", label = "Double Barrel Shotgun", category = "Schrotflinten"},
    {name = "WEAPON_AUTOSHOTGUN", label = "Sweeper Shotgun", category = "Schrotflinten"},
    {name = "WEAPON_COMBATSHOTGUN", label = "Combat Shotgun", category = "Schrotflinten"},
    
    -- ═══ STURMGEWEHRE ═══
    {name = "WEAPON_ASSAULTRIFLE", label = "Assault Rifle", category = "Sturmgewehre"},
    {name = "WEAPON_ASSAULTRIFLE_MK2", label = "Assault Rifle Mk II", category = "Sturmgewehre"},
    {name = "WEAPON_CARBINERIFLE", label = "Carbine Rifle", category = "Sturmgewehre"},
    {name = "WEAPON_CARBINERIFLE_MK2", label = "Carbine Rifle Mk II", category = "Sturmgewehre"},
    {name = "WEAPON_ADVANCEDRIFLE", label = "Advanced Rifle", category = "Sturmgewehre"},
    {name = "WEAPON_SPECIALCARBINE", label = "Special Carbine", category = "Sturmgewehre"},
    {name = "WEAPON_SPECIALCARBINE_MK2", label = "Special Carbine Mk II", category = "Sturmgewehre"},
    {name = "WEAPON_BULLPUPRIFLE", label = "Bullpup Rifle", category = "Sturmgewehre"},
    {name = "WEAPON_BULLPUPRIFLE_MK2", label = "Bullpup Rifle Mk II", category = "Sturmgewehre"},
    {name = "WEAPON_COMPACTRIFLE", label = "Compact Rifle", category = "Sturmgewehre"},
    {name = "WEAPON_MILITARYRIFLE", label = "Military Rifle", category = "Sturmgewehre"},
    {name = "WEAPON_HEAVYRIFLE", label = "Heavy Rifle", category = "Sturmgewehre"},
    {name = "WEAPON_TACTICALRIFLE", label = "Tactical Rifle", category = "Sturmgewehre"},
    {name = "WEAPON_BATTLERIFLE", label = "Battle Rifle", category = "Sturmgewehre"},
    
    -- ═══ MASCHINENGEWEHRE ═══
    {name = "WEAPON_MG", label = "MG", category = "Maschinengewehre"},
    {name = "WEAPON_COMBATMG", label = "Combat MG", category = "Maschinengewehre"},
    {name = "WEAPON_COMBATMG_MK2", label = "Combat MG Mk II", category = "Maschinengewehre"},
    {name = "WEAPON_GUSENBERG", label = "Gusenberg Sweeper", category = "Maschinengewehre"},
    
    -- ═══ SCHARFSCHÜTZENGEWEHRE ═══
    {name = "WEAPON_SNIPERRIFLE", label = "Sniper Rifle", category = "Scharfschützengewehre"},
    {name = "WEAPON_HEAVYSNIPER", label = "Heavy Sniper", category = "Scharfschützengewehre"},
    {name = "WEAPON_HEAVYSNIPER_MK2", label = "Heavy Sniper Mk II", category = "Scharfschützengewehre"},
    {name = "WEAPON_MARKSMANRIFLE", label = "Marksman Rifle", category = "Scharfschützengewehre"},
    {name = "WEAPON_MARKSMANRIFLE_MK2", label = "Marksman Rifle Mk II", category = "Scharfschützengewehre"},
    {name = "WEAPON_PRECISIONRIFLE", label = "Precision Rifle", category = "Scharfschützengewehre"},
    
    -- ═══ SCHWERE WAFFEN ═══
    {name = "WEAPON_RPG", label = "RPG", category = "Schwere Waffen"},
    {name = "WEAPON_GRENADELAUNCHER", label = "Grenade Launcher", category = "Schwere Waffen"},
    {name = "WEAPON_GRENADELAUNCHER_SMOKE", label = "Smoke Grenade Launcher", category = "Schwere Waffen"},
    {name = "WEAPON_MINIGUN", label = "Minigun", category = "Schwere Waffen"},
    {name = "WEAPON_FIREWORK", label = "Firework Launcher", category = "Schwere Waffen"},
    {name = "WEAPON_RAILGUN", label = "Railgun", category = "Schwere Waffen"},
    {name = "WEAPON_HOMINGLAUNCHER", label = "Homing Launcher", category = "Schwere Waffen"},
    {name = "WEAPON_COMPACTLAUNCHER", label = "Compact Grenade Launcher", category = "Schwere Waffen"},
    {name = "WEAPON_RAYMINIGUN", label = "Widowmaker", category = "Schwere Waffen"},
    {name = "WEAPON_EMPLAUNCHER", label = "EMP Launcher", category = "Schwere Waffen"},
    
    -- ═══ WURFWAFFEN ═══
    {name = "WEAPON_GRENADE", label = "Grenade", category = "Wurfwaffen"},
    {name = "WEAPON_BZGAS", label = "BZ Gas", category = "Wurfwaffen"},
    {name = "WEAPON_MOLOTOV", label = "Molotov Cocktail", category = "Wurfwaffen"},
    {name = "WEAPON_STICKYBOMB", label = "Sticky Bomb", category = "Wurfwaffen"},
    {name = "WEAPON_PROXMINE", label = "Proximity Mine", category = "Wurfwaffen"},
    {name = "WEAPON_SNOWBALL", label = "Snowball", category = "Wurfwaffen"},
    {name = "WEAPON_PIPEBOMB", label = "Pipe Bomb", category = "Wurfwaffen"},
    {name = "WEAPON_BALL", label = "Ball", category = "Wurfwaffen"},
    {name = "WEAPON_SMOKEGRENADE", label = "Smoke Grenade", category = "Wurfwaffen"},
    {name = "WEAPON_FLARE", label = "Flare", category = "Wurfwaffen"},
    
    -- ═══ NAHKAMPF ═══
    {name = "WEAPON_KNIFE", label = "Knife", category = "Nahkampf"},
    {name = "WEAPON_NIGHTSTICK", label = "Nightstick", category = "Nahkampf"},
    {name = "WEAPON_HAMMER", label = "Hammer", category = "Nahkampf"},
    {name = "WEAPON_BAT", label = "Baseball Bat", category = "Nahkampf"},
    {name = "WEAPON_GOLFCLUB", label = "Golf Club", category = "Nahkampf"},
    {name = "WEAPON_CROWBAR", label = "Crowbar", category = "Nahkampf"},
    {name = "WEAPON_BOTTLE", label = "Bottle", category = "Nahkampf"},
    {name = "WEAPON_DAGGER", label = "Antique Cavalry Dagger", category = "Nahkampf"},
    {name = "WEAPON_HATCHET", label = "Hatchet", category = "Nahkampf"},
    {name = "WEAPON_KNUCKLE", label = "Knuckle Duster", category = "Nahkampf"},
    {name = "WEAPON_MACHETE", label = "Machete", category = "Nahkampf"},
    {name = "WEAPON_FLASHLIGHT", label = "Flashlight", category = "Nahkampf"},
    {name = "WEAPON_SWITCHBLADE", label = "Switchblade", category = "Nahkampf"},
    {name = "WEAPON_POOLCUE", label = "Pool Cue", category = "Nahkampf"},
    {name = "WEAPON_WRENCH", label = "Wrench", category = "Nahkampf"},
    {name = "WEAPON_BATTLEAXE", label = "Battle Axe", category = "Nahkampf"},
    {name = "WEAPON_STONE_HATCHET", label = "Stone Hatchet", category = "Nahkampf"},
    
    -- ═══ SPEZIALWAFFEN ═══
    {name = "WEAPON_PETROLCAN", label = "Jerry Can", category = "Spezial"},
    {name = "WEAPON_HAZARDCAN", label = "Hazard Can", category = "Spezial"},
    {name = "WEAPON_FIREEXTINGUISHER", label = "Fire Extinguisher", category = "Spezial"},
    {name = "WEAPON_PARACHUTE", label = "Parachute", category = "Spezial"},
    {name = "WEAPON_FERTILIZERCAN", label = "Fertilizer Can", category = "Spezial"},
}

-- ═══════════════════════════════════════════════════════════════
-- ITEMS: Waffen als Items + Munition + Sonstiges
-- ═══════════════════════════════════════════════════════════════
Config.Items = {
    -- ═══ MUNITION ═══
    {name = "ammo_pistol", label = "Pistolen Munition", category = "Munition"},
    {name = "ammo_smg", label = "SMG Munition", category = "Munition"},
    {name = "ammo_rifle", label = "Gewehr Munition", category = "Munition"},
    {name = "ammo_shotgun", label = "Schrotflinte Munition", category = "Munition"},
    {name = "ammo_sniper", label = "Sniper Munition", category = "Munition"},
    {name = "ammo_mg", label = "MG Munition", category = "Munition"},
    {name = "ammo_rocket", label = "Raketen Munition", category = "Munition"},
    {name = "ammo_grenade", label = "Granaten", category = "Munition"},
    {name = "ammo_50cal", label = ".50 Cal Munition", category = "Munition"},
    {name = "ammo_armor_piercing", label = "Panzerbrechende Munition", category = "Munition"},
    
    -- ═══ WAFFEN ALS ITEMS (PISTOLEN) ═══
    {name = "weapon_pistol", label = "Pistol (Item)", category = "Waffen-Items"},
    {name = "weapon_pistol_mk2", label = "Pistol Mk II (Item)", category = "Waffen-Items"},
    {name = "weapon_combatpistol", label = "Combat Pistol (Item)", category = "Waffen-Items"},
    {name = "weapon_appistol", label = "AP Pistol (Item)", category = "Waffen-Items"},
    {name = "weapon_pistol50", label = "Pistol .50 (Item)", category = "Waffen-Items"},
    {name = "weapon_snspistol", label = "SNS Pistol (Item)", category = "Waffen-Items"},
    {name = "weapon_heavypistol", label = "Heavy Pistol (Item)", category = "Waffen-Items"},
    {name = "weapon_vintagepistol", label = "Vintage Pistol (Item)", category = "Waffen-Items"},
    {name = "weapon_revolver", label = "Heavy Revolver (Item)", category = "Waffen-Items"},
    {name = "weapon_revolver_mk2", label = "Heavy Revolver Mk II (Item)", category = "Waffen-Items"},
    
    -- ═══ WAFFEN ALS ITEMS (SMGS) ═══
    {name = "weapon_microsmg", label = "Micro SMG (Item)", category = "Waffen-Items"},
    {name = "weapon_smg", label = "SMG (Item)", category = "Waffen-Items"},
    {name = "weapon_smg_mk2", label = "SMG Mk II (Item)", category = "Waffen-Items"},
    {name = "weapon_assaultsmg", label = "Assault SMG (Item)", category = "Waffen-Items"},
    {name = "weapon_combatpdw", label = "Combat PDW (Item)", category = "Waffen-Items"},
    {name = "weapon_machinepistol", label = "Machine Pistol (Item)", category = "Waffen-Items"},
    {name = "weapon_minismg", label = "Mini SMG (Item)", category = "Waffen-Items"},
    {name = "weapon_tecpistol", label = "Tactical SMG (Item)", category = "Waffen-Items"},
    
    -- ═══ WAFFEN ALS ITEMS (SCHROTFLINTEN) ═══
    {name = "weapon_pumpshotgun", label = "Pump Shotgun (Item)", category = "Waffen-Items"},
    {name = "weapon_pumpshotgun_mk2", label = "Pump Shotgun Mk II (Item)", category = "Waffen-Items"},
    {name = "weapon_sawnoffshotgun", label = "Sawed-Off Shotgun (Item)", category = "Waffen-Items"},
    {name = "weapon_assaultshotgun", label = "Assault Shotgun (Item)", category = "Waffen-Items"},
    {name = "weapon_bullpupshotgun", label = "Bullpup Shotgun (Item)", category = "Waffen-Items"},
    {name = "weapon_heavyshotgun", label = "Heavy Shotgun (Item)", category = "Waffen-Items"},
    {name = "weapon_dbshotgun", label = "Double Barrel Shotgun (Item)", category = "Waffen-Items"},
    {name = "weapon_combatshotgun", label = "Combat Shotgun (Item)", category = "Waffen-Items"},
    
    -- ═══ WAFFEN ALS ITEMS (STURMGEWEHRE) ═══
    {name = "weapon_assaultrifle", label = "Assault Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_assaultrifle_mk2", label = "Assault Rifle Mk II (Item)", category = "Waffen-Items"},
    {name = "weapon_carbinerifle", label = "Carbine Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_carbinerifle_mk2", label = "Carbine Rifle Mk II (Item)", category = "Waffen-Items"},
    {name = "weapon_advancedrifle", label = "Advanced Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_specialcarbine", label = "Special Carbine (Item)", category = "Waffen-Items"},
    {name = "weapon_specialcarbine_mk2", label = "Special Carbine Mk II (Item)", category = "Waffen-Items"},
    {name = "weapon_bullpuprifle", label = "Bullpup Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_bullpuprifle_mk2", label = "Bullpup Rifle Mk II (Item)", category = "Waffen-Items"},
    {name = "weapon_compactrifle", label = "Compact Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_militaryrifle", label = "Military Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_heavyrifle", label = "Heavy Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_tacticalrifle", label = "Tactical Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_battlerifle", label = "Battle Rifle (Item)", category = "Waffen-Items"},
    
    -- ═══ WAFFEN ALS ITEMS (SCHARFSCHÜTZENGEWEHRE) ═══
    {name = "weapon_sniperrifle", label = "Sniper Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_heavysniper", label = "Heavy Sniper (Item)", category = "Waffen-Items"},
    {name = "weapon_heavysniper_mk2", label = "Heavy Sniper Mk II (Item)", category = "Waffen-Items"},
    {name = "weapon_marksmanrifle", label = "Marksman Rifle (Item)", category = "Waffen-Items"},
    {name = "weapon_marksmanrifle_mk2", label = "Marksman Rifle Mk II (Item)", category = "Waffen-Items"},
    {name = "weapon_precisionrifle", label = "Precision Rifle (Item)", category = "Waffen-Items"},
    
    -- ═══ WAFFEN ALS ITEMS (SCHWERE WAFFEN) ═══
    {name = "weapon_rpg", label = "RPG (Item)", category = "Waffen-Items"},
    {name = "weapon_grenadelauncher", label = "Grenade Launcher (Item)", category = "Waffen-Items"},
    {name = "weapon_minigun", label = "Minigun (Item)", category = "Waffen-Items"},
    {name = "weapon_railgun", label = "Railgun (Item)", category = "Waffen-Items"},
    {name = "weapon_hominglauncher", label = "Homing Launcher (Item)", category = "Waffen-Items"},
    
    -- ═══ WAFFEN ALS ITEMS (NAHKAMPF) ═══
    {name = "weapon_knife", label = "Knife (Item)", category = "Waffen-Items"},
    {name = "weapon_bat", label = "Baseball Bat (Item)", category = "Waffen-Items"},
    {name = "weapon_crowbar", label = "Crowbar (Item)", category = "Waffen-Items"},
    {name = "weapon_machete", label = "Machete (Item)", category = "Waffen-Items"},
    {name = "weapon_switchblade", label = "Switchblade (Item)", category = "Waffen-Items"},
    {name = "weapon_battleaxe", label = "Battle Axe (Item)", category = "Waffen-Items"},
    
    -- ═══ WURFWAFFEN ALS ITEMS ═══
    {name = "weapon_grenade", label = "Grenade (Item)", category = "Waffen-Items"},
    {name = "weapon_molotov", label = "Molotov Cocktail (Item)", category = "Waffen-Items"},
    {name = "weapon_stickybomb", label = "Sticky Bomb (Item)", category = "Waffen-Items"},
    {name = "weapon_proxmine", label = "Proximity Mine (Item)", category = "Waffen-Items"},
    {name = "weapon_smokegrenade", label = "Smoke Grenade (Item)", category = "Waffen-Items"},
    
    -- ═══ WAFFENZUBEHÖR (GTA V Online Komponenten) ═══
    -- Taschenlampen-Aufsätze
    {name = "COMPONENT_AT_AR_FLSH", label = "Taschenlampe (Gewehr/SMG)", category = "Zubehör"},
    {name = "COMPONENT_AT_PI_FLSH", label = "Taschenlampe (Pistole)", category = "Zubehör"},
    {name = "COMPONENT_AT_PI_FLSH_02", label = "Taschenlampe v2 (Pistole)", category = "Zubehör"},
    -- Zielfernrohre
    {name = "COMPONENT_AT_SCOPE_MACRO", label = "Scope klein (Pistole/SMG)", category = "Zubehör"},
    {name = "COMPONENT_AT_SCOPE_MACRO_02", label = "Scope klein v2 (Pistole/SMG)", category = "Zubehör"},
    {name = "COMPONENT_AT_SCOPE_SMALL", label = "Kurzes Scope", category = "Zubehör"},
    {name = "COMPONENT_AT_SCOPE_SMALL_02", label = "Kurzes Scope v2", category = "Zubehör"},
    {name = "COMPONENT_AT_SCOPE_MEDIUM", label = "Scope Mittel", category = "Zubehör"},
    {name = "COMPONENT_AT_SCOPE_LARGE", label = "Scope Groß", category = "Zubehör"},
    {name = "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM", label = "Scope Fixiert (Sniper)", category = "Zubehör"},
    {name = "COMPONENT_AT_SCOPE_NV", label = "Nachtsichtvisier", category = "Zubehör"},
    {name = "COMPONENT_AT_SCOPE_THERMAL", label = "Wärmesichtvisier", category = "Zubehör"},
    {name = "COMPONENT_AT_SCOPE_MAX", label = "Maximales Scope", category = "Zubehör"},
    -- Schalldämpfer
    {name = "COMPONENT_AT_AR_SUPP", label = "Schalldämpfer (Gewehr)", category = "Zubehör"},
    {name = "COMPONENT_AT_AR_SUPP_02", label = "Schalldämpfer v2 (Gewehr)", category = "Zubehör"},
    {name = "COMPONENT_AT_PI_SUPP_02", label = "Schalldämpfer (Pistole)", category = "Zubehör"},
    {name = "COMPONENT_AT_SG_SUPP", label = "Schalldämpfer (Schrotflinte)", category = "Zubehör"},
    {name = "COMPONENT_AT_SG_SUPP_03", label = "Schalldämpfer v3 (Schrotflinte)", category = "Zubehör"},
    {name = "COMPONENT_AT_SR_SUPP", label = "Schalldämpfer (Sniper)", category = "Zubehör"},
    {name = "COMPONENT_AT_SR_SUPP_03", label = "Schalldämpfer v3 (Sniper)", category = "Zubehör"},
    -- Griffe
    {name = "COMPONENT_AT_AR_AFGRIP", label = "Untergriff (Gewehr)", category = "Zubehör"},
    {name = "COMPONENT_AT_AR_AFGRIP_02", label = "Untergriff v2 (Gewehr)", category = "Zubehör"},
    -- Mündungsbremsen
    {name = "COMPONENT_AT_MUZZLE_1", label = "Flache Mündungsbremse", category = "Zubehör"},
    {name = "COMPONENT_AT_MUZZLE_2", label = "Taktische Mündungsbremse", category = "Zubehör"},
    {name = "COMPONENT_AT_MUZZLE_3", label = "Fette Mündungsbremse", category = "Zubehör"},
    {name = "COMPONENT_AT_MUZZLE_4", label = "Präzise Mündungsbremse", category = "Zubehör"},
    {name = "COMPONENT_AT_MUZZLE_5", label = "Schwere Mündungsbremse", category = "Zubehör"},
    {name = "COMPONENT_AT_MUZZLE_6", label = "Schräge Mündungsbremse", category = "Zubehör"},
    {name = "COMPONENT_AT_MUZZLE_7", label = "Gesplittete Mündungsbremse", category = "Zubehör"},
    {name = "COMPONENT_AT_STHOOK", label = "Stunt-Haken", category = "Zubehör"},
    {name = "COMPONENT_AT_RAILCOVER_01", label = "Schienenschutz", category = "Zubehör"},
    -- Erweiterte Magazine - Pistolen
    {name = "COMPONENT_PISTOL_CLIP_02", label = "Ext. Mag Pistol", category = "Zubehör"},
    {name = "COMPONENT_PISTOL_MK2_CLIP_02", label = "Ext. Mag Pistol Mk2", category = "Zubehör"},
    {name = "COMPONENT_COMBATPISTOL_CLIP_02", label = "Ext. Mag Combat Pistol", category = "Zubehör"},
    {name = "COMPONENT_APPISTOL_CLIP_02", label = "Ext. Mag AP Pistol", category = "Zubehör"},
    {name = "COMPONENT_PISTOL50_CLIP_02", label = "Ext. Mag Pistol .50", category = "Zubehör"},
    {name = "COMPONENT_SNSPISTOL_CLIP_02", label = "Ext. Mag SNS Pistol", category = "Zubehör"},
    {name = "COMPONENT_SNSPISTOL_MK2_CLIP_02", label = "Ext. Mag SNS Pistol Mk2", category = "Zubehör"},
    {name = "COMPONENT_HEAVYPISTOL_CLIP_02", label = "Ext. Mag Heavy Pistol", category = "Zubehör"},
    -- Erweiterte Magazine - SMGs
    {name = "COMPONENT_MICROSMG_CLIP_02", label = "Ext. Mag Micro SMG", category = "Zubehör"},
    {name = "COMPONENT_SMG_CLIP_02", label = "Ext. Mag SMG", category = "Zubehör"},
    {name = "COMPONENT_SMG_CLIP_03", label = "Trommelmagazin SMG", category = "Zubehör"},
    {name = "COMPONENT_SMG_MK2_CLIP_02", label = "Ext. Mag SMG Mk2", category = "Zubehör"},
    {name = "COMPONENT_ASSAULTSMG_CLIP_02", label = "Ext. Mag Assault SMG", category = "Zubehör"},
    {name = "COMPONENT_COMBATPDW_CLIP_02", label = "Ext. Mag Combat PDW", category = "Zubehör"},
    {name = "COMPONENT_MINISMG_CLIP_02", label = "Ext. Mag Mini SMG", category = "Zubehör"},
    -- Erweiterte Magazine - Sturmgewehre
    {name = "COMPONENT_ASSAULTRIFLE_CLIP_02", label = "Ext. Mag Assault Rifle", category = "Zubehör"},
    {name = "COMPONENT_ASSAULTRIFLE_CLIP_03", label = "Trommelmagazin Assault Rifle", category = "Zubehör"},
    {name = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02", label = "Ext. Mag Assault Rifle Mk2", category = "Zubehör"},
    {name = "COMPONENT_CARBINERIFLE_CLIP_02", label = "Ext. Mag Carbine Rifle", category = "Zubehör"},
    {name = "COMPONENT_CARBINERIFLE_CLIP_03", label = "Trommelmagazin Carbine Rifle", category = "Zubehör"},
    {name = "COMPONENT_CARBINERIFLE_MK2_CLIP_02", label = "Ext. Mag Carbine Rifle Mk2", category = "Zubehör"},
    {name = "COMPONENT_SPECIALCARBINE_CLIP_02", label = "Ext. Mag Special Carbine", category = "Zubehör"},
    {name = "COMPONENT_SPECIALCARBINE_MK2_CLIP_02", label = "Ext. Mag Special Carbine Mk2", category = "Zubehör"},
    {name = "COMPONENT_BULLPUPRIFLE_CLIP_02", label = "Ext. Mag Bullpup Rifle", category = "Zubehör"},
    {name = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02", label = "Ext. Mag Bullpup Rifle Mk2", category = "Zubehör"},
    {name = "COMPONENT_COMPACTRIFLE_CLIP_02", label = "Ext. Mag Compact Rifle", category = "Zubehör"},
    {name = "COMPONENT_MILITARYRIFLE_CLIP_02", label = "Ext. Mag Military Rifle", category = "Zubehör"},
    -- Erweiterte Magazine - Maschinengewehre
    {name = "COMPONENT_MG_CLIP_02", label = "Ext. Mag MG", category = "Zubehör"},
    {name = "COMPONENT_COMBATMG_CLIP_02", label = "Ext. Mag Combat MG", category = "Zubehör"},
    {name = "COMPONENT_COMBATMG_MK2_CLIP_02", label = "Ext. Mag Combat MG Mk2", category = "Zubehör"},
    -- Erweiterte Magazine - Scharfschützengewehre
    {name = "COMPONENT_SNIPERRIFLE_CLIP_02", label = "Ext. Mag Sniper Rifle", category = "Zubehör"},
    {name = "COMPONENT_HEAVYSNIPER_MK2_CLIP_02", label = "Ext. Mag Heavy Sniper Mk2", category = "Zubehör"},
    {name = "COMPONENT_MARKSMANRIFLE_CLIP_02", label = "Ext. Mag Marksman Rifle", category = "Zubehör"},
    {name = "COMPONENT_MARKSMANRIFLE_MK2_CLIP_02", label = "Ext. Mag Marksman Rifle Mk2", category = "Zubehör"},
    -- Erweiterte Magazine - Schrotflinten
    {name = "COMPONENT_PUMPSHOTGUN_MK2_CLIP_02", label = "Ext. Mag Pump Shotgun Mk2", category = "Zubehör"},
    {name = "COMPONENT_AUTOSHOTGUN_CLIP_02", label = "Ext. Mag Sweeper Shotgun", category = "Zubehör"},
    
    -- ═══ MEDIZINISCHE ITEMS ═══
    {name = "bandage", label = "Verband", category = "Medizin"},
    {name = "medkit", label = "Erste-Hilfe-Kasten", category = "Medizin"},
    {name = "painkiller", label = "Schmerzmittel", category = "Medizin"},
    {name = "adrenaline", label = "Adrenalin", category = "Medizin"},
    
    -- ═══ NAHRUNG & GETRÄNKE ═══
    {name = "water", label = "Wasser", category = "Nahrung"},
    {name = "bread", label = "Brot", category = "Nahrung"},
    {name = "sandwich", label = "Sandwich", category = "Nahrung"},
    {name = "burger", label = "Burger", category = "Nahrung"},
    {name = "cola", label = "Cola", category = "Nahrung"},
    {name = "coffee", label = "Kaffee", category = "Nahrung"},
    
    -- ═══ WERKZEUGE ═══
    {name = "phone", label = "Telefon", category = "Werkzeuge"},
    {name = "radio", label = "Funkgerät", category = "Werkzeuge"},
    {name = "lockpick", label = "Dietrich", category = "Werkzeuge"},
    {name = "repairkit", label = "Reparaturkit", category = "Werkzeuge"},
    {name = "binoculars", label = "Fernglas", category = "Werkzeuge"},
    {name = "flashlight", label = "Taschenlampe", category = "Werkzeuge"},
    
    -- ═══ SCHUTZ ═══
    {name = "armor", label = "Schutzweste", category = "Schutz"},
    {name = "helmet", label = "Helm", category = "Schutz"},
    {name = "gasmask", label = "Gasmaske", category = "Schutz"},
    
    -- ═══ SONSTIGES ═══
    {name = "parachute", label = "Fallschirm", category = "Sonstiges"},
    {name = "jerrycan", label = "Benzinkanister", category = "Sonstiges"},
    {name = "fireextinguisher", label = "Feuerlöscher", category = "Sonstiges"},
    {name = "rope", label = "Seil", category = "Sonstiges"},
    {name = "handcuffs", label = "Handschellen", category = "Sonstiges"},
}
