module Tags

abstract type AbstractSystemTag end
function coeff_type(::Type{<:AbstractSystemTag})
    return Float64
end

export AbstractSystemTag, coeff_type

struct SpinHalfTag <: AbstractSystemTag end
export SpinHalfTag

struct FermionTag <: AbstractSystemTag end
function coeff_type(::Type{<:FermionTag})
    return ComplexF64
end
export FermionTag

end
