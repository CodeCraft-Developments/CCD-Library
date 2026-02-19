local Keys
codecraft_lib = {}

local function VehKeysNotSetup()
    while true do 
        Wait(5000)
        print("Please Set You Config Properly in "..GetCurrentResourceName())
    end
end

if Config.VehicleKeys == "auto" then
    if GetResourceState('qb-vehiclekeys') == 'started' then 
        Keys = exports['qb-vehiclekeys']
    elseif GetResourceState('qbx_vehiclekeys') == 'started' then
        Keys = "qbx_vehiclekeys"
    elseif GetResourceState('Renewed-VehicleKeys') == 'started' then
        Keys = exports['Renewed-Vehiclekeys']
    elseif GetResourceState('wasabi_carlock') == 'started' then
        Keys = exports.wasabi_carlock
    else
        VehKeysNotSetup()
    end
elseif Config.VehicleKeys == "qb-vehiclekeys" then
    Keys = exports['qb-vehiclekeys']
elseif Config.VehicleKeys == "qbx_vehiclekeys" then
    Keys = exports.qbx_vehiclekeys
elseif Config.VehicleKeys == "Renewed-VehicleKeys" then
    Keys = exports['Renewed-Vehiclekeys']
elseif Config.VehicleKeys == "wasabi_carlock" then
    Keys = exports.wasabi_carlock
else
    VehKeysNotSetup()  
end
if Config.Debug then print("SERVER PRINT VEHICLEKEYS ^2 If its a empty [] then its correct ^0") end

function codecraft_lib.AddKeys(source, plate)
    if GetResourceState('qb-vehiclekeys') == 'started' then
        Keys:GiveKeys(source, plate)
    elseif GetResourceState('qbx_vehiclekeys') == 'started' then
        Keys:GiveKeys(source, plate)
    elseif GetResourceState('Renewed-VehicleKeys') == 'started' then
        Keys:addKey(source, plate)
    elseif GetResourceState('wasabi_carlock') == 'started' then
        Keys:GiveKey(source, plate)
    end
end

function codecraft_lib.RemoveKeys(source, plate)
    if GetResourceState('qb-vehiclekeys') == 'started' then
        Keys:RemoveKeys(source, plate)
    elseif GetResourceState('qbx_vehiclekeys') == 'started' then
        Keys:RemoveKeys(source, plate)
    elseif GetResourceState('Renewed-VehicleKeys') == 'started' then
        Keys:removeKey(source, plate)
    elseif GetResourceState('wasabi_carlock') == 'started' then
        Keys:RemoveKey(source, plate)
    end
end

exports("import", function()
    return codecraft_lib
end)