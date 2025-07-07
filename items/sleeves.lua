
    --Change name of cards depending on deck+sleeve combo (thanks cryptid)
    local gcui = generate_card_ui
    function generate_card_ui(
        _c,
        full_UI_table,
        specific_vars,
        card_type,
        badges,
        hide_desc,
        main_start,
        main_end,
        card
    )
        local full_UI_table =
            gcui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
        if
            card
            and G.GAME.selected_back.effect.center.key == "b_SGTMD_oops"
            and G.GAME.selected_sleeve == "sleeve_SGTMD_oops"
            and full_UI_table.name
            and type(full_UI_table.name) == "table"
            and full_UI_table.name[1].nodes
            and full_UI_table.name[1].nodes[1].config
            and full_UI_table.name[1].nodes[1].config.object
            and full_UI_table.name[1].nodes[1].config.object.config
        then

            local conf = full_UI_table.name[1].nodes[1].config.object.config
               
            

            conf.string[1] = "Oops! All ".. full_UI_table.name[1].nodes[1].config.object.config.string[1]
            if string.sub(conf.string[1], -1) ~= "!" then
                conf.string[1] = conf.string[1] .. "!"
            end
			full_UI_table.name[1].nodes[1].config.object:remove()
			full_UI_table.name[1].nodes[1].config.object = DynaText(conf)
            
           
        elseif
            card
            and G.GAME.selected_back.effect.center.key == "b_SGTMD_fuckyou"
            and G.GAME.selected_sleeve == "sleeve_SGTMD_fuckyou"
            and full_UI_table.name
            and type(full_UI_table.name) == "table"
            and full_UI_table.name[1].nodes
            and full_UI_table.name[1].nodes[1].config
            and full_UI_table.name[1].nodes[1].config.object
            and full_UI_table.name[1].nodes[1].config.object.config
        then
            local conf = full_UI_table.name[1].nodes[1].config.object.config
               
            

            conf.string[1] = "Fuck You"--.. full_UI_table.name[1].nodes[1].config.object.config.string[1]
            
			full_UI_table.name[1].nodes[1].config.object:remove()
			full_UI_table.name[1].nodes[1].config.object = DynaText(conf)
        end
        return full_UI_table
    end





SMODS.Gradient {
    key = "oops",
    colours = {
        HEX("4ac091"),
        HEX("469675")
    },
    cycle = 3
}


CardSleeves.Sleeve {
    key = "oops",
    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_SGTMD_oops" then
            key = self.key .. "_alt"
           
            self.config = {combo=true, prevent_faces = true}
        else
            key = self.key
            
            
        end
        return { key = key, vars = vars }
    end,
    config = {only_one_rank = '6', ante_scaling = 1.6},
    atlas = "decks sleeves",
    pos = { x = 0, y = 0},
   
    apply = function(self, sleeve)
        CardSleeves.Sleeve.apply(self)
        
        if self.config.prevent_faces and self.allowed_card_centers == nil then
            self.allowed_card_centers = {}
            self.skip_trigger_effect = true
            for _, card_center in pairs(G.P_CARDS) do
                local card_instance = Card(0, 0, 0, 0, card_center, G.P_CENTERS.c_base)
                if  card_instance.base.value == "6" then
                    self.allowed_card_centers[#self.allowed_card_centers+1] = card_center
                end
                card_instance:remove()
            end
            -- TODO: adhere to smodded API?
            self.get_rank_after_10 = function() return "6" end
            self.skip_trigger_effect = false
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = 1, #G.playing_cards do
                    local card = G.playing_cards[i]
                    assert(SMODS.change_base(card, nil, self.config.only_one_rank))
                end
                return true
            end
        }))
    end,
    calculate = function(self, sleeve, context)

        if context.final_scoring_step and not sleeve.config.combo then
            hand_chips = hand_chips*6
            mult = math.max(1, mult - (mult % 6))
            return{
                chips = 0,
                mult = 0,
                message = "Sixed!"
            }	
        end

        if not sleeve.config.prevent_faces then
            return
        end
        if sleeve.skip_trigger_effect then
            return
        end
        if sleeve.allowed_card_centers == nil then
            sleeve:apply(sleeve)
        end

        -- handle Strength and Ouija
        local card = context.card
        local is_playing_card = card and (card.ability.set == "Default" or card.ability.set == "Enhanced") and card.config.card_key
        if context.before_use_consumable and card then
            if card.ability.name == 'Strength' then
                sleeve.in_strength = true
            elseif card.ability.name == "Ouija" then
                sleeve.in_ouija = true
            end
            if sleeve.in_strength and sleeve.in_ouija then
                print_warning("cannot be in both strength and ouija!")
            end
        elseif context.after_use_consumable then
            sleeve.in_strength = nil
            sleeve.in_ouija = nil
            sleeve.ouija_rank = nil
        elseif (context.create_card or context.modify_playing_card) and card and is_playing_card then
           
            if card.base.value ~= "6" then
                local initial = G.GAME.blind == nil or context.create_card
                if sleeve.in_strength then
                    local base_key = SMODS.Suits[card.base.suit].card_key .. "_" .. sleeve.get_rank_after_10()
                    card:set_base(G.P_CARDS[base_key], initial)
                elseif sleeve.in_ouija then
                    if sleeve.ouija_rank == nil then
                        local random_base = pseudorandom_element(sleeve.allowed_card_centers, pseudoseed("slv"))
                        local card_instance = Card(0, 0, 0, 0, random_base, G.P_CENTERS.c_base)
                        sleeve.ouija_rank = SMODS.Ranks[card_instance.base.value]
                        card_instance:remove()
                    end
                    local base_key = SMODS.Suits[card.base.suit].card_key .. "_" .. sleeve.ouija_rank.card_key
                    card:set_base(G.P_CARDS[base_key], initial)
                else
                    local random_base = pseudorandom_element(sleeve.allowed_card_centers, pseudoseed("slv"))
                    
                    card:set_base(random_base, initial)
                end
            end
        end

        

    end
}

