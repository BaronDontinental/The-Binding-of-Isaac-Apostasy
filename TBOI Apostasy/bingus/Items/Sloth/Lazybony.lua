local Lazybony = {}
local game = Game()

mod.COLLECTIBLE_LAZYBONY = Isaac.GetItemIdByName("Lazybony")
CollectibleType.COLLECTIBLE_LAZYBONY = Isaac.GetItemIdByName("Lazybony")

local RECHARGE_TIME = 300

function Lazybony:postUpdate()

---@param player EntityPlayer
    function Lazybony:onUse(item, rng, player, useFlags, slot, varData)
        local room = game:GetRoom()
        local spawnPos = room:FindFreePickupSpawnPosition(player.Position, 0, true)
        local bony = Isaac.Spawn(EntityType.ENTITY_BONY, 0, 0, spawnPos, Vector.Zero, player)
        bony:AddCharmed(EntityRef(player), -1)
        return true
    end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Lazybony.onUse, CollectibleType.COLLECTIBLE_LAZYBONY)

---@param player EntityPlayer
    function Lazybony:onCharge(player)
        local slot = -1
        for s = 0, 3 do
            if player:GetActiveItem(s) == CollectibleType.COLLECTIBLE_LAZYBONY then
                slot = s
                break
            end
        end
        if slot == -1 then
            return
        end

        local maxCharge = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LAZYBONY).MaxCharges
        local currentCharge = player:GetActiveCharge(slot)
        local data = player:GetData()
        if currentCharge >= maxCharge then
            data.LazybonyTimer = 0
            return
        end

        data.LazybonyTimer = (data.LazybonyTimer or 0) + 1
        local perCharge = RECHARGE_TIME / maxCharge
        while data.LazybonyTimer >= perCharge and currentCharge < maxCharge do
            currentCharge = currentCharge + 1
            data.LazybonyTimer = data.LazybonyTimer - perCharge
        end
        player:SetActiveCharge(currentCharge, slot)
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Lazybony.onCharge)

end

return Lazybony