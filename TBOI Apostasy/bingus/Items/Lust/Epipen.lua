local Epipen = {}
local game = Game()

mod.COLLECTIBLE_EPIPEN = Isaac.GetItemIdByName("Epipen")
CollectibleType.COLLECTIBLE_EPIPEN = Isaac.GetItemIdByName("Epipen")

local DURATION = 8 * 30
local BLINK_DURATION = 1.5 * 30
local DAMAGE_UP = 2.0
local SPEED_UP = 0.3

local function rainbowColor(frame)
    local h = (frame % 90) / 90
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local q = 1 - f
    local r, g, b
    local phase = i % 6
    if phase == 0 then r, g, b = 1, f, 0
    elseif phase == 1 then r, g, b = q, 1, 0
    elseif phase == 2 then r, g, b = 0, 1, f
    elseif phase == 3 then r, g, b = 0, q, 1
    elseif phase == 4 then r, g, b = f, 0, 1
    else r, g, b = 1, 0, q end
    return Color(r, g, b, 1.0, 0, 0, 0)
end

function Epipen:postUpdate()

---@param player EntityPlayer
    function Epipen:onUse(item, rng, player, useFlags, slot, varData)
        local data = player:GetData()
        data.EpipenTimer = DURATION
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_SPEED)
        player:EvaluateItems()
        return true
    end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Epipen.onUse, CollectibleType.COLLECTIBLE_EPIPEN)

---@param player EntityPlayer
    function Epipen:onUpdate(player)
        local data = player:GetData()
        if (data.EpipenTimer or 0) <= 0 then
            return
        end
        data.EpipenTimer = data.EpipenTimer - 1
        if data.EpipenTimer <= 0 then
            player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_SPEED)
            player:EvaluateItems()
            return
        end
        local timer = data.EpipenTimer
        if timer > BLINK_DURATION or math.floor(timer / 3) % 2 == 0 then
            player:SetColor(rainbowColor(game:GetFrameCount()), 2, 1, false, false)
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Epipen.onUpdate)

---@param player EntityPlayer
    function Epipen:onCache(player, cacheFlag)
        local data = player:GetData()
        if (data.EpipenTimer or 0) <= 0 then
            return
        end
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + DAMAGE_UP
        end
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + SPEED_UP
        end
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Epipen.onCache)

    function Epipen:onDamage(entity, amount, flags, source, countdown)
        local player = entity:ToPlayer()
        if not player then
            return
        end
        local data = player:GetData()
        if (data.EpipenTimer or 0) > 0 then
            return false
        end
        local maxCharge = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_EPIPEN).MaxCharges
        for slot = 0, 3 do
            if player:GetActiveItem(slot) == CollectibleType.COLLECTIBLE_EPIPEN then
                player:SetActiveCharge(math.min(player:GetActiveCharge(slot) + 1, maxCharge), slot)
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Epipen.onDamage, EntityType.ENTITY_PLAYER)

end

return Epipen