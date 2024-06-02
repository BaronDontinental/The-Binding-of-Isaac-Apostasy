local Blitzfrag = {}
local game = Game()

mod.COLLECTIBLE_BLITZFRAG = Isaac.GetItemIdByName("Blitzfrag")
CollectibleType.COLLECTIBLE_BLITZFRAG = Isaac.GetItemIdByName("Blitzfrag")

function Blitzfrag:postUpdate()
end

return Blitzfrag