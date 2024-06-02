local Epipen = {}
local game = Game()

mod.COLLECTIBLE_EPIPEN = Isaac.GetItemIdByName("Epipen")
CollectibleType.COLLECTIBLE_EPIPEN = Isaac.GetItemIdByName("Epipen")

function Epipen:postUpdate()
end

return Epipen