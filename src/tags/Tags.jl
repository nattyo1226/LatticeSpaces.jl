module Tags

abstract type AbstractSystemTag end
struct SpinHalfTag <: AbstractSystemTag end
struct FermionTag <: AbstractSystemTag end

export AbstractSystemTag, SpinHalfTag, FermionTag

end
