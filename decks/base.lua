TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "oops",
	config = {only_one_rank = '6', ante_scaling = 1.6},
	atlas = "decks",
	pos = { x = 0, y = 0},
	apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    assert(SMODS.change_base(card, nil, self.config.only_one_rank))
                end
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
    	if context.final_scoring_step then
    		hand_chips = hand_chips*6
    		mult = math.max(1, mult - (mult % 6))
    		return{
    			chips = 0,
    			mult = 0,
    			message = "Sixed!"
    		}
    	end

    end

}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "kingdom",
	config = {hand_size = -2, no_interest = true},
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "hand" and #args.full_hand >= 5 then
			local yes = true
			for _,card in ipairs(args.full_hand) do
				if not (card.base.value == "Jack" and card.ability.effect == "Gold Card") then
					yes = false
				end
			end
			return yes
		end
	end,
	atlas = "decks",
	pos = { x = 0, y = 1},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				for _, card in ipairs(G.playing_cards) do
					if not card:is_face(false) then
						assert(SMODS.change_base(card, nil, "Jack" ))
					end
				end
			return true
		end
		}))
    end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "storage",
	
	--unlocked = false,
	check_for_unlock = function (self, args)
		if args.type == "modify_deck" and #G.playing_cards > 1 then
			local first = G.playing_cards[1].ability
			
			local ret = true
			for _,card in ipairs(G.playing_cards) do
				
				if not inspect(card.ability) == inspect(first) then
					
					ret = false
				end
				return false
			end
		end
	end,
	atlas = "decks",
	pos = { x = 3, y = 0},
	calculate = function(self, card, context)
		if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual  then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card { key = 'c_hanged_man', edition = "e_negative" }
					SMODS.add_card { key = 'c_hanged_man', edition = "e_negative" }
					return true
				end
			}))
		end
		if context.remove_playing_cards and not G.GAME.blind.in_blind then
			G.E_MANAGER:add_event(Event({
				func = function()
					local newcards = {}
					for i = 1, #context.removed do
						local card = context.removed[i]
						for x = 1, 2 do
							
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
		end
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "shit",
	
	check_for_unlock = function (self,args)
		if os.date("*t").month == 4 and os.date("*t").day == 20 and args.type == "chip_score" and to_number(args.chips) == 69 then
			return true
		end
	end,
	unlocked = false,
	atlas = "decks",
	pos = { x = 2, y = 1},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
            func = function()
                for _,card in ipairs(G.playing_cards) do
                    if card.base.value == "Ace" or card.base.value == "3" then
						assert(SMODS.change_base(card, nil, "2"))
					end
					if card.base.value == "5" or card.base.value == "7" then
						assert(SMODS.change_base(card, nil, "4"))
					end
					if card.base.value == "Jack" or card.base.value == "Queen" then
						assert(SMODS.change_base(card, nil, "6"))
					end
					if card.base.value == "King" or card.base.value == "8" then
						assert(SMODS.change_base(card, nil, "9"))
					end
                    if card.base.value == "10" then
						assert(SMODS.change_base(card, "Hearts", "King"))
					end
                end
                SMODS.add_card { key = 'j_egg' , area = G.consumeables,  stickers = { 'eternal' } }
				SMODS.add_card { key = 'j_obelisk', stickers = { 'eternal' } }
                return true
            end
        }))
	end
}


local flip_ref = Card.update
function Card:update(dt)
	local ret = flip_ref(self,dt)

	if self.ability.SGTMD_PermaFlip and (self.area == G.hand or self.area == G.jokers) and self.flipping ~= "f2b" then
		self.flipping = "f2b"
        self.facing='back'
        self.sprite_facing = 'back'
		self.pinch.x = false
		self.ability.wheel_flipped = true
	end
	return ret
end

local emplace_ref = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
	local ret = emplace_ref(self, card, location, stay_flipped)

	if G.GAME.selected_back.effect.center.key == "b_SGTMD_invisible" and (card.area == G.hand or card.area == G.jokers)  then
		card.ability.SGTMD_PermaFlip = true
	else
		card.ability.SGTMD_PermaFlip = false
	end

	return ret
end

