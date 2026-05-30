module Geometry

using Base: ndims, size

include("types.jl")
export AbstractGeometry, ndims, size, nsites, coord, id, neighbor_offsets, neighbors, neighbor_pairs

include("hypercubic.jl")
export Hypercubic

end
