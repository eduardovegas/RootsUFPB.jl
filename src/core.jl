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

function time_root_calculation!(r::Root)
    pi_t = 0
    err_t = 0
    total_t = @elapsed begin
        try
            pi_t = calculate_root!(r)
        catch e
            err_t = @elapsed begin
                save_error_backtrace()
            end
        end
    end
    return total_t - (pi_t + err_t)
end

function calculate_root!(r::Root{Method}) where {Method<:BisectOrFalsePos}
    rdef = r.rootdef
    range = rdef.range
    f = rdef.f
    a = range.a
    b = range.b
    pi_t = @elapsed begin
        print_iteration_header(rdef)
    end
    k = 1
    while true
        f_a, f_b = f.([a, b])
        x_k = nextpoint(a, b, rdef.method, f_a, f_b)
        f_xk = f(x_k)
        pi_t += @elapsed begin
            print_iteration(k, a, b, f_a, f_b, x_k, f_xk)
        end
        !hasroot(f_a, f_b) && break
        if iszero(f_xk, rdef.ε) || iszero(abs(b-a), rdef.ε)
            r.root = x_k
            break
        end
        if hasroot(f_a, f_xk)
            b = x_k
        elseif hasroot(f_b, f_xk)
            a = x_k
        end
        k += 1
    end
    return pi_t
end

function calculate_root!(r::Root{Method}) where {Method<:Newton}
    rdef = r.rootdef
    range = rdef.range
    f = rdef.f
    x₀ = rdef.method.x₀
    xₖ₋₁ = NaN
    xₖ = x₀ === nothing ? rand(range.a:1e-4:range.b) : x₀
    pi_t = @elapsed begin
        print_iteration_header(rdef)
    end
    k = 1
    while true
        f_xk = f(xₖ)
        derivative_xk = f'(xₖ)
        pi_t += @elapsed begin
            print_iteration(k, xₖ, xₖ₋₁, f_xk, derivative_xk)
        end
        if iszero(f_xk, rdef.ε) || iszero(abs(xₖ-xₖ₋₁), rdef.ε)
            r.root = xₖ
            break
        end
        xₖ₋₁ = xₖ
        xₖ = nextpoint(xₖ, f_xk, derivative_xk, rdef.method)
        k += 1
    end
    return pi_t
end

function save_graph!(r::Root)
    r.root !== missing && addroot!(r)
    Plots.savefig(r.graph, string(r.rootdef.filename))
    return nothing
end

function save_error_backtrace()
    bu = open("error.log", "w")
    for (exc, bt) in current_exceptions()
        showerror(bu, exc, bt)
    end
    close(bu)
    return nothing
end
