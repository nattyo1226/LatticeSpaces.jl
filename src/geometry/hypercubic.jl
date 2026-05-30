struct Hypercubic{D} <: AbstractGeometry{D}
    size::NTuple{D,Int64}
end

Hypercubic(sizes::Int...) = Hypercubic{length(sizes)}(sizes)

function Base.size(g::Hypercubic)
    return g.size
end

function coord(g::Hypercubic{D}, i::Int) where D
    return ntuple(d -> (i - 1) ÷ prod(g.size[(d+1):end]) % g.size[d] + 1, D)
end

function id(g::Hypercubic{D}, c::NTuple{D,Int}) where D
    return 1 + sum((c[d] - 1) * prod(g.size[(d+1):end]) for d in 1:D)
end

function neighbor_offsets(::Hypercubic{D}, order::Int=1) where D
    offsets = Vector{NTuple{D,Int}}()
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
