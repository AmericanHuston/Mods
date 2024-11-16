local storage = core.get_mod_storage()
clansmod.add_to_clan(issuer, playername, false, tbd)

core.register_chatcommand("assign_clan", {
    func = function(name, param)
       local average_team_lvl
        local player = core.get_player_by_name(name)
        local player = player:get_player_name()
     if
})

function clansmod.players_per_clan(clan)
    local members

    for _, player in ipairs(core.get_connected_players()) do
        local playercs = player:get_player_name() .. "-clan"
        if storage:get_string(playercs) ~= nil then
            if storage:get_string(playercs) == clan then
                members = members + 1
            end
        end
    end
    return members
end


function clansmod.players_online()
    local ptable
    for _, player in ipairs(core.get_connected_players()) do
        table.insert(ptable, player:get_player_name())
    end

    local online = #ptable
    return online
    
end

function clansmod.players_in_clan(clan)
    local playercs
    local tbl_players_in_clan
    for i,v in ipairs(core.get_connected_players) do
        playercs = v:get_player_name() .. "-clan"
        if storage:get_string(playercs) == clan then
            table.insert(tbl_players_in_clan, v:get_player_name())
        end
    end
    return tbl_players_in_clan
end

-- clansmod.sorting_algorithim. the average is going to be determined by the median, not the mean or mode.
function clansmod.sorting_alg(average, median, levels)
    local online = clansmod.players_online()
    local clan_members
    local clans_lvl --2d table
    local ptable

    for i,v in ipairs(ptable) do
        local player_lvl_cs = v .. "-level"
        local player_lvl = storage:get_string(player_lvl_cs)
        if clans_lvl == nil then
            clans_lvl = player_lvl
        else
            clans_lvl = clans_lvl + player_lvl
        end
    end

    for i,v in ipairs(clansmod.clans) do
        local clan = v
        local clan_players = clansmod.players_in_clan(clan)
        for _, a in ipairs(clan_players) do
            local playername = a:get_player_name()
            local playercs = playername .. "-clan"
            local player_lvl_cs = playername .. "-level"
            local player_clan = storage:get_string(playercs)
            local player_lvl = storage:get_string(player_lvl_cs)
            if clans_lvl == nil then
                clans_lvl = player_lvl
            else
                clans_lvl = clans_lvl + player_lvl
            end
        table.insert(clan_members, clansmod.players_per_clan(v))
    end

    for i,v in ipairs(core.get_connected_players()) do
        table.insert(ptable, player:get_player_name())
    end
end