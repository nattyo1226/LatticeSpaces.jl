function test_periodic_boundary()
    boundary = PeriodicBoundary{2}()
    periodic = is_periodic(boundary)
    @test periodic == (true, true)
end
