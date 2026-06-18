function test_space_1()
    local_space = SpinHalfSpace()
    geometry = AllToAll(4)
    space = Space(local_space, geometry)
    T = SpinHalfTag
    id = SiteIndex{T}(2)

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
    @test dim(space) == 16
    @test local_labels(space) == ((),)
    @test index_type(space) == SiteIndex{T}

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
end

function test_space_2()
    local_space = SpinfulFermionSpace()
    geometry = Hypercubic(4, true)
    space = Space(local_space, geometry)
    T = tag_type(space)
    id = SiteSpinIndex(2, Up)

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
    @test dim(space) == 256
    @test local_labels(space) == ((Up,), (Down,))
    @test index_type(space) == SiteSpinIndex

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
end

@testset "Spaces" begin
    test_space_1()
    test_space_2()
end
