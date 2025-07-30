local Just_Cause = {}
local game = Game()

mod.COLLECTIBLE_JUST_CAUSE = Isaac.GetTrinketIdByName("Just Cause")
TrinketType.COLLECTIBLE_JUST_CAUSE = Isaac.GetTrinketIdByName("Just Cause")


local cause = {
    bombct = 1,
    hit = 3,
    hitct = 0
}

function Just_Cause:postUpdate()
    function Just_Cause:OnDmg(player)
        player = player:ToPlayer()
        if not player:HasTrinket(TrinketType.COLLECTIBLE_JUST_CAUSE) then
            return
        end

        cause.hitct = cause.hitct + 1
        if cause.hitct == cause.hit then
            local roll = math.random(1,2)
            if roll == 1 then
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, player.Position, player.Velocity, nil):ToPickup()
            else
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL, player.Position, player.Velocity, nil):ToPickup()
            end
            cause.hitct = 0
        end
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Just_Cause.OnDmg, EntityType.ENTITY_PLAYER)
end

return Just_Cause