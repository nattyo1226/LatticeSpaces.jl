abstract type AbstractBoundary{D} end

function periodic(b::AbstractBoundary)
    throw(ArgumentError("periodic boundary condition is not implemented for $(typeof(b))"))
end
