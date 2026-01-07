	SMODS.Consumable:take_ownership('hex', {
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
		info_queue[#info_queue+1] = {key = "pinned_left", set = "Other"}
	end,
	loc_txt = {
        ["name"] = "Hex",
        ["text"] = {
            [1] = "Add {C:dark_edition}Polychrome{}",
            [2] = "and {C:diamonds}Pinned{} to a",
			[3] = "random {C:attention}Joker{}",
        },
    },
	use = function(self, card)
		local temp_pool = ((card.ability.name == 'Hex') and card.eligible_editionless_jokers) or {}
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local over = false
            local eligible_card = pseudorandom_element(temp_pool, pseudoseed(
                (card.ability.name == 'Hex' and 'hex')
            ))
			eligible_card.pinned = true
            eligible_card:set_edition({polychrome = true}, true)
            check_for_unlock({type = 'have_edition'})
            card:juice_up(0.3, 0.5)
        return true end }))
	end})
