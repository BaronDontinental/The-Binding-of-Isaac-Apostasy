local Death_Cap = {}
local game = Game()

mod.COLLECTIBLE_DEATH_CAP = Isaac.GetItemIdByName("Death Cap")
CollectibleType.COLLECTIBLE_DEATH_CAP = Isaac.GetItemIdByName("Death Cap")

function Death_Cap:postUpdate()
end

return Death_Cap