local Lil_Wrath = {}
local game = Game()

mod.COLLECTIBLE_LIL_WRATH = Isaac.GetItemIdByName("Lil Wrath")
CollectibleType.COLLECTIBLE_LIL_WRATH = Isaac.GetItemIdByName("Lil Wrath")
FAMILIAR_LIL_WRATH = Isaac.GetEntityVariantByName("Lil Wrath")


function Lil_Wrath:postUpdate()
end

return Lil_Wrath