struct ParticleNumberSector <: AbstractSector{FermionTag}
    num_particles::Int
end

function Base.show(io::IO, s::ParticleNumberSector)
    print(io, "ParticleNumberSector(num_particles=$(s.num_particles))")
end
