function test_all_to_all()
    g = AllToAll(4)
    periodic = (false,)
    site_id = 2
    neighbor_ids = neighbors(g, periodic, site_id)
    @test neighbor_ids == [1, 3, 4]

    pairs = neighbor_pairs(g, periodic)
    @test pairs == [
        (1, 2), (1, 3), (1, 4),
        (2, 3), (2, 4),
        (3, 4),
    ]
end

@testset "AllToAll Geometry" begin
    test_all_to_all()
end
