struct PeriodicBoundary <: AbstractBoundary end

function is_periodic(::PeriodicBoundary, dim::Int64)
    return ntuple(_ -> true, dim)
end
