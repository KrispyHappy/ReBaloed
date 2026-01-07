	SMODS.Joker:take_ownership('loyalty_card', {
	loc_txt = {
        ["name"] = "Loyalty Card",
        ["text"] = {
            [1] = "Every {C:attention}3{} hands this",
            [2] = "gives {X:mult,C:white}X#1#{} Mult and {C:money}$3{}",
			[3] = "{C:inactive}(#3#){}"
        },
    },
	config = {extra = {Xmult = 3, every = 2, remaining = "2 remaining"}},
	cost = 8,
	calculate = function(self, card, context)
		if context.joker_main then
			if card.ability.loyalty_remaining == 0 then
			card:juice_up()
			ease_dollars(3, true)
		   end
		end
	end})
