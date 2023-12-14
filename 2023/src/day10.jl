 
module day10
    using ..aoc23
    """
        solution()

    Solves the two puzzles of day 10. 
    """

    const r = CartesianIndex( 0,  1)
    const d = CartesianIndex( 1,  0)

    const orthog = Dict{CartesianIndex{2}, CartesianIndex{2}}(
        r => -d, -r => d, d => r, -d => -r
    )


    function step(mapping::Matrix{Char}, loc::CartesianIndex{2}, steps::Vector{CartesianIndex{2}})
        mapping[loc] = 'x'

        ( r in steps) && (mapping[loc+r]=='-') && (return mapping, loc+r, [ r])
        ( r in steps) && (mapping[loc+r]=='J') && (return mapping, loc+r, [-d])
        ( r in steps) && (mapping[loc+r]=='7') && (return mapping, loc+r, [ d])
        (-r in steps) && (mapping[loc-r]=='-') && (return mapping, loc-r, [-r])
        (-r in steps) && (mapping[loc-r]=='L') && (return mapping, loc-r, [-d])
        (-r in steps) && (mapping[loc-r]=='F') && (return mapping, loc-r, [ d])
        ( d in steps) && (mapping[loc+d]=='|') && (return mapping, loc+d, [ d])
        ( d in steps) && (mapping[loc+d]=='J') && (return mapping, loc+d, [-r])
        ( d in steps) && (mapping[loc+d]=='L') && (return mapping, loc+d, [ r])
        (-d in steps) && (mapping[loc-d]=='|') && (return mapping, loc-d, [-d])
        (-d in steps) && (mapping[loc-d]=='7') && (return mapping, loc-d, [-r])
        (-d in steps) && (mapping[loc-d]=='F') && (return mapping, loc-d, [ r])

        return mapping, true, true
    end

    function idregion(mapping::Matrix{Char}, loc::CartesianIndex{2}, step::CartesianIndex{2})
        ll = length(mapping[1,:])
        ul = length(mapping[:,1])
        nloc = loc + orthog[ step]
        for nl in [nloc, nloc + step]
            (0 < nl[1] <= ul) && (0 < nl[2] <= ll) && (mapping[nl] != 'x') && (mapping[nl] = 'I')
        end
        nloc = loc + orthog[-step]
        for nl in [nloc, nloc + step]
            (0 < nl[1] <= ul) && (0 < nl[2] <= ll) && (mapping[nl] != 'x') && (mapping[nl] = 'O')
        end
        return mapping
    end

    function solution(input::String = readInput(10))
        mapping = Vector{Char}[[l for l in line] for line in split(input, "\n")]

        origmap = permutedims(hcat(mapping...))
        mapping = deepcopy(origmap)
        regions = deepcopy(origmap)

        s = findall(x->x=='S', mapping)[1]
        mapping[s] = 'x'
        
        loc = deepcopy(s)
        steps = [-r, r, -d, d]
        while true
            mapping, loc, steps = step(mapping, loc, steps)
            (loc == true) && (break)
        end

        # walk around and find in/out
        loc = deepcopy(s)
        steps = [-r, r, -d, d]
        while true
            regions, loc, steps = step(regions, loc, steps)
            (loc == true) && (break)
            mapping = idregion(mapping, loc, steps[1])
        end

        # flood fill
        ll = length(mapping[1,:])
        ul = length(mapping[:,1])
    
        while !isempty(findall(x -> x ∉ ['I', 'O', 'x'], mapping))
            Is = findall(x -> x == 'I', mapping)
            Os = findall(x -> x == 'O', mapping)

            for i in Is
                for d in [-r, r, -d, d]
                    nloc = i + d
                    (0 < nloc[1] <= ul) && (0 < nloc[2] <= ll) && (mapping[nloc] ∉ ['I', 'O', 'x']) && (mapping[nloc] = 'I')
                end
            end

            for i in Os
                for d in [-r, r, -d, d]
                    nloc = i + d
                    (0 < nloc[1] <= ul) && (0 < nloc[2] <= ll) && (mapping[nloc] ∉ ['I', 'O', 'x']) && (mapping[nloc] = 'O')
                end
            end
        end

        s0 = length(findall(x->x=='x', mapping))/2
        s1 = length(findall(x -> x == 'I', mapping))

        return s0, s1
    end
end 

