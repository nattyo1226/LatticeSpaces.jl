struct Space{T<:AbstractSystemTag,L<:AbstractLocalSpace{T},G<:AbstractGeometry,S<:AbstractSector{T}}
    local_space::L
    geometry::G
    sector::S

    function Space(local_space::L, geometry::G, sector::S=FullSector{T}()) where {T<:AbstractSystemTag,L<:AbstractLocalSpace{T},G<:AbstractGeometry,S<:AbstractSector{T}}
        new{T,L,G,S}(local_space, geometry, sector)
    end
end

function nsites(space::Space)
    return nsites(space.geometry)
end

function nindices(space::Space)
    return nsites(space.geometry) * nlabels(space.local_space)
end

function local_labels(space::Space)
    return local_labels(space.local_space)
end

function index_type(space::Space)
    return index_type(space.local_space)
end

function tag_type(::Space{T}) where T
    return T
end

function dim_full(space::Space)
    num_sites = nsites(space.geometry)
    dim_local = dim(space.local_space)
    return dim_local ^ num_sites
end

function dim(space::Space{T,L,G,FullSector{T}}) where {T<:AbstractSystemTag,L<:AbstractLocalSpace{T},G<:AbstractGeometry}
    return dim_full(space)
end

function dim(space::Space{FermionTag,L,G,ParticleNumberSector}) where {L<:AbstractLocalSpace{FermionTag},G<:AbstractGeometry}
    num_indices = nindices(space)
    num_particles = space.sector.num_particles

    return binomial(num_indices, num_particles)
end

function neighbors(space::Space{T}, id::I, shell::Int=1) where {T<:AbstractSystemTag,I<:AbstractIndex{T}}
    if I != index_type(space.local_space)
        throw(ArgumentError("Index type mismatch"))
    end

    sites = neighbors(space.geometry, site(id), shell)
    labels = local_labels(space.local_space)

    return Iterators.flatten(
        Iterators.map(sites) do site_n
            Iterators.map(labels) do label_n
                I(site_n, label_n...)
            end
        end
    )
end

function neighbors_with_same_labels(space::Space{T}, id::I, shell::Int=1) where {T<:AbstractSystemTag,I<:AbstractIndex{T}}
    ids = neighbors(space, id, shell)
    label_id = local_label(id)

    return Iterators.filter(
        id_n -> local_label(id_n) == label_id,
        ids,
    )
end

function neighbors_with_other_labels(space::Space{T}, id::I, shell::Int=1) where {T<:AbstractSystemTag,I<:AbstractIndex{T}}
    ids = neighbors(space, id, shell)
    labels = local_labels(space.local_space)
    label_id = local_label(id)
    labels_n = Iterators.filter(l_n -> l_n != label_id, labels)

    return Iterators.filter(
        id_n -> local_label(id_n) in labels_n,
        ids,
    )
end

function neighbor_pairs(space::Space{T}, shell::Int=1) where {T<:AbstractSystemTag}
    pairs_site = neighbor_pairs(space.geometry, shell)
    labels = local_labels(space.local_space)
    I = index_type(space.local_space)

    return Iterators.flatten(
        Iterators.map(pairs_site) do (site_p1, site_p2)
            Iterators.flatten(
                Iterators.map(labels) do labels1
                    Iterators.map(labels) do labels2
                        (I(site_p1, labels1...), I(site_p2, labels2...))
                    end
                end
            )
        end
    )
end

function neighbor_pairs_with_same_labels(space::Space{T}, shell::Int=1) where {T<:AbstractSystemTag}
    pairs_id = neighbor_pairs(space, shell)

    return Iterators.filter(
        pair -> local_label(pair[1]) == local_label(pair[2]),
        pairs_id,
    )
end

function neighbor_pairs_with_other_labels(space::Space{T}, shell::Int=1) where {T<:AbstractSystemTag}
    pairs_id = neighbor_pairs(space, shell)

    return Iterators.filter(
        pair -> local_label(pair[1]) != local_label(pair[2]),
        pairs_id,
    )
end

function indices(space::Space{T}) where {T<:AbstractSystemTag}
    num_sites = nsites(space.geometry)
    labels = local_labels(space.local_space)
    I = index_type(space.local_space)

    return Iterators.flatten(
        Iterators.map(1:num_sites) do site
            Iterators.map(labels) do label
                I(site, label...)
            end
        end
    )
end

function indices_with_fixed_site(space::Space{T}, site_f::Int) where {T<:AbstractSystemTag}
    ids = indices(space)

    return Iterators.filter(
        id -> site(id) == site_f,
        ids,
    )
end

function indices_with_fixed_labels(space::Space{T}, label_f::Tuple) where {T<:AbstractSystemTag}
    ids = indices(space)

    return Iterators.filter(
        id -> local_label(id) == label_f,
        ids,
    )
end

function basis(space::Space{T,L,G,FullSector{T}}) where {T<:AbstractSystemTag,L<:AbstractLocalSpace{T},G<:AbstractGeometry}
    return 0:(dim_full(space)-1)
end

function basis(space::Space{FermionTag,L,G,ParticleNumberSector}) where {L<:AbstractLocalSpace{FermionTag},G<:AbstractGeometry}
    num_particles = space.sector.num_particles
    return Iterators.filter(
        b -> count_ones(b) == num_particles,
        0:(dim_full(space)-1),
    )
end

function Base.show(io::IO, space::Space{T}) where {T<:AbstractSystemTag}
    print(io, "Space{T=$(T)}(local_space=$(space.local_space), geometry=$(space.geometry), sector=$(space.sector))")
end

function Base.show(io::IO, ::MIME"text/plain", space::Space{T}) where {T<:AbstractSystemTag}
    @printf io "[Space]:\n"
    @printf io "system type: %s\n" string(T)
    @printf io "local space: %s\n" string(space.local_space)
    @printf io "geometry   : %s\n" string(space.geometry)
    @printf io "sector     : %s\n" string(space.sector)
end
