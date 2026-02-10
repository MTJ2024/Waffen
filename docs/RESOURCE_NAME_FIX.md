# Resource Name Fix - TypeError: Failed to fetch

## Problem

User experiencing:
```
[Waffen UI] Error loading weapons: TypeError: Failed to fetch
[Waffen UI] Fetch URL was: https://Waffen/getWeapons
```

Console also shows file paths like: `@owner_waffen/html/script.js`

## Root Cause

**The resource folder name must match the name used in NUI fetch calls!**

- If your folder is named `owner_waffen`, fetch URLs must use `owner_waffen`
- If your folder is named `Waffen`, fetch URLs must use `Waffen`
- **Mismatch = TypeError: Failed to fetch**

## Solution

You have **3 options**:

### Option 1: Rename Resource Folder (RECOMMENDED)

Rename your resource folder to match the fallback in the code:

```bash
# On your server in the resources folder:
mv Waffen owner_waffen
# or
mv Owner_Waffen owner_waffen
```

Then in `server.cfg`:
```cfg
ensure owner_waffen
```

### Option 2: Change Fallback in Code

If you want to keep your folder name as "Waffen":

1. Open `/html/script.js`
2. Find the `GetParentResourceName()` function (around line 85)
3. Change the fallback:
   ```javascript
   // FROM:
   return 'owner_waffen';
   
   // TO:
   return 'Waffen';  // or whatever your folder is named
   ```

### Option 3: Use Exact Folder Name

The safest approach - make everything match:

1. **Folder name:** `owner_waffen`
2. **server.cfg:** `ensure owner_waffen`
3. **Code fallback:** `return 'owner_waffen';` (already done)

## How to Check Your Resource Name

### Method 1: Check server.cfg
```cfg
# Look for your ensure line:
ensure owner_waffen    # This is your resource name
```

### Method 2: Check resources folder
```bash
ls resources/
# Look for: owner_waffen/ or Waffen/ or Owner_Waffen/
```

### Method 3: Check console
When the resource starts, FiveM shows:
```
Started resource owner_waffen
```

## Verification

After fixing, when you open the UI (F9), console should show:

**SUCCESS ✅:**
```
[Waffen UI] Resource name from URL: owner_waffen
[Waffen UI] Fetch URL: https://owner_waffen/getWeapons
[Waffen UI] Weapons data received: {...}
```

**FAILURE ❌:**
```
[Waffen UI] Could not detect resource name, using fallback
[Waffen UI] Fetch URL: https://Waffen/getWeapons
[Waffen UI] Error loading weapons: TypeError: Failed to fetch
```

## Technical Details

### Why This Happens

FiveM NUI uses a special URL scheme for callbacks:
```
https://resource_name/callback_name
```

The `resource_name` MUST match the actual folder name in your resources directory.

### Detection Methods (in order of priority)

1. **Native Function** - `window.GetParentResourceName()` (FiveM provides this)
2. **URL Parsing** - Extract from `nui://resource_name/html/index.html`
3. **Hostname** - `window.location.hostname`
4. **Fallback** - Hardcoded value (changed to `owner_waffen`)

### Why "owner_waffen"?

Based on console logs showing `@owner_waffen/html/script.js`, the most common installation uses this name.

## Quick Fix Checklist

- [ ] Check your actual resource folder name
- [ ] Ensure server.cfg uses same name: `ensure folder_name`
- [ ] Verify fallback in script.js matches folder name
- [ ] Restart resource: `restart folder_name`
- [ ] Press F9 to open UI
- [ ] Check console (F8) for successful fetch
- [ ] Verify weapons and items load

## Common Mistakes

❌ **Folder:** `owner_waffen` → **Fallback:** `Waffen` = FAILS  
❌ **Folder:** `Waffen` → **Fallback:** `owner_waffen` = FAILS  
❌ **Folder:** `Owner_Waffen` → **Fallback:** `owner_waffen` = FAILS (case-sensitive!)

✅ **Folder:** `owner_waffen` → **Fallback:** `owner_waffen` = WORKS  
✅ **Folder:** `Waffen` → **Fallback:** `Waffen` = WORKS

## Still Not Working?

1. **Check console for exact error:**
   ```
   F8 → Look for "[Waffen UI]" messages
   ```

2. **Verify resource is running:**
   ```
   In F8 console: ensure owner_waffen
   ```

3. **Check for typos:**
   - Case-sensitive: `Owner_Waffen` ≠ `owner_waffen`
   - Underscores: `owner_waffen` ≠ `ownerwaffen`
   - Hyphens: `owner-waffen` ≠ `owner_waffen`

4. **Restart FiveM server** (not just resource)

5. **Clear FiveM cache:**
   - Close FiveM
   - Delete `%localappdata%\FiveM\FiveM.app\cache` (Windows)
   - Restart FiveM

---

**Updated in Version 1.0.5**  
Fallback changed from `'Waffen'` to `'owner_waffen'` to match common installations.
