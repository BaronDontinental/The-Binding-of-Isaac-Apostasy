local L22_Gluttony = {}
local game = Game()
local sfx = SFXManager()
local sprite3 = Sprite()
sprite3:Load("gfx/characters/character_l22_gluttonywalk.anm2", true)
local sprite2 = Sprite()
sprite2:Load("gfx/characters/character_l22_gluttonyshot.anm2", true)
local sprite = Sprite()
sprite:Load("gfx/characters/character_l22_gluttonyfiring.anm2", true)
local hud = game:GetHUD()

local GluttonyBod = Isaac.GetCostumeIdByPath("gfx/characters/character_l22_gluttony.anm2")
local GluttonyType = Isaac.GetPlayerTypeByName("L22_Gluttony", false)
local shootAnim
local walkAnim
local charge

local L22_GluttonyStats = {
  DAMAGE = 0,
  SPEED = -0.15,
  SHOTSPEED = 0,
  MAXFIREDELAY = 0,
  TEARHEIGHT = 0,
  TEARFALLINGSPEED = 0,
  TEARSOFFSETD = Vector(1, 11),
  TEARSOFFSETU = Vector(1, 15),
  TEARSOFFSETL = Vector(17, 15),
  TEARSOFFSETR = Vector(-17, 15),
  TEARFLAG = TearFlags,
  Flying = false,
  LUCK = 0,
  TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0),
  LaserType = { LASER_BRIMSTONE = 1}
}

