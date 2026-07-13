local B27_Envy = {}
local Game = Game()
local sfxManager = SFXManager()

local EnvyGuyB = Isaac.GetPlayerTypeByName("B27_Envy", true)
if EnvyGuyB == -1 then
    EnvyGuyB = Isaac.GetPlayerTypeByName("B27_Envy", false)
end

local RNG_SHIFT_INDEX = 35
local SaveManager = require("callbacks.save_manager")

local FAMILIAR_ENVY_CLONE = Isaac.GetEntityVariantByName("BENVY_CLONE")
local PLAYER_SUBTYPE = 0
local CLONE_SUBTYPE = 1

local ORBIT_CLOSE = {
    Isaac.GetEntityVariantByName("BENVY_CLOSE_ORBITV1"),
    Isaac.GetEntityVariantByName("BENVY_CLOSE_ORBITV2"),
    Isaac.GetEntityVariantByName("BENVY_CLOSE_ORBITV3"),
    Isaac.GetEntityVariantByName("BENVY_CLOSE_ORBITV4")
}
local ORBIT_FAR = {
    Isaac.GetEntityVariantByName("BENVY_FAR_ORBITV1"),
    Isaac.GetEntityVariantByName("BENVY_FAR_ORBITV2"),
    Isaac.GetEntityVariantByName("BENVY_FAR_ORBITV3"),
    Isaac.GetEntityVariantByName("BENVY_FAR_ORBITV4"),
    Isaac.GetEntityVariantByName("BENVY_FAR_ORBITV5"),
    Isaac.GetEntityVariantByName("BENVY_FAR_ORBITV6")
}

local B27_EnvyStats = {
    DAMAGE = 1,
    SPEED = -0,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    Flying = true,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0),
    BLINKTIME = 10,      
    CLONESPEED = 1.5,     
    CLONEDRAG = 0.85,     
    CLONEDAMAGE = 1,      
    STARTBLACKHEARTS = 2,
    BLINK_WARNTIME = 1.5, 
    BLINK_FLASHCOLOR = Color(1, 1, 1, 1, 0.6, 0, 0) 
}

local closeSteps = { {1,0,0,0}, {0,1,0,0}, {0,0,1,0}, {0,0,0,1} }
local farSteps = { {1,0}, {0,1}, {1,1}, {0,2} }
local OrbitFamilies = {
    {name = "Close1", variants = ORBIT_CLOSE, steps = closeSteps, layer = 0, distance = Vector(20,20), damage = {1, 1.5, 2, 2.5}},
    {name = "Close2", variants = ORBIT_CLOSE, steps = closeSteps, layer = 0, distance = Vector(20,20), damage = {1, 1.5, 2, 2.5}},
    {name = "Close3", variants = ORBIT_CLOSE, steps = closeSteps, layer = 0, distance = Vector(20,20), damage = {1, 1.5, 2, 2.5}},
    {name = "Far1", variants = {ORBIT_FAR[3], ORBIT_FAR[4]}, steps = farSteps, layer = 2, distance = Vector(80,80), speed = -.025, damage = {3/4, 5/4}},
    {name = "Far2", variants = {ORBIT_FAR[1], ORBIT_FAR[2]}, steps = farSteps, layer = 1, distance = Vector(55,55), speed = .03, damage = {1, 1.5}},
    {name = "Far3", variants = {ORBIT_FAR[5], ORBIT_FAR[6]}, steps = farSteps, layer = 3, distance = Vector(120,120), speed = .015, damage = {2/3, 4/3}}
}

local AllOrbitalVariants = {}
local OrbitalConfig = {}
for _, family in ipairs(OrbitFamilies) do
    for i, variant in ipairs(family.variants) do
        if not OrbitalConfig[variant] then
            OrbitalConfig[variant] = {layer = family.layer, distance = family.distance, speed = family.speed, dmgMult = family.damage[i]}
            table.insert(AllOrbitalVariants, variant)
        end
    end
end

local function freshTiers()
    local tiers = {}
    for _, family in ipairs(OrbitFamilies) do
        tiers[family.name] = 0
    end
    return tiers
end

local function freshFam()
    return {
        dmgCount = 0,
        hitChance = 15,
        chance = 10,
        RollCount = 0,
        NextOwner = "player",  
        BlinkFrames = B27_EnvyStats.BLINKTIME * 30,
        player = freshTiers(),
        clone = freshTiers()
    }
end
local fam = freshFam()

