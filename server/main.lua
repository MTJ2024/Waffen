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

-- Spawn weapon for player
RegisterNetEvent('waffen:spawnWeapon')
AddEventHandler('waffen:spawnWeapon', function(weaponName, ammo)
    local source = source
    
    if not IsPlayerAuthorized(source) then
        print("Unauthorized access attempt from player: " .. source)
        return
    end
    
    TriggerClientEvent('waffen:receiveWeapon', source, weaponName, ammo or Config.DefaultAmmo)
    print("Weapon spawned: " .. weaponName .. " for player: " .. source)
end)

-- Give weapon to another player
RegisterNetEvent('waffen:giveWeapon')
AddEventHandler('waffen:giveWeapon', function(targetId, weaponName, ammo)
    local source = source
    
    if not IsPlayerAuthorized(source) then
        print("Unauthorized access attempt from player: " .. source)
        return
    end
    
    TriggerClientEvent('waffen:receiveWeapon', targetId, weaponName, ammo or Config.DefaultAmmo)
    print("Weapon given: " .. weaponName .. " from player: " .. source .. " to player: " .. targetId)
end)

-- Spawn item for player
RegisterNetEvent('waffen:spawnItem')
AddEventHandler('waffen:spawnItem', function(itemName, amount)
    local source = source
    
    if not IsPlayerAuthorized(source) then
        print("Unauthorized access attempt from player: " .. source)
        return
    end
    
    TriggerClientEvent('waffen:receiveItem', source, itemName, amount or 1)
    print("Item spawned: " .. itemName .. " x" .. (amount or 1) .. " for player: " .. source)
end)

-- Give item to another player
RegisterNetEvent('waffen:giveItem')
AddEventHandler('waffen:giveItem', function(targetId, itemName, amount)
    local source = source
    
    if not IsPlayerAuthorized(source) then
        print("Unauthorized access attempt from player: " .. source)
        return
    end
    
    TriggerClientEvent('waffen:receiveItem', targetId, itemName, amount or 1)
    print("Item given: " .. itemName .. " x" .. (amount or 1) .. " from player: " .. source .. " to player: " .. targetId)
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
