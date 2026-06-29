module Tags

abstract type AbstractSystemTag end
export AbstractSystemTag

struct SpinHalfTag <: AbstractSystemTag end
export SpinHalfTag

function Base.show(io::IO, ::SpinHalfTag)
    print(io, "SpinHalfTag")
end

struct FermionTag <: AbstractSystemTag end
export FermionTag

function Base.show(io::IO, ::FermionTag)
    print(io, "FermionTag")
end

end
