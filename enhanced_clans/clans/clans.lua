local storage = core.get_mod_storage()
clansmod = {}

function clansmod.ser_clans()
    storage:set_string("clans-table", core.serialize(clansmod.clans))
end
function clansmod.deser_clans()
    clansmod.clans = core.deserialize(storage:get_string("clans-table"))
end
if storage:get_string("clans-table") == "" then
    clansmod.clans = {"mesa", "mountain", "river", "grassland"}
    clansmod.ser_clans()
else
    clansmod.deser_clans()
end

--core.register_on_prejoinplayer()

core.register_privilege("eventadmin", {
    description = "Can issue all clan commands",
    give_to_singleplayer = true
})

function clansmod.add_clan(clanname)
    local found = clansmod.clan_exists(clanname)
    if found == true then
        core.chat_send_all( "The clan " .. clanname .. " name is already taken!")
    else
        table.insert(clansmod.clans, clanname)
        clansmod.ser_clans()
        clansmod.deser_clans()
        core.chat_send_all("A new clan has been created!")
    end
end

function clansmod.delete_clan(issuername, clanname)
    local found = clansmod.clan_exists(clanname)
    local clanpos
    if found == true then
        for i,v in ipairs(clansmod.clans) do
            if v == clanname then
                clanpos = i
            end
        end
        table.remove(clansmod.clans, clanpos)
        clansmod.ser_clans()
        clansmod.deser_clans()
        core.chat_send_player(issuername, "Clan " .. clanname .. " has been deleted.")
    else
        core.chat_send_player(issuername, "Clan " .. clanname .. " does not exist.")
    end
end

function clansmod.add_to_clan(issuer, playername, random, clan) --MUST BE PLAYER NAME, NOT USERDATA
    local playercs = playername .. "-clan"
    local newclan
    local tablelen = #clansmod.clans
    if random == true then --random is a bool
        newclan = clansmod.clans[math.random(1, tablelen)] --have to use the len operator (#)
    else
        newclan = clan
    end
    if storage:get_string(playercs) == "" then
        storage:set_string(playercs, newclan)
        if issuer ~= nil then
            core.chat_send_player(issuer, "Your clan has been set to " .. newclan)
        end
    end
end

function clansmod.remove_from_clan(playername) --NAME, NOT USERDATA
    local playercs = playername .. "-clan"
    if storage:get_string(playercs) then
        storage:set_string(playercs, nil)
    end
end

function clansmod.players_in_clan(clan)
    local playercs
    local tbl_players_in_clan = {}
    for i,v in ipairs(core.get_connected_players()) do
        playercs = v:get_player_name() .. "-clan"
        if storage:get_string(playercs) == clan then
            table.insert(tbl_players_in_clan, v:get_player_name())
        end
    end
    return tbl_players_in_clan
end

function clansmod.killer(killer, victim)
    local killercs = killer .. "-level"
    local victimcs = victim .. "-level"
    local klevel = storage:get_int(killercs)
    local vlevel = storage:get_int(victimcs)

    if vlevel ~= 0 then
        vlevel = vlevel - 1
        storage:set_int(victimcs, vlevel)
    end

    if klevel ~= 5 then
        klevel = klevel + 1
        storage:set_int(killercs, klevel)
    end

    core.chat_send_player(victim, "Your level is now " .. storage:get_int(victimcs))
end

function clansmod.clan_exists(clanname)
    local found
    for i,v in pairs(clansmod.clans) do
        if v == clanname then
            found = true
        else
            found = false
        end
    end
    return found
end

core.register_on_joinplayer(function(name, last_login)
    local player = name:get_player_name()
    clansmod.add_to_clan(nil, player, true)
    if storage:get_int(player .. "-level") == nil then
        storage:set_int(player .. "-level", 0)
    end
end
)