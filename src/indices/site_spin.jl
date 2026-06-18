struct SiteSpinIndex <: AbstractIndex{FermionTag}
    site::Int
    spin::Spin
end

function Base.show(io::IO, id::SiteSpinIndex)
    @printf io "(%d%s)" id.site string(id.spin)
end

function Base.:(==)(id1::SiteSpinIndex, id2::SiteSpinIndex)
    return id1.site == id2.site && id1.spin == id2.spin
end

function Base.hash(id::SiteSpinIndex, h::UInt)
    return hash((id.site, id.spin), h)
end

function site(id::SiteSpinIndex)
    return id.site
end

function has_spin(::SiteSpinIndex)
    return true
end

function spin(id::SiteSpinIndex)
    return id.spin
end

function local_label(id::SiteSpinIndex)
    return (id.spin,)
end

function to_tuple(id::SiteSpinIndex)
    return (id.site, id.spin)
end
