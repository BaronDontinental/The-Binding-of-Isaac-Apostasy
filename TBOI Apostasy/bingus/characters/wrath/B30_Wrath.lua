local B30_Wrath = {}
local Game = Game()
local WrathGuy = Isaac.GetPlayerTypeByName("B30_Wrath", true)

local B30_WrathStats = {
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

function B30_Wrath:postUpdate()
    function B30_Wrath:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "B30_Wrath") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = (player.Damage * 10) + B30_WrathStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + B30_WrathStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + B30_WrathStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + B30_WrathStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - B30_WrathStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + B30_WrathStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + B30_WrathStats.LUCK
            end
            --[[if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = B30_WrathStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | B30_WrathStats.TEARFLAG
            end]]
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
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B30_Wrath.OnCache)

    function B30_Wrath:OnUpdate()
      local player = Isaac.GetPlayer(0)

      if(Game:GetFrameCount() == 1 and player:GetName() == "B30_Wrath") then
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
                bomb.Timeout = B30_WrathStats.BOMBPERSIST
---@diagnostic disable-next-line: need-check-nil
                bomb:Update()
            end
          end
        end
      end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B30_Wrath.OnUpdate)

    function B30_Wrath:dmg(entity, amt, flag, source, frame)
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= WrathGuy then
        return
      end
      if flag == DamageFlag.DAMAGE_EXPLOSION then
---@diagnostic disable-next-line: param-type-mismatch
        player:UseCard(Card.CARD_TOWER, UseFlag.USE_NOANNOUNCER)
        player:Die()
      end
    end
  mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, B30_Wrath.dmg, EntityType.ENTITY_PLAYER)
end

return B30_Wrath
