struct SpinHalfSpace <: AbstractLocalSpace{SpinHalfTag} end

function dim(::SpinHalfSpace)
    return 2
end

function local_labels(::SpinHalfSpace)
    return ((),)
end

function index_type(::SpinHalfSpace)
    return SiteIndex{SpinHalfTag}
end
