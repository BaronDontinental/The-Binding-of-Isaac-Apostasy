local Upchuck = {}
local game = Game()

mod.COLLECTIBLE_UPCHUCK = Isaac.GetItemIdByName("Upchuck")
CollectibleType.COLLECTIBLE_UPCHUCK = Isaac.GetItemIdByName("Upchuck")

function Upchuck:postUpdate()
end

return Upchuck