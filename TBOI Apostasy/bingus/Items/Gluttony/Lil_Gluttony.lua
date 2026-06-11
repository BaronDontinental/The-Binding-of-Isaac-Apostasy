local Lil_Gluttony = {}
local game = Game()

mod.COLLECTIBLE_LIL_GLUTTONY = Isaac.GetItemIdByName("Lil Gluttony")
CollectibleType.COLLECTIBLE_LIL_GLUTTONY = Isaac.GetItemIdByName("Lil Gluttony")
FAMILIAR_GLUTTONY_VARIANT = Isaac.GetEntityVariantByName("LIL_GLUTTONY")

local CONFIG_LILGLUTTONY = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LIL_GLUTTONY)

-- How many full red hearts Lil Gluttony has to eat before he drops a food
-- item. Dark Bum pays out at 1.5 hearts, Lil Gluttony is greedier.
local HEARTS_PER_DROP = 6

-- How close (in pixels) a heart has to be before he eats it
local EAT_RANGE = 25

-- How fast he waddles toward a heart he has his eye on
local SEEK_SPEED = 3.5

-- Dark Bum's chuckle (vanilla sound 853, named by REPENTOGON). It is the
-- only bum sound in the game, vanilla plays it on payout.
local EAT_SOUND = SoundEffect.SOUND_VAMP_GULP

-- The HP up food items he can drop, picked at random
local FOOD_ITEMS = {
    CollectibleType.COLLECTIBLE_LUNCH,
    CollectibleType.COLLECTIBLE_DINNER,
    CollectibleType.COLLECTIBLE_DESSERT,
    CollectibleType.COLLECTIBLE_BREAKFAST,
    CollectibleType.COLLECTIBLE_ROTTEN_MEAT,
    CollectibleType.COLLECTIBLE_MIDNIGHT_SNACK,
    CollectibleType.COLLECTIBLE_SNACK,
}

-- Heart pickups he can eat, valued in half hearts. Soul, black, bone and
-- the other non red hearts are left for the player.
local HEART_VALUES = {
    [HeartSubType.HEART_FULL] = 2,
    [HeartSubType.HEART_HALF] = 1,
    [HeartSubType.HEART_DOUBLEPACK] = 4,
    [HeartSubType.HEART_SCARED] = 2,
    [HeartSubType.HEART_BLENDED] = 2,
    [HeartSubType.HEART_ROTTEN] = 2,
}

local RNG_SHIFT_INDEX = 35

function Lil_Gluttony:postUpdate()

---@param player EntityPlayer
    function Lil_Gluttony:OnCache(player)
        local effect = player:GetEffects()
        local count = effect:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_LIL_GLUTTONY) + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LIL_GLUTTONY)
        local rng = RNG()
        local seed = math.max(Random(), 1)
        rng:SetSeed(seed, RNG_SHIFT_INDEX)
        player:CheckFamiliar(FAMILIAR_GLUTTONY_VARIANT, count, rng, CONFIG_LILGLUTTONY)
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Lil_Gluttony.OnCache, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
    function Lil_Gluttony:init(familiar)
        familiar:AddToFollowers()
        familiar:GetSprite():Play("FloatDown", true)
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Lil_Gluttony.init, FAMILIAR_GLUTTONY_VARIANT)

---@param familiar EntityFamiliar
    function Lil_Gluttony:UpdateFam(familiar)
        local sprite = familiar:GetSprite()

        -- Find the nearest red heart in the room, like the vanilla bums he
        -- goes after hearts anywhere, not just the ones that come to him
        local target = nil
        local targetDistance = 0
        for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, -1, false, false)) do
            local heart = entity:ToPickup()
            if heart and heart:Exists() and HEART_VALUES[heart.SubType] and heart.Price == 0 then
                local distance = heart.Position:Distance(familiar.Position)
                if target == nil or distance < targetDistance then
                    target = heart
                    targetDistance = distance
                end
            end
        end

        -- Eat the heart when on top of it, otherwise waddle toward it. With
        -- no heart in sight he falls back in line behind the player.
        -- Progress is stored in half hearts on the familiar's Coins field,
        -- the same one the bum familiars use, so it sticks to each Lil
        -- Gluttony individually.
        if target ~= nil and targetDistance <= EAT_RANGE then
            if target.Wait <= 0 then
                familiar.Coins = familiar.Coins + HEART_VALUES[target.SubType]
                target:Remove()
                SFXManager():Play(EAT_SOUND, 1, 0, false, 1)
            end
            familiar.Velocity = Vector.Zero
        elseif target ~= nil then
            -- Ease toward the heart instead of snapping, gives the waddle a
            -- bit of weight like the vanilla bums
            local wanted = (target.Position - familiar.Position):Normalized() * SEEK_SPEED
            familiar.Velocity = familiar.Velocity * 0.8 + wanted * 0.2
        else
            familiar:FollowParent()
        end

        -- Ate enough, cough up a random food item
        if familiar.Coins >= HEARTS_PER_DROP * 2 then
            familiar.Coins = familiar.Coins - HEARTS_PER_DROP * 2
            local rng = RNG()
            rng:SetSeed(math.max(Random(), 1), RNG_SHIFT_INDEX)
            local foodId = FOOD_ITEMS[rng:RandomInt(#FOOD_ITEMS) + 1]
            local pos = game:GetRoom():FindFreePickupSpawnPosition(familiar.Position, 0, true)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, foodId, pos, Vector.Zero, nil)
            SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND, 1, 0, false, 1)
        end

        if sprite:IsFinished() then
            sprite:Play("FloatDown", true)
        end
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lil_Gluttony.UpdateFam, FAMILIAR_GLUTTONY_VARIANT)

end

return Lil_Gluttony