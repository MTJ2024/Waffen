# ✅ SCHNELL-ANLEITUNG - Fehler beheben

## Dein Fehler:
```
TypeError: Failed to fetch
```

## Die Lösung (2 Minuten):

### 1️⃣ Stoppe die Resource
```
stop dein_ordnername
```

### 2️⃣ Benenne den Ordner um
**Auf deinem Server im `resources` Ordner:**

Umbenennen in: **`Waffen`** (genau so, mit großem W!)

**Linux/FTP:**
```bash
mv owner_waffen Waffen
# oder
mv Owner_Waffen Waffen
```

**Windows/FileZilla:**
- Rechtsklick auf Ordner
- "Umbenennen"
- Eingeben: `Waffen`

### 3️⃣ Ändere server.cfg
```cfg
ensure Waffen
```
(nicht `owner_waffen` oder anderes!)

### 4️⃣ Starte Server/Resource neu
```
ensure Waffen
```

### 5️⃣ Fertig! ✅

Drücke **F9** - sollte jetzt funktionieren!

---

## Prüfen ob es funktioniert:

1. **F9** drücken
2. **F8** drücken (Console)
3. Sollte zeigen:
   ```
   [Waffen] UI geöffnet
   [Waffen UI] Resource name from URL: Waffen
   [Waffen UI] Weapons data received: {...}
   ```

**Keine Fetch-Fehler mehr!** ✅

---

## Falls es NICHT funktioniert:

**Prüfe diese 3 Dinge:**

1. **Ordnername** (im resources Ordner):
   ```
   ✅ Waffen          (RICHTIG - genau so!)
   ❌ owner_waffen    (FALSCH)
   ❌ waffen          (FALSCH - kleines w)
   ❌ WAFFEN          (FALSCH - alles groß)
   ```

2. **server.cfg**:
   ```cfg
   ✅ ensure Waffen
   ❌ ensure owner_waffen
   ```

3. **Server neu gestartet?**
   ```
   restart Waffen
   # ODER ganzen Server neu starten
   ```

---

## Detaillierte Anleitungen:

- **UMBENENNEN.md** - Schritt-für-Schritt mit Screenshots
- **RESOURCE_NAME_FIX.md** - Technische Details
- **README.md** - Vollständige Installation

---

**Das war's! Nach dem Umbenennen läuft alles!** 🎉
