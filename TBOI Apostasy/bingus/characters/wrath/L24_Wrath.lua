local L24_Wrath = {}
local Game = Game()
local WrathGuy = Isaac.GetPlayerTypeByName("L24_Wrath", false)

local L24_WrathStats = {
    DAMAGE = 15,
    SPEED = -0,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    --TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0),
    BOMBPERSIST = 60
}
local count
local HasBombs = nil
local bomb

function L24_Wrath:postUpdate()
    function L24_Wrath:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)        

        if(player:GetName() == "L24_Wrath") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = (player.Damage * 10) + L24_WrathStats.DAMAGE
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
            if (cacheFlag == CacheFlag.CACHE_WEAPON) then
              player.EnableWeaponType(player, WeaponType.WEAPON_BOMBS, true)
              player.EnableWeaponType(player, WeaponType.WEAPON_TEARS, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_BRIMSTONE, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_LASER, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_KNIFE, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_MONSTROS_LUNGS, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_LUDOVICO_TECHNIQUE, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_TECH_X, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_BONE, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_NOTCHED_AXE, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_URN_OF_SOULS, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_SPIRIT_SWORD, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_FETUS, false)
              player.EnableWeaponType(player, WeaponType.WEAPON_UMBILICAL_WHIP, false)
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L24_Wrath.OnCache)

    function L24_Wrath:OnUpdate()
        local player = Isaac.GetPlayer(0)

        if(Game:GetFrameCount() == 1 and player:GetName() == "L24_Wrath") then
          --player:AddPill()
        end
        if player:GetPlayerType() ~= WrathGuy then
          return
        end
        local entities = Isaac.GetRoomEntities()
          for _, entity in ipairs(entities) do
            local data = entity:GetData() 
            TempBombParam = entity:ToNPC()
            Bombinfo = entity:ToBomb()
            if Bombinfo then
              Bombinfo.ExplosionDamage = 0 + player.Damage
            end
            if TempBombParam and TempBombParam:IsEnemy() and TempBombParam:IsActiveEnemy(true) then
              if TempBombParam:IsDead() and not data.Died then
                data.Died = true
                bomb = Isaac.Spawn(
                  EntityType.ENTITY_PICKUP,
                  PickupVariant.PICKUP_BOMB,
                  BombSubType.BOMB_NORMAL,
                  TempBombParam.Position,
                  TempBombParam.Velocity,
                  player):ToPickup()
                  
---@diagnostic disable-next-line: need-check-nil
                  bomb:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, false, true, true)
                  bomb.Timeout = L24_WrathStats.BOMBPERSIST
---@diagnostic disable-next-line: need-check-nil
                  bomb:Update()
              end
            end
          end
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
