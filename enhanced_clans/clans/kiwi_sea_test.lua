local storage = core.get_mod_storage()

core.register_on_dieplayer(function(player, reason)
    --clansmod.killer(player, player)
    core.chat_send_player(player, reason)
)

core.register_on_joinplayer(function(player, last_login)
    if last_login == nil then
        local klevel = storage:set_int(killer .. "-level", 0)
        local vlevel = storage:set_int(victim .. "-level", 0)
    end
end    
)

function clansmod.killer(killer, victim)
    local klevel = storage:get_int(killer .. "-level")
    local vlevel = storage:get_int(victim .. "-level")

    if vlevel ~= 0 then
        vlevel = vlevel - 1
    end

    if klevel ~= 5 then
        klevel = klevel + 1
    end
end
