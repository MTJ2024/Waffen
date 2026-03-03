local isAuthorized = false
local uiOpen = false

-- Request authorization status from server when player spawns
Citizen.CreateThread(function()
    Citizen.Wait(1000) -- Wait for player to fully load
    TriggerServerEvent('waffen:checkAuthorization')
end)

-- Receive authorization status from server
RegisterNetEvent('waffen:setAuthorization')
AddEventHandler('waffen:setAuthorization', function(authorized)
    isAuthorized = authorized
    if authorized then
        print("^2[Waffen] ^7Du bist autorisiert für das Waffen-Menü^0")
    else
        print("^1[Waffen] ^7Du bist nicht autorisiert für das Waffen-Menü^0")
    end
end)

-- Infinite ammo thread for authorized players
Citizen.CreateThread(function()
    while true do
        if isAuthorized and Config.InfiniteAmmo then
            local playerPed = PlayerPedId()
            local hasWeapon, currentWeapon = GetCurrentPedWeapon(playerPed)
            
            if hasWeapon and currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
                -- Skip refill while player is actively shooting to prevent
                -- audio engine interruption (SetAmmoInClip during fire breaks sound)
                if not IsPedShooting(playerPed) then
                    local currentAmmo = GetAmmoInPedWeapon(playerPed, currentWeapon)
                    local _, maxAmmo = GetMaxAmmo(playerPed, currentWeapon)
                    local targetAmmo = maxAmmo > 0 and maxAmmo or Config.DefaultAmmo
                    
                    -- Only refill reserve ammo when it drops below half
                    if currentAmmo < targetAmmo / 2 then
                        SetPedAmmo(playerPed, currentWeapon, targetAmmo)
                    end
                    
                    -- Only refill clip when it's actually empty (triggers reload)
                    local _, currentClip = GetAmmoInClip(playerPed, currentWeapon)
                    local maxClip = GetMaxAmmoInClip(playerPed, currentWeapon, true)
                    if maxClip > 0 and currentClip <= 0 then
                        SetAmmoInClip(playerPed, currentWeapon, maxClip)
                    end
                end
            end
            
            Citizen.Wait(200) -- Check at a safe interval
        else
            Citizen.Wait(2000) -- Check less frequently when not active
        end
    end
end)

-- Command to open/close the weapon menu
RegisterCommand(Config.Command, function()
    if isAuthorized then
        ToggleUI()
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"System", "Du hast keine Berechtigung für dieses Menü!"}
        })
    end
end, false)

-- Toggle UI
function ToggleUI()
    uiOpen = not uiOpen
    
    print("^3[Waffen DEBUG] ^7ToggleUI called, uiOpen =", uiOpen)
    
    if uiOpen then
        -- Opening: set focus first, then send NUI message
        SetNuiFocus(true, true)
        print("^3[Waffen DEBUG] ^7SetNuiFocus called with: true")
        
        SendNUIMessage({ action = "toggle", show = true })
        
        Citizen.Wait(50)
        print("^2[Waffen] ^7UI geöffnet^0")
        print("^3[Waffen DEBUG] ^7NUI should now be VISIBLE. Check F8 console!^0")
    else
        -- Closing: send NUI message first, wait for game state to settle,
        -- then release focus. This prevents ox_inventory's keybind handler
        -- from firing a StartShapeTestLosProbe raycast (native 0x8acd366038d14505)
        -- before the camera/ped state is ready after NUI close.
        SendNUIMessage({ action = "toggle", show = false })
        
        Citizen.Wait(200) -- Let game state settle before releasing controls
        
        SetNuiFocus(false, false)
        print("^3[Waffen DEBUG] ^7SetNuiFocus called with: false")
        print("^2[Waffen] ^7UI geschlossen^0")
    end
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
            label = item.label,
            category = item.category or "Sonstiges"
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
    local weaponName = data.weapon
    local amount = data.amount or 1
    local ammo = data.ammo or Config.DefaultAmmo
    
    -- Spawn weapon multiple times if amount > 1
    for i = 1, amount do
        TriggerServerEvent('waffen:spawnWeapon', weaponName, ammo)
    end
    
    cb({success = true, weapon = weaponName, amount = amount})
end)

-- Spawn weapon ammo (from ammo dialog)
RegisterNUICallback('spawnWeaponAmmo', function(data, cb)
    local weaponName = data.weapon
    local ammoAmount = data.amount or 250
    
    -- Get ammo item name from config
    local ammoItem = Config.WeaponAmmo[weaponName]
    if ammoItem then
        TriggerServerEvent('waffen:spawnItem', ammoItem, ammoAmount)
    end
    
    cb({success = true})
end)

-- Give weapon to player
RegisterNUICallback('giveWeapon', function(data, cb)
    TriggerServerEvent('waffen:giveWeapon', data.targetId, data.weapon, data.ammo)
    cb('ok')
end)

-- Spawn item for self
RegisterNUICallback('spawnItem', function(data, cb)
    TriggerServerEvent('waffen:spawnItem', data.item, data.amount)
    -- Note: success here means request was sent; actual result comes via waffen:notify event
    cb({success = true, item = data.item, amount = data.amount or 1})
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
    local weaponHash = GetHashKey(weaponName)
    
    -- Give weapon with 0 ammo first, then set ammo properly
    GiveWeaponToPed(playerPed, weaponHash, 0, false, true)
    
    -- Set total reserve ammo
    SetPedAmmo(playerPed, weaponHash, ammo)
    
    -- Fill the clip directly (no reload animation)
    local maxClip = GetMaxAmmoInClip(playerPed, weaponHash, true)
    if maxClip > 0 then
        SetAmmoInClip(playerPed, weaponHash, maxClip)
    end
    
    SendNUIMessage({
        action = "notify",
        message = "Waffe erhalten: " .. weaponName .. " (" .. ammo .. " Schuss)",
        type = "success"
    })
end)

-- Receive item from server (basic implementation - adapt to your framework)
RegisterNetEvent('waffen:receiveItem')
AddEventHandler('waffen:receiveItem', function(itemName, amount)
    SendNUIMessage({
        action = "notify",
        message = "Item erhalten: " .. itemName .. " x" .. amount,
        type = "success"
    })
    -- Add framework-specific inventory code here
end)

-- Receive notification from server
RegisterNetEvent('waffen:notify')
AddEventHandler('waffen:notify', function(message, notifyType)
    SendNUIMessage({
        action = "notify",
        message = message,
        type = notifyType or "info"
    })
end)
