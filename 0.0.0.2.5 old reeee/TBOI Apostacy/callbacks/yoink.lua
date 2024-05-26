local yoink = {}

--require character statements here
local L19_Sloth = require("bingus.characters.sloth.L19_Sloth")
local L20_Pride = require("bingus.characters.pride.L20_Pride")
local L21_Envy = require("bingus.characters.envy.L21_Envy")
local L22_Gluttony = require("bingus.characters.gluttony.L22_Gluttony")
local L23_Lust = require("bingus.characters.lust.L23_Lust")
local L24_Wrath = require("bingus.characters.wrath.L24_Wrath")

--require item statements here
local Reeee = require("bingus.Items.Pride.Reeee")

--callbacks
function yoink:bringC()
    L19_Sloth:postUpdate()
    L20_Pride:postUpdate()
    L21_Envy:postUpdate()
    L22_Gluttony:postUpdate()
    L23_Lust:postUpdate()
    L24_Wrath:postUpdate()
end

function yoink:bringI()
    Reeee:postUpdate()
end

--return
return yoink