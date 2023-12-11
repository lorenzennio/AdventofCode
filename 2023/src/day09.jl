 
module day09
    using ..aoc23

    """
        solution()

    Solves the two puzzles of day 09. 
    """

    function history(h::Vector{Int})
        l = h[end]
        h = diff(h)
        iszero(h) && return l
        history(l.+h)
    end

    function history2(h::Vector{Int})
        l = h[1]
        h = diff(h)
        iszero(h) && return l
        history2(l.-h)
    end

    function solution(input::String = readInput(09))
        re = r"(-*\d+)"

        s0 = 0
        s1 = 0
        for line in split(input, "\n")
            hist = [parse(Int, line[i]) for i in findall(re, line)]
            s0+= history(hist)
            s1+= history2(hist)
        end

        return s0, s1
    end
end 

