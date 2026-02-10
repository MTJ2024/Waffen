# 🔧 Ordner umbenennen - SO GEHT'S!

## Das Problem
Du bekommst diese Fehler:
```
[Waffen UI] Error loading weapons: TypeError: Failed to fetch
[Waffen UI] Error loading items: TypeError: Failed to fetch
```

## Die Lösung
Dein Resource-Ordner muss **genau "Waffen"** heißen (mit großem W)!

---

## Schritt-für-Schritt Anleitung

### Schritt 1: Server stoppen
```
stop Waffen
# oder
stop owner_waffen
# oder wie auch immer dein Ordner aktuell heißt
```

### Schritt 2: Ordner umbenennen

**Auf deinem Server:**
1. Gehe zum `resources` Ordner
2. Finde deinen aktuellen Ordner (z.B. `owner_waffen` oder `Owner_Waffen`)
3. Benenne ihn um in: **`Waffen`** (genau so, mit großem W!)

**Linux:**
```bash
cd resources/
mv owner_waffen Waffen
# oder
mv Owner_Waffen Waffen
```

**Windows:**
```
Rechtsklick → Umbenennen → "Waffen" eingeben
```

### Schritt 3: server.cfg anpassen

Öffne deine `server.cfg` und ändere:

**VORHER:** ❌
```cfg
ensure owner_waffen
```

**NACHHER:** ✅
```cfg
ensure Waffen
```

### Schritt 4: Server starten
```
ensure Waffen
# oder starte den ganzen Server neu
```

### Schritt 5: Testen
1. Verbinde zum Server
2. Drücke **F9**
3. UI sollte sich öffnen
4. Drücke **F8** um Console zu sehen

**Erwartete Ausgabe (ERFOLG):** ✅
```
[Waffen] UI geöffnet
[Waffen UI] Resource name from URL: Waffen
[Waffen UI] Fetch URL: https://Waffen/getWeapons
[Waffen UI] Weapons data received: {...}
[Waffen UI] Loading items...
[Waffen UI] Items data received: {...}
```

**Falls weiterhin Fehler:** ❌
```
[Waffen UI] Could not detect resource name, using fallback
[Waffen UI] Error loading weapons: TypeError: Failed to fetch
```
→ Prüfe nochmal den Ordnernamen!

---

## Checkliste

- [ ] Server gestoppt
- [ ] Ordner heißt jetzt **"Waffen"** (mit großem W)
- [ ] server.cfg hat `ensure Waffen`
- [ ] Server neu gestartet
- [ ] F9 gedrückt
- [ ] F8 gedrückt und Console geprüft
- [ ] Keine Fetch-Fehler mehr
- [ ] Waffen und Items werden geladen

---

## Häufige Fehler

### ❌ Falsche Groß-/Kleinschreibung
```
waffen         ← Kleines w = FALSCH
WAFFEN         ← Alles groß = FALSCH
Waffen         ← Genau so! = RICHTIG ✅
```

### ❌ Falscher Name
```
owner_waffen   ← Alter Name = FALSCH
Owner_Waffen   ← Anderer Name = FALSCH
Waffen         ← Genau so! = RICHTIG ✅
```

### ❌ server.cfg nicht angepasst
```cfg
# server.cfg hat noch:
ensure owner_waffen   ← FALSCH!

# Muss sein:
ensure Waffen         ← RICHTIG ✅
```

---

## Warum ist das wichtig?

FiveM NUI benutzt den Resource-Ordnernamen für interne Kommunikation:
```
https://ORDNERNAME/getWeapons
```

Wenn der Ordner **"owner_waffen"** heißt, aber der Code **"Waffen"** erwartet:
- ❌ `https://Waffen/getWeapons` → Ordner existiert nicht → Failed to fetch
- ✅ `https://owner_waffen/getWeapons` → Ordner existiert → Funktioniert!

**ODER**

Wenn der Ordner **"Waffen"** heißt (wie jetzt im Code):
- ✅ `https://Waffen/getWeapons` → Ordner existiert → Funktioniert!

---

## Immer noch Probleme?

1. **Prüfe den genauen Ordnernamen:**
   ```bash
   ls -la resources/
   # oder in Windows Explorer nachsehen
   ```

2. **Prüfe server.cfg:**
   ```bash
   cat server.cfg | grep ensure
   # Sollte zeigen: ensure Waffen
   ```

3. **Starte FiveM Server komplett neu** (nicht nur resource restart)

4. **Lösche FiveM Cache** (Client-seitig):
   - Windows: `%localappdata%\FiveM\FiveM.app\cache`
   - Ordner löschen und FiveM neu starten

5. **Prüfe Console-Logs** (F8):
   - Was steht bei "Resource name detected"?
   - Welche Fetch URL wird benutzt?

---

## Zusammenfassung

**Du brauchst:**
1. Ordner-Name: `Waffen` (genau so!)
2. server.cfg: `ensure Waffen`
3. Beide müssen exakt übereinstimmen!

**Dann funktioniert's!** ✅

---

**Nach dem Umbenennen sollte alles funktionieren!** 🎉
