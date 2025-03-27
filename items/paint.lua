SMODS.ConsumableType {
    key = "paint",
    primary_colour = HEX("ff0068"),
    secondary_colour = HEX("ff0068"),
    loc_txt = {
        name = "Paint",
        collection = "Paint Cards",
        
    }
}
SMODS.Atlas {
    key = "paints",
    px = 71,
    py = 95,
    path = "paint.png"
}

SMODS.Shader( {key = "red",path = "red.fs",})
SMODS.Shader( {key = "blue",path = "blue.fs",})
SMODS.Shader( {key = "green",path = "green.fs",})
SMODS.Shader( {key = "yellow",path = "yellow.fs",})
SMODS.Shader( {key = "teal",path = "teal.fs",})
SMODS.Shader( {key = "orange",path = "orange.fs",})
SMODS.Shader( {key = "white",path = "white.fs",})
SMODS.Shader( {key = "black",path = "black.fs",})

SMODS.Edition {
    key = "red",
    shader = "red",
    loc_txt = {
        name = "Painted",
        label = "Painted",
        text = {
            "+5 Mult"
        }
    },
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.pre_joker and context.cardarea ~= G.play) then
            return {
                mult = 5
            }
        end
    end
}

SMODS.Edition {
    key = "blue",
    shader = "blue",
    loc_txt = {
        name = "Painted",
        label = "Painted",
        text = {
            "+35 Chips"
        }
    },
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.pre_joker and context.cardarea ~= G.play) then
            return {
                chips = 35
            }
        end
    end
}

SMODS.Edition {
    key = "yellow",
    shader = "yellow",
    loc_txt = {
        name = "Painted",
        label = "Painted",
        text = {
            "+6 Mult and +15 Chips"
        }
    },
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.pre_joker and context.cardarea ~= G.play) then
            
            return {
                chips = 15,
                mult = 6
            }
        end
    end
}

SMODS.Edition {
    key = "green",
    shader = "green",
    loc_txt = {
        name = "Painted",
        label = "Painted",
        text = {
            "-8 Chips and +1 Discard"
        }
    },
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.pre_joker and context.cardarea ~= G.play) then
            G.GAME.current_round.discards_left = 1 + G.GAME.current_round.discards_left
            return {
                chips = -8
            }
        end
    end
}

SMODS.Edition {
    key = "teal",
    shader = "teal",
    loc_txt = {
        name = "Painted",
        label = "Painted",
        text = {
            "-8 Chips and +1 hand"
        }
    },
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.pre_joker and context.cardarea ~= G.play) then
            G.GAME.current_round.hands_left = 1 + G.GAME.current_round.hands_left
            return {
                chips = -8
            }
        end
    end
}

SMODS.Edition {
    key = "orange",
    shader = "orange",
    loc_txt = {
        name = "Painted",
        label = "Painted",
        text = {
            "x1.8 mult"
        }
    },
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.pre_joker and context.cardarea ~= G.play) then
            
            return {
                xmult = 1.8
            }
        end
    end
}

SMODS.Edition {
    key = "white",
    shader = "white",
    loc_txt = {
        name = "Painted",
        label = "Painted",
        text = {
            "{C:mult}+1 Mult{} per empty Joker slot","Currently {C:mult}#1#{}"
        }
    },
    loc_vars = function (self, info_queue, card)
        if G.jokers then
        return {vars = {G.jokers.config.card_limit - G.jokers.config.card_count}}
        else
            return {vars = {1}}
        end
    end,
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.pre_joker and context.cardarea ~= G.play) then
            
            return {
                mult = G.jokers.config.card_limit - G.jokers.config.card_count
            }
        end
    end
}
--[[
local crr = Card.remove 
function Card:remove()
    local ret = crr(self)
    if self.edition and self.edition.type == "SGTMD_black" and self.ability.extra.active then
        G.jokers.config.card_limit = G.jokers.config.card_limit -1 
    end
    return ret
end


SMODS.Edition {
    key = "black",
    shader = "black",
    loc_txt = {
        name = "Painted",
        label = "Painted",
        text = {
            "+1 Joker slot if your full deck has 60","or more cards or 20 or less cards"
        }
    },
   config = {extra = {active = false}},
    calculate = function (self, card, context)
        if card.ability.extra then
        if #G.playing_cards >= 60 or #G.playing_cards <= 20 then
            if not card.ability.extra.active then
            card.ability.extra.active = true
              G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            end 
          else
            if card.ability.extra.active then
                card.ability.extra.active = false
              G.jokers.config.card_limit = G.jokers.config.card_limit -1 
            end 
        end
        end
    end,
    on_remove = function (card)
        if card.ability.extra.active then
          G.jokers.config.card_limit = G.jokers.config.card_limit -1 
        end 
    end,
    remove_from_deck = function (self, card, from_debuff)
        if card.ability.extra.active then
            G.jokers.config.card_limit = G.jokers.config.card_limit -1 
          end 
    end
}
]]

