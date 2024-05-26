local Trench_Foot = {}
local game = Game()

mod.COLLECTIBLE_TRENCH_FOOT = Isaac.GetItemIdByName("Trench Foot")
CollectibleType.COLLECTIBLE_TRENCH_FOOT = Isaac.GetItemIdByName("Trench Foot")

function Trench_Foot:postUpdate()
end

return Trench_Foot