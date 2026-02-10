fx_version 'cerulean'
game 'gta5'

author 'Waffen Management System'
description 'Professional Weapon & Ammunition Management System'
version '3.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

-- UI v3.0 - ULTRA PERFORMANCE - Optimized for RP Servers
ui_page 'html/index_v3.html'

files {
    -- v3.0 UI (Production - Ultra Fast)
    'html/index_v3.html',
    'html/style_v3.css',
    'html/script_v3.js',
    
    -- v2.0 UI (Backup)
    'html/index_v2.html',
    
    -- v1.0 UI (Legacy)
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/logo.png'
}
