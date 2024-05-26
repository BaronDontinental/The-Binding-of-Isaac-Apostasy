local Cooties = {}
local game = Game()

mod.COLLECTIBLE_COOTIES = Isaac.GetItemIdByName("Cooties")
CollectibleType.COLLECTIBLE_COOTIES = Isaac.GetItemIdByName("Cooties")

function Cooties:postUpdate()
end

return Cooties