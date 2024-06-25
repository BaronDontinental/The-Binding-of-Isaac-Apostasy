local L21_Envy = {}
local Game = Game()

FAMILIAR_ENVY_ORBIT = Isaac.GetEntityVariantByName("ENVY_ORBIT")
FAMILIAR_ENVY_ORBITV2 = Isaac.GetEntityVariantByName("ENVY_ORBITV2")
FAMILIAR_ENVY_ORBITV3 = Isaac.GetEntityVariantByName("ENVY_ORBITV3")
FAMILIAR_ENVY_ORBITV4 = Isaac.GetEntityVariantByName("ENVY_ORBITV4")

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
local RNG_SHIFT_INDEX = 35
local fam = {
  dmgCount = 0,
  hitChance = 1,
  CloseOrbitCount = 0,
  CloseOrbitUpgrade1 = 0,
  CloseOrbitUpgrade2 = 0,
  CloseOrbitUpgrade3 = 0,
  chance = 10,
  tryspawn = false,
  Close1 = 0,
  Close2 = 0,
  Close3 = 0,
  Far1 = 0,
  Far2 = 0,
  Far3 = 0,
  ZigZag1 = 0,
  ZigZag2 = 0,
  ZigZag3 = 0
  
}

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
      if fam.dmgCount == 1 then
        fam.hitChance = fam.hitChance + 1
        fam.dmgCount = fam.dmgCount - 1
          local roll = math.random(100)
          if roll <= (fam.chance * fam.hitChance) then
            fam.hitChance = -1
            fam.tryspawn = true
          end
      end

      if fam.tryspawn then
        fam.tryspawn = false
        local EnvyFamType = math.random(3)
          if EnvyFamType == 1 then
            fam.Close1 = fam.Close1 + 1
            if fam.Close1 == 1 then
              fam.CloseOrbitCount = fam.CloseOrbitCount + 1
              elseif fam.Close1 == 2 then
                fam.CloseOrbitCount = fam.CloseOrbitCount - 1
                fam.CloseOrbitUpgrade1 = fam.CloseOrbitUpgrade1 + 1
                elseif fam.Close1 == 3 then
                  fam.CloseOrbitUpgrade1 = fam.CloseOrbitUpgrade1 - 1
                  fam.CloseOrbitUpgrade2 = fam.CloseOrbitUpgrade2 + 1
                  elseif fam.close1 == 4 then
                    fam.CloseOrbitUpgrade2 = fam.CloseOrbitUpgrade2 - 1
                    fam.CloseOrbitUpgrade3 = fam.CloseOrbitUpgrade3 + 1
                    elseif fam.Close1 >= 5 then
                      fam.tryspawn = true
                    end
          elseif EnvyFamType == 2 then
            fam.Close2 = fam.Close2 + 1
            if fam.Close2 == 1 then
              fam.CloseOrbitCount = fam.CloseOrbitCount + 1
              elseif fam.Close2 == 2 then
                fam.CloseOrbitCount = fam.CloseOrbitCount - 1
                fam.CloseOrbitUpgrade1 = fam.CloseOrbitUpgrade1 + 1
                elseif fam.Close2 == 3 then
                  fam.CloseOrbitUpgrade1 = fam.CloseOrbitUpgrade1 - 1
                  fam.CloseOrbitUpgrade2 = fam.CloseOrbitUpgrade2 + 1
                  elseif fam.close2 == 4 then
                    fam.CloseOrbitUpgrade2 = fam.CloseOrbitUpgrade2 - 1
                    fam.CloseOrbitUpgrade3 = fam.CloseOrbitUpgrade3 + 1
                    elseif fam.Close2 >= 5 then
                      fam.tryspawn = true
                    end
          elseif EnvyFamType == 3 then
            fam.Close3 = fam.Close3 + 1
            if fam.Close3 == 1 then
              fam.CloseOrbitCount = fam.CloseOrbitCount + 1
              elseif fam.Close3 == 2 then
                fam.CloseOrbitCount = fam.CloseOrbitCount - 1
                fam.CloseOrbitUpgrade1 = fam.CloseOrbitUpgrade1 + 1
                elseif fam.Close3 == 3 then
                  fam.CloseOrbitUpgrade1 = fam.CloseOrbitUpgrade1 - 1
                  fam.CloseOrbitUpgrade2 = fam.CloseOrbitUpgrade2 + 1
                  elseif fam.close3 == 4 then
                    fam.CloseOrbitUpgrade2 = fam.CloseOrbitUpgrade2 - 1
                    fam.CloseOrbitUpgrade3 = fam.CloseOrbitUpgrade3 + 1
                    elseif fam.Close3 >= 5 then
                      fam.tryspawn = true
                    end
          elseif EnvyFamType == 4 then
            fam.Far1 = fam.Far1 + 1

          elseif EnvyFamType == 5 then
            fam.Far2 = fam.Far2 + 1

          elseif EnvyFamType == 6 then
            fam.Far3 = fam.Far3 + 1

          elseif EnvyFamType == 7 then
            fam.ZigZag1 = fam.ZigZag1 + 1

          elseif EnvyFamType == 8 then
            fam.ZigZag2 = fam.ZigZag2 + 1

          elseif EnvyFamType == 9 then
            fam.ZigZag3 = fam.ZigZag3 + 1

          end
      end
      player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, L21_Envy.EUpdate)

    function L21_Envy:DmgCheck(entity, Dmg, DmgFlag, Source, CountDwn)
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= EnvyGuy then
        return
      end
      fam.dmgCount = fam.dmgCount + 1   
    end
    mod:AddCallback(ModCallbacks.MC_POST_ENTITY_TAKE_DMG, L21_Envy.DmgCheck, EntityType.ENTITY_PLAYER)  

  ---@param player EntityPlayer
    function L21_Envy:ChacheFam(player)
      local rng = RNG()
      local seed = math.max(Random(), 1)
      rng:SetSeed(seed, RNG_SHIFT_INDEX)
      player:CheckFamiliar(FAMILIAR_ENVY_ORBIT, fam.CloseOrbitCount, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_ORBITV2, fam.CloseOrbitUpgrade1, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_ORBITV3, fam.CloseOrbitUpgrade2, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_ORBITV4, fam.CloseOrbitUpgrade3, rng)
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L21_Envy.ChacheFam, CacheFlag.CACHE_FAMILIARS) 

    ---@param familiar EntityFamiliar
    function L21_Envy:init(familiar)
      familiar:AddToOrbit(0)
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, L21_Envy.init, FAMILIAR_ENVY_ORBIT)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, L21_Envy.init, FAMILIAR_ENVY_ORBITV2)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, L21_Envy.init, FAMILIAR_ENVY_ORBITV3)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, L21_Envy.init, FAMILIAR_ENVY_ORBITV4)

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
      familiar.Velocity = familiar:GetOrbitPosition(player.Position + player.Velocity) - familiar.Position
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, L21_Envy.UpdateFam, FAMILIAR_ENVY_ORBIT)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, L21_Envy.UpdateFam, FAMILIAR_ENVY_ORBITV2)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, L21_Envy.UpdateFam, FAMILIAR_ENVY_ORBITV3)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, L21_Envy.UpdateFam, FAMILIAR_ENVY_ORBITV4)
    function L21_Envy:OnUpdate()
        local player = Isaac.GetPlayer(0)

        if(Game:GetFrameCount() == 1 and player:GetName() == "L21_Envy") then
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L21_Envy.OnUpdate)
end

return L21_Envy
