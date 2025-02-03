local Cloning_Machine = {}
local game = Game()

mod.COLLECTIBLE_CLONING_MACHINE = Isaac.GetItemIdByName("Cloning Machine")
CollectibleType.COLLECTIBLE_CLONING_MACHINE = Isaac.GetItemIdByName("Cloning Machine")

function Cloning_Machine:postUpdate()
end

return Cloning_Machine