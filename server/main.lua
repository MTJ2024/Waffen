-- ════════════════════════════════════════════════════════════════
-- FRAMEWORK DETECTION & INTEGRATION
-- ════════════════════════════════════════════════════════════════

ESX = nil
QBCore = nil
Framework = "standalone"

-- Try to detect ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
if ESX == nil then
    -- Try new ESX export
    ESX = exports['es_extended']:getSharedObject()
end

-- Try to detect QB-Core
if not ESX then
    QBCore = exports['qb-core']:GetCoreObject()
end

-- Determine framework
if ESX then
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
    if Framework == "ESX" then
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
    if Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            xPlayer.addWeapon(weaponName, ammo)
            print("^2[Waffen] ^7ESX: Added weapon " .. weaponName .. " with " .. ammo .. " ammo to player " .. source .. "^0")
            return true
        end
    elseif Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            -- QB-Core uses weapon items
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
    else
        print("^1[Waffen] ^7❌ Failed to spawn weapon: " .. weaponName .. " for player: " .. source .. "^0")
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
    else
        print("^1[Waffen] ^7❌ Failed to give weapon from player: " .. source .. " to player: " .. targetId .. "^0")
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
    else
        print("^1[Waffen] ^7❌ Failed to spawn item: " .. itemName .. " for player: " .. source .. "^0")
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
    else
        print("^1[Waffen] ^7❌ Failed to give item from player: " .. source .. " to player: " .. targetId .. "^0")
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
