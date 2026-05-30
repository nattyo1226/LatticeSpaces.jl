module LatticeGeometry

using Base: ndims, size
using Printf

include("geometry/Geometry.jl")
using .Geometry
import .Geometry: ndims, size, nsites, coord, id, neighbor_offsets, neighbors, neighbor_pairs
export AbstractGeometry
export Hypercubic

include("boundary/Boundary.jl")
using .Boundary
import .Boundary: is_periodic
export AbstractBoundary
export OpenBoundary, PeriodicBoundary

include("types.jl")
export Lattice, ndims, size, nsites, coord, id, neighbors, neighbor_pairs, is_periodic

end
