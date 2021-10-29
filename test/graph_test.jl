using Test
using TDD
@testset "graph_test" begin
    graph1 = [
          [2, 3],     # list of nodes that can be reached from node 1
          [1],        # list of nodes that can be reached from node 2
          [1],        # ", node 3
          [5],        # ", node 4
          [4]]        # ", node 5

    graph2 = [
          [],     # node 1
          [1,3],      # node 2
          [],        # ", node 3
          [],        # ", node 4
          [4],        # ", node 5
          [3,4]]        # ", node 6

    graph3 = Bool[
        1 1 1 0 0;
        1 1 0 0 0;
        1 0 1 0 0;
        0 0 0 0 1;
        0 0 0 1 1;
      ]
    nodes = neighbors(graph1, 1)
    @test nodes == [1,2,3]
    nodes = neighbors(graph2, 4)
    @test nodes == [4]
    nodes = neighbors(graph3, 4)
    @test nodes == [4,5]

    nodes = connectednodes(graph1, 1)
    @test nodes == [1,2,3]
    nodes = connectednodes(graph2, 5)
    @test nodes == [4,5]
    nodes = connectednodes(graph3, 4)
    @test nodes == [4,5]

    parts=connectedparts(graph1)
    @test parts==[[1,2,3], [4,5]]
    parts=connectedparts(graph2)
    @test parts==[[1,2,3,4,5,6]]
    nodes = connectedparts(graph3)
    @test nodes == [[1,2,3], [4,5]]

end;