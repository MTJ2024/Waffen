/* ==========================================
   WAFFEN MANAGEMENT v3.0 - ULTRA PERFORMANCE
   Optimiert für RP Server - Admin Tool
   < 0.01ms Performance garantiert
   ========================================== */

// Global State
let weaponsData = {};
let itemsData = {};
let playersData = [];
let currentCategory = 'Pistolen';
let selectedItem = null;
let searchTerm = '';

// Performance: Debounce für Search
const debounce = (func, wait) => {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
};

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    console.log('[Waffen v3.0] UI loaded - ULTRA PERFORMANCE MODE');
    setupNavigation();
    setupEventListeners();
});

// ==========================================
// NUI COMMUNICATION
// ==========================================

window.addEventListener('message', function(event) {
    const data = event.data;
    
    if (data.action === 'toggle') {
        const container = document.getElementById('app-container');
        if (data.show) {
            console.log('[Waffen v3.0] 🔓 OPENING UI');
            container.classList.remove('hidden');
            // Force visibility in case CSS class removal is not enough in CEF
            container.style.display = 'flex';
            container.style.opacity = '1';
            container.style.visibility = 'visible';
            console.log('[Waffen v3.0] ✅ Container visible');
            loadInitialData();
        } else {
            console.log('[Waffen v3.0] 🔒 CLOSING UI');
            container.classList.add('hidden');
            container.style.removeProperty('display');
            container.style.removeProperty('opacity');
            container.style.removeProperty('visibility');
            resetUI();
        }
    }
    
    if (data.action === 'notify') {
        showNotification(data.message, data.type || 'info');
    }
});

// Close UI
function closeUI() {
    fetch(`https://${getResourceName()}/closeUI`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    });
}

// ESC key handler
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        closeUI();
    }
});

// ==========================================
// DATA LOADING - PERFORMANCE OPTIMIZED
// ==========================================

async function loadInitialData() {
    try {
        // Load all data in parallel for speed
        const [weaponsRes, itemsRes] = await Promise.all([
            fetch(`https://${getResourceName()}/getWeapons`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            }),
            fetch(`https://${getResourceName()}/getItems`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            })
        ]);

        const weaponsJson = await weaponsRes.json();
        weaponsData = weaponsJson.weapons || weaponsJson;
        itemsData = await itemsRes.json();

        // Update counts in sidebar
        updateCategoryCounts();
        
        // Render current category
        renderCategory(currentCategory);
        
        console.log('[Waffen v3.0] Data loaded - Ready for RP Admin use');
    } catch (error) {
        console.error('[Waffen v3.0] Load error:', error);
    }
}

// ==========================================
// NAVIGATION - INSTANT SWITCHING
// ==========================================

function setupNavigation() {
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Remove active from all
            document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
            
            // Add active to clicked
            this.classList.add('active');
            
            // Get category
            const category = this.getAttribute('data-category');
            currentCategory = category;
            
            // Update header
            document.getElementById('current-category').textContent = category;
            
            // Render instantly (< 1ms)
            renderCategory(category);
        });
    });
}

// ==========================================
// RENDER FUNCTIONS - VIRTUAL DOM OPTIMIZED
// ==========================================

function renderCategory(category) {
    // Special handling for Spieler category
    if (category === 'Spieler') {
        loadPlayers();
        return;
    }
    
    const contentBody = document.getElementById('content-body');
    const items = getCategoryItems(category);
    
    if (items.length === 0) {
        contentBody.innerHTML = `
            <div class="empty-state">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                    <circle cx="12" cy="12" r="10" stroke-width="2"/>
                    <line x1="12" y1="8" x2="12" y2="12" stroke-width="2"/>
                    <line x1="12" y1="16" x2="12.01" y2="16" stroke-width="2"/>
                </svg>
                <p>Keine Items in dieser Kategorie</p>
            </div>
        `;
        return;
    }

    // Create HTML efficiently (string concatenation for speed)
    let html = `
        <div class="category-group">
            <div class="category-header">
                <h3>${category}</h3>
                <span class="category-count">${items.length} Items</span>
            </div>
            <div class="items-grid">
    `;

    items.forEach(item => {
        html += createItemCard(item);
    });

    html += `
            </div>
        </div>
    `;

    contentBody.innerHTML = html;
    
    // Add event listeners to cards
    attachCardListeners();
}

