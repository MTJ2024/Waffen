# 📋 Changelog

All notable changes to this project will be documented in this file.

---

## [1.0.1] - 2024-02-09

### 🐛 Critical Bug Fix

**Fixed: Authorization System Crash**

#### Issue
- Script crashed with error: `attempt to call a nil value (global 'GetPlayerIdentifiers')`
- Players not recognized even with correct License ID in config
- Resource failed to load completely

#### Root Cause
`GetPlayerIdentifiers()` is a server-side only function in FiveM and was being incorrectly called from client-side code.

#### Solution
- **Moved authorization check to server-side**
- Client now requests authorization status from server
- Server validates identifiers and responds to client
- Proper client-server communication architecture

#### Changes
- **client/main.lua**: Removed client-side GetPlayerIdentifiers, added server request
- **server/main.lua**: Added authorization check event handler
- **config.lua**: Enhanced with clear instructions
- **INSTALLATION.md**: Better ID finding guide
- **TROUBLESHOOTING.md**: New comprehensive troubleshooting guide
- **debug_ids.lua**: New helper script to display player IDs
- **README.md**: Updated installation section

#### New Features
- Console messages show authorization status (server + client)
- Debug helper script for easy ID discovery
- Better error messages and logging

---

## [1.0.0] - 2024-02-09

### ✨ Initial Release

**Professional Weapon & Ammunition Management System for FiveM**

#### Features
- 97+ weapons across 9 categories
- Item management system (10+ items)
- Player interaction (give weapons/items)
- Professional dark-themed UI
- Tab-based navigation
- Real-time search and filtering
- Owner-only access control
- Framework-independent design

#### Components
- Client-side weapon/item handling
- Server-side validation and distribution
- Modern HTML/CSS/JavaScript UI
- Comprehensive configuration system

#### Documentation
- Complete README.md
- Step-by-step INSTALLATION.md
- Detailed FEATURES.md
- Project SUMMARY.md

#### Security
- CodeQL scanned: 0 vulnerabilities
- Server-side validation
- Authorization system

---

## Version History

- **1.0.1** - Critical authorization bug fix
- **1.0.0** - Initial release

---

*For detailed upgrade instructions, see INSTALLATION.md*
