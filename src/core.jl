function prepare_root(rootdef::RootDef)
    Plots.plotlyjs() # backend
    r = Root(
        rootdef,
        0.0,
        missing,
        Plots.plot(
            rootdef.f,
            rootdef.range.a,
            rootdef.range.b,
            label="f(x)"
        )
    )
    return r
end

function calculate_root!(r::Root{Method}) where {Method<:BisectOrFalsePos}
    rdef = r.rootdef
    range = rdef.range
    f = rdef.f
    a = range.a
    b = range.b
    print_iteration_header(rdef)
    i = 1
    while true
        f_a, f_b = f.([a, b])
        next = nextpoint(a, b, rdef.method, f_a=f_a, f_b=f_b)
        f_next = f(next)
        print_iteration(i, a, b, f_a, f_b, next, f_next)
        !hasroot(f_a, f_b) && break
        if iszero(f_next, rdef.ε) || iszero(abs(b-a), rdef.ε)
            r.root = next
            break
        end
        if hasroot(f_a, f_next)
            b = next
        elseif hasroot(f_b, f_next)
            a = next
        end
        i += 1
    end
    return r
end

function save_graph!(r::Root)
    r.root !== missing && addroot!(r)
    Plots.savefig(r.graph, string(r.rootdef.filename))
    return nothing
end
