core.register_abm({
    nodenames = {"default:water_flowing"},
    neighbors = {"default:water_flowing"},
    intreval = 5.0,
    chance = 100.0,
    action = function(pos)
        local pos = {x = pos.x, y = pos.y + 1, z = pos.z}
        core.set_node(pos, {name = "default:goldblock"})
        core.chat_send_all("A new water has turned to gold!")
    end
})