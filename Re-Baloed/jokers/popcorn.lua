	SMODS.Joker:take_ownership('popcorn', {
	name = "Popcorn (ReBaloed)",
	loc_txt = {
        ["name"] = "Popcorn",
        ["text"] = {
			[1] = "{C:mult}+#1#{} Mult",
			[2] = "{C:mult}-#2#{} Mult per round",
			[3] = "played. When Mult runs",
			[4] = "out, create {C:attention}The Empress{}"
        },
    },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_empress
        return { vars = { card.ability.mult, card.ability.extra } }
    end,
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if card.ability.mult - card.ability.extra <= 0 then
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = (function()
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.add_card {
									set = 'Tarot',
									key = 'c_empress'
								}
								G.GAME.consumeable_buffer = 0
								return true
							end
						}))
						SMODS.destroy_cards(card, nil, nil, true)
						SMODS.calculate_effect({ message = localize('k_eaten_ex'), colour = G.C.RED },
							context.blueprint_card or card)
						return true
					end)
					}))
					return nil, true
				else
					SMODS.destroy_cards(card, nil, nil, true)
					return {
						message = localize('k_eaten_ex'),
						colour = G.C.RED
					}
				end
            elseif not context.blueprint then
                card.ability.mult = card.ability.mult - card.ability.extra
                return {
                    message = localize { type = 'variable', key = 'a_mult_minus', vars = { card.ability.extra } },
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.mult
            }
        end
    end})
