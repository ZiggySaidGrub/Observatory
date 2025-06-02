Observatory.swap = function (set)
    for i, v in ipairs(Observatory.config[set]) do
        for j, w in ipairs(G.jokers.cards) do
            if v == w.ability.obs_id then
                G.jokers.cards[i], G.jokers.cards[j] = G.jokers.cards[j], G.jokers.cards[i]
            end
        end
    end
end