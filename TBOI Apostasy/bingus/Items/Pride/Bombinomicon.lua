local Bombinomicon = {}
local game = Game()

mod.COLLECTIBLE_BOMBINOMICON = Isaac.GetItemIdByName("Bombinomicon")
CollectibleType.COLLECTIBLE_BOMBINOMICON = Isaac.GetItemIdByName("Bombinomicon")

function Bombinomicon:postUpdate()
end

return Bombinomicon