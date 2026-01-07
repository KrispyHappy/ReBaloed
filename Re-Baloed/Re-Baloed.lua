--- STEAMODDED HEADER
--- MOD_NAME: ReBaloed
--- MOD_ID: ReBaloed
--- PREFIX: rb
--- MOD_AUTHOR: [Rose]
--- MOD_DESCRIPTION: This is a rebalance mod for Balatro, its aim is to make comically weak jokers and tags more than usable by changing their abilities, along with preserving the vanilla game design. Big thanks to Frich for teaching me how take_ownership works, and the Balatro modding community for teaching me basics of modding and troubleshooting.				 All the code within this mod can be used, if you feel that the context my code is used in is too similar i ask that I'm credited :)				This mod has custom challenges to show off the joker changes! Install the challenger deep mod to play them.
local ReBaloed  = SMODS.current_mod
local config = ReBaloed.config

if (SMODS.Mods.ChDp or {}).can_load then
assert(SMODS.load_file("challenges.lua"))()
end

if SMODS.Atlas then
SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
})
end

function ReBaloed.save_config(self)
    SMODS.save_mod_config(self)
end

function ReBaloed.config_tab()
local vertical_tabs = {}	
    return {n=G.UIT.ROOT, config = {padding = 0.0, colour = G.C.BLACK}, nodes = {
		{n = G.UIT.C, config = { align = "cl", minw = G.ROOM.T.w*0, padding = 0.04 }, nodes = {
        create_toggle({label = 'Credit Card', detailed_tooltip = {title = "pussy", text = {"Line1", "Line2"}}, ref_table = ReBaloed.config, ref_value = 're_credit_card', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Loyalty Card', ref_table = ReBaloed.config, ref_value = 're_loyalty_card', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = '8 Ball', ref_table = ReBaloed.config, ref_value = 're_8_ball', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Misprint', detailed_tooltip = {'test yay'}, ref_table = ReBaloed.config, ref_value = 're_print', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Delayed Grat', ref_table = ReBaloed.config, ref_value = 're_delayed_grat', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Supernova', ref_table = ReBaloed.config, ref_value = 're_nova', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Square Joker', ref_table = ReBaloed.config, ref_value = 're_square', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Séance', ref_table = ReBaloed.config, ref_value = 're_seance', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Acrobat', ref_table = ReBaloed.config, ref_value = 're_acrobat', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'The Idol', ref_table = ReBaloed.config, ref_value = 're_idol', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Golden Joker', ref_table = ReBaloed.config, ref_value = 're_golden', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Flower Pot', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_weed', callback = function() ReBaloed:save_config() end})
    }},
    {n = G.UIT.C, config = { align = "cm", minw = G.ROOM.T.w*0, padding = 0.04 }, nodes = {
		create_toggle({label = 'Standard Tag', ref_table = ReBaloed.config, ref_value = 're_stand', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Charm Tag', ref_table = ReBaloed.config, ref_value = 're_charm', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Meteor Tag', ref_table = ReBaloed.config, ref_value = 're_meteor', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Ethereal Tag', ref_table = ReBaloed.config, ref_value = 're_ethereal', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Garbage Tag', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_garbage', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Top-up Tag', ref_table = ReBaloed.config, ref_value = 're_top', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Speed Tag', info = {'Red nodes may conflict, restart needed'}, active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_speed', callback = function() ReBaloed:save_config() end})
	}},
	{n = G.UIT.C, config = { align = "cr", minw = G.ROOM.T.w*0, padding = 0.04 }, nodes = {
	    create_toggle({label = 'Joker Rarities', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_rare', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Joker Costs', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_pj', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Voucher Costs', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_voc', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Pack Costs', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_spc', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Ouija Rework', ref_table = ReBaloed.config, ref_value = 're_ouija', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Hex Rework',  ref_table = ReBaloed.config, ref_value = 're_hex', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Double Lovers', active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_d_lovers', callback = function() ReBaloed:save_config() end}),
		create_toggle({label = 'Tag Appearance', info = {'Blue nodes are mod friendly, restart needed'}, active_colour = G.C.BLUE, ref_table = ReBaloed.config, ref_value = 're_a_tag', callback = function() ReBaloed:save_config() end})
	}},
	}}
end
if config.re_stand == true or config.re_charm == true or config.re_meteor == true then
SMODS.Atlas {
	key = "ReBaloed_Boosters",
	path = "boosters.png",
	px = 71,
	py = 95
}
end

if config.re_stand == true then
assert(SMODS.load_file('content/standard_collectors.lua'))()
end
if config.re_charm == true then
assert(SMODS.load_file('content/arcana_collectors.lua'))()
end
if config.re_meteor == true then
assert(SMODS.load_file('content/celestial_collectors.lua'))()
end
if config.re_ouija == true then
assert(SMODS.load_file('content/ouija.lua'))()
end
if config.re_hex == true then
assert(SMODS.load_file('content/hex.lua'))()
end
if config.re_ethereal == true then
assert(SMODS.load_file('content/ethereal.lua'))()
end
if config.re_top == true then
assert(SMODS.load_file('content/top_up.lua'))()
end
if config.re_credit_card == true then
assert(SMODS.load_file('jokers/credit_card.lua'))()
end
if config.re_loyalty_card == true then
assert(SMODS.load_file('jokers/loyalty_card.lua'))()
end
if config.re_square == true then
assert(SMODS.load_file('jokers/square.lua'))()
end
if config.re_seance == true then
assert(SMODS.load_file('jokers/seance.lua'))()
end
if config.re_8_ball == true then
assert(SMODS.load_file('jokers/8_ball.lua'))()
end
if config.re_delayed_grat == true then
assert(SMODS.load_file('jokers/delayed_grat.lua'))()
end
if config.re_nova == true then
assert(SMODS.load_file('jokers/supernova.lua'))()
end
if config.re_acrobat == true then
assert(SMODS.load_file('jokers/acrobat.lua'))()
end
if config.re_idol == true then
assert(SMODS.load_file('jokers/idol.lua'))()
end
if config.re_print == true then
assert(SMODS.load_file('jokers/misprint.lua'))()
end
if config.re_golden == true then
assert(SMODS.load_file('jokers/golden.lua'))()
end

if config.re_weed == true then
	G.P_CENTERS.j_flower_pot.config.extra = 4
end

if config.re_rare == true then
	G.P_CENTERS.j_runner.rarity = 2
	G.P_CENTERS.j_pareidolia.rarity = 1
	G.P_CENTERS.j_smeared.rarity = 1
	G.P_CENTERS.j_obelisk.rarity = 2
	G.P_CENTERS.j_dusk.rarity = 1
	SMODS.remove_pool(G.P_JOKER_RARITY_POOLS[3], 'j_obelisk')
	SMODS.insert_pool(G.P_JOKER_RARITY_POOLS[2], G.P_CENTERS['j_obelisk'])
	SMODS.remove_pool(G.P_JOKER_RARITY_POOLS[2], 'j_pareidolia')
	SMODS.insert_pool(G.P_JOKER_RARITY_POOLS[1], G.P_CENTERS['j_pareidolia'])
	SMODS.remove_pool(G.P_JOKER_RARITY_POOLS[2], 'j_smeared')
	SMODS.insert_pool(G.P_JOKER_RARITY_POOLS[1], G.P_CENTERS['j_smeared'])
	SMODS.remove_pool(G.P_JOKER_RARITY_POOLS[1], 'j_runner')
	SMODS.insert_pool(G.P_JOKER_RARITY_POOLS[2], G.P_CENTERS['j_runner'])
	SMODS.remove_pool(G.P_JOKER_RARITY_POOLS[2], 'j_dusk')
	SMODS.insert_pool(G.P_JOKER_RARITY_POOLS[1], G.P_CENTERS['j_dusk'])
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
	G.P_CENTERS.j_joker.cost = 1
	G.P_CENTERS.j_zany.cost = 3
	G.P_CENTERS.j_mad.cost = 3
	G.P_CENTERS.j_crazy.cost = 3
	G.P_CENTERS.j_droll.cost = 3
	G.P_CENTERS.j_wily.cost = 3
	G.P_CENTERS.j_clever.cost = 3
	G.P_CENTERS.j_devious.cost = 3
	G.P_CENTERS.j_crafty.cost = 3
	G.P_CENTERS.j_splash.cost = 1
	G.P_CENTERS.j_red_card.cost = 2
	G.P_CENTERS.j_mail.cost = 6
	G.P_CENTERS.j_diet_cola.cost = 12
	G.P_CENTERS.j_hanging_chad.cost = 6
	G.P_CENTERS.j_pareidolia.cost = 3
	G.P_CENTERS.j_smeared.cost = 4
	G.P_CENTERS.j_constellation.cost = 8
	G.P_CENTERS.j_ring_master.cost = 2
	G.P_CENTERS.j_satellite.cost = 4
end
	
if config.re_spc == true then
	G.P_CENTERS.p_spectral_normal_1.cost = 5
	G.P_CENTERS.p_spectral_normal_2.cost = 5
	G.P_CENTERS.p_spectral_jumbo_1.cost = 7
	G.P_CENTERS.p_spectral_mega_1.cost = 9
	G.P_CENTERS.p_standard_normal_1.cost = 3
	G.P_CENTERS.p_standard_normal_2.cost = 3
	G.P_CENTERS.p_standard_normal_3.cost = 3
	G.P_CENTERS.p_standard_normal_4.cost = 3
	G.P_CENTERS.p_standard_jumbo_1.cost = 5
	G.P_CENTERS.p_standard_jumbo_2.cost = 5
	G.P_CENTERS.p_standard_mega_1.cost = 7
	G.P_CENTERS.p_standard_mega_2.cost = 7
end

if config.re_voc == true then
	G.P_CENTERS.v_directors_cut.cost = 5
	G.P_CENTERS.v_magic_trick.cost = 5
	G.P_CENTERS.v_blank.cost = 5
	G.P_CENTERS.v_antimatter.cost = 15
	G.P_CENTERS.v_petroglyph.cost = 15
end

if config.re_d_lovers == true then
	G.P_CENTERS.c_lovers.config.max_highlighted = 2
end
	
if config.re_speed == true then
	G.P_TAGS.tag_skip.config.skip_bonus = 10
end

if config.re_garbage == true then
	G.P_TAGS.tag_garbage.config.dollars_per_discard = 2
end
