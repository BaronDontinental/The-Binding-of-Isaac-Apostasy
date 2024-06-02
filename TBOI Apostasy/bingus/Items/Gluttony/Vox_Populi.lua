local Vox_Populi = {}
local game = Game()

mod.COLLECTIBLE_VOX_POPULI = Isaac.GetItemIdByName("Vox Populi")
CollectibleType.COLLECTIBLE_VOX_POPULI = Isaac.GetItemIdByName("Vox Populi")

function Vox_Populi:postUpdate()
end

return Vox_Populi