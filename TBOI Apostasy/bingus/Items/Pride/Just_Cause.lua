local Just_Cause = {}
local game = Game()

mod.COLLECTIBLE_JUST_CAUSE = Isaac.GetTrinketIdByName("Just Cause")
TrinketType.COLLECTIBLE_JUST_CAUSE = Isaac.GetTrinketIdByName("Just Cause")

-- Track damage taken per player
local damageTracker = {}

function Just_Cause:postUpdate()
    -- Damage tracking callback
    ---@param target EntityPlayer
    function Just_Cause:OnTakeDamage(target)
        local player = target:ToPlayer()
        if not player then
            return
        end

        -- Check if player has Just Cause
        if not player:HasTrinket(mod.COLLECTIBLE_JUST_CAUSE) then
            return
        end

        -- Get player index for tracking
        local playerIndex = player:GetCollectibleRNG(mod.COLLECTIBLE_JUST_CAUSE):GetSeed()

        -- Initialize damage counter if not exists
        if not damageTracker[playerIndex] then
            damageTracker[playerIndex] = 0
        end

        -- Increment damage counter
        damageTracker[playerIndex] = damageTracker[playerIndex] + 1

        -- Check if we've reached 3 damage instances
        if damageTracker[playerIndex] >= 3 then
            -- Reset counter
            damageTracker[playerIndex] = 0

            -- Get player position
            local playerPos = player.Position

            -- Randomly choose between bomb or key (50/50 chance)
            local rng = player:GetCollectibleRNG(mod.COLLECTIBLE_JUST_CAUSE)
            local spawnBomb = rng:RandomInt(2) == 0

            if spawnBomb then
                -- Spawn bomb pickup
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, playerPos, Vector.Zero, nil):ToPickup()
            else
                -- Spawn key pickup
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL, playerPos, Vector.Zero, nil):ToPickup()
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Just_Cause.OnTakeDamage, EntityType.ENTITY_PLAYER)

    -- Reset damage tracker on new game
    function Just_Cause:OnGameStart()
        if(game:GetFrameCount() == 1) then
            damageTracker = {}
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Just_Cause.OnGameStart)
end

return Just_Cause