	SMODS.Challenge{
        loc_txt = "Poor Quality Products",
        key = 'poor_quality_products',
        rules = {
            custom = {
			{id = 'all_perishable_jokers'},
			{id = 'all_rental_jokers'},
            },
            modifiers = {
            }
        },
        jokers = {
            {id = 'j_credit_card', edition = 'negative'},
        },
        consumeables = {
        },
        vouchers = {
            {id = 'v_overstock_norm'},
			{id = 'v_overstock_plus'},
        },
        deck = {
			type = 'Challenge Deck'
        },
        restrictions = {
            banned_cards = {
                --{id = 'c_devil'},
                {id = 'c_hermit'},
				--{id = 'c_talisman'},
				{id = 'c_immolate'},
				--{id = 'j_ring_master'},
				{id = 'j_midas_mask'},
				--{id = 'v_reroll_surplus'},
				--{id = 'v_reroll_glut'},
				{id = 'v_seed_money'},
				{id = 'v_money_tree'},
            },
            banned_tags = {
				{id = 'tag_investment'},
				{id = 'tag_skip'},
				{id = 'tag_economy'},
            },
            banned_other = {
            }
        }
    }
	
	SMODS.Challenge{
        loc_txt = "Grazzing The Stars",
        key = 'grazzing_the_stars',
        rules = {
            custom = {
			{id = 'no_holos'},
            },
            modifiers = {
			{id = 'hands', value = 3},
			{id = 'joker_slots', value = 6},
            }
        },
        jokers = {
            {id = 'j_supernova', eternal = true},
			{id = 'j_supernova', eternal = true},
        },
        consumeables = {
        },
        vouchers = {
        },
        deck = {
			type = 'Challenge Deck'
        },
        restrictions = {
            banned_cards = { {id = 'j_joker'}, {id = 'j_jolly'}, {id = 'j_zany'}, {id = 'j_mad'}, {id = 'j_crazy'}, {id = 'j_droll'}, {id = 'j_half'}, {id = 'j_ceremonial'}, {id = 'j_mystic_summit'}, {id = 'j_misprint'}, {id = 'j_abstract'}, {id = 'j_gros_michel'}, {id = 'j_ride_the_bus'}, {id = 'j_green_joker'}, {id = 'j_red_card'}, {id = 'j_erosion'}, {id = 'j_fortune_teller'}, {id = 'j_flash'}, {id = 'j_popcorn'}, {id = 'j_trousers'}, {id = 'j_swashbuckler'},
            {id = 'j_greedy_joker'}, {id = 'j_lusty_joker'}, {id = 'j_wrathful_joker'}, {id = 'j_gluttenous_joker'}, {id = 'j_bootstraps'}, {id = 'j_raised_fist'}, {id = 'j_fibonacci'}, {id = 'j_even_steven'}, {id = 'j_scholar'}, {id = 'j_walkie_talkie'}, {id = 'j_smiley'}, {id = 'j_shoot_the_moon'},
			{id = 'c_magician'}, {id = 'c_empress'},
			},
            banned_tags = {
			{id = 'tag_holo'},
            },
            banned_other = {
            }
        }
    }