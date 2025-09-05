-- all of this stuff doesnt have any deck it belongs to specifically, so they all are being put here
TMD = {}
TMD.config = SMODS.current_mod.config

-- WaffleDevs goat
local ref = SMODS.Back.register
function SMODS.Back.register(self)
	if self.retro and TMD.config.Original then
		self.pos.x = self.pos.x+1
	end

	return ref(self)
end




SMODS.current_mod.optional_features = function ()
	return {
		retrigger_joker = true
	}
end

-- config tab 
SMODS.current_mod.config_tab = function ()
	return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.BLACK, r = 0.1}, nodes={
    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
      {n=G.UIT.C, config={align = "cm", padding = 0.1, minw = 6, minh = 3}, nodes={
        create_toggle({
                label = "Extra Content (Requires restart)",
                ref_table = TMD.config,
                ref_value = "Bonus",
            }),
			create_toggle({
                label = "Original Deck Style (Requires restart)",
                ref_table = TMD.config,
                ref_value = "Original",
            }),
      }},
	  
    }}
  }}
end

-- card creation for decks
local ccr = create_card


create_card = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local ret = {}
	if G.GAME.selected_back.effect.center.card_creation then ret = G.GAME.selected_back.effect.center.card_creation(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, nil) end
	if ret and next(ret) then _type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append = unpack(ret) end
	if CardSleeves and CardSleeves.Sleeve:get_obj(G.GAME.selected_sleeve).card_creation then ret = CardSleeves.Sleeve:get_obj(G.GAME.selected_sleeve).card_creation(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, nil) end
	if ret and next(ret) then _type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append = unpack(ret) end

	local card = ccr(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)

	if G.GAME.selected_back.effect.center.card_creation then G.GAME.selected_back.effect.center.card_creation(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, card) end
	if CardSleeves and CardSleeves.Sleeve:get_obj(G.GAME.selected_sleeve).card_creation then CardSleeves.Sleeve:get_obj(G.GAME.selected_sleeve).card_creation(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, card) end

	return card
end


-- talisman comp
to_number = to_number or function (x) return x end




-- splash screen 
TMD.splashpos = {{x=5,y=0},{x=1,y=0},{x=2,y=0},{x=3,y=0},{x=4,y=0},
							  {x=0,y=1},{x=1,y=1},{x=2,y=1},{x=3,y=1},{x=4,y=1},
							  {x=0,y=2},{x=4,y=2},{x=4,y=3},
							  {x=0,y=3},{x=1,y=3},{x=3,y=3},{x=5,y=3},{x=6,y=3},
							  {x=6,y=2},{x=6,y=1},{ x = 5, y = 2}}


-- blind for losing to deck
SMODS.Blind {
	key = "deckblind",
	loc_txt = {
		name = "The Deck",
		text = {"You lost to the deck"}
	},
	atlas = "thedeckblind",
	unlocked = false,
	no_collection = true
}


-- credits tab

G.FUNCS.change_viewed_deck_credits = function(args)
  G.TMDviewedcreds = args.to_val
end

G.FUNCS.tmdcredcheck = function(e)
  if (G.TMDviewedcreds ~= e.config.id) then 
    e.config.object:remove() 
    e.config.object = UIBox{
      definition =  G.UIDEF.TMDCREDS(),
      config = {offset = {x=0,y=0}, align = 'cm', parent = e}
    }
    e.config.id = G.TMDviewedcreds
  end
end

