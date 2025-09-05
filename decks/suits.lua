TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "argyle",
	atlas = "decks",
	unlocked = false,
	pos = { x = 1, y = 1},
	check_for_unlock = function(self,args)
		if args.type == "win_deck" and G.GAME.selected_back.effect.center.key == "b_black" then
			return true
		end
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
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "betrayal",
	
	config = {hands = -1},
	atlas = "decks",
	pos = { x = 4, y = 0},
	check_for_unlock = function(self,args)
		if args.type == "win_deck" and G.GAME.selected_back.effect.center.key == "b_black" then
			return true
		end
	end,
	apply = function(self)
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
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "blackboard",
	config = {discards = -1},
	atlas = "modified",
	retro = true,
	pos = { x = 0, y = 6},
	check_for_unlock = function(self,args)
		if args.type == "win_deck" and G.GAME.selected_back.effect.center.key == "b_black" then
			return true
		end
	end,
	apply = function(self)
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
	end
}