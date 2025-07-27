local Upchuck = {}
local game = Game()

mod.COLLECTIBLE_UPCHUCK = Isaac.GetItemIdByName("Upchuck")
CollectibleType.COLLECTIBLE_UPCHUCK = Isaac.GetItemIdByName("Upchuck")

function Upchuck:postUpdate()
    local UpFlags = {
        MIN_TIME = 300,
        Up_CHANCE = 5,
        SCALE_1 = 0.4,
        SCALE_2 = 0.4,
        FLY_1 = 20,
        FLY_2 = 1.5,
        SPEED_1 = 5,
        AMT_TEAR = 14,
        TEARFLAG = TearFlags.TEAR_EXPLOSIVE,
        Up_VARIANT = TearVariant.BLOOD,
        IsUpchuck = nil
    }

    ---@param player EntityPlayer
    function Upchuck:onUpdate(player)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_UPCHUCK) then
            if UpFlags.IsUpchuck ~= nil and game:GetLevel():GetCurrentRoomIndex() ~= UpFlags.Room then
                UpFlags.IsUpchuck =  false
                UpFlags.Room = nil
                player:EvaluateItems()
                player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
                player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
                player:AddCacheFlags(CacheFlag.CACHE_RANGE)
            end


            if UpFlags.IsUpchuck == true then
                player:EvaluateItems()
                player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
                player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
                player:AddCacheFlags(CacheFlag.CACHE_RANGE)
                for _, entity in pairs(Isaac.GetRoomEntities()) do
                    if entity.Type == EntityType.ENTITY_TEAR then
                        local TearData = entity:GetData()
                        local Tear = entity:ToTear()
                        if TearData.UpType == nil then
                            local roll = 1
                            if roll <= UpFlags.Up_CHANCE then
                                TearData.UpType = math.random(1)
                                if TearData.UpType == 1 then                          
                                    Tear:SetColor(Color(0.0, 1.0, 0.0, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear.TearFlags = Tear.TearFlags | UpFlags.TEARFLAG
                                    TearData.RotSize = 50
                                    Tear:SetSize(Tear.Size * (UpFlags.SCALE_1 + UpFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear.SpriteScale = Tear.SpriteScale * (UpFlags.SCALE_1 + UpFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear.Height = Tear.Height * (UpFlags.SCALE_1 + UpFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear.FallingSpeed = player.TearFallingSpeed - (UpFlags.FLY_1)
                                    Tear.FallingAcceleration = player.TearFallingAcceleration + (UpFlags.FLY_2)
                                end
                            else
                                TearData.UpType = 0
                            end
                        end
                    end
                end
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Upchuck.onUpdate)

---@param player EntityPlayer
---@param cacheFlags CacheFlag
function Upchuck:EvaluateCache(player, cacheFlags)
    local player = Isaac.GetPlayer(0)
    if UpFlags.IsUpchuck == true then
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                player.Damage = player.Damage + 40
        end
        if cacheFlags & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay * 3
        end
    end
    if UpFlags.IsUpchuck == false then
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage 
        end
        if cacheFlags & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay 
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Upchuck.EvaluateCache)


    ---@param item CollectibleType
    ---@param rng RNG
    ---@param player EntityPlayer
    ---@param flags UseFlags
    ---@param slot ActiveSlot
    ---@param varData integer
    function Upchuck:OnUse(item, rng, player, flags, slot, varData)
        local player = Isaac.GetPlayer(0)
        UpFlags.Room = game:GetLevel():GetCurrentRoomIndex()
        UpFlags.IsUpchuck = true
    --[[for _, entity in pairs(Isaac.GetRoomEntities()) do
            if entity.Type == EntityType.ENTITY_TEAR then
                local TearData = entity:GetData()
                local Tear = entity:ToTear()                            
                        Tear:SetColor(Color(0.0, 1.0, 0.0, 1.0, 0, 0, 0), 100, 100, false, false)
                        Tear.TearFlags = Tear.TearFlags | UpFlags.TEARFLAG
                        TearData.RotSize = math.random(100)
                        Tear:SetSize(Tear.Size * (UpFlags.SCALE_1 + UpFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                        Tear.SpriteScale = Tear.SpriteScale * (UpFlags.SCALE_1 + UpFlags.SCALE_2 * (TearData.RotSize / 100))
                        Tear.Height = Tear.Height * (UpFlags.SCALE_1 + UpFlags.SCALE_2 * (TearData.RotSize / 100))
                        Tear.FallingSpeed = player.TearFallingSpeed - (UpFlags.FLY_1)
                        Tear.FallingAcceleration = player.TearFallingAcceleration + (UpFlags.FLY_2 + math.random(1, 10) / 10)
                        Tear:ChangeVariant(UpFlags.Up_VARIANT)
            end
        end ]]
    end
    
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Upchuck.OnUse, mod.COLLECTIBLE_UPCHUCK)



end

return Upchuck