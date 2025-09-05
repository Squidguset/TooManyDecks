-- SPOILERS AHEAD
-- PLS DONT SPOIL URSELF ITS FUNNIER IF YOU DONT
-- :3


























-- Start of code



-- Splash Text 

TMD.splashtext = {
    "available now!",
    "also try Nubbys Number Factory",
    "AAAAAAAAAA",
    "peekabo",
    "ello",
    "this is splash text",
    "tadaaaaa",
    "im running out of lines",
    "future squid pls write more tyy",
    "past squid why would you do this to me",
    "burritos",
    "ball",
    "ball",
    "find out to play what this does!"
}


SMODS.Gradient {
    key = "rellow",
    colours = {
        HEX("ff00ac"),
        HEX("2a00ff")
    },
    cycle = 3
}

SMODS.Gradient {
    key = "bell",
    colours = {
        HEX("000135"),
        HEX("1b005f")
    },
    cycle = 3
}

SMODS.Back {
    key = "thereisnogod",
    
    loc_vars = function (self, info_queue, card)
        return {vars = {TMD.splashtext[math.random(#TMD.splashtext)]}}
    end,
    atlas = "decks",
    pos = {x=5,y=1},
    apply = function (self, back)
        -- negative riff raff
        G.GAME.osd_n_riffraff = 0

        -- plus two levels for straight flush
        G.GAME.hands["Straight Flush"].level = 3
        G.GAME.hands["Straight Flush"].chips = G.GAME.hands["Straight Flush"].chips + 80
        G.GAME.hands["Straight Flush"].mult = G.GAME.hands["Straight Flush"].mult + 8

        -- adds 7 of spades and 9 of diamonds
        G.E_MANAGER:add_event(Event({
            func = function ()
                create_playing_card({front = G.P_CARDS.S_7},G.deck)
                create_playing_card({front = G.P_CARDS.D_9},G.deck)
                return true
            end
        }))
    end,
    calculate = function (self, back, context)
        -- mards
        if context.final_scoring_step and context.scoring_name == "Two Pair" then
            local cont = false

            for _,card in ipairs(context.scoring_hand) do
                if card.base.value == "9" or  card.base.value == "2" then cont = true end
            end

            if cont then
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        SMODS.add_card({key = "c_mars"})
                        
                        return true
                    end
                }))
            end
        end
        -- the twoersdwerasdwe dat makesd cards erditioned
    if context.using_consumeable  and context.consumeable.label == "The Tower" then
        
        if pseudorandom("twoer") < G.GAME.probabilities.normal / 14 then
            
            if (function ()
                for _,card in ipairs(G.jokers.cards) do
                    
                    if card.ability.rental  then return false end
                end
                return true
            end)() then
                card = pseudorandom_element(G.jokers.cards, pseudoseed("yellow"))
                if not card.edition then
                    card:set_edition({ holo = true }, true)
                end
                card = pseudorandom_element(G.jokers.cards, pseudoseed("yellow"))
                if not card.edition then
                    card:set_edition({ negative = true }, true)
                end
            end
        end
    end

    -- caino
    if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual and #G.jokers.cards < G.jokers.config.card_limit then
        if pseudorandom("cantio") < G.GAME.probabilities.normal / 191 then
            G.E_MANAGER:add_event(Event({
                func = function ()
                    SMODS.add_card({key = "j_caino",stickers = {"rental"}})
                    
                    return true
                end
            }))
        end
    end

    -- just for the negative riff raff 
    if context.ending_shop then
        
        if (function ()
            local count = 0
            for _,card in ipairs(G.jokers.cards) do
                
                if card.config.center.rarity == 2  then count = count+1 end
                
                if count >= 2 then
                    return false
                end
            end
            return count == 1
        end)() and (function ()
            local count = 0
            for _,card in ipairs(G.jokers.cards) do
                
                if card.config.center.rarity == 3  then count = count+1 end
                
                if count >= 4 then
                    return false
                end
            end
            return count == 3
        end)() and (function ()
           
            for _,card in ipairs(G.jokers.cards) do
                
                if card.config.center.rarity == 1  then return false end
                
            end
            return true
        end)() and G.GAME.osd_n_riffraff < 2 then
            G.GAME.osd_n_riffraff = G.GAME.osd_n_riffraff + 1
            G.E_MANAGER:add_event(Event({
                func = function ()
                    SMODS.add_card({key = "j_riff_raff",edition = "e_negative"})
                    return true
                end
            }))
            
        end
    end
    -- plub three for 3 or 7 andte
    if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual then
        
        if (G.GAME.round_resets.ante % 3) == 0  then
            if pseudorandom("monee") < G.GAME.probabilities.normal / 3 then
            ease_dollars(3)
            end
        end
        if (G.GAME.round_resets.ante % 7) == 0  then
            if pseudorandom("monee") < G.GAME.probabilities.normal / 3 then
            ease_dollars(3)
            end
        end
    end
    -- 3 oak tree
    if context.final_scoring_step and context.scoring_name == "Three of a Kind" then
        if (function ()
            local count = 0
        for _,card in ipairs(context.scoring_hand) do
            
            if card.ability.effect == "Mult Card" then count = count + 1 end
            if count >= 2 then
                return false
            end
        end
        return count == 1
    end)() and (function ()
        local count = 0
    for _,card in ipairs(context.scoring_hand) do
        
        if card.ability.effect == "Wild Card" then count = count + 1 end
        if count >= 2 then
            return false
        end
    end
    return count == 1
end)() then
        return {
            chips = 14,
            mult = 2
        }
    end
    end
    -- glack atack
    if context.final_scoring_step and context.scoring_name == "Straight" then
        if (function ()

            for _,card in ipairs(context.scoring_hand) do

                if card.base.value == "Jack" and  card.ability.effect == "Glass Card" then return true end
            end
            return false
        end)() then
            return {
                xmult = 0.76
            }
        end
    end
    -- queer 10s
    if context.individual and context.cardarea == G.play then
        if context.other_card.base.value == "10" and  context.other_card.edition and context.other_card.edition.polychrome then return {
            chips = -23
        } end
    end
    -- negatives give 1 dollar hermits
    if context.other_joker then
        if context.other_joker.edition and context.other_joker.edition.negative then
            G.E_MANAGER:add_event(Event({
				
				func = function()
                    
					context.other_joker:juice_up()
					SMODS.add_card { key = 'c_hermit', edition = "e_negative", }.ability.consumeable.extra = 1
					
					return true
				end





			}))
            
            return {
                message = "X5 Mult",
                colour = G.C.MULT,
                sound = "multhit2",
                message_card = context.other_joker
            }
        end
    end
    -- idek at this point lmao
    if context.ending_shop and 15 <= to_number(G.GAME.dollars) and to_number(G.GAME.dollars) <= 25 and #G.jokers.cards < G.jokers.config.card_limit then
        local card = copy_card(G.jokers.cards[1], nil)
		card.children.back.sprite_pos = G.jokers.cards[1].children.back.sprite_pos
		card:add_to_deck()
		G.jokers:emplace(card)
        return {
            message = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        }
    end 
end --final end
}


SMODS.Keybind {
    key_pressed = "space",
    action = function (self)
        if G.GAME and  G.GAME.selected_back and G.GAME.selected_back.effect.center.key == "b_SGTMD_thereisnogod" and to_number(G.GAME.dollars) - 5 >=0 and G.GAME.blind.in_blind then
            ease_dollars(-5)
            ease_hands_played(1)
        end
    end
}
