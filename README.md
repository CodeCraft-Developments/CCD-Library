# Useable Functions to use and how to use them.

### Dependencies are [ox_lib](https://github.com/CommunityOx/ox_lib) and [oxmysql](https://github.com/CommunityOx/oxmysql) (oxmysql is pre-installed with every framework)

## Make sure you import all the functions using

- `local codecraft_lib = exports.CCD_Library:import()` at the top of your client and server scripts

## CoreObj Client

- `codecraft_lib.Notify(msg, type, duration)`
- `codecraft_lib.GetPlayerData()`
- `codecraft_lib.GetPlayerJob()`
- `codecraft_lib.GetPlayerJobName()`
- `codecraft_lib.IsJobBoss()`
- `codecraft_lib.GetPlayerGang()`
- `codecraft_lib.IsGangLeader()`
- `codecraft_lib.GetMetadata(meta)` Example: codecraft_lib.GetMetadata('isdead')
- `codecraft_lib.GetIdentifier()` Returns CitizenID
- `codecraft_lib.GetPlayer()` Returns PlayerPedID
- `codecraft_lib.GetIdentifierCID()`
- `codecraft_lib.isDead()`
- `codecraft_lib.getCoords()`

## CoreObj Server

- `codecraft_lib.Notify(source, msg, type, duration)`
- `codecraft_lib.GetPlayer(source)`
- `codecraft_lib.GetPlayerData()`
- `codecraft_lib.getAllPlayers()`
- `codecraft_lib.GetPlayerJob(source)`
- `codecraft_lib.GetPlayerJobName(source)`
- `codecraft_lib.GetPlayerGang(source)`
- `codecraft_lib.isBoss(source)`
- `codecraft_lib.getPlayerCoords(source)`
- `codecraft_lib.getJobDuty(source)`
- `codecraft_lib.checkDistance(source, location, distance)`
- `codecraft_lib.GetMetaData(source, metadataname)`
- `codecraft_lib.SetMetadata(source, metadata, value)`
- `codecraft_lib.GetIdentifierCID(source)`
- `codecraft_lib.GetJobCount(source, job, amount)`
- `codecraft_lib.hasJob(source)`
- `codecraft_lib.AddMoney(source, moneytype, amount)`
- `codecraft_lib.RemoveMoney(source, moneytype, amount)`
- `codecraft_lib.getMoney(source, type)`
- `codecraft_lib.vehicleOwner(licensePlate)` Returns CitizenID of vehicle owner

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