local Core
local ESX
codecraft_lib = codecraft_lib or {}

if Config.CoreObj == "auto" then
    while true do
        if GetResourceState('qb-core') == 'started' then
            Core = exports['qb-core']:GetCoreObject()
            break
        elseif GetResourceState('qbx_core') == 'started' then
            Core = exports.qbx_core
            break
        elseif GetResourceState('es_extended') == 'started' then
            ESX = exports['es_extended']:getSharedObject()
            Core = ESX
            break
        end
        Wait(1000)
    end
elseif Config.CoreObj == "qbcore" then
    Core = exports['qb-core']:GetCoreObject()
elseif Config.CoreObj == "qbx_core" then
    Core = exports.qbx_core
elseif Config.CoreObj == "es_extended" then
    ESX = exports['es_extended']:getSharedObject()
    Core = ESX
end

---@param source integer
---@param msg string
---@param type? string
---@param duration? number
---@param position? string
function codecraft_lib.Notify(source, msg, type, duration, position)
    if GetResourceState('ox_lib') == 'started' then
        local data = {
            description = msg,
            type = type,
            duration = duration,
            position = 'top-right' or position
        }
        TriggerClientEvent('ox_lib:notify', source, data)
    elseif GetResourceState('es_extended') == 'started' then
        TriggerClientEvent("ESX:Notify", source, type or "info", duration or 5000, msg)
    else
        Core.Functions.Notify(source, msg, type, duration)
    end
end

---@param source integer
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

---@param source integer
---@return table|nil PlayerData (QB/QBX) or xPlayer (ESX)
function codecraft_lib.GetPlayerData(source)
    local Player = codecraft_lib.GetPlayer(source)
    if not Player then return nil end
    if GetResourceState('es_extended') == 'started' then
        return Player
    end
    return Player.PlayerData
end

-- ESX uses 'money' for cash; QB/QBX use 'cash'
local function esxAccount(moneytype)
    if not moneytype or moneytype == 'cash' then return 'money' end
    return moneytype
end

function codecraft_lib.getAllPlayers()
    if GetResourceState('qb-core') == 'started' then
        return Core.Functions.GetQBPlayers()
    elseif GetResourceState('es_extended') == 'started' then
        return Core.GetExtendedPlayers()
    elseif GetResourceState('qbx_core') == 'started' then
        return Core:GetQBPlayers()
    end
end

---@param source integer
function codecraft_lib.GetPlayerJob(source)
    if Config.Debug then print(source) end
    local Player = codecraft_lib.GetPlayerData(source)
    return Player.job
end

---@param source integer
---@return string
function codecraft_lib.GetPlayerJobName(source)
    local Player = codecraft_lib.GetPlayerData(source)
    return Player.job.name
end

---@param source integer
function codecraft_lib.GetPlayerGang(source)
    if Config.Debug then print(source) end
    local Player = codecraft_lib.GetPlayerData(source)
    return Player.gang
end

---@param source integer
---@return boolean
function codecraft_lib.isBoss(source)
    if Config.Debug then print(source) end
    local player = codecraft_lib.GetPlayerJob(source)
    return player.isboss
end

---@param source source
---@return vector3
function codecraft_lib.getPlayerCoords(source)
    if Config.Debug then print(source) end
    return GetEntityCoords(GetPlayerPed(source))
end

---@param source integer
---@return boolean
function codecraft_lib.getJobDuty(source)
    if Config.Debug then print(source) end
    local player = codecraft_lib.GetPlayerJob(source)
    return player.onduty
end

---@param source integer
---@param location vector3
---@param distance number
---@return boolean
function codecraft_lib.checkDistance(source, location, distance)
    if Config.Debug then print(source, location, distance) end
    local pcoords = codecraft_lib.getPlayerCoords(source)
    local location = vector3(location.x, location.y, location.z)
    return #(pcoords - location) <= distance
end

---@param source integer
---@param metadataname string
---@return string
function codecraft_lib.GetMetaData(source, metadataname)
    if Config.Debug then print(source, metadataname) end
    local Player = codecraft_lib.GetPlayerData(source)
    if not Player then return nil end
    if GetResourceState('es_extended') == 'started' then
        return Player.getMeta(metadataname)
    end
    return Player.metadata[metadataname]
end

---@param source integer
---@param metadata string
---@param value any
---@return nil
function codecraft_lib.SetMetadata(source, metadata, value)
    if Config.Debug then print(source, metadata, value) end
    if GetResourceState('qb-core') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.Functions.SetMetaData(metadata, value) 
    elseif GetResourceState('qbx_core') == 'started' then
        Core:SetMetadata(source, metadata, value)
    elseif GetResourceState('es_extended') == 'started' then
        codecraft_lib.GetPlayer(source).setMeta(metadata, value)
    end
end

---@param source integer
---@return string
function codecraft_lib.GetIdentifierCID(source)
    if Config.Debug then print(source) end
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then
        local Player = codecraft_lib.GetPlayerData(source)
        return Player and Player.citizenid
    elseif GetResourceState('es_extended') == 'started' then
        local xPlayer = Core.GetPlayerFromId(source)
        local PlayerCID = xPlayer.getSSN()
        return PlayerCID
    end
end

---@param source integer
---@param job string
---@param amount number
---@return integer
function codecraft_lib.GetJobCount(source, job, amount)
    local amount = 0
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then
        local players = codecraft_lib.getAllPlayers()
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

---@param source integer
---@return string
function codecraft_lib.hasJob(source)
	if Config.Debug then print(source) end
    if GetResourceState('qb-core') == 'started' then
        local Player = codecraft_lib.GetPlayerData(source)
        return Player.job
    elseif GetResourceState('qbx_core') == 'started' then
        local Player = codecraft_lib.GetPlayerData(source)
        return Player.job
    elseif GetResourceState('es_extended') == 'started' then
        local xPlayer = codecraft_lib.GetPlayer(source)
        local jobs = xPlayer.getJob()
        return jobs.label
    end
end

---@param source integer
---@param moneytype? string
---@param amount number
function codecraft_lib.AddMoney(source, moneytype, amount)
	if Config.Debug then print(source, moneytype, amount) end
    if GetResourceState('qb-core') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.Functions.AddMoney(moneytype, amount)
    elseif GetResourceState('qbx_core') == 'started' then
        Core:AddMoney(source, moneytype, amount)
    elseif GetResourceState('es_extended') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.addAccountMoney(esxAccount(moneytype), amount)
    end
end

---@param source integer
---@param moneytype? string
---@param amount number
function codecraft_lib.RemoveMoney(source, moneytype, amount)
	if Config.Debug then print(source, moneytype, amount) end
    if GetResourceState('qb-core') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.Functions.RemoveMoney(moneytype, amount)
    elseif GetResourceState('qbx_core') == 'started' then
        Core:RemoveMoney(source, moneytype, amount)
    elseif GetResourceState('es_extended') == 'started' then
        local Player = codecraft_lib.GetPlayer(source)
        Player.removeAccountMoney(esxAccount(moneytype), amount)
    end
end

---@param source integer
---@param type? string
---@return number
function codecraft_lib.getMoney(source, type)
	if Config.Debug then print(source, type) end
    local player = codecraft_lib.GetPlayer(source)
    if not player then return 0 end
    if not type then type = 'cash' end
    if GetResourceState('es_extended') == 'started' then
        local account = player.getAccount(esxAccount(type))
        return account and account.money or 0
    end
    return player.PlayerData.money[type] or 0
end

---@param licensePlate string
---@return string
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