SMODS.Consumable {
    key = "sludge",
    set = "paint",
    config = {extra = {cards = 1}},
    loc_vars = function (self, info_queue, card)
        return{ vars = { card.ability.extra.cards }}
    end,
    loc_txt = {
        name = "Sludge",
        text = {
            "you went too far..." 
        }
    },
    atlas = "paints",
    pos = {x=3,y=1},
    can_use = function (self, card)
        return false
    end,
    in_pool =function (self, args)
        return false
    end
}


SMODS.Consumable {
    key = "red",
    set = "paint",
    config = {extra = {cards = 1}},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_SGTMD_red
        return{ vars = { card.ability.extra.cards }}
    end,
    loc_txt = {
        name = "Red Paint",
        text = {
            "Paints {C:attention}#1#{} selected","card {C:red}red{}" 
        }
    },
    atlas = "paints",
    can_use = function (self, card)
        return #G.jokers.highlighted
				+ #G.hand.highlighted
				+ #G.consumeables.highlighted
				+ (G.pack_cards and #G.pack_cards.highlighted or 0)
			== 2
    end,
    use = function (self, card, area, copier)
        if G.jokers.highlighted[1] then
            G.jokers.highlighted[1]:set_edition("e_SGTMD_red")
        elseif G.hand.highlighted[1] then
            G.hand.highlighted[1]:set_edition("e_SGTMD_red")
        else
            if G.consumeables.highlighted[1].ability.name == "c_SGTMD_yellow" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_orange"}
            elseif G.consumeables.highlighted[1].ability.name == "c_SGTMD_blue" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_teal"}
            elseif G.consumeables.highlighted[1].ability.set  == "paint" and not G.consumeables.highlighted[1].ability.name == "c_SGTMD_sludge" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_sludge"}
            else
                G.consumeables.highlighted[1]:set_edition("e_SGTMD_red")
            end
        end
    end
}

SMODS.Consumable {
    key = "blue",
    set = "paint",
    config = {extra = {cards = 1}},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_SGTMD_blue
        return{ vars = { card.ability.extra.cards }}
    end,
    loc_txt = {
        name = "Blue Paint",
        text = {
            "Paints {C:attention}#1#{} selected","card {C:blue}blue{}" 
        }
    },
    atlas = "paints",
    pos = {x=1,y=0},
    can_use = function (self, card)
        return #G.jokers.highlighted
				+ #G.hand.highlighted
				+ #G.consumeables.highlighted
				+ (G.pack_cards and #G.pack_cards.highlighted or 0)
			== 2
    end,
    use = function (self, card, area, copier)
        if G.jokers.highlighted[1] then
            G.jokers.highlighted[1]:set_edition("e_SGTMD_blue")
        elseif G.hand.highlighted[1] then
            G.hand.highlighted[1]:set_edition("e_SGTMD_blue")
        else
            if G.consumeables.highlighted[1].ability.name == "c_SGTMD_yellow" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_green"}
            elseif G.consumeables.highlighted[1].ability.name == "c_SGTMD_red" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_teal"}
            elseif G.consumeables.highlighted[1].ability.name == "c_SGTMD_white" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_teal"}
            elseif G.consumeables.highlighted[1].ability.set  == "paint" and not G.consumeables.highlighted[1].ability.name == "c_SGTMD_sludge" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_sludge"}
            else
                G.consumeables.highlighted[1]:set_edition("e_SGTMD_blue")
            end
        end
    end
}

SMODS.Consumable {
    key = "green",
    set = "paint",
    config = {extra = {cards = 1}},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_SGTMD_green
        return{ vars = { card.ability.extra.cards }}
    end,
    loc_txt = {
        name = "Green Paint",
        text = {
            "Paints {C:attention}#1#{} selected","card {C:green}green{}" 
        }
    },
    atlas = "paints",
    pos = {x=2,y=0},
    can_use = function (self, card)
        return #G.jokers.highlighted
				+ #G.hand.highlighted
				+ #G.consumeables.highlighted
				+ (G.pack_cards and #G.pack_cards.highlighted or 0)
			== 2
    end,
    use = function (self, card, area, copier)
        if G.jokers.highlighted[1] then
            G.jokers.highlighted[1]:set_edition("e_SGTMD_green")
        elseif G.hand.highlighted[1] then
            G.hand.highlighted[1]:set_edition("e_SGTMD_green")
        else
            if G.consumeables.highlighted[1].ability.name == "c_SGTMD_blue" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_teal"}
            elseif G.consumeables.highlighted[1].ability.name == "c_SGTMD_red" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_white"}
            elseif G.consumeables.highlighted[1].ability.set  == "paint" and not G.consumeables.highlighted[1].ability.name == "c_SGTMD_sludge" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_sludge"}
            else
                G.consumeables.highlighted[1]:set_edition("e_SGTMD_green")
            end
        end
    end
}

SMODS.Consumable {
    key = "yellow",
    set = "paint",
    config = {extra = {cards = 1}},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_SGTMD_yellow
        return{ vars = { card.ability.extra.cards }}
    end,
    loc_txt = {
        name = "Yellow Paint",
        text = {
            "Paints {C:attention}#1#{} selected","card {C:yellow}yellow{}" 
        }
    },
    atlas = "paints",
    pos = {x=2,y=1},
    can_use = function (self, card)
        return #G.jokers.highlighted
				+ #G.hand.highlighted
				+ #G.consumeables.highlighted
				+ (G.pack_cards and #G.pack_cards.highlighted or 0)
			== 2
    end,
    use = function (self, card, area, copier)
        if G.jokers.highlighted[1] then
            G.jokers.highlighted[1]:set_edition("e_SGTMD_yellow")
        elseif G.hand.highlighted[1] then
            G.hand.highlighted[1]:set_edition("e_SGTMD_yellow")
        else
            if G.consumeables.highlighted[1].ability.name == "c_SGTMD_blue" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_green"}
            elseif G.consumeables.highlighted[1].ability.name == "c_SGTMD_red" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_orange"}
            elseif G.consumeables.highlighted[1].ability.set  == "paint" and not G.consumeables.highlighted[1].ability.name == "c_SGTMD_sludge" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_sludge"}
            else
                G.consumeables.highlighted[1]:set_edition("e_SGTMD_yellow")
            end
        end
    end
}

SMODS.Consumable {
    key = "teal",
    set = "paint",
    config = {extra = {cards = 1}},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_SGTMD_teal
        return{ vars = { card.ability.extra.cards }}
    end,
    loc_txt = {
        name = "Teal Paint",
        text = {
            "Paints {C:attention}#1#{} selected","card {C:Chips}teal{}" ,
            "cannot be used on {C:attention}Jokers"
        }
    },
    atlas = "paints",
    pos = {x=0,y=1},
    can_use = function (self, card)
        return 
				    #G.hand.highlighted
				+ #G.consumeables.highlighted
				+ (G.pack_cards and #G.pack_cards.highlighted or 0)
			== 2
    end,
    use = function (self, card, area, copier)
        
        if G.hand.highlighted[1] then
            G.hand.highlighted[1]:set_edition("e_SGTMD_teal")
        else
            if G.consumeables.highlighted[1].ability.name == "c_SGTMD_yellow" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_white"}
            elseif G.consumeables.highlighted[1].ability.set  == "paint" and not G.consumeables.highlighted[1].ability.name == "c_SGTMD_sludge" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_sludge"}
            else
                G.consumeables.highlighted[1]:set_edition("e_SGTMD_teal")
            end
        end
    end
}

SMODS.Consumable {
    key = "orange",
    set = "paint",
    config = {extra = {cards = 1}},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_SGTMD_orange
        return{ vars = { card.ability.extra.cards }}
    end,
    loc_txt = {
        name = "Orange Paint",
        text = {
            "Paints {C:attention}#1#{} selected","card {C:orange}orange{}" 
        }
    },
    atlas = "paints",
    pos = {x=1,y=1},
    can_use = function (self, card)
        return #G.jokers.highlighted
				+ #G.hand.highlighted
				+ #G.consumeables.highlighted
				+ (G.pack_cards and #G.pack_cards.highlighted or 0)
			== 2
    end,
    use = function (self, card, area, copier)
        if G.jokers.highlighted[1] then
            G.jokers.highlighted[1]:set_edition("e_SGTMD_orange")
        elseif G.hand.highlighted[1] then
            G.hand.highlighted[1]:set_edition("e_SGTMD_orange")
        else
            if G.consumeables.highlighted[1].ability.name == "c_SGTMD_blue" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_white"}
            elseif G.consumeables.highlighted[1].ability.name == "c_SGTMD_white" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_yellow"}
            elseif G.consumeables.highlighted[1].ability.set == "paint" and not G.consumeables.highlighted[1].ability.name == "c_SGTMD_sludge" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_sludge"}
            else
                G.consumeables.highlighted[1]:set_edition("e_SGTMD_orange")
            end
        end
    end
}

SMODS.Consumable {
    key = "white",
    set = "paint",
    config = {extra = {cards = 1}},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_SGTMD_white
        return{ vars = { card.ability.extra.cards }}
    end,
    loc_txt = {
        name = "white Paint",
        text = {
            "Paints {C:attention}#1#{} selected","card white" 
        }
    },
    atlas = "paints",
    pos = {x=0,y=2},
    can_use = function (self, card)
        return #G.jokers.highlighted
				+ #G.hand.highlighted
				+ #G.consumeables.highlighted
				+ (G.pack_cards and #G.pack_cards.highlighted or 0)
			== 2
    end,
    use = function (self, card, area, copier)
        if G.jokers.highlighted[1] then
            G.jokers.highlighted[1]:set_edition("e_SGTMD_white")
        elseif G.hand.highlighted[1] then
            G.hand.highlighted[1]:set_edition("e_SGTMD_white")
        else
            if G.consumeables.highlighted[1].ability.name == "c_SGTMD_blue" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_teal"}
                --[[
            elseif G.consumeables.highlighted[1].ability.name == "c_SGTMD_sludge" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_black"}
                
            elseif G.consumeables.highlighted[1].ability.name == "c_SGTMD_black" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_gray"}
                ]]
            elseif G.consumeables.highlighted[1].ability.set == "paint" and not G.consumeables.highlighted[1].ability.name == "c_SGTMD_sludge" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_sludge"}
            else
                G.consumeables.highlighted[1]:set_edition("e_SGTMD_white")
            end
        end
    end
}

--[[
SMODS.Consumable {
    key = "black",
    set = "paint",
    config = {extra = {cards = 1}},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_SGTMD_black
        return{ vars = { card.ability.extra.cards }}
    end,
    loc_txt = {
        name = "white Paint",
        text = {
            "Paints {C:attention}#1#{} selected","card black" 
        }
    },
    atlas = "paints",
    pos = {x=0,y=2},
    can_use = function (self, card)
        return #G.jokers.highlighted
				+ #G.hand.highlighted
				+ #G.consumeables.highlighted
				+ (G.pack_cards and #G.pack_cards.highlighted or 0)
			== 2
    end,
    use = function (self, card, area, copier)
        if G.jokers.highlighted[1] then
            G.jokers.highlighted[1]:set_edition("e_SGTMD_black")
        elseif G.hand.highlighted[1] then
            G.hand.highlighted[1]:set_edition("e_SGTMD_black")
        else
            
            if G.consumeables.highlighted[1].ability.name == "c_SGTMD_white" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_gray"}
            elseif G.consumeables.highlighted[1].ability.set == "paint" and not G.consumeables.highlighted[1].ability.name == "c_SGTMD_sludge" then
                G.consumeables.highlighted[1]:start_dissolve()
                SMODS.add_card {key = "c_SGTMD_sludge"}
            else
                G.consumeables.highlighted[1]:set_edition("e_SGTMD_black")
            end
        end
    end
}
]]