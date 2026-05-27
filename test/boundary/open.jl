function test_open_boundary()
    boundary = OpenBoundary()
    periodic = is_periodic(boundary, 2)
    @test periodic == (false, false)
end
