local Message_In_A_Bottle = {}
local game = Game()

mod.TRINKET_MESSAGE_IN_A_BOTTLE = Isaac.GetTrinketIdByName("Message in a Bottle")
TrinketType.TRINKET_MESSAGE_IN_A_BOTTLE = Isaac.GetTrinketIdByName("Message in a Bottle")

local TRIGGER_CHANCE = 2

function Message_In_A_Bottle:postUpdate()

    function Message_In_A_Bottle:onDamage(entity, amount, flags, source, countdown)
        local player = entity:ToPlayer()
        if not player then
            return
        end
        if not player:HasTrinket(TrinketType.TRINKET_MESSAGE_IN_A_BOTTLE) then
            return
        end
        if math.random(100) > TRIGGER_CHANCE then
            return
        end
        local poolId = Isaac.GetPoolIdByName("Paper")
        if poolId < 0 then
            return
        end
        local seed = math.max(Random(), 1)
        local itemId = game:GetItemPool():GetCollectible(poolId, false, seed)
        if not itemId or itemId <= 0 then
            return
        end
        player:TryRemoveTrinket(TrinketType.TRINKET_MESSAGE_IN_A_BOTTLE)
        local pos = game:GetRoom():FindFreePickupSpawnPosition(player.Position, 0, true)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemId, pos, Vector.Zero, player)
    end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Message_In_A_Bottle.onDamage, EntityType.ENTITY_PLAYER)

end

return Message_In_A_Bottle