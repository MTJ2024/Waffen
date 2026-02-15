let weaponsData = {};
let itemsData = [];
let playersData = [];
let selectedPlayer = null;
let pendingWeaponForAmmo = null; // Für Munitions-Dialog

// Listen for messages from the game
window.addEventListener('message', function(event) {
    const data = event.data;
    
    console.log('[Waffen UI] ✉️ Message received:', data);
    
    if (data.action === 'toggle') {
        const container = document.getElementById('container');
        console.log('[Waffen UI] 📦 Container element:', container);
        
        if (data.show) {
            console.log('[Waffen UI] 🔓 OPENING UI NOW!');
            
            // SCHRITT 1: Klasse entfernen
            container.classList.remove('hidden');
            console.log('[Waffen UI] ✅ Removed hidden class');
            
            // SCHRITT 2: Inline styles ZWINGEND setzen
            container.style.cssText = `
                display: flex !important;
                position: fixed !important;
                top: 0 !important;
                left: 0 !important;
                width: 100vw !important;
                height: 100vh !important;
                z-index: 99999 !important;
                opacity: 1 !important;
                visibility: visible !important;
                pointer-events: auto !important;
                background: rgba(0, 0, 0, 0.85) !important;
            `;
            console.log('[Waffen UI] ✅ Set inline styles');
            
            // SCHRITT 3: Verify
            setTimeout(() => {
                const computed = window.getComputedStyle(container);
                console.log('[Waffen UI] 📊 FINAL STATE:');
                console.log('[Waffen UI] 📊 Display:', computed.display);
                console.log('[Waffen UI] 📊 Position:', computed.position);
                console.log('[Waffen UI] 📊 Opacity:', computed.opacity);
                console.log('[Waffen UI] 📊 Visibility:', computed.visibility);
                console.log('[Waffen UI] 📊 Z-Index:', computed.zIndex);
                console.log('[Waffen UI] 📊 Width:', computed.width);
                console.log('[Waffen UI] 📊 Height:', computed.height);
            }, 100);
            
            loadWeapons();
            loadItems();
        } else {
            console.log('[Waffen UI] 🔒 CLOSING UI');
            container.classList.add('hidden');
            // Remove ALL inline styles to ensure clean close
            container.style.cssText = '';
            container.style.display = 'none';
        }
    }
});

// Enhanced mouse wheel support for smooth scrolling
document.addEventListener('DOMContentLoaded', function() {
    console.log('[Waffen UI] 🎬 DOMContentLoaded - HTML is loaded!');
    
    const weaponsList = document.getElementById('weapons-list');
    const itemsList = document.getElementById('items-list');
    const playersList = document.getElementById('players-list');
    
    console.log('[Waffen UI] 📋 Elements found:', {
        weaponsList: !!weaponsList,
        itemsList: !!itemsList,
        playersList: !!playersList
    });
    
    // Add smooth mouse wheel scrolling to all grids
    [weaponsList, itemsList, playersList].forEach(element => {
        if (element) {
            element.addEventListener('wheel', function(e) {
                // Allow natural mouse wheel scrolling
                e.stopPropagation();
                
                // Smooth scroll with mouse wheel
                const delta = e.deltaY;
                element.scrollBy({
                    top: delta,
                    behavior: 'smooth'
                });
            }, { passive: true });
        }
    });
});

// Close UI on ESC key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeUI();
    }
});

