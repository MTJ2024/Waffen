Config = {}

-- Access Control - Add authorized Steam IDs or License IDs
Config.AuthorizedPlayers = {
    -- Example: "steam:110000xxxxxxxx",
    -- Example: "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
}

-- Weapons Configuration
Config.Weapons = {
    -- Pistols
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
    
    -- SMGs
    {name = "WEAPON_MICROSMG", label = "Micro SMG", category = "SMGs"},
    {name = "WEAPON_SMG", label = "SMG", category = "SMGs"},
    {name = "WEAPON_SMG_MK2", label = "SMG Mk II", category = "SMGs"},
    {name = "WEAPON_ASSAULTSMG", label = "Assault SMG", category = "SMGs"},
    {name = "WEAPON_COMBATPDW", label = "Combat PDW", category = "SMGs"},
    {name = "WEAPON_MACHINEPISTOL", label = "Machine Pistol", category = "SMGs"},
    {name = "WEAPON_MINISMG", label = "Mini SMG", category = "SMGs"},
    {name = "WEAPON_RAYCARBINE", label = "Unholy Hellbringer", category = "SMGs"},
    
    -- Shotguns
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
    
    -- Assault Rifles
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
    
    -- Machine Guns
    {name = "WEAPON_MG", label = "MG", category = "Maschinengewehre"},
    {name = "WEAPON_COMBATMG", label = "Combat MG", category = "Maschinengewehre"},
    {name = "WEAPON_COMBATMG_MK2", label = "Combat MG Mk II", category = "Maschinengewehre"},
    {name = "WEAPON_GUSENBERG", label = "Gusenberg Sweeper", category = "Maschinengewehre"},
    
    -- Sniper Rifles
    {name = "WEAPON_SNIPERRIFLE", label = "Sniper Rifle", category = "Scharfschützengewehre"},
    {name = "WEAPON_HEAVYSNIPER", label = "Heavy Sniper", category = "Scharfschützengewehre"},
    {name = "WEAPON_HEAVYSNIPER_MK2", label = "Heavy Sniper Mk II", category = "Scharfschützengewehre"},
    {name = "WEAPON_MARKSMANRIFLE", label = "Marksman Rifle", category = "Scharfschützengewehre"},
    {name = "WEAPON_MARKSMANRIFLE_MK2", label = "Marksman Rifle Mk II", category = "Scharfschützengewehre"},
    {name = "WEAPON_PRECISIONRIFLE", label = "Precision Rifle", category = "Scharfschützengewehre"},
    
    -- Heavy Weapons
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
    
    -- Throwables
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
    
    -- Melee
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
}

-- Items Configuration
Config.Items = {
    {name = "bandage", label = "Verband"},
    {name = "medkit", label = "Erste-Hilfe-Kasten"},
    {name = "water", label = "Wasser"},
    {name = "bread", label = "Brot"},
    {name = "phone", label = "Telefon"},
    {name = "radio", label = "Funkgerät"},
    {name = "lockpick", label = "Dietrich"},
    {name = "repairkit", label = "Reparaturkit"},
    {name = "armor", label = "Schutzweste"},
    {name = "parachute", label = "Fallschirm"},
}

-- Default ammunition amount
Config.DefaultAmmo = 250

-- UI Settings
Config.OpenKey = 'F9' -- Key to open the menu (owner only)
