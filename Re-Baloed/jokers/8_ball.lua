	SMODS.Joker:take_ownership('8_ball', {
	name = "8_ball (ReBaloed)",
	loc_txt = {
        ["name"] = "8 Ball",
        ["text"] = {
            [1] = "After an {C:attention}8{} is",
			[2] = "discarded next played {C:attention}8{}",
			[3] = "creates a {C:tarot}Tarot{} card",
			[4] = "{C:inactive}(Must have room)",
        },
    },
	config = {ball_ready = 0},
	calculate = function(self, card, context)
		if context.discard then
			if context.other_card:get_id() == 8 then
				card.ability.ball_ready = 1
				local eval = function() return card.ability.ball_ready == 1 end
				juice_card_until(card, eval, true)
			end
		end
		if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		  if context.individual and context.cardarea == G.play then
			if (context.other_card:get_id() == 8) and card.ability.ball_ready == 1 then
				card.ability.ball_ready = 0
		        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {focus = card, message = localize('k_plus_tarot'), func = function()
                    G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                    local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, '8ba')
						card:add_to_deck()
						G.consumeables:emplace(card)
						G.GAME.consumeable_buffer = 0
						return true
                      end)}))
                    end},
                    colour = G.C.SECONDARY_SET.Tarot,
                    card = card
                }
            end
		  end
        end
	end})
