local Bottomless_Pit = {}
local game = Game()

mod.COLLECTIBLE_BOTTOMLESS_PIT = Isaac.GetItemIdByName("Bottomless Pit")
CollectibleType.COLLECTIBLE_BOTTOMLESS_PIT = Isaac.GetItemIdByName("Bottomless Pit")

function Bottomless_Pit:postUpdate()
end

return Bottomless_Pit