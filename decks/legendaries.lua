
TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "perkeo",
	atlas = "legendary",
	pos = {x=0,y=0},
	float_pos = {x=0,y=1},
	float2 = {x=0,y=2},
	calculate = function (self, back, context)
		if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual then
			G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
		end
	end,
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if created_card then
			if not created_card.edition and _type == "Joker" and pseudorandom("sgtmdperk") < 1/40 then
				created_card:set_edition({negative=true})
			end
		else
			if not forced_key and area == G.pack_cards and _type == "Tarot" and pseudorandom("sgtmdperks") < 1/20 then
				forced_key = "c_soul"
				return {_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append}
			end
		end
		
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "chicot",
	atlas = "legendary",
	pos = {x=1,y=0},
	float_pos = {x=1,y=1},
	float2 = {x=1,y=2},
	config = {vouchers = {"v_clearance_sale"},ante_scaling = 0.75},
	apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
				local ante_UI = G.hand_text_area.ante
				G.GAME.round_resets.ante = 0
				G.GAME.round_resets.ante_disp = number_format(G.GAME.round_resets.ante)
				ante_UI.config.object:update()
				G.HUD:recalculate()
                return true
            end
        }))
		
    end,
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if created_card then
		else
			if not forced_key and area == G.pack_cards and _type == "Tarot" and pseudorandom("sgtmdperks") < 1/20 then
				forced_key = "c_soul"
				return {_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append}
			end
		end
		
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "caino",
	atlas = "legendary",
	pos = {x=2,y=0},
	float_pos = {x=2,y=1},
	float2 = {x=2,y=2},
	config = {},
	apply = function(self)
		
		G.E_MANAGER:add_event(Event({
            func = function()
            	local newcards = {}
                for i = 1, #G.playing_cards do
					local card = G.playing_cards[i]
					if card:is_face(true) then
					
						card:set_ability(G.P_CENTERS.m_glass,true)

                    local _card = copy_card(card, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.deck:emplace(_card)
                    
					end
                end
                return true
            end
        }))
    end,
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if created_card then
		else
			if not forced_key and area == G.pack_cards and _type == "Tarot" and pseudorandom("sgtmdperks") < 1/20 then
				forced_key = "c_soul"
				return {_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append}
			end
		end
		
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "triboulet",
	atlas = "legendary",
	pos = {x=3,y=0},
	float_pos = {x=3,y=1},
	float2 = {x=3,y=2},
	config = {hand_size = -1},
	calculate =function (self, back, context)
		if context.repetition and G.GAME.current_round.hands_left == 0 and context.other_card:is_face() and context.cardarea == G.play then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1
                    }
                end
	end,
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if created_card then
		else
			if not forced_key and area == G.pack_cards and _type == "Tarot" and pseudorandom("sgtmdperks") < 1/20 then
				forced_key = "c_soul"
				return {_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append}
			end
		end
		
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "yorick",
	atlas = "legendary",
	pos = {x=4,y=0},
	float_pos = {x=4,y=1},
	float2 = {x=4,y=2},
	config = { discards = 1, joker_slot = -1},
	calculate = function (self, back, context)
		if not G.GAME.SGTMDBACKmult then G.GAME.SGTMDBACKmult = 1 end
		if context.discard then
			G.GAME.SGTMDBACKmult = G.GAME.SGTMDBACKmult+ 0.25
		end
		if context.final_scoring_step then
			return {
				xmult = G.GAME.SGTMDBACKmult or 1
			}
		end
		if context.end_of_round and not context.individual and not context.repetition then
			G.GAME.SGTMDBACKmult = 1
			return {
				card = back,
				message = "Reset!"
			}
		end
		
	end,
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if created_card then
		else
			if not forced_key and area == G.pack_cards and _type == "Tarot" and pseudorandom("sgtmdperks") < 1/20 then
				forced_key = "c_soul"
				return {_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append}
			end
		end
		
	end
}