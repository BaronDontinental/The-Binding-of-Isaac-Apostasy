local BO = {}
local game = Game()

mod.COLLECTIBLE_BO = Isaac.GetItemIdByName("BO")
CollectibleType.COLLECTIBLE_BO = Isaac.GetItemIdByName("BO")
local numyes = 0
local num = 0
local stink
function BO:postUpdate()
    ---@param player EntityPlayer
    function BO:onUpdate(player)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_BO) then
            local spawnpos = player.Position
            num = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DEATH_CAP)
            if num ~= numyes then
                numyes = numyes + 1
                local stink = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART_RING, 0, spawnpos, Vector.Zero, player):ToEffect()
            end
            stink.Position = player.Position
            stink:update()
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, BO.onUpdate)
    
end

return BO