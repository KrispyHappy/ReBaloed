	SMODS.Joker:take_ownership('obelisk', {
	name = "Obelisk (ReBaloed)",
	loc_txt = {
        ["name"] = "Obelisk",
        ["text"] = {
			[1] = "This Joker gains {X:mult,C:white} X#1# {} Mult",
			[2] = "if hand played isn't your",
			[3] = "most played {C:attention}poker hand{}",
			[4] = "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
        },
    },
	config = { extra = { Xmult_gain = 0.1, Xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for handname, values in pairs(G.GAME.hands) do
                if handname ~= context.scoring_name and values.played >= play_more_than and SMODS.is_poker_hand_visible(handname) then
					card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
					return {
						message = localize('k_upgrade_ex'),
						colour = G.C.MULT,
					}
				end
			end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end})
