module LocalSpaces

using ..Tags: AbstractSystemTag, SpinHalfTag, FermionTag
using ..Indices: Up, Down, SiteIndex, SiteSpinIndex

include("type.jl")
export AbstractLocalSpace, dim, local_labels, index_type, tag_type

include("spin_half.jl")
export SpinHalfSpace

include("spinful_fermion.jl")
export SpinfulFermionSpace

end
