TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "stone",
	retro = true,
	atlas = "modified",
	pos = {x=2,y=3},
	config = {joker_slot = -4},
	apply = function (self, back)
		G.GAME.SGTMD_MOD = G.GAME.SGTMD_MOD or {}
		G.GAME.SGTMD_MOD.stonedeckcount = 0

	end,
	calculate = function (self, back, context)
		if context.modify_playing_card or context.final_scoring_step then
			local stonecount = 0
			
			for x=1,#G.playing_cards do
				local ccard = G.playing_cards[x]
				if ccard.config.center == G.P_CENTERS.m_stone then stonecount = stonecount +1 end
			end
			if math.floor(stonecount/2) ~= G.GAME.SGTMD_MOD.stonedeckcount then
				local diff =  math.floor(stonecount/2) - G.GAME.SGTMD_MOD.stonedeckcount
				G.E_MANAGER:add_event(Event({func = function()
					if G.jokers then 
						G.jokers.config.card_limit = G.jokers.config.card_limit + diff
					end
					return true end }))
				G.GAME.SGTMD_MOD.stonedeckcount  = G.GAME.SGTMD_MOD.stonedeckcount +diff
			end
		end
	end
}

TMD.wilddeckrandoms = {{"dollars",1},{"xmult",1.1},{"mult",5},{"chips",50}}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "wild",
	retro = true,
	shader = "SGTMD_wild",
	atlas = "modified",
	pos = {x=0,y=4},
	calculate = function (self, back, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card.config.center == G.P_CENTERS.m_wild then
			local opt = pseudorandom_element(TMD.wilddeckrandoms,pseudoseed("wilddeck"))
			return {
				[opt[1]] = opt[2],
				card = context.other_card
			}
		end
		end
		if context.final_scoring_step then
			local wildcount = 0
			
			for x=1,#G.playing_cards do
				local ccard = G.playing_cards[x]
				if ccard.config.center == G.P_CENTERS.m_wild then wildcount = wildcount +1 end
			end
			return {
				chips = wildcount*10
			}
		end
	end
}


SMODS.Shader {key = "wild", path = "wild.fs"}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "midas",
	atlas = "modified",
	retro = true,
	shader = "SGTMD_midas",
	pos = {x=2,y=4},
	config = {vouchers = {"v_seed_money"}},
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

SMODS.Shader {key = "midas", path = "midas.fs"}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "editions",
	shader = "SGTMD_four",
	retro = true,
	config = {hands = -1,hand_size = -1},
	atlas = "modified",
	pos = {x=0,y=4},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
            func = function()
				for k, v in pairs(G.playing_cards) do
					local edition = poll_edition('editions_deck', nil, nil, true)

					if pseudorandom("editions_proc") >.2 then
						v:set_edition(edition,true,true)
					end
				end
                return true
            end
        }))
	end
}

SMODS.Shader {key = "four", path = "four.fs"}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "seals",
	
	config = {hands = -1,hand_size = -1},
	
	atlas = "decks",
	pos = {x=1,y=4},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
            func = function()
				for k, v in pairs(G.playing_cards) do
					local seal = SMODS.poll_seal({ guaranteed = true, type_key = 'seals_deck' })

					if pseudorandom("seals_proc") >.2 then
						v:set_seal(seal,true,true)
					end
				end
                return true
            end
        }))
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "enhancement",
	
	config = {hands = -1,hand_size = -1},
	
	atlas = "decks",
	pos = {x=2,y=4},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
            func = function()
				for k, v in pairs(G.playing_cards) do
					local enhancement = SMODS.poll_enhancement({ guaranteed = true, type_key = 'enhancement_deck' })

					if pseudorandom("enhancement_proc") >.2 then
						v:set_ability(G.P_CENTERS[enhancement])
					end
				end
                return true
            end
        }))
	end
}