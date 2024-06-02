local Weighted_Dice = {}
local game = Game()

mod.COLLECTIBLE_WEIGHTED_DICE = Isaac.GetItemIdByName("Weighted Dice")
CollectibleType.COLLECTIBLE_WEIGHTED_DICE = Isaac.GetItemIdByName("Weighted Dice")

function Weighted_Dice:postUpdate()
end

return Weighted_Dice