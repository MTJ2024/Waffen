-- ════════════════════════════════════════════════════════════════
-- FRAMEWORK DETECTION & INTEGRATION
-- Automatische Erkennung aller gängigen Inventory-Systeme
-- ════════════════════════════════════════════════════════════════

ESX = nil
QBCore = nil
InventoryExport = nil
Framework = "standalone"
InventorySystem = "none"

-- Helper: safely check if a resource is started
local function IsResourceStarted(resourceName)
    return GetResourceState(resourceName) == 'started'
end

-- Helper: safely try to get an export
local function TryExport(resourceName, exportName)
    local success, result = pcall(function()
        return exports[resourceName]
    end)
    if success and result then
        return result
    end
    return nil
end

-- ═══ INVENTORY AUTO-DETECTION ═══
-- Checks for all popular inventory systems in priority order

local inventoryDetected = false

-- 1. ox_inventory (most popular, works with ESX/QB-Core/standalone)
if not inventoryDetected and IsResourceStarted('ox_inventory') then
    local exp = TryExport('ox_inventory')
    if exp then
        InventoryExport = exp
        InventorySystem = "ox_inventory"
        inventoryDetected = true
        print("^2[Waffen] ^7✅ Inventory detected: ox_inventory^0")
    end
end

-- 2. qs-inventory (Quasar Store)
if not inventoryDetected and IsResourceStarted('qs-inventory') then
    local exp = TryExport('qs-inventory')
    if exp then
        InventoryExport = exp
        InventorySystem = "qs-inventory"
        inventoryDetected = true
        print("^2[Waffen] ^7✅ Inventory detected: qs-inventory^0")
    end
end

-- 3. codem-inventory
if not inventoryDetected and IsResourceStarted('codem-inventory') then
    local exp = TryExport('codem-inventory')
    if exp then
        InventoryExport = exp
        InventorySystem = "codem-inventory"
        inventoryDetected = true
        print("^2[Waffen] ^7✅ Inventory detected: codem-inventory^0")
    end
end

-- 4. origen_inventory
if not inventoryDetected and IsResourceStarted('origen_inventory') then
    local exp = TryExport('origen_inventory')
    if exp then
        InventoryExport = exp
        InventorySystem = "origen_inventory"
        inventoryDetected = true
        print("^2[Waffen] ^7✅ Inventory detected: origen_inventory^0")
    end
end

-- 5. mf-inventory
if not inventoryDetected and IsResourceStarted('mf-inventory') then
    local exp = TryExport('mf-inventory')
    if exp then
        InventoryExport = exp
        InventorySystem = "mf-inventory"
        inventoryDetected = true
        print("^2[Waffen] ^7✅ Inventory detected: mf-inventory^0")
    end
end

-- 6. tgiann-inventory
if not inventoryDetected and IsResourceStarted('tgiann-inventory') then
    local exp = TryExport('tgiann-inventory')
    if exp then
        InventoryExport = exp
        InventorySystem = "tgiann-inventory"
        inventoryDetected = true
        print("^2[Waffen] ^7✅ Inventory detected: tgiann-inventory^0")
    end
end

-- 7. core_inventory
if not inventoryDetected and IsResourceStarted('core_inventory') then
    local exp = TryExport('core_inventory')
    if exp then
        InventoryExport = exp
        InventorySystem = "core_inventory"
        inventoryDetected = true
        print("^2[Waffen] ^7✅ Inventory detected: core_inventory^0")
    end
end

-- 8. qb-inventory (standalone QB inventory)
if not inventoryDetected and IsResourceStarted('qb-inventory') then
    local exp = TryExport('qb-inventory')
    if exp then
        InventoryExport = exp
        InventorySystem = "qb-inventory"
        inventoryDetected = true
        print("^2[Waffen] ^7✅ Inventory detected: qb-inventory^0")
    end
end

-- 9. lj-inventory (older QB inventory)
if not inventoryDetected and IsResourceStarted('lj-inventory') then
    local exp = TryExport('lj-inventory')
    if exp then
        InventoryExport = exp
        InventorySystem = "lj-inventory"
        inventoryDetected = true
        print("^2[Waffen] ^7✅ Inventory detected: lj-inventory^0")
    end
end

if not inventoryDetected then
    print("^3[Waffen] ^7⚠️ Kein Inventory-System erkannt - nutze Framework-Standard^0")
end

-- ═══ FRAMEWORK DETECTION (ESX / QB-Core) ═══

-- Try to detect ESX
pcall(function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end)
if ESX == nil then
    pcall(function()
        ESX = exports['es_extended']:getSharedObject()
    end)
end

-- Try to detect QB-Core
if not ESX then
    pcall(function()
        QBCore = exports['qb-core']:GetCoreObject()
    end)
