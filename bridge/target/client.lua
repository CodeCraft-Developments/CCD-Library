local Target
local targetZones = {}
codecraft_lib = codecraft_lib or {}

if Config.Target == "auto" then
    if GetResourceState('ox_target') == 'started' then 
        Target = exports.ox_target
    elseif GetResourceState('qb-target') == 'started' then
        Target = exports['qb-target']
    else
        while true do 
            Wait(5000)
            print("Please Set You Config Properly in "..GetCurrentResourceName())
        end
    end
elseif Config.Target == "ox_target" then
    Target = exports.ox_target
elseif Config.Target == "qb-target" then
    Target = exports['qb-target']
end
if Config.Debug then print("CLIENT PRINT TARGET "..tostring(Target).."^2 If its a table (string of random shit) then its correct ^0") end

function codecraft_lib.disableTargeting(state)
    if Config.Debug then print("IF TRUE THEN YOU CANT TARGET " ..json.encode(state)) end
    if GetResourceState('ox_target') == 'started' then 
        if state then
            Target:disableTargeting(true)
            state = true
        else
            Target:disableTargeting(false)
            state = false
        end
    else
        if state then
            Target:AllowTargeting(false)
            state = false
        else
            Target:AllowTargeting(true)
            state = true
        end
    end
    return state
end
function codecraft_lib.addBoxZone(name, coords, label, icon, distance, job, onSelect, itemreq, type, size, length, width, minZ, maxZ, heading, debug)
    if Config.Debug then print(name, coords, label, icon, distance, job, onSelect, itemreq, type, size, length, width, minZ, maxZ, heading, debug) end
    if GetResourceState('ox_target') == 'started' then 
        Target:addBoxZone({
            coords = coords,
            name = name,
            size = size,
            rotation = heading or 0,
            debug = debug or false,
            options = {
                label = label or name, 
                icon = icon or "fa-solid fa-file-circle-exclamation",
                distance = distance or 1,
                items = itemreq or false,
                onSelect = onSelect,
                groups = job or nil,
            }
        })
    else
        Target:AddBoxZone(name, coords, length, width, {
            name = name,
            heading = heading or 0,
            debugPoly = debug or false,
            minZ = minZ,
            maxZ = maxZ
            }, {
            options = {
                {
                    type = type,
                    icon = icon or "fa-solid fa-file-circle-exclamation",
                    label = label or name,
                    item = itemreq or false,
                    action = onSelect,
                    job = job or false,
                }
            },
            distance = distance or 1
        })
    end
    table.insert(targetZones, { name = name, id = name, creator = GetInvokingResource() })
end

function codecraft_lib.addLocalEntity(models, name, label, icon, distance, job, onSelect, itemreq, type)
    if Config.Debug then print(models, name, label, icon, distance, job, onSelect, itemreq, type) end
    if GetResourceState('ox_target') == 'started' then 
        Target:addLocalEntity(models, {
            options = {
                label = label or name, 
                icon = icon or "fa-solid fa-file-circle-exclamation",
                distance = distance or 1,
                items = itemreq or false,
                onSelect = onSelect,
                groups = job or nil,
            }
        })
    else
        Target:AddTargetEntity(models, {
            }, {
            options = {
                {
                    type = type,
                    icon = icon or "fa-solid fa-file-circle-exclamation",
                    label = label or name,
                    item = itemreq or false,
                    action = onSelect,
                    job = job or false,
                }
            },
            distance = distance or 1
        })
    end
    table.insert(targetZones, { name = models, id = models, creator = GetInvokingResource() })
end

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then
        local removed = 0
        for _, target in pairs(targetZones) do
            if target.creator == resource then
                if GetResourceState('ox_target') == 'started' then 
                    Target:removeZone(target.id)
                else
                    Target:RemoveZone(target.id)
                end
                table.remove(targetZones, _)
                removed = removed + 1
            end
        end
        if removed > 0 and Config.Debug then print('[DEBUG] - removed targets for:', resource) end
    end
end)








exports("import", function()
    return codecraft_lib
end)