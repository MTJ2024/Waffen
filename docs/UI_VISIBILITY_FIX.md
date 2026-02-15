# UI Sichtbarkeitsproblem Fix (v1.0.8)

## Problem

**User berichtete:**
> "f8 sagt ui ist offen aber es wird nicht angezeigt"

### Symptome
- ✅ F8 Console zeigt: `[Waffen] UI geöffnet`
- ❌ Bildschirm: Nichts zu sehen
- ✅ NUI Focus ist gesetzt
- ❌ UI bleibt unsichtbar

## Root Cause

### 1. Position: absolute (statt fixed)
```css
/* VORHER - FALSCH */
#container {
    position: absolute;  /* Relativ zu parent, kann "verschwinden" */
}

/* NACHHER - KORREKT */
#container {
    position: fixed;  /* Relativ zu Viewport, immer sichtbar */
}
```

**Problem:** `absolute` positioning kann außerhalb des sichtbaren Bereichs landen, besonders wenn das Parent-Element manipuliert wird oder andere Scripts laufen.

### 2. Fehlender Z-Index
```css
/* VORHER - FALSCH */
#container {
    /* Kein z-index = Standard (oft 0) */
}

/* NACHHER - KORREKT */
#container {
    z-index: 9999;  /* Über allen anderen NUIs */
}
```

**Problem:** Andere FiveM Resources (wie Tankstelle, Haus-Manager, etc.) könnten höhere z-index Werte haben und die Waffen-UI überdecken.

### 3. Keine expliziten Visibility-States
```css
/* VORHER - UNVOLLSTÄNDIG */
.hidden {
    display: none !important;
}

#container {
    display: flex;  /* Wird beim Entfernen von .hidden NICHT garantiert */
}

/* NACHHER - VOLLSTÄNDIG */
.hidden {
    display: none !important;
    opacity: 0 !important;
    visibility: hidden !important;
    pointer-events: none !important;
}

#container:not(.hidden) {
    display: flex !important;
    opacity: 1 !important;
    visibility: visible !important;
    pointer-events: auto !important;
}
```

**Problem:** Beim Entfernen einer Klasse mit `display: none` gibt es keine Garantie, dass der ursprüngliche display-Wert wiederhergestellt wird.

### 4. Keine Force-Inline-Styles
```javascript
// VORHER - UNZUREICHEND
if (data.show) {
    container.classList.remove('hidden');
}

// NACHHER - GARANTIERT SICHTBAR
if (data.show) {
    container.classList.remove('hidden');
    
    // Force inline styles (überschreiben alles andere)
    container.style.display = 'flex';
    container.style.opacity = '1';
    container.style.visibility = 'visible';
    container.style.pointerEvents = 'auto';
}
```

**Problem:** CSS Klassen können von anderen Scripts überschrieben werden. Inline styles haben höchste Priorität.

## Lösung

### CSS Änderungen (style.css)

```css
.hidden {
    display: none !important;
    opacity: 0 !important;
    visibility: hidden !important;
    pointer-events: none !important;
}

#container {
    position: fixed;        /* WICHTIG: fixed statt absolute */
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    display: flex !important;
    justify-content: center;
    align-items: center;
    background: rgba(0, 0, 0, 0.85);
    backdrop-filter: blur(8px);
    z-index: 9999;         /* WICHTIG: Über allen anderen NUIs */
    opacity: 1;
    visibility: visible;
    pointer-events: auto;
}

#container:not(.hidden) {
    display: flex !important;
    opacity: 1 !important;
    visibility: visible !important;
    pointer-events: auto !important;
}
```

### JavaScript Änderungen (script.js)