local function getClone()
    local zigs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FAMILIAR_ENVY_CLONE, CLONE_SUBTYPE)
    if zigs[1] then
        return zigs[1]:ToFamiliar()
    end
    return nil
end

local function grantOrbital(owner)
    local tiers = fam[owner]
    local famType = math.random(#OrbitFamilies)
    for _ = 1, #OrbitFamilies do
        local family = OrbitFamilies[famType]
        if tiers[family.name] < #family.steps then
            tiers[family.name] = tiers[family.name] + 1
            return
        end
        famType = (famType % #OrbitFamilies) + 1
    end
end

local function orbitalCounts(owner)
    local counts = {}
    for _, family in ipairs(OrbitFamilies) do
        local tier = fam[owner][family.name]
        if tier and tier > 0 then
            for i, n in ipairs(family.steps[tier]) do
                if n > 0 then
                    local variant = family.variants[i]
                    counts[variant] = (counts[variant] or 0) + n
                end
            end
        end
    end
    return counts
end

function B27_Envy:postUpdate()
    function B27_Envy:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "B27_Envy") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage + B27_EnvyStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + B27_EnvyStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + B27_EnvyStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + B27_EnvyStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - B27_EnvyStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + B27_EnvyStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + B27_EnvyStats.LUCK
            end
            if (cacheFlag == CacheFlag.CACHE_FLYING) then
              player.CanFly = true
            end
            --[[if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = B27_EnvyStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | B27_EnvyStats.TEARFLAG
            end]]
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B27_Envy.OnCache)

    function B27_Envy:onGameStarted(fromSave)
      if fromSave then
        local saved = SaveManager.Get("B27Envy")
        if saved then
          fam = saved
        end
      else
        fam = freshFam()
        SaveManager.Set("B27Envy", fam)
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, B27_Envy.onGameStarted)

    function B27_Envy:onSave()
      SaveManager.Set("B27Envy", fam)
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, B27_Envy.onSave)
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, B27_Envy.onSave)

    function B27_Envy:EUpdate(player)
      if player:GetPlayerType() ~= EnvyGuyB then
        return
      end

      if fam.dmgCount > 0 then
        fam.hitChance = fam.hitChance + 1
        fam.dmgCount = fam.dmgCount - 1
          local roll = math.random(100)
          if roll <= (fam.chance * fam.hitChance) then
            fam.hitChance = -1
            fam.RollCount = fam.RollCount + 1
            grantOrbital(fam.NextOwner)
            if fam.NextOwner == "player" then
              fam.NextOwner = "clone"
            else
              fam.NextOwner = "player"
            end
          end
      end

      local clone = getClone()

      if clone then
        fam.BlinkFrames = (fam.BlinkFrames or B27_EnvyStats.BLINKTIME * 30) - 1
        if fam.BlinkFrames > 0 and fam.BlinkFrames <= B27_EnvyStats.BLINK_WARNTIME * 30 then
          if fam.BlinkFrames % 10 < 5 then
            player:SetColor(B27_EnvyStats.BLINK_FLASHCOLOR, 2, 1, false, false)
          end
          if fam.BlinkFrames % 30 == 0 then
            sfxManager:Play(SoundEffect.SOUND_BEEP, 1, 0, false, 1)
          end
        end        
        if fam.BlinkFrames <= 0 then
          fam.BlinkFrames = B27_EnvyStats.BLINKTIME * 30
          local room = Game:GetRoom()
          local landPos = clone.Position
          local coll = room:GetGridCollisionAtPos(landPos)
          if coll ~= GridCollisionClass.COLLISION_NONE and coll ~= GridCollisionClass.COLLISION_PIT then
            landPos = room:FindFreePickupSpawnPosition(landPos, 0, true, true)
          end
          Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector(0,0), player)
          Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, landPos, Vector(0,0), player)
          clone.Position = player.Position
          player.Position = landPos
          sfxManager:Play(SoundEffect.SOUND_BLACK_POOF, 1, 0, false, 1)
        end
      end
      local red = player:GetMaxHearts()
      if red > 0 then
        player:AddMaxHearts(-red)
        player:AddSoulHearts(red)
      end
      local bone = player:GetBoneHearts()
      if bone > 0 then
        player:AddBoneHearts(-bone)
        player:AddSoulHearts(bone * 2)
      end
      player:SetCanShoot(false)
      if player.CanFly == false then
        player.CanFly = true
      end
      player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B27_Envy.EUpdate)

    function B27_Envy:DmgCheck(entity, Dmg, DmgFlag, Source, CountDwn)
      local player = entity:ToPlayer()
      if not player or player:GetPlayerType() ~= EnvyGuyB then
        return
      end
      fam.dmgCount = fam.dmgCount + 1
    end
    mod:AddCallback(ModCallbacks.MC_POST_ENTITY_TAKE_DMG, B27_Envy.DmgCheck, EntityType.ENTITY_PLAYER)

  ---@param player EntityPlayer
    function B27_Envy:ChacheFam(player)
      if player:GetPlayerType() ~= EnvyGuyB then
        return
      end
      local rng = RNG()
      local seed = math.max(Random(), 1)
      rng:SetSeed(seed, RNG_SHIFT_INDEX)
      player:CheckFamiliar(FAMILIAR_ENVY_CLONE, 1, rng, nil, CLONE_SUBTYPE)
      local playerCounts = orbitalCounts("player")
      local cloneCounts = orbitalCounts("clone")
      for _, variant in ipairs(AllOrbitalVariants) do
        player:CheckFamiliar(variant, playerCounts[variant] or 0, rng, nil, PLAYER_SUBTYPE)
        player:CheckFamiliar(variant, cloneCounts[variant] or 0, rng, nil, CLONE_SUBTYPE)
      end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B27_Envy.ChacheFam, CacheFlag.CACHE_FAMILIARS)

  ---@param familiar EntityFamiliar
    function B27_Envy:init(familiar)
      local player = familiar.Player
      if player:GetPlayerType() ~= EnvyGuyB then
        return
      end
      if familiar.Variant == FAMILIAR_ENVY_CLONE and familiar.SubType == CLONE_SUBTYPE then
        familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
        return
      end
      local config = OrbitalConfig[familiar.Variant]
      if not config then
        return
      end
      if familiar.SubType == CLONE_SUBTYPE then
        familiar:AddToOrbit(config.layer + 4) 
      else
        familiar:AddToOrbit(config.layer)
      end
    end
    for _, variant in ipairs(AllOrbitalVariants) do
      mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, B27_Envy.init, variant)
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, B27_Envy.init, FAMILIAR_ENVY_CLONE)

  ---@param familiar EntityFamiliar
    function B27_Envy:UpdateFam(familiar)
      local sprite = familiar:GetSprite()
      local player = familiar.Player
      if player:GetPlayerType() ~= EnvyGuyB then
        return
      end
      local config = OrbitalConfig[familiar.Variant]
      if not config then
        return
      end
      if sprite:IsFinished() then
        sprite:Play("Float")
      end
      familiar:CanBlockProjectiles()
      familiar.OrbitDistance = config.distance
      if config.speed then
        familiar.OrbitSpeed = config.speed
      end
      local center = player
      if familiar.SubType == CLONE_SUBTYPE then
        local clone = getClone()
        if clone then
