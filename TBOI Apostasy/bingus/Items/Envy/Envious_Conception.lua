local Envious_Conception = {}
local game = Game()

mod.COLLECTIBLE_ENVIOUS_CONCEPTION = Isaac.GetItemIdByName("Envious Conception")
CollectibleType.COLLECTIBLE_ENVIOUS_CONCEPTION = Isaac.GetItemIdByName("Envious Conception")

local RNG_SHIFT_INDEX = 35
local fam = {
  dmgCount = 0,
  hitChance = 3,
  CloseOrbit1 = 0,
  CloseOrbit2 = 0,
  CloseOrbit3 = 0,
  CloseOrbit4 = 0,
  FarOrbit1 = 0,
  FarOrbit2 = 0,
  FarOrbit3 = 0,
  FarOrbit4 = 0,
  FarOrbit5 = 0,
  FarOrbit6 = 0,
  ZigOrbit1 = 0,
  ZigOrbit2 = 0,
  ZigOrbit3 = 0,
  ZigOrbit4 = 0,
  chance = 10,
  TrySpawn = false,
  Close1 = 1,
  Close2 = 0,
  Close3 = 0,
  Far1 = 0,
  Far2 = 0,
  Far3 = 0,
  ZigZag1 = 0,
  ZigZag2 = 0,
  ZigZag3 = 0,
  TryCount = 0,
  RollCount = 0
}
local EnvyFamType



