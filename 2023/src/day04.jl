 
module day04
    using ..aoc23

    """
        solution()

    Solves the two puzzles of day 04. 
    """

    mutable struct card
        nr::Int
        win::Vector{Int}
        obt::Vector{Int}
        copies::Int
        wins::Int
    end

    function solution(input::String = readInput(04))
        deck = card[]
        for (nr, c) in enumerate(split(input, "\n"))
            win, obt = split(split(c, r": +")[2], r" +\| +")
            win = [parse(Int, n) for n in split(win, r" +")]
            obt  = [parse(Int, n) for n in split(obt,  r" +")]
            push!(deck, card(nr, win, obt, 1, 0))
        end

        s0 = 0
        for card in deck
            score = 0
            for n in card.obt
                if n in card.win
                    if score == 0
                        score = 1
                    else
                        score *= 2
                    end
                    card.wins += 1
                end
            end
            s0 += score
        end

        for (nr, card) in enumerate(deck)
            for i in 1:card.wins
                deck[nr+i].copies += card.copies
            end
        end

        s1 = 0
        for card in deck
            s1 += card.copies
        end

        return s0, s1
    end

end 