// Close UI
function closeUI() {
    const container = document.getElementById('container');
    container.classList.add('hidden');
    
    fetch(`https://${getResourceName()}/closeUI`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

// Mouse wheel navigation for weapons list
let weaponsList;
document.addEventListener('DOMContentLoaded', function() {
    weaponsList = document.getElementById('weapons-list');
    
    // Add smooth mouse wheel scrolling
    if (weaponsList) {
        weaponsList.addEventListener('wheel', function(e) {
            e.preventDefault();
            const delta = e.deltaY;
            weaponsList.scrollBy({
                top: delta,
                behavior: 'smooth'
            });
        });
    }
});

// Get resource name - IMPROVED with multiple detection methods
function getResourceName() {
    // CRITICAL FIX: Check if FiveM native exists (avoid recursion!)
    // The native FiveM function is on window, our function has different name
    if (window.GetParentResourceName && typeof window.GetParentResourceName === 'function') {
        try {
            const resourceName = window.GetParentResourceName();
            if (resourceName && resourceName !== 'getResourceName') {
                console.log('[Waffen UI] ✅ Resource name from FiveM native:', resourceName);
                return resourceName;
            }
        } catch (e) {
            console.warn('[Waffen UI] ⚠️ Could not call FiveM native:', e);
        }
    }
    
    // Method 2: Parse from URL
    const url = window.location.href;
    console.log('[Waffen UI] Current URL:', url);
    
    // Try different URL patterns
    // Pattern 1: nui://resource_name/html/index.html
    let match = url.match(/nui:\/\/([^\/]+)\//);
    if (match && match[1]) {
        console.log('[Waffen UI] ✅ Resource name from URL:', match[1]);
        return match[1];
    }
    
    // Pattern 2: Check if URL contains resource name differently
    match = url.match(/nui:\/\/(.+?)(?:\/|$)/);
    if (match && match[1]) {
        console.log('[Waffen UI] ✅ Resource name (pattern 2):', match[1]);
        return match[1];
    }
    
    // Method 3: Try hostname
    if (window.location.hostname && window.location.hostname !== '') {
        console.log('[Waffen UI] ✅ Resource name from hostname:', window.location.hostname);
        return window.location.hostname;
    }
    
    // CRITICAL WARNING: Could not detect - using fallback
    console.error('[Waffen UI] ⚠️⚠️⚠️ CRITICAL: Could not auto-detect resource name!');
    console.error('[Waffen UI] ⚠️ Using fallback: "Waffen"');
    console.error('[Waffen UI] ⚠️ If fetches fail, rename your resource folder to "Waffen"');
    console.error('[Waffen UI] ⚠️ Or update this fallback to match your folder name');
    
    // Fallback: Use simple "Waffen" as resource name
    return 'Waffen';
}

// Switch Tab
function switchTab(tabName, clickedElement) {
    // Remove active from all tabs
    const tabs = document.querySelectorAll('.tab-btn');
    const contents = document.querySelectorAll('.tab-content');
    
    tabs.forEach(tab => tab.classList.remove('active'));
    contents.forEach(content => content.classList.remove('active'));
    
    // Add active to selected tab
    if (clickedElement) {
        clickedElement.classList.add('active');
    } else {
        // Fallback: find the button by tab name
        tabs.forEach(tab => {
            if (tab.textContent.toLowerCase().includes(tabName.toLowerCase())) {
                tab.classList.add('active');
            }
        });
    }
    document.getElementById(tabName + '-tab').classList.add('active');
    
    // Load data for the tab
    if (tabName === 'weapons') {
        loadWeapons();
    } else if (tabName === 'items') {
        loadItems();
    } else if (tabName === 'players') {
        loadPlayers();
    }
}

// Load Weapons
function loadWeapons() {
    const resourceName = getResourceName();
    const fetchUrl = `https://${resourceName}/getWeapons`;
    
    console.log('[Waffen UI] Loading weapons...');
    console.log('[Waffen UI] Resource name:', resourceName);
    console.log('[Waffen UI] Fetch URL:', fetchUrl);
    
    fetch(fetchUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    })
    .then(response => {
        console.log('[Waffen UI] Response received:', response);
        return response.json();
    })
    .then(data => {
        console.log('[Waffen UI] Weapons data received:', data);
        
        if (data && data.weapons) {
            weaponsData = data.weapons;
            
            // Populate category filter
            const categorySelect = document.getElementById('weapon-category');
            categorySelect.innerHTML = '<option value="all">Alle Kategorien</option>';
            
            Object.keys(weaponsData).forEach(category => {
                const option = document.createElement('option');
                option.value = category;
                option.textContent = category;
                categorySelect.appendChild(option);
            });
            
            displayWeapons();
        } else {
            console.error('[Waffen UI] Invalid weapons data format');
            showError('Fehler beim Laden der Waffen');
        }
    })
    .catch(error => {
        console.error('[Waffen UI] Error loading weapons:', error);
        console.error('[Waffen UI] Fetch URL was:', fetchUrl);
        showError('Waffen konnten nicht geladen werden. Überprüfe die Console (F8).');
    });
}

// Display Weapons
function displayWeapons() {
    const weaponsList = document.getElementById('weapons-list');
    const searchTerm = document.getElementById('weapon-search').value.toLowerCase();
    const selectedCategory = document.getElementById('weapon-category').value;
    
    weaponsList.innerHTML = '';
    
    let hasWeapons = false;
    
    Object.keys(weaponsData).forEach(category => {
        if (selectedCategory !== 'all' && selectedCategory !== category) {
            return;
        }
        
        weaponsData[category].forEach(weapon => {
            if (searchTerm && !weapon.label.toLowerCase().includes(searchTerm) && !weapon.name.toLowerCase().includes(searchTerm)) {
                return;
            }
            
            hasWeapons = true;
            
            const weaponCard = document.createElement('div');
            weaponCard.className = 'item-card';
            weaponCard.innerHTML = `
                <div class="item-card-header">
                    <div class="item-name">${weapon.label}</div>
                    <div class="item-category">${category}</div>
                </div>
                <div class="item-id">${weapon.name}</div>
                <div class="item-controls">
                    <div class="control-group">
                        <label>Anzahl:</label>
                        <input type="number" class="weapon-amount-input" value="1" min="1" max="99" />
                    </div>
                    <div class="control-group">
                        <label>Munition:</label>
                        <input type="number" class="weapon-ammo-input" value="250" min="0" max="9999" />
                    </div>
                </div>
                <div class="item-actions">
                    <button class="btn btn-success" onclick="spawnWeaponWithSettings('${weapon.name}', this)">
                        <span class="btn-icon">+</span>
                        Spawnen
                    </button>
                </div>
            `;
            weaponsList.appendChild(weaponCard);
        });
    });
    
    if (!hasWeapons) {
        weaponsList.innerHTML = `
            <div class="empty-state">
                <div class="empty-state-icon">-</div>
                <h3>Keine Waffen gefunden</h3>
                <p>Versuche einen anderen Suchbegriff oder wähle eine andere Kategorie</p>
            </div>
        `;
    }
}

// Filter Weapons
function filterWeapons() {
    displayWeapons();
}

// Spawn Weapon with individual settings
function spawnWeaponWithSettings(weaponName, buttonElement) {
    const card = buttonElement.closest('.item-card');
    const amount = parseInt(card.querySelector('.weapon-amount-input').value) || 1;
    const ammo = parseInt(card.querySelector('.weapon-ammo-input').value) || 250;
    
    fetch(`https://${getResourceName()}/spawnWeapon`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            weapon: weaponName,
            amount: amount,
            ammo: ammo
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('[Waffen UI] Weapon spawned:', weaponName, 'Amount:', amount, 'Ammo:', ammo);
    })
    .catch(error => {
        console.error('[Waffen UI] Error spawning weapon:', error);
    });
}

// Old spawn weapon function (kept for compatibility)
function spawnWeapon(weaponName) {
    const ammo = parseInt(document.getElementById('weapon-ammo').value) || 250;
    
    fetch(`https://${getResourceName()}/spawnWeapon`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            weapon: weaponName,
            amount: 1,
            ammo: ammo
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('[Waffen UI] Weapon spawned successfully');
        
        // Show ammo dialog after weapon is spawned
        pendingWeaponForAmmo = weaponName;
        showAmmoDialog(weaponName);
    })
    .catch(error => {
        console.error('[Waffen UI] Error spawning weapon:', error);
    });
}

