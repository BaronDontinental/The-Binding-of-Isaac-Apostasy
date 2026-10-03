local Big_Boi_Bathwater = {}
local game = Game()

mod.COLLECTIBLE_BIG_BOI_BATHWATER = Isaac.GetItemIdByName("Big, Boi, Bathwater")
CollectibleType.COLLECTIBLE_BIG_BOI_BATHWATER = Isaac.GetItemIdByName("Big, Boi, Bathwater")

function Big_Boi_Bathwater:postUpdate()
    function Big_Boi_Bathwater:onUse(item, rng, player, flags, slot, varData)
        player:UsePoopSpell(PoopSpellType.SPELL_LIQUID)
        return true
    end
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, Big_Boi_Bathwater.onUse, CollectibleType.COLLECTIBLE_BIG_BOI_BATHWATER)
end

return Big_Boi_Bathwater
