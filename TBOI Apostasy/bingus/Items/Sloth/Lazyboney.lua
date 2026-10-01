local Lazyboney = {}
local game = Game()

mod.COLLECTIBLE_LAZYBONEY = Isaac.GetItemIdByName("Lazyboney")
CollectibleType.COLLECTIBLE_LAZYBONEY = Isaac.GetItemIdByName("Lazyboney")

local RECHARGE_TIME = 300

function Lazyboney:postUpdate()

---@param player EntityPlayer
    function Lazyboney:onUse(item, rng, player, useFlags, slot, varData)
        local room = game:GetRoom()
        local spawnPos = room:FindFreePickupSpawnPosition(player.Position, 0, true)
        local bony = Isaac.Spawn(EntityType.ENTITY_BONY, 0, 0, spawnPos, Vector.Zero, player)
        bony:AddCharmed(EntityRef(player), -1)
        return true
    end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Lazyboney.onUse, CollectibleType.COLLECTIBLE_LAZYBONEY)

---@param player EntityPlayer
    function Lazyboney:onCharge(player)
        local slot = -1
        for s = 0, 3 do
            if player:GetActiveItem(s) == CollectibleType.COLLECTIBLE_LAZYBONEY then
                slot = s
                break
            end
        end
        if slot == -1 then
            return
        end

        local maxCharge = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LAZYBONEY).MaxCharges
        local currentCharge = player:GetActiveCharge(slot)
        local data = player:GetData()
        if currentCharge >= maxCharge then
            data.LazyboneyTimer = 0
            return
        end

        data.LazyboneyTimer = (data.LazyboneyTimer or 0) + 1
        local perCharge = RECHARGE_TIME / maxCharge
        while data.LazyboneyTimer >= perCharge and currentCharge < maxCharge do
            currentCharge = currentCharge + 1
            data.LazyboneyTimer = data.LazyboneyTimer - perCharge
        end
        player:SetActiveCharge(currentCharge, slot)
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Lazyboney.onCharge)

end

return Lazyboney