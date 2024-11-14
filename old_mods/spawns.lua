--local pos = {}
--player = minetest.get_player_by_name(name)
--minetest.register_on_respawnplayer(function(player)
    --player_name = player:get_player_name(player)
    --if player_name ==  nil then return end
    --player_clan = assigned_players[player_name]
    --echo = clans[player_clan]
    --echo1 = echo[4]
    --for i,v in ipairs(assigned_players) do
        --minetest.chat_send_all(assigned_players[i])
        --end
    --minetest.chat_send_all(player_clan)
    --pos[1] = clans.player_clan[1]
    --pos[2] = clans.player_clan[2]
    --pos[3] = clans.player_clan[3]
   -- player:set_pos(pos)
--end)


-------------------------------Try num 2---------------------------
--minetest.register_on_respawnplayer(function(player)
    --local player_name = player:get_player_name(player)
    --local pos = {}
    --local player_clan = assigned_players[player_name]
    --local clan_pos = clans[player_clan]
    --if player_name == nil then 
    --minetest.chat_send_all("failed")
    --return end
    --pos[1] = clan_pos[1]
    --pos[2] = clan_pos[2]
    --pos[3] = clan_pos[3]
    --for i,v in ipairs(pos) do
    --minetest.chat_send_all(pos[i])
   -- end
    --player:set_pos(pos)
    --minetest.chat_send_all("Player Teleported!")
--end)
-------------------------------Try num 3-----------------------------
-- local pos = {x,y,z}
-- minetest.register_on_dieplayer(function(player)
--     pos = player:get_pos()
-- end)
-- minetest.register_on_respawnplayer(function(player)
--     local player_name = player:get_player_name(player)
--     local player_clan = assigned_players[player_name]
--     if player_clan == 'mesa' then
--         pos = clans.mesa
--     elseif player_clan == 'mountain' then
--         pos = clans.mountain
--     elseif player_clan == 'grassland' then
--         pos = clans.grassland
--     elseif player_clan == 'desert' then
--         pos = clans.desert
--     end
--     player:set_pos(clans.mesa)
--     minetest.chat_send_all('Player Teleported!')
-- end)
-- if player_clan = example then
-- pos[1] = clans.example[1]
--------------------------Try num 4 (ai)------------------------------
spawn = {}
spawn.mesa = {x=50, y=50, z=50}
spawn.mountain = {x=10, y=10, z=10}
spawn.grassland = {x=20, y=20, z=20}
spawn.desert = {x=30, y=30, z=30}

minetest.register_on_respawnplayer(function(name)
  local player = player:get_player_name(name)
  if player == nil then
      -- just a check to prevent the server crashing
      return false
  end
  local player_clan = assigned_players[player]

  -- Check if player's clan exists in the 'clans' table
  if spawn[player_clan] then
    pos = vector.round(spawn[player_clan])
    local newpos = minetest.string_to_pos(pos)
    player:set_pos(newpos) -- Set position based on clan
    minetest.chat_send_player(player, player .. ' has teleported to the ' .. player_clan .. ' spawn!')
  else
    -- Handle the case of an unknown clan (optional)
    minetest.chat_send_player(player, "Your clan doesn't have a designated spawn point yet.")
  end
end)
minetest.register_chatcommand('bringmehomelol',{
  definition = 'what the flippers am I doing',
  func = function(name)
    local player = minetest.get_player_by_name(name)
    if player == nil then
        -- just a check to prevent the server crashing
        return false
    end
    player:set_pos(spawn.desert)
  end
})
------------------------------Try 5 (Plagerism)------------------------------------
-- sethome/init.lua

-- sethome = {}

-- -- Load support for MT game translation.
-- local S = minetest.get_translator("sethome")


-- local homes_file = minetest.get_worldpath() .. "/homes"
-- local homepos = {}

-- local function loadhomes()
-- 	local input = io.open(homes_file, "r")
-- 	if not input then
-- 		return -- no longer an error
-- 	end

-- 	-- Iterate over all stored positions in the format "x y z player" for each line
-- 	for pos, name in input:read("*a"):gmatch("(%S+ %S+ %S+)%s([%w_-]+)[\r\n]") do
-- 		homepos[name] = minetest.string_to_pos(pos)
-- 	end
-- 	input:close()
-- end

-- loadhomes()

-- sethome.set = function(name, pos)
-- 	local player = minetest.get_player_by_name(name)
-- 	if not player or not pos then
-- 		return false
-- 	end
-- 	local player_meta = player:get_meta()
-- 	player_meta:set_string("sethome:home", minetest.pos_to_string(pos))

-- 	-- remove `name` from the old storage file
-- 	if not homepos[name] then
-- 		return true
-- 	end
-- 	local data = {}
-- 	local output = io.open(homes_file, "w")
-- 	if output then
-- 		homepos[name] = nil
-- 		for i, v in pairs(homepos) do
-- 			table.insert(data, string.format("%.1f %.1f %.1f %s\n", v.x, v.y, v.z, i))
-- 		end
-- 		output:write(table.concat(data))
-- 		io.close(output)
-- 		return true
-- 	end
-- 	return true -- if the file doesn't exist - don't return an error.
-- end

-- sethome.get = function(name)
-- 	local player = minetest.get_player_by_name(name)
-- 	if not player then
-- 		return false, S("This command can only be executed in-game!")
-- 	end
-- 	local player_meta = player:get_meta()
-- 	local pos = minetest.string_to_pos(player_meta:get_string("sethome:home"))
-- 	if pos then
-- 		return pos
-- 	end

-- 	-- fetch old entry from storage table
-- 	pos = homepos[name]
-- 	if pos then
-- 		return vector.new(pos)
-- 	else
-- 		return nil
-- 	end
-- end

-- sethome.go = function(name)
-- 	local pos = sethome.get(name)
-- 	local player = minetest.get_player_by_name(name)
-- 	if player and pos then
-- 		player:set_pos(pos)
-- 		return true
-- 	end
-- 	return false
-- end

-- minetest.register_privilege("home", {
-- 	description = S("Can use /sethome and /home"),
-- 	give_to_singleplayer = true
-- })

-- minetest.register_chatcommand("home", {
-- 	description = S("Teleport you to your home point"),
-- 	privs = {home = true},
-- 	func = function(name)
-- 		local player = minetest.get_player_by_name(name)
-- 		if not player then
-- 			return false, S("This command can only be executed in-game!")
-- 		end
-- 		if sethome.go(name) then
-- 			return true, S("Teleported to home!")
-- 		end
-- 		return false, S("Set a home using /sethome")
-- 	end,
-- })

-- minetest.register_chatcommand("sethome", {
-- 	description = S("Set your home point"),
-- 	privs = {home = true},
-- 	func = function(name)
-- 		name = name or "" -- fallback to blank name if nil
-- 		local player = minetest.get_player_by_name(name)
-- 		if player and sethome.set(name, player:get_pos()) then
-- 			return true, S("Home set!")
-- 		end
-- 		return false, S("Player not found!")
-- 	end,
-- })
