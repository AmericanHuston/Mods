local storage = core.get_mod_storage()
core.register_on_dieplayer(function(player)
    local playercs = player .. "-clan"
    local clan = storage:get_string(playercs)
    
end
)