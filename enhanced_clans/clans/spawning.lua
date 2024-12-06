local storage = core.get_mod_storage()

core.register_on_respawnplayer(function(userdata) --need userdata for name:get/set_pos()
    local player = userdata:get_player_name()
    local playercs = player .. "-clan"
    local clan = storage:get_string(playercs)
    local clanss = clan .. "-spawn"
    local spawnPoint = storage:get_string(clanss)
    spawnPoint = core.deserialize(spawnPoint)
    core.after(0.5,function()
        userdata:set_pos(spawnPoint)
    end
    )
end)

core.register_on_dieplayer(function(name, reason)
    local player = name:get_player_name()
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

