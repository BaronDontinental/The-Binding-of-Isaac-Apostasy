local B26_Pride = {}
local game = Game()
local sfx = SFXManager()
local okSave, SaveManager = pcall(require, "callbacks.save_manager")
if not okSave or type(SaveManager) ~= "table" then
    print("[Apostasy] B26_Pride: save_manager failed to load, saving disabled: " .. tostring(SaveManager))
    SaveManager = {Get = function() return nil end, Set = function() end}
end

local PrideBType = Isaac.GetPlayerTypeByName("B26_Pride", false)
local DogmaType = Isaac.GetPlayerTypeByName("B26_Dogma", false)
local PRIDE_BODY_VARIANT = Isaac.GetEntityVariantByName("Pride Body")
local SOUND_APPEAR = SoundEffect.SOUND_DOGMA_APPEAR_SCREAM or 541
local SOUND_TV_BREAK = SoundEffect.SOUND_DOGMA_TV_BREAK or 567
print("[Apostasy] B26_Pride loaded: PrideBType=" .. tostring(PrideBType) .. " DogmaType=" .. tostring(DogmaType) .. " BodyVariant=" .. tostring(PRIDE_BODY_VARIANT))

mod.COLLECTIBLE_HUBRIS = Isaac.GetItemIdByName("Hubris")
CollectibleType.COLLECTIBLE_HUBRIS = Isaac.GetItemIdByName("Hubris")
print("[Apostasy] B26_Pride: Hubris id=" .. tostring(CollectibleType.COLLECTIBLE_HUBRIS))

local B26_PrideStats = {
    DAMAGE = 0,
    SPEED = 0,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    LUCK = 0,
    FLIP_INTERVAL = 150,
    CHAIN_SPACING = 12,
    STATIC_COLOR = Color(0.5, 0.8, 1.0, 1.0, 0, 0.1, 0.3)
}

mod.PrideB = {
    form = "pride",
    timer = 0,
    cycle = 1,
    pattern = 1,
    bodyPos = nil,
    autoFlipped = false,
    charge = 0,
    fired = false,
    beamUntil = -1,
    radialUntil = -1,
    STATIC_COLOR = Color(0.5, 0.8, 1.0, 1.0, 0, 0.1, 0.3)
}
local state = mod.PrideB

local chainSprite = Sprite()
chainSprite:Load("gfx/dogma_chain.anm2", true)
chainSprite:Play("Idle", true)

function B26_Pride:postUpdate()
    print("[Apostasy] B26_Pride registering callbacks")

    local function removeBody()
        for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, PRIDE_BODY_VARIANT, -1, false, false)) do
            entity:Remove()
        end
        state.bodyPos = nil
    end

---@param player EntityPlayer
    local function spawnBody(player)
        local body = Isaac.Spawn(EntityType.ENTITY_EFFECT, PRIDE_BODY_VARIANT, 0, player.Position, Vector.Zero, player):ToEffect()
        local sprite = body:GetSprite()
        for layer = 0, 14 do
            sprite:ReplaceSpritesheet(layer, "gfx/characters/costumes/Character_026_PrideB.png")
        end
        sprite:LoadGraphics()
        sprite:SetFrame("WalkDown", 0)
        body.Color = B26_PrideStats.STATIC_COLOR
        body.DepthOffset = -10
        state.bodyPos = player.Position
    end

---@param player EntityPlayer
    function mod.PrideB.FlipToDogma(player, auto)
        if player:GetPlayerType() ~= PrideBType then
            return
        end
        spawnBody(player)
        player:ChangePlayerType(DogmaType)
        state.form = "dogma"
        state.timer = 0
        state.autoFlipped = auto == true
        state.pattern = state.cycle
        state.cycle = state.cycle % 3 + 1
        SaveManager.Set("B26_Pride", {cycle = state.cycle})
        state.charge = 0
        state.fired = false
        state.beamUntil = -1
        state.radialUntil = -1
        player:AddCacheFlags(CacheFlag.CACHE_ALL)
        player:EvaluateItems()
        sfx:Play(SOUND_APPEAR, 0.6, 0, false, 1)
        print("[Apostasy] FlipToDogma done: pattern=" .. tostring(state.pattern))
    end

---@param player EntityPlayer
    function mod.PrideB.FlipToPride(player, teleport)
        if player:GetPlayerType() ~= DogmaType then
            return
        end
        player:ChangePlayerType(PrideBType)
        if teleport and state.bodyPos ~= nil then
            player.Position = state.bodyPos
        end
        removeBody()
        player:SetCanShoot(true)
        player.Color = Color(1, 1, 1, 1, 0, 0, 0)
        state.form = "pride"
        state.timer = 0
        state.autoFlipped = false
        player:AddCacheFlags(CacheFlag.CACHE_ALL)
        player:EvaluateItems()
        sfx:Play(SOUND_TV_BREAK, 0.6, 0, false, 1)
        print("[Apostasy] FlipToPride done")
    end

