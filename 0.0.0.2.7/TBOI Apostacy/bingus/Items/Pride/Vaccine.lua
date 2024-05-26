local Vaccine = {}
local game = Game()

mod.COLLECTIBLE_VACCINE = Isaac.GetItemIdByName("Vaccine")
CollectibleType.COLLECTIBLE_VACCINE = Isaac.GetItemIdByName("Vaccine")

function Vaccine:postUpdate()
end

return Vaccine