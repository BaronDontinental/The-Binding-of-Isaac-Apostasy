local Moar = {}
local game = Game()

mod.COLLECTIBLE_MOAR = Isaac.GetItemIdByName("Moar")
CollectibleType.COLLECTIBLE_MOAR = Isaac.GetItemIdByName("Moar")

function Moar:postUpdate()
    local player = Isaac.GetPlayer(0)
    local level = game:GetLevel()
    local currentroom = level:GetCurrentRoom()

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOAR) == 1 then
        print(currentroom)
        print("ur mom gae")
    end
    

    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Moar.postUpdate)
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Moar.postUpdate)
end

return Moar