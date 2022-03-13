using Test

include("../src/RootsUFPB.jl")
include("unit/unit.jl")
include("integration/integration.jl")

run_unit_tests()
run_integration_tests()
