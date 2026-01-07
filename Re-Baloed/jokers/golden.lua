	SMODS.Joker:take_ownership('golden', {
	name = "Golden Joker (ReBaloed)",
	loc_txt = {
        ["name"] = "Golden Joker",
        ["text"] = {
            [1] = "Whever {C:money}money{} changes,",
            [2] = "{C:green}#1# in #2#{} chance to give {C:money}$#4#{}",
            [3] = "at the next {C:attention}Cashout{}.",
            [4] = "{C:inactive}(Next cashout gives {C:money}$#3#{C:inactive})"
        },
    },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'ReBaloed_golden')
        return { vars = { numerator, denominator, card.ability.extra.money, card.ability.extra.money_mod}}
    end,
	config = {extra = {odds = 2, money = 0, money_mod = 1}},
	calculate = function(self, card, context)
		if context.money_altered and SMODS.pseudorandom_probability(card, 'ReBaloed_golden', 1, card.ability.extra.odds) then
			card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
			return {
				message = localize('k_upgrade_ex')
			}
		end
		if context.starting_shop then
			card.ability.extra.money = 0
			return {
				message = localize('k_reset')
			}
		end
    end,
	calc_dollar_bonus = function(self, card)
		if  card.ability.extra.money > 0 then
			return card.ability.extra.money
		end
    end})
