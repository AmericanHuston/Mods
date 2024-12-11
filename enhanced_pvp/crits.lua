core.register_globalstep(function()
    for _,player in ipairs(core.get_connected_players()) do
        local vel = player:get_velocity().y
        if vel < 0 then
            core.override_item("", {
                tool_capabilities = {
                    full_punch_interval = 0.9,
                    max_drop_level = 0,
                    groupcaps = {
                        crumbly = {times={3.00, 0.70, 0.20}, uses=0, maxlevel=1},
                        cracky  = {times={2.00, 0.70, 0.30}, uses=0, maxlevel=1},
                        snappy  = {times={0.40, 0.30, 0.20}, uses=0, maxlevel=1},
                        choppy  = {times={3.00, 2.00, 1.00}, uses=0, maxlevel=1},
                        oddly_breakable_by_hand = {times={3.50, 2.00, 0.70}, uses=0},
                        -- dig_immediate group doesn't use value 1. Value 3 is instant dig
                    },
                    damage_groups = {fleshy = 10},
                }
            })
        else
            core.override_item("", {
                wield_scale = {x=1,y=1,z=2.5},
                tool_capabilities = {
                    full_punch_interval = 0.9,
                    max_drop_level = 0,
                    groupcaps = {
                        crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
                        snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
                        oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
                    },
                    damage_groups = {fleshy=1},
                }
            })
        end
    end
end)