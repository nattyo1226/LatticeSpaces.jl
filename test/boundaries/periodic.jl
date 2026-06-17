function test_periodic_boundary()
    b = PeriodicBoundary(2)
    @test periodic(b) == (true, true)
end

@testset "Periodic Boundary" begin
    test_periodic_boundary()
end
