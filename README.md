# 🔫 Waffen Management System

Ein professionelles Waffen- und Munitions-Verwaltungssystem für FiveM Server mit einer hochmodernen Benutzeroberfläche.

## ✨ Features

- **🔫 Waffen-Management**
  - Über 100 verschiedene Waffen aus allen Kategorien
  - Pistolen, SMGs, Schrotflinten, Sturmgewehre, Scharfschützengewehre, Schwere Waffen, etc.
  - Kategorie-basierte Filterung
  - Suchfunktion für schnelles Finden
  - Anpassbare Munitionsmenge

- **📦 Item-Management**
  - Vorkonfigurierte Items (Verbände, Wasser, Brot, etc.)
  - Einfach erweiterbar in der Config
  - Mengenauswahl

- **👥 Spieler-Management**
  - Zeigt Spieler im Umkreis von 50m
  - Waffen an Spieler geben
  - Items an Spieler geben
  - Live-Entfernungsanzeige

- **🎨 Professionelle UI**
  - Modernes, dunkles Design
  - Responsive und übersichtlich
  - Animationen und Hover-Effekte
  - Tab-basierte Navigation
  - Suchfunktionen

- **🔒 Sicherheit**
  - Owner-Only Zugriff
  - Identifier-basierte Autorisierung
  - Server-seitige Validierung

## 📥 Installation

1. Lade das Resource herunter
2. **WICHTIG**: Benenne den Ordner in `Waffen` um (genau so, Groß/Kleinschreibung beachten!)
3. Kopiere den `Waffen` Ordner in deinen FiveM Server `resources` Ordner
4. **Wichtig**: Finde deine License ID (siehe unten)
5. Öffne die `config.lua` und füge deine License ID hinzu:
```lua
Config.AuthorizedPlayers = {
    "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",  -- Deine License ID
}
```
6. Füge `ensure Waffen` zu deiner `server.cfg` hinzu
7. Starte deinen Server

### ⚠️ KRITISCH: Resource-Name muss "Waffen" sein!

Dein Ordner MUSS genau **"Waffen"** heißen (mit großem W), sonst gibt es `TypeError: Failed to fetch` Fehler.

**Richtig:** ✅
```
resources/Waffen/
server.cfg: ensure Waffen
```

**Falsch:** ❌
```
resources/owner_waffen/     ← Umbenennen!
resources/waffen/           ← Großes W fehlt!
resources/Owner_Waffen/     ← Falscher Name!
```

### 🔍 License ID finden

**Methode 1: Debug Helper (Einfachste Methode)**
1. Verbinde dich mit deinem Server
2. Schaue in die **Server Console** (nicht F8!)
3. Du siehst: `Player Connecting: DeinName (license:xxxxx...)`
4. Kopiere die komplette License ID

**Methode 2: Mit Debug Script**
1. Öffne `fxmanifest.lua`
2. Füge `'debug_ids.lua'` zu den `server_scripts` hinzu
3. Restart Waffen
4. Verbinde dich - Deine IDs werden in der Console angezeigt!
5. Entferne `debug_ids.lua` wieder nach dem Kopieren

Siehe **TROUBLESHOOTING.md** für detaillierte Hilfe!

## 🎮 Verwendung

- Drücke **F9** um das Menü zu öffnen (nur für autorisierte Spieler)
- Navigiere zwischen den Tabs: Waffen, Items, Spieler
- Nutze die Suchfunktion um schnell zu finden, was du brauchst
- Spawne Waffen/Items für dich selbst oder gebe sie an Spieler weiter

### Waffen Tab
- Suche nach Waffen mit der Suchleiste
- Filtere nach Kategorie
- Stelle die Munitionsmenge ein
- Klicke auf "Spawnen" um die Waffe zu erhalten
- "Alle Waffen entfernen" - Entfernt alle Waffen von dir

### Items Tab
- Suche nach Items
- Stelle die Anzahl ein
- Klicke auf "Spawnen" um das Item zu erhalten

### Spieler Tab
- Klicke auf "Spielerliste aktualisieren" um nahegelegene Spieler zu sehen
- Wähle eine Waffe oder ein Item aus dem Dropdown
- Klicke auf "Waffe/Item geben" um es dem Spieler zu geben

## ⚙️ Konfiguration

Die `config.lua` Datei enthält alle Einstellungen:

```lua
-- Autorisierte Spieler
Config.AuthorizedPlayers = {}

-- Standard-Munitionsmenge
Config.DefaultAmmo = 250

-- Tastenbindung zum Öffnen
Config.OpenKey = 'F9'
```

### Waffen hinzufügen

Neue Waffen können einfach in der `Config.Weapons` Tabelle hinzugefügt werden:

```lua
{name = "WEAPON_NAME", label = "Waffenname", category = "Kategorie"},
```

### Items hinzufügen

Neue Items können in der `Config.Items` Tabelle hinzugefügt werden:

```lua
{name = "item_name", label = "Item Name"},
```

## 🔧 Framework Integration

Dieses Resource ist Framework-unabhängig konzipiert. Für die Item-Verwaltung musst du eventuell Anpassungen vornehmen:

### ESX Integration
In `client/main.lua` bei `waffen:receiveItem`:
```lua
ESX.TriggerServerCallback('esx_inventory:addInventoryItem', function()
end, itemName, amount)
```

### QB-Core Integration
In `client/main.lua` bei `waffen:receiveItem`:
```lua
TriggerServerEvent('QBCore:Server:AddItem', itemName, amount)
```

## 📝 Changelog

### Version 1.0.0
- Initiales Release
- Waffen-Management System
- Item-Management System
- Spieler-Interaktion
- Professionelle UI

## 🤝 Support

Bei Fragen oder Problemen erstelle ein Issue auf GitHub.

## 📜 Lizenz

Dieses Projekt ist Open Source. Du darfst es für deine eigenen Server verwenden und anpassen.

## 🎯 Roadmap

- [ ] Weapon Tint Support
- [ ] Weapon Attachments/Components
- [ ] Mehr vordefinierte Items
- [ ] Admin Logs
- [ ] Discord Webhook Integration
- [ ] Multi-Language Support

---

**Made with ❤️ for the FiveM Community**
