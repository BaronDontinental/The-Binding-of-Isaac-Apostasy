local B27_Envy = {}
local Game = Game()

local B27_EnvyStats = {
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

function B27_Envy:postUpdate()
    function B27_Envy:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "B27_Envy") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage + B27_EnvyStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + B27_EnvyStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + B27_EnvyStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + B27_EnvyStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - B27_EnvyStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + B27_EnvyStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + B27_EnvyStats.LUCK
            end
            if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = B27_EnvyStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | B27_EnvyStats.TEARFLAG
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B27_Envy.OnCache)
    function B27_Envy:OnUpdate()
        local player = Isaac.GetPlayer(0)

        if(Game:GetFrameCount() == 1 and player:GetName() == "B27_Envy") then
            player:AddCard(math.random(1, 54))
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B27_Envy.OnUpdate)
end

return B27_Envy
