local B28_Gluttony = {}
local game = Game()
local sfx = SFXManager()
local okSave, SaveManager = pcall(require, "callbacks.save_manager")
if not okSave or type(SaveManager) ~= "table" then
    SaveManager = {Get = function() return nil end, Set = function() end}
end

local GluttonyBBod = Isaac.GetCostumeIdByPath("gfx/character_B28_Gluttony.anm2")

mod.COLLECTIBLE_GORGE = Isaac.GetItemIdByName("Gorge")
CollectibleType.COLLECTIBLE_GORGE = Isaac.GetItemIdByName("Gorge")

local B28_GluttonyStats = {
  DAMAGE = -0.5,
  SPEED = -0.15,
  SHOTSPEED = -0.1,
  MAXFIREDELAY = 2,
  TEARRANGE = -40,
  LUCK = -1
}

local TRINKET_CHANCE = 50
local TRINKET_COUNT = 3

local GORGE_STATUPS = {
  {stat = "DAMAGE", amount = 0.75, flag = CacheFlag.CACHE_DAMAGE, text = "Damage up"},
  {stat = "TEARS", amount = 0.35, flag = CacheFlag.CACHE_FIREDELAY, text = "Tears up"},
  {stat = "RANGE", amount = 30, flag = CacheFlag.CACHE_RANGE, text = "Range up"},
  {stat = "SPEED", amount = 0.15, flag = CacheFlag.CACHE_SPEED, text = "Speed up"},
  {stat = "SHOTSPEED", amount = 0.15, flag = CacheFlag.CACHE_SHOTSPEED, text = "Shot speed up"},
  {stat = "LUCK", amount = 0.75, flag = CacheFlag.CACHE_LUCK, text = "Luck up"}
}

local gorgeMode = false
local gorgeBonus = {DAMAGE = 0, TEARS = 0, RANGE = 0, SPEED = 0, SHOTSPEED = 0, LUCK = 0}
local firingBack = false

function B28_Gluttony:postUpdate()

  local function saveState()
    SaveManager.Set("B28_Gluttony", {bonus = gorgeBonus, mode = gorgeMode})
  end

---@param player EntityPlayer
  function B28_Gluttony:PlayerInit(player)
    if player:GetName() ~= "B28_Gluttony" then
      return
    end
    gorgeMode = false
    for stat in pairs(gorgeBonus) do
      gorgeBonus[stat] = 0
    end
    if GluttonyBBod >= 0 then
      player:AddNullCostume(GluttonyBBod)
    end
    if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_GORGE then
      player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_GORGE, ActiveSlot.SLOT_POCKET, false)
    end
    player:AddCacheFlags(CacheFlag.CACHE_WEAPON)
    player:EvaluateItems()
  end
  mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, B28_Gluttony.PlayerInit)

---@param player EntityPlayer
  function B28_Gluttony:OnCache(player, cacheFlag)
    if player:GetName() ~= "B28_Gluttony" then
      return
    end
    if cacheFlag == CacheFlag.CACHE_DAMAGE then
      player.Damage = player.Damage + B28_GluttonyStats.DAMAGE + gorgeBonus.DAMAGE
    end
    if cacheFlag == CacheFlag.CACHE_SPEED then
      player.MoveSpeed = player.MoveSpeed + B28_GluttonyStats.SPEED + gorgeBonus.SPEED
    end
    if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
      player.ShotSpeed = player.ShotSpeed + B28_GluttonyStats.SHOTSPEED + gorgeBonus.SHOTSPEED
    end
    if cacheFlag == CacheFlag.CACHE_FIREDELAY then
      player.MaxFireDelay = player.MaxFireDelay + B28_GluttonyStats.MAXFIREDELAY
      local tears = 30 / (player.MaxFireDelay + 1) + gorgeBonus.TEARS
      player.MaxFireDelay = 30 / tears - 1
    end
    if cacheFlag == CacheFlag.CACHE_RANGE then
      player.TearRange = player.TearRange + B28_GluttonyStats.TEARRANGE + gorgeBonus.RANGE
    end
    if cacheFlag == CacheFlag.CACHE_LUCK then
      player.Luck = player.Luck + B28_GluttonyStats.LUCK + gorgeBonus.LUCK
    end
    if cacheFlag == CacheFlag.CACHE_WEAPON then
      player.EnableWeaponType(player, WeaponType.WEAPON_BRIMSTONE, true)
      player.EnableWeaponType(player, WeaponType.WEAPON_TEARS, false)
      player.EnableWeaponType(player, WeaponType.WEAPON_BOMBS, false)
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
    if cacheFlag == CacheFlag.CACHE_FLYING then
      if player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) and game:GetLevel():GetStage() == LevelStage.STAGE8 then
        player.CanFly = true
      else
        player.CanFly = false
      end
    end
  end
  mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B28_Gluttony.OnCache)

