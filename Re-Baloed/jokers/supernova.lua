	SMODS.Joker:take_ownership('supernova', {
	name = "supernova (ReBaloed)",
	loc_txt = {
        ["name"] = "Supernova",
        ["text"] = {
            [1] = "Add {C:red}Mult{} to played",
			[2] = "{C:attention}poker hand{} equal to",
            [3] = "the number of times its",
			[4] = "been played this run",
        },
    },
	calculate = function(self, card, context)
		if context.before then
			G.GAME.hands[context.scoring_name].mult = G.GAME.hands[context.scoring_name].mult + G.GAME.hands[context.scoring_name].played
			mult = mod_mult(G.GAME.hands[context.scoring_name].mult)
			update_hand_text({delay = 0}, {mult = mult})
			return {
			message = localize{type='variable',key='a_mult',vars={G.GAME.hands[context.scoring_name].played}},
			colour = G.C.MULT
			}
		end
		if context.after then
			G.GAME.hands[context.scoring_name].mult = G.GAME.hands[context.scoring_name].mult - G.GAME.hands[context.scoring_name].played
		end
	end})
