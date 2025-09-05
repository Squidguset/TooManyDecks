TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "cheap",
	retro = true,
	atlas = "modified",
	pos = {x=2,y=1},
	config = {vouchers = {"v_clearance_sale","v_reroll_surplus"}}
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "doubleup",
	retro = true,
	atlas = "modified",
	pos = { x = 2, y = 2},
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

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "prodeck",
	
	check_for_unlock = function(self,args)
		if args.type == "win_deck" and G.GAME.selected_back.effect.center.key == "b_SGTMD_fuckyou" then
			return true
		end
	end,
	unlocked = false,
	config = {hands = 1, discards = 1,hand_size = 2, consumable_slot = -1,no_interest = true,ante_scaling = 1.4, dollars = 10},
	atlas = "decks",
	pos = { x = 2, y = 2},
	
	float_pos = {x=3,y=2},
	float2 = {x=2,y=3}
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "consume",
	atlas = "modified",
	retro = true,
	pos = {x=2,y=5},
	config = {consumable_slot = -1},
	calculate = function (self, back, context)
		if context.end_of_round  and not context.repetition and not context.individual then
			if G.consumeables.config.card_limit > #G.consumeables.cards then
				SMODS.add_card({
					set = "Consumeables",
					area = G.consumeables
				})
			end
		end
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "tuna",
	atlas = "decks",
	pos = {x=3,y=4},
	calculate = function (self, back, context)
		if context.using_consumeable and context.area == G.pack_cards then
			if #G.consumeables.cards < G.consumeables.config.card_limit + (context.consumeable.edition and context.consumeable.edition.negative and 1 or 0) then
			G.E_MANAGER:add_event(Event({
				func = function ()
					G.consumeables:emplace(copy_card(context.consumeable))
					return true
				end
			}))
		end
		end
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "snake",
	atlas = "decks",
	pos = {x=6,y=1},
	config = {hands = 1,discards = 1},
	apply = function (self, back)
		G.GAME.SGTMD_MOD = G.GAME.SGTMD_MOD or {}
		G.GAME.SGTMD_MOD.limitdraw = 3
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "piquet",
	
	config = {hands = -1},
	retro = true,
	atlas = "modified",
	pos = {x=0,y=1},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
            func = function()
            	local i2 = 1
                for i = 1, #G.playing_cards do
					local card = G.playing_cards[i2]

                    if not (card.base.value == "Ace" or card.base.value == "King"  or card.base.value == "Queen"  or card.base.value =="Jack"  or card.base.value =="10"  or card.base.value =="9"  or card.base.value =="8"  or card.base.value == "7") then
						G.deck:remove_card(card)
						card:remove()
						i2 = i2-1
					end
					i2 = i2 + 1
                end

                return true
            end
        }))
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "pinochle",
	
	config = {hands = -1},
	retro = true,
	atlas = "modified",
	pos = {x=0,y=3},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
            func = function()
            	local i2 = 1
                for i = 1, #G.playing_cards do
					local card = G.playing_cards[i2]
                    if not (card.base.value == "Ace" or card.base.value == "King"  or card.base.value == "Queen"  or card.base.value =="Jack"  or card.base.value =="10"  or card.base.value =="9" ) then
						G.deck:remove_card(card)
						card:remove()
						i2 = i2-1
					end
					i2 = i2 + 1
                end

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

