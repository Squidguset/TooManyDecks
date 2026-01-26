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

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "bomb",
	atlas = "decks",
	apply = function (self)
		G.GAME.SGTMD_timer = 60
	end,
	calculate = function (self,card,context)
		if context.individual and context.cardarea == G.play then
			local mod = (context.other_card.base.id or 3)
			G.E_MANAGER:add_event(Event{
				func = function ()
					play_sound("SGTMD_tick",1,.5)
					local round_UI = G.hand_text_area.round
					G.GAME.SGTMD_timer = G.GAME.SGTMD_timer + mod
					local text = mod < 0 and "-" or "+"
					attention_text({
            		text = text..tostring(math.abs(mod)),
            		scale = 1, 
            		hold = 0.7,
            		cover = round_UI.parent,
            		cover_colour = G.C.GREEN,
            		align = 'cm',
            		})
					return true
				end
			})
		end
	end
}

local upd = G.update

function G:update(dt)
	local ret = upd(G,dt)

	if self.GAME and self.GAME.SGTMD_timer and not self.SETTINGS.paused then
		self.GAME.SGTMD_timer = self.GAME.SGTMD_timer-dt
		self.GAME.SGTMD_timerR = math.floor(self.GAME.SGTMD_timer)
		if to_number(self.GAME.SGTMD_timerR)<= 0 and G.STATE ~= G.STATES.GAME_OVER then
			G.GAME.blind.config.blind = G.P_BLINDS.bl_SGTMD_deckblind
			G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false 
		end
	end

	return ret
end

function roundUI()
	if  G.GAME.SGTMD_timer then
		return {n=G.UIT.R, config={align = "cm", maxw = 1.35}, nodes={
                  {n=G.UIT.T, config={text = "Time Left", minh = 0.33, scale = 0.85*0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                }},
                {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = G.C.DYN_UI.BOSS_DARK, id = 'row_round_text'}, nodes={
                  {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'SGTMD_timerR'}}, colours = {G.C.IMPORTANT},shadow = true, scale = 2*0.4}),id = 'round_UI_count'}},
                }}
	else
		return {n=G.UIT.R, config={align = "cm", maxw = 1.35}, nodes={
                  {n=G.UIT.T, config={text = localize('k_round'), minh = 0.33, scale = 0.85*0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                }},
                {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = G.C.DYN_UI.BOSS_DARK, id = 'row_round_text'}, nodes={
                  {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'round'}}, colours = {G.C.IMPORTANT},shadow = true, scale = 2*0.4}),id = 'round_UI_count'}},
                }}
	end
end

SMODS.Sound{
	key = "tick",
	path = "Cad_lv1.ogg"
}