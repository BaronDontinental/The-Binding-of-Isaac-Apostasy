local L23_Lust = {}
local Game = Game()

local LustLump = Isaac.GetCostumeIdByPath("gfx/characters/character_l23_lust.anm2")
local LustGuy = Isaac.GetPlayerTypeByName("L23_Lust", false)
local BoxOfChocolates = Isaac.GetItemIdByName("Box of Chocolates")

local L23_LustStats = {
    DAMAGE = 0,
    SPEED = 0,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0),
    STARTINGEMPTYHEARTS = 2
}

local L23_LustStatsDown = {
    DAMAGE = 0.5,
    SPEED = 0.1,
    SHOTSPEED = 0.1,
    MAXFIREDELAY = 0.5,
    RANGE = 20,
    LUCK = 0.5
}

local L23_LustStatsUp = {
    DAMAGE = 0.5,
    SPEED = 0.1,
    SHOTSPEED = 0.1,
    MAXFIREDELAY = 0.5,
    RANGE = 20,
    LUCK = 0.5
}

local function GetHeartOffset(player)
  local filled = player:GetHearts() / 2
  local half = player:GetMaxHearts() / 4
  return filled - half
end

local function GetHeartStat(player, stat)
  local offset = GetHeartOffset(player)
  if offset > 0 then
    return -offset * L23_LustStatsDown[stat]
  elseif offset < 0 then
    return -offset * L23_LustStatsUp[stat]
  end
  return 0
end

function L23_Lust:postUpdate()
    function L23_Lust:OnCache(player, cacheFlag)
        if player:GetPlayerType() ~= LustGuy then
          return
        end
        if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
          player.Damage = player.Damage + L23_LustStats.DAMAGE + GetHeartStat(player, "DAMAGE")
        end
        if(cacheFlag == CacheFlag.CACHE_SPEED) then
          player.MoveSpeed = player.MoveSpeed + L23_LustStats.SPEED + GetHeartStat(player, "SPEED")
        end
        if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
          player.ShotSpeed = player.ShotSpeed + L23_LustStats.SHOTSPEED + GetHeartStat(player, "SHOTSPEED")
        end
        if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
          player.MaxFireDelay = math.max(1, player.MaxFireDelay + L23_LustStats.MAXFIREDELAY - GetHeartStat(player, "MAXFIREDELAY"))
        end
        if(cacheFlag == CacheFlag.CACHE_RANGE) then
          player.TearHeight = player.TearHeight - L23_LustStats.TEARHEIGHT
          player.TearFallingSpeed = player.TearFallingSpeed + L23_LustStats.TEARFALLINGSPEED
          player.TearRange = player.TearRange + GetHeartStat(player, "RANGE")
        end
        if(cacheFlag == CacheFlag.CACHE_LUCK) then
          player.Luck = player.Luck + L23_LustStats.LUCK + GetHeartStat(player, "LUCK")
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L23_Lust.OnCache)

    function L23_Lust:OnUpdate()
        local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() ~= LustGuy then
          return
        end
        if(Game:GetFrameCount() == 1 and player:GetName() == "L23_Lust") then
            player:AddMaxHearts(L23_LustStats.STARTINGEMPTYHEARTS * 2, false)
            player:AddCollectible(BoxOfChocolates)
            Game:GetItemPool():RemoveCollectible(BoxOfChocolates)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L23_Lust.OnUpdate)

    --[[function L23_Lust:Costume(player)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
        player:AddNullCostume(LustLump)
    end

    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, L23_Lust.Costume)]]

    function L23_Lust:PeUpdate(player)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      if player:GetSoulHearts() > 0 then
        player:AddSoulHearts(-player:GetSoulHearts())
      end
      local data = player:GetData()
      local hearts = player:GetHearts()
      local maxHearts = player:GetMaxHearts()
      if data.L23Hearts ~= hearts or data.L23MaxHearts ~= maxHearts then
        data.L23Hearts = hearts
        data.L23MaxHearts = maxHearts
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_SPEED | CacheFlag.CACHE_SHOTSPEED
          | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_RANGE | CacheFlag.CACHE_LUCK)
        player:EvaluateItems()
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, L23_Lust.PeUpdate)

    function L23_Lust:HeartBlock(pickup, collider, low)
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
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, L23_Lust.HeartBlock, PickupVariant.PICKUP_HEART)
end

return L23_Lust