end

-- Determine framework
if InventorySystem ~= "none" then
    Framework = InventorySystem
    print("^2[Waffen] ^7Framework: " .. Framework .. "^0")
elseif ESX then
    Framework = "ESX"
    print("^2[Waffen] ^7Framework detected: ESX^0")
elseif QBCore then
    Framework = "QBCore"
    print("^2[Waffen] ^7Framework detected: QB-Core^0")
else
    Framework = "standalone"
    print("^3[Waffen] ^7No framework detected - using standalone mode^0")
end

-- ════════════════════════════════════════════════════════════════
-- AUTHORIZATION
-- ════════════════════════════════════════════════════════════════

-- Check if player is authorized
function IsPlayerAuthorized(source)
    local identifiers = GetPlayerIdentifiers(source)
    
    for _, authorizedId in ipairs(Config.AuthorizedPlayers) do
        for _, playerId in ipairs(identifiers) do
            if playerId == authorizedId then
                return true
            end
        end
    end
    
    -- If no authorized players configured, allow access (for testing)
    if #Config.AuthorizedPlayers == 0 then
        return true
    end
    
    return false
end

-- ════════════════════════════════════════════════════════════════
-- FRAMEWORK-SPECIFIC FUNCTIONS
-- ════════════════════════════════════════════════════════════════

-- Get player object based on framework
function GetPlayer(source)
    if Framework == "ESX" then
        return ESX.GetPlayerFromId(source)
    elseif Framework == "QBCore" then
        return QBCore.Functions.GetPlayer(source)
    end
    return nil
end

-- Add item to player inventory
function AddItem(source, itemName, amount)
    if InventorySystem ~= "none" and InventoryExport then
        -- All detected inventory systems support AddItem export
        local ok, result = pcall(function()
            return InventoryExport:AddItem(source, itemName, amount)
        end)
        if ok and result then
            print("^2[Waffen] ^7" .. InventorySystem .. ": Added " .. itemName .. " x" .. amount .. " to player " .. source .. "^0")
            return true
        else
            print("^1[Waffen] ^7" .. InventorySystem .. ": Failed to add " .. itemName .. " - item might not exist^0")
            return false
        end
    elseif Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            xPlayer.addInventoryItem(itemName, amount)
            print("^2[Waffen] ^7ESX: Added " .. itemName .. " x" .. amount .. " to player " .. source .. "^0")
            return true
        end
    elseif Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            Player.Functions.AddItem(itemName, amount)
            print("^2[Waffen] ^7QB-Core: Added " .. itemName .. " x" .. amount .. " to player " .. source .. "^0")
            return true
        end
    else
        -- Standalone: Send to client
        TriggerClientEvent('waffen:receiveItem', source, itemName, amount)
        print("^2[Waffen] ^7Standalone: Sent item " .. itemName .. " x" .. amount .. " to player " .. source .. "^0")
        return true
    end
    return false
end

-- Add weapon to player
function AddWeapon(source, weaponName, ammo)
    if InventorySystem ~= "none" and InventoryExport then
        -- Inventory systems that support weapon items with metadata
        -- Note: Do NOT set 'durability' here — inventory systems manage durability
        -- internally via their own degrade system. Setting a static value
        -- causes "Haltbarkeit abgelaufen" (durability expired) errors.
        local metadata = {
            ammo = ammo,
            serial = "WF-" .. math.random(100000, 999999)
        }
        local ok, result = pcall(function()
            return InventoryExport:AddItem(source, weaponName, 1, metadata)
        end)
        if ok and result then
            print("^2[Waffen] ^7" .. InventorySystem .. ": Added weapon " .. weaponName .. " with " .. ammo .. " ammo to player " .. source .. "^0")
            return true
        else
            print("^1[Waffen] ^7" .. InventorySystem .. ": Failed to add weapon " .. weaponName .. " - weapon might not exist^0")
            return false
        end
    elseif Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            xPlayer.addWeapon(weaponName, ammo)
            print("^2[Waffen] ^7ESX: Added weapon " .. weaponName .. " with " .. ammo .. " ammo to player " .. source .. "^0")
            return true
        end
    elseif Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            Player.Functions.AddItem(weaponName, 1, false, {ammo = ammo})
            print("^2[Waffen] ^7QB-Core: Added weapon item " .. weaponName .. " with " .. ammo .. " ammo to player " .. source .. "^0")
            return true
        end
    else
        -- Standalone: Send to client for direct weapon give
        TriggerClientEvent('waffen:receiveWeapon', source, weaponName, ammo)
        print("^2[Waffen] ^7Standalone: Sent weapon " .. weaponName .. " to player " .. source .. "^0")
        return true
    end
    return false
