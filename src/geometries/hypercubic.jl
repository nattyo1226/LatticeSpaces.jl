struct Hypercubic{D} <: AbstractGeometry{D}
    size::NTuple{D,Int}
    periodic::NTuple{D,Bool}
end

function Hypercubic(size::Int, periodic::Bool)
    return Hypercubic((size,), (periodic,))
end

function Hypercubic(size::NTuple{D,Int}, ::Type{B}) where {D,B<:AbstractBoundary{D}}
    boundary = B(D)
    p = periodic(boundary)
    return Hypercubic{D}(size, p)
end

function Hypercubic(size::Int, ::Type{B}) where {B<:AbstractBoundary}
    D = 1
    boundary = B(D)
    p = periodic(boundary)
    return Hypercubic{D}((size,), p)
end

function Base.show(io::IO, g::Hypercubic{D}) where {D}
    print(io, "Hypercubic{D=$(D)}(size=$(g.size), periodic=$(g.periodic))")
end

function Base.show(io::IO, ::MIME"text/plain", g::Hypercubic{D}) where {D}
    @printf io "[Hypercubic Geometry]:\n"
    @printf io "dimensions: %d\n" D
    @printf io "size      : %s\n" string(g.size)
    @printf io "periodic  : %s\n" string(g.periodic)
end

function Base.size(g::Hypercubic)
    return g.size
end

function periodic(g::Hypercubic)
    return g.periodic
end

function id2coord(g::Hypercubic{D}, id::Int) where D
    return ntuple(d -> (id - 1) ÷ prod(g.size[(d+1):end]) % g.size[d] + 1, Val(D))
end

function coord2id(g::Hypercubic{D}, c::NTuple{D,Int}) where D
    return 1 + sum((c[d] - 1) * prod(g.size[(d+1):end]) for d in 1:D)
end

function neighbor_offsets(::Hypercubic{D}, shell::Int=1) where D
    offsets = Vector{NTuple{D,Int}}()
    if shell == 1
        for d in 1:D
            push!(offsets, ntuple(i -> i == d ? 1 : 0, Val(D)))
            push!(offsets, ntuple(i -> i == d ? -1 : 0, Val(D)))
        end
    else
        throw(ArgumentError("Only nearest neighbors (shell=1) are supported for Hypercubic geometry"))
    end
    return offsets
end
