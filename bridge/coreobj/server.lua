local Core
local ESX
codecraft_lib = {}

if Config.CoreObj == "auto" then
    if GetResourceState('qb-core') == 'started' then 
        Core = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('qbx_core') == 'started' then
        Core = exports.qbx_core
    elseif GetResourceState('es_extended') == 'started' then
        Core = ESX
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
elseif Config.CoreObj == "es_extended" then
    Core = ESX
end

function codecraft_lib.GetUserID(source)
    if Config.Debug then print(source) end
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayer(source)
        return Player
    elseif GetResourceState('qbx_core') == 'started' then
        local Player = Core:GetUserId(source)
        return Player
    elseif GetResourceState('es_extended') == 'started' then
        local Player = Core.GetPlayerFromId(source)
        return Player
    end
end

function codecraft_lib.GetPlayerData(source)
    if Config.Debug then print(source) end
    if GetResourceState('qbcore') == 'started' then
        local source = QBCore.Functions.GetPlayerData()
        return source
    elseif GetResourceState('qbx_core') == 'started' then
        local source = Core:GetPlayerData()
        return source
    end
end

function codecraft_lib.GetMetaData(source, metadataname)
    if Config.Debug then print(source, metadataname) end
    if GetResourceState('qbcore') == 'started' then
        local source = QBCore.Functions.GetPlayerData()
        local metadata = source.metadata
        return metadataname
    elseif GetResourceState('qbx_core') == 'started' then
        local source = Core:GetMetadata(source, metadataname)
        return metadataname
    end
end

function codecraft_lib.SetMetadata(source, metadata, value)
    if Config.Debug then print(source, metadata, value) end
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayer(source)
        Player.Functions.SetMetaData(metadata, value) 
    elseif GetResourceState('qbx_core') == 'started' then
        Core:SetMetadata(source, metadata, value)
    end
end

function codecraft_lib.GetIdentifierCID(source)
    if Config.Debug then print(source) end
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayer(source)
        return Player.PlayerData.citizenid
    elseif GetResourceState('qbx_core') == 'started' then
        local PlayerCID = Core:GetPlayerByCitizenId(source)
        return PlayerCID
    elseif GetResourceState('es_extended') == 'started' then
        local xPlayer = Core.GetPlayerFromId(source)
        local PlayerCID = xPlayer.getSSN()
        return PlayerCID
    end
end

function codecraft_lib.GetJobCount(source, job, amount)
    local amount = 0
    if GetResourceState('qbcore') == 'started' or GetResourceState('qbx_core') == 'started' then
        local players = Core.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if v and v.PlayerData.job.name == job then
                amount = amount + 1
            end
        end
        return amount
    elseif GetResourceState('es_extended') == 'started' then
        local amount = Core.GetNumPlayers('job', job)
        return amount
    end
end

function codecraft_lib.hasJob(source, job)
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayerData()
        local job = Player.job.name
        return job
    elseif GetResourceState('qbx_core') == 'started' then
        local job = Core:HasGroup(source, job)
        return job
    elseif GetResourceState('es_extended') == 'started' then
        local xPlayer = Core.GetPlayerFromId(source)
        local jobs = xPlayer.getJob()
        local jobName = jobs.label
        job = jobName
        return job
    end
end

function codecraft_lib.AddMoney(source, moneytype, amount)
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayer(source)
        Player.Functions.AddMoney(moneytype, amount)
    elseif GetResourceState('qbx_core') == 'started' then
        Core:AddMoney(source, moneytype, amount)
    elseif GetResourceState('es_extended') == 'started' then
        local Player = Core.GetPlayerFromId(source)
        Player.addMoney(amount)
    end
end

function codecraft_lib.RemoveMoney(source, moneytype, amount)
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayer(source)
        Player.Functions.RemoveMoney(moneytype, amount)
    elseif GetResourceState('qbx_core') == 'started' then
        Core:RemoveMoney(source, moneytype, amount)
    elseif GetResourceState('es_extended') == 'started' then
        local Player = Core.GetPlayerFromId(source)
        Player.removeMoney(amount)
    end
end



exports("import", function()
    return codecraft_lib
end)