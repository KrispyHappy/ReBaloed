--- STEAMODDED HEADER
--- MOD_NAME: ReBaloed
--- MOD_ID: ReBaloed
--- PREFIX: RB
--- MOD_AUTHOR: [Rose and others]
--- MOD_DESCRIPTION: This is a small rebalance mod for Balarto, its aim is to make vouchers more interesting, comically weak jokers and tags more than usable. Big thanks to Frich for teaching me how take_ownership works, Victin, Eremel, Galdur Wizard, GayCoonie for teaching me basics to Balatro modding and troubleshooting. Disclaimer: this mod is work in progress, though the plans aren't big there is more to come, also by the nature of this mod it does make the game generally easier.
local ReBaloed  = SMODS.current_mod
local config = ReBaloed.config
function ReBaloed.save_config(self)
    SMODS.save_mod_config(self)
end

function ReBaloed.config_tab()
local vertical_tabs = {}	
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
	    create_toggle({label = 'Better Tags', ref_table = ReBaloed.config, info = {'Ethereal and Speed tags are changed'}, ref_value = 're_tag', callback = function() ReBaloed:save_config() end}),
        create_toggle({label = 'Change Joker Rarities', info = {'below is enabling or disabling joker reworks'}, ref_table = ReBaloed.config, ref_value = 're_rare', callback = function() ReBaloed:save_config() end}),
        create_toggle({label = 'Credit Card', ref_table = ReBaloed.config, ref_value = 're_credit_card', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Loyalty Card', ref_table = ReBaloed.config, ref_value = 're_loyalty_card', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = '8 Ball', ref_table = ReBaloed.config, ref_value = 're_8_ball', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Delayed Gratification', ref_table = ReBaloed.config, ref_value = 're_delayed_grat', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Square Joker', ref_table = ReBaloed.config, ref_value = 're_square', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Acrobat', info = {'if you change any settings you must restart the game'}, ref_table = ReBaloed.config, ref_value = 're_acrobat', callback = function() ReBaloed:save_config() end})
    }}
end
	if config.re_rare == true then
	SMODS.Joker:take_ownership('runner', {rarity = 2})
	SMODS.Joker:take_ownership('pareidolia', {rarity = 1})
	end
	
	if config.re_tag == true then
	SMODS.Tag:take_ownership('skip', {min_ante = 2, config = {type = 'immediate', skip_bonus = 10}})
	SMODS.Tag:take_ownership('ethereal', {
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
        end
		})
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
            [1] = "{C:green}#1# in #2#{} chance for each played",
            [2] = "{C:attention}8{} to create a {C:tarot}Tarot{} card when",
            [3] = "scored. Failure rate decreases by",
			[4] = "{C:green}1{} for each {C:attention}8{} {C:attention}discarded{}, resets",
			[5] = "when {C:attention}Boss Blind{} is defeated",
			[6] = "{C:inactive}(Must have room)",
        },
    },
	config = {extra= 6},
	calculate = function(self, card, context)
		if context.discard then
			if context.other_card:get_id() == 8 and card.ability.extra > 1 and not context.blueprint then
				card.ability.extra = card.ability.extra - 1
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.GREEN
				}
			end
		return
		elseif context.end_of_round and not (context.individual or context.repetition) then
			if not context.blueprint and card.ability.extra < 6 and G.GAME.blind.boss then
                card.ability.extra = 6
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
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
