local L24_Wrath = {}
local Game = Game()
local WrathGuy = Isaac.GetPlayerTypeByName("L24_Wrath", false)
local SaveManager = require("callbacks.save_manager")

local FULL_DAMAGE_STAGE = LevelStage.STAGE4_1   
local MAX_TOTAL = 999        
local SHOW_HUD = true       
local HUD_X = 36             
local HUD_FROM_BOTTOM = 211  
local HUD_SCALE = 1.0        -- text size. 

local HUD_FONT = "font/pftempestasevencondensed.fnt"

local bombTotal = 0          
local expectedReal = 0       
local deepPocketsUnlocked = false

local hudFont = Font()
hudFont:Load(HUD_FONT)

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
              if TempBombParam:IsDead() and TempBombParam:IsBoss() and not data.Died then
                data.Died = true
                local numbomb = math.random(2,5)
                for i = 1, numbomb do
                  bomb = Isaac.Spawn(
                    EntityType.ENTITY_PICKUP,
                    PickupVariant.PICKUP_BOMB,
                    BombSubType.BOMB_NORMAL,
                    TempBombParam.Position,
                    TempBombParam.Velocity,
                    player):ToPickup()
                end
                    bomb:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, false, true, true)
                    bomb.Timeout = L24_WrathStats.BOMBPERSIST
                    bomb:Update()
                
              elseif TempBombParam:IsDead() and not TempBombParam:IsBoss() and not data.Died then
                data.Died = true
                bomb = Isaac.Spawn(
                  EntityType.ENTITY_PICKUP,
                  PickupVariant.PICKUP_BOMB,
                  BombSubType.BOMB_NORMAL,
                  TempBombParam.Position,
                  TempBombParam.Velocity,
                  player):ToPickup()

                  bomb:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, false, true, true)
                  bomb.Timeout = L24_WrathStats.BOMBPERSIST
                  bomb:Update()
              elseif TempBombParam.ParentNPC
                then
                  data.Died = true
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

    local function saveBombState()
      SaveManager.Set("L24WrathBombs", { unlocked = deepPocketsUnlocked, total = bombTotal })
    end

    function L24_Wrath:onGameStarted(fromSave)
      if fromSave then
        local data = SaveManager.Get("L24WrathBombs")
        deepPocketsUnlocked = data and data.unlocked or false
        bombTotal = data and data.total or 0
      else
        deepPocketsUnlocked = false
        bombTotal = 0
        saveBombState()
      end
      expectedReal = Isaac.GetPlayer(0):GetNumBombs()
    end
    mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, L24_Wrath.onGameStarted)

    function L24_Wrath:onSaveCheckpoint()
      saveBombState()
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, L24_Wrath.onSaveCheckpoint)
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, L24_Wrath.onSaveCheckpoint)

    function L24_Wrath:ManageBombs(player)
      if not deepPocketsUnlocked then
        local threshold = Game:IsGreedMode() and LevelStage.STAGE4_GREED or FULL_DAMAGE_STAGE
        if Game:GetLevel():GetStage() >= threshold then
          deepPocketsUnlocked = true
          bombTotal = player:GetNumBombs()
          expectedReal = bombTotal
          saveBombState()
        end
      end
      if not deepPocketsUnlocked then
        return
      end
      if player:HasGoldenBomb() then
        return
      end

      local cur = player:GetNumBombs()
      bombTotal = bombTotal + (cur - expectedReal)
      if bombTotal < 0 then bombTotal = 0 end
      if bombTotal > MAX_TOTAL then bombTotal = MAX_TOTAL end
      local disp = (bombTotal < 10) and bombTotal or math.floor(bombTotal / 10)
      if cur ~= disp then
        player:AddBombs(disp - cur)
      end
      expectedReal = disp
    end

    function L24_Wrath:PeUpdate(player)
      if player:GetPlayerType() ~= WrathGuy then
        return
      end
      player:EvaluateItems()
      player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
      L24_Wrath:ManageBombs(player)
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
      if source.Type == 6 then
        return
      end
      if flag == 268435584 then 
        return 
      end
        Isaac.Explode(player.Position, player, 45)
    end
  mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, L24_Wrath.dmg, EntityType.ENTITY_PLAYER)

    function L24_Wrath:onRender()
      if not SHOW_HUD or not deepPocketsUnlocked then
        return
      end
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= WrathGuy or player:HasGoldenBomb() then
        return
      end
      local y = Isaac.GetScreenHeight() - HUD_FROM_BOTTOM
      hudFont:DrawStringScaled(string.format("%03d", bombTotal), HUD_X, y, HUD_SCALE, HUD_SCALE, KColor(1, 1, 1, 1), 0, false)
    end
    if ModCallbacks.MC_POST_HUD_RENDER then
      mod:AddCallback(ModCallbacks.MC_POST_HUD_RENDER, L24_Wrath.onRender)
    else
      mod:AddCallback(ModCallbacks.MC_POST_RENDER, L24_Wrath.onRender)
    end

end

return L24_Wrath