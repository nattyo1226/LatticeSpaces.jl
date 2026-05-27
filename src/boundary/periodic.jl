struct PeriodicBoundary{D} <: AbstractBoundary where D end

function is_periodic(::PeriodicBoundary{D}) where D
    return ntuple(_ -> true, D)
end
