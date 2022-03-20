abstract type AbstractMethod end
abstract type BisectOrFalsePos <: AbstractMethod end
struct Bisection <: BisectOrFalsePos end
struct FalsePosition <: BisectOrFalsePos end

@Base.kwdef struct Newton <: AbstractMethod
    x₀::Union{Float64,Nothing} = nothing
end

@Base.kwdef struct Secant <: AbstractMethod
    x₀::Union{Float64,Nothing} = nothing
    x₁::Union{Float64,Nothing} = nothing
end

Bisection(::String) = "Bisection"
FalsePosition(::String) = "False Position"
Newton(::String) = "Newton"
Secant(::String) = "Secant"

struct Range
    a::Float64
    b::Float64
end

mutable struct RootDef{Method}
    filename::String
    f::Function
    range::Range
    ε::Float64
    method::Method
end

mutable struct Root{Method}
    rootdef::RootDef{Method}
    time_in_seconds::Float64
    root::Union{Float64,Missing}
    graph::Plots.Plot
end
