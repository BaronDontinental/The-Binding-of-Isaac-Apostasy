local Hornfells_Horn = {}
local game = Game()

mod.COLLECTIBLE_HORNFELLS_HORN = Isaac.GetItemIdByName("Hornfell's Horn")
CollectibleType.COLLECTIBLE_HORNFELLS_HORN = Isaac.GetItemIdByName("Hornfell's Horn")

function Hornfells_Horn:postUpdate()
end

return Hornfells_Horn