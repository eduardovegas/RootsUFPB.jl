function find_root(rootdef::RootDef)
    root = prepare_root(rootdef)
    t = @elapsed begin
        calculate_root!(root)
    end
    root.time_in_seconds = t
    save_graph!(root)
    return root
end
