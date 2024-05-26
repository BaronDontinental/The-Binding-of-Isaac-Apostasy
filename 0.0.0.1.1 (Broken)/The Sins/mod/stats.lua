--[[
	DO NOT CHANGE, SCROLL DOWN TO CONFIG
]]
local mt = {
  __index = {
    items = {},
    costume = {},
    trinket = {},
    card = {},
    pill = {},
    charge = {},
    name = ""
  }
}
function mt.__index:AddItem(id, costume)
  costume = costume or false
  table.insert(self.items, {id, costume})
end

local stats = {
  default = {},
  tainted = {}
}
setmetatable(stats.default, mt)
setmetatable(stats.tainted, mt)
local character = stats.default
local tainted = stats.tainted

character.items = {}
tainted.items = {}

--[[
	CONFIG (THIS WHERE YOU CAN CHANGE STUFF)
	Try looking at MORE_INFO at the bottom of the page if you get stuck :)
]]

--[[
	REGULAR CHARACTER SETUP
]]
character.name = "L19_Sloth" -- The name of your character (must match the players.xml file).

character.stats = {
  damage = 6.50, --float
  firedelay = 8.00, --float
  shotspeed = 0.00, --float
  range = -1.00, --float
  speed = -0.20, --float
  tearflags = TearFlags.TEAR_EXPLOSIVE, --Enum "TearFlags"
  tearcolor = Color(0, 1.0, 0, 1.0, 0, 0, 0), --Color, first four arguments between 0 and 1
  flying = false, --boolean
  luck = 1.00 -- float
}



character.costume = ""

tainted.name = "B19_Sloth"
tainted.stats = {
  damage = 2.00,
  firedelay = 1.00,
  shotspeed = 1.00,
  range = 1.00,
  speed = 1.00,
  tearflags = TearFlags.TEAR_POISON | TearFlags.TEAR_FREEZE,
  tearcolor = Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0),
  flying = false,
  luck = 1.00
}

tainted.costume = ""

tainted.trinket = TrinketType.TRINKET_SWALLOWED_PENNY

tainted.card = Card.CARD_FOOL

tainted.pill = false

tainted.charge = -1

tainted:AddItem() -- I want Sad Onion and give me the costume. 


return stats