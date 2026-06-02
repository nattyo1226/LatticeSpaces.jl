module Geometry

using Printf

include("types.jl")
export AbstractGeometry, nsites, coord, id, neighbor_offsets, neighbors, neighbor_pairs

include("hypercubic.jl")
export Hypercubic

end
