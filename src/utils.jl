# Read the input from a file:
function readInput(path::String)
    s = open(path, "r") do file
        read(file, String)
    end
    return s
end

function readInput(day::Int, directory::String)
    path = joinpath(directory, "../inputs", @sprintf("day%02d.txt", day))
    return readInput(path)
end

function create_files(year::Int, day::Int)
    y = string(year)
    d = @sprintf("%02d", day)

    touch("20$y/inputs/day$d.txt")

    src = "20$y/src/day$d.jl"
    touch(src)

    template = """ 
    module day$d
        using ..aoc$y

        \"""
            solution()

        Solves the two puzzles of day $d. 
        \"""

        function solution(input::String = readInput($d))

        end
    end 

    """
    open(src, "a") do io
        write(io, template)
    end
    
    test = """

    @testset "Day $d" begin
        @test aoc$y.day$d.solution() == [s0 , s1]
    end
    

    """

    open("20$y/test/runtests.jl", "a") do io
        write(io, test)
    end
end