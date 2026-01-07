	SMODS.Joker:take_ownership('misprint', {
	name = "Misprint (ReBaloed)",
	loc_txt = {
        ["name"] = "Misprint",
        ["text"] = {
            [1] = "Gives {C:blue}chips{} equal to",
            [2] = "the difference between",
            [3] = "card rank and {C:attention}#1#{} whever",
            [4] = "{C:attention}CONTEXT.INDIVIDUAL{} triggers"
        },
    },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra}}
    end,
	config = {extra = 15},
	calculate = function(self, card, context)
	if context.individual and not context.end_of_round then
		return {
			chips = card.ability.extra-context.other_card.base.nominal,
			card = card
		}
	end
    end})
