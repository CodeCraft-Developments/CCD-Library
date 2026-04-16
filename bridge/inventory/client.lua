local Inventory
local ESX
codecraft_lib = codecraft_lib or {}

local function InventoryNotSetup()
    while true do
        Wait(5000)
        print("Please Set You Config Properly in "..GetCurrentResourceName())
    end
end

if Config.Inventory == "auto" then
    if GetResourceState('ox_inventory') == 'started' then 
        Inventory = exports.ox_inventory
    elseif GetResourceState('qb-inventory') == 'started' then
        Inventory = exports['qb-inventory']
    elseif GetResourceState('ps-inventory') == 'started' then
        Inventory = exports['ps-inventory']
    elseif GetResourceState('es_extended') == 'started' and not GetResourceState('ox_inventory') == 'started' then
        Inventory = ESX
    else
        InventoryNotSetup()
    end
elseif Config.Inventory == "ox_inventory" then
    Inventory = exports.ox_inventory
elseif Config.Inventory == "qb-inventory" then
    Inventory = exports['qb-inventory']
elseif Config.Inventory == "ps-inventory" then
    Inventory = exports['ps-inventory']
elseif GetResourceState('es_extended') == 'started' and not GetResourceState('ox_inventory') == 'started' then
    Inventory = ESX
else
    InventoryNotSetup()
end

if Config.Debug then print("CLIENT PRINT INVENTORY "..json.encode(Inventory).."^2 If its a empty [] then its correct ^0") end








exports("import", function()
    return codecraft_lib
end)