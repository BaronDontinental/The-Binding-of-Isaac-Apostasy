local Disability_Papers = {}
local game = Game()
local bedTime = true
mod.COLLECTIBLE_DISABILITY_PAPERS = Isaac.GetItemIdByName("Disability Papers")
CollectibleType.COLLECTIBLE_DISABILITY_PAPERS = Isaac.GetItemIdByName("Disability Papers")

function Disability_Papers:postUpdate() 
    function Disability_Papers:onUpdate()
    local playerCount = game:GetNumPlayers()
    local entities = Isaac.GetRoomEntities()
        for playerIndex = 0, playerCount - 1 do
            local player = Isaac.GetPlayer(playerIndex)
            if player:HasCollectible(CollectibleType.COLLECTIBLE_DISABILITY_PAPERS) then
                Isaac.Spawn(
                    EntityType.ENTITY_PICKUP,
                    PickupVariant.PICKUP_BED,
                    BedSubType.BED_ISAAC,
                    Vector (140, 180),
                    Vector (0,0),
                    nil)
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Disability_Papers.onUpdate)
end

return Disability_Papers