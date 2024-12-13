minetest.register_craftitem("clans_weapons:weapon1", {
    description = "A Powerful Weapon",
    inventory_image = "clans_weapons_water_sword.png"
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