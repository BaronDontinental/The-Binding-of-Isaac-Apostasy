local Trench_Foot = {}
local game = Game()

mod.COLLECTIBLE_TRENCH_FOOT = Isaac.GetItemIdByName("Trench Foot")
CollectibleType.COLLECTIBLE_TRENCH_FOOT = Isaac.GetItemIdByName("Trench Foot")

local creep
local Trench = {
    Size1 = .75,
    Size2 = 1,
    Chance = 25
}


function Trench_Foot:postUpdate()
    function Trench_Foot:onUpdate(player)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TRENCH_FOOT) then
            local roll = math.random(100)
            if Trench.Chance <= roll then
                local spawnpos = player.Position
                local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, spawnpos, Vector.Zero, player):ToEffect()
                creep.Scale = Trench.Size1 * (roll/100)
                creep:Update()
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Trench_Foot.onUpdate)

    function Trench_Foot:onEffect(Creep)
        local sprite = Creep:GetSprite()
        local player = Isaac.GetPlayer(0)
        local data = Creep:GetData()
        data.FlyBlacklist = {}
        local spawnpos = player.Position
        local poggers = EntityRef(player)

        if player:HasCollectible(CollectibleType.COLLECTIBLE_TRENCH_FOOT) then
            local capsule = Creep:GetCollisionCapsule("body")
            for _, entity in ipairs(Isaac.FindInCapsule(capsule, EntityPartition.ENEMY)) do
                local hit = entity:GetData()
                if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
                    entity:AddPoison(poggers, 90, player.Damage)
                end
                if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() and not hit.Fly then
                    local fly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, spawnpos, Vector.Zero, player):ToFamiliar()
                    hit.Fly = true
                end
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, Trench_Foot.onEffect, EffectVariant.PLAYER_CREEP_GREEN)
end

return Trench_Foot