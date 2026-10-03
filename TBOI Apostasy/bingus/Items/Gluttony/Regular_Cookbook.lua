local Regular_Cookbook = {}
local game = Game()

mod.COLLECTIBLE_REGULAR_COOKBOOK = Isaac.GetItemIdByName("Regular Cookbook")
CollectibleType.COLLECTIBLE_REGULAR_COOKBOOK = Isaac.GetItemIdByName("Regular Cookbook")

local LUNCH_ITEMS = {
    CollectibleType.COLLECTIBLE_LUNCH,
    CollectibleType.COLLECTIBLE_DINNER,
    CollectibleType.COLLECTIBLE_DESSERT,
    CollectibleType.COLLECTIBLE_BREAKFAST,
    CollectibleType.COLLECTIBLE_ROTTEN_MEAT,
    CollectibleType.COLLECTIBLE_SNACK,
    CollectibleType.COLLECTIBLE_MIDNIGHT_SNACK,
    CollectibleType.COLLECTIBLE_SUPPER,
}

function Regular_Cookbook:postUpdate()
    function Regular_Cookbook:onUse(item, rng, player, flags, slot, varData)
        local lunch = LUNCH_ITEMS[rng:RandomInt(#LUNCH_ITEMS) + 1]
        local pos = game:GetRoom():FindFreePickupSpawnPosition(player.Position + Vector(0, 40), 0, true)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, lunch, pos, Vector.Zero, player)
        return true
    end
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, Regular_Cookbook.onUse, CollectibleType.COLLECTIBLE_REGULAR_COOKBOOK)
end

return Regular_Cookbook
