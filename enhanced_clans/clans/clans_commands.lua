local storage = core.get_mod_storage()

core.register_chatcommand("showclan", {
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        local playercs = param .. "-clan" --player clan storage
        if param == "" then
            local player_clan = storage:get_string(player .. "-clan")
            core.chat_send_player(player, "Your clan is " .. player_clan)
        else
            local player_clan = storage:get_string(playercs)
            core.chat_send_player(player, param .. " is of the clan " .. player_clan)
        end
    end,
    description = "Usage: /showclan <player>"
})

core.register_chatcommand("setclan", {
    func = function(name, param)
        local success = false
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        local msg, to = param:match("^([%a%d_-]+) (.+)$")
        if param ~= "" then
            for i,v in pairs(clansmod.clans) do
                if to == v then
                    success = true
                    core.chat_send_player(player, "Match found")
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
            core.chat_send_player(player, to .. "Isn't a valid clan")
        end
    end,
    description = "Usage: /setclan <player> <clan>"
})

core.register_chatcommand("clearclan", {
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        if param ~= "" then
            local msg = param:match("^([%a%d_-]+)$")
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
        for i,v in ipairs(clansmod.clans) do
            core.chat_send_all(v)
        end
    end
})
core.register_chatcommand("showclan_members", {
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        local playercs = player .. "-clan"
        local table = clansmod.players_in_clan(storage:get_string(playercs))
        local str
        for i,v in ipairs(table) do
            str = v
            str = str .. ", " .. v
        end
        core.chat_send_player(player, str)
    end
})
core.register_chatcommand("newclan", {
    func = function(player, param)
        if param ~= "" then
            local msg = param:match("^([%a%d_-]+)$")
            clansmod.add_clan(msg)
        end
    end,
    description = "Usage: /new_clan <clanname>"
})
core.register_chatcommand("rmclan", {
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        if param ~= "" then
            local msg = param:match("^([%a%d_-]+)$")
            clansmod.delete_clan(player, msg)
        end
    end,
    description = "Usage: /rmclan <clanname>"
})