SMODS.Booster {
    key = "standard_collectors",
	loc_txt = {
		["name"] = "Collectors Standard Pack",
		["text"] = {
			[1] = "Choose {C:attention}#1#{} of up to {C:attention}#2#{C:attention} Playing{} cards",
			[2] = "to add to your deck, all with",
			[3] = "an {C:attention}enhancement{}, {C:attention}seal{} and {C:attention}edition{}"
		},
	},
    weight = 0,
    kind = 'Standard',
    cost = 10,
	atlas = 'ReBaloed_Boosters',
    pos = { x = 0, y = 0 },
    config = { extra = 4, choose = 1 },
    group_key = "k_standard_pack", -- Delete this if you're using `group_name` in `loc_txt`
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.STANDARD_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.3,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLACK, G.C.RED, G.C.PURPLE, G.C.GOLD },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _edition = SMODS.poll_edition({no_negative = true, guaranteed = true})
        local _enchant = SMODS.poll_enhancement({guaranteed = true})
        local _seal = SMODS.poll_seal({guaranteed = true})
        return {
            set = "Playing Card",
            enhancement = _enchant,
            edition = _edition,
            seal = _seal,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "ReBaloed_sta"
        }
    end,
}

	SMODS.Tag:take_ownership('standard', {
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = G.P_CENTERS.p_rb_standard_collectors
	end,
	loc_txt = {
		["name"] = "Standard Tag",
		["text"] = {
			[1] = "Gives a free",
			[2] = "{C:attention}Collectors Standard Pack"
		},
	},
	apply = function(self, tag, context)
	if context.type == 'new_blind_choice' then
        G.CONTROLLER.locks[tag.ID] = true
        tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
			local key = 'p_rb_standard_collectors'
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
