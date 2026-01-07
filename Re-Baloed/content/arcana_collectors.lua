SMODS.Booster {
    key = "arcana_collectors",
    loc_txt = {
        ["name"] = "Collectors Arcana Pack",
		["text"] = {
            [1] = "Choose any or all {C:attention}#1#{} {C:tarot}Tarot{}",
            [2] = "cards to be used immediately"
		},
	},
    weight = 0.01,
    kind = 'Arcana',
    cost = 10,
	atlas = 'ReBaloed_Boosters',
    pos = { x = 1, y = 0 },
    config = { extra = 5, choose = 5 },
    group_key = "k_arcana_pack",
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "Spectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "ReBaloed_ar"
            }
        else
            _card = {
                set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "ReBaloed_ar"
            }
        end
        return _card
    end,
}

	SMODS.Tag:take_ownership('charm', {
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = G.P_CENTERS.p_rb_arcana_collectors
	end,
	loc_txt = {
		["name"] = "Charm Tag",
		["text"] = {
			[1] = "Gives a free",
			[2] = "{C:tarot}Collectors Arcana Pack"
		},
	},
	apply = function(self, tag, context)
	if context.type == 'new_blind_choice' then
        G.CONTROLLER.locks[tag.ID] = true
        tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
			local key = 'p_rb_arcana_collectors'
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
