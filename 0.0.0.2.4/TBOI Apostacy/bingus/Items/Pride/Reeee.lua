local Reeee = {}
local game = Game()

mod.COLLECTIBLE_REEEE = Isaac.GetItemIdByName("Reeee!")
CollectibleType.COLLECTIBLE_REEEE = Isaac.GetItemIdByName("Reeee!")


local DirectionVector = {
    UP = Vector(0,-1),
    LEFT = Vector(-1,0),
    DOWN = Vector(0,1),
    RIGHT = Vector(1,0),
    NO_DIRECTION = Vector(0,0)
}

function Reeee:postUpdate()
    function Reeee.Use()
        local player = Isaac.GetPlayer(0)
        --player.LaserVariant = { LASER_PRIDE = 4 }
        local PlayerData = player:GetData()
        if PlayerData.BeautyFrame == nil then PlayerData.BeautyFrame = 0 end
        if PlayerData.BeautyCool == nil then PlayerData.BeautyCool = 0 end
        local LASER_DURATION = 15

        if player:GetActiveItem() == CollectibleType.COLLECTIBLE_REEEE then
            player.FireDelay = player.MaxFireDelay
           -- if player:GetFireDirection() > Direction.NO_DIRECTION and
           -- PlayerData.BeautyCool == 0 then
            --    PlayerData.BeautyFrame = math.min(player.MaxFireDelay * 2, PlayerData.BeautyFrame + 1)
           --     BOff = math.ceil(255 * PlayerData.BeautyFrame / player.MaxFireDelay / 2)
           --     player:SetColor(Color(255,255,255,1,BOff, BOff, BOff), 1, 0, false, false)

            elseif game:GetRoom():GetFrameCount() > 1 then
                if PlayerData.BeautyFrame == player.MaxFireDelay * 2 then
                    Isaac.DebugString("Doin her too.")
                if player:GetActiveItem() == CollectibleType.COLLECTIBLE_REEEE then
                    BaseAngle = 45
                end
                for Angle = BaseAngle, BaseAngle + 270, 90 do
                    local PrideLaser = EntityLaser.ShootAngle(LaserVariant.PRIDE, player.Position, Angle, LASER_DURATION, Vector(0,0), player)
                    PrideLaser.TearFlags = player.TearFlags
                    PrideLaser.CollisionDamage = player.Damage
                end
          --  end
            end
        end       
        print("ur mom is gay")
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Reeee.OnUpdate)
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, Reeee.Use, mod.COLLECTIBLE_REEEE)
end

return Reeee