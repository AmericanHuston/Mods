simple_clans = {}
simple_clans.clans = {}
local modname = minetest.get_current_modname()
local clan_storage_info = minetest.get_modpath(modname)
local clan_def = 'default'
local clan_grass = 'grassland'
local clan_mountain = 'mountain'
local clan_mesa = 'mesa'
local clan_desert = 'desert'

function simple_clans.assign_clan(player, clan_name)
    simple_clans.clans[clan_mesa] = clan_mesa
    if type(player) == 'string' then
        player = minetest.get_player_by_name(player)
    end
    if simple_clans.clans[clan_name] then
        print((simple_clans.clans))
        simple_clans[player] = player.. "=" ..clan_name
    else
        minetest.log('error', "Clan".. clan_name.." does not exist!")
    end
end
minetest.register_on_joinplayer(function(player, last_login)
    if last_login == nil then
        simple_clans.assign_clan(player, simple_clans.clans.default_clan)
    end
end
)
minetest.register_chatcommand('assign_clan',{
    description = 'Assign a player to a clan',
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
minetest.register_chatcommand('clan',{
    description = 'get the clan of a player',
    param = '[playername]',
    func = function(name, player_name)
        if player_name == nil then
            player_name = name
            if minetest.is_singleplayer() then
                player_name = 'singleplayer'
            end
        end
        local my_clan = simple_clans.player or 'default'
        minetest.chat_send_player(player_name, "Your clan is:" ..my_clan.. "clan" )
        if minetest.player_exists(player_name) then
            local player = minetest.get_player_by_name(player_name)
            local meta = player:get_meta()
            local clan = meta:get('simple_clans:clan') or "default"
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