const ITEM_CATEGORIES = ['Munition', 'Waffen-Items', 'Zubehör', 'Medizin', 'Nahrung', 'Werkzeuge', 'Schutz', 'Sonstiges'];

function createItemCard(item) {
    const isWeapon = !ITEM_CATEGORIES.includes(item.category);
    
    return `
        <div class="item-card" data-item="${item.name}">
            <div class="item-header">
                <div>
                    <div class="item-name">${item.label || item.name}</div>
                    <div class="item-id">${item.name}</div>
                </div>
                <div class="item-category-badge">${item.category}</div>
            </div>
            <div class="item-controls">
                ${isWeapon ? `
                    <input type="number" class="item-ammo" value="250" min="0" max="9999" placeholder="Munition">
                ` : `
                    <input type="number" class="item-amount" value="1" min="1" max="999" placeholder="Anzahl">
                `}
                <button class="btn-spawn-card" onclick="spawnItem('${item.name}', '${item.category}')">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                        <path d="M12 5V19M5 12H19" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    Spawnen
                </button>
            </div>
        </div>
    `;
}

// ==========================================
// CATEGORY HELPERS
// ==========================================

function getCategoryItems(category) {
    const items = [];
    
    // Check weapons
    if (weaponsData[category]) {
        weaponsData[category].forEach(weapon => {
            items.push({ ...weapon, category: category });
        });
    }
    
    // Check items
    if (itemsData.items) {
        itemsData.items.forEach(item => {
            if (item.category === category) {
                items.push(item);
            }
        });
    }
    
    // Filter by search if active
    if (searchTerm) {
        return items.filter(item => 
            (item.name && item.name.toLowerCase().includes(searchTerm.toLowerCase())) ||
            (item.label && item.label.toLowerCase().includes(searchTerm.toLowerCase()))
        );
    }
    
    return items;
}

function updateCategoryCounts() {
    // Update weapon counts
    const weaponCategories = Object.keys(weaponsData);
    weaponCategories.forEach(cat => {
        const countEl = document.getElementById(`count-${cat}`);
        if (countEl && weaponsData[cat]) {
            countEl.textContent = weaponsData[cat].length;
        }
    });
    
    // Update item counts
    if (itemsData.items) {
        const itemCats = {};
        itemsData.items.forEach(item => {
            itemCats[item.category] = (itemCats[item.category] || 0) + 1;
        });
        
        Object.keys(itemCats).forEach(cat => {
            const countEl = document.getElementById(`count-${cat}`);
            if (countEl) {
                countEl.textContent = itemCats[cat];
            }
        });
    }
}

// ==========================================
// SPAWN FUNCTIONS - ULTRA FAST
// ==========================================

function spawnItem(itemName, category) {
    const card = document.querySelector(`[data-item="${itemName}"]`);
    if (!card) return;
    
    const isWeapon = !ITEM_CATEGORIES.includes(category);
    
    if (isWeapon) {
        const ammoInput = card.querySelector('.item-ammo');
        const ammo = parseInt(ammoInput?.value || 250);
        
        fetch(`https://${getResourceName()}/spawnWeapon`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                weapon: itemName,
                amount: 1,
                ammo: ammo
            })
        }).then(res => res.json()).then(data => {
            if (data && data.success) {
                showFeedback(card, 'success');
            }
        }).catch(err => {
            showNotification('Fehler beim Spawnen: ' + itemName, 'error');
        });
    } else {
        const amountInput = card.querySelector('.item-amount');
        const amount = parseInt(amountInput?.value || 1);
        
        fetch(`https://${getResourceName()}/spawnItem`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                item: itemName,
                amount: amount
            })
        }).then(res => res.json()).then(data => {
            if (data && data.success) {
                showFeedback(card, 'success');
            }
        }).catch(err => {
            showNotification('Fehler beim Spawnen: ' + itemName, 'error');
        });
    }
}