end

-- ════════════════════════════════════════════════════════════════
-- WEAPON & ITEM SPAWNING
-- ════════════════════════════════════════════════════════════════

-- Spawn weapon for player
RegisterNetEvent('waffen:spawnWeapon')
AddEventHandler('waffen:spawnWeapon', function(weaponName, ammo)
    local source = source
    
    if not IsPlayerAuthorized(source) then
        print("^1[Waffen] ^7Unauthorized access attempt from player: " .. source .. "^0")
        return
    end
    
    local success = AddWeapon(source, weaponName, ammo or Config.DefaultAmmo)
    if success then
        print("^2[Waffen] ^7✅ Weapon spawned: " .. weaponName .. " for player: " .. source .. "^0")
        TriggerClientEvent('waffen:notify', source, "Waffe gespawnt: " .. weaponName, "success")
    else
        print("^1[Waffen] ^7❌ Failed to spawn weapon: " .. weaponName .. " for player: " .. source .. "^0")
        TriggerClientEvent('waffen:notify', source, "Fehler: " .. weaponName .. " konnte nicht gespawnt werden", "error")
    end
end)

-- Give weapon to another player
RegisterNetEvent('waffen:giveWeapon')
AddEventHandler('waffen:giveWeapon', function(targetId, weaponName, ammo)
    local source = source
    
    if not IsPlayerAuthorized(source) then
        print("^1[Waffen] ^7Unauthorized access attempt from player: " .. source .. "^0")
        return
    end
    
    local success = AddWeapon(targetId, weaponName, ammo or Config.DefaultAmmo)
    if success then
        print("^2[Waffen] ^7✅ Weapon given: " .. weaponName .. " from player: " .. source .. " to player: " .. targetId .. "^0")
        TriggerClientEvent('waffen:notify', source, "Waffe gegeben: " .. weaponName .. " an Spieler " .. targetId, "success")
    else
        print("^1[Waffen] ^7❌ Failed to give weapon from player: " .. source .. " to player: " .. targetId .. "^0")
        TriggerClientEvent('waffen:notify', source, "Fehler: Waffe konnte nicht gegeben werden", "error")
    end
end)

-- Spawn item for player
RegisterNetEvent('waffen:spawnItem')
AddEventHandler('waffen:spawnItem', function(itemName, amount)
    local source = source
    
    if not IsPlayerAuthorized(source) then
        print("^1[Waffen] ^7Unauthorized access attempt from player: " .. source .. "^0")
        return
    end
    
    local success = AddItem(source, itemName, amount or 1)
    if success then
        print("^2[Waffen] ^7✅ Item spawned: " .. itemName .. " x" .. (amount or 1) .. " for player: " .. source .. "^0")
        TriggerClientEvent('waffen:notify', source, "Item gespawnt: " .. itemName .. " x" .. (amount or 1), "success")
    else
        print("^1[Waffen] ^7❌ Failed to spawn item: " .. itemName .. " for player: " .. source .. "^0")
        TriggerClientEvent('waffen:notify', source, "Fehler: " .. itemName .. " konnte nicht gespawnt werden", "error")
    end
end)

-- Give item to another player
RegisterNetEvent('waffen:giveItem')
AddEventHandler('waffen:giveItem', function(targetId, itemName, amount)
    local source = source
    
    if not IsPlayerAuthorized(source) then
        print("^1[Waffen] ^7Unauthorized access attempt from player: " .. source .. "^0")
        return
    end
    
    local success = AddItem(targetId, itemName, amount or 1)
    if success then
        print("^2[Waffen] ^7✅ Item given: " .. itemName .. " x" .. (amount or 1) .. " from player: " .. source .. " to player: " .. targetId .. "^0")
        TriggerClientEvent('waffen:notify', source, "Item gegeben: " .. itemName .. " x" .. (amount or 1) .. " an Spieler " .. targetId, "success")
    else
        print("^1[Waffen] ^7❌ Failed to give item from player: " .. source .. " to player: " .. targetId .. "^0")
        TriggerClientEvent('waffen:notify', source, "Fehler: Item konnte nicht gegeben werden", "error")
    end
end)

-- Check authorization when player requests it
RegisterNetEvent('waffen:checkAuthorization')
AddEventHandler('waffen:checkAuthorization', function()
    local source = source
    local authorized = IsPlayerAuthorized(source)
    TriggerClientEvent('waffen:setAuthorization', source, authorized)
    
    if authorized then
        print("^2[Waffen] ^7Player " .. source .. " is authorized^0")
    else
        print("^3[Waffen] ^7Player " .. source .. " is NOT authorized^0")
    end
end)

print("^2[Waffen Management System] ^7Server loaded successfully^0")
