local Bombinomicon = {}
local game = Game()

mod.COLLECTIBLE_BOMBINOMICON = Isaac.GetItemIdByName("Bombinomicon")
CollectibleType.COLLECTIBLE_BOMBINOMICON = Isaac.GetItemIdByName("Bombinomicon")

function Bombinomicon:postUpdate()

    function Bombinomicon:TakeDmg(player, _, dmgFlag, DmgSourceRef)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_BOMBINOMICON)then
            
            if DmgSourceRef.Variant == BombVariant.BOMB_TROLL 
            or DmgSourceRef.Variant == BombVariant.BOMB_SUPERTROLL 
            or DmgSourceRef.Variant == BombVariant.BOMB_GOLDENTROLL then
                player:UseCard(Card.CARD_TOWER, UseFlag.USE_NOANNOUNCER)
            end


            if (dmgFlag & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION) then
                print("try")
                return false
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, Bombinomicon.TakeDmg)



end

return Bombinomicon