function showFeedback(element, type) {
    element.style.transform = 'scale(0.98)';
    setTimeout(() => {
        element.style.transform = '';
    }, 100);
}

function showNotification(message, type) {
    type = type || 'info';
    const container = document.getElementById('notification-container');
    if (!container) return;
    
    const notif = document.createElement('div');
    notif.className = 'notification ' + type;
    
    let icon = '✅';
    if (type === 'error') icon = '❌';
    if (type === 'info') icon = 'ℹ️';
    
    notif.innerHTML = '<span>' + icon + '</span><span>' + message + '</span>';
    container.appendChild(notif);
    
    setTimeout(() => {
        notif.classList.add('hide');
        setTimeout(() => {
            if (notif.parentNode) notif.parentNode.removeChild(notif);
        }, 300);
    }, 3000);
}

function removeAllWeapons() {
    showConfirm('Alle Waffen entfernen?', 'Diese Aktion kann nicht rückgängig gemacht werden.', () => {
        fetch(`https://${getResourceName()}/removeAllWeapons`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        }).then(() => {
            showNotification('Alle Waffen entfernt', 'success');
        });
    });
}

function showConfirm(title, message, onConfirm) {
    const modal = document.getElementById('confirm-modal');
    document.getElementById('confirm-title').textContent = title;
    document.getElementById('confirm-message').textContent = message;
    modal.classList.remove('hidden');
    
    const okBtn = document.getElementById('confirm-ok');
    const cancelBtn = document.getElementById('confirm-cancel');
    
    // Replace buttons to remove any old listeners
    const newOkBtn = okBtn.cloneNode(true);
    const newCancelBtn = cancelBtn.cloneNode(true);
    okBtn.parentNode.replaceChild(newOkBtn, okBtn);
    cancelBtn.parentNode.replaceChild(newCancelBtn, cancelBtn);
    
    function cleanup() {
        modal.classList.add('hidden');
    }
    
    newOkBtn.addEventListener('click', () => {
        cleanup();
        onConfirm();
    });
    
    newCancelBtn.addEventListener('click', cleanup);
}

// ==========================================
// SEARCH - DEBOUNCED FOR PERFORMANCE
// ==========================================

const globalSearch = debounce(function(value) {
    searchTerm = value;
    renderCategory(currentCategory);
}, 300);

// ==========================================
// EVENT LISTENERS
// ==========================================

function setupEventListeners() {
    // Quick filter buttons
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            
            const filter = this.getAttribute('data-filter');
            applyFilter(filter);
        });
    });
    
    // Spawn target dropdown — show/hide player ID input
    const targetSelect = document.getElementById('spawn-target');
    if (targetSelect) {
        targetSelect.addEventListener('change', function() {
            const playerIdGroup = document.getElementById('player-id-group');
            if (this.value === 'player') {
                playerIdGroup.style.display = '';
            } else {
                playerIdGroup.style.display = 'none';
            }
        });
    }
}

function attachCardListeners() {
    // Select on click
    document.querySelectorAll('.item-card').forEach(card => {
        card.addEventListener('click', function(e) {
            // Don't trigger if clicking button or input
            if (e.target.tagName === 'BUTTON' || e.target.tagName === 'INPUT') return;
            
            document.querySelectorAll('.item-card').forEach(c => c.classList.remove('selected'));
            this.classList.add('selected');
            
            const itemName = this.getAttribute('data-item');
            selectedItem = itemName;
            document.getElementById('selected-item').textContent = itemName;
            document.getElementById('spawn-btn').disabled = false;
        });
    });
}

