local House_Arrest = {}
local game = Game()

mod.COLLECTIBLE_HOUSE_ARREST = Isaac.GetItemIdByName("House Arrest")
CollectibleType.COLLECTIBLE_HOUSE_ARREST = Isaac.GetItemIdByName("House Arrest")

function House_Arrest:postUpdate()
end

return House_Arrest