local Dud_Bomb = {}
local game = Game()

mod.COLLECTIBLE_DUD_BOMB = Isaac.GetTrinketIdByName("Dud Bomb")
TrinketType.COLLECTIBLE_DUD_BOMB = Isaac.GetTrinketIdByName("Dud Bomb")

function Dud_Bomb:postUpdate()

    function Dud_Bomb:TakeDmg(player, _, dmgFlag, DmgSourceRef)
        if player:HasTrinket(TrinketType.COLLECTIBLE_DUD_BOMB) then
            if DmgSourceRef.Variant == BombVariant.BOMB_TROLL 
            or DmgSourceRef.Variant == BombVariant.BOMB_SUPERTROLL 
            or DmgSourceRef.Variant == BombVariant.BOMB_GOLDENTROLL then
                return false
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, Dud_Bomb.TakeDmg)

end

return Dud_Bomb