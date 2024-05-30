local Restraining_Order = {}
local game = Game()

mod.COLLECTIBLE_RESTRAINING_ORDER = Isaac.GetItemIdByName("Restraining Order")
CollectibleType.COLLECTIBLE_RESTRAINING_ORDER = Isaac.GetItemIdByName("Restraining Order")

function Restraining_Order:postUpdate()
end

return Restraining_Order