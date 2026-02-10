# 🔧 Troubleshooting Guide

## Problem: "attempt to call a nil value (global 'GetPlayerIdentifiers')"

**Status**: ✅ FIXED in latest version

### Ursache
`GetPlayerIdentifiers()` ist eine server-seitige Funktion und kann nicht vom Client aufgerufen werden.

### Lösung
Die Autorisierung wird jetzt korrekt server-seitig durchgeführt:
1. Client fordert beim Spawnen die Autorisierung an
2. Server prüft die License/Steam ID
3. Server sendet das Ergebnis zurück an den Client

---

## Problem: "Er erkennt mich nicht obwohl Lizenz in Config"

### Häufige Ursachen

#### 1. Falsche License ID Format
❌ **FALSCH**:
```lua
Config.AuthorizedPlayers = {
    "1a2b3c4d5e6f7g8h9i0j...",  -- Fehlt "license:" davor
}
```

✅ **RICHTIG**:
```lua
Config.AuthorizedPlayers = {
    "license:1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t",  -- MIT "license:"
}
```

#### 2. License ID falsch kopiert

**So findest du deine korrekte License ID:**

1. Starte deinen Server
2. Verbinde dich mit dem Server
3. Öffne die Server Console (nicht F8 im Spiel, sondern das Terminal-Fenster)
4. Suche nach einer Zeile wie:
   ```
   [system] Player Connecting: DeinName (license:1a2b3c4d5e6f7g8h9i0j...)
   ```
5. Kopiere die **komplette** License ID inklusive `license:`

**Alternative: Steam ID verwenden**

Wenn du Steam verwendest, kannst du auch deine Steam ID nutzen:

1. Schaue in der Server Console nach einer Zeile mit `steam:`
   ```
   [system] Player Connecting: DeinName (steam:110000xxxxxxxx)
   ```
2. Kopiere die Steam ID inklusive `steam:`

#### 3. Resource nicht neu gestartet

Nach Änderungen in der `config.lua`:
```
restart Waffen
```

Oder komplett neu starten:
```
stop Waffen
ensure Waffen
```

#### 4. Syntaxfehler in config.lua

Überprüfe:
- Kommas zwischen Einträgen
- Anführungszeichen korrekt gesetzt
- Keine zusätzlichen Zeichen

```lua
-- RICHTIG:
Config.AuthorizedPlayers = {
    "license:abc123",
    "license:def456",  -- Komma nach jedem Eintrag (außer dem letzten)
}

-- FALSCH:
Config.AuthorizedPlayers = {
    "license:abc123"
    "license:def456",  -- Fehlendes Komma
}
```

---

## Debugging-Schritte

### 1. Server Console überprüfen

Beim Verbinden solltest du sehen:
```
[Waffen] Player 1 is authorized
```
ODER
```
[Waffen] Player 1 is NOT authorized
```

### 2. Client Console überprüfen (F8 im Spiel)

Du solltest sehen:
```
[Waffen] Du bist autorisiert für das Waffen-Menü
```
ODER
```
[Waffen] Du bist nicht autorisiert für das Waffen-Menü
```

### 3. License ID ausgeben lassen

Temporär in `server/main.lua` einfügen (nach Zeile 2):
```lua
RegisterNetEvent('waffen:checkAuthorization')
AddEventHandler('waffen:checkAuthorization', function()
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    
    -- DEBUG: Zeige alle IDs
    print("=== DEBUG: Spieler IDs ===")
    for _, id in ipairs(identifiers) do
        print("  - " .. id)
    end
    print("========================")
    
    local authorized = IsPlayerAuthorized(source)
    TriggerClientEvent('waffen:setAuthorization', source, authorized)
end)
```

Dann schaue in der Console welche IDs angezeigt werden und kopiere die richtige in deine Config.

---

## Test-Modus (NICHT für Production!)

Wenn du nur testen willst, kannst du die Autorisierung temporär deaktivieren:

```lua
Config.AuthorizedPlayers = {}  -- Leere Liste = Jeder hat Zugriff!
```

⚠️ **WARNUNG**: Dies gibt JEDEM auf dem Server Zugriff! Nur für Tests!

---

## Häufige Fehler-Meldungen

### "attempt to call a nil value"
✅ **Gelöst** in der neuesten Version. Aktualisiere das Script.

### "Resource Waffen not found"
- Überprüfe den Ordnernamen (muss genau "Waffen" sein)
- Überprüfe den Pfad in `server.cfg`: `ensure Waffen`

### Menü öffnet sich nicht (F9)
1. Bist du autorisiert? Schaue in die Console
2. Ist die Resource geladen? `resmon` im F8 Console
3. Versuche einen anderen Key in `config.lua`: `Config.OpenKey = 'F10'`

### UI zeigt keine Waffen
- Öffne F12 (Browser DevTools) im Spiel
- Schaue nach JavaScript Errors
- Überprüfe ob `config.lua` korrekt formatiert ist

---

## Support

Wenn nichts hilft:

1. **Server Console Screenshot** - Zeigt ob Resource lädt
2. **F8 Console Screenshot** - Zeigt Client-seitige Errors
3. **Deine config.lua** (ohne echte IDs!) - Zum überprüfen
4. **Fehler-Meldung** - Komplette Error Message

Erstelle ein GitHub Issue mit diesen Informationen.

---

## Quick Fix Checklist

- [ ] License ID mit `license:` davor kopiert
- [ ] Kommas in config.lua korrekt gesetzt
- [ ] Resource neu gestartet: `restart Waffen`
- [ ] Server Console geprüft für Autorisierungs-Nachricht
- [ ] F8 Console geprüft für Client-Nachricht
- [ ] Neueste Version des Scripts verwendet

---

*Letzte Aktualisierung: Nach Fix für GetPlayerIdentifiers Issue*
