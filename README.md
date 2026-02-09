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
2. Kopiere den `Waffen` Ordner in deinen FiveM Server `resources` Ordner
3. Öffne die `config.lua` und füge deine Steam ID oder License ID hinzu:
```lua
Config.AuthorizedPlayers = {
    "steam:110000xxxxxxxx",
    "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
}
```
4. Füge `ensure Waffen` zu deiner `server.cfg` hinzu
5. Starte deinen Server

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
