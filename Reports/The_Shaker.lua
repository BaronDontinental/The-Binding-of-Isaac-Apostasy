local The_Shaker = {}
local game = Game()
local sfx = SFXManager()

mod.COLLECTIBLE_THE_SHAKER = Isaac.GetItemIdByName("The Shaker")
CollectibleType.COLLECTIBLE_THE_SHAKER = Isaac.GetItemIdByName("The Shaker")
EFFECT_SHAKER_SNEEZE = Isaac.GetEntityVariantByName("Shaker Sneeze")

local DOUBLE_TAP_WINDOW = 10
local SAME_DIRECTION_DOT = 0.7
local SNEEZE_COOLDOWN = 60
local SNEEZE_OFFSET = 20
local SNEEZE_LIFETIME = 20
local SNEEZE_RANGE = 90
local SNEEZE_CONE = 40
local STUN_DURATION = 60
local BOSS_STUN_COOLDOWN = 300
local HEAD_DURATION = 12

local SNEEZE_COLOR = Color(1, 1, 1, 1, 0.7, 0.7, 0.7)
SNEEZE_COLOR:SetColorize(1, 1, 1, 1)

local OLD_INNATE_GROUP = "TheShaker"

local function stun(enemy, player)
    if enemy:IsBoss() then
        local data = enemy:GetData()
        local frame = game:GetFrameCount()
        if data.ShakerBossStun and frame - data.ShakerBossStun < BOSS_STUN_COOLDOWN then
            return
        end
        data.ShakerBossStun = frame
        enemy:AddFreeze(EntityRef(player), STUN_DURATION, true)
    else
        enemy:AddFreeze(EntityRef(player), STUN_DURATION)
    end
end

local function sneeze(player, direction)
    local sneezeEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EFFECT_SHAKER_SNEEZE, 0,
        player.Position + direction * SNEEZE_OFFSET, Vector.Zero, player):ToEffect()
    local sprite = sneezeEffect:GetSprite()
    sprite:Play(sprite:GetDefaultAnimation(), true)
    sneezeEffect.SpriteRotation = direction:GetAngleDegrees()
    sneezeEffect.Color = SNEEZE_COLOR
    sneezeEffect:GetData().ShakerSneeze = {Player = player, Direction = direction, Hit = {}}
    player:AddNullCostume(NullItemID.ID_HEMOPTYSIS)
    player:GetData().ShakerHeadUntil = game:GetFrameCount() + HEAD_DURATION
    sfx:Play(SoundEffect.SOUND_BABY_BRIM, 1, 0, false, 1.3)
end

function The_Shaker:postUpdate()
    function The_Shaker:onUpdate(player)
        local oldInnate = player:GetInnateCollectibleCount(CollectibleType.COLLECTIBLE_HEMOPTYSIS, OLD_INNATE_GROUP)
        if oldInnate > 0 then
            player:RemoveInnateCollectible(CollectibleType.COLLECTIBLE_HEMOPTYSIS, oldInnate, OLD_INNATE_GROUP)
        end
        local data = player:GetData()
        local frame = game:GetFrameCount()
        if data.ShakerHeadUntil and frame >= data.ShakerHeadUntil then
            data.ShakerHeadUntil = nil
            player:TryRemoveNullCostume(NullItemID.ID_HEMOPTYSIS)
        end
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_THE_SHAKER) then
            return
        end
        local input = player:GetShootingInput()
        local pressing = input:Length() > 0.5
        if pressing and not data.ShakerHeld then
            local direction = input:Normalized()
            local ready = not data.ShakerCooldown or frame >= data.ShakerCooldown
            if ready and data.ShakerLastTap and frame - data.ShakerLastTap <= DOUBLE_TAP_WINDOW
                and data.ShakerLastDir:Dot(direction) >= SAME_DIRECTION_DOT then
                sneeze(player, direction)
                data.ShakerCooldown = frame + SNEEZE_COOLDOWN
                data.ShakerLastTap = nil
            else
                data.ShakerLastTap = frame
                data.ShakerLastDir = direction
            end
        end
        data.ShakerHeld = pressing
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, The_Shaker.onUpdate)

    function The_Shaker:onSneezeUpdate(effect)
        local sneezeData = effect:GetData().ShakerSneeze
        if not sneezeData then
            return
        end
        local player = sneezeData.Player
        if not player:Exists() or effect.FrameCount >= SNEEZE_LIFETIME
            or effect:GetSprite():IsFinished(effect:GetSprite():GetAnimation()) then
            effect:Remove()
            return
        end
        effect.Position = player.Position + sneezeData.Direction * SNEEZE_OFFSET
        local aim = sneezeData.Direction:GetAngleDegrees()
        for _, entity in ipairs(Isaac.GetRoomEntities()) do
            local hash = GetPtrHash(entity)
            if not sneezeData.Hit[hash] and entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy()
                and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
                local offset = entity.Position - player.Position
                local angle = math.abs((offset:GetAngleDegrees() - aim + 180) % 360 - 180)
                if offset:Length() <= SNEEZE_RANGE + entity.Size and angle <= SNEEZE_CONE then
                    sneezeData.Hit[hash] = true
                    stun(entity, player)
                end
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, The_Shaker.onSneezeUpdate, EFFECT_SHAKER_SNEEZE)
end

