local Slug = {}
local game = Game()

mod.COLLECTIBLE_SLUG = Isaac.GetItemIdByName("Slug")
CollectibleType.COLLECTIBLE_SLUG = Isaac.GetItemIdByName("Slug")

function Slug:postUpdate()
end

return Slug