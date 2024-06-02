local Devour = {}
local game = Game()

mod.COLLECTIBLE_DEVOUR = Isaac.GetItemIdByName("Devour")
CollectibleType.COLLECTIBLE_DEVOUR = Isaac.GetItemIdByName("Devour")

function Devour:postUpdate()
end

return Devour