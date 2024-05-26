local Stick_Of_Deodorant = {}
local game = Game()

mod.COLLECTIBLE_STICK_OF_DEODORANT = Isaac.GetTrinketIdByName("Stick Of Deodorant")
TrinketType.COLLECTIBLE_STICK_OF_DEODORANT = Isaac.GetTrinketIdByName("Stick Of Deodorant")
function Stick_Of_Deodorant:postUpdate()
end
return Stick_Of_Deodorant
--[[ function Stick_Of_Deodorant:OnNewRoom()
        local stank = {
        chance = .9,
        length = 5,
        interval = 20 }
        local player = Isaac.GetPlayer(0)

        if player:HasTrinket(TrinketType.COLLECTIBLE_ACTIVE_CARBOS) then
            local rng = player:GetTrinketRNG(TrinketType.COLLECTIBLE_STICK_OF_DEODORANT)
            local entities = Isaac.GetRoomEntities()

            for _, entity in ipairs(entities) do
                if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() then
                    if rng:RandomFloat() < stank.chance then
                        entity:AddCharmed(EntityRef(player), stank.length)
                    end
                end
            end 
        end 
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Stick_Of_Deodorant.OnNewRoom)                                              Issue has something to do with callbacks i think idk whats up.  
    ]]