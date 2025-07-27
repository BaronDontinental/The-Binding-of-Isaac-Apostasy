local B26_Pride = {}
local Game = Game()

local B26_PrideStats = {
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

function B26_Pride:postUpdate()
    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function B26_Pride:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "B26_Pride") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage * B26_PrideStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + B26_PrideStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + B26_PrideStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + B26_PrideStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - B26_PrideStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + B26_PrideStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + B26_PrideStats.LUCK
            end
            if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = B26_PrideStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | B26_PrideStats.TEARFLAG
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B26_Pride.OnCache)
    function B26_Pride:OnUpdate()
        local player = Isaac.GetPlayer(0)
        local Reeee = Isaac.GetItemIdByName("Reeee!")

        if(Game:GetFrameCount() == 1 and player:GetName() == "B26_Pride") then
            player:AddCard(math.random(1, 54))
            player:AddCollectible(Reeee)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B26_Pride.OnUpdate)
end

return B26_Pride
