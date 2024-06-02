local Nitroglycerin = {}
local game = Game()

mod.COLLECTIBLE_NITROGLYCERIN = Isaac.GetItemIdByName("Nitroglycerin")
CollectibleType.COLLECTIBLE_NITROGLYCERIN = Isaac.GetItemIdByName("Nitroglycerin")

local NitroFlags = {
    HALFH = 0.5,
    FULLH = 1,
    DOUBLEH = 2,
    HALFSOULH = 1,
    SOULH = 1.5,
    BLACKH = 2,
    ETERNALH = 3,
    GOLDENH = 4,
    ROTTENH = 0.5,
    BONEH = 1,
    SCAREDH = 1,
    BLENDEDH = 1.25,
}
Trigger = {
    ANY = false,
    HALFH = false,
    FULLH = false,
    DOUBLEH = false,
    HALFSOULH = false,
    SOULH = false,
    BLACKH = false,
    ETERNALH = false,
    GOLDENH = false,
    ROTTENH = false,
    BONEH = false,
    SCAREDH = false,
    BLENDEDH = false,
}
local heartcount = {
    ALL = 0,
    HALFH = 0,
    FULLH = 0,
    DOUBLEH = 0,
    HALFSOULH = 0,
    SOULH = 0,
    BLACKH = 0,
    ETERNALH = 0,
    GOLDENH = 0,
    ROTTENH = 0,
    BONEH = 0,
    SCAREDH = 0,
    BLENDEDH = 0,
}

function Nitroglycerin:postUpdate()
    function Nitroglycerin:onUpdate(player)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_NITROGLYCERIN) then
            for _, entity in pairs(Isaac.GetRoomEntities()) do
                if entity.Type == EntityType.ENTITY_PICKUP and (player.Position - entity.Position):Length() < player.Size + entity.Size then
                    if entity:GetSprite():IsPlaying("Collect") and entity:GetData().Picked == nil then
                        entity:GetData().Picked = true
                        if entity.Variant == PickupVariant.PICKUP_HEART then
                            heartcount.ALL = heartcount.ALL + 1
                            Trigger.ANY = true
                            if entity.SubType == HeartSubType.HEART_HALF then
                                heartcount.HALFH = heartcount.HALFH + 1
                                Trigger.HALFH = true
                            end
                            if entity.SubType == HeartSubType.HEART_FULL then
                                heartcount.FULLH = heartcount.FULLH + 1
                                Trigger.FULLH = true
                            end
                            if entity.SubType == HeartSubType.HEART_DOUBLEPACK then
                                heartcount.DOUBLEH = heartcount.DOUBLEH + 1
                                Trigger.DOUBLEH = true
                            end
                            if entity.SubType == HeartSubType.HEART_HALF_SOUL then
                                heartcount.HALFSOULH = heartcount.HALFSOULH + 1
                                Trigger.HALFSOULH = true
                            end
                            if entity.SubType == HeartSubType.HEART_SOUL then
                                heartcount.SOULH = heartcount.SOULH + 1
                                Trigger.SOULH = true
                            end
                            if entity.SubType == HeartSubType.HEART_BLACK then
                                heartcount.BLACKH = heartcount.BLACKH + 1
                                Trigger.BLACKH = true
                            end
                            if entity.SubType == HeartSubType.HEART_ETERNAL then
                                heartcount.ETERNALH = heartcount.ETERNALH + 1
                                Trigger.ETERNALH = true
                            end
                            if entity.SubType == HeartSubType.HEART_GOLDEN then
                                heartcount.GOLDENH = heartcount.GOLDENH + 1
                                Trigger.GOLDENH = true
                            end
                            if entity.SubType == HeartSubType.HEART_ROTTEN then
                                heartcount.ROTTENH = heartcount.ROTTENH + 1
                                Trigger.ROTTENH = true
                            end
                            if entity.SubType == HeartSubType.HEART_BONE then
                                heartcount.BONEH = heartcount.BONEH + 1
                                Trigger.BONEH = true
                            end
                            if entity.SubType == HeartSubType.HEART_SCARED then
                                heartcount.SCAREDH = heartcount.SCAREDH + 1
                                Trigger.SCAREDH = true
                            end
                            if entity.SubType == HeartSubType.HEART_BLENDED then
                                heartcount.BLENDEDH = heartcount.BLENDEDH + 1
                                Trigger.BLENDEDH = true
                            end
                            player:EvaluateItems()
                            player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
                        end
                    end
                end
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Nitroglycerin.onUpdate)

    function Nitroglycerin:EvaluateCache(player, cacheFlags)
        local player = Isaac.GetPlayer(0)
        if Trigger.ANY == true then
            if Trigger.HALFH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.HALFH * (heartcount.HALFH + 1))
                end
                Trigger.HALFH = false
            end
            if Trigger.FULLH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.FULLH * (heartcount.FULLH + 1))
                end
                Trigger.FULLH = false
            end
            if Trigger.DOUBLEH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.DOUBLEH * (heartcount.DOUBLEH + 1))
                end
                Trigger.DOUBLEH = false
            end
            if Trigger.HALFSOULH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.HALFSOULH * (heartcount.HALFSOULH + 1))
                end
                Trigger.HALFSOULH = false
            end
            if Trigger.SOULH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.SOULH * (heartcount.SOULH + 1))
                end
                Trigger.SOULH = false
            end
            if Trigger.BLACKH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.BLACKH * (heartcount.BLACKH + 1))
                end
                Trigger.BLACKH = false
            end
            if Trigger.ETERNALH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.ETERNALH * (heartcount.ETERNALH + 1))
                end
                Trigger.ETERNALH = false
            end
            if Trigger.GOLDENH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.GOLDENH * (heartcount.GOLDENH + 1))
                end
                Trigger.GOLDENH = false
            end
            if Trigger.ROTTENH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.ROTTENH * (heartcount.ROTTENH + 1))
                end
                Trigger.ROTTENH = false
            end
            if Trigger.BONEH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.BONEH * (heartcount.BONEH + 1))
                end
                Trigger.BONEH = false
            end
            if Trigger.SCAREDH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.SCAREDH * (heartcount.SCAREDH + 1))
                end
                Trigger.SCAREDH = false
            end
            if Trigger.BLENDEDH == true then
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    player.Damage = player.Damage + (NitroFlags.BLENDEDH * (heartcount.BLENDEDH + 1))
                end
                Trigger.BLENDEDH = false
            end
            Trigger.ANY = false
        end
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Nitroglycerin.EvaluateCache) 
end

return Nitroglycerin