local Salt_Lamp = {}
local game = Game()
local damageUp = 1
mod.COLLECTIBLE_SALT_LAMP = Isaac.GetItemIdByName("Salt Lamp")
CollectibleType.COLLECTIBLE_SALT_LAMP = Isaac.GetItemIdByName("Salt Lamp")

function Salt_Lamp:postUpdate()
    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function Salt_Lamp:EvaluateCache(player, cacheFlags)
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            local copyCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SALT_LAMP)
            local damageToAdd = damageUp * copyCount
                player.Damage = player.Damage + damageToAdd
        end
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Salt_Lamp.EvaluateCache)

---@param player EntityPlayer
function Salt_Lamp:CurseR(player)
    local playerCount = game:GetNumPlayers()
    local entities = Isaac.GetRoomEntities()
    for playerIndex = 0, playerCount - 1 do
        local player = Isaac.GetPlayer(playerIndex)
        local level = game:GetLevel()
        local curseforlevel = level:GetCurseName()

        if player:HasCollectible(CollectibleType.COLLECTIBLE_SALT_LAMP) then
            game:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_DARKNESS)
            if curseforlevel == LevelCurse.CURSE_OF_DARKNESS then
                   game:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_DARKNESS)
            
            end
         end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Salt_Lamp.CurseR)

end

return Salt_Lamp