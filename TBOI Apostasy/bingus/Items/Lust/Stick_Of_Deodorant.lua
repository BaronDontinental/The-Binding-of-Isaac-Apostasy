local Stick_Of_Deodorant = {}
local game = Game()

mod.COLLECTIBLE_STICK_OF_DEODORANT = Isaac.GetTrinketIdByName("Stick of Deodorant")
TrinketType.COLLECTIBLE_STICK_OF_DEODORANT = Isaac.GetTrinketIdByName("Stick of Deodorant")

local stank = {
    chance = 100,
    length = 30,
    }
    

function Stick_Of_Deodorant:postUpdate()
    function Stick_Of_Deodorant:onUpdate(player)
        local Poggers = EntityRef(player)

        if player:HasTrinket(TrinketType.COLLECTIBLE_STICK_OF_DEODORANT) then
            local roll = math.random(100)
            for _, entity in ipairs(Isaac.GetRoomEntities()) do
                local charm = entity:GetData()
                if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() and not charm.try then
                    if stank.chance >= roll then
                        entity:AddCharmed(Poggers, stank.length)
                        charm.try = true
                        charm.yes = true
                    else
                        charm.try = true
                        charm.yes = false
                    end
                end
                print(charm.yes)
            end 
        end 
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Stick_Of_Deodorant.onUpdate)
end
return Stick_Of_Deodorant
    