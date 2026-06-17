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
    neighbor_ids = Int[]
    size_g = size(g)

    offsets = neighbor_offsets(g, shell)
    for offset in offsets
        neighbor_c = ntuple(D) do i
            val = c[i] + offset[i]
            periodic(g)[i] ? mod1(val, size_g[i]) : val
        end

        if all(1 .<= neighbor_c .<= size_g)
            push!(neighbor_ids, coord2id(g, neighbor_c))
        end
    end

    return sort(neighbor_ids)
end

function neighbor_pairs(g::AbstractGeometry{D}, shell::Int=1) where {D}
    pairs = Tuple{Int,Int}[]
    for id in 1:nsites(g)
        ns = neighbors(g, id, shell)
        for id_n in ns
            if id < id_n
                push!(pairs, (id, id_n))
            end
        end
    end
    return sort(pairs)
end
