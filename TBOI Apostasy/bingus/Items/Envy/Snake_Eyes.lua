local Snake_Eyes = {}
local game = Game()

mod.COLLECTIBLE_SNAKE_EYES = Isaac.GetTrinketIdByName("Snake Eyes")
TrinketType.COLLECTIBLE_SNAKE_EYES = Isaac.GetTrinketIdByName("Snake Eyes")

local snake = {
    chance = 100
}

function Snake_Eyes:postUpdate()
--[[
    function Snake_Eyes:OnClear(rng, pos)
        local level = game:GetLevel()
        local room = level:GetCurrentRoom()
        local roomdesc = level:GetCurrentRoomDesc()
        --roomdesc.AwardSeed = rng.GetSeed()
        print("try")

        local player = Isaac.GetPlayer(0)
        if not player:HasTrinket(TrinketType.COLLECTIBLE_SNAKE_EYES) then
            return
        end

        local roll = math.random(1, 100)
        if roll <= snake.chance then
            print("try2")
            room:SpawnClearAward()
            room:SpawnClearAward()
        end


    end
    mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Snake_Eyes.OnClear)
]]

end

return Snake_Eyes