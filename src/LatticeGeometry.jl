module LatticeGeometry

using Printf

include("geometry/Geometry.jl")
using .Geometry
import .Geometry: nsites, coord, id, neighbors, neighbor_pairs
export AbstractGeometry
export Hypercubic, AllToAll

include("boundary/Boundary.jl")
using .Boundary
import .Boundary: is_periodic
export AbstractBoundary
export OpenBoundary, PeriodicBoundary

include("types.jl")
export Lattice, nsites, coord, id, neighbors, neighbor_pairs, is_periodic

end
