local L24_Wrath = {}
local Game = Game()
local WrathGuy = Isaac.GetPlayerTypeByName("L24_Wrath", false)

local L24_WrathStats = {
    DAMAGE = 1,
    SPEED = -0,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    --TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0)
    
}
local count
local HasBombs = nil

function L24_Wrath:postUpdate()
    function L24_Wrath:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)        

        if(player:GetName() == "L24_Wrath") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage + L24_WrathStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + L24_WrathStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + L24_WrathStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + L24_WrathStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - L24_WrathStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + L24_WrathStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + L24_WrathStats.LUCK
            end
            --[[if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = L24_WrathStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | L24_WrathStats.TEARFLAG
            end]]
            if (cacheFlag == CacheFlag.CACHE_WEAPON) then
              player.EnableWeaponType(player, WeaponType.WEAPON_BOMBS, true)
              player.EnableWeaponType(player, WeaponType.WEAPON_TEARS, false)
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L24_Wrath.OnCache)
    function L24_Wrath:OnUpdate()
        local player = Isaac.GetPlayer(0)

        if(Game:GetFrameCount() == 1 and player:GetName() == "L24_Wrath") then
            --player:AddBombs(9)
        end
        if player:GetPlayerType() ~= WrathGuy then
          return
        end
        local entities = Isaac.GetRoomEntities()
          for _, entity in ipairs(entities) do
            local data = entity:GetData() 
            TempBombParam = entity:ToNPC()
            if TempBombParam and TempBombParam:IsEnemy() then
              if TempBombParam:IsDead() and not data.Died then
                data.Died = true
                Isaac.Spawn(
                  EntityType.ENTITY_PICKUP,
                  PickupVariant.PICKUP_BOMB,
                  BombSubType.BOMB_NORMAL,
                  TempBombParam.Position,
                  TempBombParam.Velocity,
                  nil)
              end
            end
          end

          -- use morph command to set the ingore modifiers of the bombs to make it so that items wont turn it into another pickup or whatever.  

    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L24_Wrath.OnUpdate)

    function L24_Wrath:OnFire(dir, amt, entity, weapon)
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= WrathGuy then
        return
      end
        player:AddBombs(-1)
    end
mod:AddCallback(ModCallbacks.MC_POST_TRIGGER_WEAPON_FIRED, L24_Wrath.OnFire)

    function L24_Wrath:PeUpdate(player)
      if player:GetPlayerType() ~= WrathGuy then
        return
      end
      player:EvaluateItems()
      player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
      count = player:GetNumBombs()
      if count == 0 then
        HasBombs = false
      end
      if count >= 1 then
        HasBombs = true
      end
      if HasBombs ~= nil then
        player:SetCanShoot(HasBombs)
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, L24_Wrath.PeUpdate)

    function L24_Wrath:dmg(entity, amt, flag, source, frame)
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= WrathGuy then
        return
      end
        Isaac.Explode(player.Position, player, 45)
    end
  mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, L24_Wrath.dmg, EntityType.ENTITY_PLAYER)

end

return L24_Wrath