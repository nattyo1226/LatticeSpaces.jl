struct Hypercubic{D} <: AbstractGeometry
    size::NTuple{D,Int64}
end

Hypercubic(sizes::Int64...) = Hypercubic{length(sizes)}(sizes)

function Base.ndims(::Hypercubic{D}) where D
    return D
end

function Base.size(g::Hypercubic)
    return g.size
end

function nsites(g::Hypercubic)
    return prod(g.size)
end

function coord(g::Hypercubic{D}, i::Int64) where D
    return ntuple(d -> (i - 1) ÷ prod(g.size[d+1:end]) % g.size[d] + 1, D)
end

function id(g::Hypercubic{D}, c::NTuple{D,Int64}) where D
    return 1 + sum((c[d] - 1) * prod(g.size[d+1:end]) for d in 1:D)
end

function neighbor_offsets(::Hypercubic{D}, order::Int64=1) where D
    offsets = Vector{NTuple{D,Int64}}()
    if order == 1
        for d in 1:D
            push!(offsets, ntuple(i -> i == d ? 1 : 0, D))
            push!(offsets, ntuple(i -> i == d ? -1 : 0, D))
        end
    else
        throw(ArgumentError("Only nearest neighbors (order=1) are supported for Hypercubic geometry"))
    end
    return offsets
end
