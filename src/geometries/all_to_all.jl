struct AllToAll <: AbstractGeometry{1}
    size::Int
end

function Base.show(io::IO, g::AllToAll)
    print(io, "AllToAll(size=$(g.size))")
end

function Base.show(io::IO, ::MIME"text/plain", g::AllToAll)
    @printf io "[AllToAll]:\n"
    @printf io "size: %d\n" g.size
end

function Base.size(g::AllToAll)
    return (g.size,)
end

function id2coord(::AllToAll, id::Int)
    return (id,)
end

function coord2id(::AllToAll, c::NTuple{1,Int})
    return c[1]
end

function neighbors(g::AllToAll, id::Int, shell::Int=1)
    if shell == 1
        return Iterators.filter(j -> j != id, 1:g.size)
    else
        throw(ArgumentError("Only nearest neighbors (shell=1) are supported for AllToAll geometry"))
    end
end
