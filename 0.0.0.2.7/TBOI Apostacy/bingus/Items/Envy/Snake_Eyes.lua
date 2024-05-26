local Snake_Eyes = {}
local game = Game()

mod.COLLECTIBLE_SNAKE_EYES = Isaac.GetItemIdByName("Snake Eyes")
CollectibleType.COLLECTIBLE_SNAKE_EYES = Isaac.GetItemIdByName("Snake Eyes")

function Snake_Eyes:postUpdate()
end

return Snake_Eyes