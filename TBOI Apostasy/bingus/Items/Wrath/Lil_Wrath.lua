local Lil_Wrath = {}
local game = Game()

mod.COLLECTIBLE_LIL_WRATH = Isaac.GetItemIdByName("Lil Wrath")
CollectibleType.COLLECTIBLE_LIL_WRATH = Isaac.GetItemIdByName("Lil Wrath")
FAMILIAR_LIL_WRATH = Isaac.GetEntityVariantByName("LIL_WRATH")

local itemconfig = Isaac.GetItemConfig()
local CONFIG_LILWRATH = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LIL_WRATH)

local SHOOTING_TICK_COOLDOWN = 60
local TEAR_SPEED =10
local RNG_SHIFT_INDEX = 35

local WrathCount = 0

function Lil_Wrath:postUpdate()
    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function Lil_Wrath:OnCache(player, cacheFlag)
        local effect = player:GetEffects()
        local count = effect:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_LIL_WRATH) + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LIL_WRATH)
        local rng = RNG()
        local seed = math.max(Random(), 1)
        rng:SetSeed(seed,RNG_SHIFT_INDEX)
        player:CheckFamiliar(FAMILIAR_LIL_WRATH, count, rng, CONFIG_LILWRATH)
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Lil_Wrath.OnCache, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
function Lil_Wrath:init(familiar)
    familiar:AddToFollowers() 
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Lil_Wrath.init, FAMILIAR_LIL_WRATH)


---@param familiar EntityFamiliar
    function Lil_Wrath:UpdateFam(familiar)
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
            shootanm = "FloatShootDown"
        elseif firedirection == Direction.UP then
            direction = Vector(0, -1)
            shootanm = "FloatShootUp"
        end

        if direction ~= nil and familiar.FireCooldown == 0 then
            local velocity = direction * TEAR_SPEED + player:GetTearMovementInheritance(direction)
            local tear = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_SMALL, 0, familiar.Position, velocity, familiar):ToBomb()
            familiar.FireCooldown = SHOOTING_TICK_COOLDOWN

            sprite.FlipX = doFlip
            sprite:Play(shootanm, true)
        end

        if sprite:IsFinished() then
            sprite:Play("FloatDown")
        end
        familiar:FollowParent()
        familiar.FireCooldown = math.max(familiar.FireCooldown - 1, 0)
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lil_Wrath.UpdateFam, FAMILIAR_LIL_WRATH)

end

return Lil_Wrath