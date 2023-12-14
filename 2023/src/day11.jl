 
module day11
    using ..aoc23

    """
        solution()

    Solves the two puzzles of day 11. 
    """

    function solution(input::String = readInput(11))
        mapping = Vector{Char}[[l for l in line] for line in split(input, "\n")]
        mapping = permutedims(hcat(mapping...))

        gal = findall(x -> x == '#', mapping)
        sort!(gal, by = x->x[1])
    
        s0 = 0
        for i in eachindex(gal) 
            for j in i+1:length(gal)
                s0 += abs(gal[i][1] - gal[j][1]) + abs(gal[i][2] - gal[j][2])
                for r in min(gal[i][1], gal[j][1]):max(gal[i][1], gal[j][1])
                    ('#' ∉ mapping[r,:]) && (s0 += 1)
                end
                for c in min(gal[i][2], gal[j][2]):max(gal[i][2], gal[j][2])
                    ('#' ∉ mapping[:,c]) && (s0 += 1)
                end
            end
        end

        s1 = 0
        for i in eachindex(gal) 
            for j in i:length(gal)
                s1 += abs(gal[i][1] - gal[j][1]) + abs(gal[i][2] - gal[j][2])
                for r in min(gal[i][1], gal[j][1]):max(gal[i][1], gal[j][1])
                    ('#' ∉ mapping[r,:]) && (s1 += 1e6-1)
                end
                for c in min(gal[i][2], gal[j][2]):max(gal[i][2], gal[j][2])
                    ('#' ∉ mapping[:,c]) && (s1 += 1e6-1)
                end
            end
        end

        return s0, s1
    end
end 