CardSleeves.Sleeve {
    key = "argyle",
    atlas = "decks sleeves",
    pos = { x = 3, y = 0},
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_argyle" then
            key = self.key .. "_alt"
            self.config = { force_suits = {["Spades"] = "Clubs", ["Hearts"] = "Diamonds"} }
        else
            key = self.key
            self.config = {}
        end
        return { key = key }
    end,
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				for _, card in ipairs(G.playing_cards) do
					
					if card:is_suit("Hearts") then
						assert(SMODS.change_base(card, "Diamonds"))
					end
					if card:is_suit("Spades") then
						assert(SMODS.change_base(card, "Clubs"))
					end
				end
			return true
		   end
		}))
	end,
    calculate = function(self, sleeve, context)
        if not sleeve.config.force_suits then
            return
        end

        local card = context.card
        local is_playing_card = card and (card.ability.set == "Default" or card.ability.set == "Enhanced") and card.config.card_key
        if (context.create_card or context.modify_playing_card) and card and is_playing_card then
            for from_suit, to_suit in pairs(sleeve.config.force_suits) do
                if card.base.suit == from_suit then
                    local base = SMODS.Suits[to_suit].card_key .. "_" .. SMODS.Ranks[card.base.value].card_key
                    local initial = G.GAME.blind == nil or context.create_card
                    card:set_base(G.P_CARDS[base], initial)
                end
            end
        end
    end,
}

