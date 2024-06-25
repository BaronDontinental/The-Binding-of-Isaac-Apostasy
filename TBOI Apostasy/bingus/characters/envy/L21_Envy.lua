local L21_Envy = {}
local Game = Game()

CollectibleType.COLLECTIBLE_ENVYORBIT = Isaac.GetItemIdByName("Envy Orbit")
local CONFIG_ENVYORBIT = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_ENVYORBIT)
FAMILIAR_ENVY_ORBIT = Isaac.GetEntityVariantByName("ENVY_ORBIT")

local EnvyGuy = Isaac.GetPlayerTypeByName("L21_Envy", false)

local L21_EnvyStats = {
    DAMAGE = 1,
    SPEED = -0,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0)
}
local dmgCount = 0
local orbitCount = 0
local RNG_SHIFT_INDEX = 35

function L21_Envy:postUpdate()
    function L21_Envy:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "L21_Envy") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage + L21_EnvyStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + L21_EnvyStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + L21_EnvyStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + L21_EnvyStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - L21_EnvyStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + L21_EnvyStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + L21_EnvyStats.LUCK
            end
            --[[if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = L21_EnvyStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | L21_EnvyStats.TEARFLAG
            end]]
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L21_Envy.OnCache)
    function L21_Envy:EUpdate(player)
      if player:GetPlayerType() ~= EnvyGuy then
        return
      end
      print(orbitCount)
      if dmgCount == 3 then
        dmgCount = dmgCount - 3
        orbitCount = orbitCount + 1
      end
      player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, L21_Envy.EUpdate)

    function L21_Envy:DmgCheck(entity, Dmg, DmgFlag, Source, CountDwn)
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= EnvyGuy then
        return
      end
      dmgCount = dmgCount + 1   
    end
    mod:AddCallback(ModCallbacks.MC_POST_ENTITY_TAKE_DMG, L21_Envy.DmgCheck, EntityType.ENTITY_PLAYER)  

  ---@param player EntityPlayer
    function L21_Envy:ChacheFam(player)
      local rng = RNG()
      local seed = math.max(Random(), 1)
      rng:SetSeed(seed, RNG_SHIFT_INDEX)
      player:CheckFamiliar(FAMILIAR_ENVY_ORBIT, orbitCount, rng)
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L21_Envy.ChacheFam, CacheFlag.CACHE_FAMILIARS) 

    ---@param familiar EntityFamiliar
    function L21_Envy:init(familiar)
      familiar:AddToOrbit(0)
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, L21_Envy.init, FAMILIAR_ENVY_ORBIT)

    ---@param familiar EntityFamiliar
    function L21_Envy:UpdateFam(familiar)
      local sprite = familiar:GetSprite()
      local player = familiar.Player
      local direction

      if sprite:IsFinished() then
        sprite:Play("Float")
      end
      familiar:CanBlockProjectiles(true)
      familiar.OrbitDistance = Vector(20,20)
      --familiar.OrbitSpeed = .05
      familiar.Velocity = familiar:GetOrbitPosition(player.Position + player.Velocity) - familiar.Position



    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, L21_Envy.UpdateFam, FAMILIAR_ENVY_ORBIT)
    function L21_Envy:OnUpdate()
        local player = Isaac.GetPlayer(0)

        if(Game:GetFrameCount() == 1 and player:GetName() == "L21_Envy") then
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L21_Envy.OnUpdate)
end

return L21_Envy
