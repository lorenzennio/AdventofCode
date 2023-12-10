 
module day07
    using ..aoc23
    using DataStructures

    """
        solution()

    Solves the two puzzles of day 07. 
    """

    const ctv = Dict{Char, Int}('A'=>14, 'K'=>13, 'Q'=>12, 'J'=>11, 'T'=> 10, '9'=> 9, '8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2)
    const ctvJ= Dict{Char, Int}('A'=>14, 'K'=>13, 'Q'=>12, 'J'=>1, 'T'=> 10, '9'=> 9, '8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2)

    struct hand
        cards::String
        bid::Int
        value::Int
        valueJ::Int
    end

    function hand(cards::AbstractString, bid::Int)
        value = sum([10^(10-2*i) * ctv[c] for (i, c) in enumerate(cards)])
        value += 10^10 * gettype(cards)
        valueJ = value
        if 'J' in cards
            valueJ = sum([10^(10-2*i) * ctvJ[c] for (i, c) in enumerate(cards)])
            valueJ += 10^10 * gettypeJ(cards)
        end
        return hand(cards, bid, value, valueJ)
    end

    function gettype(cards::AbstractString)
        c = counter(cards)
        return gettype(c)
    end

    function gettypeJ(cards::AbstractString)
        c = counter(cards)
        (length(c) == 1) && (return 7)
        delete!(c.map, 'J')
        ncards = replace(cards, "J" => findmax(c)[2])
        c = counter(ncards)
        return gettype(c)
    end

    function gettype(c::Accumulator{Char, Int64})
        if length(c) == 1 # Five of a kind
            return 7
        elseif length(c) == 2 # Four of a kind or Full house
            if maximum(values(c)) == 4
                return 6
            else
                return 5
            end
        elseif length(c) == 3 # Two pair or Three of a kind
            if maximum(values(c)) == 3
                return 4
            else
                return 3
            end
        elseif length(c) == 4 # One pair
            return 2
        else # High card
            return 1
        end
    end

    
    function solution(input::String = readInput(07))

        hands = hand[]
        for line in split(input, "\n")
            cards, bid = split(line, " ")
            push!(hands, hand(cards, parse(Int, bid)))
        end

        sort!(hands, by = x -> x.value)
        s0 = sum(i * v.bid for (i, v) in enumerate(hands))

        sort!(hands, by = x -> x.valueJ)
        s1 = sum(i * v.bid for (i, v) in enumerate(hands))
        
        return s0, s1
    end
end 
