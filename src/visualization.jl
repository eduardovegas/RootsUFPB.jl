function print_iteration_header(::RootDef{Method}) where {Method<:BisectOrFalsePos}
    method_str = Method("")
    @info "$method_str started"
    @info "       |          range          |         f(range)        |                 root                 |"
    @info " iter. |          a |          b |       f(a) |       f(b) |       next |    f(next) |      b - a |"
    return nothing
end

function print_iteration(
    id::Int,
    a::T,
    b::T,
    f_a::T,
    f_b::T,
    next::T,
    f_next::T
) where {T<:Float64}
    str = @sprintf(
        " %5d | %10.4f | %10.4f | %10.4f | %10.4f | %10.4f | %10.4f | %10.4f |",
        id,
        a,
        b,
        f_a,
        f_b,
        next,
        f_next,
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
    println(io, "     Time : ", root.time_in_seconds, "s")
    println(io, "     Root : ", root.root)
    return nothing
end
