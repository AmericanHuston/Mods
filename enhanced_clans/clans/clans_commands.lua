local storage = core.get_mod_storage()

core.register_chatcommand("showclan", {
    func = function(name, param)
        local player = core.get_player_by_name(name)
        local player = player:get_player_name()
        local playercs = param .. "-clan" --player clan storage
        if storage:get_string(playercs) ~= nil then
            if param == "" then
                core.chat_send_player(player, storage:get_string(player))
            else
                local player_clan = storage:get_string(param)
                core.chat_send_player(player, param .. " is of the clan " .. storage:get_string(playercs))
            end
        else
            core.chat_send_player(player, "Either the player doesn't exist, or you did something wrong")
        end
    end,
    description = "Usage: /showclan <player>"
})

core.register_chatcommand("setclan", {
    func = function(name, param)
        local success = false
        local player = core.get_player_by_name(name)
        local player = player:get_player_name()
        if param ~= "" then
            local msg, to = param:match("^([%a%d]+) (.+)$")
            for i,v in pairs(clansmod.clans) do
                if msg == v then
                    success = true
                end
            end
            if success then
                local playercs = msg .. "-clan" --player clan storage
                storage:set_string(playercs, to)
                core.chat_send_player(player, "Set player " .. msg .. "'s clan to " .. to)
            else
                core.chat_send_player(player, "Usage: /setclan <player> <clan>")
            end
        else
            core.chat_send_player(player, msg .. "Isn't a valid clan")
        end
    end,
    description = "Usage: /setclan <player> <clan>"
})

core.register_chatcommand("clearclan", {
    func = function(name, param)
        local player = core.get_player_by_name(name)
        local player = player:get_player_name()
        if param ~= "" then
            local msg, to = param:match("^([%a%d]+)$")
            local playercs = msg .. "-clan" --player clan storage
            storage:set_string(playercs, nil)
            core.chat_send_player(player, "Set player " .. msg .. "'s clan to nil")
        else
            core.chat_send_player(player, "Usage: /clearclan <player>")
        end
    end,
    description = "Usage: /clearclan <player>"
})

core.register_chatcommand("testadd", {
    func = function(player, param)
        if core.check_player_privs(player, { interact=true }) ~= true then
            core.chat_send_player(player, "You need eventadmin for this")
        else
            if param ~= "" then
                local msg, to = param:match("^([%a%d]+)$")
                clansmod.add_to_clan(player, msg, true)
            end
        end
    end,
})