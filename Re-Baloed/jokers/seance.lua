	SMODS.Joker:take_ownership('seance', {
	name = "Séance (ReBaloed)",
	loc_txt = {
        ["name"] = "Séance",
        ["text"] = {
            [1] = "After playing a {C:attention}Straight{}",
            [2] = "and then a {C:attention}Flush{},",
			[3] = "create a {C:spectral}Spectral{} card",
			[4] = "{C:inactive}(Must have room)",
			[5] = "{C:inactive}(#1#)"
        },
    },
	loc_vars = function(self, info_queue, card)
        local vars
        if card.ability.extra.hand_tracker == 1 then
			return {vars = {"Flush next"}}
        else
            return {vars = {"Straight next"}}
        end
    end,
    rarity = 3,
	config = {extra = {hand_tracker = 0}},
	calculate = function(self, card, context)
		if context.before and context.poker_hands then
			if (next(context.poker_hands['Flush']) and card.ability.extra.hand_tracker == 1) or next(context.poker_hands['Straight Flush']) then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = (function()
						SMODS.add_card {
							set = 'Spectral'
						}
						G.GAME.consumeable_buffer = 0
						card.ability.extra.hand_tracker = 0
						return true
					end)
					}))
				return {
					nil, true,
					message = localize('k_plus_spectral'),
					colour = G.C.SECONDARY_SET.Spectral
				}
			elseif next(context.poker_hands['Straight']) and card.ability.extra.hand_tracker == 0 and not context.blueprint then
				card.ability.extra.hand_tracker = 1
				local eval = function() return (card.ability.extra.hand_tracker == 1) end
				juice_card_until(card, eval, false)
				return {
					message = 'Straight'
				}
			end
		end
	end})
