-- core.register_globalstep(function()
--     for _,player in ipairs(core.get_connected_players()) do
--         if player:get_velocity().y < 0 then
--             -- core.override_item("", {
--             --     tool_capabilities = {
--             --         full_punch_interval = 0.9,
--             --         max_drop_level = 0,
--             --         groupcaps = {
--             --             crumbly = {times={3.00, 0.70, 0.20}, uses=0, maxlevel=1},
--             --             cracky  = {times={2.00, 0.70, 0.30}, uses=0, maxlevel=1},
--             --             snappy  = {times={0.40, 0.30, 0.20}, uses=0, maxlevel=1},
--             --             choppy  = {times={3.00, 2.00, 1.00}, uses=0, maxlevel=1},
--             --             oddly_breakable_by_hand = {times={3.50, 2.00, 0.70}, uses=0},
--             --             -- dig_immediate group doesn't use value 1. Value 3 is instant dig
--             --         },
--             --         damage_groups = {fleshy = 10},
--             --     }
--             -- })
--             core.chat_send_player(player:get_player_name(), player:get_velocity().y)
--         else
--             -- core.override_item("", {
--             --     tool_capabilities = {
--             --         full_punch_interval = 0.9,
--             --         max_drop_level = 0,
--             --         groupcaps = {
--             --             crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
--             --             snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
--             --             oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
--             --         },
--             --         damage_groups = {fleshy=1},
--             --     }
--             -- })
--         end
--     end
-- end)

core.register_on_punchplayer(function(player_got_hit, hitter, time_from_last_punch, tool_capabilities, dir, damage)
    local vel = hitter:get_velocity().y
    core.chat_send_all(vel)
    if vel < 0 then
        core.chat_send_all("First if good")
        local standard_damage = tool_capabilities.damage_groups.fleshy
        local new_damage = standard_damage + math.round(-vel/2)
        core.chat_send_all(standard_damage.." "..new_damage)
        if standard_damage < new_damage then
            core.chat_send_all("second if good")
            local health = player_got_hit:get_hp()
            player_got_hit:set_hp(health - -(standard_damage - new_damage), "CRITICALLL")
        end
    end
end)