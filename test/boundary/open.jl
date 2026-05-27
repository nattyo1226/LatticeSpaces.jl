function test_open_boundary()
    boundary = OpenBoundary{2}()
    periodic = is_periodic(boundary)
    @test periodic == (false, false)
end
