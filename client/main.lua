local isAuthorized = false
local uiOpen = false

-- Check if player is authorized
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        
        local playerIdentifiers = {}
        for _, id in ipairs(GetPlayerIdentifiers(PlayerId())) do
            table.insert(playerIdentifiers, id)
        end
        
        for _, authorizedId in ipairs(Config.AuthorizedPlayers) do
            for _, playerId in ipairs(playerIdentifiers) do
                if playerId == authorizedId then
                    isAuthorized = true
                    break
                end
            end
            if isAuthorized then break end
        end
        
        -- If no authorized players configured, allow access (for testing)
        if #Config.AuthorizedPlayers == 0 then
            isAuthorized = true
        end
        
        break
    end
end)

-- Key Press Handler
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if IsControlJustReleased(0, 56) then -- F9 key (56)
            if isAuthorized then
                ToggleUI()
            else
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {"System", "Du hast keine Berechtigung für dieses Menü!"}
                })
            end
        end
    end
end)

-- Toggle UI
function ToggleUI()
    uiOpen = not uiOpen
    SetNuiFocus(uiOpen, uiOpen)
    SendNUIMessage({
        action = "toggle",
        show = uiOpen
    })
end

-- Send weapons list to UI
RegisterNUICallback('getWeapons', function(data, cb)
    local weapons = {}
    local categories = {}
    
    for _, weapon in ipairs(Config.Weapons) do
        if not categories[weapon.category] then
            categories[weapon.category] = {}
        end
        table.insert(categories[weapon.category], {
            name = weapon.name,
            label = weapon.label
        })
    end
    
    cb({weapons = categories})
end)

-- Send items list to UI
RegisterNUICallback('getItems', function(data, cb)
    local items = {}
    for _, item in ipairs(Config.Items) do
        table.insert(items, {
            name = item.name,
            label = item.label
        })
    end
    cb({items = items})
end)

-- Get nearby players
RegisterNUICallback('getPlayers', function(data, cb)
    local players = {}
    local myPed = PlayerPedId()
    local myCoords = GetEntityCoords(myPed)
    
    for _, player in ipairs(GetActivePlayers()) do
        local targetPed = GetPlayerPed(player)
        if targetPed ~= myPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(myCoords - targetCoords)
            
            if distance <= 50.0 then
                table.insert(players, {
                    id = GetPlayerServerId(player),
                    name = GetPlayerName(player),
                    distance = math.floor(distance)
                })
            end
        end
    end
    
    cb({players = players})
end)

-- Spawn weapon for self
RegisterNUICallback('spawnWeapon', function(data, cb)
    TriggerServerEvent('waffen:spawnWeapon', data.weapon, data.ammo)
    cb('ok')
end)

-- Give weapon to player
RegisterNUICallback('giveWeapon', function(data, cb)
    TriggerServerEvent('waffen:giveWeapon', data.targetId, data.weapon, data.ammo)
    cb('ok')
end)

-- Spawn item for self
RegisterNUICallback('spawnItem', function(data, cb)
    TriggerServerEvent('waffen:spawnItem', data.item, data.amount)
    cb('ok')
end)

-- Give item to player
RegisterNUICallback('giveItem', function(data, cb)
    TriggerServerEvent('waffen:giveItem', data.targetId, data.item, data.amount)
    cb('ok')
end)

-- Remove all weapons
RegisterNUICallback('removeAllWeapons', function(data, cb)
    RemoveAllPedWeapons(PlayerPedId(), true)
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        args = {"System", "Alle Waffen wurden entfernt"}
    })
    cb('ok')
end)

-- Close UI
RegisterNUICallback('closeUI', function(data, cb)
    ToggleUI()
    cb('ok')
end)

-- Receive weapon from server
RegisterNetEvent('waffen:receiveWeapon')
AddEventHandler('waffen:receiveWeapon', function(weaponName, ammo)
    local playerPed = PlayerPedId()
    GiveWeaponToPed(playerPed, GetHashKey(weaponName), ammo, false, false)
    SetPedAmmo(playerPed, GetHashKey(weaponName), ammo)
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        args = {"System", "Waffe erhalten: " .. weaponName}
    })
end)

-- Receive item from server (basic implementation - adapt to your framework)
RegisterNetEvent('waffen:receiveItem')
AddEventHandler('waffen:receiveItem', function(itemName, amount)
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        args = {"System", "Item erhalten: " .. itemName .. " x" .. amount}
    })
    -- Add framework-specific inventory code here
end)
