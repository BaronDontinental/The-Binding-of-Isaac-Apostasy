local Hornfells_Horn = {}
local game = Game()

mod.COLLECTIBLE_HORNFELLS_HORN = Isaac.GetItemIdByName("Hornfel's Horn")
CollectibleType.COLLECTIBLE_HORNFELLS_HORN = Isaac.GetItemIdByName("Hornfel's Horn")

-- Kamikaze wisps blow up like a bomb when they die or an enemy touches them
local BOMB_WISP_SUBTYPE = CollectibleType.COLLECTIBLE_KAMIKAZE

function Hornfells_Horn:postUpdate()

    function Hornfells_Horn:onRoomClear(rng, spawnPos)
        for i = 0, game:GetNumPlayers() - 1 do
            local player = game:GetPlayer(i)
            if player:HasCollectible(CollectibleType.COLLECTIBLE_HORNFELLS_HORN) then
                player:AddWisp(BOMB_WISP_SUBTYPE, player.Position)
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Hornfells_Horn.onRoomClear)

end

return Hornfells_Horn
