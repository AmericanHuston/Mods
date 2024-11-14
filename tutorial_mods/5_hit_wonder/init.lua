local hits = 0

core.register_node("5_hit_wonder:5_tap", {
    description = "Node that vanishes after 5 hits",
    tiles = {"bones_rear.png"},
    is_ground_content = false,
    groups = {cracky=1, oddly_breakable_by_hand=1},
    drop = "default:diamond",
    on_punch = function(pos, node, puncher, pointed_thing)
        if puncher:is_player() then
            hits = hits + 1
            if (hits == 5) then
                core.remove_node(pos)
                hits = 0
            end
        end
    end
})
