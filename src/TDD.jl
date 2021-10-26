module TDD
export neighbors, connectednodes, connectedparts

function neighbors(graph::Vector, startnode::Integer)
    nodes = union(graph[startnode], startnode)
    return sort!(nodes)
end

function neighbors(graph::Matrix{Bool}, startnode::Integer)
    nodes = findall(graph[startnode,:])
    union!(nodes, startnode)
    return sort!(nodes)
end

function connectednodes(graph::Union{Vector, Matrix{Bool}}, startnode::Integer)
    # depth first search?
    nodestack = [startnode]
    nodes = Vector{Integer}()
    while !isempty(nodestack)
        currentnode = pop!(nodestack)
        push!(nodes, currentnode)
        neighbornodes = neighbors(graph, currentnode)
        union!(nodestack, setdiff(neighbornodes, nodes))
    end
    return sort!(nodes)
end

function connectedparts(graph::Union{Vector, Matrix{Bool}})
    parts=Vector{Vector{Integer}}()
    for currentnode in 1:size(graph,1)
        nodes = connectednodes(graph, currentnode)
        mergeind=[]
        for currentpart in 1: size(parts,1)
            if !isempty(intersect(parts[currentpart], nodes))
                sort!(union!(parts[currentpart], nodes))
                push!(mergeind, currentpart)
            end
                
        end
        if size(mergeind,1)==0
            # if cannot find overlapping in the existing node, create a new one
            push!(parts, nodes)
        elseif size(mergeind,1)>1
            # if there are multiple parts that the current node connected to, merge them all
            for ii in 2:size(mergeind,1)
                union!(parts[mergeind[1]], parts[mergeind[ii]])
            end
            sort!(parts[mergeind[1]])
            deleteat!(parts, mergeind[2:end])
        end
    end
    return parts
end


end
