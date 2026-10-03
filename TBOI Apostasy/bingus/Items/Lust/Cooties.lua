local Cooties = {}
local game = Game()

mod.COLLECTIBLE_COOTIES = Isaac.GetItemIdByName("Cooties")
CollectibleType.COLLECTIBLE_COOTIES = Isaac.GetItemIdByName("Cooties")

local CHARM_DURATION = 90
local pending = {}

local function canCatch(entity)
    return entity:IsActiveEnemy() and entity:IsVulnerableEnemy()
        and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY)
end

local function isCharmed(entity)
    return entity:HasEntityFlags(EntityFlag.FLAG_CHARM)
end

local function getCarrier()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_COOTIES) then
            return player
        end
    end
end

function Cooties:postUpdate()

---@param player EntityPlayer
    function Cooties:onPlayerTouch(player, collider, low)
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_COOTIES) then
            return
        end
        if canCatch(collider) then
            table.insert(pending, {enemy = collider, player = player})
        end
    end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, Cooties.onPlayerTouch)

    function Cooties:applyPending()
        for _, touch in ipairs(pending) do
            if touch.enemy:Exists() and canCatch(touch.enemy) then
                touch.enemy:AddCharmed(EntityRef(touch.player), CHARM_DURATION)
            end
        end
        pending = {}
    end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Cooties.applyPending)

    function Cooties:onNpcTouch(npc, collider, low)
        local carrier = getCarrier()
        if not carrier then
            return
        end
        if isCharmed(npc) and canCatch(collider) and not isCharmed(collider) then
            collider:AddCharmed(EntityRef(carrier), CHARM_DURATION)
        elseif isCharmed(collider) and canCatch(npc) and not isCharmed(npc) then
            npc:AddCharmed(EntityRef(carrier), CHARM_DURATION)
        end
    end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, Cooties.onNpcTouch)

end

return Cooties
