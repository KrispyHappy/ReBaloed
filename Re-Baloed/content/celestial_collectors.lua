SMODS.Booster {
    key = "celestial_collectors",
    loc_txt = {
        ["name"] = "Collectors Celestial Pack",
		["text"] = {
            [1] = "Choose {C:attention}#1#{} of up to {C:attention}#2#{C:planet} Planet{}",
            [2] = "cards to be used immediately"
		},
	},
    weight = 0.01,
    kind = 'Celestial',
    cost = 10,
	atlas = 'ReBaloed_Boosters',
    pos = { x = 2, y = 0 },
    config = { extra = 7, choose = 3 },
    group_key = "k_celestial_pack",
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "Planet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "ReBaloed_pl"
            }
        else
            _card = {
                set = "Planet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "ReBaloed_pl"
            }
        end
        return _card
    end,
}

	SMODS.Tag:take_ownership('meteor', {
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = G.P_CENTERS.p_rb_celestial_collectors
	end,
	loc_txt = {
		["name"] = "Meteor Tag",
		["text"] = {
			[1] = "Gives a free",
			[2] = "{C:planet}Collectors Celestial Pack"
		},
	},
	apply = function(self, tag, context)
	if context.type == 'new_blind_choice' then
        G.CONTROLLER.locks[tag.ID] = true
        tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
			local key = 'p_rb_celestial_collectors'
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
