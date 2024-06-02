local Empathy_Syringe = {}
local game = Game()

mod.COLLECTIBLE_EMPATHY_SYRINGE = Isaac.GetItemIdByName("Empathy Syringe")
CollectibleType.COLLECTIBLE_EMPATHY_SYRINGE = Isaac.GetItemIdByName("Empathy Syringe")

function Empathy_Syringe:postUpdate()
end

return Empathy_Syringe