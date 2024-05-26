local Active_Carbos = {}
local game = Game()

mod.COLLECTIBLE_ACTIVE_CARBOS = Isaac.GetItemIdByName("Active Carbos")
CollectibleType.COLLECTIBLE_ACTIVE_CARBOS = Isaac.GetItemIdByName("Active Carbos")

function Active_Carbos:postUpdate()
end

return Active_Carbos