function L22_Gluttony:postUpdate()
  function L22_Gluttony:OnCache(player, cacheFlag)
    if (player:GetName() == "L22_Gluttony") then
      if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
        player.Damage = player.Damage + L22_GluttonyStats.DAMAGE
      end
      if (cacheFlag == CacheFlag.CACHE_SPEED) then
        player.MoveSpeed = player.MoveSpeed + L22_GluttonyStats.SPEED
      end
      if (cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
        player.ShotSpeed = player.ShotSpeed + L22_GluttonyStats.SHOTSPEED
      end
      if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
        player.MaxFireDelay = player.MaxFireDelay + L22_GluttonyStats.MAXFIREDELAY
      end
      if (cacheFlag == CacheFlag.CACHE_RANGE) then
        player.TearHeight = player.TearHeight - L22_GluttonyStats.TEARHEIGHT
        player.TearFallingSpeed = player.TearFallingSpeed + L22_GluttonyStats.TEARFALLINGSPEED
      end
      if (cacheFlag == CacheFlag.CACHE_LUCK) then
        player.Luck = player.Luck + L22_GluttonyStats.LUCK
      end
      --[[if (cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
        player.TearColor = L22_GluttonyStats.TEARCOLOR
      end
      if (cacheFlag == CacheFlag.CACHE_TEARFLAG) then
        player.TearFlags = player.TearFlags | L22_GluttonyStats.TEARFLAG
      end ]]
      if (cacheFlag == CacheFlag.CACHE_WEAPON) then
        player.EnableWeaponType(player, WeaponType.WEAPON_BRIMSTONE, true)
        player.EnableWeaponType(player, WeaponType.WEAPON_TEARS, false)
      end
      if (cacheFlag == CacheFlag.CACHE_FLYING) then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) and game:GetLevel():GetStage() == LevelStage.STAGE8 then
          player.CanFly = true
        else 
          player.CanFly = false
        end
      end
    end
  end

  mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L22_Gluttony.OnCache)

  function L22_Gluttony:Costume(player)
    if player:GetPlayerType() ~= GluttonyType then
      return
    end
      player:AddNullCostume(GluttonyBod)
     
  end 
    
  mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, L22_Gluttony.Costume)

  function L22_Gluttony:OnUpdate()
    local player = Isaac.GetPlayer(0)
    if player:GetPlayerType() ~= GluttonyType then
      return
    end
    if (game:GetFrameCount() == 1 and player:GetName() == "L22_Gluttony") then
    end
  end
  mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L22_Gluttony.OnUpdate)


  function L22_Gluttony:PeUpdate(player)
    if player:GetPlayerType() ~= GluttonyType then
      return
    end
    player:EvaluateItems()
    player:AddCacheFlags(CacheFlag.CACHE_FLYING)

    local weapon = player:GetWeapon(1)
    charge = weapon:GetCharge()


    if player:GetFireDirection() == Direction.RIGHT then
      player.TearsOffset = L22_GluttonyStats.TEARSOFFSETR
      if Input.IsButtonPressed(Keyboard.KEY_W, 0) or Input.IsButtonPressed(Keyboard.KEY_A, 0) 
      or Input.IsButtonPressed(Keyboard.KEY_S, 0) or Input.IsButtonPressed(Keyboard.KEY_D, 0) then
        shootAnim = "ChargeWalkRight"
      else
        shootAnim = "ChargeRight"
      end
    end
      if player:GetFireDirection() == Direction.LEFT then
        player.TearsOffset = L22_GluttonyStats.TEARSOFFSETL
        if Input.IsButtonPressed(Keyboard.KEY_W, 0) or Input.IsButtonPressed(Keyboard.KEY_A, 0) 
        or Input.IsButtonPressed(Keyboard.KEY_S, 0) or Input.IsButtonPressed(Keyboard.KEY_D, 0) then
          shootAnim = "ChargeWalkLeft"
        else
          shootAnim = "ChargeLeft"
        end
      end
        if player:GetFireDirection() == Direction.DOWN then
          player.TearsOffset = L22_GluttonyStats.TEARSOFFSETD
          if Input.IsButtonPressed(Keyboard.KEY_W, 0) or Input.IsButtonPressed(Keyboard.KEY_A, 0) 
          or Input.IsButtonPressed(Keyboard.KEY_S, 0) or Input.IsButtonPressed(Keyboard.KEY_D, 0) then
            shootAnim = "ChargeWalkDown"
          else
            shootAnim = "ChargeDown"
          end
        end
          if player:GetFireDirection() == Direction.UP then
            player.TearsOffset = L22_GluttonyStats.TEARSOFFSETU
            if Input.IsButtonPressed(Keyboard.KEY_W, 0) or Input.IsButtonPressed(Keyboard.KEY_A, 0) 
            or Input.IsButtonPressed(Keyboard.KEY_S, 0) or Input.IsButtonPressed(Keyboard.KEY_D, 0) then
              shootAnim = "ChargeWalkUp"
            else
              shootAnim = "ChargeUp"
            end
          end

    if player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) and game:GetLevel():GetStage() == LevelStage.STAGE8 then 
      player.CanFly = true
      else
        if player.CanFly == true then
          player.CanFly = false
        end
    end

    if Input.IsButtonPressed(Keyboard.KEY_W, 0) or Input.IsButtonPressed(Keyboard.KEY_A, 0) 
      or Input.IsButtonPressed(Keyboard.KEY_S, 0) or Input.IsButtonPressed(Keyboard.KEY_D, 0) then
          player:SetCanShoot(false)
    else
        player:SetCanShoot(true)
    end

    if charge == 0 then
      if player:GetMovementDirection() == Direction.NO_DIRECTION then
        walkAnim = "Idle"
      elseif player:GetMovementDirection() == Direction.RIGHT then
        walkAnim = "WalkRight"
      elseif player:GetMovementDirection() == Direction.LEFT then
        walkAnim = "WalkLeft"
      elseif player:GetMovementDirection() == Direction.UP then
        walkAnim = "WalkUp"
      elseif player:GetMovementDirection() == Direction.DOWN then
        walkAnim = "WalkDown"
      end
      if walkAnim == "Idle" and not sprite3:IsPlaying("Idle") then
        sprite3:Play("Idle", false)
      end 
      if walkAnim == "WalkRight" and not sprite3:IsPlaying("WalkRight") then
        sprite3:Play("WalkRight", true)
      end
      if walkAnim == "WalkLeft" and not sprite3:IsPlaying("WalkLeft") then
        sprite3:Play("WalkLeft", true)
      end
      if walkAnim == "WalkUp" and not sprite3:IsPlaying("WalkUp") then
        sprite3:Play("WalkUp", true)
      end
      if walkAnim == "WalkDown" and not sprite3:IsPlaying("WalkDown") then
        sprite3:Play("WalkDown", true)
      end
    end


    if charge > 0 and charge < 32 then
      if shootAnim == "ChargeWalkRight" and not sprite:IsPlaying("ChargeWalkRight") then
        sprite:Play(shootAnim, true)
      end
      if shootAnim == "ChargeWalkLeft" and not sprite:IsPlaying("ChargeWalkLeft") then
        sprite:Play(shootAnim, true)
      end
      if shootAnim == "ChargeWalkDown" and not sprite:IsPlaying("ChargeWalkDown") then
        sprite:Play(shootAnim, true)
      end
      if shootAnim == "ChargeWalkUp" and not sprite:IsPlaying("ChargeWalkUp") then
        sprite:Play(shootAnim, true)
      end
      if shootAnim == "ChargeUp" and not sprite:IsPlaying("ChargeUp") then
        sprite:Play(shootAnim, true)
      end
      if shootAnim == "ChargeDown" and not sprite:IsPlaying("ChargeDown") then
        sprite:Play(shootAnim, true)
      end
      if shootAnim == "ChargeLeft" and not sprite:IsPlaying("ChargeLeft") then
        sprite:Play(shootAnim, true)
      end
      if shootAnim == "ChargeRight" and not sprite:IsPlaying("ChargeRight") then
        sprite:Play(shootAnim, true)
      end
    end
  end
  mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, L22_Gluttony.PeUpdate)
