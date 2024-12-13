core.register_on_punchplayer(function(player_got_hit, hitter, time_from_last_punch, tool_capabilities, dir, damage)
    if time_from_last_punch >= tool_capabilities.full_punch_interval then
    local vel = hitter:get_velocity().y
        if vel < 0 then
            local standard_damage = tool_capabilities.damage_groups.fleshy
            local new_damage = standard_damage + -1
            if standard_damage < new_damage then
                local health = player_got_hit:get_hp()
                player_got_hit:set_hp(health - -(standard_damage - new_damage), "CRITICALLL")
            end
        end
    end
end)