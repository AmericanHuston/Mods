minetest.register_craftitem("enhanced_pvp:weapon1", {
    description = "A Powerful Weapon",
    inventory_image = ""
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