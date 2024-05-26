local Puzzle_Cube = {}
local game = Game()

mod.COLLECTIBLE_PUZZLE_CUBE = Isaac.GetTrinketIdByName("Puzzle Cube")
TrinketType.COLLECTIBLE_PUZZLE_CUBE = Isaac.GetTrinketIdByName("Puzzle Cube")

function Puzzle_Cube:postUpdate()
    function Puzzle_Cube:clearRoom(player)
        local bitches = Room.GetAlliveEntitiesCount() + Room.GetAlliveBossesCount()
        if player:HasTrinket(TrinketType.COLLECTIBLE_ACTIVE_CARBOS) then
           
                        
        end
        print(bitches)
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Puzzle_Cube.clearRoom) 
end 

return Puzzle_Cube