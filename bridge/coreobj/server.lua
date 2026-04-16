local Core
local ESX
codecraft_lib = codecraft_lib or {}

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

function codecraft_lib.Notify(source, msg, type, duration)
    if GetResourceState('ox_lib') == 'started' then
        local data = {
            description = msg,
            type = type,
            duration = duration,
            position = 'top-right'
        }
        TriggerClientEvent('ox_lib:notify', source, data)
    elseif GetResourceState('es_extended') == 'started' and not GetResourceState('ox_lib') == 'started' then
        TriggerClientEvent("ESX:Notify", type or "info", duration or 5000, msg)
    else
        Core.Functions.Notify(source, msg, type, duration)
    end
end

function codecraft_lib.GetPlayer(source)
    if Config.Debug then print(source) end
    if GetResourceState('qb-core') == 'started' then
        local Player = Core.Functions.GetPlayer(source)
        return Player
    elseif GetResourceState('qbx_core') == 'started' then
        local Player = Core:GetPlayer(source)
        return Player
    elseif GetResourceState('es_extended') == 'started' then
        local Player = Core.GetPlayerFromId(source)
        return Player
    end
end

function codecraft_lib.GetPlayerData()
    if GetResourceState('qb-core') == 'started' then
        return Core.Functions.GetPlayerData()
    elseif GetResourceState('qbx_core') == 'started' then
        return Core:GetPlayersData()
    end
end

function codecraft_lib.getAllPlayers()
    if GetResourceState('qb-core') == 'started' then
        return Core.Functions.GetQBPlayers()
    elseif GetResourceState('es_extended') == 'started' then
        local xPlayers = Core.ExtendedPlayers()
        for i, xPlayer in ipairs(xPlayers) do
            return xPlayers
        end
    elseif GetResourceState('qbx_core') == 'started' then
        return Core:GetQBPlayers()
    end
end

function codecraft_lib.GetPlayerJob(source)
    if Config.Debug then print(source) end
    local Player = codecraft_lib.GetPlayerData(source)
    return Player.job
end

function codecraft_lib.GetPlayerJobName(source)
    local Player = codecraft_lib.GetPlayerData(source)
    return Player.job.name
end

function codecraft_lib.GetPlayerGang(source)
    if Config.Debug then print(source) end
    local Player = codecraft_lib.GetPlayerData(source)
    return Player.gang
end

function codecraft_lib.isBoss(source)
    if Config.Debug then print(source) end
    local player = codecraft_lib.GetPlayerJob(source)
    return player.isboss
end

function codecraft_lib.getPlayerCoords(source)
    if Config.Debug then print(source) end
    return GetEntityCoords(GetPlayerPed(source))
end

function codecraft_lib.getJobDuty(source)
    if Config.Debug then print(source) end
    local player = codecraft_lib.GetPlayerJob(source)
    return player.onduty
end

function codecraft_lib.checkDistance(source, location, distance)
    if Config.Debug then print(source, location, distance) end
    local pcoords = codecraft_lib.getEntityCoords(source)
    local location = vector3(location.x, location.y, location.z)
    return #(pcoords - location) <= distance
end

function codecraft_lib.GetMetaData(source, metadataname)
    if Config.Debug then print(source, metadataname) end
    if GetResourceState('qb-core') == 'started' then
        local source = Codecraft_lib.GetPlayerData(source)
        local metadata = source.metadata
        return metadataname
    elseif GetResourceState('qbx_core') == 'started' then
        local source = Core:GetMetadata(source, metadataname)
        return metadataname
    end
end

function codecraft_lib.SetMetadata(source, metadata, value)
    if Config.Debug then print(source, metadata, value) end
    if GetResourceState('qb-core') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.Functions.SetMetaData(metadata, value) 
    elseif GetResourceState('qbx_core') == 'started' then
        Core:SetMetadata(source, metadata, value)
    end
end

function codecraft_lib.GetIdentifierCID(source)
    if Config.Debug then print(source) end
    if GetResourceState('qb-core') == 'started' then
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
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then
        local players = Core.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if v and v.PlayerData.job.name == job then
                amount = amount + 1
            end
        end
		if Config.Debug then print(amount) end
        return amount
    elseif GetResourceState('es_extended') == 'started' then
        local amount = Core.GetNumPlayers('job', job)
		if Config.Debug then print(amount) end
        return amount
    end
end

function codecraft_lib.hasJob(source)
	if Config.Debug then print(source) end
    if GetResourceState('qb-core') == 'started' then
        local Player = codecraft_lib.GetPlayerData(source)
        return Player.job
    elseif GetResourceState('qbx_core') == 'started' then
        return Core:HasGroup(source)
    elseif GetResourceState('es_extended') == 'started' then
        local xPlayer = codecraft_lib.GetPlayer(source)
        local jobs = xPlayer.getJob()
        return jobs.label
    end
end

function codecraft_lib.AddMoney(source, moneytype, amount)
	if Config.Debug then print(source, moneytype, amount) end
    if GetResourceState('qb-core') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.Functions.AddMoney(moneytype, amount)
    elseif GetResourceState('qbx_core') == 'started' then
        Core:AddMoney(source, moneytype, amount)
    elseif GetResourceState('es_extended') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.addMoney(amount)
    end
end

function codecraft_lib.RemoveMoney(source, moneytype, amount)
	if Config.Debug then print(source, moneytype, amount) end
    if GetResourceState('qb-core') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.Functions.RemoveMoney(moneytype, amount)
    elseif GetResourceState('qbx_core') == 'started' then
        Core:RemoveMoney(source, moneytype, amount)
    elseif GetResourceState('es_extended') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.removeMoney(amount)
    end
end

function codecraft_lib.getMoney(source, type)
	if Config.Debug then print(source, type) end
    local player = codecraft_lib.GetPlayer(source)
    if not type then type = 'cash' end
    return player.PlayerData.money[type] or 0
end

function codecraft_lib.vehicleOwner(licensePlate)
	if Config.Debug then print(licensePlate) end
    local vehicle = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ?', {licensePlate})
    if not vehicle or #vehicle == 0 then
        return false
    end
    return vehicle[1].citizenid
end



exports("import", function()
    return codecraft_lib
end)