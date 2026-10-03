local Bottomless_Pit = {}
local game = Game()
local sfx = SFXManager()

mod.COLLECTIBLE_BOTTOMLESS_PIT = Isaac.GetItemIdByName("Bottomless Pit")
CollectibleType.COLLECTIBLE_BOTTOMLESS_PIT = Isaac.GetItemIdByName("Bottomless Pit")

local SLOTS = {ActiveSlot.SLOT_PRIMARY, ActiveSlot.SLOT_SECONDARY, ActiveSlot.SLOT_POCKET}

local DOUBLE_SUBTYPES = {
    [PickupVariant.PICKUP_BOMB] = {[BombSubType.BOMB_DOUBLEPACK] = 2},
    [PickupVariant.PICKUP_KEY] = {[KeySubType.KEY_DOUBLEPACK] = 2},
}

local function findUnchargedSlot(player)
    local maxCharge = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_BOTTOMLESS_PIT).MaxCharges
    for _, slot in ipairs(SLOTS) do
        if player:GetActiveItem(slot) == CollectibleType.COLLECTIBLE_BOTTOMLESS_PIT
            and player:GetActiveCharge(slot) < maxCharge then
            return slot, maxCharge
        end
    end
end

local function pickupCharge(pickup)
    if pickup.Variant == PickupVariant.PICKUP_COIN then
        return math.max(1, pickup:GetCoinValue())
    end
    return DOUBLE_SUBTYPES[pickup.Variant][pickup.SubType] or 1
end

function Bottomless_Pit:postUpdate()
    function Bottomless_Pit:onPickupTouch(pickup, collider, low)
        local player = collider:ToPlayer()
        if not player or pickup:GetData().PitEaten or pickup.Price ~= 0 then
            return
        end
        if pickup.Variant == PickupVariant.PICKUP_COIN and pickup.SubType == CoinSubType.COIN_STICKYNICKEL then
            return
        end
        local slot, maxCharge = findUnchargedSlot(player)
        if not slot then
            return
        end
        pickup:GetData().PitEaten = true
        player:SetActiveCharge(math.min(maxCharge, player:GetActiveCharge(slot) + pickupCharge(pickup)), slot)
        sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)
        pickup:GetSprite():Play("Collect", true)
        pickup:Die()
        return false
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Bottomless_Pit.onPickupTouch, PickupVariant.PICKUP_COIN)
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Bottomless_Pit.onPickupTouch, PickupVariant.PICKUP_BOMB)
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Bottomless_Pit.onPickupTouch, PickupVariant.PICKUP_KEY)

    function Bottomless_Pit:onUse(item, rng, player, flags, slot, varData)
        player:UseActiveItem(CollectibleType.COLLECTIBLE_MEGA_BLAST, UseFlag.USE_NOANIM)
        return true
    end
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, Bottomless_Pit.onUse, CollectibleType.COLLECTIBLE_BOTTOMLESS_PIT)
end

return Bottomless_Pit
