local Inferno_Bombs = {}
local game = Game()

mod.COLLECTIBLE_INFERNO_BOMBS = Isaac.GetItemIdByName("Inferno Bombs")
CollectibleType.COLLECTIBLE_INFERNO_BOMBS = Isaac.GetItemIdByName("Inferno Bombs")

function Inferno_Bombs:postUpdate()
end

return Inferno_Bombs