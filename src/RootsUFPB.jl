module RootsUFPB

import Plots, PlotlyJS
using Printf

include("structs.jl")
include("visualization.jl")
include("utils.jl")
include("core.jl")
include("api.jl")

export
    Range,
    Bisection,
    FalsePosition,
    RootDef,
    Root,
    find_root

end
