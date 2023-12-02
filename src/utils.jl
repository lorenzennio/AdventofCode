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