return The_Shaker



--[[local The_Shaker = {}
local game = Game()
local sfx = SFXManager()

mod.COLLECTIBLE_THE_SHAKER = Isaac.GetItemIdByName("The Shaker")
CollectibleType.COLLECTIBLE_THE_SHAKER = Isaac.GetItemIdByName("The Shaker")

local DOUBLE_TAP_WINDOW = 10
local SAME_DIRECTION_DOT = 0.7
local SNEEZE_COOLDOWN = 60
local STUN_DURATION = 60
local BOSS_STUN_COOLDOWN = 300
local HEAD_DURATION = 12

local SneezeShape = {
    LENGTH = 10,
    WIDTH_SCALE = 1.5,
    HIT_WIDTH = 45,
    DURATION = 6,
    OFFSET = Vector(0, -10)
}

local SNEEZE_COLOR = Color(1, 1, 1, 1, 0.7, 0.7, 0.7)
SNEEZE_COLOR:SetColorize(1, 1, 1, 1)

local OLD_INNATE_GROUP = "TheShaker"

local function distanceToSegment(point, startPos, endPos)
    local segment = endPos - startPos
    local lengthSq = segment:LengthSquared()
    if lengthSq == 0 then
        return point:Distance(startPos)
    end
    local t = math.max(0, math.min(1, (point - startPos):Dot(segment) / lengthSq))
    return point:Distance(startPos + segment * t)
end

local function stun(enemy, player)
    if enemy:IsBoss() then
        local data = enemy:GetData()
        local frame = game:GetFrameCount()
        if data.ShakerBossStun and frame - data.ShakerBossStun < BOSS_STUN_COOLDOWN then
            return
        end
        data.ShakerBossStun = frame
        enemy:AddFreeze(EntityRef(player), STUN_DURATION, true)
    else
        enemy:AddFreeze(EntityRef(player), STUN_DURATION)
    end
end

local function sneeze(player, direction)
    local laser = EntityLaser.ShootAngle(LaserVariant.THICK_RED, player.Position, direction:GetAngleDegrees(), SneezeShape.DURATION, SneezeShape.OFFSET, player)
    laser.Parent = player
    laser:SetMaxDistance(SneezeShape.LENGTH)
    laser:SetScale(SneezeShape.WIDTH_SCALE)
    laser.CollisionDamage = 0
    laser.TearFlags = TearFlags.TEAR_NORMAL
    laser.Color = SNEEZE_COLOR
    laser:GetData().ShakerSneeze = {Player = player, Hit = {}}
    player:AddNullCostume(NullItemID.ID_HEMOPTYSIS)
    player:GetData().ShakerHeadUntil = game:GetFrameCount() + HEAD_DURATION
    sfx:Play(SoundEffect.SOUND_BABY_BRIM, 1, 0, false, 1)
end

function The_Shaker:postUpdate()
    function The_Shaker:onUpdate(player)
        local oldInnate = player:GetInnateCollectibleCount(CollectibleType.COLLECTIBLE_HEMOPTYSIS, OLD_INNATE_GROUP)
        if oldInnate > 0 then
            player:RemoveInnateCollectible(CollectibleType.COLLECTIBLE_HEMOPTYSIS, oldInnate, OLD_INNATE_GROUP)
        end
        local data = player:GetData()
        local frame = game:GetFrameCount()
        if data.ShakerHeadUntil and frame >= data.ShakerHeadUntil then
            data.ShakerHeadUntil = nil
            player:TryRemoveNullCostume(NullItemID.ID_HEMOPTYSIS)
        end
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_THE_SHAKER) then
            return
        end
        local input = player:GetShootingInput()
        local pressing = input:Length() > 0.5
        if pressing and not data.ShakerHeld then
            local direction = input:Normalized()
            local ready = not data.ShakerCooldown or frame >= data.ShakerCooldown
            if ready and data.ShakerLastTap and frame - data.ShakerLastTap <= DOUBLE_TAP_WINDOW
                and data.ShakerLastDir:Dot(direction) >= SAME_DIRECTION_DOT then
                sneeze(player, direction)
                data.ShakerCooldown = frame + SNEEZE_COOLDOWN
                data.ShakerLastTap = nil
            else
                data.ShakerLastTap = frame
                data.ShakerLastDir = direction
            end
        end
        data.ShakerHeld = pressing
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, The_Shaker.onUpdate)

    function The_Shaker:onSneezeUpdate(laser)
        local sneezeData = laser:GetData().ShakerSneeze
        if not sneezeData then
            return
        end
        local startPos = laser.Position
        local endPos = laser:GetEndPoint()
        for _, entity in ipairs(Isaac.GetRoomEntities()) do
            local hash = GetPtrHash(entity)
            if not sneezeData.Hit[hash] and entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy()
                and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY)
                and distanceToSegment(entity.Position, startPos, endPos) <= SneezeShape.HIT_WIDTH + entity.Size then
                sneezeData.Hit[hash] = true
                stun(entity, sneezeData.Player)
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, The_Shaker.onSneezeUpdate)
end

return The_Shaker
]]