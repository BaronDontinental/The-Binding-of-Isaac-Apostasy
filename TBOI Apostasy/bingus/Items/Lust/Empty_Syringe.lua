local Empty_Syringe = {}
local game = Game()
local sfx = SFXManager()

mod.COLLECTIBLE_EMPTY_SYRINGE = Isaac.GetItemIdByName("Empty Syringe")
CollectibleType.COLLECTIBLE_EMPTY_SYRINGE = Isaac.GetItemIdByName("Empty Syringe")

local HUG_DAMAGE_MULT = 2
local HUG_COOLDOWN = 10
local HUG_KNOCKBACK = 6

local RED_CHARGE = {
    [HeartSubType.HEART_HALF] = 1,
    [HeartSubType.HEART_FULL] = 2,
    [HeartSubType.HEART_SCARED] = 2,
    [HeartSubType.HEART_DOUBLEPACK] = 4,
    [HeartSubType.HEART_BLENDED] = 2,
}

local SLOTS = {ActiveSlot.SLOT_PRIMARY, ActiveSlot.SLOT_SECONDARY, ActiveSlot.SLOT_POCKET}

local function findUnchargedSlot(player)
    local maxCharge = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_EMPTY_SYRINGE).MaxCharges
    for _, slot in ipairs(SLOTS) do
        if player:GetActiveItem(slot) == CollectibleType.COLLECTIBLE_EMPTY_SYRINGE
            and player:GetActiveCharge(slot) < maxCharge then
            return slot, maxCharge
        end
    end
end

function Empty_Syringe:postUpdate()
    function Empty_Syringe:onHeartTouch(pickup, collider, low)
        local player = collider:ToPlayer()
        if not player or pickup:GetData().SyringeDrained or pickup.Price ~= 0 then
            return
        end
        local charge = RED_CHARGE[pickup.SubType]
        if not charge then
            return
        end
        local slot, maxCharge = findUnchargedSlot(player)
        if not slot then
            return
        end
        pickup:GetData().SyringeDrained = true
        player:SetActiveCharge(math.min(maxCharge, player:GetActiveCharge(slot) + charge), slot)
        sfx:Play(SoundEffect.SOUND_BATTERYCHARGE, 1, 0, false, 1)
        pickup:GetSprite():Play("Collect", true)
        pickup:Die()
        return false
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Empty_Syringe.onHeartTouch, PickupVariant.PICKUP_HEART)

    function Empty_Syringe:onUse(item, rng, player, flags, slot, varData)
        player:UseActiveItem(CollectibleType.COLLECTIBLE_UNICORN_STUMP, UseFlag.USE_NOANIM)
        player:GetData().SyringeHug = true
        return true
    end
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, Empty_Syringe.onUse, CollectibleType.COLLECTIBLE_EMPTY_SYRINGE)

    function Empty_Syringe:onPlayerUpdate(player)
        local data = player:GetData()
        if data.SyringeHug and not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_UNICORN_STUMP) then
            data.SyringeHug = nil
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Empty_Syringe.onPlayerUpdate)

    function Empty_Syringe:onHug(player, collider, low)
        if not player:GetData().SyringeHug then
            return
        end
        if not collider:IsActiveEnemy() or not collider:IsVulnerableEnemy()
            or collider:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
            return
        end
        local data = collider:GetData()
        local frame = game:GetFrameCount()
        if data.SyringeHugFrame and frame - data.SyringeHugFrame < HUG_COOLDOWN then
            return
        end
        data.SyringeHugFrame = frame
        collider:TakeDamage(player.Damage * HUG_DAMAGE_MULT, 0, EntityRef(player), 0)
        collider:AddVelocity((collider.Position - player.Position):Resized(HUG_KNOCKBACK))
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, Empty_Syringe.onHug)
end

return Empty_Syringe
