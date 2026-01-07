	SMODS.Joker:take_ownership('credit_card', {
	loc_txt = {
        ["name"] = "Credit Card",
        ["text"] = {
            [1] = "Go up to {C:red}-$#1#{} in debt.",
            [2] = "When {C:attention}Boss Blind{} is",
			[3] = "defeated, remove all debt"
        },
    },
	config = {extra = 15},
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss and G.GAME.dollars < 0 then
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
					card:juice_up()
					ease_dollars(-G.GAME.dollars, true)
			return true end }))
		end
	end})