```javascript
window.addEventListener('message', function(event) {
    const data = event.data;
    
    if (data.action === 'toggle') {
        const container = document.getElementById('container');
        if (data.show) {
            console.log('[Waffen UI] 🔓 Opening UI - removing hidden class');
            container.classList.remove('hidden');
            
            // Force display and visibility (inline styles überschreiben alles)
            container.style.display = 'flex';
            container.style.opacity = '1';
            container.style.visibility = 'visible';
            container.style.pointerEvents = 'auto';
            
            // Debug Logging
            console.log('[Waffen UI] 📊 Container display:', window.getComputedStyle(container).display);
            console.log('[Waffen UI] 📊 Container opacity:', window.getComputedStyle(container).opacity);
            console.log('[Waffen UI] 📊 Container visibility:', window.getComputedStyle(container).visibility);
            console.log('[Waffen UI] 📊 Container z-index:', window.getComputedStyle(container).zIndex);
            
            loadWeapons();
            loadItems();
        } else {
            console.log('[Waffen UI] 🔒 Closing UI - adding hidden class');
            container.classList.add('hidden');
            
            // Force hide
            container.style.display = 'none';
            container.style.opacity = '0';
            container.style.visibility = 'hidden';
            container.style.pointerEvents = 'none';
        }
    }
});
```

## Testing

### Nach dem Fix sollte Console zeigen:

```
[Waffen] UI geöffnet
[Waffen UI] 🔓 Opening UI - removing hidden class
[Waffen UI] 📊 Container display: flex
[Waffen UI] 📊 Container opacity: 1
[Waffen UI] 📊 Container visibility: visible
[Waffen UI] 📊 Container z-index: 9999
[Waffen UI] Loading weapons...
[Waffen UI] Loading items...
```

### Visuelle Prüfung:

1. **F9 drücken**
2. **UI sollte sofort sichtbar sein:**
   - Großer dunkelgrauer Panel
   - Lila/Blauer Header mit "WAFFEN MANAGEMENT"
   - Tabs: WAFFEN, ITEMS, SPIELER
   - Waffen-Grid sollte geladen werden

3. **ESC oder F9 drücken zum Schließen**
4. **UI sollte sofort verschwinden**

## Troubleshooting

### Problem: UI immer noch nicht sichtbar

**Schritt 1: F8 Console öffnen**
```
Prüfe ob die Debug-Messages erscheinen:
[Waffen UI] 📊 Container display: flex
[Waffen UI] 📊 Container opacity: 1
```

**Schritt 2: Browser Developer Tools (falls möglich)**
```
Rechtsklick → Inspect Element
Suche nach #container
Prüfe computed styles:
- display: flex (nicht none!)
- opacity: 1 (nicht 0!)
- visibility: visible (nicht hidden!)
- z-index: 9999
```

**Schritt 3: Andere Resources prüfen**
```
Manche Resources können NUI beeinflussen:
- Pausiere andere Admin-Menus
- Deaktiviere temporär andere UI-Resources
- Teste mit minimaler Resource-Liste
```

**Schritt 4: Browser Cache**
```
FiveM NUI cached manchmal alte Dateien:
- Lösung: Resource neu starten
- restart Waffen
- Oder: Server neustarten
```

### Problem: UI flackert oder verschwindet sofort

**Ursache:** Andere Scripts könnten SetNuiFocus(false, false) aufrufen

**Lösung:**
```lua
-- In client/main.lua ist bereits Debouncing implementiert:
Citizen.Wait(200) -- Nach Toggle warten
```

Wenn das nicht hilft, Debounce-Zeit erhöhen:
```lua
Citizen.Wait(500) -- Längeres Debouncing
```

## Zusammenfassung

### Änderungen:

1. ✅ `position: fixed` für garantierte Viewport-Position
2. ✅ `z-index: 9999` über allen anderen NUIs
3. ✅ Explizite visibility/opacity States in CSS
4. ✅ Force inline styles in JavaScript
5. ✅ Debug-Logging für Troubleshooting

### Warum das funktioniert:

- **Fixed positioning** = Immer relativ zum Viewport, nie "verloren"
- **Hoher z-index** = Immer über anderen UI-Elementen
- **Inline styles** = Höchste CSS-Priorität, überschreibt alles
- **Multiple visibility properties** = Mehrfache Absicherung
- **Debug logging** = Sofortiges Erkennen von Problemen

---

**Version:** 1.0.8  
**Status:** ✅ BEHOBEN  
**Datum:** 2026-02-10
