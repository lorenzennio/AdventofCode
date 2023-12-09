module aoc23

    using aoc
    using Printf
    
    readInput(day::Int) = aoc.readInput(day, @__DIR__)
    export readInput


    solvedDays = [parse(Int, match(r"\d+", file).match) for file in Base.Filesystem.readdir(@__DIR__) if isnothing(match(r"aoc", file))]
    
		# Include the source files:
    for day in solvedDays
        ds = @sprintf("%02d", day)
        include(joinpath(@__DIR__, "day$ds.jl"))
    end

    # Export a function `solutionXX` for each day:
    for d in solvedDays
        modSymbol = Symbol(@sprintf("day%02d", d))
        solSymbol = Symbol(@sprintf("solution%02d", d))
        @eval begin
            function $solSymbol(input::String = aoc23.readInput($d))
                return aoc23.$modSymbol.solution(input)
            end
            export $solSymbol
        end
    end
end # module aoc23
