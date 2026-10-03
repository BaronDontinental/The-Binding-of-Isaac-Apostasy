local Le_Boom = {}
local game = Game()

mod.COLLECTIBLE_LE_BOOM = Isaac.GetItemIdByName("Le Boom")
CollectibleType.COLLECTIBLE_LE_BOOM = Isaac.GetItemIdByName("Le Boom")

local SPAWN_INTERVAL = 5 * 30

function Le_Boom:postUpdate()
    function Le_Boom:onUpdate(player)
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_LE_BOOM) then
            return
        end
        local data = player:GetData()
        data.LeBoomTimer = (data.LeBoomTimer or 0) + 1
        if data.LeBoomTimer >= SPAWN_INTERVAL then
            data.LeBoomTimer = 0
            Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_TROLL, 0, player.Position, Vector.Zero, player)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Le_Boom.onUpdate)

    function Le_Boom:onCache(player, cacheFlag)
        if cacheFlag == CacheFlag.CACHE_FLYING and player:HasCollectible(CollectibleType.COLLECTIBLE_LE_BOOM) then
            player.CanFly = true
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Le_Boom.onCache)

end

return Le_Boom
