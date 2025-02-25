mod = RegisterMod("The Binding Of Isaac: Apostasy", 1)
local game = Game()

local yoink = require("callbacks.yoink") --Creates the Yoink callback as a way to organize

-- Debug Shenanagins
DebugText = "Placeholder"
DebugMode = true
IncreaseColorCharge = true
ColorTint = 0

print("Hello, Welcome to The Binding of Isaac Apostasy.  The mod has loaded successfully.")
print("Mod version: 0.0.0.4.2")

yoink:bringC() --brings characters
yoink:bringI() --brings items
yoink:bringP() --brings pools