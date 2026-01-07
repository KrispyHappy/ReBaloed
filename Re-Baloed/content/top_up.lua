	SMODS.Tag:take_ownership('top_up', {
	loc_txt = {
		["name"] = "Top-up Tag",
		["text"] = {
			[1] = "Create {C:attention}#1# {C:blue}Common{}",
			[2] = "Jokers, even if",
			[3] = "there's no room"
		},
	},
	apply = function(self, tag, context)
		tag:yep('+', G.C.PURPLE,function()
			for i = 1, tag.config.spawn_jokers do
				local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'top')
				card:add_to_deck()
				G.jokers:emplace(card)
			end
			G.CONTROLLER.locks[tag.ID]  = nil
			return true
	    end)
	    tag.triggered = true
	    return true
	    end})