function G.UIDEF.TMDCREDS(_new_option)
  G.TMDviewedcreds = G.TMDviewedcreds or "Oops! All Sixes!"

  local curr_collab = G.tmdcreds[G.TMDviewedcreds] or G.tmdcreds["Oops! All Sixes!"]
  if TMD.config.Original and curr_collab.r then curr_collab.art.x = curr_collab.art.x +1; curr_collab.r = false end
  local collab_sprite = Sprite(0,0,0.8*G.CARD_W,0.8*G.CARD_H,G.ASSET_ATLAS[curr_collab.atlas or "SGTMD_decks"], curr_collab.art)

  return  {n=G.UIT.ROOT, config={align = "cm", colour = G.C.BLACK, r = 0.1}, nodes={
    {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
      {n=G.UIT.T, config={text = G.TMDviewedcreds, scale = 0.5, colour = G.C.WHITE}}
    }},
    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
      {n=G.UIT.C, config={align = "cm", padding = 0.1, minw = 6, minh = 3}, nodes={
        {n=G.UIT.R, config={align = "cl", padding = 0}, nodes=G.UIDEF.multiline_credit_text(
			{"Deck idea"..(curr_collab.both and " and art" or "")..(curr_collab.code and " and code" or "").." by "..curr_collab.cred,
			curr_collab.arti and ("Art by {C:blue}"..curr_collab.arti) or nil})}
      }},
      {n=G.UIT.C, config={align = "cm", padding = 0.1, minw = 3, minh = 3}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.0}, nodes={
          {n=G.UIT.R, config={align = "cm", r = 0.3}, nodes={
            {n=G.UIT.O, config={colour = G.C.BLUE, object = collab_sprite, hover = true, can_collide = false}},
          }},
        }}
      }}
    }}
  }}
end

