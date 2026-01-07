	SMODS.Joker:take_ownership('idol', {
	loc_txt = {
        ["name"] = "The Idol",
        ["text"] = {
            [1] = "Each played {C:attention}#2#",
            [2] = "gives {X:mult,C:white} X#1# {} Mult",
            [3] = "when scored",
            [4] = "{s:0.75}Rank changes every round",
        },
    },
	calculate = function(self, card, context)
	if context.individual and context.cardarea == G.play then
	    if context.other_card:get_id() == G.GAME.current_round.idol_card.id then
            return {
                x_mult = card.ability.extra,
                colour = G.C.RED,
				card = card
            }
        end
	  end
	end})
