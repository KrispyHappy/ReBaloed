	SMODS.Joker:take_ownership('delayed_grat', {
	loc_txt = {
        ["name"] = "Delayed Gratification",
        ["text"] = {
            [1] = "At end of each round earn",
            [2] = "{C:money}$#1#{} per remaining {C:red}Discard{}",
        },
    },
	calc_dollar_bonus = function(self, card)
        if G.GAME.current_round.discards_left > 0 then
            return G.GAME.current_round.discards_left*card.ability.extra
        end
    end})
