local storage = core.get_mod_storage()

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
    return tostring(tbl_players_in_clan)
end

function clansmod.clan_level(clan)
    for i,v in ipairs(clansmod.clans) do
        local clan = v
        local clan_players = clansmod.players_in_clan(clan)
        for _, a in ipairs(clan_players) do
            local player_lvl_cs = a .. "-level"
            local player_lvl = storage:get_int(player_lvl_cs)
            if clan_lvl == nil then
                clan_lvl = player_lvl
            else
                clan_lvl = clan_lvl + player_lvl
            end
        end
    end
    return clan_lvl
end

-- clansmod.sorting_algorithim. the average is going to be determined by the median, not the mean or mode.
function clansmod.sorting_alg()
    local online = clansmod.players_online()
    local clan_lvl
    local clan_players
    
    for i,v in ipairs(clansmod.clans) do
        local clan = v
        clan_players = clansmod.players_in_clan(clan)
        clan_lvl = clansmod.clan_level(clan)
        storage:set_int(clan .. "-level", clan_lvl)
    end
end