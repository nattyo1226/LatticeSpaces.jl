using LatticeSpace
using Test

@testset "LatticeSpace.jl" begin
    include("geometry/hypercubic.jl")
    include("geometry/all_to_all.jl")
    include("boundary/open.jl")
    include("boundary/periodic.jl")
    include("lattice.jl")
end
