local Cooties = {}
local game = Game()

mod.COLLECTIBLE_COOTIES = Isaac.GetItemIdByName("Cooties")
CollectibleType.COLLECTIBLE_COOTIES = Isaac.GetItemIdByName("Cooties")

local CHARM_DURATION = 90

function Cooties:postUpdate()

---@param player EntityPlayer
    function Cooties:onUpdate(player)
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_COOTIES) then
            return
        end
        local poggers = EntityRef(player)
        for _, entity in ipairs(Isaac.GetRoomEntities()) do
            if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() then
                if (entity.Position - player.Position):Length() <= player.Size + entity.Size then
                    entity:AddCharmed(poggers, CHARM_DURATION)
                end
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Cooties.onUpdate)

end

return Cooties