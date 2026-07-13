local Slug = {}
local game = Game()

mod.COLLECTIBLE_SLUG = Isaac.GetItemIdByName("Slug")
CollectibleType.COLLECTIBLE_SLUG = Isaac.GetItemIdByName("Slug")
FAMILIAR_SLUG_VARIANT = Isaac.GetEntityVariantByName("SLUG")

local CONFIG_SLUG = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_SLUG)

local RNG_SHIFT_INDEX = 35

local SLUG_SPEED = 1.0
local SLUG_FRICTION = 0.8
local WANDER_DISTANCE = 40
local CREEP_COOLDOWN = 4
local CREEP_TIMEOUT = 120
local CREEP_SCALE = 1
local PATH_MARKER = 0


function Slug:postUpdate()

---@param player EntityPlayer
    function Slug:OnCache(player)
        local effect = player:GetEffects()
        local count = effect:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_SLUG) + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SLUG)
        local rng = RNG()
        local seed = math.max(Random(), 1)
        rng:SetSeed(seed, RNG_SHIFT_INDEX)
        player:CheckFamiliar(FAMILIAR_SLUG_VARIANT, count, rng, CONFIG_SLUG)
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Slug.OnCache, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
    function Slug:init(familiar)
        familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
        familiar:GetSprite():Play("Appear", true)
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Slug.init, FAMILIAR_SLUG_VARIANT)

---@param familiar EntityFamiliar
    function Slug:UpdateFam(familiar)
        local sprite = familiar:GetSprite()
        local data = familiar:GetData()
        if data.CreepCooldown == nil then data.CreepCooldown = 0 end

        local target = nil
        local targetDist = math.huge
        for _, entity in pairs(Isaac.GetRoomEntities()) do
            if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
                local dist = (entity.Position - familiar.Position):Length()
                if dist < targetDist then
                    targetDist = dist
                    target = entity
                end
            end
        end

        local goalPos
        if target ~= nil then
            goalPos = target.Position
        elseif (familiar.Player.Position - familiar.Position):Length() > WANDER_DISTANCE then
            goalPos = familiar.Player.Position
        end

        if goalPos ~= nil then
            familiar:GetPathFinder():FindGridPath(goalPos, SLUG_SPEED, PATH_MARKER, true)
        end
        familiar:MultiplyFriction(SLUG_FRICTION)

        if data.CreepCooldown <= 0 then
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_BLACK, 0, familiar.Position, Vector.Zero, familiar):ToEffect()
            creep.Scale = CREEP_SCALE
            creep.Timeout = CREEP_TIMEOUT
            creep:Update()
            data.CreepCooldown = CREEP_COOLDOWN
        else
            data.CreepCooldown = data.CreepCooldown - 1
        end

        if not (sprite:IsPlaying("Appear") and not sprite:IsFinished("Appear")) then
            local attacking = target ~= nil and targetDist <= (familiar.Size + target.Size + 4)
            local faceDir
            if attacking then
                faceDir = target.Position - familiar.Position
            else
                faceDir = familiar.Velocity
            end
            local anim
            local flip = false
            if math.abs(faceDir.X) >= math.abs(faceDir.Y) then
                anim = attacking and "Attack Hori" or "Move Hori"
                flip = faceDir.X < 0
            elseif faceDir.Y < 0 then
                anim = attacking and "Attack Up" or "Move Up"
            else
                anim = attacking and "Attack Down" or "Move Down"
            end
            if not sprite:IsPlaying(anim) then
                sprite:Play(anim, true)
            end
            sprite.FlipX = flip
        end
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Slug.UpdateFam, FAMILIAR_SLUG_VARIANT)

end

return Slug