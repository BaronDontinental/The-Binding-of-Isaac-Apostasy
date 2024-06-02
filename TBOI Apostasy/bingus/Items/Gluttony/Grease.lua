local Grease = {}
local game = Game()

mod.COLLECTIBLE_GREASE = Isaac.GetItemIdByName("Grease")
CollectibleType.COLLECTIBLE_GREASE = Isaac.GetItemIdByName("Grease")

function Grease:postUpdate()
end

return Grease