local Yin_Yang = {}
local game = Game()

mod.COLLECTIBLE_YIN_YANG = Isaac.GetItemIdByName("Yin-Yang")
CollectibleType.COLLECTIBLE_YIN_YANG = Isaac.GetItemIdByName("Yin-Yang")

function Yin_Yang:postUpdate()
end

return Yin_Yang