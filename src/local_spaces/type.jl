abstract type AbstractLocalSpace{T<:AbstractSystemTag} end

function dim(l::AbstractLocalSpace)
    throw(ArgumentError("dim is not defined for $(l)."))
end

function local_labels(l::AbstractLocalSpace)
    throw(ArgumentError("local_labels is not defined for $(l)."))
end

function index_type(l::AbstractLocalSpace)
    throw(ArgumentError("index_type is not defined for $(l)."))
end

function tag_type(::AbstractLocalSpace{T}) where T
    return T
end
