local storage = core.get_mod_storage()

core.register_chatcommand("points", {
    func = function(name, param)
        local player = core.get_player_by_name(name)
        local player = player:get_player_name()
        local money = storage:get_int(player)
        core.chat_send_player(player, money)
    end,
    description = "Shows your points"
})