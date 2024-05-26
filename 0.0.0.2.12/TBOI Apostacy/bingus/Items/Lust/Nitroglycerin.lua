local Nitroglycerin = {}
local game = Game()

mod.COLLECTIBLE_NITROGLYCERIN = Isaac.GetItemIdByName("Nitroglycerin")
CollectibleType.COLLECTIBLE_NITROGLYCERIN = Isaac.GetItemIdByName("Nitroglycerin")

function Nitroglycerin:postUpdate()
end

return Nitroglycerin