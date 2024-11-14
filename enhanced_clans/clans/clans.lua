local storage = core.get_mod_storage()
clansmod = {}
clansmod.clans = {"mesa", "mountain", "river", "grassland"}

core.register_privilege("eventadmin", {
    description = "Can issue all clan commands",
    give_to_singleplayer = true
})


function clansmod.add_to_clan(issuer, playername, random, clan) --MUST BE PLAYER NAME, NOT USERDATA
    local playercs = playername .. "-clan"
    if random then --random is a bool
        local newclan = clansmod.clans[math.random(1,clansmod.tablelength(clansmod.clans))]
    else
        local newclan = clan
    end
    if storage:get_string(playercs) == nil then
        storage:set_string(playername, newclan)
        if issuer ~= nil then
            core.chat_send_player(issuer, "Your clan has been set to " .. newclan)
        end
    end
end

function clansmod.remove_from_clan(issuer, playername) --NAME, NOT USERDATA
    local playercs = playername .. "-clan"
    if storage:get_string(playercs) then
        storage:set_string(playercs, nil)
    end
end

core.register_on_joinplayer(function(player, last_login)
    local player = player:get_player_name()
    clansmod.add_to_clan(nil, player, true)
end
)

function clansmod.tablelength(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

function 