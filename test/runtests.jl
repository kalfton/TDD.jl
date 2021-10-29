using Test

@testset verbose = true "TDD" begin
    include("graph_test.jl");
    include("interval_test.jl")
end;
