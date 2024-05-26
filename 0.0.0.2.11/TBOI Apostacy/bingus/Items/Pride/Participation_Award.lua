local Participation_Award = {}
local game = Game()

mod.COLLECTIBLE_PARTICIPATION_AWARD = Isaac.GetItemIdByName("Participation Award")
CollectibleType.COLLECTIBLE_PARTICIPATION_AWARD = Isaac.GetItemIdByName("Participation Award")

function Participation_Award:postUpdate()
end

return Participation_Award