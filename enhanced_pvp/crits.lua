function enhanced_pvp.crit(punchername)
    local caps = {full_punch_interval = 0.9,
    max_drop_level = 0,
    groupcaps = {
        crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
        snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
        oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
    },
    damage_groups = {fleshy=1},
}
    local inv = punchername:get_inventory()
    local stack = inv:get_stack("hand", 1)
    stack:set_tool_capabilities(caps)
    inv:set_stack("hand", 1, stack)
    punchername:punch(punchername, nil, caps, nil)
end