function Envious_Conception:postUpdate()

    ---@param player EntityPlayer
    function Envious_Conception:EUpdate(player)
      if(game:GetFrameCount() == 1) then
        fam = {
          dmgCount = 0,
          hitChance = 15,
          CloseOrbit1 = 0,
          CloseOrbit2 = 0,
          CloseOrbit3 = 0,
          CloseOrbit4 = 0,
          FarOrbit1 = 0,
          FarOrbit2 = 0,
          FarOrbit3 = 0,
          FarOrbit4 = 0,
          FarOrbit5 = 0,
          FarOrbit6 = 0,
          ZigOrbit1 = 0,
          ZigOrbit2 = 0,
          ZigOrbit3 = 0,
          ZigOrbit4 = 0,
          chance = 10,
          TrySpawn = false,
          Close1 = 0,
          Close2 = 0,
          Close3 = 0,
          Far1 = 0,
          Far2 = 0,
          Far3 = 0,
          ZigZag1 = 0,
          ZigZag2 = 0,
          ZigZag3 = 0,
          TryCount = 0,
          RollCount = 0
          }
      end
      if not player:HasCollectible(CollectibleType.COLLECTIBLE_ENVIOUS_CONCEPTION) then
        return
      end 
      if fam.dmgCount == 1 then
        fam.hitChance = fam.hitChance + 1
        fam.dmgCount = fam.dmgCount - 1
          local roll = math.random(100)
          if roll <= (fam.chance * fam.hitChance) then
            fam.hitChance = -1
            fam.TrySpawn = true
            fam.RollCount = fam.RollCount + 1
          end
      end
      if fam.TrySpawn then
        fam.TryCount = 0
        fam.TrySpawn = false
        if fam.RollCount == 1 then
          EnvyFamType = math.random(6)
        else
          EnvyFamType = math.random(9)
        end
          if EnvyFamType == 1 then
            fam.Close1 = fam.Close1 + 1
            if fam.Close1 == 1 then
              fam.CloseOrbit1 = fam.CloseOrbit1 + 1
              elseif fam.Close1 == 2 then
                fam.CloseOrbit1 = fam.CloseOrbit1 - 1
                fam.CloseOrbit2 = fam.CloseOrbit2 + 1
                elseif fam.Close1 == 3 then
                  fam.CloseOrbit2 = fam.CloseOrbit2 - 1
                  fam.CloseOrbit3 = fam.CloseOrbit3 + 1
                  elseif fam.close1 == 4 then
                    fam.CloseOrbit3 = fam.CloseOrbit3 - 1
                    fam.CloseOrbit4 = fam.CloseOrbit4 + 1
                    elseif fam.Close1 >= 5 then
                      EnvyFamType = 2
                      fam.TryCount = fam.TryCount + 1
                      if fam.TryCount == 9 then
                          return
                      end  
                    end
          end
          if EnvyFamType == 2 then
            fam.Close2 = fam.Close2 + 1
            if fam.Close2 == 1 then
              fam.CloseOrbit1 = fam.CloseOrbit1 + 1
              elseif fam.Close2 == 2 then
                fam.CloseOrbit1 = fam.CloseOrbit1 - 1
                fam.CloseOrbit2 = fam.CloseOrbit2 + 1
                elseif fam.Close2 == 3 then
                  fam.CloseOrbit2 = fam.CloseOrbit2 - 1
                  fam.CloseOrbit3 = fam.CloseOrbit3 + 1
                  elseif fam.close2 == 4 then
                    fam.CloseOrbit3 = fam.CloseOrbit3 - 1
                    fam.CloseOrbit4 = fam.CloseOrbit4 + 1
                    elseif fam.Close2 >= 5 then
                      EnvyFamType = 3
                      fam.TryCount = fam.TryCount + 1
                      if fam.TryCount == 9 then
                          return
                      end  
                    end
          end
          if EnvyFamType == 3 then
            fam.Close3 = fam.Close3 + 1
            if fam.Close3 == 1 then
              fam.CloseOrbit1 = fam.CloseOrbit1 + 1
              elseif fam.Close3 == 2 then
                fam.CloseOrbit1 = fam.CloseOrbit1 - 1
                fam.CloseOrbit2 = fam.CloseOrbit2 + 1
                elseif fam.Close3 == 3 then
                  fam.CloseOrbit2 = fam.CloseOrbit2 - 1
                  fam.CloseOrbit3 = fam.CloseOrbit3 + 1
                  elseif fam.close3 == 4 then
                    fam.CloseOrbit3 = fam.CloseOrbit3 - 1
                    fam.CloseOrbit4 = fam.CloseOrbit4 + 1
                    elseif fam.Close3 >= 5 then
                      EnvyFamType = 4
                      fam.TryCount = fam.TryCount + 1
                      if fam.TryCount == 9 then
                          return
                      end  
                    end
          end
          if EnvyFamType == 4 then
            fam.Far1 = fam.Far1 + 1
            if fam.Far1 == 1 then
              fam.FarOrbit3 = fam.FarOrbit3 + 1
              elseif fam.Far1 == 2 then
                fam.FarOrbit3 = fam.FarOrbit3 - 1
                fam.FarOrbit4 = fam.FarOrbit4 + 1
                elseif fam.Far1 == 3 then
                  fam.FarOrbit3 = fam.FarOrbit3 + 1
                  elseif fam.Far1 == 4 then
                    fam.FarOrbit3 = fam.FarOrbit3 - 1
                    fam.FarOrbit4 = fam.FarOrbit4 + 1
                    elseif fam.Far1 >= 5 then
                      EnvyFamType = 5
                      fam.TryCount = fam.TryCount + 1
                      if fam.TryCount == 9 then
                          return
                      end  
                    end
          end
          if EnvyFamType == 5 then
            fam.Far2 = fam.Far2 + 1
            if fam.Far2 == 1 then
              fam.FarOrbit1 = fam.FarOrbit1 + 1
              elseif fam.Far2 == 2 then
                fam.FarOrbit1 = fam.FarOrbit1 - 1
                fam.FarOrbit2 = fam.FarOrbit2 + 1
                elseif fam.Far2 == 3 then
                  fam.FarOrbit1 = fam.FarOrbit1 + 1
                  elseif fam.Far2 == 4 then
                    fam.FarOrbit1 = fam.FarOrbit1 - 1
                    fam.FarOrbit2 = fam.FarOrbit2 + 1
                    elseif fam.Far2 >= 5 then
                      EnvyFamType = 6
                      fam.TryCount = fam.TryCount + 1
                      if fam.TryCount == 9 then
                          return
                      end  
                    end
          end
          if EnvyFamType == 6 then
            fam.Far3 = fam.Far3 + 1
            if fam.Far3 == 1 then
              fam.FarOrbit5 = fam.FarOrbit5 + 1
              elseif fam.Far3 == 2 then
                fam.FarOrbit5 = fam.FarOrbit5 - 1
                fam.FarOrbit6 = fam.FarOrbit6 + 1
                elseif fam.Far3 == 3 then
                  fam.FarOrbit5 = fam.FarOrbit5 + 1
                  elseif fam.Far3 == 4 then
                    fam.FarOrbit5 = fam.FarOrbit5 - 1
                    fam.FarOrbit6 = fam.FarOrbit6 + 1
                    elseif fam.Far3 >= 5 then
                      EnvyFamType = 7
                      fam.TryCount = fam.TryCount + 1
                      if fam.TryCount == 9 then
                          return
                      end  
                    end
          end
          if EnvyFamType == 7 then
            fam.ZigZag1 = fam.ZigZag1 + 1
            if fam.ZigZag1 == 1 then
              fam.ZigOrbit1 = fam.ZigOrbit1 + 1
              elseif fam.ZigZag1 == 2 then
                fam.ZigOrbit1 = fam.ZigOrbit1 - 1
                fam.ZigOrbit2 = fam.ZigOrbit2 + 1
                elseif fam.ZigZag1 == 3 then
                  fam.ZigOrbit2 = fam.ZigOrbit2 - 1
                  fam.ZigOrbit3 = fam.ZigOrbit3 + 1
                  elseif fam.ZigZag1 == 4 then
                    fam.ZigOrbit3 = fam.ZigOrbit3 - 1
                    fam.ZigOrbit4 = fam.ZigOrbit4 + 1
                    elseif fam.ZigZag1 >= 5 then
                      EnvyFamType = 8
                      fam.TryCount = fam.TryCount + 1
                      if fam.TryCount == 9 then
                          return
                      end  
                    end
          end
          if EnvyFamType == 8 then
            fam.ZigZag2 = fam.ZigZag2 + 1
            if fam.ZigZag2 == 1 then
              fam.ZigOrbit1 = fam.ZigOrbit1 + 1
              elseif fam.ZigZag2 == 2 then
                fam.ZigOrbit1 = fam.ZigOrbit1 - 1
                fam.ZigOrbit2 = fam.ZigOrbit2 + 1
                elseif fam.ZigZag2 == 3 then
                  fam.ZigOrbit2 = fam.ZigOrbit2 - 1
                  fam.ZigOrbit3 = fam.ZigOrbit3 + 1
                  elseif fam.ZigZag2 == 4 then
                    fam.ZigOrbit3 = fam.ZigOrbit3 - 1
                    fam.ZigOrbit4 = fam.ZigOrbit4 + 1
                    elseif fam.ZigZag2 >= 5 then
                      EnvyFamType = 9
                      fam.TryCount = fam.TryCount + 1
                      if fam.TryCount == 9 then
                          return
                      end  
                    end
          end
          if EnvyFamType == 9 then
            fam.ZigZag3 = fam.ZigZag3 + 1
            if fam.ZigZag3 == 1 then
              fam.ZigOrbit1 = fam.ZigOrbit1 + 1
              elseif fam.ZigZag3 == 2 then
                fam.ZigOrbit1 = fam.ZigOrbit1 - 1
                fam.ZigOrbit2 = fam.ZigOrbit2 + 1
                elseif fam.ZigZag3 == 3 then
                  fam.ZigOrbit2 = fam.ZigOrbit2 - 1
                  fam.ZigOrbit3 = fam.ZigOrbit3 + 1
                  elseif fam.ZigZag3 == 4 then
                    fam.ZigOrbit3 = fam.ZigOrbit3 - 1
                    fam.ZigOrbit4 = fam.ZigOrbit4 + 1
                    elseif fam.ZigZag3 >= 5 then
                      EnvyFamType = 1
                      fam.TryCount = fam.TryCount + 1
                      if fam.TryCount == 9 then
                          return
                      end  
                    end
          end
      end
      player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Envious_Conception.EUpdate)

    ---@param entity Entity
    ---@param Dmg number
    ---@param DmgFlag integer
    ---@param Source EntityRef
    ---@param CountDwn integer
    function Envious_Conception:DmgCheck(entity, Dmg, DmgFlag, Source, CountDwn)
      local player = Isaac.GetPlayer(0)
      if not player:HasCollectible(CollectibleType.COLLECTIBLE_ENVIOUS_CONCEPTION) then
        return
      end
      fam.dmgCount = fam.dmgCount + 1   
    end
    mod:AddCallback(ModCallbacks.MC_POST_ENTITY_TAKE_DMG, Envious_Conception.DmgCheck, EntityType.ENTITY_PLAYER)  

    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function Envious_Conception:ChacheFam(player, cacheFlag)
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_ENVIOUS_CONCEPTION) then
            return
        end
      local rng = RNG()
      local seed = math.max(Random(), 1)
      rng:SetSeed(seed, RNG_SHIFT_INDEX)
      player:CheckFamiliar(FAMILIAR_ENVY_CLOSE_ORBITV1, fam.CloseOrbit1, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_CLOSE_ORBITV2, fam.CloseOrbit2, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_CLOSE_ORBITV3, fam.CloseOrbit3, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_CLOSE_ORBITV4, fam.CloseOrbit4, rng)
      
      player:CheckFamiliar(FAMILIAR_ENVY_FAR_ORBITV1, fam.FarOrbit1, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_FAR_ORBITV2, fam.FarOrbit2, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_FAR_ORBITV3, fam.FarOrbit3, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_FAR_ORBITV4, fam.FarOrbit4, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_FAR_ORBITV5, fam.FarOrbit5, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_FAR_ORBITV6, fam.FarOrbit6, rng)

      player:CheckFamiliar(FAMILIAR_ENVY_ZIG_ORBITV1, fam.ZigOrbit1, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_ZIG_ORBITV2, fam.ZigOrbit2, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_ZIG_ORBITV3, fam.ZigOrbit3, rng)
      player:CheckFamiliar(FAMILIAR_ENVY_ZIG_ORBITV4, fam.ZigOrbit4, rng)
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Envious_Conception.ChacheFam, CacheFlag.CACHE_FAMILIARS) 

