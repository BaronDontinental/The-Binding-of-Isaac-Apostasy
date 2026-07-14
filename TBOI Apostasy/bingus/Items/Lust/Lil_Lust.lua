local Lil_Lust = {}
local game = Game()

mod.COLLECTIBLE_LIL_LUST = Isaac.GetItemIdByName("Lil Lust")
CollectibleType.COLLECTIBLE_LIL_LUST = Isaac.GetItemIdByName("Lil Lust")
FAMILIAR_LUST_VARIANT = Isaac.GetEntityVariantByName("LIL_LUST")

local CONFIG_LUST = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LIL_LUST)

local RNG_SHIFT_INDEX = 35

local LUST_SPEED = 1.25
local LUST_FRICTION = 0.8
local WANDER_DISTANCE = 40
local PATH_MARKER = 0
local IDLE_SPEED_THRESHOLD = 0.1

function Lil_Lust:postUpdate()
---@param player EntityPlayer
    function Lil_Lust:OnCache(player)
        local effect = player:GetEffects()
        local count = effect:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_LIL_LUST) + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LIL_LUST)
        local rng = RNG()
        local seed = math.max(Random(), 1)
        rng:SetSeed(seed, RNG_SHIFT_INDEX)
        player:CheckFamiliar(FAMILIAR_LUST_VARIANT, count, rng, CONFIG_LUST)
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Lil_Lust.OnCache, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
    function Lil_Lust:init(familiar)
        familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
        familiar:GetSprite():Play("Appear", true)
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Lil_Lust.init, FAMILIAR_LUST_VARIANT)

---@param familiar EntityFamiliar
    function Lil_Lust:UpdateFam(familiar)
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
            familiar:GetPathFinder():FindGridPath(goalPos, LUST_SPEED, PATH_MARKER, true)
        end
        familiar:MultiplyFriction(LUST_FRICTION)

        if not (sprite:IsPlaying("Appear") and not sprite:IsFinished("Appear")) then
            local attacking = target ~= nil and targetDist <= (familiar.Size + target.Size + 4)
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
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lil_Lust.UpdateFam, FAMILIAR_LUST_VARIANT)

 function Lil_Lust:onDamage(entity, amount, flags, source, countdown)
        local npc = entity:ToNPC()
        if not npc then
            return
        end
        local data = npc:GetData()
        data.KilledByLilLust = source ~= nil and source.Entity ~= nil
            and source.Entity.Type == EntityType.ENTITY_FAMILIAR
            and source.Entity.Variant == FAMILIAR_LUST_VARIANT
    end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Lil_Lust.onDamage, EntityType.ENTITY_NPC)

    function Lil_Lust:heartUpdate()
        local player = Isaac.GetPlayer(0)
        local entities = Isaac.GetRoomEntities()
        for _, entity in ipairs(entities) do
          local data = entity:GetData()
          local heartSpawn = entity:ToNPC()
         if heartSpawn and heartSpawn:IsEnemy() and heartSpawn:IsActiveEnemy(true) then
            if heartSpawn:IsDead() and not data.Died then
                data.Died = true
                if data.KilledByLilLust then
                  local heart = Isaac.Spawn(
                    EntityType.ENTITY_PICKUP,
                    PickupVariant.PICKUP_HEART,
                    HeartSubType.HEART_HALF,
                    heartSpawn.Position,
                    heartSpawn.Velocity,
                    player):ToPickup()

                    heart:Update()
                end
              elseif heartSpawn.ParentNPC
                then
                  data.Died = true
              end
          end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Lil_Lust.heartUpdate)

end

return Lil_Lust