SMODS.current_mod.extra_tabs = function ()
	return {
		{
			label = 'Credits',
			tab_definition_function = function()
				G.tmdcreds =  {
					["Oops! All Sixes!"] = {
						cred = "Fafneir",
						art = {x=0,y=0}
					},
					["Argyle Deck"] = {
						cred = "@postprototype",
						art = {x=1,y=1}
					},
					["Fuck You"] = {
						cred = "@nxkoo_",
						art = {x=6,y=5}
					},
					["Pro Deck"] = {
						cred = "@papyrussemi6798",
						art = {x=0,y=3}
					},
					["Storage Deck"] = {
						cred = "@helenadev",
						art = {x=3,y=0}
					},
					["Shitposter Deck"] = {
						cred = "dom2",
						art = {x=2,y=1}
					},
					["Deck of Betrayal"] = {
						cred = "@helenadev",
						art = {x=4,y=0}
					},
					["Blackboard Deck"] = {
						cred = "@helenadev",
						art = {x=4,y=1}
					},
					["Gambler's Deck"] = {
						cred = "@ezram.pearce",
						art = {x=1,y=3}
					},
					["Joker Deck"] = {
						cred = "@_tanghinh",
						art = {x=4,y=2},
						both = true
					},
					["Retro Deck"] = {
						cred = "@lolhappy909_lol",
						art = {x=5,y=2}
					},
					["Artist Deck"] = {
						cred = "@new_usernames_bad",
						art = {x=0,y=2},
						r=true,
						atlas = "SGTMD_modified"
					},
					["Piquet Deck"] = {
						cred = "@postprototype",
						art = {x=0,y=1},
						r=true,
						atlas = "SGTMD_modified"
					},
					["Pinochle Deck"] = {
						cred = "@ezram.pearce",
						art = {x=0,y=3},
						r=true,
						atlas = "SGTMD_modified"
					},
					["Snake Deck"] = {
						cred = "@ldoit",
						art = {x=6,y=1}
					},
					["Chaos Deck"] ={
						cred = "@monmonmondelladella1",
						both = true,
						art = {x=5,y=5}
					},
					["Enhancement/Seal/Edition Decks"] = {
						cred = "@waffledevs",
						code = true,
						art = {x=2,y=4}
					},
					["Contractors Deck"] = {
						cred = "@mr.dedmonique",
						art = {x=0,y=0},
						r=true,
						atlas = "SGTMD_modified"
					},
					["Champions Deck"] = {
						cred = "@ldoit",
						art = {x=2,y=0},
						r=true,
						atlas = "SGTMD_modified"
					},
					["Oddly Specific Deck"] ={
						cred = "@new_usernames_bad",
						art = {x=5,y=1}
					},
					["Consumers Deck"] = {
						cred = "@ronnec_15723",
						art = {x=2,y=5},
						r=true,
						atlas = "SGTMD_modified"
					},
					["Order Deck"] = {
						cred = "@ldoit",
						art = {x=7,y=5}
					}
                }
				

                local middle = {n=G.UIT.R, config={align = "cm", padding = 0.1,minh = 3.7, minw = 9.4}, nodes={
                  {n=G.UIT.O, config={id = nil, func = 'tmdcredcheck', object = Moveable()}},
                }}
              
                local collab_options = {}
                for k, v in pairs(G.tmdcreds) do
                  collab_options[#collab_options+1] = k
                end
                
                table.sort(collab_options)

                G.TMDviewedcreds = collab_options[1]

                return 
                      {n=G.UIT.ROOT, config={align = "cm", padding = 0.1, colour = G.C.L_BLACK, r = 0.1, emboss =0, minh = 4, minw = 8}, nodes={
                      {n=G.UIT.C, config={align = "cm", padding = 0.2,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                        create_option_cycle({options = 
                        collab_options, opt_callback = 'change_viewed_deck_credits', current_option = 1, colour = G.C.RED, w = 4, mid = middle
                        })
                    }}
                }}
			end,
		},
		-- insert more tables with the same structure here
	}
end


-- Set sprites for 3d decks
local cssref = Card.set_sprites

function  Card:set_sprites(_center,_front)
	local cback =self.params.galdur_back or (not self.params.viewed_back and G.GAME.selected_back) or ( self.params.viewed_back and G.GAME.viewed_back)
	if _center and _center.set == "Back" then end
	local ret = cssref(self,_center,_front)
	if _center and _center.set and _center.set ~= "Sleeve" 
			and not self.params.stake_chip then 
		if  cback and cback.effect.center.float_pos or _center.float_pos  then
			
				
				self.children.back_float = Sprite(self.T.x, self.T.y, self.T.w, self.T.h,  G.ASSET_ATLAS[ cback.atlas or 'centers'],cback.effect.center.float_pos or _center.float_pos)
				
				self.children.back_float:set_role({major = self, role_type = 'Glued', draw_major = self})
				self.children.back_float.role.draw_major = self
				self.children.back_float.states.visible = false
				self.children.back_float.states.hover.can = false
				self.children.back_float.states.click.can = false
		
		else
			if self.children.back_float then
				self.children.back_float:remove()
				self.children.back_float = nil
			end
		end
	
		if  cback and cback.effect.center.float2 or _center.float2  then
			
				
				self.children.float2 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h,  G.ASSET_ATLAS[cback[G.SETTINGS.colourblind_option and 'hc_atlas' or 'lc_atlas'] or cback.atlas or 'centers'],cback.effect.center.float2 or _center.float2)
				
				self.children.float2:set_role({major = self, role_type = 'Glued', draw_major = self})
				self.children.float2.role.draw_major = self
				self.children.float2.states.visible = false
				self.children.float2.states.hover.can = false
				self.children.float2.states.click.can = false
		else
			-- THANK YOUi BEPIS FOR THE FIX
			if self.children.float2 then
				self.children.float2:remove()
				self.children.float2 = nil
			end
		end
	end
	return ret
end



