local Salt_Lamp = {}
local game = Game()
local damageUp = 1
mod.COLLECTIBLE_SALT_LAMP = Isaac.GetItemIdByName("Salt Lamp")
CollectibleType.COLLECTIBLE_SALT_LAMP = Isaac.GetItemIdByName("Salt Lamp")

function Salt_Lamp:postUpdate()
    function Salt_Lamp:Cache(player, cacheFlags)
    
        if player:HasCollectible(CollectibleType.COLLECTIBLE_SALT_LAMP) then
        if(cacheFlags == CacheFlag.CACHE_DAMAGE) then
            local copyCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SALT_LAMP)
                local damageToAdd = damageUp * copyCount
                player.Damage = player.Damage + damageToAdd
            end

        end
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Salt_Lamp.Cache)
--[[
local level = game:GetLevel()
            local curseforlevel = level:GetCurseName()
            if curseforlevel == LevelCurse.CURSE_OF_DARKNESS then
                level:RemoveCurses(LevelCurse.CURSE_OF_DARKNESS)
            
            end
]]
end

return Salt_Lamp