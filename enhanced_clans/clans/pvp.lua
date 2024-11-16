local storage = core.get_mod_storage()

function clansmod.killer(killer, victim)
    local killercs = killer .. "-level"
    local victimcs = victim .. "-level"
    local klevel = storage:get_int(killercs)
    local vlevel = storage:get_int(victimcs)

    if vlevel ~= 0 then
        vlevel = vlevel - 1
        storage:set_int(victimcs, vlevel)
    end

    if klevel ~= 5 then
        klevel = klevel + 1
        storage:set_int(killercs, klevel)
    end

    core.chat_send_player(victim, "Your level is now " .. storage:get_int(victimcs))
end

core.register_on_dieplayer(function(player, reason)
    local player = player:get_player_name()
    local level = storage:get_int(player .. "-level")
    for i,v in pairs(reason) do
        if type(v) == "userdata" then
            core.chat_send_player(player, v:get_player_name() .. " has killed you")
            clansmod.killer(player, v:get_player_name())
        end
    end
    if level ~= 0 then
        level = level - 1
        storage:set_int(player .. "-level", level)
        core.chat_send_player(player, "Your level is now " .. level)
    else
        core.chat_send_player(player, "Your level is " .. level)
    end
end
)