-- draw 3d decks
SMODS.DrawStep {
    key = 'float_back',
    order = 60,
    func = function(self)
		
		if self.children.float2 then
			local cback = (not self.params.viewed_back and G.GAME.selected_back) or ( self.params.viewed_back and G.GAME.viewed_back) 
			if cback then
			
				local t =( self.area and self.area.config.type == "deck") or self.config.center.set == "Back"
				local aa = G.TIMERS.REAL + 1.5
				local scale_mod = 0.02 + 0.02*math.sin(1.8*aa) + 0.00*math.sin((aa - math.floor(aa))*math.pi*14)*(1 - (aa - math.floor(aa)))^2.5
				local rotate_mod = 0.05*math.sin(1.219*aa) + 0.00*math.sin((aa)*math.pi*5)*(1 - (aa - math.floor(aa)))^2
	
				if t then self.ARGS.send_to_shader = {1.0,1.0} end
			--self.children.back:draw_shader('voucher',0, nil, t, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*aa),nil, 0.6)
			
			--self.children.float2:draw_shader('dissolve', nil, self.ARGS.send_to_shader, t, self.children.center, 0,0)
							 -- Sprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
				if (t and self.area.cards[1] == self) or not t then
				self.children.float2:draw_shader('dissolve',0, nil, t, self.children.center,scale_mod, rotate_mod,nil, 0.05 + 0.03*math.sin(1.8*aa),nil, 0.6)
				self.children.float2:draw_shader('dissolve', nil, nil, t, self.children.center, scale_mod, rotate_mod)
				end
		
		end
	end
		if self.children.back_float then
			
			local cback = (not self.params.viewed_back and G.GAME.selected_back) or ( self.params.viewed_back and G.GAME.viewed_back) 
			if cback then
			
				local t =( self.area and self.area.config.type == "deck") or self.config.center.set == "Back"
				local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            	local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

				if t then self.ARGS.send_to_shader = {1.0,1.0} end
			--self.children.back:draw_shader('voucher',0, nil, t, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
			
			--self.children.back_float:draw_shader('dissolve', nil, self.ARGS.send_to_shader, t, self.children.center, 0,0)
			self.children.back_float:draw_shader('dissolve',0, nil, t, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
			self.children.back_float:draw_shader('dissolve', nil, nil, t, self.children.center, scale_mod, rotate_mod)
		
        end
		end
    end,
    conditions = { vortex = false, facing = 'back' },
}

SMODS.DrawStep {
    key = 'float_back2',
    order = 60,
    func = function(self)
		if self.children.float2 then
			local cback = (not self.params.viewed_back and G.GAME.selected_back) or ( self.params.viewed_back and G.GAME.viewed_back) 
			if cback and self.area == G.title_top then
			
				local t =( self.area and self.area.config.type == "deck") or self.config.center.set == "Back"
				local aa = G.TIMERS.REAL + 1.5
				local scale_mod = 0.02 + 0.02*math.sin(1.8*aa) + 0.00*math.sin((aa - math.floor(aa))*math.pi*14)*(1 - (aa - math.floor(aa)))^2.5
				local rotate_mod = 0.05*math.sin(1.219*aa) + 0.00*math.sin((aa)*math.pi*5)*(1 - (aa - math.floor(aa)))^2
	
				if t then self.ARGS.send_to_shader = {1.0,1.0} end
			--self.children.back:draw_shader('voucher',0, nil, t, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*aa),nil, 0.6)
			
			--self.children.float2:draw_shader('dissolve', nil, self.ARGS.send_to_shader, t, self.children.center, 0,0)
							 -- Sprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
			self.children.float2:draw_shader('dissolve',0, nil, t, self.children.center,scale_mod, rotate_mod,nil, 0.05 + 0.03*math.sin(1.8*aa),nil, 0.6)
			self.children.float2:draw_shader('dissolve', nil, nil, t, self.children.center, scale_mod, rotate_mod)
		
		end
		if self.children.back_float then
			local cback = (not self.params.viewed_back and G.GAME.selected_back) or ( self.params.viewed_back and G.GAME.viewed_back) 
			if cback and self.area == G.title_top then
			
				local t =( self.area and self.area.config.type == "deck") or self.config.center.set == "Back"
				local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            	local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

				if t then self.ARGS.send_to_shader = {1.0,1.0} end
			--self.children.back:draw_shader('voucher',0, nil, t, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
			
			--self.children.back_float:draw_shader('dissolve', nil, self.ARGS.send_to_shader, t, self.children.center, 0,0)
			self.children.back_float:draw_shader('dissolve',0, nil, t, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
			self.children.back_float:draw_shader('dissolve', nil, nil, t, self.children.center, scale_mod, rotate_mod)
		
        end
	end
	
end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- draw decks with shaders 
SMODS.DrawStep {
    key = 'edition_deck',
    order = 5,
    func = function(self)
        if self.children.back then
			local cback = self.params.galdur_back or (not self.params.viewed_back and G.GAME.selected_back) or ( self.params.viewed_back and G.GAME.viewed_back) 
			if cback then
				local shader = nil
				if cback.effect.center.shader then shader =  cback.effect.center.shader end

			-- back has shader
			if (shader 
			-- if this is a sleeve, ignore it
			and (self.config.center.set ~= "Sleeve"))
			-- not the stake select from galdur or the stake chips
			and((self.area and  not self.area.config.stake_select and not self.area.config.stake_chips)or not self.area) then
				local t =( self.area and self.area.config.type == "deck") or self.config.center.set == "Back" 
				if t and not self.states.drag.is then self.ARGS.send_to_shader = {1.0,self.ARGS.send_to_shader[2]} end
			
			self.children.back:draw_shader(shader, nil, self.ARGS.send_to_shader, t, self.children.center, 0,0)
			
		end
        end
	end
    end,
    conditions = { vortex = false, facing = 'back' },
}

-- draw sleeve with shader
SMODS.DrawStep {
    key = 'edition_sleeve',
    order = 5,
    func = function(self)
        if self.children.back and self.config and self.config.center and self.config.center.set == "Sleeve" then
			local cback = self.config.center
			if cback then
				local shader = nil
				if cback.shader then shader =  cback.shader end

			-- back has shader
			if (shader)
			-- not the stake select from galdur or the stake chips
			and((self.area and  not self.area.config.stake_select and not self.area.config.stake_chips)or not self.area) then
				local t =( self.area and self.area.config.type == "deck") or self.config.center.set == "Back" 
				if t and not self.states.drag.is then self.ARGS.send_to_shader = {1.0,self.ARGS.send_to_shader[2]} end
			
			self.children.back:draw_shader(shader, nil, self.ARGS.send_to_shader, t, self.children.center, 0,0)
			
		end
        end
	end
    end,
    conditions = { vortex = false, facing = 'back' },
}

-- unlock condition for loosing
local og = set_deck_loss
function set_deck_loss()
	local ret = og()
	check_for_unlock({type = "loss"})
	return ret
end


-- title screen
-- Credit to cryptid
local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
	local ret = oldfunc(change_context)
	local bbb = "b_SGTMD_argyle"
	if math.random() == -1 then
		bbb = "b_SGTMD_prodeck"
	end
	local newcard = Card(
		G.title_top.T.x,
		G.title_top.T.y,
		G.CARD_W,
		G.CARD_H,
		G.P_CARDS.empty,
		G.P_CENTERS[bbb],
		{ bypass_discovery_center = true, }
	)
	-- recenter the title
	if not Cryptid then
		G.title_top.T.w = G.title_top.T.w * 1.7675
		G.title_top.T.x = G.title_top.T.x - 0.8
	end

	G.title_top:emplace(newcard)

	-- make the card look the same way as the title screen Ace of Spades
	newcard.T.w = newcard.T.w * 1.1 * 1.2
	newcard.T.h = newcard.T.h * 1.1 * 1.2
	newcard.no_ui = true
	newcard.states.visible = false
	newcard:set_sprites()


	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0,
		blockable = false,
		blocking = false,
		func = function()
			if change_context == "splash" then
				newcard.states.visible = true
				newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
			else
				newcard.states.visible = true
				newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
			end
			return true
		end,
	}))

	return ret
end

local colour = SMODS.Gradient {
	key = "badge",
	colours = {
		HEX("d7d200"),
		HEX("0099a3")
	},
	cycle = 12
}

SMODS.current_mod.badge_colour = colour