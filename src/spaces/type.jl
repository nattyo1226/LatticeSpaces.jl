struct Space{T<:AbstractSystemTag,L<:AbstractLocalSpace{T},G<:AbstractGeometry}
    local_space::L
    geometry::G
end

function neighbors(s::Space{T}, id::I, shell::Int=1) where {T<:AbstractSystemTag,I<:AbstractIndex{T}}
    if I != index_type(s.local_space)
        throw(ArgumentError("Index type mismatch"))
    end

    ns = neighbors(s.geometry, site(id), shell)
    ls = local_labels(s.local_space)

    ns_with_labels = [
        I(site_n, labels...)
        for site_n in ns
        for labels in ls
    ]

    return ns_with_labels
end

function neighbor_pairs(s::Space{T}, shell::Int=1) where {T<:AbstractSystemTag}
    ps = neighbor_pairs(s.geometry, shell)
    ls = local_labels(s.local_space)
    I = index_type(s.local_space)

    ps_with_labels = [
        (I(site_p1, labels1...), I(site_p2, labels2...))
        for (site_p1, site_p2) in ps
        for labels1 in ls
        for labels2 in ls
    ]

    return ps_with_labels
end

function dim(s::Space)
    num_sites = nsites(s.geometry)
    dim_local = dim(s.local_space)
    return dim_local ^ num_sites
end

function local_labels(s::Space)
    return local_labels(s.local_space)
end

function index_type(s::Space)
    return index_type(s.local_space)
end

function tag_type(::Space{T}) where T
    return T
end

function indices(s::Space{T}) where {T<:AbstractSystemTag}
    ls = local_labels(s.local_space)
    I = index_type(s.local_space)

    return [
        I(site, labels...)
        for site in 1:nsites(s.geometry)
        for labels in ls
    ]
end
