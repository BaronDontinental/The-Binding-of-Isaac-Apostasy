local Restraining_Order = {}
local game = Game()

mod.COLLECTIBLE_RESTRAINING_ORDER = Isaac.GetItemIdByName("Restraining Order")
CollectibleType.COLLECTIBLE_RESTRAINING_ORDER = Isaac.GetItemIdByName("Restraining Order")

local FEAR_RADIUS = 100
local FEAR_DURATION = 30
local SPEED_MULT = 2

local function closestHolder(npc)
    local closest, closestDist
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_RESTRAINING_ORDER) then
            local dist = player.Position:Distance(npc.Position)
            if dist <= FEAR_RADIUS + npc.Size and (not closestDist or dist < closestDist) then
                closest, closestDist = player, dist
            end
        end
    end
    return closest
end

function Restraining_Order:postUpdate()
    function Restraining_Order:preNpcUpdate(npc)
        local data = npc:GetData()
        if data.RestrainBoost then
            npc.Velocity = npc.Velocity / data.RestrainBoost
            data.RestrainBoost = nil
        end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, Restraining_Order.preNpcUpdate)

    function Restraining_Order:npcUpdate(npc)
        if not npc:IsActiveEnemy(false)
            or npc:HasEntityFlags(EntityFlag.FLAG_FRIENDLY)
            or npc:HasEntityFlags(EntityFlag.FLAG_CHARM) then
            return
        end
        local player = closestHolder(npc)
        if not player then
            return
        end
        npc:AddFear(EntityRef(player), FEAR_DURATION)
        if npc:HasEntityFlags(EntityFlag.FLAG_FEAR) then
            npc.Velocity = npc.Velocity * SPEED_MULT
            npc:GetData().RestrainBoost = SPEED_MULT
        end
    end
    mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, Restraining_Order.npcUpdate)

    function Restraining_Order:onPlayerDamage(entity, amount, flags, source, countdown)
        local player = entity:ToPlayer()
        if not player or not player:HasCollectible(CollectibleType.COLLECTIBLE_RESTRAINING_ORDER) then
            return
        end
        if flags & (DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_LASER) ~= 0 then
            return
        end
        if source and source.Entity and source.Entity:ToNPC() then
            return false
        end
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Restraining_Order.onPlayerDamage, EntityType.ENTITY_PLAYER)
end

return Restraining_Order
