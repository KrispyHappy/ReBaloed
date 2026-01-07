	SMODS.Joker:take_ownership('square', {
	loc_txt = {
        ["name"] = "Square Joker",
        ["text"] = {
            [1] = "This Joker gains {C:blue}+#2#{} chips for",
            [2] = "every {C:attention}played hand{} and {C:attention}discard{}",
            [3] = "that are exactly {C:attention}4{} cards",
			[4] = "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}",
        },
    },
	rarity = 2,
	calculate = function(self, card, context)
		if context.discard then
			if context.other_card == context.full_hand[#context.full_hand] and not context.blueprint then
					local square_cards = 0
					for k, v in ipairs(context.full_hand) do
						square_cards = square_cards + 1
					end
					if square_cards == 4 then
						card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
						return {
							message = localize('k_upgrade_ex'),
							colour = G.C.CHIPS
						}
					end
				return
			end
		end
    end})
