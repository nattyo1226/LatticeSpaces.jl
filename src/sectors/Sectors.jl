module Sectors

using ..Tags: AbstractSystemTag, FermionTag

include("type.jl")
export AbstractSector

include("full.jl")
export FullSector

include("particle_number.jl")
export ParticleNumberSector

end
