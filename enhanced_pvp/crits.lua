function enhanced_pvp.crit(punchername)
    local caps = {full_punch_interval = 2, }
    local inv = punchername:get_inventory()
    local stack = inv:get_stack("hand", 1)
    stack:set_tool_capabilities(caps)
    inv:set_stack("hand", 1, stack)
    punchername:punch(punchername, nil, caps, nil)
end