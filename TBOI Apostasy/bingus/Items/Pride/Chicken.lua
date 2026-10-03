local Chicken = {}
local game = Game()

mod.COLLECTIBLE_CHICKEN = Isaac.GetItemIdByName("Chicken")
CollectibleType.COLLECTIBLE_CHICKEN = Isaac.GetItemIdByName("Chicken")

local GRAZE_RADIUS = 80  --40 per tile
local DAMAGE_PER_TEAR = 0.5
local DAMAGE_CAP = 3
local DECAY_PER_FRAME = 0.02
local REFRESH_STEP = 0.05

local function grazeTarget(player)
    local count = 0
    for _, projectile in ipairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE)) do
        if projectile.Position:Distance(player.Position) <= GRAZE_RADIUS + projectile.Size + player.Size then
            count = count + 1
        end
    end
    return math.min(DAMAGE_CAP, count * DAMAGE_PER_TEAR)
end

function Chicken:postUpdate()
    function Chicken:onUpdate(player)
        local data = player:GetData()
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_CHICKEN) then
            if data.ChickenBonus then
                data.ChickenBonus = nil
                data.ChickenApplied = nil
                player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
                player:EvaluateItems()
            end
            return
        end
        local current = data.ChickenBonus or 0
        local target = grazeTarget(player)
        if target > current then
            current = target
        else
            current = math.max(target, current - DECAY_PER_FRAME)
        end
        data.ChickenBonus = current
        if math.abs(current - (data.ChickenApplied or 0)) >= REFRESH_STEP
            or (current == 0 and (data.ChickenApplied or 0) ~= 0) then
            data.ChickenApplied = current
            player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
            player:EvaluateItems()
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Chicken.onUpdate)

    function Chicken:onCache(player, cacheFlag)
        if cacheFlag == CacheFlag.CACHE_DAMAGE and player:HasCollectible(CollectibleType.COLLECTIBLE_CHICKEN) then
            player.Damage = player.Damage + (player:GetData().ChickenApplied or 0)
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Chicken.onCache)
end

return Chicken