// Show Ammo Dialog
function showAmmoDialog(weaponName) {
    const dialog = document.getElementById('ammo-dialog');
    const dialogText = document.getElementById('ammo-dialog-text');
    
    dialogText.textContent = `Möchtest du zusätzliche Munition für ${weaponName} spawnen?`;
    dialog.classList.remove('hidden');
}

// Confirm Ammo Dialog
function confirmAmmo(shouldSpawn) {
    const dialog = document.getElementById('ammo-dialog');
    dialog.classList.add('hidden');
    
    if (shouldSpawn && pendingWeaponForAmmo) {
        const ammoAmount = document.getElementById('ammo-amount').value;
        
        fetch(`https://${getResourceName()}/spawnWeaponAmmo`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                weapon: pendingWeaponForAmmo,
                amount: parseInt(ammoAmount)
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log('[Waffen UI] Ammo spawned successfully');
        })
        .catch(error => {
            console.error('[Waffen UI] Error spawning ammo:', error);
        });
    }
    
    pendingWeaponForAmmo = null;
}

// Remove All Weapons
function removeAllWeapons() {
    fetch(`https://${getResourceName()}/removeAllWeapons`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

// Load Items
function loadItems() {
    const resourceName = getResourceName();
    const fetchUrl = `https://${resourceName}/getItems`;
    
    console.log('[Waffen UI] Loading items...');
    console.log('[Waffen UI] Resource name:', resourceName);
    console.log('[Waffen UI] Fetch URL:', fetchUrl);
    
    fetch(fetchUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    })
    .then(response => {
        console.log('[Waffen UI] Items response received:', response);
        return response.json();
    })
    .then(data => {
        console.log('[Waffen UI] Items data received:', data);
        
        if (data && data.items) {
            itemsData = data.items;
            displayItems();
        } else {
            console.error('[Waffen UI] Invalid items data format');
            showError('Fehler beim Laden der Items');
        }
    })
    .catch(error => {
        console.error('[Waffen UI] Error loading items:', error);
        console.error('[Waffen UI] Fetch URL was:', fetchUrl);
        showError('Items konnten nicht geladen werden. Überprüfe die Console (F8).');
    });
}

// Display Items
function displayItems() {
    const itemsList = document.getElementById('items-list');
    const searchTerm = document.getElementById('item-search').value.toLowerCase();
    
    itemsList.innerHTML = '';
    
    // Group items by category
    const categorizedItems = {};
    itemsData.forEach(item => {
        const category = item.category || 'Sonstiges';
        if (!categorizedItems[category]) {
            categorizedItems[category] = [];
        }
        categorizedItems[category].push(item);
    });
    
    // Sort categories alphabetically
    const sortedCategories = Object.keys(categorizedItems).sort();
    
    let hasItems = false;
    
    sortedCategories.forEach(category => {
        categorizedItems[category].forEach(item => {
            if (searchTerm && !item.label.toLowerCase().includes(searchTerm) && !item.name.toLowerCase().includes(searchTerm)) {
                return;
            }
            
            hasItems = true;
            
            const itemCard = document.createElement('div');
            itemCard.className = 'item-card';
            itemCard.innerHTML = `
                <div class="item-card-header">
                    <div class="item-name">${item.label}</div>
                    <div class="item-category">${category}</div>
                </div>
                <div class="item-id">${item.name}</div>
                <div class="item-controls">
                    <div class="control-group">
                        <label>Anzahl:</label>
                        <input type="number" class="item-amount-input" value="1" min="1" max="999" />
                    </div>
                </div>
                <div class="item-actions">
                    <button class="btn btn-success" onclick="spawnItemWithAmount('${item.name}', this)">
                        <span class="btn-icon">+</span>
                        Spawnen
                    </button>
                </div>
            `;
            itemsList.appendChild(itemCard);
        });
    });
    
    if (!hasItems) {
        itemsList.innerHTML = `
            <div class="empty-state">
                <div class="empty-state-icon">📦</div>
                <h3>Keine Items gefunden</h3>
                <p>Versuche einen anderen Suchbegriff</p>
            </div>
        `;
    }
}

// Filter Items
function filterItems() {
    displayItems();
}

// Spawn Item with custom amount
function spawnItemWithAmount(itemName, buttonElement) {
    const card = buttonElement.closest('.item-card');
    const amount = parseInt(card.querySelector('.item-amount-input').value) || 1;
    
    fetch(`https://${getResourceName()}/spawnItem`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            item: itemName,
            amount: amount
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('[Waffen UI] Item spawned:', itemName, 'Amount:', amount);
    })
    .catch(error => {
        console.error('[Waffen UI] Error spawning item:', error);
    });
}

