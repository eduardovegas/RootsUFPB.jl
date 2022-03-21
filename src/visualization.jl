function print_iteration_header(::RootDef{Method}) where {Method<:BisectOrFalsePos}
    method_str = Method("")
    @info "$method_str started"
    @info "       |          range          |         f(range)        |                 root                 |"
    @info " iter. |          a |          b |       f(a) |       f(b) |         xₖ |      f(xₖ) |      b - a |"
    return nothing
end

function print_iteration_header(::RootDef{Method}) where {Method<:Newton}
    method_str = Method("")
    @info "$method_str started"
    @info "       |                        root                       |"
    @info " iter. |         xₖ |      f(xₖ) |     f'(xₖ) |  xₖ - xₖ₋₁ |"
    return nothing
end

function print_iteration_header(::RootDef{Method}) where {Method<:Secant}
    method_str = Method("")
    @info "$method_str started"
    @info "       |                                           root                                           |"
    @info " iter. |       xₖ₋₁ |         xₖ |       xₖ₊₁ |    f(xₖ₋₁) |      f(xₖ) |    f(xₖ₊₁) |  xₖ₊₁ - xₖ |"
    return nothing
end

function print_iteration(
    id::Int,
    a::Float64,
    b::Float64,
    f_a::Float64,
    f_b::Float64,
    x_k::Float64,
    f_xk::Float64,
    ::RootDef{Method}
) where {Method<:BisectOrFalsePos}
    str = @sprintf(
        " %5d | %10.4f | %10.4f | %10.4f | %10.4f | %10.4f | %10.4f | %10.4f |",
        id,
        a,
        b,
        f_a,
        f_b,
        x_k,
        f_xk,
        abs(b-a)
    )
    @info str
    return nothing
end

function print_iteration(
    id::Int,
    xₖ::Float64,
    xₖ₋₁::Float64,
    f_xk::Float64,
    derivative_xk::Float64,
    ::RootDef{Method}
) where {Method<:Newton}
    str = @sprintf(
        " %5d | %10.4f | %10.4f | %10.4f | %10.4f |",
        id,
        xₖ,
        f_xk,
        derivative_xk,
        abs(xₖ-xₖ₋₁)
    )
    @info str
    return nothing
end

function print_iteration(
    id::Int,
    xₖ₋₁::Float64,
    xₖ::Float64,
    xₖ₊₁::Float64,
    f_xk₋₁::Float64,
    f_xk::Float64,
    f_xk₊₁::Float64,
    ::RootDef{Method}
) where {Method<:Secant}
    str = @sprintf(
        " %5d | %10.4f | %10.4f | %10.4f | %10.4f | %10.4f | %10.4f | %10.4f |",
        id,
        xₖ₋₁,
        xₖ,
        xₖ₊₁,
        f_xk₋₁,
        f_xk,
        f_xk₊₁,
        abs(xₖ₊₁-xₖ)
    )
    @info str
    return nothing
end

function Base.show(io::IO, rootdef::RootDef{Method}) where {Method<:AbstractMethod}
    println(io, "File Name : ", rootdef.filename)
    println(io, "     From : ", rootdef.range.a)
    println(io, "       To : ", rootdef.range.b)
    println(io, "    Error : ", rootdef.ε)
    println(io, "   Method : ", Method(""))
    return nothing
end

function Base.show(io::IO, root::Root)
    println(io)
    println(io, " RootUFPB : ")
    print(io, root.rootdef)
    println(io, "     Time : ", @sprintf("%.6fs", root.time_in_seconds))
    println(io, "     Root : ", @sprintf("%.6f", root.root))
    return nothing
end
