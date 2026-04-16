local Core
codecraft_lib = codecraft_lib or {}

if Config.CoreObj == "auto" then
    if GetResourceState('qb-core') == 'started' then 
        Core = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('qbx_core') == 'started' then
        Core = exports.qbx_core
    elseif GetResourceState('es_extended') == 'started' then
        Core = "esx"
    else
        while true do 
            Wait(5000)
            print("Please Set The Config Properly in "..GetCurrentResourceName())
        end
    end
elseif Config.CoreObj == "qb-core" then
    Core = exports['qb-core']:GetCoreObject()
elseif Config.CoreObj == "qbx_core" then
    Core = exports.qbx_core
elseif Config.CoreObj == "ESX" then
    Core = "esx"
end

function codecraft_lib.Notify(msg, type, duration)
    if GetResourceState('ox_lib') == 'started' then 
        lib.notify({ description = msg, type = type, position = 'top-right', duration = duration})
    elseif GetResourceState('es_extended') == 'started' and GetResourceState('ox_lib') ~= 'started' then
        exports['esx_notify']:Notify(type or "info", duration or 5000, msg)
    elseif GetResourceState('qb-core') == 'started' then 
        Core.Functions.Notify(msg, type, duration)
    end
end

function codecraft_lib.GetPlayerData()
    if GetResourceState('qb-core') == 'started' then
        return Core.Functions.GetPlayerData()
    elseif GetResourceState('qbx_core') == 'started' then
        return Core:GetPlayersData()
    elseif GetResourceState('es_extended') == 'started' then
        return Core.PlayerData
    end
end

function codecraft_lib.GetPlayerJob()
    local Player = codecraft_lib.GetPlayerData()
    return Player.job
end

function codecraft_lib.GetPlayerJobName()
    local Player = codecraft_lib.GetPlayerData()
    return Player.job.name
end

function codecraft_lib.IsJobBoss()
    local job = codecraft_lib.GetPlayerJob()
    return job.isboss
end

function codecraft_lib.GetPlayerGang()
    local Player = codecraft_lib.GetPlayerData()
    return Player.gang.name
end

function codecraft_lib.IsGangLeader()
    local Player = codecraft_lib.GetPlayerData()
    return Player.gang.isboss
end

function codecraft_lib.GetMetadata(meta)
    return codecraft_lib.GetPlayerData().metadata[meta]
end

function codecraft_lib.GetIdentifier()
    return codecraft_lib.GetPlayerData().citizenid
end

function codecraft_lib.GetPlayer()
    return PlayerPedId()
end

function codecraft_lib.GetIdentifierCID()
    return codecraft_lib.GetPlayerData().cid
end

function codecraft_lib.isDead()
    if codecraft_lib.GetMetadata('isdead') or codecraft_lib.GetMetadata('inlaststand') then
        return true
    else
        return false
    end
end

function codecraft_lib.getCoords()
    return GetEntityCoords(PlayerPedId())
end




















exports("import", function()
    return codecraft_lib
end)
