struct SiteIndex{T<:AbstractSystemTag} <: AbstractIndex{T}
    site::Int
end

function SiteIndex{T}(; site::Int) where {T<:AbstractSystemTag}
    return SiteIndex{T}(site)
end

function SiteIndex(::Type{T}, site::Int) where {T<:AbstractSystemTag}
    return SiteIndex{T}(site)
end

function SiteIndex(::Type{T}, id::Tuple{Int}) where {T<:AbstractSystemTag}
    return SiteIndex{T}(id[1])
end

function Base.show(io::IO, id::SiteIndex)
    @printf io "%d" id.site
end

Base.:(==)(id1::SiteIndex, id2::SiteIndex) = id1.site == id2.site

Base.hash(id::SiteIndex, h::UInt) = hash(id.site, h)

function has_site(::SiteIndex)
    return true
end

function site(id::SiteIndex)
    return id.site
end

function to_tuple(id::SiteIndex)
    return (id.site,)
end
