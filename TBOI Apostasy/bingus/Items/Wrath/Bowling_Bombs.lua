local Bowling_Bombs = {}
local game = Game()

mod.COLLECTIBLE_BOWLING_BOMBS = Isaac.GetItemIdByName("Bowling Bombs")
CollectibleType.COLLECTIBLE_BOWLING_BOMBS = Isaac.GetItemIdByName("Bowling Bombs")

local BOWL_SPEED = 8
local CONTACT_DAMAGE = 20
local HIT_COOLDOWN = 15

local EXCLUDED_VARIANTS = {
    [BombVariant.BOMB_TROLL] = true,
    [BombVariant.BOMB_SUPERTROLL] = true,
    [BombVariant.BOMB_GOLDENTROLL] = true,
    [BombVariant.BOMB_ROCKET] = true,
    [BombVariant.BOMB_ROCKET_GIGA] = true,
    [BombVariant.BOMB_THROWABLE] = true,
}

local function rollDirection(bomb, player)
    if bomb.IsFetus then
        if bomb.Velocity:Length() > 0.1 then
            return bomb.Velocity:Normalized()
        end
        return nil
    end
    local input = player:GetMovementVector()
    if input:Length() > 0.1 then
        return input:Normalized()
    end
    if player.Velocity:Length() > 0.5 then
        return player.Velocity:Normalized()
    end
    return nil
end

local function isBlocked(room, pos)
    return room:GetGridCollisionAtPos(pos) ~= GridCollisionClass.COLLISION_NONE
end

local function sign(n)
    return n > 0 and 1 or -1
end

function Bowling_Bombs:postUpdate()
    function Bowling_Bombs:onBombUpdate(bomb)
        local data = bomb:GetData()
        if not data.BowlChecked then
            data.BowlChecked = true
            local player = bomb.SpawnerEntity and bomb.SpawnerEntity:ToPlayer()
            if not player or EXCLUDED_VARIANTS[bomb.Variant]
                or not player:HasCollectible(CollectibleType.COLLECTIBLE_BOWLING_BOMBS) then
                return
            end
            data.BowlDir = rollDirection(bomb, player)
            if not data.BowlDir then
                return
            end
            data.BowlPlayer = player
            data.BowlHits = {}
        end
        if not data.BowlDir then
            return
        end
        local room = game:GetRoom()
        local dir = data.BowlDir
        local reach = bomb.Size + BOWL_SPEED
        if dir.X ~= 0 and isBlocked(room, bomb.Position + Vector(sign(dir.X) * reach, 0)) then
            dir = Vector(-dir.X, dir.Y)
        end
        if dir.Y ~= 0 and isBlocked(room, bomb.Position + Vector(0, sign(dir.Y) * reach)) then
            dir = Vector(dir.X, -dir.Y)
        end
        data.BowlDir = dir
        bomb.Velocity = dir * BOWL_SPEED
    end
    mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, Bowling_Bombs.onBombUpdate)

    function Bowling_Bombs:onBombCollision(bomb, collider, low)
        local data = bomb:GetData()
        if not data.BowlDir or not collider:IsVulnerableEnemy()
            or collider:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
            return
        end
        local hash = GetPtrHash(collider)
        local frame = game:GetFrameCount()
        if data.BowlHits[hash] and frame - data.BowlHits[hash] < HIT_COOLDOWN then
            return
        end
        data.BowlHits[hash] = frame
        local source = data.BowlPlayer and data.BowlPlayer:Exists() and data.BowlPlayer or bomb
        collider:TakeDamage(CONTACT_DAMAGE, 0, EntityRef(source), 0)
    end
    mod:AddCallback(ModCallbacks.MC_PRE_BOMB_COLLISION, Bowling_Bombs.onBombCollision)
end

return Bowling_Bombs
