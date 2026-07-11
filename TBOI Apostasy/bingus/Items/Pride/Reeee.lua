local Reeee = {}
local game = Game()
local sfx = SFXManager()

mod.COLLECTIBLE_REEEE = Isaac.GetItemIdByName("Reeee!")
CollectibleType.COLLECTIBLE_REEEE = Isaac.GetItemIdByName("Reeee!")

local LaserType = { LASER_PRIDE = 4 }
local LASER_DURATION = 15

function Reeee:postUpdate() 
    function Reeee:onUse(item, rng, player)
        local BaseAngle = 45
        for Angle = BaseAngle, BaseAngle + 270, 90 do
            local PrideLaser = EntityLaser.ShootAngle(LaserType.LASER_PRIDE, player.Position, Angle, LASER_DURATION, Vector(0,0), player)
            PrideLaser.TearFlags = player.TearFlags
            PrideLaser.CollisionDamage = player.Damage
            sfx:Play(SoundEffect.SOUND_BOSS_LITE_HISS, 1, 0, false, 1)
            player:AnimateHappy()
            sfx:Stop(SoundEffect.SOUND_THUMBSUP)
        end
    end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Reeee.onUse, CollectibleType.COLLECTIBLE_REEEE)

end



return Reeee