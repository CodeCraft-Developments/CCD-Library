# Useable Functions to use and how to use them.

### Dependencies are [ox_lib](https://github.com/CommunityOx/ox_lib) and [oxmysql](https://github.com/CommunityOx/oxmysql) (oxmysql is pre-installed with every framework)

## Make sure you import all the functions using

- `local codecraft_lib = exports['CCD-Library']:import()` at the top of your client and server scripts

## CoreObj Client

- `codecraft_lib.Notify(msg, type, duration)`
- `codecraft_lib.GetPlayerGroups(jobname, gangname)`

## CoreObj Server

- `codecraft_lib.GetUserID(source)`
- `codecraft_lib.GetPlayerData(source)`
- `codecraft_lib.GetMetaData(source, metadataname)`
- `codecraft_lib.SetMetadata(source, metadata, value)`
- `codecraft_lib.GetIdentifierCID(source)`
- `codecraft_lib.GetJobCount(source, job, amount)`
- `codecraft_lib.hasJob(source, job)`
- `codecraft_lib.AddMoney(source, moneytype, amount)`
- `codecraft_lib.RemoveMoney(source, moneytype, amount)`

## Inventory Client

- `N/A`

## Inventory Server

- `codecraft_lib.AddItem(src, item, amount, metadata, slot, cb)`
- `codecraft_lib.RemoveItem(src, item, amount)`
- `codecraft_lib.HasItem(src, item, amount)`
- `codecraft_lib.CreateStash(id, label, slots, maxWeight, group, coords)` id =  string or number
- `codecraft_lib.forceOpenInventory(src, invType, plyID)` invType = 'player' or 'stash' or 'container'or 'drop' or 'glovebox' or 'trunk' or 'dumpster' MUST BE A STRING

## VehicleKeys Client

- `N/A`

## VehicleKeys Server

- `codecraft_lib.AddKeys(source, plate)`
- `codecraft_lib.RemoveKeys(source, plate)`

## Target Client

- `codecraft_lib.disableTargeting(state)` state = boolean 
- `codecraft_lib.addBoxZone(name, coords, label, icon, distance, job, onSelect, itemreq, type, size, length, width, minZ, maxZ, heading, debug)` All variables have to be in the function but dont have to be used
- `codecraft_lib.addLocalEntity(models, name, label, icon, distance, job, onSelect, itemreq, type)` All variables have to be in the function but dont have to be used

## Target Server

- `N/A`