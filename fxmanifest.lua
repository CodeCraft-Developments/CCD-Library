fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "CCD-Library"
author "CodeCraft Developments"
version "1.0.0"
description  "A library of functions and a bridge for CodeCraft Developments scripts"

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script {
    'client/*.lua',
    'bridge/target/client.lua',
    'bridge/coreobj/client.lua',
    'bridge/inventory/client.lua',
    'bridge/keys/client.lua',
}

server_script {
    'server/*.lua',
    'bridge/inventory/server.lua',
    'bridge/coreobj/server.lua',
    'bridge/keys/server.lua',
    'bridge/target/server.lua'
}

dependencies {
    'ox_lib',
    'oxmysql'
}