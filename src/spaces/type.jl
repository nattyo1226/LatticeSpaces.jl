struct Space{T<:AbstractSystemTag,L<:AbstractLocalSpace{T},G<:AbstractGeometry,S<:AbstractSector{T}}
    local_space::L
    geometry::G
    sector::S
end

function nsites(s::Space)
    return nsites(s.geometry)
end

function nindices(s::Space)
    return nsites(s.geometry) * nlabels(s.local_space)
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

function dim_full(s::Space)
    num_sites = nsites(s.geometry)
    dim_local = dim(s.local_space)
    return dim_local ^ num_sites
end

function dim(s::Space{T,L,G,FullSector{T}}) where {T<:AbstractSystemTag,L<:AbstractLocalSpace{T},G<:AbstractGeometry}
    return dim_full(s)
end

function dim(s::Space{FermionTag,L,G,ParticleNumberSector}) where {L<:AbstractLocalSpace{FermionTag},G<:AbstractGeometry}
    num_indices = nindices(s)
    num_particles = s.sector.num_particles

    return binomial(num_indices, num_particles)
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

function neighbors_with_same_labels(s::Space{T}, id::I, shell::Int=1) where {T<:AbstractSystemTag,I<:AbstractIndex{T}}
    if I != index_type(s.local_space)
        throw(ArgumentError("Index type mismatch"))
    end

    ns = neighbors(s.geometry, site(id), shell)
    labels = local_label(id)

    ns_with_labels = [
        I(site_n, labels...)
        for site_n in ns
    ]

    return ns_with_labels
end

function neighbors_with_other_labels(s::Space{T}, id::I, shell::Int=1) where {T<:AbstractSystemTag,I<:AbstractIndex{T}}
    if I != index_type(s.local_space)
        throw(ArgumentError("Index type mismatch"))
    end

    ns = neighbors(s.geometry, site(id), shell)
    ls = local_labels(s.local_space)

    ns_with_labels = [
        I(site_n, labels...)
        for site_n in ns
        for labels in ls
        if labels != local_label(id)
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

function neighbor_pairs_with_same_labels(s::Space{T}, shell::Int=1) where {T<:AbstractSystemTag}
    ps = neighbor_pairs(s.geometry, shell)
    ls = local_labels(s.local_space)
    I = index_type(s.local_space)

    ps_with_labels = [
        (I(site_p1, labels1...), I(site_p2, labels2...))
        for (site_p1, site_p2) in ps
        for labels1 in ls
        for labels2 in ls
        if labels1 == labels2
    ]

    return ps_with_labels
end

function neighbor_pairs_with_other_labels(s::Space{T}, shell::Int=1) where {T<:AbstractSystemTag}
    ps = neighbor_pairs(s.geometry, shell)
    ls = local_labels(s.local_space)
    I = index_type(s.local_space)

    ps_with_labels = [
        (I(site_p1, labels1...), I(site_p2, labels2...))
        for (site_p1, site_p2) in ps
        for labels1 in ls
        for labels2 in ls
        if labels1 != labels2
    ]

    return ps_with_labels
end

function indices(s::Space{T}) where {T<:AbstractSystemTag}
    num_sites = nsites(s.geometry)
    ls = local_labels(s.local_space)
    I = index_type(s.local_space)

    return [
        I(site, labels...)
        for site in 1:num_sites
        for labels in ls
    ]
end

function indices_with_fixed_site(s::Space{T}, site::Int) where {T<:AbstractSystemTag}
    ls = local_labels(s.local_space)
    I = index_type(s.local_space)

    return [
        I(site, labels...)
        for labels in ls
    ]
end

function indices_with_fixed_labels(s::Space{T}, labels::Tuple) where {T<:AbstractSystemTag}
    num_sites = nsites(s.geometry)
    I = index_type(s.local_space)

    return [
        I(site, labels...)
        for site in 1:num_sites
    ]
end

function basis(s::Space{T,L,G,FullSector{T}}) where {T<:AbstractSystemTag,L<:AbstractLocalSpace{T},G<:AbstractGeometry}
    return collect(0:(dim_full(s)-1))
end

function basis(s::Space{FermionTag,L,G,ParticleNumberSector}) where {L<:AbstractLocalSpace{FermionTag},G<:AbstractGeometry}
    return [b for b in 0:(dim_full(s)-1) if count_ones(b) == num_particles]
end

function Base.show(io::IO, s::Space{T}) where {T<:AbstractSystemTag}
    print(io, "Space{T=$(T)}(local_space=$(s.local_space), geometry=$(s.geometry), sector=$(s.sector))")
end

function Base.show(io::IO, ::MIME"text/plain", s::Space{T}) where {T<:AbstractSystemTag}
    @printf io "[Space]:\n"
    @printf io "system type: %s\n" string(T)
    @printf io "local space: %s\n" string(s.local_space)
    @printf io "geometry   : %s\n" string(s.geometry)
    @printf io "sector     : %s\n" string(s.sector)
end
