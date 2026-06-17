struct OpenBoundary{D} <: AbstractBoundary{D} end

function OpenBoundary(D::Int)
    return OpenBoundary{D}()
end

function periodic(::OpenBoundary{D}) where D
    return ntuple(_ -> false, Val(D))
end
