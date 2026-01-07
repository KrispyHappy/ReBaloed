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
