local grab = {}

--require statements here
local bingo = require("bingus.bingus")
local L19_Sloth = require("bingus.characters.L19_Sloth")
--callbacks

function grab:bring()
    bingo:postUpdate()
    L19_Sloth:postUpdate()
end

--return
return grab