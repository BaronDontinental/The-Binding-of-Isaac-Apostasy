local Transfuse = {}
local game = Game()

mod.COLLECTIBLE_TRANSFUSE = Isaac.GetItemIdByName("Transfuse")
CollectibleType.COLLECTIBLE_TRANSFUSE = Isaac.GetItemIdByName("Transfuse")

function Transfuse:postUpdate()
end

return Transfuse