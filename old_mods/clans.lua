simple_clans = {}
simple_clans.clans = {}
local mod_meta = minetest.get_mod_storage()
--[[

clan_def:
{ do you know where the chat is?
    spawn_pos: {x=,y=,z=} no... ill look for it tho this is fine imo
} 
]] 

default_clan_def = {
    spawn_pos = {x=0,y=0,z=0},
}

function simple_clans.register_clan(clan_name, clan_def)
    if simple_clans.clans[clan_name] == nil then
        simple_clans.clans[clan_name] = clan_def
        mod_meta:set_string('simple_clans:clan_table', minetest.serialize(simple_clans.clans))
    else
        minetest.log("warning", "[simple_clans] Clan ".. clan_name.. " already exists!")
    end
end

function simple_clans.assign_clan(player, clan_name)
    if type(player) == 'string' then
        player = minetest.get_player_by_name(player)
    end
    print(minetest.serialize(simple_clans.clans))
    if simple_clans.clans[clan_name] then
        local meta = player:get_meta()
        meta:set_string('simple_clans:clan', clan_name)
    else
        minetest.log("error", "Clan ".. clan_name.. " does not exist!")
    end
end
minetest.register_on_mods_loaded(function()

    if mod_meta:get_string("simple_clans:clan_table") then
        local c = nil
        --simple_clans.clans = minetest.deserialize(mod_meta:get_string("simple_clans:clan_table"))
    else
        simple_clans.register_clan('default', default_clan_def)
    end
    simple_clans.default_clan = mod_meta:get_string('simple_clans:default_clan') or 'default'
end)
minetest.register_on_joinplayer(function(player, last_login)
    local meta = player:get_meta()
    if meta:get('simple_clans:clan') == nil then
        simple_clans.assign_clan(player, simple_clans.default_clan)
    end
end)

minetest.register_chatcommand('assign_clan', {
    description = 'Assign a clan to a player',
    param = '<playername> <clan>',
    privs = {clan_admin = true},
    func = function(name, param)

        local substrings = {}

        for str in param:gmatch("([^ ]+)") do
            table.insert(substrings, str)
        end
        player_name = substrings[1]
        clan = substrings[2]
        --player_name, clan = string.gmatch(param, "([^ ]+)")
        local player = minetest.get_player_by_name(player_name)
        if param ~= nil then
            simple_clans.assign_clan(player, param)
            minetest.chat_send_player(name, "Set "..player_name.."'s clan to ".. clan)
            minetest.chat_send_player(player_name, name..' set your clan to '..clan)
        end
    end
})
minetest.register_chatcommand('clan', {
    description = 'Get the clan of a player',
    param = '[playername]',
    func = function(name, player_name)
        if player_name == nil then
            player_name = name
            if minetest.is_singleplayer() then
                player_name = 'singleplayer'
            end
        end
        if minetest.player_exists(player_name) then
            local player = minetest.get_player_by_name(player_name)
            local meta = player:get_meta()
            local clan = meta:get('simple_clans:clan')
            minetest.chat_send_player(player_name, 'Player '..player_name..' is in the '..clan..' clan')
        else
            minetest.chat_send_player(player_name, 'Player '..player_name..' does not exist')
        end
    end
})
minetest.register_privilege('clan_admin', {
    give_to_singleplayer = true,
    give_to_admin = true,
})