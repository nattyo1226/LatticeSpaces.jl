struct Lattice{D,G<:AbstractGeometry}
    geometry::G
    periodic::NTuple{D,Bool}
end

function Lattice(geometry::G, boundary::B) where {D,G<:AbstractGeometry{D},B<:AbstractBoundary}
    periodic = is_periodic(boundary, D)
    return Lattice{D,G}(geometry, periodic)
end

Base.show(io::IO, lattice::Lattice{D,G}) where {D,G<:AbstractGeometry} = print(io, "Lattice{$(D)}(geometry=$(G), periodic=$(lattice.periodic))")
function Base.show(io::IO, ::MIME"text/plain", lattice::Lattice{D,G}) where {D,G<:AbstractGeometry}
    @printf io "Lattice:\n"
    @printf io "\tgeometry:   %s\n" string(G)
    @printf io "\tdimensions: %d\n" D
    @printf io "\tsize:       %s\n" string(size(lattice))
    @printf io "\tperiodic:   %s\n" string(lattice.periodic)
end

function Base.ndims(lattice::Lattice)
    return ndims(lattice.geometry)
end

function Base.size(lattice::Lattice)
    return size(lattice.geometry)
end

function nsites(lattice::Lattice)
    return nsites(lattice.geometry)
end

function coord(lattice::Lattice, site_id::Int64)
    return coord(lattice.geometry, site_id)
end

function id(lattice::Lattice{D}, site_c::NTuple{D,Int64}) where {D}
    return id(lattice.geometry, site_c)
end

function neighbors(lattice::Lattice, site_id::Int64, order::Int64=1)
    return neighbors(lattice.geometry, lattice.periodic, site_id, order)
end

function neighbor_pairs(lattice::Lattice)
    return neighbor_pairs(lattice.geometry, lattice.periodic)
end

function is_periodic(lattice::Lattice)
    return lattice.periodic
end
