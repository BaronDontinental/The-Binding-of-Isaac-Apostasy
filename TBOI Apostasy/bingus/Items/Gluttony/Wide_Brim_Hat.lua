local Wide_Brim_Hat = {}
local game = Game()
local sfx = SFXManager()

mod.COLLECTIBLE_WIDE_BRIM_HAT = Isaac.GetItemIdByName("Wide Brim Hat")
CollectibleType.COLLECTIBLE_WIDE_BRIM_HAT = Isaac.GetItemIdByName("Wide Brim Hat")

local CHARGE_TIME = 60
local BEAM_DAMAGE = 3.5
local BEAM_TIMEOUT = 15
local STILL_SPEED = 0.5
local READY_COLOR = Color(1, 1, 1, 1, 0.4, 0, 0)
local BEAM_OFFSET = Vector(0, -10)

local function isStandingStill(player)
    return player:GetMovementVector():Length() < 0.1 and player.Velocity:Length() < STILL_SPEED
end

local function nearestEnemy(position)
    local closest, closestDist
    for _, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy()
            and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
            local dist = entity.Position:Distance(position)
            if not closestDist or dist < closestDist then
                closest, closestDist = entity, dist
            end
        end
    end
    return closest
end

function Wide_Brim_Hat:postUpdate()
    function Wide_Brim_Hat:onUpdate(player)
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_WIDE_BRIM_HAT) then
            return
        end
        local data = player:GetData()
        if not isStandingStill(player) then
            data.BrimHatCharge = 0
            return
        end
        data.BrimHatCharge = math.min(CHARGE_TIME, (data.BrimHatCharge or 0) + 1)
        if data.BrimHatCharge < CHARGE_TIME then
            return
        end
        local target = nearestEnemy(player.Position)
        if not target then
            if player.FrameCount % 20 < 10 then
                player:SetColor(READY_COLOR, 2, 1, false, false)
            end
            return
        end
        data.BrimHatCharge = 0
        local angle = (target.Position - player.Position):GetAngleDegrees()
        local laser = EntityLaser.ShootAngle(LaserVariant.THICK_RED, player.Position, angle, BEAM_TIMEOUT, BEAM_OFFSET, player)
        laser.CollisionDamage = BEAM_DAMAGE
        laser.TearFlags = TearFlags.TEAR_NORMAL
        sfx:Play(SoundEffect.SOUND_BLOOD_LASER_LARGE, 1, 0, false, 1)
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Wide_Brim_Hat.onUpdate)
end

return Wide_Brim_Hat
