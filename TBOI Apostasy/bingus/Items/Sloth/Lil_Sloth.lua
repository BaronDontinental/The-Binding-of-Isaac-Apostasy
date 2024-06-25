local Lil_Sloth = {}
local game = Game()

mod.COLLECTIBLE_LIL_SLOTH = Isaac.GetItemIdByName("Lil' Sloth")
CollectibleType.COLLECTIBLE_LIL_SLOTH = Isaac.GetItemIdByName("Lil' Sloth")
FAMILIAR_SLOTH_VARIANT = Isaac.GetEntityVariantByName("LIL_SLOTH")

local itemconfig = Isaac.GetItemConfig()
local CONFIG_LILSLOTH = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LIL_SLOTH)

local SHOOTING_TICK_COOLDOWN = 45
local TEAR_SPEED =10
local TEAR_SCALE = 0.8
local TEAR_DAMAGE = 3
local RNG_SHIFT_INDEX = 35


local SLOTH_COOLDOWN = 40
local SlothCount = 0

function Lil_Sloth:postUpdate()
    
---@param player EntityPlayer
    function Lil_Sloth:OnCache(player)
        local effect = player:GetEffects()
        local count = effect:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_LIL_SLOTH) + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LIL_SLOTH)
        local rng = RNG()
        local seed = math.max(Random(), 1)
        rng:SetSeed(seed, RNG_SHIFT_INDEX)
        player:CheckFamiliar(FAMILIAR_SLOTH_VARIANT, count, rng, CONFIG_LILSLOTH)
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Lil_Sloth.OnCache, CacheFlag.CACHE_FAMILIARS) 

---@param familiar EntityFamiliar
    function Lil_Sloth:init(familiar)
        familiar:AddToFollowers() 
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Lil_Sloth.init, FAMILIAR_SLOTH_VARIANT)

---@param familiar EntityFamiliar
    function Lil_Sloth:UpdateFam(familiar)
        local sprite = familiar:GetSprite()
        local player = familiar.Player
        local firedirection = player:GetFireDirection()
        local direction
        local shootanm
        local doFlip = false

        if firedirection == Direction.LEFT then
            direction = Vector(-1, 0)
            shootanm = "FloatShootSide"
            doFlip = true
        elseif firedirection == Direction.RIGHT then
            direction = Vector(1, 0)
            shootanm = "FloatShootSide"
        elseif firedirection == Direction.DOWN then
            direction = Vector(0,1)
            shootanm = "FloatShootDowm"
        elseif firedirection == Direction.UP then
            direction = Vector(0, -1)
            shootanm = "FloatShootUp"
        end

        if direction ~= nil and familiar.FireCooldown == 0 then
            local velocity = direction * TEAR_SPEED + player:GetTearMovementInheritance(direction)
            local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, familiar.Position, velocity, familiar):ToTear()
            tear.TearFlags = TearFlags.TEAR_EXPLOSIVE
            tear.CollisionDamage = TEAR_DAMAGE
            familiar.FireCooldown = SHOOTING_TICK_COOLDOWN
            tear.Color = Color(0, 1.0, 0, 1.0, 0, 0, 0)

            sprite.FlipX = doFlip
            sprite:Play(shootanm, true)
        end

        if sprite:IsFinished() then
            sprite:Play("FloatDown")
        end
        familiar:FollowParent()
        familiar.FireCooldown = math.max(familiar.FireCooldown - 1, 0)
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lil_Sloth.UpdateFam, FAMILIAR_SLOTH_VARIANT)
end

return Lil_Sloth