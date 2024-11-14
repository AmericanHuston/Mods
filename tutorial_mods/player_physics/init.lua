core.register_chatcommand("antigravity", {
    func = function(name, param)
        local player = core.get_player_by_name(name)
        local to, msg = param:match("^([%d]+) (.+)$")
        player:set_physics_override({
            gravity = msg
        })
    end,
    description = "Usage: /antigravity <int>"
})

core.register_chatcommand("superspeed", {
    func = function(name, param)
        local player = core.get_player_by_name(name)
        local to, msg = param:match("^([%d]+) (.+)$")
        player:set_physics_override({
            speed = msg
        })
    end,
    description = "Usage: /superspeed <int>"
})

core.register_chatcommand("jumpy", {
    func = function(name, param)
        local player = core.get_player_by_name(name)
        local msg = param:match("^([%d]+) (.+)$")
        player:set_physics_override({
            jump = msg
        })
    end,
    description = "Usage: /jumpy <int>"
})

core.register_chatcommand("superpower", {
    func = function(name, param)
        local player = core.get_player_by_name(name)
        local msg, to = param:match("^([%a%d]+) ([%d]+)$")
        if (msg == "jumpy") then
            player:set_physics_override({jump = to})
        elseif (msg == "speedy") then 
            player:set_physics_override({speed = to})
        elseif (msg == "floaty") then
            player:set_physics_override({gravity = to})
        else
            core.chat_send_player(name, "Usage: /superpower <jumpy, speedy, floaty> <int>")
        end
    end,
    description = "Usage: /superpower <jumpy, speedy, floaty> <int>"
})