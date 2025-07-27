local Brownie_Pool = {}
local game = Game()

    mod.COLLECTIBLE_SALT_LAMP = Isaac.GetItemIdByName("Salt Lamp")
    CollectibleType.COLLECTIBLE_SALT_LAMP = Isaac.GetItemIdByName("Salt Lamp")

    mod.COLLECTIBLE_THE_SHAKER = Isaac.GetItemIdByName("The Shaker")
    CollectibleType.COLLECTIBLE_THE_SHAKER = Isaac.GetItemIdByName("The Shaker")

function Brownie_Pool:postUpdate()
    local Brownie = {
        VARIANT = EntityType.ENTITY_BROWNIE,
        Current = nil
        }
    local CurrentRoom = nil
    local CurrentStage = nil

    function Brownie_Pool:SpinTheWheel(math)
        local Roll = math.random(100)   --[this is where its broken i think]
        if Roll < 50 then
            return CollectibleType.COLLECTIBLE_SALT_LAMP
        elseif Roll > 50 then
            return CollectibleType.COLLECTIBLE_THE_SHAKER
        end
    end

    ---@param player EntityPlayer
    function Brownie_Pool:onUpdate(player)
        local level = game:GetLevel()
        local copyCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOAR)

        if CurrentRoom ~= level:GetCurrentRoom() or CurrentStage ~= level:GetStage() then
            Brownie.Current = nil
        end
        CurrentRoom = level:GetCurrentRoomIndex()
        CurrentStage = level:GetStage()
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Brownie_Pool.onUpdate)

    function Brownie_Pool:PostRender()
        local level = game:GetLevel()

        local entities = Isaac.GetRoomEntities()
        for _, entity in ipairs(entities) do
            local data = entity:GetData() 
            BrownE = entity:ToNPC()
            if BrownE and BrownE:IsBoss() and BrownE.Type == EntityType.ENTITY_BROWNIE then
                Brownie.Current = true
            end
                if level:GetCurrentRoom():GetType() == RoomType.ROOM_BOSS and Brownie.Current ~= nil then
                for _, entity in pairs(Isaac.GetRoomEntities()) do
                    if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
                        Isaac.Spawn(EntityType.ENTITY_PICKUP,
                                    PickupVariant.PICKUP_COLLECTIBLE,
                                    Brownie_Pool.SpinTheWheel(math),   --[this is where its broken i think]
                                    entity.Position,
                                    entity.Velocity,
                                    nil
                                    )
                        Brownie.Current = nil
                        entity:Remove()
                        break
                    end
                end
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, Brownie_Pool.PostRender)
end
    
return Brownie_Pool