---@param player EntityPlayer
    function B26_Pride:OnCache(player, cacheFlag)
        if player:GetPlayerType() ~= PrideBType then
            return
        end
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + B26_PrideStats.DAMAGE
        end
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + B26_PrideStats.SPEED
        end
        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed + B26_PrideStats.SHOTSPEED
        end
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay + B26_PrideStats.MAXFIREDELAY
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + B26_PrideStats.LUCK
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B26_Pride.OnCache)

---@param player EntityPlayer
    function B26_Pride:PlayerInit(player)
        print("[Apostasy] B26_Pride PlayerInit: playerType=" .. tostring(player:GetPlayerType()) .. " expected=" .. tostring(PrideBType))
        if player:GetPlayerType() ~= PrideBType then
            return
        end
        if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_HUBRIS then
            player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_HUBRIS, ActiveSlot.SLOT_POCKET, false)
            print("[Apostasy] B26_Pride: Hubris granted to pocket slot")
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, B26_Pride.PlayerInit)

    function B26_Pride:GameStarted(isContinued)
        local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() == DogmaType then
            player:ChangePlayerType(PrideBType)
            if player:GetSoulHearts() == 0 and player:GetMaxHearts() == 0 then
                player:AddSoulHearts(6)
            end
        end
        if not isContinued then
            SaveManager.Set("B26_Pride", nil)
            state.cycle = 1
        else
            local saved = SaveManager.Get("B26_Pride")
            if type(saved) == "table" and tonumber(saved.cycle) then
                state.cycle = tonumber(saved.cycle)
            end
        end
        state.form = "pride"
        state.timer = 0
        state.bodyPos = nil
        state.autoFlipped = false
    end
    mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, B26_Pride.GameStarted)

---@param player EntityPlayer
    function B26_Pride:PeUpdate(player)
        local ptype = player:GetPlayerType()
        if ptype ~= PrideBType and ptype ~= DogmaType then
            return
        end

        if ptype == PrideBType then
            local red = player:GetMaxHearts()
            if red > 0 then
                player:AddMaxHearts(-red)
                player:AddSoulHearts(red)
            end
            local bone = player:GetBoneHearts()
            if bone > 0 then
                player:AddBoneHearts(-bone)
                player:AddSoulHearts(bone * 2)
            end
        end

        local enemies = false
        for _, entity in ipairs(Isaac.GetRoomEntities()) do
            if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
                enemies = true
                break
            end
        end

        if DebugMode and game:GetFrameCount() % 60 == 0 then
            print("[Apostasy] B26_Pride PeUpdate: form=" .. tostring(state.form) .. " timer=" .. tostring(state.timer) .. " enemies=" .. tostring(enemies))
        end

        if enemies then
            state.timer = state.timer + 1
            if state.timer >= B26_PrideStats.FLIP_INTERVAL then
                if ptype == PrideBType then
                    mod.PrideB.FlipToDogma(player, true)
                else
                    mod.PrideB.FlipToPride(player, true)
                end
            end
        elseif ptype == DogmaType and state.autoFlipped then
            mod.PrideB.FlipToPride(player, true)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B26_Pride.PeUpdate)

---@param player EntityPlayer
    function B26_Pride:UseHubris(item, rng, player, useFlags, slot, varData)
        if player:GetPlayerType() == PrideBType then
            mod.PrideB.FlipToDogma(player, false)
            return true
        elseif player:GetPlayerType() == DogmaType then
            mod.PrideB.FlipToPride(player, true)
            return true
        end
        return false
    end
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, B26_Pride.UseHubris, CollectibleType.COLLECTIBLE_HUBRIS)

    function B26_Pride:NewRoom()
        local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() == DogmaType then
            mod.PrideB.FlipToPride(player, false)
        end
        removeBody()
        state.timer = 0
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, B26_Pride.NewRoom)

    function B26_Pride:OnRender()
        if state.form ~= "dogma" or state.bodyPos == nil then
            return
        end
        local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() ~= DogmaType then
            return
        end
        local delta = player.Position - state.bodyPos
        local links = math.max(math.floor(delta:Length() / B26_PrideStats.CHAIN_SPACING), 1)
        for i = 0, links do
            local point = state.bodyPos + delta * (i / links)
            chainSprite:Render(Isaac.WorldToScreen(point))
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_RENDER, B26_Pride.OnRender)
    print("[Apostasy] B26_Pride callbacks registered")

end

return B26_Pride