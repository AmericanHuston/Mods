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