 
module day05
    using ..aoc23

    """
        solution()

    Solves the two puzzles of day 05. 
    """

    struct Map
        from::UnitRange{Int}
        to::UnitRange{Int}
    end

    struct Maps
        maps::Set{Map}
    end

    function (f::Map)(input)
        (input in f.from) && (return input - f.from.start + f.to.start)
        nothing
    end

    function (f::Maps)(input)
        for m in f.maps
            to = m(input)
            !isnothing(to) && return to
        end
        return input
    end

    function map(init_from::Int, init_to::Int, range::Int)
        return Map(init_from:init_from+range-1, init_to:init_to+range-1)
    end

    function get_maps(list_ranges)
        maps = Set{Map}()
        for ranges in list_ranges
            ranges = [parse(Int, n) for n in split(ranges, " ")]
            push!(maps, map(ranges[2], ranges[1], ranges[3]))
        end
        return maps
    end

    function (f::Map)(ur::UnitRange{Int})
        start, stop = f.from.start, f.from.stop

        if ur.start < start 
            left = ur.start:min(ur.stop, start-1)
        else
            left = nothing
        end

        if (start <= ur.stop) & (stop >= ur.start)
            mapped = f(max(ur.start, start)):f(min(ur.stop, stop))
        else
            mapped = nothing
        end

        if stop < ur.stop
            right = max(ur.start, stop+1):ur.stop
        else
            right = nothing
        end

        return (left, mapped, right)
    end

    function (f::Maps)(ur::UnitRange{Int})
        result = UnitRange{Int}[]
        queue = UnitRange{Int}[ur]
        
        for m in f.maps
            for _ in eachindex(queue)
                q = pop!(queue)
                left, mapped, right = m(q)
                !isnothing(left)    && push!(queue, left)
                !isnothing(mapped)  && push!(result, mapped)
                !isnothing(right)   && push!(queue, right)
            end
        end

        append!(result, queue)

        return result
    end

    function solution(input::String = readInput(05))
        input = split(input, "\n\n")

        seeds = [parse(Int, n) for n in split(split(input[1], ": ")[2])]
        maps = Maps[]
        for ins in input[2:end]
            push!(maps, Maps(get_maps(split(ins, "\n")[2:end])))
        end
        
        locs = Set{Int}()
        for loc in seeds
            for m in maps
                loc = m(loc)
            end
            push!(locs, loc)
        end
        
        s0 = minimum(locs)

        locations = UnitRange{Int}[]
        for i in 1:2:length(seeds)-1
            location = UnitRange{Int}[seeds[i]:seeds[i]+seeds[i+1]]

            for m in maps
                next = UnitRange{Int}[]
                for loc in location 
                    append!(next, m(loc))
                end
                location = next
            end

            append!(locations, location)
        end

        s1 = minimum(x -> x.start, locations)

        return s0, s1
    end
end 

