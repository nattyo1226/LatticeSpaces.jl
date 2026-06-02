struct AllToAll <: AbstractGeometry{1}
    size::Int
end

function Base.show(io::IO, g::AllToAll)
    print(io, "AllToAll(size=$(g.size))")
end

function Base.size(g::AllToAll)
    return (g.size,)
end

function coord(::AllToAll, i::Int)
    return (i,)
end

function id(::AllToAll, c::NTuple{1,Int})
    return c[1]
end

function neighbors(g::AllToAll, periodic::NTuple{1,Bool}, site_id::Int, shell::Int=1)
    if periodic[1]
        throw(ArgumentError("Periodic boundary conditions are not supported for AllToAll geometry"))
    end

    if shell == 1
        return [j for j in 1:g.size if j != site_id]
    else
        throw(ArgumentError("Only nearest neighbors (shell=1) are supported for AllToAll geometry"))
    end
end
