struct OpenBoundary <: AbstractBoundary end

function is_periodic(::OpenBoundary, dim::Int64)
    return ntuple(_ -> false, dim)
end
