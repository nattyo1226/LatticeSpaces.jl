module Geometries

using Printf

using ..Boundaries: AbstractBoundary
import ..Boundaries: periodic

include("type.jl")
export AbstractGeometry, nsites, neighbors, neighbor_pairs

include("hypercubic.jl")
export Hypercubic

include("all_to_all.jl")
export AllToAll

end
