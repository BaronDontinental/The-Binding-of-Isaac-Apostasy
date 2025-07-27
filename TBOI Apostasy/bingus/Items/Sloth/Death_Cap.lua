local Death_Cap = {}
local game = Game()

mod.COLLECTIBLE_DEATH_CAP = Isaac.GetItemIdByName("Death Cap")
CollectibleType.COLLECTIBLE_DEATH_CAP = Isaac.GetItemIdByName("Death Cap")
local numyes = 0
local num = 0

function Death_Cap:postUpdate()
    ---@param player EntityPlayer
    function Death_Cap:onUpdate(player)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_DEATH_CAP) then
            player:EvaluateItems()
            player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
            player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
            for _, entity in pairs(Isaac.GetRoomEntities()) do
                local data = entity:GetData()
                if entity.Type == EntityType.ENTITY_TEAR then
                    local tear = entity:ToTear()
                    if entity.Variant == TearVariant.BLUE then
                        tear:ChangeVariant(TearVariant.BLOOD)
                    end
                end
            end
            num = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DEATH_CAP)
            if num ~= numyes then
                numyes = numyes + 1
                player:AddMaxHearts(2, true)
                player:AddRottenHearts(2)
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Death_Cap.onUpdate)
    ---@param player EntityPlayer
    ---@param cacheFlags CacheFlag
    function Death_Cap:onCache(player, cacheFlags)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_DEATH_CAP) then
            if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                player.Damage = player.Damage + 2
            end
            if(cacheFlags == CacheFlag.CACHE_TEARFLAG) then
                player.TearFlags = player.TearFlags | TearFlags.TEAR_EXPLOSIVE
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Death_Cap.onCache)

end

return Death_Cap