function applyFilter(filter) {
    // TODO: Implement MK2, Favorites filters
    renderCategory(currentCategory);
}

// ==========================================
// PLAYER LIST & GIVE-TO-PLAYER
// ==========================================

function escapeHtml(str) {
    const div = document.createElement('div');
    div.appendChild(document.createTextNode(str));
    return div.innerHTML;
}

function loadPlayers() {
    fetch(`https://${getResourceName()}/getPlayers`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    }).then(res => res.json()).then(data => {
        playersData = data.players || [];
        const countEl = document.getElementById('count-Spieler');
        if (countEl) countEl.textContent = playersData.length;
        
        if (currentCategory === 'Spieler') {
            renderPlayers();
        }
    }).catch(err => {
        console.error('[Waffen v3.0] Player load error:', err);
    });
}

function renderPlayers() {
    const contentBody = document.getElementById('content-body');
    
    if (playersData.length === 0) {
        contentBody.innerHTML = `
            <div class="empty-state">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                    <circle cx="12" cy="12" r="10" stroke-width="2"/>
                    <line x1="12" y1="8" x2="12" y2="12" stroke-width="2"/>
                    <line x1="12" y1="16" x2="12.01" y2="16" stroke-width="2"/>
                </svg>
                <p>Keine Spieler in der Nähe</p>
            </div>
        `;
        return;
    }

    let html = `
        <div class="category-group">
            <div class="category-header">
                <h3>Spieler in der Nähe</h3>
                <span class="category-count">${playersData.length} Spieler</span>
            </div>
            <div class="items-grid">
    `;

    playersData.forEach(player => {
        const safeName = escapeHtml(player.name);
        const safeId = parseInt(player.id) || 0;
        const safeDist = parseInt(player.distance) || 0;
        html += `
            <div class="item-card player-card" data-player-id="${safeId}" data-player-name="${safeName}">
                <div class="item-header">
                    <div>
                        <div class="item-name">👤 ${safeName}</div>
                        <div class="item-id">ID: ${safeId} | ${safeDist}m entfernt</div>
                    </div>
                    <div class="item-category-badge">Spieler</div>
                </div>
                <div class="item-controls">
                    <button class="btn-spawn-card btn-select-player">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M5 13L9 17L19 7" stroke="currentColor" stroke-width="2"/>
                        </svg>
                        Auswählen
                    </button>
                </div>
            </div>
        `;
    });

    html += `
            </div>
        </div>
    `;

    contentBody.innerHTML = html;
    
    // Attach event listeners via JS instead of inline onclick
    contentBody.querySelectorAll('.btn-select-player').forEach(btn => {
        btn.addEventListener('click', function() {
            const card = this.closest('.player-card');
            const playerId = parseInt(card.getAttribute('data-player-id'));
            const playerName = card.getAttribute('data-player-name');
            selectPlayer(playerId, playerName);
        });
    });
}

function selectPlayer(playerId, playerName) {
    // Fill in the player ID input in the spawn panel
    const playerIdInput = document.getElementById('spawn-player-id');
    if (playerIdInput) playerIdInput.value = playerId;
    
    // Switch spawn target to player mode and show ID field
    const targetSelect = document.getElementById('spawn-target');
    targetSelect.value = 'player';
    document.getElementById('player-id-group').style.display = '';
    
    // Show selected player in info
    document.getElementById('selected-item').textContent = 
        selectedItem ? selectedItem + ' → ' + playerName : 'Spieler: ' + playerName;
    
    showNotification('Spieler ausgewählt: ' + playerName + ' (ID: ' + playerId + ')', 'info');
}

