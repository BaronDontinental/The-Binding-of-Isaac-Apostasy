local L20_Pride = {}
local Game = Game()

local L20_PrideStats = {
    DAMAGE = 1.05,
    SPEED = 0.1,
    SHOTSPEED = 0.1,
    MAXFIREDELAY = -0.1,
    TEARHEIGHT = 0.5,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 1,
    TEARCOLOR = Color(0.9, 0, 0, 1, 0.1, 0, 0)
}

function L20_Pride:postUpdate()
    function L20_Pride:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "L20_Pride") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage * L20_PrideStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + L20_PrideStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + L20_PrideStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + L20_PrideStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - L20_PrideStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + L20_PrideStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + L20_PrideStats.LUCK
            end
            if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = L20_PrideStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | L20_PrideStats.TEARFLAG
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L20_Pride.OnCache)
    function L20_Pride:OnUpdate()
        local player = Isaac.GetPlayer(0)
        local Reeee = Isaac.GetItemIdByName("Reeee!")

        if(Game:GetFrameCount() == 1 and player:GetName() == "L20_Pride") then
            player:AddCard(math.random(1, 54))
            player:AddCollectible(Reeee)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L20_Pride.OnUpdate)
end

return L20_Pride
