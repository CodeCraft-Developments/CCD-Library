Config = Config or {}

Config.Banner = [[

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ____ ___  ____  _____ ____ ____      _    _____ _____                    
 / ___/ _ \|  _ \| ____/ ___|  _ \    / \  |  ___|_   _|                   
| |  | | | | | | |  _|| |   | |_) |  / _ \ | |_    | |                     
| |__| |_| | |_| | |__| |___|  _ <  / ___ \|  _|   | |                     
 \____\___/|____/|_____\____|_| \_\/_/   \_\_|     |_|                     
                                                                           
 ____  _______     _______ _     ___  ____  __  __ _____ _   _ _____ ____  
|  _ \| ____\ \   / / ____| |   / _ \|  _ \|  \/  | ____| \ | |_   _/ ___| 
| | | |  _|  \ \ / /|  _| | |  | | | | |_) | |\/| |  _| |  \| | | | \___ \ 
| |_| | |___  \ V / | |___| |__| |_| |  __/| |  | | |___| |\  | | |  ___) |
|____/|_____|  \_/  |_____|_____\___/|_|   |_|  |_|_____|_| \_| |_| |____/ 
                                                                           
 _     ___ ____  ____      _    ______   __                                
| |   |_ _| __ )|  _ \    / \  |  _ \ \ / /                                
| |    | ||  _ \| |_) |  / _ \ | |_) \ V /                                 
| |___ | || |_) |  _ <  / ___ \|  _ < | |                                  
|_____|___|____/|_| \_\/_/   \_\_| \_\|_|                                  
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]]

Config.CoreObj = "auto" -- qbcore, qbx_core, ESX or auto

Config.Inventory = "auto" -- ox_inventory, qb-inventory, esx_inventory, ps-inventory or auto

-- Inventory image locations used by codecraft_lib.GetItemImage().
-- Add or override a resource here if your inventory stores images elsewhere.
Config.InventoryImagePaths = {
    ['qb-inventory'] = { 'html/images/%s.png', 'html/images/%s.webp' },
    ['ox_inventory'] = { 'web/images/%s.png', 'web/images/%s.webp' },
    ['ps-inventory'] = { 'html/images/%s.png', 'html/images/%s.webp' },
    ['lj-inventory'] = { 'html/images/%s.png', 'html/images/%s.webp' },
    ['qs-inventory'] = { 'html/images/%s.png', 'html/images/%s.webp' },
    ['core_inventory'] = { 'html/images/%s.png', 'html/images/%s.webp' },
    ['codem-inventory'] = { 'html/images/%s.png', 'html/images/%s.webp' },
    ['tgiann-inventory'] = { 'html/images/%s.png', 'html/images/%s.webp' },
}

Config.Target = "auto" -- ox_target, qb-target or auto

Config.VehicleKeys = "auto" -- qb-vehiclekeys, qbx_vehiclekeys, Renewed-VehicleKeys, wasabi_carlock, jaksam_vehiclekeys or auto

Config.Debug = false -- set to true to enable CCD-Library and bridge debug output on client/server
