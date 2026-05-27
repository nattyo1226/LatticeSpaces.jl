using LatticeGeometry
using Test

include("geometry/hypercubic.jl")

include("boundary/open.jl")
include("boundary/periodic.jl")

@testset "LatticeGeometry.jl" begin
    test_hypercubic()
    test_open_boundary()
    test_periodic_boundary()
end
