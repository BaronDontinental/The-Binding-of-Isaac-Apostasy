mod = RegisterMod("The Binding Of Isaac: Apostasy", 1)
local game = Game()

local yoink = require("callbacks.yoink") --Creates the Yoik callback as a way to organize

-- Debug Shenanagins
DebugText = "Placeholder"
DebugMode = true
IncreaseColorCharge = true
ColorTint = 0

print("Hello Gomper, my name is Bingus!  The Mod has successfully booted!")

yoink:bringC() --brings characters
yoink:bringI() --brings items
