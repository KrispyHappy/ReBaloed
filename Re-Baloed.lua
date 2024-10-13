--- STEAMODDED HEADER
--- MOD_NAME: ReBaloed
--- MOD_ID: ReBaloed
--- PREFIX: RB
--- MOD_AUTHOR: [Rose and others]
--- MOD_DESCRIPTION: This is a small rebalance mod for Balarto, its aim is to make vouchers more interesting, comically weak jokers and tags more than usable. Big thanks to Frich for teaching me how take_ownership works, Victin, Eremel, Galdur Wizard, GayCoonie and a bunch of other people i don't remember to mention for teaching me basics to Balatro modding and troubleshooting. All the code within this mod can be used, if you feel that the context my code is used in is too similar i ask that I'm created :)
local ReBaloed  = SMODS.current_mod
local config = ReBaloed.config
function ReBaloed.save_config(self)
    SMODS.save_mod_config(self)
end

function ReBaloed.config_tab()
local vertical_tabs = {}	
    return {n=G.UIT.ROOT, config = {padding = 0.0, colour = G.C.BLACK}, nodes = {
		{n = G.UIT.C, config = { align = "cl", minw = G.ROOM.T.w*0, padding = 0.04 }, nodes = {
        create_toggle({label = 'Credit Card', detailed_tooltip = {'test yay'}, ref_table = ReBaloed.config, ref_value = 're_credit_card', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Loyalty Card', ref_table = ReBaloed.config, ref_value = 're_loyalty_card', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = '8 Ball', ref_table = ReBaloed.config, ref_value = 're_8_ball', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Delayed Grat', ref_table = ReBaloed.config, ref_value = 're_delayed_grat', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Supernova', ref_table = ReBaloed.config, ref_value = 're_nova', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Square Joker', ref_table = ReBaloed.config, ref_value = 're_square', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Acrobat', ref_table = ReBaloed.config, ref_value = 're_acrobat', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'The Idol', ref_table = ReBaloed.config, ref_value = 're_idol', callback = function() ReBaloed:save_config() end})
    }},
	{n = G.UIT.C, config = { align = "cr", minw = G.ROOM.T.w*0.25, padding = 0.04 }, nodes = {
	    create_toggle({label = 'Change Joker Rarities', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_rare', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Change Prices', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_pj', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Ouija Rework', ref_table = ReBaloed.config, ref_value = 're_ouija', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Hex Rework', ref_table = ReBaloed.config, ref_value = 're_hex', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Double Lovers', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_d_lovers', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Buff Speed Tag', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_speed', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Buff Ethereal Tag', ref_table = ReBaloed.config, ref_value = 're_ethereal', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Change Tag Appearance', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_a_tag', callback = function() ReBaloed:save_config() end})
	}},
	}}
end

	if config.re_rare == true then
	G.P_CENTERS.j_runner.rarity = 2
	G.P_CENTERS.j_pareidolia.rarity = 1
	G.P_CENTERS.j_smeared.rarity = 1
	G.P_CENTERS.j_obelisk.rarity = 2
	end
	
	if config.re_a_tag == true then
	G.P_TAGS.tag_skip.min_ante = 3
	G.P_TAGS.tag_juggle.min_ante = 3
	G.P_TAGS.tag_economy.min_ante = 2
	G.P_TAGS.tag_boss.min_ante = 3
	G.P_TAGS.tag_voucher.min_ante = 2
	G.P_TAGS.tag_handy.min_ante = 3
	G.P_TAGS.tag_garbage.min_ante = 3
	G.P_TAGS.tag_d_six.min_ante = 2
	end
	
	if config.re_pj == true then
	G.P_CENTERS.j_splash.cost = 1
	G.P_CENTERS.j_red_card.cost = 2
	G.P_CENTERS.j_mail.cost = 6
	G.P_CENTERS.j_diet_cola.cost = 12
	G.P_CENTERS.j_pareidolia.cost = 3
	G.P_CENTERS.j_smeared.cost = 4
	G.P_CENTERS.j_constellation.cost = 8
	G.P_CENTERS.j_ring_master.cost = 2
	
	G.P_CENTERS.v_blank.cost = 5
	G.P_CENTERS.v_antimatter.cost = 15
	
	G.P_CENTERS.p_spectral_normal_1.cost = 6
	G.P_CENTERS.p_spectral_normal_2.cost = 6
	G.P_CENTERS.p_spectral_jumbo_1.cost = 8
	G.P_CENTERS.p_spectral_mega_1.cost = 10
	end
	
	
	if config.re_d_lovers == true then
	G.P_CENTERS.c_lovers.config.max_highlighted = 2
	end
	
	if config.re_speed == true then
	G.P_TAGS.tag_skip.config.skip_bonus = 10
	end
	
	if config.re_ethereal == true then
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
	apply = function(tag, context)
        tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
            local key = 'p_spectral_mega_1'
            local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
            G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
            card.cost = 0
            card.from_tag = true
            G.FUNCS.use_card({config = {ref_table = card}})
            card:start_materialize()
            G.CONTROLLER.locks[tag.ID] = nil
            return true
            end)
            tag.triggered = true
            return true
        end})
	end
	
	if config.re_ouija == true then
	SMODS.Consumable:take_ownership('ouija', {
	loc_txt = {
        ["name"] = "Ouija",
        ["text"] = {
            [1] = "Converts up to {C:attention}4{}",
            [2] = "selected cards to a",
			[3] = "single random {C:attention}rank",
        },
    },
	config = {max_highlighted = 4},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
    use = function(self)
		local _rank = pseudorandom_element({'2','3','4','5','6','7','8','9','T','J','Q','K','A'}, pseudoseed('ouija'))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);
            return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                card = G.hand.highlighted[i]
                suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                rank_suffix =_rank
                card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3);
            return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end }))
        delay(0.5)
    end,
	can_use = function(self, card, any_state, skip_check)
		if card.ability.consumeable.mod_num >= #G.hand.highlighted and #G.hand.highlighted >= (card.ability.consumeable.min_highlighted or 1) then
			return true
		end
	end})
	end
	
	if config.re_hex == true then
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
	end
	
	if config.re_credit_card == true then
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
		if context.end_of_round and G.GAME.blind.boss and G.GAME.dollars < 0 then
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				if G.GAME.dollars ~= 0 then
					card:juice_up()
					ease_dollars(-G.GAME.dollars, true)
				end
			return true end }))
		end
	end})
	end
	
	if config.re_loyalty_card == true then
	SMODS.Joker:take_ownership('loyalty_card', {
	loc_txt = {
        ["name"] = "Loyalty Card",
        ["text"] = {
            [1] = "Every {C:attention}3{} hands this",
            [2] = "gives {X:mult,C:white}X#1#{} Mult and {C:money}$3{}",
			[3] = "{C:inactive}(#3#){}"
        },
    },
	config = {extra = {Xmult = 3, every = 2, remaining = "2 remaining"}},
	cost = 8,
	calculate = function(self, card, context)
		if context.joker_main then
			if card.ability.loyalty_remaining == 0 then
			card:juice_up()
			ease_dollars(3, true)
		   end
		end
	end})
	SMODS.Joker:take_ownership('square', {
	loc_txt = {
        ["name"] = "Square Joker",
        ["text"] = {
            [1] = "This Joker gains {C:blue}+#2#{} chips for",
            [2] = "every {C:attention}played hand{} and {C:attention}discard{}",
            [3] = "that are exactly {C:attention}4{} cards",
			[4] = "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}",
        },
    },
	rarity = 2,
	calculate = function(self, card, context)
		if context.discard then
			if context.other_card == context.full_hand[#context.full_hand] and not context.blueprint then
					local square_cards = 0
					for k, v in ipairs(context.full_hand) do
						square_cards = square_cards + 1
					end
					if square_cards == 4 then
						card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
						return {
							message = localize('k_upgrade_ex'),
							colour = G.C.CHIPS
						}
					end
				return
			end
		end
    end})
	end
	
	if config.re_8_ball == true then
	SMODS.Joker:take_ownership('8_ball', {
	loc_txt = {
        ["name"] = "8 Ball",
        ["text"] = {
            [1] = "After an {C:attention}8{} is",
			[2] = "discarded next played {C:attention}8{}",
			[3] = "creates a {C:tarot}Tarot{} card",
			[4] = "{C:inactive}(Must have room)",
        },
    },
	config = {extra = 99999},
	calculate = function(self, card, context)
		if context.discard then
			if context.other_card:get_id() == 8 then
				ball_ready = 1
				local eval = function() return ball_ready == 1 end
				juice_card_until(card, eval, true)
			end
		end
		if context.individual and context.cardarea == G.play then
			if (context.other_card:get_id() == 8) and ball_ready == 1 then
				ball_ready = 0
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
	end})
	end
	
	if config.re_delayed_grat == true then
	SMODS.Joker:take_ownership('delayed_grat', {
	loc_txt = {
        ["name"] = "Delayed Gratification",
        ["text"] = {
            [1] = "At end of each round earn",
            [2] = "{C:money}$#1#{} per remaining {C:red}Discard{}",
        },
    },
	calc_dollar_bonus = function(self, card)
        if G.GAME.current_round.discards_left > 0 then
            return G.GAME.current_round.discards_left*card.ability.extra
        end
    end})
	end
	
	if config.re_nova == true then
	SMODS.Joker:take_ownership('supernova', {
	loc_txt = {
        ["name"] = "Supernova",
        ["text"] = {
            [1] = "Add {C:red}Mult{} to played",
			[2] = "{C:attention}poker hand{} equal to",
            [3] = "the number of times its",
			[4] = "been played this run",
        },
    },
	calculate = function(self, card, context)
		if context.before then
			G.GAME.hands[context.scoring_name].mult = G.GAME.hands[context.scoring_name].mult + G.GAME.hands[context.scoring_name].played
			mult = mod_mult(G.GAME.hands[context.scoring_name].mult)
			update_hand_text({delay = 0}, {mult = mult})
			return {
			message = localize{type='variable',key='a_mult',vars={G.GAME.hands[context.scoring_name].played}},
			colour = G.C.MULT
			}
		end
		if context.joker_main then
			return {
			message = 'Hand Played',
			colour = nil
			}
		end
		if context.after then
			G.GAME.hands[context.scoring_name].mult = G.GAME.hands[context.scoring_name].mult - G.GAME.hands[context.scoring_name].played
		end
	end
	})
	end
	
	if config.re_acrobat == true then
	SMODS.Joker:take_ownership('acrobat', {
	loc_txt = {
        ["name"] = "Acrobat",
        ["text"] = {
            [1] = "{X:red,C:white} X#1# {} Mult on {C:attention}final",
            [2] = "{C:attention}hand{} of round or next",
			[3] = "{C:attention}played hand{} after",
			[4] = "{C:attention}final discard{} of round",
        },
    },
	calculate = function(self, card, context)
	  if not context.blueprint then
		if G.GAME.current_round.discards_left > 0 then
			acrobat_trigger = true
		end
		if G.GAME.current_round.discards_left == 0 and acrobat_trigger == true then
			acrobat_trigger = false
			acrobat_ready = 1
			local eval = function() return (acrobat_ready == 1) end
            juice_card_until(card, eval, true)
			return
		end
	  end
		if context.joker_main and acrobat_ready == 1 then
			acrobat_ready = 0
		    return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra}},
                Xmult_mod = card.ability.extra
            }
		end
	end})
	end
	
	if config.re_idol == true then
	SMODS.Joker:take_ownership('idol', {
	--loc_vars = function(self) return {vars = {self.ability.extra, localize(G.GAME.current_round.idol_card.rank, 'ranks')}} end,
	loc_txt = {
        ["name"] = "The Idol",
        ["text"] = {
            [1] = "Each played {C:attention}#2#",
            [2] = "gives {X:mult,C:white} X#1# {} Mult",
            [3] = "when scored",
            [4] = "{s:0.75}Rank changes every round",
        },
    },
	calculate = function(self, card, context)
	if context.individual and context.cardarea == G.play then
	    if context.other_card:get_id() == G.GAME.current_round.idol_card.id then		
            return {
                x_mult = card.ability.extra,
                colour = G.C.RED,
				card = card
            }
        end
	  end
	end})
	end
