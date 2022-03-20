function find_root(rootdef::RootDef)
    root = prepare_root(rootdef)
    t = time_root_calculation!(root)
    root.time_in_seconds = t
    save_graph!(root)
    return root
end
