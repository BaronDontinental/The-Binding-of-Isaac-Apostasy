local Puzzle_Cube = {}
local game = Game()

mod.COLLECTIBLE_PUZZLE_CUBE = Isaac.GetItemIdByName("Puzzle Cube")
CollectibleType.COLLECTIBLE_PUZZLE_CUBE = Isaac.GetItemIdByName("Puzzle Cube")

function Puzzle_Cube:postUpdate()
end

return Puzzle_Cube