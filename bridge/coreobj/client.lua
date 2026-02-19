local Core
codecraft_lib = {}

if Config.CoreObj == "auto" then
    if GetResourceState('qb-core') == 'started' then 
        Core = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('qbx_core') == 'started' then
        Core = exports.qbx_core
    else
        while true do 
            Wait(5000)
            print("Please Set The Config Properly in "..GetCurrentResourceName())
        end
    end
elseif Config.CoreObj == "qbcore" then
    Core = exports['qb-core']:GetCoreObject()
elseif Config.CoreObj == "qbx_core" then
    Core = exports.qbx_core
end

function codecraft_lib.Notify(msg, type, duration)
    if GetResourceState('ox_lib') == 'started' then 
        lib.notify({ description = msg, type = type, position = 'top-right', duration = duration})
    else
        QBCore.Functions.Notify(msg, type, duration)
    end
end

function codecraft_lib.GetPlayerGroups(jobname, gangname)
    local Player = QBCore.Functions.GetPlayerData()
    return Player.job.name, Player.gang.name
end



exports("import", function()
    return codecraft_lib
end)
