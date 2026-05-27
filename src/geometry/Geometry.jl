module Geometry

using Base: ndims, size

include("types.jl")
export AbstractGeometry, nsites, neighbor_offsets, neighbors, neighbor_pairs

include("hypercubic.jl")
export Hypercubic

end
