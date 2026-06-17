module Indices

using ..Tags: AbstractSystemTag, SpinHalfTag, FermionTag

using Printf

include("type.jl")
export AbstractIndex, site, has_spin, spin, to_tuple
export Spin, Up, Down

include("site.jl")
export SiteIndex

include("site_spin.jl")
export SiteSpinIndex

end
