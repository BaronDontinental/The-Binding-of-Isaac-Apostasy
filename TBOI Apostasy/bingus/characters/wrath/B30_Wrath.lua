local B30_Wrath = {}
local Game = Game()
local sfxManager = SFXManager()
local WrathGuy = Isaac.GetPlayerTypeByName("B30_Wrath", true)
local costumeWrath = "gfx/characters/character_b30_wrath.anm2"
local sprite = Sprite()
local sprightsheeg1 = Renderer.LoadImage("gfx/ui/ui_bombhearts.png")
local sprightsheeg2 = Renderer.LoadImage("gfx/ui/ui_hearts.png")

local B30_WrathStats = {
  DAMAGE = 10,
  SPEED = -0,
  SHOTSPEED = 0,
  MAXFIREDELAY = 0,
  TEARHEIGHT = 0,
  TEARFALLINGSPEED = 0,
  Flying = false,
  LUCK = 0,
  TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0),
  BOMBPERSIST = 60,
  MAXHEARTS = 24,              
  HEAL_NORMAL = 2,           
  HEAL_DOUBLEPACK = 4,        
  HEART_SPACING_X = 12,       
  HEART_SPACING_Y = 10,     
  HEARTS_PER_ROW = 6,
  BURST_OFFSET = Vector(6, 6), 
  FUSETIME = 30,              
  FUSE_WARNTIME = 1.5,           
  FUSE_FLASHCOLOR = Color(1, 1, 1, 1, 0.6, 0, 0), 
  NUM_BOMB = 5
}
local count
local HasBombs = nil
local bomb

local hudIsBomb = false
local burstSprite = Sprite()
burstSprite:Load("gfx/ui/ui_bombheart_burst.anm2", true)
local burstActive = false
local burstIndex = 0
local fuseSprite = Sprite()
fuseSprite:Load("gfx/ui/ui_bombheart_fuse.anm2", true)
fuseSprite:Play("Burn", true)
local fuseTimer = B30_WrathStats.FUSETIME * 30 
local heartsPos = Vector(0, 0)

