local Blank_Tile = {}
local game = Game()

mod.COLLECTIBLE_BLANK_TILE = Isaac.GetItemIdByName("Blank Tile")
CollectibleType.COLLECTIBLE_BLANK_TILE = Isaac.GetItemIdByName("Blank Tile")

function Blank_Tile:postUpdate()
end

return Blank_Tile