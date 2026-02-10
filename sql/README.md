# SQL Installation für Waffen-System

## ⚠️ WICHTIG!

**Items müssen ZUERST in deinem Inventar-System existieren, bevor sie gespawnt werden können!**

> "nur die sachen die als item vorhanden sind können auch gespawnt werden"

---

## 🚀 Quick Installation

### Schritt 1: Framework identifizieren

Welches Inventar-System benutzt du?
- ox_inventory → Siehe unten
- ESX → Siehe unten  
- QB-Core → Siehe unten

### Schritt 2: SQL importieren

**ox_inventory:**
```bash
1. Öffne: ox_inventory/data/items.lua
2. Füge die Waffen + Items ein (siehe ox_inventory_items.sql)
3. restart ox_inventory
```

**ESX:**
```bash
1. MySQL: mysql -u root -p esx < esx_items.sql
2. Oder: phpMyAdmin → Import → esx_items.sql
3. restart es_extended
```

**QB-Core:**
```bash
1. Öffne: qb-core/shared/items.lua
2. Füge Items in QBShared.Items ein (siehe qbcore_items.lua)
3. restart qb-core
```

### Schritt 3: Waffen-Script starten

```bash
restart Waffen
```

### Schritt 4: Testen

```
F9 → Item spawnen → Inventar prüfen
```

---

## 📋 Verfügbare SQL-Dateien

1. **ox_inventory_items.sql** - 197 Items für ox_inventory
2. **esx_items.sql** - 197 Items für ESX  
3. **qbcore_items.lua** - 197 Items für QB-Core

---

## ✅ Was die SQL-Dateien enthalten:

### Waffen (107):
- Alle Pistolen, SMGs, Schrotflinten
- Alle Sturmgewehre, MGs, Scharfschützengewehre
- Schwere Waffen, Wurfwaffen, Nahkampf
- Spezial-Waffen

### Items (90):
- Munition (10 Typen)
- Waffen-Zubehör (7 Items)
- Medizin, Nahrung, Werkzeuge
- Schutz, Sonstiges

**Gesamt: 197 Items**

---

## 🔧 Item-Namen wichtig!

**Das Script verwendet diese Namen:**
- `WEAPON_PISTOL`
- `ammo_pistol`
- `bandage`

**Dein Inventar-System MUSS die gleichen Namen haben!**

Wenn nicht → Item kann nicht gespawnt werden!

---

## ⚠️ Troubleshooting

**Problem:** "Item nicht erhalten"

**Lösung:**
1. Prüfe ob Item in items.lua/DB existiert
2. Prüfe item name (Groß-/Kleinschreibung!)
3. Prüfe Server-Console für Fehler
4. restart Inventar-System

**Problem:** "Waffe nicht erhalten"

**Lösung:**
1. Waffen MÜSSEN als Items existieren
2. Nicht GiveWeaponToPed bei ESX/QB/ox
3. SQL/items.lua importieren!

---

## 📖 Mehr Infos

Siehe Haupt-README.md für:
- Framework-Integration
- Troubleshooting
- Features
