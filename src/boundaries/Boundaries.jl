module Boundaries

include("type.jl")
export AbstractBoundary, periodic

include("open.jl")
export OpenBoundary

include("periodic.jl")
export PeriodicBoundary

end
