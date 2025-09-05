return {
    descriptions = {
        Back = {
            b_SGTMD_nane = {
                name = "Nil",
		        text = {"naneinf"},
		        unlock = {"Score naneinf or higher"}
            },
            b_SGTMD_oops = {
                name = "Oops! All Sixes!",
                text = {"All Cards start",
                        "as 6's",
                        "Total chip's multiplied by 6",
                        "Total mult rounded to lower 6",
                        "{X:mult,C:white}X1.6{} base Blind size"}
            },
            b_SGTMD_argyle = {
                name = "Argyle Deck",
                text = {"Start run with",
                            "{C:attention}26{} {C:clubs}Clubs{} and",
                        "{C:attention}26{} {C:diamonds}Diamonds{} in deck"},
                unlock = {"Win a run with","{C:attention}Black Deck{}","on any difficulty"}
            },
            b_SGTMD_doubleup = {
                name = "Double Deck",
                text = {"There are two of",
                        "every base card"}
            },
            b_SGTMD_kingdom = {
                name = "Kingdom Deck",
                text = {"All non-face cards",
                            "are Jack's",
                        "{C:red}-2{} hand size",
                        "Earn no {C:attention}Interest{}"},
                        unlock = {"Play {C:attention}5 Gold Jacks{} in one hand"}
            },
            b_SGTMD_fuckyou = {
                name = "Fuck you",
                text = {"You start with 1",
                "card in your deck",
                "{X:mult,C:white}X0.5{} Mult",
                "Start at {C:attention}ante 0{}","Start with a {T:j_popcorn}popcorn{}",
                "{s:2.0}Fuck You{}"},
                unlock = {"{C:green}#1# in 15{} chance this","deck unlock when","losing a run"}
            },
            b_SGTMD_prodeck = {
                name = "Pro Deck",
                text = {
                    "{C:blue}+1{} hand {C:red}+1{} discard",
                    "{C:attention}+2{} hand size",
                    "Start with extra {C:money}$10{}",
                    "{X:mult,C:white}X1.4{} base Blind size",
                    "{C:red}-1{} consumeable slot",
                    "Earn no {C:attention}Interest{}"
                },
                unlock = {"Win a run with","{C:attention}Fuck you{}","on any difficulty"}
            },
            b_SGTMD_storage = {
                name = "Storage Deck",
                text = {"Any playing cards destroyed in ",
                            "a shop are duplicated twice",
                        "Create 2 {T:e_negative,C:dark_edition}Negative{} {T:c_hanged_man,C:tarot}Hanged Man{}'s",
                        "after boss blind defeated"},
                        unlock = {"Create and destroy a card","in one hand"}
        },
            b_SGTMD_shit = {
                name = "Shitposter deck",
                text = {"Start with an {T:st_eternal,T:j_egg,C:attention}Eternal Egg",
                            "Deck contains only 6, 9, 4, 2's and King of {C:hearts}Hearts{}"},
                unlock = {"Score exactly {C:attention}69{} chips",
            "on {C:green}April 20th{}"}
            },
            b_SGTMD_buno = {
                name = "Buno Deck",
                text = {"Literally just a deck",
            "of Buno cards",
        "{s:2.0,C:attention}VERY W.I.P.{}",
            "use at your own risk"},
            unlock = {"Play a High Card with","{C:attention}0{} cards held in hand"}
            },
            b_SGTMD_invisible = {
                name = "Invisible Deck",
                text = {"All cards are flipped",
                            "Create a {T:e_negative,C:dark_edition}negative{} copy","of leftmost joker when blind selected"
                        ,"Jokers are face up immediately","after boss blinds"}
            },
            b_SGTMD_betrayal = {
                name = "Deck of Betrayal",
                text = {"Start run with",
                            "{C:attention}26{} {C:hearts}Hearts{} and",
                        "{C:attention}26{} {C:diamonds}Diamonds{} in deck",
                    "Kings are replaced with Jacks",
                "{C:blue}-1{} hand every round"},
                unlock = {"Win a run with","{C:attention}Black Deck{}","on any difficulty"}
            },
            b_SGTMD_blackboard = {
                name = "Blackboard Deck",
                text = {"Start run with",
                            "{C:attention}26{} {C:spades}Spades{} and",
                        "{C:attention}26{} {C:clubs}Clubs{} in deck",
                        "2s are replaced with Aces",
                "{C:red}-1{} discard every round"},
                unlock = {"Win a run with","{C:attention}Black Deck{}","on any difficulty"}
            },
            ["b_SGTMD_letsgogambling!!!!!"] = {
                name = "Gambler's Deck",
                text = {
                    "Gain {C:money}$1{} for every","{C:chips}500{} base chips scored",
                    "{s:0.75}(chips before multiplication)",
                    "Small and Big Blinds cost {C:money}$5{}",
                    "Boss Blinds cost {C:money}$7{}",
                    "All Buy-ins return 2 to 1",
                    "reaching {C:money}$0{} ends your run"
                }
            },
            b_SGTMD_Joker = {
                name = "Joker Deck",
                text  = {
                    "All jokers and buffon packs are free",
                    "+2 joker slots",
                    "Non-jokers no longer show up in shop",
                    "{C:blue}-2{} hands every round"
                }
            },
            b_SGTMD_throwback = {
                name = "Retro Deck",
                text = {
                    "Skipping blinds creates 2 random tags",
                    "Skipping enters the shop",
                    "{C:white,X:mult}X1.5{} Base blind size"
                }
            },
            b_SGTMD_artist = {
                name = "Artist Deck",
                text = {
                    "When each blind is selected",
                    "create a random {C:blue}Paint{} card",
                    "{C:inactive}(must have room){}"
                }
        
            },
            b_SGTMD_ballot = {
                name = "Ballot Deck",
                text = {
                    "Every {C:attention}3{} rounds:","go back {C:attention}1 ante","{C:attention}-1{} hand size"
                }
            },
            b_SGTMD_piquet = {
                name = "Piquet Deck",
                text = {
                    "Start run with 32 cards","From Ace to 7","{C:blue}-1 hand{} every round"
                }
            },
            b_SGTMD_pinochle = {
                name = "Pinochle Deck",
                text = {
                    "Start run with 48 cards","From Ace to 9","{C:blue}-1 hand{} every round"
                }
            },
            b_SGTMD_thereisnogod = {
                name = "Oddly Specific Deck",
                
                text = {
                    "Play to find out what this does",
                    "{C:sgtmd_rellow};)",
                    "{C:sgtmd_bell}#1#"
                   
                }
            },
            b_SGTMD_snake = {
                name = "Snake Deck",
                text = {
                    "After Play or Discard","always draw 3 cards",
                    "{C:blue}+1{} hand and {C:red}+1{} discard per round"
                }
            },
            b_SGTMD_stone = {
                name = "Stone Deck",
                text = {
                    "Start with {C:attention}1 Joker slot{}",
                    "{C:attention}+1 Joker slot {}for every {C:attention}2","{C:blue,T:m_stone}stone cards{} in deck"
                },
                
            },
            b_SGTMD_wild = {
                name = "Wild Deck",
                text = {
                    "Scored {C:attention,T:m_wild}Wild cards{} give random effects",
                    "{C:blue}+10{} chips for every","{C:attention,T:m_wild}Wild card{} in full deck"
                }
            },
            b_SGTMD_tds = {
                name = "This Deck Sucks",
                text = {
                    "All {C:attention}Jokers{} are {C:tarot}Eternal{} (If possible)",
                    "{C:money}Money{} is limited to {C:money}$50",
                    "{C:attention}No interest{}",
                    "Buying {C:attention}ANYTHING{} in the shop will","{C:green}reroll the shop{} for {C:attention}half the cost",
                    "{C:inactive}(Won't reroll if you cant afford)"
                }
            },
            b_SGTMD_roffledeck = {
                name = "Roffle Deck",
                text = {
                    "{C:green}> Roffle Deck",
                    "{C:green}> Look inside",
                    "{C:green}> {C:attention,T:j_photograph}Photo{C:attention,T:j_hanging_chad}chad"
                }
            },
            b_SGTMD_midas = {
                name = "Midas Deck",
                text = {
                    "Start run with {C:money,T:v_seed_money}Seed Money{}",
                    "{C:attention,T:m_gold}Gold{} Cards {C:attention}are retriggered"
                }
            },
            b_SGTMD_editions = {
                name = "Editions Deck",
                text = {
                    "Every playing card can start",
                    "with a random {C:dark_edition}Edition",
                    "{C:red}-1 {C:blue}Hand{} & {C:attention}Hand Size"
                }
            },
            b_SGTMD_seals = {
                name = "Seals Deck",
                text = {
                    "Every playing card can start",
                    "with a random {C:dark_edition}Seal",
                    "{C:red}-1 {C:blue}Hand{} & {C:attention}Hand Size"
                }
            },
            b_SGTMD_enhancement = {
                name = "Enhancement Deck",
                text = {
                    "Every playing card can start",
                    "with a random {C:dark_edition}Enhancement",
                    "{C:red}-1 {C:blue}Hand{} & {C:attention}Hand Size"
                }
            },
            b_SGTMD_tuna = {
                name = "Tuna Deck",
                text = {
                    "{C:tarot}Consumables{} inside","{C:attention}Booster Packs",
                    "will be added to your","{C:attention}Consumable slots",
                    "{C:attention}when used",
                    "{C:inactive(Must have room)}"
                }
            },
            b_SGTMD_contract = {
                name = "Contractors Deck",
                text = {
                    "{C:attention}Retriggers{} your leftmost","{C:attention}Joker{} once",
                    "{C:blue,T:j_blueprint}Blueprint{} is more","likely to appear"
                }
            },
            b_SGTMD_champ = {
                name = "Champions Deck",
                text = {
                    "Start with extra {C:money}$#1#{}",
                    "{C:white,X:mult}X#2#{} mult",
                    "{C:attention}+#3#{} extra joker slot#4#",
                    "{C:inactive}(All values SCALE upon win)",
                    "{C:inactive}(All values RESET upon loss)"
                }
            },
            b_SGTMD_cheap = {
                name = "Saving Deck",
                text = {
                    "Start run with",
                    "{C:money,T:v_clearance_sale}Clearance Sale{},",
                    "and {C:green,T:v_reroll_surplus}Reroll Surplus"
                }
            },
            b_SGTMD_perkeo = {
                name = "Perkeo's Deck",
                text = {
                    "{C:attention}+1{} Consumable slot after","{C:red}Boss Blind{} defeated",
                    "{C:dark_edition,T:e_negative}Negative{} {C:attention}Jokers{} appear more"
                }
            },
            b_SGTMD_chicot = {
                name = "Chicot's Deck",
                text = {
                    "{C:white,X:mult}X0.75{} ante scaling",
                    "Start at Ante {C:attention}0{}",
                    "Start with {T:v_clearance_sale,C:tarot}Clearance Sale"
                }
            },
            b_SGTMD_caino = {
                name = "Canio's Deck",
                text = {
                    "Start with {C:attention}Double{} the face cards",
                    "Face cards start as {C:tarot,T:m_glass}Glass Cards{}",
                }
            },
            b_SGTMD_triboulet = {
                name = "Triboulet's Deck",
                text = {
                    "Retrigger every {C:attention}Face Card{}","played in last hand of round",
                    "{C:red}-1{} Hand Size",
                }
            },
            b_SGTMD_yorick = {
                name = "Yorick's Deck",
                text = {
                    "{C:red}+1{} Discard {C:attention}-1{} Joker slot",
                    "{C:white,X:mult}X0.25{} Mult for each card","discarded {C:attention}this round",
                }
            },
            b_SGTMD_chaos = {
                name = "Chaos Deck",
                text = {"{s:2}!!!"}
            },
            b_SGTMD_order = {
                name = "Order Deck",
                text = {
                    "{C:attention}Jokers{} in the shop appear",
                    "{C:green}in collection order{}",
                    "Can only buy one {C:legendary}legendary",
                    "buying a {C:legendary}legendary{} sets {C:money}dollars to -50",
                    "{C:inactive}(Highest rarity is Legendary)"

                }
            },
            b_SGTMD_consume = {
                name = "Consumers Deck",
                text = {
                    "{C:red}-1{} Consumable slot",
                    "Creates a {C:tarot}Consumable{} after each round"
                }
            },
            b_SGTMD_vanity = {
                name = "Vanity Deck",
                text = {
                    "{C:red}-1 Discard",
                    "When {C:attention}Removing a playing card{}",
                    "{C:money}-5 dollars{}","{C:tarot}+1 Consumable Slot{}"
                }
            },
            b_SGTMD_duck = {
                name = "This Deck sucks ass",
                text = {
                    "{C:red}-1 Discard{}",
                    "{C:attention}-1 Joker Slot",
                    "{C:red}-1 Shop Slot"
                }
            }
        },





        Sleeve={

            sleeve_SGTMD_oops = {
                name = "Oops! All Sixes!",
                text = {"All Cards start",
                        "as 6's",
                        "Total chip's multiplied by 6",
                        "Total mult rounded to lower 6",
                        "{X:mult,C:white}X1.6{} base Blind size"}
            },
            sleeve_SGTMD_oops_alt = {
                name = "Oops! All Sixes!",
                text = {"{C:sgtmd_oops}its all sixes"}
            },
            sleeve_SGTMD_argyle = {
                name = "Argyle Sleeve",
                text = {"Start run with",
                    "{C:attention}26{} {C:clubs}Clubs{} and",
                "{C:attention}26{} {C:diamonds}Diamonds{} in deck"}
            },
            sleeve_SGTMD_argyle_alt = {
                name = "Argyle Sleeve",
                text = {"All {C:spades}Spade{} cards will get",
                    "converted to {C:clubs}Clubs{} and",
                    "all {C:hearts}Heart{} cards will get",
                    "converted to {C:diamonds}Diamonds{}"}
            },
            sleeve_SGTMD_doubleup = {
                    name = "Double Sleeve",
                    text = {"There are two of",
                            "every base card"}
            },
            sleeve_SGTMD_doubleup_alt = {
                name = "Double Sleeve",
                text = {"There are four of",
                        "every base card"}
            },
            sleeve_SGTMD_kingdom = {
                name = "Kingdom Sleeve",
                text = {"All non-face cards",
                    "are Jack's",
                "{C:red}-2{} hand size",
                "Earn no {C:attention}Interest{}"}
            },
            sleeve_SGTMD_kingdom_alt = {
                name = "Kingdom Sleeve",
                text = {"Only {C:attention}Face Cards{} can",
                "show up this run"}
            },
            sleeve_SGTMD_fuckyou = {
                name = "Fuck you",
                text = {"You start with 1",
                "card in your deck",
                "{X:mult,C:white}X0.5{} Mult",
                "Start at {C:attention}ante 0{}","Start with a {T:j_popcorn}popcorn{}",
                "{s:2.0}Fuck You{}"}
                
            },
            sleeve_SGTMD_fuckyou_alt = {
                name = "Fuck You Too",
                text = {"No more {C:attention}interest",
                "start with {C:money}10 dollars{} of debt",
                "{X:mult,C:white}X0.25{} Mult",
                "Start with an additional {T:j_ice_cream}Ice Cream",
                
                "{s:2.0}Fuck You Too{}"}
            },
            sleeve_SGTMD_prosleeve = {
                name = "Pro Sleeve",
                text = {
                "{C:blue}+1{} hand {C:red}+1{} discard",
                "{C:attention}+2{} hand size",
                "Start with extra {C:money}$10{}",
                "{X:mult,C:white}X1.4{} base Blind size",
                "{C:red}-1{} consumable slot",
                "Earn no {C:attention}Interest{}"
                },
            },
            sleeve_SGTMD_prosleeve_alt = {
                name = "Pro Sleeve",
                text = {
                "{C:blue}+1{} hand {C:red}+1{} discard",
                "{C:attention}+3{} hand size",
                "Start with extra {C:money}$12{}",
                "{X:mult,C:white}X1.2{} base Blind size",
                "You can earn {C:attention}Interest{}"
                },
            },
            sleeve_SGTMD_betrayal = {
                name = "Sleeve of Betrayal",
		        text = {"Start run with",
					"{C:attention}26{} {C:hearts}Hearts{} and",
				    "{C:attention}26{} {C:diamonds}Diamonds{} in deck",
			        "Kings are replaced with Jacks",
		            "{C:blue}-1{} hand every round"}
            },
            sleeve_SGTMD_betrayal_alt = {
                name = "Sleeve of Betrayal",
                text = {"All {C:clubs}Clubs{} cards will get",
                    "converted to {C:diamonds}Diamonds{} and",
                    "all {C:spades}Spades{} cards will get",
                    "converted to {C:hearts}Hearts{}"}
            },
            sleeve_SGTMD_blackboard = {
                name = "Blackboard Sleeve",
                text = {"Start run with",
                "{C:attention}26{} {C:spades}Spades{} and",
                "{C:attention}26{} {C:clubs}Clubs{} in deck",
                "2s are replaced with Aces",
                "{C:red}-1{} discard every round"},
            },
            sleeve_SGTMD_blackboard_alt = {
                name = "Blackboard Sleeve",
                text = {"All {C:diamonds}Diamonds{} cards will get",
                    "converted to {C:clubs}Clubs{} and",
                    "all {C:hearts}Hearts{} cards will get",
                    "converted to {C:spades}Spades{}"}
            },
            sleeve_SGTMD_tds = {
                name = "This Sleeve Sucks",
                text = {
                    "All {C:attention}Jokers{} are {C:tarot}Eternal{} (If possible)",
                    "{C:money}Money{} is limited to {C:money}$50",
                    "{C:attention}No interest{}",
                    "Buying {C:attention}ANYTHING{} in the shop will","{C:green}reroll the shop{} for {C:attention}half the cost",
                    "{C:inactive}(Won't reroll if you cant afford)"
                }
            },
            sleeve_SGTMD_tds_alt = {
                name = "This Combo Sucks",
                text = {
                    "All {C:attention}Jokers{} are {C:tarot}Eternal{} and {C:money}Rental",
                    "{C:money}Money{} is limited to {C:money}$35",
                    "{C:attention}No interest or money from {C:blue}Hands{}",
                    "Buying {C:attention}ANYTHING{} in the shop will","{C:green}reroll the shop{} for {C:attention}half the cost",
                    "{C:inactive}(Won't reroll if you cant afford)"
                }
            },
            sleeve_SGTMD_roffledeck = {
                name = "Roffle Sleeve",
                text = {
                    "{C:green}> Roffle Sleeve",
                    "{C:green}> Look inside",
                    "{C:green}> {C:attention,T:j_photograph}Photo{C:attention,T:j_hanging_chad}chad"
                }
            },
            sleeve_SGTMD_roffledeck_alt = {
                name = "Roffle Sleeve",
                text = {
                    "{C:green}> Roffle Deck + Sleeve combo",
                    "{C:green}> Look inside",
                    "{C:green}> {C:money}Gold Stake Balatro{}"
                }
            },
            sleeve_SGTMD_midas = {
                name = "Midas Sleeve",
                text = {
                    "Start run with {C:money,T:v_seed_money}Seed Money{}",
                    "{C:attention,T:m_gold}Gold{} Cards {C:attention}are retriggered"
                }
            },
            sleeve_SGTMD_midas_alt = {
                name = "Midas Deck",
                text = {
                    "Start run with","{C:money,T:v_seed_money}Seed Money{} and {C:money,T:v_money_tree}Money Tree",
                    "{C:attention,T:m_gold}Gold{} Cards {C:attention}are retriggered TWICE"
                }
            },
            sleeve_SGTMD_joker = {
                name = "Joker Sleeve",
                text  = {
                    "All jokers and buffon packs are free",
                    "+2 joker slots",
                    "Non-jokers no longer show up in shop",
                    "{C:blue}-2{} hands every round"
                }
            },
            sleeve_SGTMD_joker_alt = {
                name = "Joker Sleeve",
                text  = {
                    "Additionally start run with",
                    "{C:green,T:v_reroll_surplus}Reroll Surplus{} and {C:attention,T:v_overstock_norm}Overstock"
                }
            },
            sleeve_SGTMD_Enhanced = {
                name = "Enhancement Sleeve",
                text = {
                    "Every playing card can start",
                    "with a random {C:dark_edition}Enhancement",
                    "{C:red}-1 {C:blue}Hand{} & {C:attention}Hand Size"
                }
            },
            sleeve_SGTMD_Enhanced_alt = {
                name = "Enhancement Sleeve",
                text = {
                    "Every playing card starts",
                    "with a random {C:dark_edition}Enhancement"
                }
            },
        },
        Blind={},
        Edition={},
        Enhanced={},
        Joker={},
        Other={
            SGTMD_consumenegative = {
                name = "Negative",
                text = {"{C:dark_edition}+1{} Consumable slot"}
            }
        },
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},

    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={},
        high_scores={},
        labels={},
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}
}
    


