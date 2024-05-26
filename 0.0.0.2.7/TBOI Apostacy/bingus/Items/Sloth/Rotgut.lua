local Rotgut = {}
local game = Game()

mod.COLLECTIBLE_ROTGUT = Isaac.GetItemIdByName("Rotgut")
CollectibleType.COLLECTIBLE_ROTGUT = Isaac.GetItemIdByName("Rotgut")

function Rotgut:postUpdate()
end

return Rotgut