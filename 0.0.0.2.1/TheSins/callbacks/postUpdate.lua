local postUpdate = {}

-- This section is reserved for the localization of characters
local L19_Sloth = require("bingus.characers.L19_Sloth.lua") -- this brings the "L19_Sloth" code from the bingus file

function postUpdate:init(mod)
  mod:AddCallback(ModCallbacks.MC_POST_UPDATE, postUpdate.main)
end  -- general postUpdate shizzle

function postUpdate:main()
  L19_Sloth:postUpdate()  -- this runs the fucntions in the L19_Sloth file.
end

return postUpdate