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

function print_iteration(
    id::Int,
    a::T,
    b::T,
    f_a::T,
    f_b::T,
    x_k::T,
    f_xk::T
) where {T<:Float64}
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
    println(io, "     Time : ", @sprintf("%.4fs", root.time_in_seconds))
    println(io, "     Root : ", @sprintf("%.4f", root.root))
    return nothing
end