---@diagnostic disable-next-line: cast-local-type
          center = clone
        end
      end
      familiar.Velocity = familiar:GetOrbitPosition(center.Position + center.Velocity) - familiar.Position
      familiar.CollisionDamage = player.Damage * config.dmgMult
    end
    for _, variant in ipairs(AllOrbitalVariants) do
      mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, B27_Envy.UpdateFam, variant)
    end

  ---@param familiar EntityFamiliar
    function B27_Envy:CloneUpdate(familiar)
      local sprite = familiar:GetSprite()
      local player = familiar.Player
      if player:GetPlayerType() ~= EnvyGuyB or familiar.SubType ~= CLONE_SUBTYPE then
        return
      end
      if sprite:IsFinished() then
        sprite:Play("Float")
      end
      familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
      familiar:CanBlockProjectiles()
      local input = player:GetShootingInput()
      familiar.Velocity = familiar.Velocity * B27_EnvyStats.CLONEDRAG + input * B27_EnvyStats.CLONESPEED
      familiar.CollisionDamage = player.Damage * B27_EnvyStats.CLONEDAMAGE
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, B27_Envy.CloneUpdate, FAMILIAR_ENVY_CLONE)

    function B27_Envy:OnUpdate()
        local player = Isaac.GetPlayer(0)

        if(Game:GetFrameCount() == 1 and player:GetName() == "B27_Envy") then
            player:AddBlackHearts(B27_EnvyStats.STARTBLACKHEARTS)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B27_Envy.OnUpdate)
end

return B27_Envy