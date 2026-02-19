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
        Keys = "qb-vehiclekeys"
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
    Keys = "qb-vehiclekeys"
elseif Config.VehicleKeys == "qbx_vehiclekeys" then
    Keys = "qbx_vehiclekeys"
elseif Config.VehicleKeys == "Renewed-VehicleKeys" then
    Keys = exports['Renewed-Vehiclekeys']
elseif Config.VehicleKeys == "wasabi_carlock" then
    Keys = exports.wasabi_carlock
else
    VehKeysNotSetup()  
end
if Config.Debug then print("CLIENT PRINT VEHICLEKEYS ^2 If its a empty [] then its correct ^0") end

exports("import", function()
    return codecraft_lib
end)