function test_periodic_boundary()
    boundary = PeriodicBoundary()
    periodic = is_periodic(boundary, 2)
    @test periodic == (true, true)
end
