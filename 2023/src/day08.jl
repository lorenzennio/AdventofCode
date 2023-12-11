 
module day08
    using ..aoc23

    """
        solution()

    Solves the two puzzles of day 08. 
    """
    
    const dti = Dict{Char, Int}('L' => 1, 'R' => 2)

    function solve(loc, direct, mapping)
        s = 0
        while loc[end] != 'Z'
            for d in direct
                loc = mapping[loc][dti[d]]
                s += 1
            end
        end
        return s
    end

    function solution(input::String = readInput(08))
        direct = split(input, "\n")[1]

        mapping = Dict{AbstractString, Tuple{AbstractString, AbstractString}}()
        for line in split(input, "\n")[3:end]
            mapping[line[1:3]] = (line[8:10], line[13:15])
        end

        s0 = solve("AAA", direct, mapping)

        locs = [l for (l, _) in mapping if l[end] == 'A']
        println(locs)
        steps = [solve(loc, direct, mapping) for loc in locs]
        s1 = lcm(steps)

        return s0, s1
    end
end 

