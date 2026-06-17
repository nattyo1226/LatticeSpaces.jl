struct SpinfulFermionSpace <: AbstractLocalSpace{FermionTag} end

function dim(::SpinfulFermionSpace)
    return 4
end

function local_labels(::SpinfulFermionSpace)
    return ((Up,), (Down,))
end

function index_type(::SpinfulFermionSpace)
    return SiteSpinIndex
end
