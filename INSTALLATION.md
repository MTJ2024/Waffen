# 🚀 Installations-Anleitung

## Schritt 1: Download

Lade das Resource von GitHub herunter oder klone es:
```bash
git clone https://github.com/MTJ2024/Waffen.git
```

## Schritt 2: Installation auf dem Server

1. Kopiere den gesamten `Waffen` Ordner in deinen FiveM Server Ordner unter `resources/`
   - Beispiel: `server/resources/Waffen/`

2. Die Ordnerstruktur sollte so aussehen:
```
resources/
└── Waffen/
    ├── client/
    │   └── main.lua
    ├── server/
    │   └── main.lua
    ├── html/
    │   ├── index.html
    │   ├── style.css
    │   ├── script.js
    │   └── logo.png
    ├── config.lua
    ├── fxmanifest.lua
    └── README.md
```

## Schritt 3: Autorisierung konfigurieren

1. Öffne `config.lua` mit einem Texteditor

2. Finde deine Steam ID oder License ID:
   - **License ID finden** (EMPFOHLEN):
     - Starte deinen FiveM Server
     - Verbinde dich mit dem Server
     - Öffne die Server Console (F8 im Server-Terminal)
     - Suche nach einer Zeile die so aussieht: `[system] Player Connecting: YourName (license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)`
     - Die License ID ist der komplette String: `license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`
     - Kopiere die gesamte License ID inklusive `license:`
   
   - **Steam ID finden** (Alternative):
     - Gehe zu https://steamid.io/
     - Gib deinen Steam Profil Link ein
     - Kopiere die SteamID64 (z.B. 76561198012345678)
     - Konvertiere zu FiveM Format: Entferne die ersten 7 Ziffern (7656119) und füge `steam:` davor
     - Beispiel: 76561198012345678 → `steam:8012345678` (ohne die ersten 7 Ziffern von der SteamID64)
     - ODER einfacher: Schaue in der Server Console nach `steam:110000xxxxxxxx`

3. Trage deine ID in die Config ein:
```lua
Config.AuthorizedPlayers = {
    "steam:110000xxxxxxxx",  -- Deine Steam ID
    -- oder
    "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",  -- Deine License ID
}
```

4. Du kannst mehrere IDs hinzufügen:
```lua
Config.AuthorizedPlayers = {
    "steam:110000111111111",
    "steam:110000222222222",
    "license:abc123...",
}
```

## Schritt 4: Server Config

1. Öffne deine `server.cfg` im Server-Hauptordner

2. Füge diese Zeile hinzu:
```cfg
ensure Waffen
```

3. Optional: Setze es vor andere Resources, wenn du willst, dass es früher lädt:
```cfg
# Core Resources
ensure mapmanager
ensure chat
ensure Waffen
# Andere Resources
```

## Schritt 5: Server starten

1. Starte deinen FiveM Server neu oder verwende den Befehl:
```
restart Waffen
```

2. In der Server Console solltest du sehen:
```
[Waffen Management System] Server loaded successfully
```

## Schritt 6: Testen

1. Verbinde dich mit deinem Server

2. Drücke **F9** um das Menü zu öffnen

3. Wenn du autorisiert bist, sollte sich das Menü öffnen

4. Wenn nicht autorisiert, bekommst du die Nachricht: "Du hast keine Berechtigung für dieses Menü!"

## 🔧 Fehlerbehebung

### Menü öffnet sich nicht
- Überprüfe, ob die Resource läuft: `restart Waffen`
- Überprüfe deine ID in der config.lua
- Schaue in die F8 Console für Fehler

### Waffen spawnen nicht
- Überprüfe die Server Console auf Fehler
- Stelle sicher, dass die Waffen-Namen korrekt sind

### UI wird nicht angezeigt
- Drücke F8 und gib ein: `resmon`
- Schaue, ob "Waffen" in der Liste ist
- Überprüfe Browser Console (F12 in FiveM) für JavaScript Fehler

### Für Entwickler: Testen ohne Autorisierung
- Lasse die `Config.AuthorizedPlayers` Tabelle leer:
```lua
Config.AuthorizedPlayers = {}
```
Dies erlaubt JEDEM Zugriff - nur für Testzwecke!

## 🔄 Updates installieren

1. Sichere deine `config.lua` (kopiere sie woanders hin)
2. Lösche den alten `Waffen` Ordner
3. Kopiere den neuen `Waffen` Ordner
4. Stelle deine `config.lua` wieder her
5. Restart: `restart Waffen`

## 📞 Support

Bei Problemen:
1. Überprüfe die F8 Console im Game
2. Überprüfe die Server Console
3. Erstelle ein Issue auf GitHub mit den Fehlermeldungen
