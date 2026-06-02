using LatticeGeometry
using Test

@testset "LatticeGeometry.jl" begin
    include("geometry/hypercubic.jl")
    include("geometry/all_to_all.jl")
    include("boundary/open.jl")
    include("boundary/periodic.jl")
    include("lattice.jl")
end