function B30_Wrath:postUpdate()
    function B30_Wrath:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "B30_Wrath") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = (player.Damage * 7.5) + B30_WrathStats.DAMAGE
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

      function B30_Wrath:OnInit(player)
        if player:GetPlayerType() ~= WrathGuy then
          return
        end
        local playSprite = player:GetSprite()
        if playSprite:GetFilename() ~= costumeWrath then
          local anim = playSprite:GetAnimation()
          local frame = playSprite:GetFrame()
          playSprite:Load(costumeWrath, true)
          if anim and anim ~= "" then
            playSprite:Play(anim, true)
            playSprite:SetFrame(frame)
          end
        end
      end
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, B30_Wrath.OnInit)
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, B30_Wrath.OnInit)

      function B30_Wrath:reset(player)
        if player:GetPlayerType() ~= WrathGuy then
          return
        end
        hudIsBomb = false
        fuseTimer = B30_WrathStats.FUSETIME * 30
      end
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, B30_Wrath.reset)

    function B30_Wrath:OnUpdate()
      local player = Isaac.GetPlayer(0)

      if(Game:GetFrameCount() == 1 and player:GetName() == "B30_Wrath") then
        --player:AddPill()

      end
      if player:GetPlayerType() ~= WrathGuy then
        return
      end

      fuseSprite:Update()
      fuseTimer = fuseTimer - 1
      if fuseTimer > 0 and fuseTimer <= B30_WrathStats.FUSE_WARNTIME * 30 then
        if fuseTimer % 10 < 5 then
          player:SetColor(B30_WrathStats.FUSE_FLASHCOLOR, 2, 1, false, false)
        end
        if fuseTimer % 30 == 0 then
          sfxManager:Play(SoundEffect.SOUND_BEEP, 1, 0, false, 1) 
        end
      end
      if fuseTimer <= 0 then
        fuseTimer = B30_WrathStats.FUSETIME * 30
        player:TakeDamage(2, 0, EntityRef(player), 0)
        sfxManager:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT) --no hurt grunt
        Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_TROLL, 0, player.Position, Vector(0,0), player)
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
                for i = 1, B30_WrathStats.NUM_BOMB do
                  bomb = Isaac.Spawn(
                    EntityType.ENTITY_PICKUP,
                    PickupVariant.PICKUP_BOMB,
                    BombSubType.BOMB_NORMAL,
                    TempBombParam.Position,
                    TempBombParam.Velocity,
                    player):ToPickup()
                end
                    bomb:Update()
              elseif TempBombParam.ParentNPC
                then
                  data.Died = true
              end
          end
        end
      end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B30_Wrath.OnUpdate)

    function B30_Wrath:PEffect(player)
      if player:GetPlayerType() ~= WrathGuy then
        return
      end
      if player:GetMaxHearts() > B30_WrathStats.MAXHEARTS then
        player:AddMaxHearts(B30_WrathStats.MAXHEARTS - player:GetMaxHearts())
      end
      if player:GetSoulHearts() > 0 then
        player:AddSoulHearts(-player:GetSoulHearts())
      end
      if player:GetBoneHearts() > 0 then
        player:AddBoneHearts(-player:GetBoneHearts())
      end
      if player:GetEternalHearts() > 0 then
        player:AddEternalHearts(-player:GetEternalHearts())
      end
      local rotten = player:GetRottenHearts()
      if rotten > 0 then
        player:AddRottenHearts(-rotten * 2)
        player:AddHearts(rotten * 2)
      end
      if player:GetHearts() % 2 == 1 then
        player:AddHearts(1) 
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B30_Wrath.PEffect)

    function B30_Wrath:BombTouch(pickup, collider, low)
      local player = collider:ToPlayer()
      if not player or player:GetPlayerType() ~= WrathGuy then
        return
      end
      if pickup:GetData().BombHeartTaken then
        return
      end
      local missing = player:GetMaxHearts() - player:GetHearts()
      if pickup.SubType == BombSubType.BOMB_GOLDEN and missing <= 0 then
        player:AddGoldenHearts(1)
      end
      if missing <= 0 then
        return 
      end
      if pickup.SubType == BombSubType.BOMB_NORMAL then
        player:AddHearts(B30_WrathStats.HEAL_NORMAL)
      elseif pickup.SubType == BombSubType.BOMB_DOUBLEPACK then
        player:AddHearts(B30_WrathStats.HEAL_DOUBLEPACK)
      elseif pickup.SubType == BombSubType.BOMB_GOLDEN then
        player:AddHearts(B30_WrathStats.HEAL_NORMAL)
        player:AddGoldenHearts(1)
        if missing == 2 then
          player:AddBombs(1) 
        end
      else
        return 
      end
      pickup:GetData().BombHeartTaken = true
      sfxManager:Play(SoundEffect.SOUND_STEAM_HALFSEC, .75, 0, false, 1) 
      pickup:GetSprite():Play("Collect", true)
      pickup:Die()
      return false
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, B30_Wrath.BombTouch, PickupVariant.PICKUP_BOMB)

    function B30_Wrath:HeartBlock(pickup, collider, low)
      local player = collider:ToPlayer()
      if not player or player:GetPlayerType() ~= WrathGuy then
        return
      end
      return false
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, B30_Wrath.HeartBlock, PickupVariant.PICKUP_HEART)

    function B30_Wrath:TakeDmg(entity, amount, flags, source, countdown)
      local player = entity:ToPlayer()
      if not player or player:GetPlayerType() ~= WrathGuy then
        return
      end
      if flags & DamageFlag.DAMAGE_FAKE ~= 0 then
        return
      end
      if flags ~= DamageFlag.DAMAGE_EXPLOSION then
        flags = flags | DamageFlag.DAMAGE_NO_PENALTIES
      end
      if amount > 0 and amount <= 2 then
        return {Damage = 2, DamageFlags = flags} 
      elseif amount > 2 and amount <= 4 then
        return {Damage = 4, DamageFlags = flags}
      elseif amount > 4 and amount <= 6 then
        return {Damage = 6, DamageFlags = flags}
      elseif amount > 6 and amount <= 8 then
        return {Damage = 8, DamageFlags = flags}
      end
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, B30_Wrath.TakeDmg, EntityType.ENTITY_PLAYER)

    --fires once each time a bomb heart actually breaks
    function B30_Wrath:HeartBreak(entity, amount, flags, source, countdown)
      local player = entity:ToPlayer()
      if not player or player:GetPlayerType() ~= WrathGuy then
        return
      end
      if amount <= 0 or flags & DamageFlag.DAMAGE_FAKE ~= 0 then
        return
      end
      fuseTimer = B30_WrathStats.FUSETIME * 30 
      burstIndex = math.floor(player:GetHearts() / 2) --the container that just emptied
      burstActive = true
      burstSprite:Play("Break", true)
      --EFFECT TBD: broken bomb heart effect goes here
      sfxManager:Play(SoundEffect.SOUND_ROCKET_EXPLOSION, 1, 0, false, 1) --sound TBD
    end
    mod:AddCallback(ModCallbacks.MC_POST_ENTITY_TAKE_DMG, B30_Wrath.HeartBreak, EntityType.ENTITY_PLAYER)

    function B30_Wrath:dmg(entity, amt, flag, source, frame)
      local player = entity:ToPlayer()
      if not player or player:GetPlayerType() ~= WrathGuy then
        return
      end
      if (flag & DamageFlag.DAMAGE_EXPLOSION) ~=0 then
