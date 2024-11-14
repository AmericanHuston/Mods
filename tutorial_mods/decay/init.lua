core.register_abm({
    nodenames = {"default:tree"},
    neighbors = {"default:water_flowing", "default:water_source"},
    intreval = 20.0,
    chance = 100.0,
    action = function(pos)
        local pos = {x = pos.x, y = pos.y + 1, z = pos.z}
        core.set_node(pos, {name = "default:dirt"})
        core.chat_send_all("A piece of wood has turned to dirt!")
    end
})