CardSleeves.Sleeve {
    key = "doubleup",
    atlas = "decks sleeves",  -- you will need to create an atlas yourself
    pos = { x = 1, y = 0 },
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_doubleup" then
            key = self.key .. "_alt"
            self.config = {}
        else
            key = self.key
            self.config = {}
        end
        return { key = key }
    end,
   
    apply = function(self)


        G.E_MANAGER:add_event(Event({
            func = function()
            	local newcards = {}
                for i = 1, #G.playing_cards do
  					local card = G.playing_cards[i]

                    local _card = copy_card(card, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.deck:emplace(_card)
                    
                end
                
                return true
            end
        }))
    end
}

CardSleeves.Sleeve {
    key = "kingdom",
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_kingdom" then
            key = self.key .. "_alt"
            self.config = {prevent_faces = true}
        else
            key = self.key
            self.config = {hand_size = -2, no_interest = true}
        end
        
        return { key = key }
        
    end,
    config = {hand_size = -2, no_interest = true},
    atlas = "decks sleeves",
    pos = { x = 2, y = 0},


    apply = function(self, sleeve)
        CardSleeves.Sleeve.apply(self)
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 1,
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    if not card:is_face(false) then
                            assert(SMODS.change_base(card, nil, "Jack" ))
                        end
                end
            return true
           end
        }))
        
        if self.config.prevent_faces and self.allowed_card_centers == nil then
            self.allowed_card_centers = {}
            self.skip_trigger_effect = true
            for _, card_center in pairs(G.P_CARDS) do
                local card_instance = Card(0, 0, 0, 0, card_center, G.P_CENTERS.c_base)
                if  SMODS.Ranks[card_instance.base.value].face then
                    self.allowed_card_centers[#self.allowed_card_centers+1] = card_center
                end
                card_instance:remove()
            end
            -- TODO: adhere to smodded API?
            self.get_rank_after_K = function() return "J" end
            self.skip_trigger_effect = false
        end
    end,
    calculate = function(self, sleeve, context)
        if not sleeve.config.prevent_faces then
            return
        end
        if sleeve.skip_trigger_effect then
            return
        end
        if sleeve.allowed_card_centers == nil then
            sleeve:apply(sleeve)
        end

        -- handle Strength and Ouija
        local card = context.card
        local is_playing_card = card and (card.ability.set == "Default" or card.ability.set == "Enhanced") and card.config.card_key
        if context.before_use_consumable and card then
            if card.ability.name == 'Strength' then
                sleeve.in_strength = true
            elseif card.ability.name == "Ouija" then
                sleeve.in_ouija = true
            end
            if sleeve.in_strength and sleeve.in_ouija then
                print_warning("cannot be in both strength and ouija!")
            end
        elseif context.after_use_consumable then
            sleeve.in_strength = nil
            sleeve.in_ouija = nil
            sleeve.ouija_rank = nil
        elseif (context.create_card or context.modify_playing_card) and card and is_playing_card then
            if not SMODS.Ranks[card.base.value].face then
                local initial = G.GAME.blind == nil or context.create_card
                if sleeve.in_strength then
                    local base_key = SMODS.Suits[card.base.suit].card_key .. "_" .. sleeve.get_rank_after_K()
                    card:set_base(G.P_CARDS[base_key], initial)
                elseif sleeve.in_ouija then
                    if sleeve.ouija_rank == nil then
                        local random_base = pseudorandom_element(sleeve.allowed_card_centers, pseudoseed("slv"))
                        local card_instance = Card(0, 0, 0, 0, random_base, G.P_CENTERS.c_base)
                        sleeve.ouija_rank = SMODS.Ranks[card_instance.base.value]
                        card_instance:remove()
                    end
                    local base_key = SMODS.Suits[card.base.suit].card_key .. "_" .. sleeve.ouija_rank.card_key
                    card:set_base(G.P_CARDS[base_key], initial)
                else
                    local random_base = pseudorandom_element(sleeve.allowed_card_centers, pseudoseed("slv"))
                    card:set_base(random_base, initial)
                end
            end
        end
    end,


}

CardSleeves.Sleeve {
    key = "fuckyou",
    config = {},
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_fuckyou" then
            key = self.key .. "_alt"



            
            self.config = {dollars = -14, no_interest = true}
        else
            key = self.key
            self.config = {}
        end
        
        return { key = key }
        
    end,
    
    atlas = "decks sleeves",
    pos = { x = 4, y = 0},
    
    apply = function(self)
        CardSleeves.Sleeve.apply(self)
        if not self.config.no_interest then
        G.E_MANAGER:add_event(Event({
            func = function()
				SMODS.add_card { key = 'j_popcorn' }
				local ante_UI = G.hand_text_area.ante
				G.GAME.round_resets.ante = 0
				G.GAME.round_resets.ante_disp = number_format(G.GAME.round_resets.ante)
				ante_UI.config.object:update()
				G.HUD:recalculate()
            	local newcards = {}
                for i = 1, #G.playing_cards do
  					local card = G.playing_cards[1]
					G.deck:remove_card(card)
					card:remove()
                    
                end
                card = create_playing_card({front = G.P_CARDS.S_K},G.deck)
                return true
            end
        }))
		
    else
        G.E_MANAGER:add_event(Event({
            func = function()
				SMODS.add_card { key = 'j_ice_cream' }
				
                
                return true
            end
        }))
        
    end
end,
	calculate = function(self, card, context)

		 if context.final_scoring_step then
			return{
				xmult = 0.5
			}
		 end
		
	end
}

