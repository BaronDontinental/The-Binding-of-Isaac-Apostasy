local Cold_Shoulder = {}
local game = Game()

mod.COLLECTIBLE_COLD_SHOULDER = Isaac.GetItemIdByName("Cold Shoulder?")
CollectibleType.COLLECTIBLE_COLD_SHOULDER = Isaac.GetItemIdByName("Cold Shoulder?")

function Cold_Shoulder:postUpdate()
end

return Cold_Shoulder