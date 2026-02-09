let weaponsData = {};
let itemsData = [];
let playersData = [];
let selectedPlayer = null;

// Listen for messages from the game
window.addEventListener('message', function(event) {
    const data = event.data;
    
    if (data.action === 'toggle') {
        const container = document.getElementById('container');
        if (data.show) {
            container.classList.remove('hidden');
            loadWeapons();
            loadItems();
        } else {
            container.classList.add('hidden');
        }
    }
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
    
    fetch(`https://${GetParentResourceName()}/closeUI`, {
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

// Get resource name
function GetParentResourceName() {
    let queryString = window.location.search;
    return queryString.substring(1);
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
    fetch(`https://${GetParentResourceName()}/getWeapons`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    }).then(response => response.json()).then(data => {
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
                <div class="item-actions">
                    <button class="btn btn-success" onclick="spawnWeapon('${weapon.name}')">
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

// Spawn Weapon for Self
function spawnWeapon(weaponName) {
    const ammo = parseInt(document.getElementById('weapon-ammo').value) || 250;
    
    fetch(`https://${GetParentResourceName()}/spawnWeapon`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            weapon: weaponName,
            ammo: ammo
        })
    });
}

// Remove All Weapons
function removeAllWeapons() {
    if (confirm('Möchtest du wirklich alle Waffen entfernen?')) {
        fetch(`https://${GetParentResourceName()}/removeAllWeapons`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({})
        });
    }
}

// Load Items
function loadItems() {
    fetch(`https://${GetParentResourceName()}/getItems`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    }).then(response => response.json()).then(data => {
        itemsData = data.items;
        displayItems();
    });
}

// Display Items
function displayItems() {
    const itemsList = document.getElementById('items-list');
    const searchTerm = document.getElementById('item-search').value.toLowerCase();
    
    itemsList.innerHTML = '';
    
    let hasItems = false;
    
    itemsData.forEach(item => {
        if (searchTerm && !item.label.toLowerCase().includes(searchTerm) && !item.name.toLowerCase().includes(searchTerm)) {
            return;
        }
        
        hasItems = true;
        
        const itemCard = document.createElement('div');
        itemCard.className = 'item-card';
        itemCard.innerHTML = `
            <div class="item-card-header">
                <div class="item-name">${item.label}</div>
            </div>
            <div class="item-id">${item.name}</div>
            <div class="item-actions">
                <button class="btn btn-success" onclick="spawnItem('${item.name}')">
                    <span class="btn-icon">+</span>
                    Spawnen
                </button>
            </div>
        `;
        itemsList.appendChild(itemCard);
    });
    
    if (!hasItems) {
        itemsList.innerHTML = `
            <div class="empty-state">
                <div class="empty-state-icon">-</div>
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

// Spawn Item for Self
function spawnItem(itemName) {
    const amount = parseInt(document.getElementById('item-amount').value) || 1;
    
    fetch(`https://${GetParentResourceName()}/spawnItem`, {
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
    fetch(`https://${GetParentResourceName()}/getPlayers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    }).then(response => response.json()).then(data => {
        playersData = data.players;
        displayPlayers();
    });
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
        alert('Bitte wähle eine Waffe aus!');
        return;
    }
    
    const ammo = parseInt(document.getElementById('weapon-ammo').value) || 250;
    
    fetch(`https://${GetParentResourceName()}/giveWeapon`, {
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
        alert('Bitte wähle ein Item aus!');
        return;
    }
    
    const amount = parseInt(document.getElementById('item-amount').value) || 1;
    
    fetch(`https://${GetParentResourceName()}/giveItem`, {
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