SMODS.Atlas {
    key = "prosleeve",
    px = 73,
    py = 95,
    path = "prosleeve.png"
}

CardSleeves.Sleeve {
    key = "prosleeve",
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_prodeck" then
            key = self.key .. "_alt"
            
            self.config = {hand_size = 1,no_interest = false,ante_scaling = 1.2, dollars = 2}
        else
            key = self.key
            self.config = {hands = 1, discards = 1,hand_size = 2, consumable_slot = -1,no_interest = true,ante_scaling = 1.4, dollars = 10}
        end
        
        return { key = key }
        
    end,
    atlas = "prosleeve",
    pos = { x = 0, y = 0},
    apply = function(self)
        CardSleeves.Sleeve.apply(self)
        if not self.config.no_interest then
        G.GAME.modifiers.no_interest = false
        end
    end
}

CardSleeves.Sleeve {
    key = "betrayal",
	loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_betrayal" then
            key = self.key .. "_alt"
            
            self.config = {force_suits = {["Spades"] = "Hearts", ["Clubs"] = "Diamonds"}}
        else
            key = self.key
            self.config = {hands = -1}
        end
        
        return { key = key }
        
    end,
	atlas = "decks sleeves",
	pos = { x = 2, y = 1},
	apply = function(self)
        CardSleeves.Sleeve.apply(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				for _, card in ipairs(G.playing_cards) do
					if card.base.value == "King"then
						assert(SMODS.change_base(card, nil, "Jack"))
					end
					if card:is_suit("Clubs") then
						assert(SMODS.change_base(card, "Diamonds"))
					end
					if card:is_suit("Spades") then
						assert(SMODS.change_base(card, "Hearts"))
					end
				end
			return true
		   end
		}))
	end,
    calculate = function(self, sleeve, context)
        if not sleeve.config.force_suits then
            return
        end

        local card = context.card
        local is_playing_card = card and (card.ability.set == "Default" or card.ability.set == "Enhanced") and card.config.card_key
        if (context.create_card or context.modify_playing_card) and card and is_playing_card then
            for from_suit, to_suit in pairs(sleeve.config.force_suits) do
                if card.base.suit == from_suit then
                    local base = SMODS.Suits[to_suit].card_key .. "_" .. SMODS.Ranks[card.base.value].card_key
                    local initial = G.GAME.blind == nil or context.create_card
                    card:set_base(G.P_CARDS[base], initial)
                end
            end
        end
    end,
}

CardSleeves.Sleeve {
    key = "blackboard",
	loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_blackboard" then
            key = self.key .. "_alt"
            
            self.config = {force_suits = {["Hearts"] = "Spades", ["Diamonds"] = "Clubs"}}
        else
            key = self.key
            self.config = {discards = -1}
        end
        
        return { key = key }
        
    end,

	atlas = "decks sleeves",
	pos = { x = 1, y = 1},
	check_for_unlock = function(self,args)
		if args.type == "win_deck" and G.GAME.selected_back.effect.center.key == "b_black" then
			return true
	end
	end,
	apply = function(self)
        CardSleeves.Sleeve.apply(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				for _, card in ipairs(G.playing_cards) do
					if card.base.value == "2"then
						assert(SMODS.change_base(card, nil, "Ace"))
					end
					if card:is_suit("Diamonds") then
						assert(SMODS.change_base(card, "Clubs"))
					end
					if card:is_suit("Hearts") then
						assert(SMODS.change_base(card, "Spades"))
					end
				end
			return true
		   end
		}))
	end,
    calculate = function(self, sleeve, context)
        if not sleeve.config.force_suits then
            return
        end

        local card = context.card
        local is_playing_card = card and (card.ability.set == "Default" or card.ability.set == "Enhanced") and card.config.card_key
        if (context.create_card or context.modify_playing_card) and card and is_playing_card then
            for from_suit, to_suit in pairs(sleeve.config.force_suits) do
                if card.base.suit == from_suit then
                    local base = SMODS.Suits[to_suit].card_key .. "_" .. SMODS.Ranks[card.base.value].card_key
                    local initial = G.GAME.blind == nil or context.create_card
                    card:set_base(G.P_CARDS[base], initial)
                end
            end
        end
    end,
}

