local Bowling_Bombs = {}
local game = Game()

mod.COLLECTIBLE_BOWLING_BOMBS = Isaac.GetItemIdByName("Bowling Bombs")
CollectibleType.COLLECTIBLE_BOWLING_BOMBS = Isaac.GetItemIdByName("Bowling Bombs")

function Bowling_Bombs:postUpdate()
end

return Bowling_Bombs