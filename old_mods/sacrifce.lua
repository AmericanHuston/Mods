minetest.register_on_dieplayer(function(player, punch)
    
end)

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	local hitter_name = hitter:get_player_name()
	local player_name = player:get_player_name()
	if player:get_hp() > 0 and player:get_hp() - damage <= 0 and 
	minetest.is_player(hitter) and hitter_name ~= player_name then
		local heart_num = hitter:get_properties().hp_max / 2
		if not (heart_num >= lifesteal_mod.max_hearts) then
			local health = hitter:get_meta():get_int("health") + 2
			hitter:get_meta():set_int("health", health)

			lifesteal_mod.change_hp_max(hitter, health, health, false)
		else
			local inv = hitter:get_inventory()
			if inv:room_for_item("main", {name = "lifesteal_mod:heart"}) then
				inv:add_item("main", "lifesteal_mod:heart")
			else
				minetest.add_item(hitter:get_pos(), {name = "lifesteal_mod:heart"})
			end
		end
		minetest.log("action", string.format("[Lifesteal Mod] %s killed and took a heart from %s.", hitter_name, player_name))
	end
end)