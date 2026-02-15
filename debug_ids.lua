-- ════════════════════════════════════════════════════════════════
-- DEBUG HELPER - Zeigt deine IDs an
-- ════════════════════════════════════════════════════════════════
-- 
-- ANLEITUNG:
-- 1. Füge diese Datei temporär zum fxmanifest.lua hinzu:
--    server_scripts {
--        'server/main.lua',
--        'debug_ids.lua'  -- <-- Diese Zeile hinzufügen
--    }
-- 
-- 2. Starte den Server neu: restart Waffen
-- 
-- 3. Verbinde dich mit dem Server
-- 
-- 4. Schaue in die Server Console - Deine IDs werden angezeigt!
-- 
-- 5. Kopiere die angezeigte License ID in deine config.lua
-- 
-- 6. WICHTIG: Entferne diese Datei wieder aus dem fxmanifest.lua
--    und starte neu, damit sie nicht dauerhaft läuft!
-- 
-- ════════════════════════════════════════════════════════════════

print("^3════════════════════════════════════════════════════════════════^0")
print("^3  DEBUG HELPER AKTIV - Zeigt alle Spieler-IDs beim Verbinden^0")
print("^3════════════════════════════════════════════════════════════════^0")

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local source = source
    
    -- Warte kurz damit die Identifiers verfügbar sind
    Citizen.SetTimeout(100, function()
        local identifiers = GetPlayerIdentifiers(source)
        
        if identifiers then
            print("^2════════════════════════════════════════════════════════════════^0")
            print("^2  SPIELER VERBINDET: " .. playerName .. " (ID: " .. source .. ")^0")
            print("^2════════════════════════════════════════════════════════════════^0")
            print("^6  Alle IDs für diesen Spieler:^0")
            print("")
            
            local licenseId = nil
            local steamId = nil
            
            for _, id in ipairs(identifiers) do
                if string.match(id, "^license:") then
                    licenseId = id
                    print("^2  ✓ LICENSE ID: " .. id .. "^0")
                elseif string.match(id, "^steam:") then
                    steamId = id
                    print("^5  ✓ STEAM ID:   " .. id .. "^0")
                else
                    print("^7    - " .. id .. "^0")
                end
            end
            
            print("")
            print("^3  ► KOPIERE EINE DIESER IDs IN DEINE CONFIG.LUA:^0")
            print("")
            
            if licenseId then
                print('^2  Config.AuthorizedPlayers = {^0')
                print('^2      "' .. licenseId .. '",  -- ' .. playerName .. '^0')
                print('^2  }^0')
            end
            
            if steamId and licenseId then
                print("")
                print("^6  ODER mit Steam ID:^0")
                print("")
                print('^5  Config.AuthorizedPlayers = {^0')
                print('^5      "' .. steamId .. '",  -- ' .. playerName .. '^0')
                print('^5  }^0')
            end
            
            print("")
            print("^2════════════════════════════════════════════════════════════════^0")
            print("")
        end
    end)
end)

print("^3DEBUG HELPER bereit! Verbinde dich mit dem Server um deine IDs zu sehen.^0")
