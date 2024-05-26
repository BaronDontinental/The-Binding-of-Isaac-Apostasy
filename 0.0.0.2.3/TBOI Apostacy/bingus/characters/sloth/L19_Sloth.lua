local L19_Sloth = {}

local Game = Game()

local L19_SlothStats = {
    DAMAGE = 6.5,
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

function L19_Sloth:postUpdate()
    function L19_Sloth:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "L19_Sloth") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage + L19_SlothStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + L19_SlothStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + L19_SlothStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + L19_SlothStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - L19_SlothStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + L19_SlothStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + L19_SlothStats.LUCK
            end
            if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = L19_SlothStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | L19_SlothStats.TEARFLAG
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L19_Sloth.OnCache)
    function L19_Sloth:OnUpdate()
        local player = Isaac.GetPlayer(0)

        if(Game:GetFrameCount() == 1 and player:GetName() == "L19_Sloth") then
            player:AddCard(math.random(1, 54))
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L19_Sloth.OnUpdate)
end

return L19_Sloth
