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

        @testset "Newton method" begin
            rootdef = RootsUFPB.RootDef(
                "x²ln(x)-1 Newton.png",
                (x) -> x^2*log(x)-1,
                RootsUFPB.Range(0.1, 2),
                2e-3,
                RootsUFPB.Newton(1.2150)
            )
            ς = 1.531615036354796
            r = RootsUFPB.find_root(rootdef)
            @show r
            @test r.root == ς
        end

        @testset "Secant method" begin
            rootdef = RootsUFPB.RootDef(
                "x²ln(x)-1 Secant.png",
                (x) -> x^2*log(x)-1,
                RootsUFPB.Range(0.1, 2),
                2e-3,
                RootsUFPB.Secant(1.3075, 1.8714)
            )
            ς = 1.5319059631577356
            r = RootsUFPB.find_root(rootdef)
            @show r
            @test r.root == ς
        end
    end
    return nothing
end