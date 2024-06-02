local Dud_Bomb = {}
local game = Game()

mod.COLLECTIBLE_DUD_BOMB = Isaac.GetItemIdByName("Dud Bomb")
CollectibleType.COLLECTIBLE_DUD_BOMB = Isaac.GetItemIdByName("Dud Bomb")

function Dud_Bomb:postUpdate()
end

return Dud_Bomb