function test_lattice()
    geometry = Hypercubic(4, 4)
    boundary = OpenBoundary()
    lattice = Lattice(geometry, boundary)

    @test ndims(lattice) == 2
    @test size(lattice) == (4, 4)
    @test nsites(lattice) == 16
    @test coord(lattice, 5) == (2, 1)
    @test id(lattice, (2, 1)) == 5
    @test neighbors(lattice, 5) == [1, 6, 9]
    @test neighbor_pairs(lattice) == [
        (1, 2), (1, 5),
        (2, 3), (2, 6),
        (3, 4), (3, 7),
        (4, 8),
        (5, 6), (5, 9),
        (6, 7), (6, 10),
        (7, 8), (7, 11),
        (8, 12),
        (9, 10), (9, 13),
        (10, 11), (10, 14),
        (11, 12), (11, 15),
        (12, 16),
        (13, 14),
        (14, 15),
        (15, 16),
    ]
    @test is_periodic(lattice) == (false, false)
end

@testset "Lattice" begin
    test_lattice()
end
