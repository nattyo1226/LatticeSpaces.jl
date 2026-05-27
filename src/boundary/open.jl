struct OpenBoundary{D} <: AbstractBoundary where D end

function is_periodic(::OpenBoundary{D}) where D
    return ntuple(_ -> false, D)
end
