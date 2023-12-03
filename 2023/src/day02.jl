module Day02
    using ..aoc23
    """
    day02()

    Solves the two puzzles of day 2. 
    """

    mutable struct hand
        red::Int
        blue::Int
        green::Int
    end

    mutable struct game
        id::Int
        hands::Array{hand, 1}
    end

    function getgames(input)
        rred   = r"(\d+) red"
        rgreen = r"(\d+) green"
        rblue  = r"(\d+) blue"

        games = game[]
        
        for line in split(input, "\n")
            id, hands = split(line, ": ")
            id = replace(id, "Game " => "")
            g = game(parse(Int, id), [])
            for h in split(hands, "; ")
                thishand = hand(0, 0, 0)
                red = match(rred, h)
                if red !== nothing
                    thishand.red = parse(Int, red[1])
                end
                green = match(rgreen, h)
                if green !== nothing
                    thishand.green = parse(Int, green[1])
                end
                blue = match(rblue, h)
                if blue !== nothing
                    thishand.blue = parse(Int, blue[1])
                end
                push!(g.hands, thishand)
            end
            push!(games, g)
        end
        
        return games
    end

    function day02(input::String = readInput(01))
        games = getgames(input)
        
        s0 = 0
        s1 = 0

        for g in games
            maxreds   = maximum([h.red   for h in g.hands])
            maxgreens = maximum([h.green for h in g.hands])
            maxblues  = maximum([h.blue  for h in g.hands])
     
            (maxreds <= 12 && maxgreens <= 13 && maxblues <= 14) && (s0 += g.id)

            s1 += maxreds * maxgreens * maxblues
            
        end
        return s0, s1
    end
end