---@param player EntityPlayer
  function B28_Gluttony:PeUpdate(player)
    if player:GetName() ~= "B28_Gluttony" then
      return
    end

    if Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex) then
      gorgeMode = not gorgeMode
      sfx:Play(SoundEffect.SOUND_BEEP, 1, 0, false, 1)
      if gorgeMode then
        game:GetHUD():ShowItemText("Gorge", "Devour your trinket for power")
      else
        game:GetHUD():ShowItemText("Gulp", "Swallow your trinket whole")
      end
      saveState()
    end

    local queued = player.QueuedItem
    local pdata = player:GetData()
    if queued.Item ~= nil and queued.Item:IsCollectible() and not queued.Touched then
      if pdata.GorgeQueueId ~= queued.Item.ID then
        pdata.GorgeQueueId = queued.Item.ID
        pdata.GorgeQueueConvert = math.random(100) <= TRINKET_CHANCE
      end
    elseif pdata.GorgeQueueId ~= nil then
      local itemId = pdata.GorgeQueueId
      local convert = pdata.GorgeQueueConvert
      pdata.GorgeQueueId = nil
      pdata.GorgeQueueConvert = nil
      if convert and player:HasCollectible(itemId) then
        player:RemoveCollectible(itemId)
        game:GetItemPool():RemoveCollectible(itemId)
        local room = game:GetRoom()
        for i = 1, TRINKET_COUNT do
          local trinketId = game:GetItemPool():GetTrinket(false)
          local offset = Vector(40, 0):Rotated((i - 1) * 120)
          local pos = room:FindFreePickupSpawnPosition(player.Position + offset, 0, true)
          Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, trinketId, pos, Vector.Zero, nil)
        end
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector.Zero, nil)
        sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)
      end
    end

    if player:GetMovementInput():Length() > 0.001 then
      player:SetCanShoot(false)
    else
      player:SetCanShoot(true)
    end

    if player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) and game:GetLevel():GetStage() == LevelStage.STAGE8 then
      player.CanFly = true
    else
      if player.CanFly == true then
        player.CanFly = false
      end
    end
  end
  mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B28_Gluttony.PeUpdate)

---@param player EntityPlayer
  function B28_Gluttony:UseGorge(item, rng, player, useFlags, slot, varData)
    local trinket = player:GetTrinket(0)
    if trinket == 0 then
      trinket = player:GetTrinket(1)
    end
    if trinket == 0 then
      return false
    end
    if not gorgeMode then
      player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, UseFlag.USE_NOANIM)
      sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)
      return true
    end
    player:TryRemoveTrinket(trinket)
    local up = GORGE_STATUPS[math.random(#GORGE_STATUPS)]
    gorgeBonus[up.stat] = gorgeBonus[up.stat] + up.amount
    player:AddCacheFlags(up.flag)
    player:EvaluateItems()
    saveState()
    sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)
    game:GetHUD():ShowItemText("Gorge", up.text)
    return true
  end
  mod:AddCallback(ModCallbacks.MC_USE_ITEM, B28_Gluttony.UseGorge, CollectibleType.COLLECTIBLE_GORGE)

---@param laser EntityLaser
  function B28_Gluttony:FireBrim(laser)
    if firingBack then
      return
    end
    local player = (laser.SpawnerEntity and laser.SpawnerEntity:ToPlayer()) or Isaac.GetPlayer(0)
    if not player or player:GetName() ~= "B28_Gluttony" then
      return
    end
    firingBack = true
    player:FireBrimstone(Vector.FromAngle(laser.AngleDegrees + 180))
    firingBack = false
  end
  mod:AddCallback(ModCallbacks.MC_POST_FIRE_BRIMSTONE, B28_Gluttony.FireBrim)

  function B28_Gluttony:GameStarted(isContinued)
    if not isContinued then
      SaveManager.Set("B28_Gluttony", nil)
      return
    end
    local state = SaveManager.Get("B28_Gluttony")
    if type(state) ~= "table" then
      return
    end
    gorgeMode = state.mode == true
    if type(state.bonus) == "table" then
      for stat in pairs(gorgeBonus) do
        local value = tonumber(state.bonus[stat])
        if value then
          gorgeBonus[stat] = value
        end
      end
    end
    local player = Isaac.GetPlayer(0)
    if player:GetName() == "B28_Gluttony" then
      player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_RANGE | CacheFlag.CACHE_SPEED | CacheFlag.CACHE_SHOTSPEED | CacheFlag.CACHE_LUCK)
      player:EvaluateItems()
    end
  end
  mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, B28_Gluttony.GameStarted)

end

return B28_Gluttony