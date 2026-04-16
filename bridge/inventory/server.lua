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
if Config.Debug then print("SERVER PRINT INVENTORY "..json.encode(Inventory).."^2 If its a empty [] then its correct ^0") end


function codecraft_lib.AddItem(src, item, amount, metadata, slot, cb)
    if Config.Debug then print("codecraft_lib.AddItem() "..src, item, amount, metadata, slot, cb) end
    if GetResourceState('es_extended') == 'started' and not GetResourceState('ox_inventory') == 'started' then
        local xPlayer = Inventory.GetPlayerFromId(src)
        return xPlayer.addInventoryItem(item, amount) 
    else
        return Inventory:AddItem(src, item, amount, metadata, slot, cb)
    end
end

function codecraft_lib.RemoveItem(src, item, amount)
    if Config.Debug then print("codecraft_lib.RemoveItem() "..src, item, amount) end
    if GetResourceState('es_extended') == 'started' and not GetResourceState('ox_inventory') == 'started' then
        local xPlayer = Inventory.GetPlayerFromId(src)
        return xPlayer.removeInventoryItem(item, amount) 
    else
        return Inventory:Removeitem(src, item, amount)
    end
end

function codecraft_lib.HasItem(src, item, amount)
    if Config.Debug then print("codecraft_lib.HasItem() "..src, item, amount) end
    if GetResourceState('ox_inventory') == 'started' then 
        return Inventory:GetItemCount(src, item, amount)
    elseif GetResourceState('es_extended') == 'started' and not GetResourceState('ox_inventory') == 'started' then
        local xPlayer = Inventory.GetPlayerFromId(src)
        return xPlayer.getInventoryItem(item)
    else
        return Inventory:HasItem(src, item, amount)
    end
end

function codecraft_lib.CreateStash(id, label, slots, maxWeight, group, coords)
    if Config.Debug then print("codecraft_lib.CreateStash() "..id, label, slots, maxWeight, group, coords) end
    if GetResourceState('ox_inventory') == 'started' then 
        return Inventory:RegisterStash(id, label, slots, maxWeight, group, coords)
    else
        return Inventory:CreateInventory(id, label, maxWeight, slots)
    end
end

function codecraft_lib.forceOpenInventory(src, invType, plyID)
    if Config.Debug then print("codecraft_lib.forceOpenInventory() "..src, invType, plyID) end
    if GetResourceState('ox_inventory') == 'started' then 
        return Inventory:forceOpenInventory(src, invType, plyID)
    else
        return Inventory:OpenInventoryById(src, plyID)
    end
end

exports("import", function()
    return codecraft_lib
end)