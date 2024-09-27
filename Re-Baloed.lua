--- STEAMODDED HEADER
--- MOD_NAME: ReBaloed
--- MOD_ID: ReBaloed
--- MOD_AUTHOR: [Rose and others]
--- MOD_DESCRIPTION: This is a small rebalance mod for Balarto, its aim is to make vouchers more interesting and comically weak jokers more than usable. Big thanks to Frich for teaching me how take_ownership works, Victin and Eremel, Galdur Wizard for teaching me some basics to Balatro modding and troubleshooting. Disclaimer: this mod is work in progress, though the plans aren't big there is more to come, also by the nature of this mod it does make the game generally easier by making jokers better and more versatility from vouchers. 
----------------------------------------------
------------MOD CODE -------------------------
function SMODS.INIT.ReBaloed()
local ReBaloed = SMODS.findModByID('ReBaloed')
local card = self
	SMODS.Joker:take_ownership('credit_card', {
	loc_txt = {
        ["name"] = "Credit Card",
        ["text"] = {
            [1] = "Go up to {C:red}-$#1#{} in debt.",
            [2] = "When {C:attention}Boss Blind{} is defeated,",
			[3] = "remove all debt"
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
	  end
	})
	SMODS.Joker:take_ownership('loyalty_card', {
	loc_txt = {
        ["name"] = "Loyalty Card",
        ["text"] = {
            [1] = "Every {C:attention}4{} hands this Joker",
            [2] = "gives {X:mult,C:white}X#1#{} Mult and {C:money}$3{}",
			[3] = "{C:inactive}(#3#){}"
        },
    },
	config = {extra = {Xmult = 3, every = 3, remaining = "3 remaining"}},
	cost = 8,
	calculate = function(self, card, context)
		if context.before then
			if card.ability.loyalty_remaining == 0 then
			card:juice_up()
			ease_dollars(3, true)
		   end
		end
	end
	})
	SMODS.Joker:take_ownership('square', {
	loc_txt = {
        ["name"] = "Square Joker",
        ["text"] = {
            [1] = "This Joker gains {C:blue}+4{} chips for",
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
    end
	})
	SMODS.Joker:take_ownership('8_ball', {
	loc_txt = {
        ["name"] = "8 Ball",
        ["text"] = {
            [1] = "{C:green}#1# in #2#{} chance for each played",
            [2] = "{C:attention}8{} to create a {C:tarot}Tarot{} card when",
            [3] = "scored. failure rate decreases by",
			[4] = "{C:green}1{} when an {C:attention}8{} is {C:attention}discarded{}, Resets",
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
	end
	})
end
----------------------------------------------
------------MOD CODE END----------------------
