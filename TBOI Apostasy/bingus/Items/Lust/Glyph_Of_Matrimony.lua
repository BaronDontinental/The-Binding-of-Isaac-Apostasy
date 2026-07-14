local Glyph_Of_Matrimony = {}
local game = Game()

mod.COLLECTIBLE_GLYPH_OF_MATRIMONY = Isaac.GetItemIdByName("Glyph of Matrimony")
CollectibleType.COLLECTIBLE_GLYPH_OF_MATRIMONY = Isaac.GetItemIdByName("Glyph of Matrimony")

local CONVERT_CHANCE = 25

function Glyph_Of_Matrimony:postUpdate()

    function Glyph_Of_Matrimony:onDamage(entity, amount, flags, source, countdown)
        local player = entity:ToPlayer()
        if not player or not player:HasCollectible(CollectibleType.COLLECTIBLE_GLYPH_OF_MATRIMONY) then
            return
        end
        if not source or not source.Entity then
            return
        end
        local npc = source.Entity:ToNPC()
        if not npc then
            return
        end
        if npc:IsActiveEnemy(true) and npc:IsVulnerableEnemy() and not npc:IsBoss() then
            if math.random(100) <= CONVERT_CHANCE then
                npc:AddCharmed(EntityRef(player), -1)
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Glyph_Of_Matrimony.onDamage, EntityType.ENTITY_PLAYER)

end

return Glyph_Of_Matrimony