export Interval

struct Interval
    a::Real
    b::Real
    Interval(a, b) = a > b ? error("invalid input") : new(a, b)
    Interval(a::Real) = new(a, a)
    Interval(a::Char) = a == '\U2205' ? new(Inf, -Inf) : error("invalid input") # U+2205 is ∅
end

Base.minimum(A::Interval) = A.a
Base.maximum(A::Interval) = A.b

function Base.:(∈)(a::Real, A::Interval)
    if a >= A.a && a <= A.b
        return true
    else
        return false
    end
end
A = Interval(1, 2)
3 ∈ A
4 ∉ A

        function Base.isempty(A::Interval)
    if A.a >= A.b
        return true
    else
        return false
    end
end

function Base.issubset(A::Interval, B::Interval)
    if A.a >= B.a && A.b <= B.b
return true
    else
        return false
    end
end


function Base.intersect(A::Interval, B::Interval)
    if maximum(A) >= minimum(B) && maximum(B) >= minimum(A)
        return Interval(max(minimum(A), minimum(B)), min(maximum(A), maximum(B)))
    else
        return Interval('∅')
    end
end

function Base.show(io::IO, A::Interval)
    if isempty(A)
        print(io, '∅')
    else
        print(io, '\u301a')
        print(io, A.a)
        print(io, ", ")
        print(io, A.b)
        print(io, '\u301b')
    end
end