---@param laser EntityLaser
  function L22_Gluttony:fireBrim(laser)
    local player = Isaac.GetPlayer(0)
    if player:GetPlayerType() ~= GluttonyType then
      return
    end
    if player:GetHeadDirection() == Direction.RIGHT then
      if Input.IsButtonPressed(Keyboard.KEY_W, 0) or Input.IsButtonPressed(Keyboard.KEY_A, 0) 
      or Input.IsButtonPressed(Keyboard.KEY_S, 0) or Input.IsButtonPressed(Keyboard.KEY_D, 0) then
        sprite2:Play("FireWalkRight", true)
        sprite2:SetFrame(0)
      else
        sprite2:Play("FireRight", true)
        sprite2:SetFrame(0)
      end
    end
    if player:GetHeadDirection() == Direction.LEFT then
      if Input.IsButtonPressed(Keyboard.KEY_W, 0) or Input.IsButtonPressed(Keyboard.KEY_A, 0) 
      or Input.IsButtonPressed(Keyboard.KEY_S, 0) or Input.IsButtonPressed(Keyboard.KEY_D, 0) then
        sprite2:Play("FireWalkLeft", true)
        sprite2:SetFrame(0)
      else
        sprite2:Play("FireLeft", true)
        sprite2:SetFrame(0)
      end
    end
    if player:GetHeadDirection() == Direction.DOWN then
      if Input.IsButtonPressed(Keyboard.KEY_W, 0) or Input.IsButtonPressed(Keyboard.KEY_A, 0) 
      or Input.IsButtonPressed(Keyboard.KEY_S, 0) or Input.IsButtonPressed(Keyboard.KEY_D, 0) then
        sprite2:Play("FireWalkDown", true)
        sprite2:SetFrame(0)
      else
        sprite2:Play("FireDown", true)
        sprite2:SetFrame(0)
      end
    end
    if player:GetHeadDirection() == Direction.UP then
      if Input.IsButtonPressed(Keyboard.KEY_W, 0) or Input.IsButtonPressed(Keyboard.KEY_A, 0) 
      or Input.IsButtonPressed(Keyboard.KEY_S, 0) or Input.IsButtonPressed(Keyboard.KEY_D, 0) then
        sprite2:Play("FireWalkUp", true)
        sprite2:SetFrame(0)
      else
        sprite2:Play("FireUp", true)
        sprite2:SetFrame(0)
      end
    end
  end
  mod:AddCallback(ModCallbacks.MC_POST_FIRE_BRIMSTONE, L22_Gluttony.fireBrim)

  function L22_Gluttony:onRender(player, head)
    if sprite2:IsPlaying() then
      sprite2.PlaybackSpeed = .5   
      sprite2:Update()
      sprite2:Render(Isaac.WorldToScreen(player.Position))
      if sprite2:IsFinished() then
        sprite2:Stop()
      end
    end
    if charge > 0 and not sprite2:IsPlaying() then
      sprite.PlaybackSpeed = .5   
      sprite:Update()
      sprite:Render(Isaac.WorldToScreen(player.Position))
    end
    if charge == 0 and not sprite2:IsPlaying() then
      sprite3.PlaybackSpeed = .5   
      sprite3:Update()
      sprite3:Render(Isaac.WorldToScreen(player.Position))
    end
  end
  mod:AddCallback(ModCallbacks.MC_PRE_RENDER_PLAYER_HEAD, L22_Gluttony.onRender, GluttonyType)

end

return L22_Gluttony
