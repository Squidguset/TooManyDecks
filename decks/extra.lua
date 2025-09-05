-- This file is only ran when bonus content is active

assert(SMODS.load_file("items/paint.lua"))()

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "artist",
	
	atlas = "modified",
	retro = true,
	pos = { x = 0, y = 2},
	calculate =function (self, back, context)
		if context.setting_blind and #G.consumeables.cards < G.consumeables.config.card_limit then
			G.E_MANAGER:add_event(Event({func = function ()
				SMODS.add_card({set = "paint",area = G.consumeables})
				return true
			end}))
		end
	end
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key = "ballot",
	
	config = {extra = {round = 0}},
	loc_vars = function (self, info_queue, card)
		
		return{ vars = { 3 - (self.config.extra.round or 0) }}
		
	end,
	atlas = "decks",
	pos = {x=6,y=0},
	calculate = function (self, back, context)
		if context.setting_blind then
			back.effect.config.extra.round = back.effect.config.extra.round + 1
			if back.effect.config.extra.round >= 3 then
				back.effect.config.extra.round = 0
				ease_ante(-1)
				G.hand:change_size(-1)
				return {
					message = "Again!"
				}
			end
		end
	end
}

SMODS.Atlas {
	key = "lookinside",
	path = "roffledecklookinsidephotochad.png",
	px = 71,
	py = 95
}

TMD.Decks[#TMD.Decks+1] = SMODS.Back {
	key ="roffledeck",
	atlas = "lookinside",
	pos = {x=0,y=0},
	calculate =function (self, back, context)
		
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