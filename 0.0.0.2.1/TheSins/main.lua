local mod = RegisterMod("The Sins Project", 1)

local postUpdate = require("callbacks.postUpdate")

postUpdate:init(mod)

postUpdate:main()

