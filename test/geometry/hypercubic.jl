function test_hypercubic_1()
    g = Hypercubic(4, 4)
    periodic = (true, true)
    site_id = 5
    neighbor_ids = neighbors(g, periodic, site_id)
    @test neighbor_ids == [1, 6, 8, 9]

    pairs = neighbor_pairs(g, periodic)
    @test pairs == [
        (1, 2), (1, 4), (1, 5), (1, 13),
        (2, 3), (2, 6), (2, 14),
        (3, 4), (3, 7), (3, 15),
        (4, 8), (4, 16),
        (5, 6), (5, 8), (5, 9),
        (6, 7), (6, 10),
        (7, 8), (7, 11),
        (8, 12),
        (9, 10), (9, 12), (9, 13),
        (10, 11), (10, 14),
        (11, 12), (11, 15),
        (12, 16),
        (13, 14), (13, 16),
        (14, 15),
        (15, 16),
    ]
end

function test_hypercubic_2()
    g = Hypercubic(3, 3, 3)
    periodic = (false, false, false)
    site_id = 13
    neighbor_ids = neighbors(g, periodic, site_id)
    @test neighbor_ids == [4, 10, 14, 16, 22]

    pairs = neighbor_pairs(g, periodic)
    @test pairs == [
        (1, 2), (1, 4), (1, 10),
        (2, 3), (2, 5), (2, 11),
        (3, 6), (3, 12),
        (4, 5), (4, 7), (4, 13),
        (5, 6), (5, 8), (5, 14),
        (6, 9), (6, 15),
        (7, 8), (7, 16),
        (8, 9), (8, 17),
        (9, 18),
        (10, 11), (10, 13), (10, 19),
        (11, 12), (11, 14), (11, 20),
        (12, 15), (12, 21),
        (13, 14), (13, 16), (13, 22),
        (14, 15), (14, 17), (14, 23),
        (15, 18), (15, 24),
        (16, 17), (16, 25),
        (17, 18), (17, 26),
        (18, 27),
        (19, 20), (19, 22),
        (20, 21), (20, 23),
        (21, 24),
        (22, 23), (22, 25),
        (23, 24), (23, 26),
        (24, 27),
        (25, 26),
        (26, 27),
    ]
end

@testset "Hypercubic Geometry" begin
    test_hypercubic_1()
    test_hypercubic_2()
end
