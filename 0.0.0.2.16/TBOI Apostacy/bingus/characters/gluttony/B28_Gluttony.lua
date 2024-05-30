local B28_Gluttony = {}
local Game = Game()

mod.COSTUME_GLUTTONY_BODY = Isaac.GetCostumeIdByPath("gfx/character_B28_Gluttony.anm2")

local B28_GluttonyStats = {
  DAMAGE = 1,
  SPEED = -0,
  SHOTSPEED = 0,
  MAXFIREDELAY = 0,
  TEARHEIGHT = 0,
  TEARFALLINGSPEED = 0,
  TEARFLAG = TearFlags,
  Flying = false,
  LUCK = 0,
  TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0)
}

function B28_Gluttony:postUpdate()
  function B28_Gluttony:OnCache(player, cacheFlag)
    local player = Isaac.GetPlayer(0)

    if (player:GetName() == "B28_Gluttony") then
      if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
        player.Damage = player.Damage + B28_GluttonyStats.DAMAGE
      end
      if (cacheFlag == CacheFlag.CACHE_SPEED) then
        player.MoveSpeed = player.MoveSpeed + B28_GluttonyStats.SPEED
      end
      if (cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
        player.ShotSpeed = player.ShotSpeed + B28_GluttonyStats.SHOTSPEED
      end
      if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
        player.MaxFireDelay = player.MaxFireDelay + B28_GluttonyStats.MAXFIREDELAY
      end
      if (cacheFlag == CacheFlag.CACHE_RANGE) then
        player.TearHeight = player.TearHeight - B28_GluttonyStats.TEARHEIGHT
        player.TearFallingSpeed = player.TearFallingSpeed + B28_GluttonyStats.TEARFALLINGSPEED
      end
      if (cacheFlag == CacheFlag.CACHE_LUCK) then
        player.Luck = player.Luck + B28_GluttonyStats.LUCK
      end
      if (cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
        player.TearColor = B28_GluttonyStats.TEARCOLOR
      end
      if (cacheFlag == CacheFlag.CACHE_TEARFLAG) then
        player.TearFlags = player.TearFlags | B28_GluttonyStats.TEARFLAG
      end
      player:AddNullCostume(mod.COSTUME_GLUTTONY_BODY)
    end
  end

  mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B28_Gluttony.OnCache)
  function B28_Gluttony:OnUpdate()
    local player = Isaac.GetPlayer(0)

    if (Game:GetFrameCount() == 1 and player:GetName() == "B28_Gluttony") then
      player:AddCard(math.random(1, 54))
    end
  end

  mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B28_Gluttony.OnUpdate)
end

return B28_Gluttony
