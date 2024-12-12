unused_args = false
allow_defined_top = true

globals = {
    "core", "clansmod", "enhanced_pvp","eventadmin"
}

read_globals = {
    string = {fields = {"split"}},
    table = {fields = {"copy", "getn"}},

    -- Builtin
    "vector", "ItemStack",
    "dump", "DIR_DELIM", "VoxelArea", "Settings", "math",

    -- MTG
    "default", "sfinv", "creative",
}