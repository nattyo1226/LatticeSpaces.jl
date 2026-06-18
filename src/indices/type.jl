abstract type AbstractIndex{T<:AbstractSystemTag} end

function to_tuple(id::AbstractIndex)
    return throw(ArgumentError("to_tuple function not defined for $(id)."))
end

function site(id::AbstractIndex)
    throw(ArgumentError("site function not defined for $(id)."))
end

function has_spin(::AbstractIndex)
    return false
end

function spin(id::AbstractIndex)
    throw(ArgumentError("spin function not defined for $(id)."))
end

function local_label(::AbstractIndex)
    return ()
end

function Base.isless(id1::I, id2::I) where {I<:AbstractIndex}
    return to_tuple(id1) < to_tuple(id2)
end

@enum Spin begin
    Up
    Down
end

function string(spin::Spin)
    return spin == Up ? "↑" : "↓"
end

function Base.show(io::IO, spin::Spin)
    print(io, spin == Up ? "↑" : "↓")
end
