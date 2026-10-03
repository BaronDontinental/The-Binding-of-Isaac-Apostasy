local Yin_Yang = {}
local game = Game()
local SaveManager = require("callbacks.save_manager")

mod.COLLECTIBLE_YIN_YANG = Isaac.GetItemIdByName("Yin-Yang")
CollectibleType.COLLECTIBLE_YIN_YANG = Isaac.GetItemIdByName("Yin-Yang")

local SWAPPED_POOLS = {
    [ItemPoolType.POOL_DEVIL] = ItemPoolType.POOL_ANGEL,
    [ItemPoolType.POOL_ANGEL] = ItemPoolType.POOL_DEVIL,
    [ItemPoolType.POOL_GREED_DEVIL] = ItemPoolType.POOL_GREED_ANGEL,
    [ItemPoolType.POOL_GREED_ANGEL] = ItemPoolType.POOL_GREED_DEVIL,
}

local swapped = false
local rerolling = false

local function anyoneHasYinYang()
    for i = 0, game:GetNumPlayers() - 1 do
        if Isaac.GetPlayer(i):HasCollectible(CollectibleType.COLLECTIBLE_YIN_YANG) then
            return true
        end
    end
    return false
end

local function setSwapped(value)
    if swapped == value then
        return
    end
    swapped = value
    SaveManager.Set("Yin_Yang", {Swapped = swapped})
end

function Yin_Yang:postUpdate()
    function Yin_Yang:onUpdate()
        setSwapped(anyoneHasYinYang())
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Yin_Yang.onUpdate)

    function Yin_Yang:onGetCollectible(poolType, decrease, seed)
        local swapTo = SWAPPED_POOLS[poolType]
        if not swapped or rerolling or not swapTo then
            return
        end
        rerolling = true
        local item = game:GetItemPool():GetCollectible(swapTo, decrease, seed)
        rerolling = false
        return item
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, Yin_Yang.onGetCollectible)

    function Yin_Yang:onGameStarted(fromSave)
        local saved = fromSave and SaveManager.Get("Yin_Yang")
        swapped = saved and saved.Swapped == true or false
        if not fromSave then
            SaveManager.Set("Yin_Yang", {Swapped = swapped})
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Yin_Yang.onGameStarted)
end

return Yin_Yang
