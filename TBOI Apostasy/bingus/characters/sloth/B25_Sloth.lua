local B25_Sloth = {}
local Game = Game()

local B25_SlothStats = {
    DAMAGE = 2.857,
    SPEED = -0.2,
    SHOTSPEED = 0,
    MAXFIREDELAY = 10,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags.TEAR_EXPLOSIVE,
    Flying = false,
    LUCK = 1,
    TEARCOLOR = Color(0, 1.0, 0, 1.0, 0, 0, 0)
}

function B25_Sloth:postUpdate()
    function B25_Sloth:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "B25_Sloth") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage * B25_SlothStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + B25_SlothStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + B25_SlothStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + B25_SlothStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - B25_SlothStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + B25_SlothStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + B25_SlothStats.LUCK
            end
            if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = B25_SlothStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | B25_SlothStats.TEARFLAG
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B25_Sloth.OnCache)
    function B25_Sloth:OnUpdate()
        local player = Isaac.GetPlayer(0)

        if(Game:GetFrameCount() == 1 and player:GetName() == "B25_Sloth") then
            player:AddCard(math.random(1, 54))
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B25_Sloth.OnUpdate)
end

return B25_Sloth
