	SMODS.Joker:take_ownership('greedy_joker', {
	name = "Greedy Joker (ReBaloed)",
	loc_txt = {
        ["name"] = "Greedy Joker",
        ["text"] = {
			[1] = "Earn {C:money}$#1#{} when a",
			[2] = "{C:diamonds}Diamond{} is discarded"
        },
    },
	config = {extra = {money = 1, suit = 'nil_rebaloed'}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
		if context.discard and not context.other_card.debuff and context.other_card:is_suit("Diamonds") then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
			return {
				dollars = card.ability.extra.money,
				func = function()
				G.E_MANAGER:add_event(Event({
				func = function()
				G.GAME.dollar_buffer = 0
				return true
				end
				}))
			end
			}
		end
    end})

	SMODS.Joker:take_ownership('lusty_joker', {
	name = "Lusty Joker (ReBaloed)",
	loc_txt = {
        ["name"] = "Lusty Joker",
        ["text"] = {
			[1] = "{C:green}#4# in #3#{} chance to gain",
			[2] = "{X:mult,C:white} X#2# {} Mult per {C:hearts}Heart{}",
			[3] = "discarded {C:attention}this hand{}",
			[4] = "{C:inactive}(Currently {X:mult,C:white} X#1# {} {C:inactive}Mult){}"
        },
    },
	config = {extra = {Xmult = 1, Xmult_gain = 0.5, odds = 3, suit = 'nil_rebaloed'}},
    loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'ReBaloed_lusty')
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain, denominator, numerator } }
    end,
    calculate = function(self, card, context)
		if context.discard and not context.blueprint and not context.other_card.debuff and context.other_card:is_suit("Hearts") and SMODS.pseudorandom_probability(card, 'ReBaloed_lusty', 1, card.ability.extra.odds) then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                colour = G.C.RED
            }
		end
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
                Xmult = card.ability.extra.Xmult,
            }
		end
		if context.after and card.ability.extra.Xmult > 1 then
			card.ability.extra.Xmult = 1
		end
    end})

	SMODS.Joker:take_ownership('wrathful_joker', {
	name = "Wrathful Joker (ReBaloed)",
	loc_txt = {
        ["name"] = "Wrathful Joker",
        ["text"] = {
			[1] = "{C:chips}+#2#{} Chips per {C:spades}Spade{}",
			[2] = "discarded {C:attention}this hand{}",
			[3] = "{C:inactive}(Currently {C:chips}+#1#{} {C:inactive}Chips){}"
        },
    },
	config = {extra = {chips = 0, chip_gain = 20, suit = 'nil_rebaloed'}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
    end,
    calculate = function(self, card, context)
		if context.discard and not context.blueprint and not context.other_card.debuff and context.other_card:is_suit("Spades") then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
			return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                colour = G.C.BLUE
            }
		end
		if context.joker_main and card.ability.extra.chips > 1 then
			return {
                chips = card.ability.extra.chips,
            }
		end
		if context.after and card.ability.extra.chips > 1 then
			card.ability.extra.chips = 0
		end
    end})

	SMODS.Joker:take_ownership('gluttenous_joker', {
	name = "Gluttenous Joker (ReBaloed)",
	loc_txt = {
        ["name"] = "Gluttenous Joker",
        ["text"] = {
			[1] = "{C:mult}+#2#{} Mult per {C:clubs}Club{}",
			[2] = "discarded {C:attention}this hand{}",
			[3] = "{C:inactive}(Currently {C:mult}+#1#{} {C:inactive}Mult){}"
        },
    },
	config = {extra = {mult = 0, mult_gain = 4, suit = 'nil_rebaloed'}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
    calculate = function(self, card, context)
		if context.discard and not context.blueprint and not context.other_card.debuff and context.other_card:is_suit("Clubs") then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                colour = G.C.RED
            }
		end
		if context.joker_main and card.ability.extra.mult > 1 then
			return {
                mult = card.ability.extra.mult,
            }
		end
		if context.after and card.ability.extra.mult > 1 then
			card.ability.extra.mult = 0
		end
    end})
