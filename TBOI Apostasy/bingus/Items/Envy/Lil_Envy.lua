local Lil_Envy = {}
local game = Game()

mod.COLLECTIBLE_LIL_ENVY = Isaac.GetItemIdByName("Lil Envy")
CollectibleType.COLLECTIBLE_LIL_ENVY = Isaac.GetItemIdByName("Lil Envy")
FamiliarVariant.LIL_ENVY = Isaac.GetEntityVariantByName("Lil Envy")

local CONFIG_ENVY = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LIL_ENVY)

local RNG_SHIFT_INDEX = 35

local ENVY_SPEED = 0.6
local ENVY_FRICTION = 0.85
local WANDER_DISTANCE = 40
local IDLE_SPEED_THRESHOLD = 0.1
local ORBIT_DISTANCE = 40
local ORBIT_TANGENT = 0.7

local function findLilEnvy(player)
    for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.LIL_ENVY)) do
        local familiar = entity:ToFamiliar()
        if familiar and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            return familiar
        end
    end
end

function mod.LilEnvyOrbitCenter(player)
    local envy = findLilEnvy(player)
    if envy then
        return envy.Position + envy.Velocity
    end
    return player.Position + player.Velocity
end

function Lil_Envy:postUpdate()
---@param player EntityPlayer
    function Lil_Envy:OnCache(player)
        local effect = player:GetEffects()
        local count = effect:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_LIL_ENVY) + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LIL_ENVY)
        local rng = RNG()
        local seed = math.max(Random(), 1)
        rng:SetSeed(seed, RNG_SHIFT_INDEX)
        player:CheckFamiliar(FamiliarVariant.LIL_ENVY, count, rng, CONFIG_ENVY)
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Lil_Envy.OnCache, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
    function Lil_Envy:init(familiar)
        familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
        familiar:GetSprite():Play("Appear", true)
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Lil_Envy.init, FamiliarVariant.LIL_ENVY)

---@param familiar EntityFamiliar
    function Lil_Envy:UpdateFam(familiar)
        local sprite = familiar:GetSprite()

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

        if target ~= nil then
            local toTarget = target.Position - familiar.Position
            if toTarget:Length() > 0 then
                local radial = toTarget:Normalized()
                local tangent = radial:Rotated(90)
                local pull = math.max(-1, math.min(1, (targetDist - ORBIT_DISTANCE) / ORBIT_DISTANCE))
                local steer = radial * pull + tangent * ORBIT_TANGENT
                familiar:AddVelocity(steer:Resized(ENVY_SPEED))
            end
        elseif (familiar.Player.Position - familiar.Position):Length() > WANDER_DISTANCE then
            familiar:AddVelocity((familiar.Player.Position - familiar.Position):Resized(ENVY_SPEED))
        end
        familiar:MultiplyFriction(ENVY_FRICTION)

        if not (sprite:IsPlaying("Appear") and not sprite:IsFinished("Appear")) then
            local attacking = target ~= nil
            local moving = familiar.Velocity:Length() > IDLE_SPEED_THRESHOLD
            if attacking or moving then
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
            else
                sprite:Stop()
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lil_Envy.UpdateFam, FamiliarVariant.LIL_ENVY)

---@param familiar EntityFamiliar
    function Lil_Envy:StealOrbital(familiar)
        if familiar.OrbitLayer < 0 or familiar.Variant == FamiliarVariant.LIL_ENVY or not familiar.Player then
            return
        end
        if not findLilEnvy(familiar.Player) then
            return
        end
        familiar.Velocity = familiar:GetOrbitPosition(mod.LilEnvyOrbitCenter(familiar.Player)) - familiar.Position
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lil_Envy.StealOrbital)

end

return Lil_Envy
