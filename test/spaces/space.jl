function test_space_1()
    local_space = SpinHalfSpace()
    geometry = AllToAll(4)
    sector = FullSector{SpinHalfTag}()
    space = Space(local_space, geometry, sector)
    T = SpinHalfTag
    id = SiteIndex{T}(2)

    @test local_labels(space) == ((),)
    @test index_type(space) == SiteIndex{T}
    @test dim_full(space) == 16
    @test dim(space) == 16

    @test neighbors(space, id) == [
        SiteIndex{T}(1),
        SiteIndex{T}(3),
        SiteIndex{T}(4),
    ]
    @test neighbor_pairs(space) == [
        (SiteIndex{T}(1), SiteIndex{T}(2)),
        (SiteIndex{T}(1), SiteIndex{T}(3)),
        (SiteIndex{T}(1), SiteIndex{T}(4)),
        (SiteIndex{T}(2), SiteIndex{T}(3)),
        (SiteIndex{T}(2), SiteIndex{T}(4)),
        (SiteIndex{T}(3), SiteIndex{T}(4)),
    ]

    @test indices(space) == [
        SiteIndex{T}(1),
        SiteIndex{T}(2),
        SiteIndex{T}(3),
        SiteIndex{T}(4),
    ]
    @test indices_with_fixed_site(space, 2) == [
        SiteIndex{T}(2),
    ]
    @test indices_with_fixed_labels(space, ()) == [
        SiteIndex{T}(1),
        SiteIndex{T}(2),
        SiteIndex{T}(3),
        SiteIndex{T}(4),
    ]

    @test basis(space) == collect(0:15)
end

function test_space_2()
    local_space = SpinfulFermionSpace()
    geometry = Hypercubic(4, PeriodicBoundary)
    sector = ParticleNumberSector(4)
    space = Space(local_space, geometry, sector)
    id = SiteSpinIndex(2, Up)

    @test local_labels(space) == ((Up,), (Down,))
    @test index_type(space) == SiteSpinIndex
    @test dim_full(space) == 256
    @test dim(space) == 70

    @test neighbors(space, id) == [
        SiteSpinIndex(1, Up),
        SiteSpinIndex(1, Down),
        SiteSpinIndex(3, Up),
        SiteSpinIndex(3, Down),
    ]
    @test neighbors_with_same_labels(space, id) == [
        SiteSpinIndex(1, Up),
        SiteSpinIndex(3, Up),
    ]
    @test neighbors_with_other_labels(space, id) == [
        SiteSpinIndex(1, Down),
        SiteSpinIndex(3, Down),
    ]
    @test neighbor_pairs(space) == [
        (SiteSpinIndex(1, Up), SiteSpinIndex(2, Up)),
        (SiteSpinIndex(1, Up), SiteSpinIndex(2, Down)),
        (SiteSpinIndex(1, Down), SiteSpinIndex(2, Up)),
        (SiteSpinIndex(1, Down), SiteSpinIndex(2, Down)),
        (SiteSpinIndex(1, Up), SiteSpinIndex(4, Up)),
        (SiteSpinIndex(1, Up), SiteSpinIndex(4, Down)),
        (SiteSpinIndex(1, Down), SiteSpinIndex(4, Up)),
        (SiteSpinIndex(1, Down), SiteSpinIndex(4, Down)),
        (SiteSpinIndex(2, Up), SiteSpinIndex(3, Up)),
        (SiteSpinIndex(2, Up), SiteSpinIndex(3, Down)),
        (SiteSpinIndex(2, Down), SiteSpinIndex(3, Up)),
        (SiteSpinIndex(2, Down), SiteSpinIndex(3, Down)),
        (SiteSpinIndex(3, Up), SiteSpinIndex(4, Up)),
        (SiteSpinIndex(3, Up), SiteSpinIndex(4, Down)),
        (SiteSpinIndex(3, Down), SiteSpinIndex(4, Up)),
        (SiteSpinIndex(3, Down), SiteSpinIndex(4, Down)),
    ]
    @test neighbor_pairs_with_same_labels(space) == [
        (SiteSpinIndex(1, Up), SiteSpinIndex(2, Up)),
        (SiteSpinIndex(1, Down), SiteSpinIndex(2, Down)),
        (SiteSpinIndex(1, Up), SiteSpinIndex(4, Up)),
        (SiteSpinIndex(1, Down), SiteSpinIndex(4, Down)),
        (SiteSpinIndex(2, Up), SiteSpinIndex(3, Up)),
        (SiteSpinIndex(2, Down), SiteSpinIndex(3, Down)),
        (SiteSpinIndex(3, Up), SiteSpinIndex(4, Up)),
        (SiteSpinIndex(3, Down), SiteSpinIndex(4, Down)),
    ]
    @test neighbor_pairs_with_other_labels(space) == [
        (SiteSpinIndex(1, Up), SiteSpinIndex(2, Down)),
        (SiteSpinIndex(1, Down), SiteSpinIndex(2, Up)),
        (SiteSpinIndex(1, Up), SiteSpinIndex(4, Down)),
        (SiteSpinIndex(1, Down), SiteSpinIndex(4, Up)),
        (SiteSpinIndex(2, Up), SiteSpinIndex(3, Down)),
        (SiteSpinIndex(2, Down), SiteSpinIndex(3, Up)),
        (SiteSpinIndex(3, Up), SiteSpinIndex(4, Down)),
        (SiteSpinIndex(3, Down), SiteSpinIndex(4, Up)),
    ]

    @test indices(space) == [
        SiteSpinIndex(1, Up),
        SiteSpinIndex(1, Down),
        SiteSpinIndex(2, Up),
        SiteSpinIndex(2, Down),
        SiteSpinIndex(3, Up),
        SiteSpinIndex(3, Down),
        SiteSpinIndex(4, Up),
        SiteSpinIndex(4, Down),
    ]
    @test indices_with_fixed_site(space, 2) == [
        SiteSpinIndex(2, Up),
        SiteSpinIndex(2, Down),
    ]
    @test indices_with_fixed_labels(space, (Up,)) == [
        SiteSpinIndex(1, Up),
        SiteSpinIndex(2, Up),
        SiteSpinIndex(3, Up),
        SiteSpinIndex(4, Up),
    ]

    @test basis(space) == [
        0b00001111,
        0b00010111, 0b00011011, 0b00011101, 0b00011110,
        0b00100111, 0b00101011, 0b00101101, 0b00101110, 0b00110011, 0b00110101, 0b00110110, 0b00111001, 0b00111010, 0b00111100,
        0b01000111, 0b01001011, 0b01001101, 0b01001110, 0b01010011, 0b01010101, 0b01010110, 0b01011001, 0b01011010, 0b01011100, 0b01100011, 0b01100101, 0b01100110, 0b01101001, 0b01101010, 0b01101100, 0b01110001, 0b01110010, 0b01110100, 0b01111000,
        0b10000111, 0b10001011, 0b10001101, 0b10001110, 0b10010011, 0b10010101, 0b10010110, 0b10011001, 0b10011010, 0b10011100, 0b10100011, 0b10100101, 0b10100110, 0b10101001, 0b10101010, 0b10101100, 0b10110001, 0b10110010, 0b10110100, 0b10111000, 0b11000011, 0b11000101, 0b11000110, 0b11001001, 0b11001010, 0b11001100, 0b11010001, 0b11010010, 0b11010100, 0b11011000, 0b11100001, 0b11100010, 0b11100100, 0b11101000, 0b11110000,
    ]
end

@testset "Spaces" begin
    test_space_1()
    test_space_2()
end
