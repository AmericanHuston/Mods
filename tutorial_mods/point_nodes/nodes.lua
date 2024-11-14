local storage = core.get_mod_storage()

core.register_node("point_nodes:one_node", {
    description = "1 Point Node",
    tiles = {"one_point_node.png"},
    is_ground_content = false,
    groups = {cracky = 1, oddly_breakable_by_hand = 1},
    on_dig = function(pos, node, digger)
        core.node_dig(pos, node, digger)
        digger = digger:get_player_name()
        if storage:get_int(digger) == nil then
            storage:set_int(digger, "0")
        else 
            local money = storage:get_int(digger)
            money = money + 1
            storage:set_int(digger, money)
        end
    end,
    drop = ""
})

core.register_node("point_nodes:five_node", {
    description = "5 Point Node",
    tiles = {"five_point_node.png"},
    is_ground_content = false,
    groups = {choppy = 1, oddly_breakable_by_hand = 2},
    on_dig = function(pos, node, digger)
        core.node_dig(pos, node, digger)
        digger = digger:get_player_name()
        if storage:get_int(digger) == nil then
            storage:set_int(digger, "0")
        else 
            local money = storage:get_int(digger)
            money = money + 5
            storage:set_int(digger, money)
        end
    end,
    drop = ""
})

core.register_node("point_nodes:ten_node", {
    description = "10 Point Node",
    tiles = {"ten_point_node.png"},
    is_ground_content = false,
    groups = {choppy = 2, wood = 1},
    on_dig = function(pos, node, digger)
        core.node_dig(pos, node, digger)
        digger = digger:get_player_name()
        if storage:get_int(digger) == nil then
            storage:set_int(digger, "0")
        else 
            local money = storage:get_int(digger)
            money = money + 10
            storage:set_int(digger, money)
        end
    end,
    drop = ""
})

core.register_node("point_nodes:one_hundred_node", {
    description = "100 Point Node",
    tiles = {"one_hundred_point_node.png"},
    is_ground_content = false,
    groups = {cracky = 3, stone = 3},
    on_dig = function(pos, node, digger)
        core.node_dig(pos, node, digger)
        digger = digger:get_player_name()
        if storage:get_int(digger) == nil then
            storage:set_int(digger, "0")
        else 
            local money = storage:get_int(digger)
            money = money + 100
            storage:set_int(digger, money)
        end
    end,
    drop = ""
})