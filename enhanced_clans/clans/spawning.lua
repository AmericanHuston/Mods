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

core.register_node("clans:clanspawn", {
    description = "Testing a formspec",
    tiles = {"clan_spawn_node.png"},
    groups = {cracky = 1},
    after_place_node = function(pos, placer)
        -- This function is run when the chest node is placed.
        -- The following code sets the formspec for chest.
        -- Meta is a way of storing data onto a node.

        local meta = core.get_meta(pos)
        local prevClan = meta:get_string("clan_on_node") or ""
        meta:set_string("formspec",
        "formspec_version[4]"..
        "size[8,4]"..
        "label[0.375,0.5;Which clan should spawn members here?]"..
        "field[Clanname;Clanname;".. core.formspec_escape(prevClan) ..";]"..
        "button[3.5,3.0;3,0.8;submit;Submit]")
    end,

    on_receive_fields = function(pos, formname, fields, player)
        if fields.quit then
            return
        end

        local meta = core.get_meta(pos)
        local clan = fields.Clanname
        local clanss = clan .. "-spawn"
        pos = {x = pos.x, y = pos.y + 0.5, z = pos.z}
        storage:set_string(clanss, core.serialize(pos))
        meta:set_string("clan_on_node", fields.Clanname)

        core.chat_send_all(fields.Clanname)
    end,
    on_destruct = function(pos)
        local meta = core.get_meta(pos)
        local clan = meta:get_string("clan_on_node")
        local clanSpawnNew = {x = 0, y = 40, z = 0}
        storage:set_string(clan .. "-spawn", core.serialize(clanSpawnNew))
    end
})