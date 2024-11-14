local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()
local rand = math.random(1,4)
--Below this line is just to cycle through all the clans.
--I need to assign each player to a clan 1-4, making default the default.(Default is nono)
--make it so that the mod saves assigned_players to mod storage, keeping it for next time.
function table_contains(tbl, x)
    found = false
    for i,v in ipairs(tbl) do
        if v == x then 
            found = true
        end
    end
end
minetest.register_on_joinplayer(function(player, last_login)
    for i,v in ipairs(clans) do
    minetest.chat_send_all(clans[i])
    end
end)
--gives the players a clan when they join
minetest.register_on_prejoinplayer(function(player, last_login)
    if last_login == nil then
    if type(player) == 'string' then
         local player = minetest.get_player_by_name(player)
    end
    rand = math.random(1,4)
    assigned_players[player] = clans[rand]
    --minetest.serialize(storage:set_string("assigned_players", assigned_players))
    else
    --assigned_players = minetest.deserialize(storage:get_string('assigned_players'))
    end
end)

minetest.register_chatcommand('c', {
    description = 'say the clans',
    func = function()
        for i,v in ipairs(clans) do
            minetest.chat_send_all(clans[i])
        end
    end
})
minetest.register_chatcommand('rand',{
    description = 'Say a random clan',
    func = function()
        rand = math.random(1,4)
        minetest.chat_send_all(clans[rand])
    end
})
minetest.register_chatcommand('my_clan',{
    description = 'Say what clan is associated with my player',
    func = function(player)
        if assigned_players[player] == nil then
            rand = math.random(1,4)
            assigned_players[player] = clans[rand]
            minetest.chat_send_player(player, assigned_players[player])
        else
        minetest.chat_send_player(player, assigned_players[player])
    end
end
})
minetest.register_chatcommand('name', {
    description = 'say the player name',
    func = function(player)
        minetest.chat_send_player(player, "my name is: " ..player)
    end
})
minetest.register_chatcommand('assign_clan', {
    description = 'Assign a clan to a player',
    param = '<playername> <clan>',
    func = function(name, param)

        local substrings = {}
        assigned_players = {}
        
        for str in param:gmatch("([^ ]+)") do
            table.insert(substrings, str)
        end
        local player_name = substrings[1] or minetest.get_player_by_name(name)
        if substrings[2] == nil then
            minetest.chat_send_player(name, "You need to enter the clan!")
            return
        end
       local clan = substrings[2]
        --player_name, clan = string.gmatch(param, "([^ ]+)")
        local player = minetest.get_player_by_name(player_name)
        if clans[clan] ~= nil then
        if param ~= nil then
            assigned_players[player_name] = clan
            minetest.chat_send_player(name, "Set "..player_name.."'s clan to ".. clan)
            minetest.chat_send_player(player_name, name..' set your clan to '..clan)
        else
            minetest.chat_send_player(player_name, "Clan doesn't exist!")
        end
    else 
        minetest.chat_send_player(player_name, "Clan doesn't exist!")
    end
    end
})
minetest.register_chatcommand('randclan',{
    definition = "Assigns player to a random clan",
    param = '<playername>',
    func = function(name, param)
        local substrings = {}

        for str in param:gmatch("([^ ]+)") do
            table.insert(substrings, str)
        end
        if substrings[1] == nil then
            local player_name = minetest.get_player_by_name(name)
        else
        end
        local clan = clans[rand]
        local player = minetest.get_player_by_name(player_name)
        assigned_players[player_name] = clan
        minetest.chat_send_player(name, "Set " ..player_name.."'s clan to "..clan)
        minetest.chat_send_player(player_name, name..' set your clan to '..clan)
    end
})
minetest.register_chatcommand('yourclan',{
    definition = "check someone else's clan",
    param = '<playername>',
    func = function(name, param)
        local substrings = {}
        for str in param:gmatch("([^ ]+)") do
            table.insert(substrings, str)
        end
        if substrings[1] == nil then 
            local player_name = player:get_player_name(player)
        else
            minetest.chat_send_all(assigned_players[substrings[1]])
        end
    end
})
--need to write what clan the player is assigned into on the tabel "assigned_players"
--need to add a way to remove clans from the player's name in the assigned players table