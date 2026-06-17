struct PeriodicBoundary{D} <: AbstractBoundary{D} end

function PeriodicBoundary(D::Int)
    return PeriodicBoundary{D}()
end

function periodic(::PeriodicBoundary{D}) where D
    return ntuple(_ -> true, Val(D))
end
