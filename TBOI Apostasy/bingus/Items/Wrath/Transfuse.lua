local Transfuse = {}
local game = Game()

mod.COLLECTIBLE_TRANSFUSE = Isaac.GetItemIdByName("Transfuse")
CollectibleType.COLLECTIBLE_TRANSFUSE = Isaac.GetItemIdByName("Transfuse")

local STAT_BOOSTS = {
    Damage = 0.10,
    MoveSpeed = 0.02,
    Luck = 0.1,
    ShotSpeed = 0.02,
    TearHeight = -0.5, 
    FireDelay = -1     
}

function Transfuse:postUpdate()
    function Transfuse:OnEvaluateCache(player, cacheFlag)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TRANSFUSE) then
            local data = player:GetData().TransfuseBonuses or {}

            if cacheFlag == CacheFlag.CACHE_DAMAGE and data.Damage then
                player.Damage = player.Damage + data.Damage
            elseif cacheFlag == CacheFlag.CACHE_SPEED and data.MoveSpeed then
                player.MoveSpeed = player.MoveSpeed + data.MoveSpeed
            elseif cacheFlag == CacheFlag.CACHE_LUCK and data.Luck then
                player.Luck = player.Luck + data.Luck
            elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED and data.ShotSpeed then
                player.ShotSpeed = player.ShotSpeed + data.ShotSpeed
            elseif cacheFlag == CacheFlag.CACHE_RANGE and data.TearHeight then
                player.TearHeight = player.TearHeight + data.TearHeight
            elseif cacheFlag == CacheFlag.CACHE_FIREDELAY and data.FireDelay then
                player.MaxFireDelay = player.MaxFireDelay + data.FireDelay
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Transfuse.OnEvaluateCache)

    -- When picking up a bomb
    function Transfuse:OnPickupCollect(pickup)
        local player= Isaac.GetPlayer(0)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TRANSFUSE) then
            local statNames = {}
            for stat in pairs(STAT_BOOSTS) do table.insert(statNames, stat) end

            local chosenStat = statNames[math.random(#statNames)]
            local bonus = STAT_BOOSTS[chosenStat]

            local data = player:GetData()
            data.TransfuseBonuses = data.TransfuseBonuses or {}
            data.TransfuseBonuses[chosenStat] = (data.TransfuseBonuses[chosenStat] or 0) + bonus

            player:AddCacheFlags(CacheFlag.CACHE_ALL)
            player:EvaluateItems()
        end
    end

    
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Transfuse.OnPickupCollect, PickupVariant.PICKUP_BOMB)

end

return Transfuse