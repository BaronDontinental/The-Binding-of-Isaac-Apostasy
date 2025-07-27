local Reeee = {}
local game = Game()
local sfx = SFXManager()

mod.COLLECTIBLE_REEEE = Isaac.GetItemIdByName("Reeee!")
CollectibleType.COLLECTIBLE_REEEE = Isaac.GetItemIdByName("Reeee!")

local LaserType = { LASER_PRIDE = 4 }
local LASER_DURATION = 15

function Reeee:postUpdate() 
    ---@param itemId CollectibleType
    ---@param rng RNG
    ---@param player EntityPlayer
    ---@param useFlags UseFlags
    ---@param slot ActiveSlot
    ---@param customVarData integer
    function Reeee:onUse(itemId, rng, player, useFlags, slot, customVarData)
        local BaseAngle = 45
        local entity = Isaac.GetRoomEntities()
        local playerCount = game:GetNumPlayers()local entities = Isaac.GetRoomEntities()
        for playerIndex = 0, playerCount - 1 do
            local player = Isaac.GetPlayer(playerIndex)
            for Angle = BaseAngle, BaseAngle + 270, 90 do
                local PrideLaser = EntityLaser.ShootAngle(LaserType.LASER_PRIDE, player.Position, Angle, LASER_DURATION, Vector(0,0), player)
                PrideLaser.TearFlags = player.TearFlags
                PrideLaser.CollisionDamage = player.Damage
                sfx:Play(SoundEffect.SOUND_BOSS_LITE_HISS, 1, 0, false, 1)
                player:AnimateHappy()
                sfx:Stop(SoundEffect.SOUND_THUMBSUP)
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Reeee.onUse, CollectibleType.COLLECTIBLE_REEEE)

end



return Reeee