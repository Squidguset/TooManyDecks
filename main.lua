local atlases = {
SMODS.Atlas {
	key = "decks sleeves",
	px = 73,
	py = 95,
	path = "sleeves.png"
},
SMODS.Atlas {
	key = "modicon",
	px = 32,
	py = 32,
	path = "modicon.png"
},
SMODS.Atlas {
	key = "thedeckblind",
	px = 34,
	py = 34,
	atlas_table = 'ANIMATION_ATLAS',
	path = "deckblind.png",
	frames = 21
},
SMODS.Atlas {
	key = "modified",
	px = 71,
	py = 95,
	path = "modified.png",
},
SMODS.Atlas {
	key = "legendary",
	px = 71,
	py = 95,
	path = "legendaries.png",
},
}
deckstext = SMODS.Atlas {
	key = "decks",
	px = 71,
	py = 95,
	path = "decks.png"
}
atlases[#atlases+1] = deckstext


assert(SMODS.load_file("items/miscstuffs.lua"))()

TMD.atlases = atlases
TMD.Decks = {}

-- Decks revolving around suits (e.g. Argyle) loaded first so that argyle shows up first
assert(SMODS.load_file("decks/suits.lua"))()
-- Simpler decks (e.g. Saving)
assert(SMODS.load_file("decks/simple.lua"))()
-- All other decks
assert(SMODS.load_file("decks/base.lua"))()
-- Enhancement themed Decks {e.g. Midas}
assert(SMODS.load_file("decks/enhancements.lua"))()
-- Challenge decks (e.g. Fuck You)
assert(SMODS.load_file("decks/challenge.lua"))()
-- specific deck
assert(SMODS.load_file("decks/iamgoingtohaveaheadache.lua"))()
-- Legendary themed decks 
assert(SMODS.load_file("decks/legendaries.lua"))()

if  SMODS.current_mod.config.Bonus then assert(SMODS.load_file("decks/extra.lua"))() end
if CardSleeves then assert(SMODS.load_file("items/sleeves.lua"))() end