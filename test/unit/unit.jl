function run_unit_tests()
    @testset "Unit" begin
        @testset "Close to zero" begin
            ε = rand()
            @test RootsUFPB.iszero(0.0, ε) == true
            @test RootsUFPB.iszero(ε, ε) == true
            @test RootsUFPB.iszero(ε+ε, ε) == false
        end

        @testset "Intermediate Value Theorem" begin
            a, b = rand(2)
            @test RootsUFPB.hasroot(a, b) == false
            @test RootsUFPB.hasroot(a, -b) == true
            @test RootsUFPB.hasroot(-a, b) == true
            @test RootsUFPB.hasroot(-a, -b) == false
        end

        @testset "Bisection next point" begin
            a, b = rand(2)
            @test RootsUFPB.nextpoint(a, b, RootsUFPB.Bisection()) == (a+b)/2.0
        end

        @testset "False Position next point" begin
            a, f_a, b, f_b = rand(4)
            @test RootsUFPB.nextpoint(a, b, RootsUFPB.FalsePosition(), f_a=f_a, f_b=f_b) ==
                (a*abs(f_b)+b*abs(f_a))/(abs(f_b)+abs(f_a))
        end
    end
    return nothing
end