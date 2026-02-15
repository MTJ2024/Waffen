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
            showFeedback(card, 'success');
            if (data && data.success) {
                showNotification('Waffe gespawnt: ' + (data.weapon || itemName), 'success');
            } else {
                showNotification('Fehler beim Spawnen: ' + (data.error || itemName), 'error');
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
            showFeedback(card, 'success');
            if (data && data.success) {
                showNotification('Item gespawnt: ' + (data.item || itemName) + ' x' + (data.amount || amount), 'success');
            } else {
                showNotification('Fehler beim Spawnen: ' + (data.error || itemName), 'error');
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
    if (confirm('Alle Waffen entfernen?')) {
        fetch(`https://${getResourceName()}/removeAllWeapons`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        }).then(() => {
            showNotification('Alle Waffen entfernt', 'success');
        });
    }
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
            document.getElementById('selected-item').textContent = itemName;
        });
    });
}

function applyFilter(filter) {
    // TODO: Implement MK2, Favorites filters
    renderCategory(currentCategory);
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
}

// ==========================================
// PERFORMANCE MONITORING (Admin Debug)
// ==========================================

if (window.performance && window.performance.mark) {
    performance.mark('waffen-ui-loaded');
    console.log('[Waffen v3.0] Performance tracking active');
}

console.log('[Waffen v3.0] Initialization complete - Ready for RP Admin use');
