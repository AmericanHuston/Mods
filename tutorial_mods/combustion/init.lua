core.register_abm({
    nodenames = {"air"},
    neighbors = {"air", "fire:basic_flame"},
    intreval = 1.0,
    chance = 1.0,
    action = function(pos)
        local pos = {x = pos.x, y = pos.y + 1, z = pos.z}
        core.set_node(pos, {name = "fire:basic_flame"})
        core.chat_send_all("THE END IS NIGH AT HAND")
    end
})