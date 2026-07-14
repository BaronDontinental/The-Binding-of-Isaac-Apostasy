local BO = {}
local game = Game()

mod.COLLECTIBLE_BODY_ODOR = Isaac.GetItemIdByName("Body Odor")
CollectibleType.COLLECTIBLE_BODY_ODOR = Isaac.GetItemIdByName("Body Odor")
EffectVariant.BOCLOUD = Isaac.GetEntityVariantByName("BO Cloud")

local TICK_DAMAGE = 0.25
local POISON_DURATION = 90
local BO_CLOUD_COLOR = Color(0.5, 1.0, 0.4, 1.0, 0, 0, 0)
local DAMAGE_INTERVAL = 20
local aura = false
local cloud

function BO:postUpdate()

---@param player EntityPlayer
    function BO:onUpdate(player)
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_BODY_ODOR) then
            return
        end
        local spawnpos = player.Position
        if not aura then
            cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOCLOUD, 0, spawnpos, Vector.Zero, player):ToEffect()
---@diagnostic disable-next-line: need-check-nil
            cloud:FollowParent(player)
            cloud.SpriteOffset = Vector(0, -20)
            cloud.IsFollowing = true
            cloud.Color = BO_CLOUD_COLOR
---@diagnostic disable-next-line: need-check-nil
            cloud:Update()
        end
---@diagnostic disable-next-line: need-check-nil
        if cloud:Exists() then
            aura = true
        else
            aura = false
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, BO.onUpdate)

    function BO:onEffect(Cloud)
        local poggers = EntityRef(Cloud.SpawnerEntity or Isaac.GetPlayer(0))
        local capsule = Cloud:GetNullCapsule("capsule")
---@diagnostic disable-next-line: param-type-mismatch
        for _, entity in ipairs(Isaac.FindInCapsule(capsule, EntityPartition.ENEMY)) do
            if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
                entity:AddPoison(poggers, POISON_DURATION, TICK_DAMAGE)
                --entity:TakeDamage(TICK_DAMAGE, 0, poggers, DAMAGE_INTERVAL)
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, BO.onEffect, EffectVariant.BOCLOUD)
    
end

return BO