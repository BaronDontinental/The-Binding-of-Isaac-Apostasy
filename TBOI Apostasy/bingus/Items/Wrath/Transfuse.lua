local Transfuse = {}
local game = Game()
local SaveManager = require("callbacks.save_manager")

mod.COLLECTIBLE_TRANSFUSE = Isaac.GetItemIdByName("Transfuse")
CollectibleType.COLLECTIBLE_TRANSFUSE = Isaac.GetItemIdByName("Transfuse")

local TEAR_CAP = 5.0 

local STAT_BOOSTS = {
    Damage = 0.2,
    MoveSpeed = 0.04,
    Luck = 0.2,
    ShotSpeed = 0.04,
    Range = 6.0,   
    Tears = 0.2    
}
local bombspawn = false

--accumulated transfuse bonuses for the current run, persisted across save+continue
local bonuses = {}

function Transfuse:postUpdate()
    function Transfuse:OnUpdate(player)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TRANSFUSE) then 
            if not bombspawn then
                Isaac.Spawn(
                    EntityType.ENTITY_PICKUP,
                    PickupVariant.PICKUP_BOMB,
                    BombSubType.BOMB_NORMAL,
                    player.Position,
                    player.Velocity,
                    player):ToPickup()
                Isaac.Spawn(
                    EntityType.ENTITY_PICKUP,
                    PickupVariant.PICKUP_BOMB,
                    BombSubType.BOMB_NORMAL,
                    player.Position,
                    player.Velocity,
                    player):ToPickup()
                bombspawn = true
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Transfuse.OnUpdate)

    function Transfuse:OnEvaluateCache(player, cacheFlag)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TRANSFUSE) then
            if cacheFlag == CacheFlag.CACHE_DAMAGE and bonuses.Damage then
                player.Damage = player.Damage + bonuses.Damage
            elseif cacheFlag == CacheFlag.CACHE_SPEED and bonuses.MoveSpeed then
                player.MoveSpeed = player.MoveSpeed + bonuses.MoveSpeed
            elseif cacheFlag == CacheFlag.CACHE_LUCK and bonuses.Luck then
                player.Luck = player.Luck + bonuses.Luck
            elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED and bonuses.ShotSpeed then
                player.ShotSpeed = player.ShotSpeed + bonuses.ShotSpeed
            elseif cacheFlag == CacheFlag.CACHE_RANGE and bonuses.Range then
                player.TearRange = player.TearRange + bonuses.Range
            elseif cacheFlag == CacheFlag.CACHE_FIREDELAY and bonuses.Tears then
                local contribution = math.min(bonuses.Tears, TEAR_CAP)
                local tears = 30 / (player.MaxFireDelay + 1)
                tears = tears + contribution
                player.MaxFireDelay = (30 / tears) - 1
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Transfuse.OnEvaluateCache)

    -- When picking up a bomb
    function Transfuse:OnPickupCollect(pickup, collider, low)
        local player = collider:ToPlayer()
        if not player or not player:HasCollectible(CollectibleType.COLLECTIBLE_TRANSFUSE) then
            return
        end
        if pickup:GetData().Transfused then
            return
        end
        pickup:GetData().Transfused = true

        local statNames = {}
        for stat in pairs(STAT_BOOSTS) do table.insert(statNames, stat) end

        local chosenStat = statNames[math.random(#statNames)]
        bonuses[chosenStat] = (bonuses[chosenStat] or 0) + STAT_BOOSTS[chosenStat]
        SaveManager.Set("Transfuse", bonuses)

        player:AddCacheFlags(CacheFlag.CACHE_ALL)
        player:EvaluateItems()
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Transfuse.OnPickupCollect, PickupVariant.PICKUP_BOMB)

    function Transfuse:onGameStarted(fromSave)
        if fromSave then
            bonuses = SaveManager.Get("Transfuse") or {}
        else
            bonuses = {}
            SaveManager.Set("Transfuse", bonuses)
        end
        for i = 0, game:GetNumPlayers() - 1 do
            local player = Isaac.GetPlayer(i)
            player:AddCacheFlags(CacheFlag.CACHE_ALL)
            player:EvaluateItems()
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Transfuse.onGameStarted)

    function Transfuse:onSaveCheckpoint()
        SaveManager.Set("Transfuse", bonuses)
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, Transfuse.onSaveCheckpoint)
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Transfuse.onSaveCheckpoint)

end

return Transfuse