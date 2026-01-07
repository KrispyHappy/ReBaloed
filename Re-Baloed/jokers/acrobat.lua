	SMODS.Joker:take_ownership('acrobat', {
	name = "Acrobat (ReBaloed)",
	loc_txt = {
        ["name"] = "Acrobat",
        ["text"] = {
            [1] = "{X:red,C:white} X#1# {} Mult on {C:attention}final",
            [2] = "{C:attention}hand{} of round or next",
			[3] = "{C:attention}played hand{} after",
			[4] = "{C:attention}final discard{} of round"
        },
    },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.Xmult}}
    end,
    config = {extra = {Xmult = 3, acrobat_trigger = 0}},
	calculate = function(self, card, context)
		if (context.after and G.GAME.current_round.hands_left == 1) or (G.GAME.current_round.discards_left == 1 and context.pre_discard) or (G.GAME.current_round.discards_used == 0 and G.GAME.current_round.discards_left == 0) and not context.blueprint and card.ability.extra.acrobat_trigger == 0 then
			card.ability.extra.acrobat_trigger = 1
			local eval = function() return (card.ability.extra.acrobat_trigger == 1) end
            juice_card_until(card, eval, false)
			return
		end
		if context.joker_main and card.ability.extra.acrobat_trigger == 1 then
			card.ability.extra.acrobat_trigger = 0
		    return {
                Xmult = card.ability.extra.Xmult
            }
		end
	end})
