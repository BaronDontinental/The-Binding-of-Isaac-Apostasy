local Nitroglycerin = {}
local game = Game()
local SaveManager = require("callbacks.save_manager")

mod.COLLECTIBLE_NITROGLYCERIN = Isaac.GetItemIdByName("Nitroglycerin")
CollectibleType.COLLECTIBLE_NITROGLYCERIN = Isaac.GetItemIdByName("Nitroglycerin")

local TYPE_CAPS = {
    RED = 0.5,
    SOUL = 0.5,
    ROTTEN = 0.5,
    BLENDED = 0.5,
    BLACK = 0.75,
    BONE = 0.75,
    ETERNAL = 1.0,
    GOLDEN = 1.0,
}

local HEART_DAMAGE = {
    [HeartSubType.HEART_HALF] = {type = "RED", amount = 0.06},
    [HeartSubType.HEART_FULL] = {type = "RED", amount = 0.13},
    [HeartSubType.HEART_DOUBLEPACK] = {type = "RED", amount = 0.25},
    [HeartSubType.HEART_SCARED] = {type = "RED", amount = 0.13},
    [HeartSubType.HEART_HALF_SOUL] = {type = "SOUL", amount = 0.06},
    [HeartSubType.HEART_SOUL] = {type = "SOUL", amount = 0.13},
    [HeartSubType.HEART_BLACK] = {type = "BLACK", amount = 0.19},
    [HeartSubType.HEART_ETERNAL] = {type = "ETERNAL", amount = 0.25},
    [HeartSubType.HEART_GOLDEN] = {type = "GOLDEN", amount = 0.25},
    [HeartSubType.HEART_ROTTEN] = {type = "ROTTEN", amount = 0.06},
    [HeartSubType.HEART_BONE] = {type = "BONE", amount = 0.19},
    [HeartSubType.HEART_BLENDED] = {type = "BLENDED", amount = 0.13},
}

local bonuses = {}

local function playerBonuses(key)
    if type(bonuses[key]) ~= "table" then
        bonuses[key] = {}
    end
    return bonuses[key]
end

local function totalBonus(key)
    local total = 0
    for _, value in pairs(playerBonuses(key)) do
        total = total + value
    end
    return total
end

local function playerKey(player)
    for i = 0, game:GetNumPlayers() - 1 do
        if GetPtrHash(Isaac.GetPlayer(i)) == GetPtrHash(player) then
            return tostring(i)
        end
    end
    return "0"
end

function Nitroglycerin:postUpdate()
    function Nitroglycerin:onHeartTouch(pickup, collider, low)
        local player = collider:ToPlayer()
        if not player or not player:HasCollectible(CollectibleType.COLLECTIBLE_NITROGLYCERIN) then
            return
        end
        pickup:GetData().NitroPlayer = player
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Nitroglycerin.onHeartTouch, PickupVariant.PICKUP_HEART)

    function Nitroglycerin:onHeartUpdate(pickup)
        local data = pickup:GetData()
        if not data.NitroPlayer or data.NitroCounted or not pickup:GetSprite():IsPlaying("Collect") then
            return
        end
        data.NitroCounted = true
        local player = data.NitroPlayer
        local heart = HEART_DAMAGE[pickup.SubType]
        if not heart or not player:Exists() then
            return
        end
        local typeBonuses = playerBonuses(playerKey(player))
        local cap = TYPE_CAPS[heart.type]
        local current = typeBonuses[heart.type] or 0
        if current >= cap then
            return
        end
        typeBonuses[heart.type] = math.min(cap, current + heart.amount)
        SaveManager.Set("Nitroglycerin", bonuses)
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
        player:EvaluateItems()
    end
    mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, Nitroglycerin.onHeartUpdate, PickupVariant.PICKUP_HEART)

    function Nitroglycerin:EvaluateCache(player, cacheFlags)
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_NITROGLYCERIN) then
            return
        end
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + totalBonus(playerKey(player))
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Nitroglycerin.EvaluateCache)

    function Nitroglycerin:onGameStarted(fromSave)
        if fromSave then
            bonuses = SaveManager.Get("Nitroglycerin") or {}
        else
            bonuses = {}
            SaveManager.Set("Nitroglycerin", bonuses)
        end
        for i = 0, game:GetNumPlayers() - 1 do
            local player = Isaac.GetPlayer(i)
            player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
            player:EvaluateItems()
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Nitroglycerin.onGameStarted)

    function Nitroglycerin:onSaveCheckpoint()
        SaveManager.Set("Nitroglycerin", bonuses)
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, Nitroglycerin.onSaveCheckpoint)
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Nitroglycerin.onSaveCheckpoint)
end

return Nitroglycerin
