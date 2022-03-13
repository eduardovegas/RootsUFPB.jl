function run_integration_tests()
    @testset "Integration" begin
        @testset "Bisection method" begin
            rootdef = RootsUFPB.RootDef(
                "x²ln(x)-1 Bisect.png",
                (x) -> x^2*log(x)-1,
                RootsUFPB.Range(0.1, 2),
                2e-3,
                RootsUFPB.Bisection()
            )
            ς = 1.5314941406249998
            r = RootsUFPB.find_root(rootdef)
            @show r
            @test r.root == ς
        end

        @testset "False Position method" begin
            rootdef = RootsUFPB.RootDef(
                "x²ln(x)-1 FalsePosition.png",
                (x) -> x^2*log(x)-1,
                RootsUFPB.Range(0.1, 2),
                2e-3,
                RootsUFPB.FalsePosition()
            )
            ς = 1.531280329416501
            r = RootsUFPB.find_root(rootdef)
            @show r
            @test r.root == ς
        end
    end
    return nothing
end