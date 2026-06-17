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

function Base.isless(id1::I, id2::I) where {I<:AbstractIndex}
    return to_tuple(id1) < to_tuple(id2)
end

@enum Spin begin
    Up
    Down
end

function Base.show(io::IO, spin::Spin)
    if spin == Spin.Up
        print(io, "↑")
    else
        print(io, "↓")
    end
end
