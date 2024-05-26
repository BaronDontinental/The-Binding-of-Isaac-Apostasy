local Chicken = {}
local game = Game()

mod.COLLECTIBLE_CHICKEN = Isaac.GetItemIdByName("Chicken")
CollectibleType.COLLECTIBLE_CHICKEN = Isaac.GetItemIdByName("Chicken")

function Chicken:postUpdate()
end

return Chicken