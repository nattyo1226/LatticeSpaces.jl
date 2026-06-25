struct FullSector{T<:AbstractSystemTag} <: AbstractSector{T} end

function Base.show(io::IO, ::FullSector{T}) where {T<:AbstractSystemTag}
    print(io, "FullSector")
end