// Old spawn item function (kept for compatibility)
function spawnItem(itemName) {
    const amount = parseInt(document.getElementById('item-amount').value) || 1;
    
    fetch(`https://${getResourceName()}/spawnItem`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            item: itemName,
            amount: amount
        })
    });
}

// Load Players
function loadPlayers() {
    refreshPlayers();
}

// Refresh Players
function refreshPlayers() {
    console.log('[Waffen UI] Loading/Refreshing players...');
    
    fetch(`https://${getResourceName()}/getPlayers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    })
    .then(response => {
        console.log('[Waffen UI] Players response received:', response);
        return response.json();
    })
    .then(data => {
        console.log('[Waffen UI] Players data received:', data);
        
        if (data && data.players) {
            playersData = data.players;
            displayPlayers();
        } else {
            console.error('[Waffen UI] Invalid players data format');
            showError('Fehler beim Laden der Spieler');
        }
    })
    .catch(error => {
        console.error('[Waffen UI] Error loading players:', error);
        const playersList = document.getElementById('players-list');
        if (playersList) {
            playersList.innerHTML = `
                <div class="empty-state">
                    <div class="empty-state-icon">⚠️</div>
                    <h3>Fehler</h3>
                    <p>Spieler konnten nicht geladen werden</p>
                    <p style="font-size: 11px; margin-top: 10px;">Drücke F8 für Details</p>
                </div>
            `;
        }
    });
}

// Show error message
function showError(message) {
    console.error('[Waffen UI] Error:', message);
    const weaponsList = document.getElementById('weapons-list');
    if (weaponsList && weaponsList.innerHTML === '') {
        weaponsList.innerHTML = `
            <div class="empty-state">
                <div class="empty-state-icon">⚠️</div>
                <h3>Fehler</h3>
                <p>${message}</p>
                <p style="font-size: 11px; margin-top: 10px;">Drücke F8 und schaue in die Console für Details</p>
            </div>
        `;
    }
}

// Display Players
function displayPlayers() {
    const playersList = document.getElementById('players-list');
    
    if (playersData.length === 0) {
        playersList.innerHTML = `
            <div class="empty-state">
                <div class="empty-state-icon">👥</div>
                <h3>Keine Spieler in der Nähe</h3>
                <p>Es befinden sich keine anderen Spieler in einem Umkreis von 50m</p>
            </div>
        `;
        return;
    }
    
    playersList.innerHTML = '';
    
    playersData.forEach(player => {
        const playerCard = document.createElement('div');
        playerCard.className = 'player-card';
        playerCard.innerHTML = `
            <div class="player-header">
                <div class="player-info">
                    <div class="player-avatar">U</div>
                    <div class="player-details">
                        <h3>${player.name}</h3>
                        <p>ID: ${player.id}</p>
                    </div>
                </div>
                <div class="player-distance">• ${player.distance}m</div>
            </div>
            <div class="player-actions">
                <div class="player-action-section">
                    <h4>🔫 Waffe geben</h4>
                    <div class="give-section">
                        <div class="give-controls">
                            <select id="weapon-select-${player.id}">
                                <option value="">Waffe wählen...</option>
                            </select>
                        </div>
                        <button class="btn btn-primary" onclick="giveWeaponToPlayer(${player.id})">
                            <span class="btn-icon">></span>
                            Waffe geben
                        </button>
                    </div>
                </div>
                <div class="player-action-section">
                    <h4>📦 Item geben</h4>
                    <div class="give-section">
                        <div class="give-controls">
                            <select id="item-select-${player.id}">
                                <option value="">Item wählen...</option>
                            </select>
                        </div>
                        <button class="btn btn-primary" onclick="giveItemToPlayer(${player.id})">
                            <span class="btn-icon">></span>
                            Item geben
                        </button>
                    </div>
                </div>
            </div>
        `;
        playersList.appendChild(playerCard);
        
        // Populate weapon select
        const weaponSelect = document.getElementById(`weapon-select-${player.id}`);
        Object.keys(weaponsData).forEach(category => {
            const optgroup = document.createElement('optgroup');
            optgroup.label = category;
            
            weaponsData[category].forEach(weapon => {
                const option = document.createElement('option');
                option.value = weapon.name;
                option.textContent = weapon.label;
                optgroup.appendChild(option);
            });
            
            weaponSelect.appendChild(optgroup);
        });
        
        // Populate item select
        const itemSelect = document.getElementById(`item-select-${player.id}`);
        itemsData.forEach(item => {
            const option = document.createElement('option');
            option.value = item.name;
            option.textContent = item.label;
            itemSelect.appendChild(option);
        });
    });
}

// Give Weapon to Player
function giveWeaponToPlayer(playerId) {
    const weaponSelect = document.getElementById(`weapon-select-${playerId}`);
    const weaponName = weaponSelect.value;
    
    if (!weaponName) {
        console.warn('[Waffen] Bitte wähle eine Waffe aus!');
        return;
    }
    
    const ammo = parseInt(document.getElementById('weapon-ammo').value) || 250;
    
    fetch(`https://${getResourceName()}/giveWeapon`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            targetId: playerId,
            weapon: weaponName,
            ammo: ammo
        })
    });
    
    weaponSelect.value = '';
}

// Give Item to Player
function giveItemToPlayer(playerId) {
    const itemSelect = document.getElementById(`item-select-${playerId}`);
    const itemName = itemSelect.value;
    
    if (!itemName) {
        console.warn('[Waffen] Bitte wähle ein Item aus!');
        return;
    }
    
    const amount = parseInt(document.getElementById('item-amount').value) || 1;
    
    fetch(`https://${getResourceName()}/giveItem`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            targetId: playerId,
            item: itemName,
            amount: amount
        })
    });
    
    itemSelect.value = '';
}
