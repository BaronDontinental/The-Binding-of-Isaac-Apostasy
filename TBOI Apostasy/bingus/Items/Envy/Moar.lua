local Moar = {}
local game = Game()

mod.COLLECTIBLE_MOAR = Isaac.GetItemIdByName("Moar")
CollectibleType.COLLECTIBLE_MOAR = Isaac.GetItemIdByName("Moar")

function Moar:postUpdate()
    function Moar:onUpdate()
    local playerCount = game:GetNumPlayers()
    for playerIndex = 0, playerCount - 1 do
        local player = Isaac.GetPlayer(playerIndex)
        local copyCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOAR)
        if copyCount > 0 then
            local entities = Isaac.GetRoomEntities()
            if game:GetLevel():GetStage() ~= LevelStage.STAGE6 then
                for _, entity in ipairs(entities) do
                    local data = entity:GetData() 
                     MoarE = entity:ToNPC()
                    if MoarE and MoarE:IsBoss() then
                        if MoarE:IsDead() and not data.Died then
                            data.Died = true
                            Isaac.Spawn(
                                EntityType.ENTITY_PICKUP,
                                PickupVariant.PICKUP_CHEST,
                                ChestSubType.CHEST_CLOSED,
                                MoarE.Position,
                                MoarE.Velocity,
                                nil)
                        elseif MoarE.ParentNPC or
                            MoarE.Type == EntityType.ENTITY_BLASTOCYST_MEDIUM
                            or MoarE.Type == EntityType.ENTITY_BLASTOCYST_SMALL
                            or MoarE.Type == EntityType.ENTITY_FISTULA_MEDIUM
                            or MoarE.Type == EntityType.ENTITY_FISTULA_SMALL
                            or MoarE.Type == EntityType.ENTITY_ENVY then
                                data.Died = true
                        end
                    end
                end
            end
        end  
    end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Moar.onUpdate)
end

return Moar