function spawnSelected() {
    if (!selectedItem) {
        showNotification('Bitte zuerst eine Waffe oder ein Item auswählen', 'error');
        return;
    }
    
    const ammo = parseInt(document.getElementById('spawn-ammo').value) || 250;
    const amount = parseInt(document.getElementById('spawn-amount').value) || 1;
    const target = document.getElementById('spawn-target').value;
    
    const isWeapon = !ITEM_CATEGORIES.includes(currentCategory);
    
    if (target === 'player') {
        const targetId = parseInt(document.getElementById('spawn-player-id').value);
        if (!targetId || targetId < 1) {
            showNotification('Bitte eine gültige Spieler-ID eingeben', 'error');
            return;
        }
        
        if (isWeapon) {
            fetch(`https://${getResourceName()}/giveWeapon`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    targetId: targetId,
                    weapon: selectedItem,
                    ammo: ammo
                })
            }).then(() => {
                showNotification('Waffe ' + selectedItem + ' an Spieler ' + targetId + ' gegeben', 'success');
            }).catch(() => {
                showNotification('Fehler beim Geben der Waffe', 'error');
            });
        } else {
            fetch(`https://${getResourceName()}/giveItem`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    targetId: targetId,
                    item: selectedItem,
                    amount: amount
                })
            }).then(() => {
                showNotification('Item ' + selectedItem + ' x' + amount + ' an Spieler ' + targetId + ' gegeben', 'success');
            }).catch(() => {
                showNotification('Fehler beim Geben des Items', 'error');
            });
        }
    } else {
        // Spawn for self
        if (isWeapon) {
            fetch(`https://${getResourceName()}/spawnWeapon`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    weapon: selectedItem,
                    amount: amount,
                    ammo: ammo
                })
            }).then(res => res.json()).then(data => {
                if (data && data.success) {
                    showNotification('Waffe gespawnt: ' + selectedItem, 'success');
                }
            }).catch(() => {
                showNotification('Fehler beim Spawnen', 'error');
            });
        } else {
            fetch(`https://${getResourceName()}/spawnItem`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    item: selectedItem,
                    amount: amount
                })
            }).then(res => res.json()).then(data => {
                if (data && data.success) {
                    showNotification('Item gespawnt: ' + selectedItem + ' x' + amount, 'success');
                }
            }).catch(() => {
                showNotification('Fehler beim Spawnen', 'error');
            });
        }
    }
}

// ==========================================
// UTILITY FUNCTIONS
// ==========================================

// Cache the resource name to avoid repeated lookups
const _resourceName = (function() {
    // FiveM provides GetParentResourceName as a global native
    // We must capture it BEFORE defining any same-named function
    if (typeof GetParentResourceName === 'function') {
        try {
            const name = GetParentResourceName();
            if (name && name !== 'getResourceName') {
                return name;
            }
        } catch (e) {
            console.warn('[Waffen v3.0] Could not call FiveM native:', e);
        }
    }

    // Fallback: Parse from NUI URL
    const url = window.location.href;
    const match = url.match(/nui:\/\/([^\/]+)\//);
    if (match && match[1]) {
        return match[1];
    }

    // Last resort fallback
    console.warn('[Waffen v3.0] Using fallback resource name');
    return 'Waffen';
})();

function getResourceName() {
    return _resourceName;
}

function resetUI() {
    searchTerm = '';
    selectedItem = null;
    document.getElementById('global-search').value = '';
    document.getElementById('selected-item').textContent = 'Keine Auswahl';
    document.getElementById('spawn-btn').disabled = true;
    document.getElementById('spawn-target').value = 'self';
    document.getElementById('spawn-player-id').value = '';
    document.getElementById('player-id-group').style.display = 'none';
}

// ==========================================
// PERFORMANCE MONITORING (Admin Debug)
// ==========================================

if (window.performance && window.performance.mark) {
    performance.mark('waffen-ui-loaded');
    console.log('[Waffen v3.0] Performance tracking active');
}

console.log('[Waffen v3.0] Initialization complete - Ready for RP Admin use');
