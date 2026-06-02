using LatticeGeometry
using Test

@testset "LatticeGeometry.jl" begin
    include("geometry/hypercubic.jl")
    include("boundary/open.jl")
    include("boundary/periodic.jl")
    include("lattice.jl")
end
