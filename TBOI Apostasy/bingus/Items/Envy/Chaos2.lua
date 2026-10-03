local Chaos2 = {}
local game = Game()
local sfx = SFXManager()
local SaveManager = require("callbacks.save_manager")

mod.COLLECTIBLE_CHAOS2 = Isaac.GetItemIdByName("Chaos?")
CollectibleType.COLLECTIBLE_CHAOS2 = Isaac.GetItemIdByName("Chaos?")

local BLIND_PEDESTALS = 3
local PEDESTAL_SPACING = 80
local DISGUISE_CHANCE = 0.33

local DISGUISES = {
    {variant = PickupVariant.PICKUP_COIN, subtype = CoinSubType.COIN_PENNY},
    {variant = PickupVariant.PICKUP_BOMB, subtype = BombSubType.BOMB_NORMAL},
    {variant = PickupVariant.PICKUP_KEY, subtype = KeySubType.KEY_NORMAL},
    {variant = PickupVariant.PICKUP_HEART, subtype = HeartSubType.HEART_FULL},
}

local rolled = {}
local rolledFloor = nil

local function currentFloor()
    local level = game:GetLevel()
    return tostring(level:GetStage()) .. "_" .. tostring(level:GetStageType())
end

local function saveRolled()
    SaveManager.Set("Chaos2", {Floor = rolledFloor, Rolled = rolled})
end

local function syncFloor()
    local floor = currentFloor()
    if rolledFloor ~= floor then
        rolledFloor = floor
        rolled = {}
    end
end

local function anyoneHasChaos()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CHAOS2) then
            return player
        end
    end
end

local function spawnBlindPedestals(player)
    local room = game:GetRoom()
    local itemPool = game:GetItemPool()
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_CHAOS2)
    local poolType = itemPool:GetPoolForRoom(room:GetType(), rng:Next())
    if poolType == ItemPoolType.POOL_NULL then
        poolType = ItemPoolType.POOL_TREASURE
    end
    local optionsIndex = 1
    for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
        optionsIndex = math.max(optionsIndex, entity:ToPickup().OptionsPickupIndex + 1)
    end
    for i = 1, BLIND_PEDESTALS do
        local offset = Vector((i - (BLIND_PEDESTALS + 1) / 2) * PEDESTAL_SPACING, 80)
        local pos = room:FindFreePickupSpawnPosition(player.Position + offset, 0, true)
        local item = itemPool:GetCollectible(poolType, true, rng:Next())
        local pedestal = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, item, pos, Vector.Zero, player):ToPickup()
        pedestal:SetForceBlind(true)
        pedestal.OptionsPickupIndex = optionsIndex
    end
end

function Chaos2:postUpdate()
    function Chaos2:onAdd(itemType, charge, firstTime, slot, varData, player)
        if firstTime then
            spawnBlindPedestals(player)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, Chaos2.onAdd, CollectibleType.COLLECTIBLE_CHAOS2)

    function Chaos2:onPickupTouch(pickup, collider, low)
        syncFloor()
        local player = collider:ToPlayer()
        local key = tostring(pickup.InitSeed)
        if rolled[key] or not player then
            return
        end
        local holder = anyoneHasChaos()
        if not holder then
            return
        end
        local price = pickup.Price
        local shopItem = price ~= 0
        if shopItem then
            if price < 0 and price ~= PickupPrice.PRICE_FREE then
                return
            end
            if price > 0 and player:GetNumCoins() < price then
                return
            end
        end
        rolled[key] = true
        saveRolled()
        local rng = holder:GetCollectibleRNG(CollectibleType.COLLECTIBLE_CHAOS2)
        if rng:RandomFloat() >= DISGUISE_CHANCE then
            return
        end
        local options = {}
        for _, disguise in ipairs(DISGUISES) do
            if disguise.variant ~= pickup.Variant then
                table.insert(options, disguise)
            end
        end
        local reveal = options[rng:RandomInt(#options) + 1]
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
        if shopItem then
            if price > 0 then
                player:AddCoins(-price)
            end
            sfx:Play(SoundEffect.SOUND_CASH_REGISTER, 1, 0, false, 1)
            local drop = Isaac.Spawn(EntityType.ENTITY_PICKUP, reveal.variant, reveal.subtype, pickup.Position, Vector.Zero, nil)
            rolled[tostring(drop.InitSeed)] = true
            saveRolled()
            pickup:Remove()
            return false
        end
        pickup:Morph(EntityType.ENTITY_PICKUP, reveal.variant, reveal.subtype, true, true, true)
        rolled[tostring(pickup.InitSeed)] = true
        saveRolled()
        return false
    end
    mod:AddPriorityCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, CallbackPriority.IMPORTANT, Chaos2.onPickupTouch, PickupVariant.PICKUP_COIN)
    mod:AddPriorityCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, CallbackPriority.IMPORTANT, Chaos2.onPickupTouch, PickupVariant.PICKUP_BOMB)
    mod:AddPriorityCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, CallbackPriority.IMPORTANT, Chaos2.onPickupTouch, PickupVariant.PICKUP_KEY)
    mod:AddPriorityCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, CallbackPriority.IMPORTANT, Chaos2.onPickupTouch, PickupVariant.PICKUP_HEART)

    function Chaos2:onGameStarted(fromSave)
        local saved = fromSave and SaveManager.Get("Chaos2")
        rolled = saved and saved.Rolled or {}
        rolledFloor = saved and saved.Floor or nil
        if not fromSave then
            saveRolled()
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Chaos2.onGameStarted)
end

return Chaos2
