local B25_Sloth = {}
local Game = Game()
local SlothGuy = Isaac.GetPlayerTypeByName("B25_Sloth", false)
local sfxManager = SFXManager()

local B25_SlothStats = {
    DAMAGE = 2.857,
    SPEED = -0.2,
    SHOTSPEED = 0,
    MAXFIREDELAY = 49,
    TEARFLAG = TearFlags.TEAR_EXPLOSIVE,
    LUCK = 1,
    TEARCOLOR = Color(0, 1.0, 0, 1.0, 0, 0, 0),
    ARC_FALLINGSPEED = 20,
    ARC_FALLINGACCEL = 1.5,
    CREEP_VARIANT = EffectVariant.PLAYER_CREEP_LEMON_MISHAP,
    CREEP_SCALE = 2,
    CREEP_RADIUS = 26,
    CREEP_TIME = 270,
    CREEPCOLOR = Color(0.7, 0.9, 0.2, 1.0, 0, 0, 0),
    CREEP_FIRE_MULT = 2,
    CORK_MULT = 2,
    CREEP_IMMUNE = true,
    ALLOW_SOUL_HEARTS = false
}

local inCreep = false

local function isSloth(player)
    if player == nil then
        return false
    end
    if SlothGuy < 0 then
        SlothGuy = Isaac.GetPlayerTypeByName("B25_Sloth", false)
    end
    return player:GetPlayerType() == SlothGuy or player:GetName() == "B25_Sloth"
end

function B25_Sloth:postUpdate()

    local function spawnCreep(position, player)
        local scale = B25_SlothStats.CREEP_SCALE
        if player:HasTrinket(TrinketType.TRINKET_LOST_CORK) then
            scale = scale * B25_SlothStats.CORK_MULT
        end
        for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, B25_SlothStats.CREEP_VARIANT, -1, false, false)) do
            local creep = entity:ToEffect()
            if creep:GetData().SlothCreep and creep.Position:Distance(position) <= B25_SlothStats.CREEP_RADIUS * creep.Scale then
                creep:SetTimeout(B25_SlothStats.CREEP_TIME)
                return
            end
        end
        local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, B25_SlothStats.CREEP_VARIANT, 0, position, Vector.Zero, player):ToEffect()
        creep:GetData().SlothCreep = true
        creep.Scale = scale
        creep.Timeout = B25_SlothStats.CREEP_TIME
        creep.Color = B25_SlothStats.CREEPCOLOR
        creep:Update()
    end

---@param player EntityPlayer
    function B25_Sloth:OnCache(player, cacheFlag)
        if not isSloth(player) then
            return
        end
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage * B25_SlothStats.DAMAGE
        end
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + B25_SlothStats.SPEED
        end
        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed + B25_SlothStats.SHOTSPEED
        end
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay + B25_SlothStats.MAXFIREDELAY
            if inCreep then
                player.MaxFireDelay = (player.MaxFireDelay + 1) / B25_SlothStats.CREEP_FIRE_MULT - 1
            end
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + B25_SlothStats.LUCK
        end
        if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
            player.TearColor = B25_SlothStats.TEARCOLOR
        end
        if cacheFlag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | B25_SlothStats.TEARFLAG
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B25_Sloth.OnCache)

---@param player EntityPlayer
    function B25_Sloth:PEffect(player)
        if not isSloth(player) then
            return
        end

        local red = player:GetHearts() - player:GetRottenHearts() * 2
        if red > 0 then
            player:AddHearts(-red)
            player:AddRottenHearts(math.ceil(red / 2) * 2)
        end
        if not B25_SlothStats.ALLOW_SOUL_HEARTS and player:GetSoulHearts() > 0 then
            player:AddSoulHearts(-player:GetSoulHearts())
        end

        local standing = false
        for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, B25_SlothStats.CREEP_VARIANT, -1, false, false)) do
            local creep = entity:ToEffect()
            if creep:GetData().SlothCreep and creep.Position:Distance(player.Position) <= B25_SlothStats.CREEP_RADIUS * creep.Scale then
                standing = true
                break
            end
        end
        if standing ~= inCreep then
            inCreep = standing
            player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
            player:EvaluateItems()
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B25_Sloth.PEffect)

---@param pickup EntityPickup
    function B25_Sloth:HeartBlock(pickup, collider, low)
        local player = collider:ToPlayer()
        if not isSloth(player) then
            return
        end
        if pickup.SubType == HeartSubType.HEART_SOUL
        or pickup.SubType == HeartSubType.HEART_HALF_SOUL
        or pickup.SubType == HeartSubType.HEART_BLACK
        or pickup.SubType == HeartSubType.HEART_ETERNAL
        or pickup.SubType == HeartSubType.HEART_BONE
        or pickup.SubType == HeartSubType.HEART_BLENDED then
            return false
        end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, B25_Sloth.HeartBlock, PickupVariant.PICKUP_HEART)

---@param tear EntityTear
    function B25_Sloth:FireTear(tear)
        local player = (tear.Parent and tear.Parent:ToPlayer()) or (tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer())
        if not isSloth(player) then
            return
        end
        tear:GetData().SlothTear = true
        tear.TearFlags = tear.TearFlags | B25_SlothStats.TEARFLAG
        tear.Color = B25_SlothStats.TEARCOLOR
        tear.FallingSpeed = tear.FallingSpeed - B25_SlothStats.ARC_FALLINGSPEED
        tear.FallingAcceleration = tear.FallingAcceleration + B25_SlothStats.ARC_FALLINGACCEL
    end
    mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, B25_Sloth.FireTear)

---@param tear EntityTear
    function B25_Sloth:TearUpdate(tear)
        local data = tear:GetData()
        if not data.SlothTear or data.CreepDone then
            return
        end
        if not tear:IsDead() then
            return
        end
        data.CreepDone = true
        local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
        if not player then
            return
        end
        spawnCreep(tear.Position, player)
    end
    mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, B25_Sloth.TearUpdate)

---@param familiar EntityFamiliar
    function B25_Sloth:FlyInit(familiar)
        local player = familiar.Player or (familiar.SpawnerEntity and familiar.SpawnerEntity:ToPlayer()) or Isaac.GetPlayer(0)
        if not isSloth(player) then
            return
        end
        for _, fly in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, -1, false, false)) do
            if GetPtrHash(fly) ~= GetPtrHash(familiar) and not fly:IsDead() then
                local position = familiar.Position
                fly:Remove()
                familiar:Remove()
                local charger = Isaac.Spawn(EntityType.ENTITY_CHARGER, 0, 1, position, Vector.Zero, player)
                charger:AddCharmed(EntityRef(player), -1)
                return
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, B25_Sloth.FlyInit, FamiliarVariant.BLUE_FLY)

    function B25_Sloth:TakeDmg(entity, amount, flags, source, countdown)
        local player = entity:ToPlayer()
        if not isSloth(player) then
            return
        end
        if B25_SlothStats.CREEP_IMMUNE and flags & DamageFlag.DAMAGE_ACID ~= 0 then
            return false
        end
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, B25_Sloth.TakeDmg, EntityType.ENTITY_PLAYER)

end

return B25_Sloth