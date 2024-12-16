core.register_craftitem("clans_weapons:weapon1", {
    description = "A Powerful Weapon",
    inventory_image = "clans_weapons_water_sword.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            snappy = {times = {[1] = 1.90, [2] = 0.90, [3] = 0.30}, uses = 20, maxlevel = 3},
        },
        damage_groups = {fleshy = 15},
    }
})

core.register_craft({
    type = "shaped",
    output = "enhanced_pvp:weapon1",
    recipe = {
        {"","default:diamond", ""},
        {"","default:diamond", ""},
        {"","default:diamond", ""}
    },
})