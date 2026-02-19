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

function codecraft_lib.GetUserID(source)
    if Config.Debug then print(source) end
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayer(source)
        return Player
    elseif GetResourceState('qbx_core') == 'started' then
        local Player = Core:GetUserId(source)
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
    end
end

function codecraft_lib.GetJobCount(source, job, amount)
    local amount = 0
    local players = Core.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.name == job then
            amount = amount + 1
        end
    end
    return amount
end

function codecraft_lib.hasJob(source, job)
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayerData()
        local job = Player.job.name
        return job
    elseif GetResourceState('qbx_core') == 'started' then
        local job = Core:HasGroup(source, job)
        return job
    end
end

function codecraft_lib.AddMoney(source, moneytype, amount)
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayer(source)
        Player.Functions.AddMoney(moneytype, amount)
    elseif GetResourceState('qbx_core') == 'started' then
        Core:AddMoney(source, moneytype, amount)
    end
end

function codecraft_lib.RemoveMoney(source, moneytype, amount)
    if GetResourceState('qbcore') == 'started' then
        local Player = Core.Functions.GetPlayer(source)
        Player.Functions.RemoveMoney(moneytype, amount)
    elseif GetResourceState('qbx_core') == 'started' then
        Core:RemoveMoney(source, moneytype, amount)
    end
end



exports("import", function()
    return codecraft_lib
end)