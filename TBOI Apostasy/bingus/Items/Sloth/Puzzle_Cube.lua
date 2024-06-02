local Puzzle_Cube = {}
local game = Game()

mod.COLLECTIBLE_PUZZLE_CUBE = Isaac.GetItemIdByName("Puzzle Cube")
CollectibleType.COLLECTIBLE_PUZZLE_CUBE = Isaac.GetItemIdByName("Puzzle Cube")

function Puzzle_Cube:postUpdate()
    --[[
    function Puzzle_Cube:clearRoom(player)
        local bitches = Room.GetAlliveEntitiesCount() + Room.GetAlliveBossesCount()
        if player:HasTrinket(TrinketType.COLLECTIBLE_PUZZLE_CUBE) then
           if bitches == 0 then
          print("ur gay")
           end
                        
        end
        print(bitches)
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Puzzle_Cube.clearRoom)   ]]
end

return Puzzle_Cube