---@param familiar EntityFamiliar
    function Envious_Conception:init(familiar)
      local player = familiar.Player
      if not player:HasCollectible(CollectibleType.COLLECTIBLE_ENVIOUS_CONCEPTION) then
        return
      end
      if (familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV1 or familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV2 or
          familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV3 or familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV3) then
            familiar:AddToOrbit(0)
            elseif (familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV1 or familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV2) then
              familiar:AddToOrbit(1)
              elseif (familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV3 or familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV4) then
                familiar:AddToOrbit(2)
                elseif (familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV5 or familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV6) then
                  familiar:AddToOrbit(3)
      end
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_CLOSE_ORBITV1)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_CLOSE_ORBITV2)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_CLOSE_ORBITV3)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_CLOSE_ORBITV4)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_FAR_ORBITV1)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_FAR_ORBITV2)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_FAR_ORBITV3)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_FAR_ORBITV4)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_FAR_ORBITV5)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Envious_Conception.init, FAMILIAR_ENVY_FAR_ORBITV6)

    ---@param familiar EntityFamiliar 
    function Envious_Conception:UpdateFam(familiar)
      local sprite = familiar:GetSprite()
      local player = familiar.Player
      if not player:HasCollectible(CollectibleType.COLLECTIBLE_ENVIOUS_CONCEPTION) then
        return
      end
      if sprite:IsFinished() then
        sprite:Play("Float")
      end
      familiar:CanBlockProjectiles()
      if (familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV1 or familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV2 or
          familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV3 or familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV3) then
        familiar.OrbitDistance = Vector(20,20)
        familiar.Velocity = familiar:GetOrbitPosition(player.Position + player.Velocity) - familiar.Position
        elseif (familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV1 or familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV2) then
          familiar.OrbitDistance = Vector(55,55)
          familiar.OrbitSpeed = .03
          familiar.Velocity = familiar:GetOrbitPosition(player.Position + player.Velocity) - familiar.Position
          elseif (familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV3 or familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV4) then
            familiar.OrbitDistance = Vector(80,80)
            familiar.OrbitSpeed = -.025
            familiar.Velocity = familiar:GetOrbitPosition(player.Position + player.Velocity) - familiar.Position
            elseif (familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV5 or familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV6) then
              familiar.OrbitDistance = Vector(120,120)
              familiar.OrbitSpeed = .015
              familiar.Velocity = familiar:GetOrbitPosition(player.Position + player.Velocity) - familiar.Position
              elseif (familiar.Variant == FAMILIAR_ENVY_ZIG_ORBITV1 or familiar.Variant == FAMILIAR_ENVY_ZIG_ORBITV2 or
                      familiar.Variant == FAMILIAR_ENVY_ZIG_ORBITV3 or familiar.Variant == FAMILIAR_ENVY_ZIG_ORBITV4) then
                familiar:MoveDiagonally(1)
      end
      if familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV1 then
        familiar.CollisionDamage = player.Damage
        elseif familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV2 then
          familiar.CollisionDamage = player.Damage * 1.5 
          elseif familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV3 then
            familiar.CollisionDamage = player.Damage * 2
            elseif familiar.Variant == FAMILIAR_ENVY_CLOSE_ORBITV4 then
              familiar.CollisionDamage = player.Damage * 2.5
              elseif familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV1 then
                familiar.CollisionDamage = player.Damage 
                elseif familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV2 then
                  familiar.CollisionDamage = player.Damage * 1.5
                  elseif familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV3 then
                    familiar.CollisionDamage = player.Damage * (3/4)
                    elseif familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV4 then
                      familiar.CollisionDamage = player.Damage * (5/4)
                      elseif familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV5 then
                        familiar.CollisionDamage = player.Damage * (2/3)
                        elseif familiar.Variant == FAMILIAR_ENVY_FAR_ORBITV6 then
                          familiar.CollisionDamage = player.Damage * (4/3)
                          elseif familiar.Variant == FAMILIAR_ENVY_ZIG_ORBITV1 then
                            familiar.CollisionDamage = player.Damage * 3
                            elseif familiar.Variant == FAMILIAR_ENVY_ZIG_ORBITV2 then
                              familiar.CollisionDamage = player.Damage * 6 
                              elseif familiar.Variant == FAMILIAR_ENVY_ZIG_ORBITV3 then
                                familiar.CollisionDamage = player.Damage * 9
                                elseif familiar.Variant == FAMILIAR_ENVY_ZIG_ORBITV4 then
                                  familiar.CollisionDamage = player.Damage * 12
      end
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_CLOSE_ORBITV1)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_CLOSE_ORBITV2)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_CLOSE_ORBITV3)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_CLOSE_ORBITV4)

    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_FAR_ORBITV1)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_FAR_ORBITV2)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_FAR_ORBITV3)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_FAR_ORBITV4)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_FAR_ORBITV5)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_FAR_ORBITV6)
    
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_ZIG_ORBITV1)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_ZIG_ORBITV2)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_ZIG_ORBITV3)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Envious_Conception.UpdateFam, FAMILIAR_ENVY_ZIG_ORBITV4)



end

return Envious_Conception