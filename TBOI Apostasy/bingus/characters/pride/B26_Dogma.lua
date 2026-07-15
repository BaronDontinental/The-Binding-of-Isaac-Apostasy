local B26_Dogma = {}
local game = Game()
local sfx = SFXManager()

local SOUND_BRIM_CHARGE = SoundEffect.SOUND_DOGMA_BRIMSTONE_CHARGE or 547
local SOUND_BRIM_SHOOT = SoundEffect.SOUND_DOGMA_BRIMSTONE_SHOOT or 548
local SOUND_GODHEAD = SoundEffect.SOUND_DOGMA_GODHEAD or 549
local SOUND_FEATHERS = SoundEffect.SOUND_DOGMA_FEATHER_SPRAY or 556

local B26_DogmaStats = {
    BRIM_CHARGE = 15,
    BRIM_DURATION = 135,
    RADIAL_DELAY = 8,
    RADIAL_DURATION = 90,
    RADIAL_RATE = 5,
    RADIAL_COUNT = 8,
    RADIAL_SPEED = 10,
    FEATHER_CHARGE = 15,
    FEATHER_COUNT = 10,
    FEATHER_SPREAD = 30,
    FEATHER_SPEED = 10,
    FEATHER_TRAVEL_MIN = 10,
    FEATHER_TRAVEL_MAX = 20,
    FEATHER_HOVER = 90,
    FEATHER_VARIANT = TearVariant.TOOTH,
    CHAIN_LENGTH = 260,
    HEART_FADE = Color(1, 1, 1, 0.25, 0, 0, 0),
    STATIC_SPACING = 40
}

local staticSprite = Sprite()
staticSprite:Load("gfx/dogma_static.anm2", true)
staticSprite:Play("Idle", true)

function B26_Dogma:postUpdate()
    local state = mod.PrideB

---@param player EntityPlayer
    function B26_Dogma:OnCache(player, cacheFlag)
        if player:GetName() ~= "B26_Dogma" then
            return
        end
        if cacheFlag == CacheFlag.CACHE_FLYING then
            player.CanFly = true
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B26_Dogma.OnCache)

---@param player EntityPlayer
    function B26_Dogma:PeUpdate(player)
        if player:GetName() ~= "B26_Dogma" then
            return
        end
        player:SetCanShoot(false)
        player.Color = state.STATIC_COLOR

        if state.bodyPos ~= nil then
            local delta = player.Position - state.bodyPos
            if delta:Length() > B26_DogmaStats.CHAIN_LENGTH then
                player.Position = state.bodyPos + delta:Resized(B26_DogmaStats.CHAIN_LENGTH)
            end
        end

        local frame = game:GetFrameCount()
        local input = player:GetShootingInput()
        local held = input:Length() > 0.1

        if state.pattern == 1 then
            if frame < state.beamUntil then
                state.charge = 0
            elseif held and not state.fired then
                if state.charge == 0 then
                    sfx:Play(SOUND_BRIM_CHARGE, 0.7, 0, false, 1)
                end
                state.charge = state.charge + 1
                if state.charge >= B26_DogmaStats.BRIM_CHARGE then
                    local laser = player:FireBrimstone(input:Normalized())
                    laser.TearFlags = laser.TearFlags | TearFlags.TEAR_HOMING
                    laser:SetTimeout(B26_DogmaStats.BRIM_DURATION)
                    laser.Color = state.STATIC_COLOR
                    laser:GetData().DogmaStatic = true
                    sfx:Play(SOUND_BRIM_SHOOT, 0.8, 0, false, 1)
                    state.beamUntil = frame + B26_DogmaStats.BRIM_DURATION
                    state.charge = 0
                    state.fired = true
                end
            elseif not held then
                state.charge = 0
                state.fired = false
            end
        elseif state.pattern == 2 then
            if frame < state.radialUntil then
                if frame % B26_DogmaStats.RADIAL_RATE == 0 then
                    for i = 0, B26_DogmaStats.RADIAL_COUNT - 1 do
                        local dir = Vector.FromAngle(i * (360 / B26_DogmaStats.RADIAL_COUNT) + frame * 3)
                        local tear = player:FireTear(player.Position, dir * B26_DogmaStats.RADIAL_SPEED, false, true, false, player, 1)
                        tear.TearFlags = tear.TearFlags | TearFlags.TEAR_GLOW
                        tear.Color = state.STATIC_COLOR
                        tear:GetData().DogmaStatic = true
                    end
                end
            elseif held and not state.fired then
                state.charge = state.charge + 1
                if state.charge >= B26_DogmaStats.RADIAL_DELAY then
                    state.radialUntil = frame + B26_DogmaStats.RADIAL_DURATION
                    state.charge = 0
                    state.fired = true
                    sfx:Play(SOUND_GODHEAD, 0.8, 0, false, 1)
                end
            elseif not held then
                state.charge = 0
                state.fired = false
            end
        else
            if held and not state.fired then
                if state.charge == 0 then
                    sfx:Play(SOUND_BRIM_CHARGE, 0.5, 0, false, 1)
                end
                state.charge = state.charge + 1
                if state.charge >= B26_DogmaStats.FEATHER_CHARGE then
                    local aim = input:Normalized()
                    for i = 1, B26_DogmaStats.FEATHER_COUNT do
                        local angle = (math.random() - 0.5) * B26_DogmaStats.FEATHER_SPREAD
                        local speed = B26_DogmaStats.FEATHER_SPEED * (0.7 + math.random() * 0.6)
                        local tear = player:FireTear(player.Position, aim:Rotated(angle) * speed, false, true, false, player, 1)
                        tear:ChangeVariant(B26_DogmaStats.FEATHER_VARIANT)
                        tear.Color = state.STATIC_COLOR
                        local tdata = tear:GetData()
                        tdata.DogmaFeather = true
                        tdata.DogmaStatic = true
                        tdata.StopFrame = frame + math.random(B26_DogmaStats.FEATHER_TRAVEL_MIN, B26_DogmaStats.FEATHER_TRAVEL_MAX)
                    end
                    sfx:Play(SOUND_FEATHERS, 0.8, 0, false, 1)
                    state.charge = 0
                    state.fired = true
                end
            elseif not held then
                state.charge = 0
                state.fired = false
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B26_Dogma.PeUpdate)

