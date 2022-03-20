module RootsUFPB

import Plots, PlotlyJS
using Printf, CalculusWithJulia

include("structs.jl")
include("visualization.jl")
include("utils.jl")
include("core.jl")
include("api.jl")

export
    Range,
    Bisection,
    FalsePosition,
    Newton,
    Secant,
    RootDef,
    Root,
    find_root

end
