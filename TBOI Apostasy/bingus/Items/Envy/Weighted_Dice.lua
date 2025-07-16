local Weighted_Dice = {}
local game = Game()

mod.COLLECTIBLE_WEIGHTED_DICE = Isaac.GetItemIdByName("Weighted Dice")
CollectibleType.COLLECTIBLE_WEIGHTED_DICE = Isaac.GetItemIdByName("Weighted Dice")

local itemPool = game:GetItemPool()
local itemConfig = Isaac.GetItemConfig()

function Weighted_Dice:postUpdate()

    local function GetRoomItemPool()
        local roomDesc = game:GetLevel():GetCurrentRoomDesc()
        local roomType = roomDesc.Data.Type
            return itemPool:GetPoolForRoom(roomType, 0)
    end

    function Weighted_Dice:GetItemsByQualityAndPool(targetQuality, poolType)
        local candidates = {}

        for id = 1, CollectibleType.NUM_COLLECTIBLES - 1 do
            local config = itemConfig:GetCollectible(id)
            if config and config.Quality == targetQuality and not config.Hidden then
                local testPool = GetRoomItemPool()
                if testPool == poolType then
                    table.insert(candidates, id)
                end
            end
        end

        return candidates
    end

    function Weighted_Dice:UseWeightedDice(_, rng, player, flags, slot)
        local currentPool = GetRoomItemPool()
        local pedestals = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)

        for _, entity in ipairs(pedestals) do
            local pickup = entity:ToPickup()
            local currentID = pickup.SubType
            local config = itemConfig:GetCollectible(currentID)

            if config and config.Type ~= ItemType.ITEM_QUEST then
                local currentQuality = config.Quality or 0
                local newQuality = (currentQuality - 1) % 5  

                local candidates = Weighted_Dice:GetItemsByQualityAndPool(newQuality, currentPool)

                if #candidates > 0 then
                    local newID = candidates[rng:RandomInt(#candidates) + 1]
                    pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, newID, true)
                end
            end
        end

        return true
    end

    mod:AddCallback(ModCallbacks.MC_USE_ITEM, Weighted_Dice.UseWeightedDice, CollectibleType.COLLECTIBLE_WEIGHTED_DICE)


end

return Weighted_Dice