---@param tear EntityTear
    function B26_Dogma:TearUpdate(tear)
        local tdata = tear:GetData()
        if not tdata.DogmaFeather then
            return
        end
        local frame = game:GetFrameCount()
        if tdata.HoverUntil ~= nil then
            if frame >= tdata.HoverUntil then
                tear:Die()
                return
            end
            tear.Velocity = Vector.Zero
            tear.FallingSpeed = 0
            tear.FallingAcceleration = 0
        elseif frame >= tdata.StopFrame then
            tdata.HoverUntil = frame + B26_DogmaStats.FEATHER_HOVER
            tear.Velocity = Vector.Zero
            tear.FallingSpeed = 0
            tear.FallingAcceleration = 0
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, B26_Dogma.TearUpdate)

---@param pickup EntityPickup
    function B26_Dogma:HeartBlock(pickup, collider, low)
        local player = collider:ToPlayer()
        if player and player:GetName() == "B26_Dogma" then
            return false
        end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, B26_Dogma.HeartBlock, PickupVariant.PICKUP_HEART)

    function B26_Dogma:TakeDmg(entity, amount, flags, source, countdown)
        local player = entity:ToPlayer()
        if not player or player:GetName() ~= "B26_Dogma" then
            return
        end
        if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
            return
        end
        player:Die()
        return false
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, B26_Dogma.TakeDmg, EntityType.ENTITY_PLAYER)

    if ModCallbacks.MC_PRE_PLAYERHUD_RENDER_HEARTS ~= nil then
        function B26_Dogma:RenderHearts(offset, heartsSprite, position, unknown, player)
            if player ~= nil and player:GetName() == "B26_Dogma" then
                heartsSprite.Color = B26_DogmaStats.HEART_FADE
            else
                heartsSprite.Color = Color(1, 1, 1, 1, 0, 0, 0)
            end
        end
        mod:AddCallback(ModCallbacks.MC_PRE_PLAYERHUD_RENDER_HEARTS, B26_Dogma.RenderHearts)
    end

    local function renderStatic(position, scale)
        staticSprite.Scale = Vector(scale, scale)
        staticSprite:SetFrame("Idle", math.random(0, 3))
        staticSprite:Render(Isaac.WorldToScreen(position))
    end

    function B26_Dogma:RenderStaticOverlay()
        if state.form ~= "dogma" then
            return
        end
        if state.bodyPos ~= nil then
            renderStatic(state.bodyPos, 1.0)
        end
        for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_TEAR, -1, -1, false, false)) do
            if entity:GetData().DogmaStatic then
                local tear = entity:ToTear()
                renderStatic(tear.Position + Vector(0, tear.Height), 0.5)
            end
        end
        for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_LASER, -1, -1, false, false)) do
            if entity:GetData().DogmaStatic then
                local laser = entity:ToLaser()
                if laser.GetEndPoint ~= nil then
                    local delta = laser:GetEndPoint() - laser.Position
                    local steps = math.max(math.floor(delta:Length() / B26_DogmaStats.STATIC_SPACING), 1)
                    for i = 0, steps do
                        renderStatic(laser.Position + delta * (i / steps), 0.6)
                    end
                else
                    renderStatic(laser.Position, 0.6)
                end
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_RENDER, B26_Dogma.RenderStaticOverlay)

end

return B26_Dogma