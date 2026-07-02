abstract type AbstractGeometry{D} end

function Base.ndims(::AbstractGeometry{D}) where D
    return D
end

function Base.size(g::AbstractGeometry)
    error("size is not implemented for $(typeof(g))")
end

function nsites(g::AbstractGeometry)
    return prod(size(g))
end

function periodic(g::AbstractGeometry)
    error("periodic is not implemented for $(typeof(g))")
end

function id2coord(g::AbstractGeometry{D}, ::Int) where {D}
    error("id2coord is not implemented for $(typeof(g))")
end

function coord2id(g::AbstractGeometry{D}, ::NTuple{D,Int}) where {D}
    error("coord2id is not implemented for $(typeof(g))")
end

function neighbor_offsets(g::AbstractGeometry, ::Int)
    error("neighbor_offsets is not implemented for $(typeof(g))")
end

function neighbors(g::AbstractGeometry{D}, id::Int, shell::Int=1) where {D}
    c = id2coord(g, id)
    size_g = size(g)
    periodic_g = periodic(g)

    offsets = neighbor_offsets(g, shell)
    neighbor_coords = Iterators.map(offsets) do offset
        ntuple(D) do i
            val = c[i] + offset[i]
            periodic_g[i] ? mod1(val, size_g[i]) : val
        end
    end
    valid_neighbor_coords = Iterators.filter(neighbor_coords) do neighbor_c
        all(i -> 1 <= neighbor_c[i] <= size_g[i], 1:D)
    end

    return Iterators.map(neighbor_c -> coord2id(g, neighbor_c), valid_neighbor_coords)
end

function neighbor_pairs(g::AbstractGeometry{D}, shell::Int=1) where {D}
    return Iterators.flatten(
        Iterators.map(1:nsites(g)) do id
            Iterators.map(
                id_n -> (id, id_n),
                Iterators.filter(
                    id_n -> id < id_n,
                    neighbors(g, id, shell),
                )
            )
        end
    )
end