---@diagnostic disable-next-line: param-type-mismatch
        player:UseCard(Card.CARD_TOWER, UseFlag.USE_NOANNOUNCER)
        player:Die()
      end
    end
  mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, B30_Wrath.dmg, EntityType.ENTITY_PLAYER)


    function B30_Wrath:HudHearts(offset, heartsSprite, position, unknown, player)
      heartsPos = position 
      local wantBomb = player ~= nil and player:GetPlayerType() == WrathGuy
      if wantBomb ~= hudIsBomb then
        if wantBomb then
          heartsSprite:Load("gfx/ui/ui_hearts.anm2", true)
          heartsSprite:SetSpritesheet(0, sprightsheeg1)
          heartsSprite:LoadGraphics()
        else
          heartsSprite:Load("gfx/ui/ui_hearts.anm2", true)
          heartsSprite:SetSpritesheet(0, sprightsheeg2)
          heartsSprite:LoadGraphics()
        end
        hudIsBomb = wantBomb
      end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PLAYERHUD_RENDER_HEARTS, B30_Wrath.HudHearts)

    function B30_Wrath:BurstUpdate()
      if burstActive then
        burstSprite:Update()
        if burstSprite:IsFinished("Break") then
          burstActive = false
        end
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B30_Wrath.BurstUpdate)

    function B30_Wrath:BurstRender()
      if not burstActive or not Game:GetHUD():IsVisible() then
        return
      end
      local row = math.floor(burstIndex / B30_WrathStats.HEARTS_PER_ROW)
      local col = burstIndex % B30_WrathStats.HEARTS_PER_ROW
      local pos = heartsPos + B30_WrathStats.BURST_OFFSET
        + Vector(col * B30_WrathStats.HEART_SPACING_X, row * B30_WrathStats.HEART_SPACING_Y)
      burstSprite:Render(pos)
    end
    mod:AddCallback(ModCallbacks.MC_POST_RENDER, B30_Wrath.BurstRender)

    --draws the burning fuse on the rightmost filled bomb heart
    function B30_Wrath:FuseRender()
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= WrathGuy or not Game:GetHUD():IsVisible() then
        return
      end
      local filled = math.floor(player:GetHearts() / 2)
      if filled <= 0 then
        return
      end
      local index = filled - 1 --rightmost filled heart
      local row = math.floor(index / B30_WrathStats.HEARTS_PER_ROW)
      local col = index % B30_WrathStats.HEARTS_PER_ROW
      local pos = heartsPos + B30_WrathStats.BURST_OFFSET
        + Vector(col * B30_WrathStats.HEART_SPACING_X, row * B30_WrathStats.HEART_SPACING_Y)
      fuseSprite:Render(pos)
    end
    mod:AddCallback(ModCallbacks.MC_POST_RENDER, B30_Wrath.FuseRender)
end

return B30_Wrath