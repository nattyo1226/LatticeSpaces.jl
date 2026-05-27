abstract type AbstractBoundary end

function is_periodic(b::AbstractBoundary)
    error("is_periodic is not implemented for $(typeof(b))")
end
