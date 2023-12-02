module Day01
    using ..AdventOfCode23
    """
    day01()

    Solves the two puzzles of day 1. 
    """
    const par = Dict{String, String}(
        "1"   => "1", "2"   => "2", "3"     => "3", "4"    => "4", "5"    => "5", "6"   => "6", "7"     => "7", "8"     => "8", "9"    => "9",
        "one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9",
        "eno" => "1", "owt" => "2", "eerht" => "3", "ruof" => "4", "evif" => "5", "xis" => "6", "neves" => "7", "thgie" => "8", "enin" => "9"
        )

    function day01(input::String = readInput(01))
        s0 = 0
        s1 = 0

        r = r"(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)|(\d)"
        rr = r"(eno)|(owt)|(eerht)|(ruof)|(evif)|(xis)|(neves)|(thgie)|(enin)|(\d)"

        for line in split(input, "\n")
            linerev = reverse(line)
            s0 += parse(Int, line[findfirst(r"\d", line)]*linerev[findfirst(r"\d", linerev)])
            s1 += parse(Int, par[line[findfirst(r, line)]]*par[linerev[findfirst(rr, linerev)]])
        end
        return s0, s1
    end
end