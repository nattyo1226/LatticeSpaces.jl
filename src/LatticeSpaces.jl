module LatticeSpaces

include("tags/Tags.jl")
using .Tags
export AbstractSystemTag, SpinHalfTag, FermionTag

include("indices/Indices.jl")
using .Indices
export AbstractIndex, has_site, site, has_spin, spin, to_tuple, Spin, Up, Down
export SiteIndex, SiteSpinIndex

include("local_spaces/LocalSpaces.jl")
using .LocalSpaces
export AbstractLocalSpace, dim, local_labels, index_type, tag_type
export SpinHalfSpace, SpinfulFermionSpace

include("boundaries/Boundaries.jl")
using .Boundaries
export AbstractBoundary, periodic
export OpenBoundary, PeriodicBoundary

include("geometries/Geometries.jl")
using .Geometries
export AbstractGeometry, nsites, coord, id, neighbors, neighbor_pairs
export Hypercubic, AllToAll

include("spaces/Spaces.jl")
using .Spaces
export Space, indices

end
