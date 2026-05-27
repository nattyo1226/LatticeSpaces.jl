abstract type AbstractGeometry end

function Base.ndims(g::AbstractGeometry)
    error("ndims is not implemented for $(typeof(g))")
end

function Base.size(g::AbstractGeometry)
    error("size is not implemented for $(typeof(g))")
end

function nsites(g::AbstractGeometry)
    error("nsites is not implemented for $(typeof(g))")
end

function coord(g::AbstractGeometry, ::Int64)
    error("coord is not implemented for $(typeof(g))")
end

function id(g::AbstractGeometry, ::NTuple{D,Int64}) where D
    error("site is not implemented for $(typeof(g))")
end

function neighbor_offsets(g::AbstractGeometry, ::Int64)
    error("neighbor_offsets is not implemented for $(typeof(g))")
end

function neighbors(g::AbstractGeometry, periodic::NTuple{D,Bool}, site_id::Int64, order::Int64=1) where D
    c = coord(g, site_id)
    neighbor_ids = Int64[]
    size_g = size(g)

    offsets = neighbor_offsets(g, order)
    for offset in offsets
        neighbor_c = ntuple(D) do i
            val = c[i] + offset[i]
            periodic[i] ? mod1(val, size_g[i]) : val
        end

        if all(1 .<= neighbor_c .<= size_g)
            push!(neighbor_ids, id(g, neighbor_c))
        end
    end

    return sort(neighbor_ids)
end

function neighbor_pairs(g::AbstractGeometry, periodic::NTuple{D,Bool}) where D
    pairs = Tuple{Int64,Int64}[]
    for site_id in 1:nsites(g)
        neighbor_ids = neighbors(g, periodic, site_id)
        for neighbor_id in neighbor_ids
            if site_id < neighbor_id
                push!(pairs, (site_id, neighbor_id))
            end
        end
    end
    return sort(pairs)
end
