local Inferno_Bombs = {}
local game = Game()

mod.COLLECTIBLE_INFERNO_BOMBS = Isaac.GetItemIdByName("Inferno Bombs")
CollectibleType.COLLECTIBLE_INFERNO_BOMBS = Isaac.GetItemIdByName("Inferno Bombs")

local FLAME_COUNT = 6
local FLAME_SPEED = 5
local FLAME_FRICTION = 0.9
local FLAME_LIFETIME = 75
local FLAME_DAMAGE_MULT = 1

local EXCLUDED_VARIANTS = {
    [BombVariant.BOMB_TROLL] = true,
    [BombVariant.BOMB_SUPERTROLL] = true,
    [BombVariant.BOMB_GOLDENTROLL] = true,
}

local function spawnFlames(position, player)
    local offset = math.random() * 360
    for i = 1, FLAME_COUNT do
        local velocity = Vector.FromAngle(offset + (360 / FLAME_COUNT) * i) * FLAME_SPEED
        local flame = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLUE_FLAME, 0, position, velocity, player):ToEffect()
        flame.CollisionDamage = player.Damage * FLAME_DAMAGE_MULT
        flame:SetTimeout(FLAME_LIFETIME)
        flame:GetData().InfernoFlame = true
    end
end

function Inferno_Bombs:postUpdate()
    function Inferno_Bombs:onBombUpdate(bomb)
        local data = bomb:GetData()
        if data.InfernoDone or not bomb:GetSprite():IsPlaying("Explode") then
            return
        end
        data.InfernoDone = true
        local player = bomb.SpawnerEntity and bomb.SpawnerEntity:ToPlayer()
        if not player or EXCLUDED_VARIANTS[bomb.Variant]
            or not player:HasCollectible(CollectibleType.COLLECTIBLE_INFERNO_BOMBS) then
            return
        end
        spawnFlames(bomb.Position, player)
    end
    mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, Inferno_Bombs.onBombUpdate)

    function Inferno_Bombs:onFlameUpdate(flame)
        if not flame:GetData().InfernoFlame then
            return
        end
        flame.Velocity = flame.Velocity * FLAME_FRICTION
        if flame.FrameCount >= FLAME_LIFETIME then
            flame:Remove()
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, Inferno_Bombs.onFlameUpdate, EffectVariant.BLUE_FLAME)
end

return Inferno_Bombs
