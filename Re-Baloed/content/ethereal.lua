	SMODS.Tag:take_ownership('ethereal', {
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = G.P_CENTERS.p_spectral_mega_1
	end,
	loc_txt = {
		["name"] = "Ethereal Tag",
		["text"] = {
			[1] = "Gives a free",
			[2] = "{C:spectral}Mega Spectral Pack"
		},
	},
	apply = function(self, tag, context)
	if context.type == 'new_blind_choice' then
        G.CONTROLLER.locks[tag.ID] = true
        tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
			local key = 'p_spectral_mega_1'
			local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
			G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, 	bypass_discovery_ui = true})
			card.cost = 0
			card.from_tag = true
			G.FUNCS.use_card({config = {ref_table = card}})
			card:start_materialize()
			G.CONTROLLER.locks[tag.ID] = nil
			return true
		end)
        tag.triggered = true
        return true
        end
        end})
