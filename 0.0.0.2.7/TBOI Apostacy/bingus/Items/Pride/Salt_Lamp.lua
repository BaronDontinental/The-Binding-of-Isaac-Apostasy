local Salt_Lamp = {}
local game = Game()

mod.COLLECTIBLE_SALT_LAMP = Isaac.GetItemIdByName("Salt Lamp")
CollectibleType.COLLECTIBLE_SALT_LAMP = Isaac.GetItemIdByName("Salt Lamp")

function Salt_Lamp:postUpdate()
end

return Salt_Lamp