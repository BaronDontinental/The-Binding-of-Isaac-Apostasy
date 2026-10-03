local Pack_Em_In = {}
local game = Game()
local SaveManager = require("callbacks.save_manager")

mod.COLLECTIBLE_PACK_EM_IN = Isaac.GetItemIdByName("Pack 'em in")
CollectibleType.COLLECTIBLE_PACK_EM_IN = Isaac.GetItemIdByName("Pack 'em in")

local SPAWN_CHANCE = 0.075

local FRUIT_ORDER = {
    CollectibleType.COLLECTIBLE_BREAKFAST,
    CollectibleType.COLLECTIBLE_LUNCH,
    CollectibleType.COLLECTIBLE_SNACK,
    CollectibleType.COLLECTIBLE_DINNER,
    CollectibleType.COLLECTIBLE_DESSERT,
    CollectibleType.COLLECTIBLE_BLUE_CAP,
    CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM,
    CollectibleType.COLLECTIBLE_DADS_KEY,
}

local state = {Index = 1, Pedestals = {}}

local function save()
    SaveManager.Set("Pack_Em_In", state)
end

local function getHolder()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_PACK_EM_IN) then
            return player
        end
    end
end

function Pack_Em_In:postUpdate()
    function Pack_Em_In:onNewRoom()
        local room = game:GetRoom()
        if room:IsClear() or room:GetAliveEnemiesCount() <= 0 or room:GetType() == RoomType.ROOM_BOSS then
            return
        end
        local player = getHolder()
        if not player then
            return
        end
        if player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PACK_EM_IN):RandomFloat() >= SPAWN_CHANCE then
            return
        end
        local fruit = FRUIT_ORDER[state.Index]
        local pos = room:FindFreePickupSpawnPosition(room:GetCenterPos(), 0, true)
        local pedestal = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, fruit, pos, Vector.Zero, nil)
        state.Pedestals[tostring(pedestal.InitSeed)] = fruit
        save()
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Pack_Em_In.onNewRoom)

    function Pack_Em_In:onPedestalUpdate(pickup)
        local key = tostring(pickup.InitSeed)
        local fruit = state.Pedestals[key]
        if not fruit or fruit == 0 or pickup.SubType == fruit then
            return
        end
        state.Pedestals[key] = 0
        if fruit == FRUIT_ORDER[#FRUIT_ORDER] then
            state.Index = 1
            local player = getHolder()
            if player then
                player:RemoveCollectible(CollectibleType.COLLECTIBLE_PACK_EM_IN)
            end
        else
            state.Index = math.min(#FRUIT_ORDER, state.Index + 1)
        end
        save()
    end
    mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, Pack_Em_In.onPedestalUpdate, PickupVariant.PICKUP_COLLECTIBLE)

    function Pack_Em_In:onRoomClear()
        local removed = false
        for _, pedestal in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
            local key = tostring(pedestal.InitSeed)
            if state.Pedestals[key] then
                state.Pedestals[key] = nil
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pedestal.Position, Vector.Zero, nil)
                pedestal:Remove()
                removed = true
            end
        end
        if removed then
            save()
        end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Pack_Em_In.onRoomClear)

    function Pack_Em_In:onGameStarted(fromSave)
        local saved = fromSave and SaveManager.Get("Pack_Em_In")
        if saved and saved.Index then
            state = {Index = saved.Index, Pedestals = saved.Pedestals or {}}
        else
            state = {Index = 1, Pedestals = {}}
            save()
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Pack_Em_In.onGameStarted)
end

return Pack_Em_In
