local Birthright_B30_Wrath = {}
local Game = Game()
local sfxManager = SFXManager()
local SaveManager = require("callbacks.save_manager")
local WrathGuy = Isaac.GetPlayerTypeByName("B30_Wrath", true)

local BurnedOutStats = {
  REVIVE_IFRAMES = 90,
  TINT = Color(0.45, 0.4, 0.4, 1, 0, 0, 0),
  BURN_DURATION = 90,
  BURN_DAMAGE = 6,
  BURN_COOLDOWN = 30,
  TRAIL_INTERVAL = 8,
  TRAIL_MIN_SPEED = 1,
  FUSE_HOLD = 60,
  BOMB_SCALE = 1
}

local burnedOut = false

local function isBurnedOutWrath(player)
  return player ~= nil and burnedOut and player:GetPlayerType() == WrathGuy
end

function Birthright_B30_Wrath:IsBurnedOut()
  return burnedOut
end

function Birthright_B30_Wrath:TryRevive(player)
  if burnedOut or not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
    return false
  end
  burnedOut = true
  SaveManager.Set("B30_WrathBurnedOut", burnedOut)
  local target = math.ceil(player:GetMaxHearts() / 4) * 2
  player:AddHearts(target - player:GetHearts())
  player:SetMinDamageCooldown(BurnedOutStats.REVIVE_IFRAMES)
  Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, 0, player.Position, Vector(0,0), player)
  sfxManager:Play(SoundEffect.SOUND_FIREDEATH_HISS, 1, 0, false, 1)
  return true
end

function Birthright_B30_Wrath:postUpdate()
    function Birthright_B30_Wrath:Tint(player)
      if not isBurnedOutWrath(player) then
        return
      end
      player:SetColor(BurnedOutStats.TINT, 2, 0, false, false)
    end
  mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Birthright_B30_Wrath.Tint)

    function Birthright_B30_Wrath:BombUpdate(bomb)
      local data = bomb:GetData()
      if data.BurnedOutChecked == nil then
        local player = bomb.SpawnerEntity and bomb.SpawnerEntity:ToPlayer()
        data.BurnedOutChecked = bomb.IsFetus and isBurnedOutWrath(player)
        if data.BurnedOutChecked then
          data.BurnedOutPlayer = player
          data.BurnedOutHits = {}
          bomb:AddTearFlags(TearFlags.TEAR_BURN)
        end
      end
      if not data.BurnedOutChecked then
        return
      end
      bomb:SetExplosionCountdown(BurnedOutStats.FUSE_HOLD)
      if bomb:GetScale() ~= BurnedOutStats.BOMB_SCALE then
        bomb:SetScale(BurnedOutStats.BOMB_SCALE)
      end
      if bomb.FrameCount % BurnedOutStats.TRAIL_INTERVAL == 0 and bomb.Velocity:Length() > BurnedOutStats.TRAIL_MIN_SPEED then
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HOT_BOMB_FIRE, 0, bomb.Position, Vector(0,0), data.BurnedOutPlayer)
      end
    end
  mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, Birthright_B30_Wrath.BombUpdate)

    function Birthright_B30_Wrath:BombTouch(bomb, collider, low)
      local data = bomb:GetData()
      if not data.BurnedOutChecked or not collider:IsVulnerableEnemy() then
        return
      end
      local hash = GetPtrHash(collider)
      local frame = Game:GetFrameCount()
      if data.BurnedOutHits[hash] and frame - data.BurnedOutHits[hash] < BurnedOutStats.BURN_COOLDOWN then
        return
      end
      data.BurnedOutHits[hash] = frame
      local source = data.BurnedOutPlayer and data.BurnedOutPlayer:Exists() and data.BurnedOutPlayer or bomb
      collider:AddBurn(EntityRef(source), BurnedOutStats.BURN_DURATION, BurnedOutStats.BURN_DAMAGE)
    end
  mod:AddCallback(ModCallbacks.MC_PRE_BOMB_COLLISION, Birthright_B30_Wrath.BombTouch)

    function Birthright_B30_Wrath:GameStarted(fromSave)
      if fromSave then
        burnedOut = SaveManager.Get("B30_WrathBurnedOut") == true
      else
        burnedOut = false
        SaveManager.Set("B30_WrathBurnedOut", burnedOut)
      end
    end
  mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Birthright_B30_Wrath.GameStarted)
end

return Birthright_B30_Wrath
