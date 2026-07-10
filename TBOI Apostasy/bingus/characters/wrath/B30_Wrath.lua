local B30_Wrath = {}
local Game = Game()
local sfxManager = SFXManager()
local WrathGuy = Isaac.GetPlayerTypeByName("B30_Wrath", true)
local sprite = Sprite()

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
  BOMBPERSIST = 60,
  --bomb hearts
  MAXHEARTS = 8,              --4 full bomb hearts, in half heart units
  HEAL_NORMAL = 2,            --one full bomb heart per normal bomb
  HEAL_DOUBLEPACK = 4,        --two full bomb hearts per double pack
  HEART_SPACING_X = 12,       --hud distance between heart containers
  HEART_SPACING_Y = 10,       --hud distance between heart rows
  HEARTS_PER_ROW = 6,
  BURST_OFFSET = Vector(6, 6) --nudge the burst onto the heart, tweak in game
}
local count
local HasBombs = nil
local bomb

local hudIsBomb = false
local burstSprite = Sprite()
--burstSprite:Load("gfx/ui/ui_bombheart_burst.anm2", true)
local burstActive = false
local burstIndex = 0
local heartsPos = Vector(0, 0)

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
          sprite:Load("gfx/ui/ui_hearts.anm2", true)
          sprite:ReplaceSpritesheet(0, "gfx/ui/ui_bombhearts.png")
          sprite:LoadGraphics()
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

    --keeps health in a legal bomb heart state every frame:
    --no half hearts, no soul/bone/eternal/rotten hearts, max 4 containers
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
        player:AddHearts(1) --half heals from items snap up to a full bomb heart
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B30_Wrath.PEffect)

    --bomb pickups fill empty bomb hearts before they give ammo
    function B30_Wrath:BombTouch(pickup, collider, low)
      local player = collider:ToPlayer()
      if not player or player:GetPlayerType() ~= WrathGuy then
        return
      end
      if pickup:IsShopItem() or pickup:GetData().BombHeartTaken then
        return
      end
      local missing = player:GetMaxHearts() - player:GetHearts()
      if missing <= 0 then
        return --bomb hearts full, vanilla bomb pickup
      end
      if pickup.SubType == BombSubType.BOMB_NORMAL then
        player:AddHearts(B30_WrathStats.HEAL_NORMAL)
      elseif pickup.SubType == BombSubType.BOMB_DOUBLEPACK then
        player:AddHearts(B30_WrathStats.HEAL_DOUBLEPACK)
        if missing == 2 then
          player:AddBombs(1) --second bomb of the pack spills into ammo
        end
      else
        return --golden/giga stay vanilla
      end
      pickup:GetData().BombHeartTaken = true
      sfxManager:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1) --pickup sound TBD
      pickup:GetSprite():Play("Collect", true)
      pickup:Die()
      return false
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, B30_Wrath.BombTouch, PickupVariant.PICKUP_BOMB)

    --hearts never get collected, he just shoves them around the room
    function B30_Wrath:HeartBlock(pickup, collider, low)
      local player = collider:ToPlayer()
      if not player or player:GetPlayerType() ~= WrathGuy then
        return
      end
      return false
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, B30_Wrath.HeartBlock, PickupVariant.PICKUP_HEART)

    --every hit costs exactly one full bomb heart, they never break in half
    function B30_Wrath:TakeDmg(entity, amount, flags, source, countdown)
      local player = entity:ToPlayer()
      if not player or player:GetPlayerType() ~= WrathGuy then
        return
      end
      if flags & DamageFlag.DAMAGE_FAKE ~= 0 then
        return
      end
      if amount > 0 and amount ~= 2 then
        return {Damage = 2} --REPENTOGON: overrides the damage amount
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
      burstIndex = math.floor(player:GetHearts() / 2) --the container that just emptied
      burstActive = true
      burstSprite:Play("Break", true)
      --EFFECT TBD: broken bomb heart effect goes here
      sfxManager:Play(SoundEffect.SOUND_BOSS1_EXPLOSIONS, 1, 0, false, 1) --sound TBD
    end
    mod:AddCallback(ModCallbacks.MC_POST_ENTITY_TAKE_DMG, B30_Wrath.HeartBreak, EntityType.ENTITY_PLAYER)

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

    --swaps the hud heart spritesheet for the bomb heart sheet
    function B30_Wrath:HudHearts(offset, heartsSprite, position, unknown, player)
      heartsPos = position --remember where the hearts render for the burst
      local wantBomb = player ~= nil and player:GetPlayerType() == WrathGuy
      if wantBomb ~= hudIsBomb then
        if wantBomb then
          heartsSprite:Load("gfx/ui/ui_hearts.anm2", true)
          heartsSprite:ReplaceSpritesheet(0, "gfx/ui/ui_bombhearts.png")
          heartsSprite:LoadGraphics()
        else
          heartsSprite:Load("gfx/ui/ui_hearts.anm2", true)
          heartsSprite:ReplaceSpritesheet(0, "gfx/ui/ui_hearts.png")
          heartsSprite:LoadGraphics()
        end
        hudIsBomb = wantBomb
      end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PLAYERHUD_RENDER_HEARTS, B30_Wrath.HudHearts)

    --advances the burst at game speed so it pauses with the game
   --[[ function B30_Wrath:BurstUpdate()
      if burstActive then
        burstSprite:Update()
        if burstSprite:IsFinished("Break") then
          burstActive = false
        end
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B30_Wrath.BurstUpdate)

    --draws the burst over the hud on the heart that broke
    function B30_Wrath:BurstRender()
      if not burstActive then
        return
      end
      local row = math.floor(burstIndex / B30_WrathStats.HEARTS_PER_ROW)
      local col = burstIndex % B30_WrathStats.HEARTS_PER_ROW
      local pos = heartsPos + B30_WrathStats.BURST_OFFSET
        + Vector(col * B30_WrathStats.HEART_SPACING_X, row * B30_WrathStats.HEART_SPACING_Y)
      burstSprite:Render(pos)
    end
    mod:AddCallback(ModCallbacks.MC_POST_RENDER, B30_Wrath.BurstRender)]]
end

return B30_Wrath