SMODS.Shader{key = "voucher",path = "voucher.fs"}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "invisible",
	retro = true,
	atlas = "modified",
	pos = {x=0,y=5},
	shader = "voucher",
	calculate = function (self, card, context)
		if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual  then
			for x = 1,#G.jokers.cards do
				local c = G.jokers.cards[x]
				c.ability.SGTMD_PermaFlip = false
				c:flip()
			end
		end
		if context.starting_shop then
			for x = 1,#G.jokers.cards do
				local c = G.jokers.cards[x]
				c:flip()
				c.ability.SGTMD_PermaFlip = true
				
			end
		end
		if context.setting_blind and #G.jokers.cards > 0 then
			G.E_MANAGER:add_event(Event({
				func = function()
					local card = copy_card(G.jokers.cards[1], nil)
					card:set_edition({ negative = true }, true)
					card.children.back.sprite_pos = G.jokers.cards[1].children.back.sprite_pos
					card:add_to_deck()
					G.jokers:emplace(card)
					return true
				end
			}))
		end
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "letsgogambling!!!!!",
	
	config = {dollars = 6},
	atlas = "decks",
	pos = { x = 1, y = 3},
	calculate = function (self,card,context)
		if to_number(G.GAME.dollars)<= 0 and G.STATE ~= G.STATES.GAME_OVER then
			G.GAME.blind.config.blind = G.P_BLINDS.bl_SGTMD_deckblind
			G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false 
		end
		
		if context.final_scoring_step then
			
			if math.floor(to_number(hand_chips)/500) > 0 then
				return {dollars = math.floor(to_number(hand_chips)/500) }
			end
		end
		if context.setting_blind then
			if G.GAME.blind.boss then
				G.GAME.SGTMD_GD_B = 7
				
			elseif context.blind == "bl_pvp" then
				G.GAME.SGTMD_GD_B = 10
			else
				G.GAME.SGTMD_GD_B = 5
			end
			if to_number(G.GAME.dollars) - G.GAME.SGTMD_GD_B < 0 then
				G.GAME.SGTMD_GD_B = G.GAME.SGTMD_GD_B - (G.GAME.SGTMD_GD_B - to_number(G.GAME.dollars))
			end
			return { dollars = 0-G.GAME.SGTMD_GD_B}
		end
		if context.end_of_round and not context.individual and not context.repetition then
			return{dollars = G.GAME.SGTMD_GD_B * 2}
		end
	end
}


local cost_ref = Card.set_cost
function Card:set_cost()
	local ret = cost_ref(self)
	if not G.GAME.selected_back then return ret end
	if (self.ability.set == 'Joker' or (self.ability.set == 'Booster' and self.ability.name:find('Buffoon'))) and (G.GAME.selected_back.effect.center.key == "b_SGTMD_Joker" or G.GAME.selected_sleeve == "sleeve_SGTMD_joker" ) then self.cost = 0 end
	
	return ret
end

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "Joker",
	
	config = {hands = -2, joker_slot = 2},
	atlas = "decks",
	pos = { x = 4, y = 2},
	apply = function (self)
		local banned = {
			'p_celestial_normal_1','p_celestial_normal_2',"p_celestial_normal_3","p_celestial_normal_4","p_celestial_jumbo_1","p_celestial_jumbo_2","p_celestial_mega_1","p_celestial_mega_2"
		,'p_standard_normal_1','p_standard_normal_2',"p_standard_normal_3","p_standard_normal_4","p_standard_jumbo_1","p_standard_jumbo_2","p_standard_mega_1","p_standard_mega_2"
		,'p_arcana_normal_1','p_arcana_normal_2',"p_arcana_normal_3","p_arcana_normal_4","p_arcana_jumbo_1","p_arcana_jumbo_2","p_arcana_mega_1","p_arcana_mega_2"
		,'p_spectral_normal_1','p_spectral_normal_2',"p_spectral_jumbo_1","p_spectral_mega_1",
		"v_tarot_merchant","v_tarot_tycoon","v_planet_merchant","v_planet_tycoon","v_telescope","v_observatory","v_crystal_ball","v_omen_globe"}
		for k,v in ipairs(banned) do
			G.GAME.banned_keys[v] = true
		end

		G.E_MANAGER:add_event(Event({func = function()
            G.GAME.tarot_rate = 0
			G.GAME.planet_rate = 0
			return true 
		end }))
	end

}



TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "throwback",
	loc_txt = {
		name = "Retro Deck",
		text = {
			"Skipping blinds creates 2 random tags",
			"Skipping enters the shop",
			"{C:white,X:mult}X1.5{} Base blind size"
		}
	},  
	config = {ante_scaling = 1.5},
	atlas = "decks",
	pos = { x = 5, y = 2},
	calculate = function (self,card,context)
		
		if context.skip_blind then
			
			for x=1 ,2 do
				local _pool, _pool_key = get_current_pool('Tag', nil, nil, "retro")
				local _tag = pseudorandom_element(_pool, pseudoseed(_pool_key))
				local it = 1
				while _tag == 'UNAVAILABLE' do
					it = it + 1
					_tag = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
				end
				add_tag(Tag(_tag))
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'before', delay = 0.2,
				func = function()
				  G.blind_prompt_box.alignment.offset.y = -10
				  G.blind_select.alignment.offset.y = 40
				  G.blind_select.alignment.offset.x = 0
				  return true
			end}))
			G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			func = function()
				G.blind_select:remove()
				G.blind_prompt_box:remove()
				G.blind_select = nil
				return true
			end}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = .9,
				func = function()
					-- G.blind_select:remove()
					-- G.blind_prompt_box:remove()

					G.GAME.current_round.jokers_purchased = 0
					G.STATE = G.STATES.SHOP
					G.GAME.shop_free = nil
					G.GAME.shop_d6ed = nil
					G.STATE_COMPLETE = false
					
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 1.4,
						func = function()
							for i = 1, #G.GAME.tags do
								if G.GAME.tags[i]:apply_to_run({type = 'new_blind_choice'}) then break end
							end
							return true
						end,
					}))
					return true
				end,
			}))
		end
		
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "chaos",
	atlas = "decks",
	pos = {x=5,y=5},
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if created_card or forced_key or legendary then return end
		local types = {
			"Joker",
			"Enhanced",
			"Base",
			"Joker" -- make jokers more likely
		}
		local _types = {
			Joker = "Joker",
			Enhanced = "Enhanced",
			Base = "Base"
		}
		for k,v in pairs(SMODS.ConsumableTypes) do
			if k ~= "Unique" and k ~= "paint" then -- remove cryptids unique and TMD's paint cards
				_types[k] = k
				types[#types+1] = k
			end
		end
		
		if _types[_type]then
			_type = pseudorandom_element(types,pseudoseed("sgtmd_metamorphasis"))
		end

		return {_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append}
	end
}



TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "order",
	atlas = "decks",
	pos = {x=7,y=5},
	apply = function (self, back)
		G.GAME.TMDORDER = 1
		G.GAME.TMDORDERLEG = false
	end,
	calculate = function (self, back, context)
		if context.buying_card then
			if context.card.config.center.rarity == 4 then
				G.E_MANAGER:add_event(Event({
            	func = function()
				ease_dollars(-30 - G.GAME.dollars, true)
                return true
            	end
       		 }))
				
				G.GAME.TMDORDERLEG = true
			end
		end
	end,
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if created_card or _type ~= "Joker" or forced_key then return nil end
		local yc = G.P_CENTER_POOLS.Joker
		
		if area == G.shop_jokers then
		
		while  (type(yc[G.GAME.TMDORDER].rarity) ~= "number" or yc[G.GAME.TMDORDER].rarity > ((G.GAME.TMDORDERLEG and 3) or 4))  do
			G.GAME.TMDORDER = G.GAME.TMDORDER+1
			if G.GAME.TMDORDER > #yc then G.GAME.TMDORDER = 1 end
		end
		
		forced_key = yc[G.GAME.TMDORDER].key

		G.GAME.TMDORDER = G.GAME.TMDORDER+1
		if G.GAME.TMDORDER > #yc then G.GAME.TMDORDER = 1 end
		else return nil end

		return {_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append}
		
	end
}





TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "contract",
	retro = true,
	atlas = "modified",
	pos = {x=0,y=0},
	calculate = function (self, back, context)
		if context.retrigger_joker_check and not context.retrigger_joker then
			if context.other_card == G.jokers.cards[1] then
				return {
					message = "Again!",
					colour = G.C.BLUE,
					repetitions = 1,
					message_card = card
				}
			end
		end
	end,
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if created_card or _type ~= "Joker" then return nil end
		if _type == "Joker" and (next(SMODS.find_card("j_ring_master")) or (not next(SMODS.find_card("j_blueprint",true)))) and not forced_key then
			if  pseudorandom("Contractor") <= 0.05 then
				forced_key = "j_blueprint"
				return {_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append}
			else

				return nil
			end
			else
				return nil
			end


		
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "champ",
	retro = true,
	atlas = "modified",
	pos = {x=2,y=0},
	loc_vars = function (self, info_queue, card)
		local wins = G.PROFILES[G.SETTINGS.profile].SGTMD_wins or 0
		return {vars = {wins*2,(wins*0.5)+1,wins,wins~=1 and "s" or ""}}
	end,
	apply = function (self, back)
		G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + (G.PROFILES[G.SETTINGS.profile].SGTMD_wins or 0)*2
		G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + (G.PROFILES[G.SETTINGS.profile].SGTMD_wins or 0)
	end,
	calculate = function (self, back, context)
		if context.win then
			G.GAME.SGTMD_WON = true
			G.PROFILES[G.SETTINGS.profile].SGTMD_wins = (G.PROFILES[G.SETTINGS.profile].SGTMD_wins or 0) + 1
			G:save_progress()
		end
		if context.end_of_round and context.game_over then
			if not G.GAME.SGTMD_WON then
			G.PROFILES[G.SETTINGS.profile].SGTMD_wins =  0
			G:save_progress()
			end
		end
		if context.final_scoring_step then
			return {
				xmult = (G.PROFILES[G.SETTINGS.profile].SGTMD_wins or 0)*0.5+1
			}
		end
		
	end
}


TMD.Decks[#TMD.Decks+1] = SMODS.Back{
	key = "vanity",
	atlas = "modified",
	retro = true,
	config = {discards = -1},
	pos = {x=2,y=6},
	calculate = function (self,card,context)
		if context.remove_playing_cards then
			G.consumeables:change_size(#context.removed)
			return {
				dollars = -5*#context.removed
			}
		end
	end
}