 
module day06
    using ..aoc23

    """
        solution()

    Solves the two puzzles of day 06. 
    """

    function race(t, rec)
        distances = [(t-hold)*hold for hold in 0:t]
        wins = filter(x -> x > rec, distances)
        return length(wins)
    end

    function solution(input::String = readInput(06))
        t, x = split(input, "\n")
        t = split(t, r": +")[2]
        x = split(x, r": +")[2]
        t = [parse(Int, i) for i in split(t, r" +")]
        x = [parse(Int, i) for i in split(x, r" +")]

        s0 = 1
        for (tt, xx) in zip(t,x) 
            s0 *= race(tt, xx)
        end

        t, x = split(input, "\n")
        t = split(t, r": +")[2]
        x = split(x, r": +")[2]

        t = parse(Int, replace(t, " " => ""))
        x = parse(Int, replace(x, " " => ""))

        s1 = race(t, x)

        return s0, s1
    end
end 

