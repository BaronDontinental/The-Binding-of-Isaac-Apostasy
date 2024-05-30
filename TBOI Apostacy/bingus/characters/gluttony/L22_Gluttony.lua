local L22_Gluttony = {}
local Game = Game()
local sfx = SFXManager()

local GluttonyBod = Isaac.GetCostumeIdByPath("gfx/characters/character_l22_gluttony.anm2")
local GluttonyType = Isaac.GetPlayerTypeByName("L22_Gluttony", false)

local L22_GluttonyStats = {
  DAMAGE = 1,
  SPEED = -0,
  SHOTSPEED = 0,
  MAXFIREDELAY = 0,
  TEARHEIGHT = 0,
  TEARFALLINGSPEED = 0,
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
      if (cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
        player.TearColor = L22_GluttonyStats.TEARCOLOR
      end
      --[[if (cacheFlag == CacheFlag.CACHE_TEARFLAG) then
        player.TearFlags = player.TearFlags | L22_GluttonyStats.TEARFLAG
      end ]]
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

    if (Game:GetFrameCount() == 1 and player:GetName() == "L22_Gluttony") then
      player:AddCard(math.random(1, 54))
      
    end
  end

  mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L22_Gluttony.OnUpdate)

end

return L22_Gluttony
