--Why, you may ask? Well, simply put:
--It makes it easy to point to each file, rather than guess what the heck is in the init
--May change this later, but I think there will be a few child-mods in the 
--custom_mods modfile, ie clans, pvp modifications, items, ect...
-- the first num is x, second is y, third is z
--clans.example = {50, 50, 50, 'example'}
local modpath = minetest.get_modpath("custom_mods")
clans = {"mesa", "mountain", "grassland", "desert"} --modifying this will change the avaliable clans
-- spawn = {}
-- spawn.mesa = {x=50, y=50, z=50}
-- spawn.mountain = {x=10, y=10, z=10}
-- spawn.grassland = {x=20, y=20, z=20}
-- spawn.desert = {x=30, y=30, z=30}

assigned_players = {}
assigned_players.example = {x=0, y=0, z=0, 'example'}

dofile(modpath.."/clans03.lua")
minetest.log("info", "Main Clans loaded!")
dofile(modpath.."/spawns.lua")
minetest.log("info", "Spawns loaded!")