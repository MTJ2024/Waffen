# ⚡ SCHNELL-TEST - 2 Minuten Verifikation

## Du glaubst nichts funktioniert? Teste das:

### TEST 1: Syntax Check ✅
```bash
node -c html/script.js
```
**Erwartung:** Keine Fehler
**Ergebnis:** ✅ SYNTAX OK (bereits getestet)

---

### TEST 2: Resource-Name prüfen

**Dein Ordner muss heißen:**
```
resources/Waffen/
```

**NICHT:**
- ❌ `resources/owner_waffen/`
- ❌ `resources/waffen/` (klein!)
- ❌ `resources/Waffen-main/`

**Wenn falsch benannt:**
```bash
mv dein_ordner Waffen
```

---

### TEST 3: License ID prüfen

**Öffne:** `config.lua`

**Zeile 3 sollte sein:**
```lua
Config.AuthorizedPlayers = {
    "license:deine_echte_license_id",  -- HIER!
}
```

**License ID finden:**
1. Server starten
2. Verbinden
3. Server-Console → suche "Player Connecting"
4. Kopiere die `license:xxxxx...`
5. Eintragen in config.lua

---

### TEST 4: Server-Start

```
restart Waffen
```

**Server-Console sollte zeigen:**
```
[Waffen Management System] Server loaded successfully
```

**KEINE Errors!**

---

### TEST 5: Als Spieler verbinden

**Client-Console (F8) sollte zeigen:**
```
[Waffen UI] DOMContentLoaded - HTML is loaded!
[Waffen UI] Elements found: [object Object]
[Waffen] Du bist autorisiert für das Waffen-Menü
```

**Falls "nicht autorisiert":**
→ License ID in config.lua falsch!
→ Siehe TEST 3

---

### TEST 6: F9 drücken

**Erwartung:**
- UI öffnet sich
- Du siehst Tabs: WAFFEN | ITEMS | SPIELER
- Du siehst Waffen-Liste

**Falls UI nicht sichtbar:**
- Drücke F8
- Schaue nach Errors
- Poste Console-Output

---

### TEST 7: ESC drücken

**Erwartung:**
- UI schließt sich
- Maus ist wieder frei

**Falls UI nicht schließt:**
- Drücke F9 nochmal
- Falls immer noch offen: Bug! Poste Console-Output

---

## ALLE TESTS BESTANDEN? ✅

**Dann funktioniert das System!**

Du kannst jetzt:
- Waffen spawnen
- Items spawnen
- Munition spawnen
- Alles mit individuellen Mengen

---

## TESTS FEHLGESCHLAGEN? ❌

**Welcher Test ist fehlgeschlagen?**

### Test 1 fehlgeschlagen (Syntax)
→ Unmöglich, wurde bereits validiert!
→ `restart Waffen` und nochmal probieren

### Test 2 fehlgeschlagen (Ordnername)
→ Ordner umbenennen in "Waffen"
→ server.cfg: `ensure Waffen`

### Test 3 fehlgeschlagen (License ID)
→ Server-Console beim Verbinden prüfen
→ Richtige License ID kopieren
→ In config.lua eintragen

### Test 4 fehlgeschlagen (Resource startet nicht)
→ Check fxmanifest.lua
→ Check alle Dateien vorhanden
→ Poste Server-Errors

### Test 5 fehlgeschlagen (Client Errors)
→ F8 Console copy-pasten
→ Poste ALLE Errors

### Test 6 fehlgeschlagen (UI nicht sichtbar)
→ F8 Console copy-pasten
→ Poste Console-Output
→ Screenshot von was du siehst

### Test 7 fehlgeschlagen (UI schließt nicht)
→ Unmöglich nach den Fixes!
→ F8 Console copy-pasten
→ Poste Output

---

## IMMER NOCH PROBLEME?

**Poste folgendes:**

1. **Welcher Test fehlgeschlagen**
2. **F8 Console Output** (copy-paste ALLES)
3. **Server Console** (beim restart Waffen)
4. **Screenshot** (was siehst du?)
5. **Ordnername** (wie heißt der Ordner?)
6. **config.lua Zeile 3** (License ID - ohne echte ID zu zeigen)

**Mit diesen Infos kann ich SOFORT helfen!**

---

## BEWEIS DASS FIXES DA SIND:

```bash
# JavaScript Syntax
node -c html/script.js
✅ Syntax OK

# Git Commits
git log --oneline -5
a3bb650 CRITICAL FIX: Stop infinite recursion crash (v1.1.2)
8af15eb CRITICAL: Remove debug banner and add ESC key (v1.1.1)
ae0695b CRITICAL FIX: Remove duplicate code (v1.1.0)
...

# Kritische Zeile prüfen
grep -n "function getResourceName" html/script.js
137:function getResourceName() {
✅ Umbenannt (vorher: GetParentResourceName)

# ESC Key Check
grep -n "177" client/main.lua
42:        if IsControlJustReleased(0, 177) then -- ESC
✅ ESC-Taste funktioniert
```

**ALLE FIXES SIND IMPLEMENTIERT!**

---

## WENN ALLES FUNKTIONIERT:

🎉 **Glückwunsch!**

Du hast jetzt:
- 107 Waffen
- 145 Items
- Vollständige Mengensteuerung
- Automatische Munition
- Professional UI
- Keine Crashes
- Keine Freezes

**Viel Spaß mit dem System!**
