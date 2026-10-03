local Lil_Pride = {}
local game = Game()
local sfx = SFXManager()
local SaveManager = require("callbacks.save_manager")

mod.COLLECTIBLE_LIL_PRIDE = Isaac.GetItemIdByName("Lil Pride")
CollectibleType.COLLECTIBLE_LIL_PRIDE = Isaac.GetItemIdByName("Lil Pride")
FAMILIAR_PRIDE_VARIANT = Isaac.GetEntityVariantByName("LIL_PRIDE")

local CONFIG_PRIDE = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LIL_PRIDE)

local RNG_SHIFT_INDEX = 35

local PRIDE_SPEED = 2
local PRIDE_FRICTION = 0.8
local WANDER_DISTANCE = 40
local PATH_MARKER = 0
local IDLE_SPEED_THRESHOLD = 0.1

local KILLS_FOR_FIGHT = 15
local DROP_CHANCE = 0.33

local PRIDE_COLLECTIBLES = {
    "Chicken",
    "The Shaker",
    "Salt Lamp",
    "Lil Pride",
    "Big, Boi, Bathwater",
    "Reeee!",
    "Vaccine",
    "Bombinomicon",
    "Haughty Spirit",
}
local PRIDE_TRINKETS = {
    "Participation Award",
    "Just Cause",
}

local killCounts = {}

local function playerKey(player)
    for i = 0, game:GetNumPlayers() - 1 do
        if GetPtrHash(Isaac.GetPlayer(i)) == GetPtrHash(player) then
            return tostring(i)
        end
    end
    return "0"
end

local function buildDropPool()
    local pool = {}
    for _, name in ipairs(PRIDE_COLLECTIBLES) do
        local id = Isaac.GetItemIdByName(name)
        if id > 0 then
            table.insert(pool, {variant = PickupVariant.PICKUP_COLLECTIBLE, id = id})
        end
    end
    for _, name in ipairs(PRIDE_TRINKETS) do
        local id = Isaac.GetTrinketIdByName(name)
        if id > 0 then
            table.insert(pool, {variant = PickupVariant.PICKUP_TRINKET, id = id})
        end
    end
    return pool
end

local function morphPoof(position)
    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, position, Vector.Zero, nil)
    sfx:Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
end

local function morphBack(familiar, position)
    local data = familiar:GetData()
    if not data.LilPrideMorph then
        return
    end
    data.LilPrideMorph = nil
    familiar.Visible = true
    familiar.EntityCollisionClass = data.LilPrideCollision or EntityCollisionClass.ENTCOLL_ALL
    data.LilPrideCollision = nil
    familiar.Position = position
    familiar.Velocity = Vector.Zero
    familiar:GetSprite():Play("Appear", true)
    morphPoof(position)
end

local function startPrideFight(player, familiar)
    local room = game:GetRoom()
    local origin = familiar and familiar:Exists() and familiar.Position or room:GetCenterPos()
    local pos = Isaac.GetFreeNearPosition(origin, 40)
    local pride = Isaac.Spawn(EntityType.ENTITY_PRIDE, 0, 0, pos, Vector.Zero, nil)
    pride:GetData().LilPrideFight = player
    if familiar and familiar:Exists() then
        local data = familiar:GetData()
        data.LilPrideMorph = pride
        data.LilPrideCollision = familiar.EntityCollisionClass
        pride:GetData().LilPrideFamiliar = familiar
        familiar.Visible = false
        familiar.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
    end
    morphPoof(pos)
    room:SetClear(false)
    for slot = 0, DoorSlot.NUM_DOOR_SLOTS - 1 do
        local door = room:GetDoor(slot)
        if door then
            door:Close(true)
        end
    end
end

function Lil_Pride:postUpdate()
---@param player EntityPlayer
    function Lil_Pride:OnCache(player)
        local effect = player:GetEffects()
        local count = effect:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_LIL_PRIDE) + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LIL_PRIDE)
        local rng = RNG()
        local seed = math.max(Random(), 1)
        rng:SetSeed(seed, RNG_SHIFT_INDEX)
        player:CheckFamiliar(FAMILIAR_PRIDE_VARIANT, count, rng, CONFIG_PRIDE)
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Lil_Pride.OnCache, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
    function Lil_Pride:init(familiar)
        familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
        familiar:GetSprite():Play("Appear", true)
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Lil_Pride.init, FAMILIAR_PRIDE_VARIANT)

