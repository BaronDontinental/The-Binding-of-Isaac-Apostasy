local Moar = {}
local game = Game()

mod.COLLECTIBLE_MOAR = Isaac.GetItemIdByName("Moar")
CollectibleType.COLLECTIBLE_MOAR = Isaac.GetItemIdByName("Moar")

function Moar:postUpdate()
end

return Moar