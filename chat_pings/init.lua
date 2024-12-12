core.register_on_chat_message(function(name, initial_message)
    local message = initial_message
    local words = {}
    words[1], words[2] = message:match("(%w+)(.+)")
    if message ~= nil then
        core.chat_send_all(words[1])
        for i, player in ipairs(core.get_connected_players()) do
            if words[1] .. words[2] == player:get_player_name() then
                core.sound_play( {name = "ping", gain = 2.0, pitch = 1.0, to_player = words[1]:gsub('@','')})
            end
            if player:get_player_name() == words[1]:gsub('%@', '') then --Gets rid of the @
                core.sound_play( {name = "ping", gain = 2.0, pitch = 1.0, to_player = words[1]:gsub('@','')})
            end
        end
    end
end)