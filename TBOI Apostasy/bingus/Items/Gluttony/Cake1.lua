local Cake1 = {}
local game = Game()

mod.COLLECTIBLE_CAKE1 = Isaac.GetItemIdByName("Cake?")
CollectibleType.COLLECTIBLE_CAKE1 = Isaac.GetItemIdByName("Cake?")

local TEARS_UP = 1.5
local BROKEN_HEARTS = 1

function Cake1:postUpdate()
    function Cake1:onAdd(itemType, charge, firstTime, slot, varData, player)
        if not firstTime then
            return
        end
        player:AddBrokenHearts(BROKEN_HEARTS)
    end
    mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, Cake1.onAdd, CollectibleType.COLLECTIBLE_CAKE1)

    function Cake1:onCache(player, cacheFlag)
        if cacheFlag ~= CacheFlag.CACHE_FIREDELAY then
            return
        end
        local count = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CAKE1)
        if count <= 0 then
            return
        end
        local tears = 30 / (player.MaxFireDelay + 1)
        tears = tears + TEARS_UP * count
        player.MaxFireDelay = (30 / tears) - 1
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Cake1.onCache)
end

return Cake1
