local postUpdate = {}

local testitem = require("TheSins.bingus.items.testitem") -- this brings the "testitem" code from the bingus file

function postUpdate:init(mod)
  mod:AddCallback(ModCallbacks.MC_POST_UPDATE, postUpdate.main)
end  -- general postUpdate shizzle

function postUpdate:main()
  testitem:postUpdate()  -- this runs the fucntions in the testitem file.
end

return postUpdate