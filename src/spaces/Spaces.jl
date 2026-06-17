module Spaces

using ..Tags: AbstractSystemTag

using ..Indices: AbstractIndex, site

using ..Geometries: AbstractGeometry, nsites
import ..Geometries: neighbors, neighbor_pairs

using ..LocalSpaces: AbstractLocalSpace
import ..LocalSpaces: dim, local_labels, index_type, tag_type

include("type.jl")
export Space, indices

end
