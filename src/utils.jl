iszero(v::Float64, ε::Float64) = isapprox(v, 0.0, atol=ε)
hasroot(a::Float64, b::Float64) = a*b < 0.0

function nextpoint(a::Float64, b::Float64, ::Bisection; kwargs...)
    return (a+b)/2.0
end

function nextpoint(a::Float64, b::Float64, ::FalsePosition; kwargs...)
    mod_fa = abs(kwargs[:f_a])
    mod_fb = abs(kwargs[:f_b])
    return (a*mod_fb+b*mod_fa)/(mod_fb+mod_fa)
end

function addroot!(r::Root)
    x = r.root
    y = r.rootdef.f(x)
    Plots.scatter!([x], [y], label="root")
    return nothing
end
