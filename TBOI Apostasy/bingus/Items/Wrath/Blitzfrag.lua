local Blitzfrag = {}
local game = Game()

mod.COLLECTIBLE_BLITZFRAG = Isaac.GetItemIdByName("Blitzfrag")
CollectibleType.COLLECTIBLE_BLITZFRAG = Isaac.GetItemIdByName("Blitzfrag")

local MAX_CHARGE = 12
local OVERCHARGE = MAX_CHARGE * 2
local BASE_DAMAGE = 20
local DAMAGE_PER_CHARGE = 10
local BASE_RADIUS = 0.5
local RADIUS_PER_CHARGE = 0.15

function Blitzfrag:postUpdate()
    function Blitzfrag:minCharge(slot, player, current)
        return 1
    end
    mod:AddCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MIN_USABLE_CHARGE, Blitzfrag.minCharge, CollectibleType.COLLECTIBLE_BLITZFRAG)

    function Blitzfrag:preUse(item, rng, player, flags, slot, varData)
        local data = player:GetData()
        if slot >= 0 then
            data.BlitzCharge = player:GetActiveCharge(slot) + player:GetBatteryCharge(slot)
            data.BlitzDrainSlot = slot
        else
            data.BlitzCharge = MAX_CHARGE
        end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, Blitzfrag.preUse, CollectibleType.COLLECTIBLE_BLITZFRAG)

    function Blitzfrag:onUse(item, rng, player, flags, slot, varData)
        local data = player:GetData()
        local charges = math.max(1, math.min(OVERCHARGE, data.BlitzCharge or MAX_CHARGE))
        data.BlitzCharge = nil
        data.BlitzBlastFrame = game:GetFrameCount()
        if charges >= OVERCHARGE then
            player:UseActiveItem(CollectibleType.COLLECTIBLE_MAMA_MEGA, UseFlag.USE_NOANIM)
        elseif charges >= MAX_CHARGE then
            game:GetRoom():MamaMegaExplosion(player.Position, player)
        else
            game:BombExplosionEffects(
                player.Position,
                BASE_DAMAGE + DAMAGE_PER_CHARGE * charges,
                TearFlags.TEAR_NORMAL,
                Color.Default,
                player,
                BASE_RADIUS + RADIUS_PER_CHARGE * charges,
                true,
                false,
                DamageFlag.DAMAGE_EXPLOSION)
        end
        return true
    end
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, Blitzfrag.onUse, CollectibleType.COLLECTIBLE_BLITZFRAG)

    function Blitzfrag:drain(player)
        local data = player:GetData()
        if not data.BlitzDrainSlot then
            return
        end
        if player:GetActiveItem(data.BlitzDrainSlot) == CollectibleType.COLLECTIBLE_BLITZFRAG then
            player:SetActiveCharge(0, data.BlitzDrainSlot)
        end
        data.BlitzDrainSlot = nil
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Blitzfrag.drain)

    function Blitzfrag:selfBlast(entity, amount, flags, source, countdown)
        local player = entity:ToPlayer()
        if not player or flags & DamageFlag.DAMAGE_EXPLOSION == 0 then
            return
        end
        if player:GetData().BlitzBlastFrame == game:GetFrameCount() then
            return false
        end
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Blitzfrag.selfBlast, EntityType.ENTITY_PLAYER)
end

return Blitzfrag