CardSleeves.Sleeve {
	key = "tds",
	atlas = "decks sleeves",
	pos = {x=2, y=2},
	config = {no_interest = true},
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_tds" then
            key = self.key .. "_alt"
            
            self.config = {no_interest = true,extra_hand_bonus = 0}
        else
            key = self.key
            self.config = {no_interest = true}
        end
        
        return { key = key }
        
    end,
	calculate = function (self, back, context)
		if (context.buying_card or (context.open_booster and not context.card.from_tag)) and not G.GAME.selected_back.name == "b_SGTMD_tds"then
			
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function ()
					local startrerollcost = G.GAME.current_round.reroll_cost
					if (to_number(G.GAME.dollars-context.card.cost) - math.floor(G.GAME.current_round.reroll_cost/2) >= 0) 
					then
					G.GAME.current_round.reroll_cost = math.floor(G.GAME.current_round.reroll_cost/2)
					G.FUNCS.reroll_shop()
					G.GAME.current_round.reroll_cost = startrerollcost + 1
				end
			return true
				end
			}))
			
		end
	end,
    card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
		if _type ~= "Joker" or not created_card then return end
        created_card:set_eternal(true)
		if G.GAME.selected_back.name == "b_SGTMD_tds" then
			created_card:set_rental(true)
		end
	end
}


CardSleeves.Sleeve {
	key ="roffledeck",
	atlas = "decks sleeves",
	pos = {x=3,y=2},
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_roffledeck" then
            key = self.key .. "_alt"
            
            self.config = {combo = true}
        else
            key = self.key
            self.config = {}
        end
        
        return { key = key }
        
    end,
    apply = function (self)
        if self.config.combo then
            G.GAME.stake = 8
            SMODS.setup_stake(G.GAME.stake)
        end
    end,
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if created_card or _type ~= "Joker" then return nil end
		if pseudorandom("rofdeckya") > 0.65 then return nil end
		if forced_key and pseudorandom("rofedeckforce") >=0.25 then return nil end

		if pseudorandom("roffledeck") >.5 then
			forced_key = "j_photograph"
		else
			forced_key = "j_hanging_chad"
		end
		if _rarity == 4 or legendary then
			forced_key = "j_triboulet"
		end
		return {_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append}
	end
}

CardSleeves.Sleeve {
    key = "midas",
	atlas = "decks sleeves",
	pos = {x=4,y=2},
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_midas" then
            key = self.key .. "_alt"
            
            self.config = {vouchers = {"v_money_tree"}}
        else
            key = self.key
            self.config = {vouchers = {"v_seed_money"}}
        end
        
        return { key = key }
        
    end,
	calculate = function (self, back, context)
		if context.repetition and not context.repetition_only then
			if SMODS.has_enhancement(context.other_card,"m_gold") then
				return {
					message = "Again!",
					repetitions = 1,
					card = context.other_card
				}
			end
		end
	end
}

CardSleeves.Sleeve {
    key = "joker",
    atlas = "decks sleeves",
    pos = {x=4,y=1},
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_Joker" then
            key = self.key .. "_alt"
            
            self.config = {vouchers = {"v_reroll_surplus","v_overstock_norm"}}
        else
            key = self.key
            self.config = {hands = -2, joker_slot = 2}
        end
        
        return { key = key }
        
    end,
    config = {hands = -2, joker_slot = 2},
    apply = function (self)
        CardSleeves.Sleeve.apply(self)
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

CardSleeves.Sleeve {
    key = "Enhanced",
    atlas = "decks sleeves",
    config = {hands = -1, hand_size = -1},
     loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_SGTMD_enhancement" then
            key = self.key .. "_alt"
            
            self.config = {combo = true, hands = 1, hand_size = 1}
        else
            key = self.key
            self.config = {hands = -1, hand_size = -1}
        end
        
        return { key = key }
        
    end,
    pos = {x=2,y=3},
    apply = function(self)
        CardSleeves.Sleeve.apply(self)
		G.E_MANAGER:add_event(Event({
            func = function()
				for k, v in pairs(G.playing_cards) do
					local enhancement = SMODS.poll_enhancement({ guaranteed = true, type_key = 'enhancement_deck' })

					if pseudorandom("enhancement_proc") >.2 or self.config.combo then
						v:set_ability(G.P_CENTERS[enhancement])
					end
				end
                return true
            end
        }))
	end
}