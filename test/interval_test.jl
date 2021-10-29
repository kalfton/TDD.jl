using Test
using TDD

@testset "interval_test.jl" begin
    inv1 = Interval(2,5)
    @test minimum(inv1)==2
    @test maximum(inv1)==5

    @test 3.5 in Interval(2,5)
    @test !(5.5 in Interval(2,5))

    @test isempty(Interval('∅'))
    @test !isempty(Interval(2,3))
    @test isempty(Interval(2,2))

    @test issubset(Interval(2,3), Interval(2,3))
    @test issubset(Interval(2,3), Interval(-1.5,5))
    @test !issubset(Interval(-7,3), Interval(-1.5,5))
    @test issubset(Interval('∅'), Interval(-1.5,5))
    @test issubset(Interval('∅'), Interval('∅'))
    @test !issubset(Interval(2,3), Interval('∅'))

    @test Interval(2,3) == Interval(2,3) ∩ Interval(2,3)
    @test Interval(3,6) == Interval(-4,6) ∩ Interval(3,9)
    @test Interval(3,6) == Interval(3,9) ∩ Interval(-4,6)
    @test Interval(3,3) == Interval(2,3) ∩ Interval(3,6)
    @test Interval('∅') == Interval(3,5) ∩ Interval(-4,2)

    show(stdout, Interval(3,5))
    
    mktemp() do fname, io
        show(io, Interval(3,5))
        seek(io, 0)
        @test read(io, String)=="\u301a3, 5\u301b"
        truncate(io, 0)
        seek(io, 0)
        show(io, Interval('∅'))
        seek(io, 0)
        @test read(io, String)=="∅"
    end



end