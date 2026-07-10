local B29_Lust = {}
local Game = Game()
local level = Game:GetLevel()

local LustLump = Isaac.GetCostumeIdByPath("gfx/characters/character_b29_lust.anm2")
local LustGuy = Isaac.GetPlayerTypeByName("B29_Lust", true)
PickupVariant.PICKUP_EMPTYHEART = Isaac.GetEntityVariantByName("Empty Heart")
local sfxManager = SFXManager()

local B29_LustStats = {
    DAMAGE = -0.88,
    SPEED = 0.3,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0),
    STARTINGBROKENHEARTS = 11
}

local EmptyHeartColor = Color(0.75, 0.75, 0.75, 1, 0, 0, 0)

local EmptyHeart = {
  DevilBonus = 0,       
  AngelBonus = 0,      
  BonusPerHeart = 0.02, 
  Active = false,       
  
}

local function SpawnEmptyHeart(position)
  local room = Game:GetRoom()
  local pos = room:FindFreePickupSpawnPosition(position or room:GetRandomPosition(40), 0, true)
  Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_EMPTYHEART, 0, pos, Vector.Zero, nil):ToPickup()
end

local function RemoveEmptyHearts()
  for _, heart in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_EMPTYHEART, -1)) do
    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, heart.Position, Vector.Zero, nil):ToEffect()
    heart:Remove()
  end
end

local function AnotherBossRoomCleared()
  local rooms = Game:GetLevel():GetRooms()
  for i = 0, rooms.Size - 1 do
    local desc = rooms:Get(i)
    if desc and desc.Data and desc.Data.Type == RoomType.ROOM_BOSS and desc.Clear then
      return true
    end
  end
  return false
end

function B29_Lust:postUpdate()
    function B29_Lust:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "B29_Lust") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage + B29_LustStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + B29_LustStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + B29_LustStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + B29_LustStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - B29_LustStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + B29_LustStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + B29_LustStats.LUCK
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B29_Lust.OnCache)

    --[[function B29_Lust:Costume(player)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      if LustLump ~= -1 then
        player:AddNullCostume(LustLump)
      end
    end

    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, B29_Lust.Costume)]]

    function B29_Lust:OnUpdate()
        local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() ~= LustGuy then
          return
        end
        if(Game:GetFrameCount() == 1 and player:GetName() == "B29_Lust") then
            if player:GetBrokenHearts() == 0 then
              player:AddBrokenHearts(B29_LustStats.STARTINGBROKENHEARTS)
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B29_Lust.OnUpdate)

    function B29_Lust:NewLevel()
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      if EmptyHeart.AngelBonus > 0 then
        Game:GetLevel():AddAngelRoomChance(-EmptyHeart.AngelBonus)
      end
      EmptyHeart.DevilBonus = 0
      EmptyHeart.AngelBonus = 0
      EmptyHeart.Active = false
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, B29_Lust.NewLevel)

    function B29_Lust:NewRoom()
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      EmptyHeart.Active = false
      local level = Game:GetLevel()
      local room = Game:GetRoom()
      if room:GetType() ~= RoomType.ROOM_BOSS or room:IsClear() then
        return
      end
      if level:GetStage() == LevelStage.STAGE1_1 then
        local isXL = level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH ~= 0
        if not isXL or not AnotherBossRoomCleared() then
          return
        end
      end
      EmptyHeart.Active = true
      SpawnEmptyHeart()
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, B29_Lust.NewRoom)

    function B29_Lust:EmptyHeartInit(pickup)
      pickup.Color = EmptyHeartColor
    end
    mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, B29_Lust.EmptyHeartInit, PickupVariant.PICKUP_EMPTYHEART)

    function B29_Lust:EmptyHeartTouch(pickup, collider, low)
      local player = collider:ToPlayer()
      if not player or player:GetPlayerType() ~= LustGuy then
        return true
      end
      local devilChance = Game:GetRoom():GetDevilRoomChance()
      local angelChance = Game:GetLevel():GetAngelRoomChance()
      if angelChance > devilChance then
        EmptyHeart.AngelBonus = EmptyHeart.AngelBonus + EmptyHeart.BonusPerHeart
        Game:GetLevel():AddAngelRoomChance(EmptyHeart.BonusPerHeart)
      else
        EmptyHeart.DevilBonus = EmptyHeart.DevilBonus + EmptyHeart.BonusPerHeart
      end
      sfxManager:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1, 0)
      pickup:Remove()
      if EmptyHeart.Active then
        SpawnEmptyHeart()
      end
      return true
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, B29_Lust.EmptyHeartTouch, PickupVariant.PICKUP_EMPTYHEART)

    function B29_Lust:HeartBlock(pickup, collider, low)
      local player = collider:ToPlayer()
      if not player or player:GetPlayerType() ~= LustGuy then
        return
      end
      if pickup.SubType == HeartSubType.HEART_SOUL
      or pickup.SubType == HeartSubType.HEART_HALF_SOUL
      or pickup.SubType == HeartSubType.HEART_BLACK then
        return false
      end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, B29_Lust.HeartBlock, PickupVariant.PICKUP_HEART)

    function B29_Lust:OnHit(entity, amount, flags, source, countdown)
      local player = entity:ToPlayer()
      if not player or player:GetPlayerType() ~= LustGuy then
        return
      end
      if EmptyHeart.Active then
        EmptyHeart.Active = false
        RemoveEmptyHearts()
      end
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, B29_Lust.OnHit, EntityType.ENTITY_PLAYER)

      function B29_Lust:PeUpdate(player)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      if player:GetSoulHearts() > 0 then
        player:AddSoulHearts(-player:GetSoulHearts())
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B29_Lust.PeUpdate)

    function B29_Lust:BossClear(rng, spawnpos)
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      if Game:GetRoom():GetType() ~= RoomType.ROOM_BOSS then
        return
      end
      EmptyHeart.Active = false
      RemoveEmptyHearts()
      if player:GetBrokenHearts() > 0 then
        player:AddBrokenHearts(-1)
      end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, B29_Lust.BossClear)

    function B29_Lust:DevilCalc(chance)
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      if EmptyHeart.DevilBonus > 0 then
        return chance + EmptyHeart.DevilBonus
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_DEVIL_CALCULATE, B29_Lust.DevilCalc)

end

return B29_Lust