---@param familiar EntityFamiliar
    function Lil_Pride:UpdateFam(familiar)
        local sprite = familiar:GetSprite()
        local morph = familiar:GetData().LilPrideMorph
        if morph then
            if morph:Exists() and not morph:IsDead() then
                familiar.Position = morph.Position
                familiar.Velocity = Vector.Zero
                return
            end
            morphBack(familiar, morph.Position)
        end

        local target = nil
        local targetDist = math.huge
        for _, entity in pairs(Isaac.GetRoomEntities()) do
            if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
                local dist = (entity.Position - familiar.Position):Length()
                if dist < targetDist then
                    targetDist = dist
                    target = entity
                end
            end
        end

        local goalPos
        if target ~= nil then
            goalPos = target.Position
        elseif (familiar.Player.Position - familiar.Position):Length() > WANDER_DISTANCE then
            goalPos = familiar.Player.Position
        end

        if goalPos ~= nil then
            familiar:GetPathFinder():FindGridPath(goalPos, PRIDE_SPEED, PATH_MARKER, true)
        end
        familiar:MultiplyFriction(PRIDE_FRICTION)

        if not (sprite:IsPlaying("Appear") and not sprite:IsFinished("Appear")) then
            local attacking = target ~= nil and targetDist <= (familiar.Size + target.Size + 4)
            local moving = familiar.Velocity:Length() > IDLE_SPEED_THRESHOLD
            if attacking or moving then
                local faceDir
                if attacking then
                    faceDir = target.Position - familiar.Position
                else
                    faceDir = familiar.Velocity
                end
                local anim
                local flip = false
                if math.abs(faceDir.X) >= math.abs(faceDir.Y) then
                    anim = attacking and "Attack Hori" or "Move Hori"
                    flip = faceDir.X < 0
                elseif faceDir.Y < 0 then
                    anim = attacking and "Attack Up" or "Move Up"
                else
                    anim = attacking and "Attack Down" or "Move Down"
                end
                if not sprite:IsPlaying(anim) then
                    sprite:Play(anim, true)
                end
                sprite.FlipX = flip
            else
                sprite:Stop()
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lil_Pride.UpdateFam, FAMILIAR_PRIDE_VARIANT)

    function Lil_Pride:onDamage(entity, amount, flags, source, countdown)
        local npc = entity:ToNPC()
        if not npc then
            return
        end
        local familiar = source and source.Entity and source.Entity:ToFamiliar()
        local data = npc:GetData()
        if familiar and familiar.Variant == FAMILIAR_PRIDE_VARIANT then
            data.LilPrideKiller = familiar.Player
            data.LilPrideKillerFamiliar = familiar
        else
            data.LilPrideKiller = nil
            data.LilPrideKillerFamiliar = nil
        end
    end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Lil_Pride.onDamage)

    function Lil_Pride:onKill(entity)
        local data = entity:GetData()
        if data.LilPrideFight then
            local player = data.LilPrideFight
            data.LilPrideFight = nil
            local familiar = data.LilPrideFamiliar
            data.LilPrideFamiliar = nil
            if familiar and familiar:Exists() then
                morphBack(familiar, entity.Position)
            end
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LIL_PRIDE)
            if rng:RandomFloat() >= DROP_CHANCE then
                return
            end
            local pool = buildDropPool()
            if #pool == 0 then
                return
            end
            local drop = pool[rng:RandomInt(#pool) + 1]
            local pos = game:GetRoom():FindFreePickupSpawnPosition(entity.Position, 0, true)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, drop.variant, drop.id, pos, Vector.Zero, nil)
            return
        end
        local player = data.LilPrideKiller
        if not player or not player:Exists() or not entity:IsEnemy() then
            return
        end
        local familiar = data.LilPrideKillerFamiliar
        data.LilPrideKiller = nil
        data.LilPrideKillerFamiliar = nil
        local key = playerKey(player)
        killCounts[key] = (killCounts[key] or 0) + 1
        if killCounts[key] >= KILLS_FOR_FIGHT then
            killCounts[key] = 0
            startPrideFight(player, familiar)
        end
        SaveManager.Set("Lil_Pride", killCounts)
    end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, Lil_Pride.onKill)

    function Lil_Pride:onGameStarted(fromSave)
        if fromSave then
            killCounts = SaveManager.Get("Lil_Pride") or {}
        else
            killCounts = {}
            SaveManager.Set("Lil_Pride", killCounts)
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Lil_Pride.onGameStarted)

end

return Lil_Pride
