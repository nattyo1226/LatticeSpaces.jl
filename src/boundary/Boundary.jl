module Boundary

include("types.jl")
export AbstractBoundary, is_periodic

include("open.jl")
export OpenBoundary

include("periodic.jl")
export PeriodicBoundary

end
