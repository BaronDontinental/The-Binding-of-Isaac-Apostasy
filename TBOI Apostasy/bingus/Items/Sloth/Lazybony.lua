local Lazybony = {}
local game = Game()

mod.COLLECTIBLE_LAZYBONY = Isaac.GetItemIdByName("Lazybony")
CollectibleType.COLLECTIBLE_LAZYBONY = Isaac.GetItemIdByName("Lazybony")

function Lazybony:postUpdate()
end

return Lazybony