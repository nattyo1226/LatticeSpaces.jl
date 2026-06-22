module Spaces

using Printf

using ..Tags: AbstractSystemTag

using ..Indices: AbstractIndex, site, local_label

using ..Geometries: AbstractGeometry
import ..Geometries: nsites, neighbors, neighbor_pairs

using ..LocalSpaces: AbstractLocalSpace, nlabels
import ..LocalSpaces: dim, local_labels, index_type, tag_type

include("type.jl")
export Space, nindices, neighbors_with_same_labels, neighbors_with_other_labels, neighbor_pairs_with_same_labels, neighbor_pairs_with_other_labels, indices, indices_with_fixed_site, indices_with_fixed_labels

end
