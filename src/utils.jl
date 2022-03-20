iszero(v::Float64, ε::Float64) = isapprox(v, 0.0, atol=ε)
hasroot(a::Float64, b::Float64) = a*b < 0.0

function nextpoint(a::Float64, b::Float64, ::Bisection, f_a::Float64 = NaN, f_b::Float64 = NaN)
    return (a+b)/2.0
end

function nextpoint(a::Float64, b::Float64, ::FalsePosition, f_a::Float64, f_b::Float64)
    mod_fa = abs(f_a)
    mod_fb = abs(f_b)
    return (a*mod_fb+b*mod_fa)/(mod_fb+mod_fa)
end

function nextpoint(xₖ::Float64, f_xk::Float64, derivative_xk::Float64, ::Newton)
    return xₖ-(f_xk/derivative_xk)
end

function addroot!(r::Root)
    x = r.root
    y = r.rootdef.f(x)
    Plots.scatter!([x], [y], label="root")
    return nothing
end
