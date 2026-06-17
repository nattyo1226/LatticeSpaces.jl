function test_open_boundary()
    b = OpenBoundary(2)
    @test periodic(b) == (false, false)
end

@testset "Open Boundary" begin
    test_open_boundary()
end
