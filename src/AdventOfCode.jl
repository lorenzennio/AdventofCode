module AdventOfCode

    using Printf    

    include("utils.jl")
    include(joinpath(@__DIR__, "../2023/src/AdventOfCode23.jl"))

    plusone(x::Int) = x + 1
end
