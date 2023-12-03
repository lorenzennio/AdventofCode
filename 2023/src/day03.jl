 
module Day03
    using ..aoc23

    """
        day03()

    Solves the two puzzles of day 03. 
    """
    
    function day03(input::String = readInput(03))

        grid = split(input, "\n")
        glen = length(grid[1])

        range_extend(range::UnitRange{Int64}) = max(1,(range[1]-1)):min(glen, range[end]+1)
        range_extend(index::Int64) = max(1,(index-1)):min(glen, index+1)
        
        nrs = Int[]

        for (ind, line) in enumerate(grid)

            for range in findall(r"\d+", line)
                range_ext = range_extend(range)
            
                tosearch = prod([grid[i][range_ext] for i in range_extend(ind)])
            
                if (match(r"[^0-9\.]", tosearch) !== nothing)
                    push!(nrs, parse(Int, line[range]))
                end

            end

        end

        s0 = sum(nrs)
        
        s1 = 0
        for (ind, line) in enumerate(grid)

            for range in findall("*", line)
                
                nst = Int[]
                
                range_ext = range_extend(range)

                tosearch = [grid[i] for i in range_extend(ind)]

                for search_line in tosearch
                    for nrange in findall(r"\d+", search_line)
                        if (nrange[1] in range_ext) | (nrange[end] in range_ext)
                            push!(nst, parse(Int, search_line[nrange]))
                        end
                    end
                end

                if (length(nst) > 1)
                    s1 += prod(nst)
                end

            end

        end

        return s0, s1

    end
    
end 

