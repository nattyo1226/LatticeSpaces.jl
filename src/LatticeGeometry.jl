module LatticeGeometry

include("geometry/Geometry.jl")
using .Geometry
export AbstractGeometry, nsites, neighbor_offsets, neighbors, neighbor_pairs
export Hypercubic

include("boundary/Boundary.jl")
using .Boundary
export AbstractBoundary, is_periodic
export OpenBoundary, PeriodicBoundary

end
