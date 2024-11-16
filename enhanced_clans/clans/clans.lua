local storage = core.get_mod_storage()
clansmod = {}
clansmod.clans = {"mesa", "mountain", "river", "grassland"}
if storage:get_string("clans-table") == nil then
    storage:set_string("clans-table", core.serialize(clansmod.table))
else
    clansmod.clans = core.deserialize(storage:get_string("clans-table"), safe = true)
end

--core.register_on_prejoinplayer()

core.register_privilege("eventadmin", {
    description = "Can issue all clan commands",
    give_to_singleplayer = true
})

function clansmod.add_clan(issuername, clanname)
    local found = clansmod.clan_exists(clanname)
        if found == true then
            core.chat_send_player(player, "The clan " .. clanname .. " name is already taken!")
        elseif found == false then
            table.insert(clansmod.clans, clanname)
            storage:set_string("clans-table", core.serialize(clansmod.clans))
            core.chat_send_all("A new clan has been created!")
        end 
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
        storage:set_string(clansmod, core.serialize(clansmod.clans))

function clansmod.add_to_clan(issuer, playername, random, clan) --MUST BE PLAYER NAME, NOT USERDATA
    local playercs = playername .. "-clan"
    local newclan
    if random == true then --random is a bool
        newclan = clansmod.clans[math.random(1, #clansmod.clans)] --have to use the len operator (#)
    else
        newclan = clan
    end
    if storage:get_string(playercs) == nil then
        storage:set_string(playercs, newclan)
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
    if last_login == nil then
        storage:set_int(player .. "-level", 0)
    end
end
)

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