TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "fuckyou",
	locked_loc_vars = function (self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1)}}
	end,
	
	unlocked = false,
	check_for_unlock = function (self, args)
		if args.type == "loss" and pseudorandom("fuckyou") < G.GAME.probabilities.normal / 15 then
			return true
		end
		
	end,
	atlas = "decks",
	pos = { x = 0, y = 2},
	float_pos = {x=7,y=4},
	apply = function(self)
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
		
    end,
	calculate = function(self, card, context)

		 if context.final_scoring_step then
			return{
				xmult = 0.5
			}
		 end
		
	end
}


local emr = ease_dollars
function  ease_dollars(mod, instant)
	TMD.easing_dollar = nil

	local ret = emr(mod,instant)
	G.E_MANAGER:add_event(Event({
		func = function( )
			if G.GAME and G.GAME.selected_back.name == "b_SGTMD_tds" or G.GAME.selected_sleeve == "sleeve_SGTMD_tds" then
				G.GAME.dollars = math.min(50, G.GAME.dollars) 
			end
			if G.GAME and G.GAME.selected_back.name == "b_SGTMD_tds" and G.GAME.selected_sleeve == "sleeve_SGTMD_tds" then
				G.GAME.dollars = math.min(35, G.GAME.dollars) 
			end
			return true
		end
	}))
	TMD.easing_dollar = true
	return ret
end

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "tds",
	atlas = "decks",
	pos = {x=7,y=1},
	config = {no_interest = true},
	calculate = function (self, back, context)
		if context.buying_card or (context.open_booster and not context.card.from_tag) then
			
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function ()
					local startrerollcost = G.GAME.current_round.reroll_cost
					if (to_number(G.GAME.dollars-context.card.cost) - math.floor(G.GAME.current_round.reroll_cost/2) >= 0) then
						G.GAME.current_round.reroll_cost = math.floor(G.GAME.current_round.reroll_cost/2)
						G.FUNCS.reroll_shop()
						G.GAME.current_round.reroll_cost = startrerollcost + 1
					end
					return true
				end
			}))
			
		end
	end,
	card_creation = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, created_card)
		if _type ~= "Joker" then return nil end
		if created_card and created_card.config.center.eternal_compat then
			created_card:set_eternal(true)
		end
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "duck",
	retro = true,
	atlas = "modified",
	pos = {x=4,y=1},
	config= {discards = -1, joker_slot=-1},
	apply = function (self)
		change_shop_size(-1)
		
	end
}
