local Cake2 = {}
local game = Game()

mod.COLLECTIBLE_CAKE2 = Isaac.GetItemIdByName("Cake!")
CollectibleType.COLLECTIBLE_CAKE2 = Isaac.GetItemIdByName("Cake!")

local WISH_QUALITY = 4

local function wishCandidates(itemPool, poolType)
    local config = Isaac.GetItemConfig()
    local candidates = {}
    for _, entry in ipairs(itemPool:GetCollectiblesFromPool(poolType)) do
        local item = config:GetCollectible(entry.itemID)
        if entry.weight > 0 and item and item.Quality == WISH_QUALITY
            and itemPool:CanSpawnCollectible(entry.itemID, false) then
            table.insert(candidates, entry.itemID)
        end
    end
    return candidates
end

local function rollWish(rng)
    local itemPool = game:GetItemPool()
    local room = game:GetRoom()
    local poolType = itemPool:GetPoolForRoom(room:GetType(), rng:Next())
    if poolType == ItemPoolType.POOL_NULL then
        poolType = ItemPoolType.POOL_TREASURE
    end
    local candidates = wishCandidates(itemPool, poolType)
    if #candidates == 0 and poolType ~= ItemPoolType.POOL_TREASURE then
        poolType = ItemPoolType.POOL_TREASURE
        candidates = wishCandidates(itemPool, poolType)
    end
    if #candidates == 0 then
        return itemPool:GetCollectible(poolType, true, rng:Next())
    end
    return itemPool:GetCollectibleFromList(candidates, rng:Next(), candidates[1], true)
end

function Cake2:postUpdate()
    function Cake2:onUse(item, rng, player, flags, slot, varData)
        local room = game:GetRoom()
        local pos = room:FindFreePickupSpawnPosition(player.Position + Vector(0, 40), 0, true)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, rollWish(rng), pos, Vector.Zero, player)
        return {Discharge = true, Remove = true, ShowAnim = true}
    end
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, Cake2.onUse, CollectibleType.COLLECTIBLE_CAKE2)
end

return Cake2
