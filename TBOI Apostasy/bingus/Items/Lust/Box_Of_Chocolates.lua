local Box_Of_Chocolates = {}
local game = Game()

mod.COLLECTIBLE_BOX_OF_CHOCOLATES = Isaac.GetItemIdByName("Box of Chocolates")
CollectibleType.COLLECTIBLE_BOX_OF_CHOCOLATES = Isaac.GetItemIdByName("Box of Chocolates")

local SETTINGS = {
    KEEP_HALF_HEARTS = 2,           
    PAYOUT_PER_HALF_HEART = 0.5,    
    MULT_MIN = 0.75,               
    MULT_MAX = 1.5,
    FLAT_MIN = 0,                   
    FLAT_MAX = 1,
    JACKPOT_CHANCE = 0.05,          
    JACKPOT_BONUS = 3,
    MIN_PAYOUT = 1,                 
    MAX_PAYOUT = 15,
    PILL_CHANCE = 0.5,              
    SPAWN_SPEED_MIN = 2,            
    SPAWN_SPEED_MAX = 5,
}

local ONLY_CARD_ITEMS = {
    CollectibleType.COLLECTIBLE_STARTER_DECK,
}
local ONLY_PILL_ITEMS = {
    CollectibleType.COLLECTIBLE_LITTLE_BAGGY,
}

local TAROT_CARDS = {
    Card.CARD_FOOL, Card.CARD_MAGICIAN, Card.CARD_HIGH_PRIESTESS, Card.CARD_EMPRESS, Card.CARD_EMPEROR,
    Card.CARD_HIEROPHANT, Card.CARD_LOVERS, Card.CARD_CHARIOT, Card.CARD_JUSTICE, Card.CARD_HERMIT,
    Card.CARD_WHEEL_OF_FORTUNE, Card.CARD_STRENGTH, Card.CARD_HANGED_MAN, Card.CARD_DEATH, Card.CARD_TEMPERANCE,
    Card.CARD_DEVIL, Card.CARD_TOWER, Card.CARD_STARS, Card.CARD_MOON, Card.CARD_SUN,
    Card.CARD_JUDGEMENT, Card.CARD_WORLD,
}

local REVERSE_TAROT_CARDS = {
    Card.CARD_REVERSE_FOOL, Card.CARD_REVERSE_MAGICIAN, Card.CARD_REVERSE_HIGH_PRIESTESS, Card.CARD_REVERSE_EMPRESS, Card.CARD_REVERSE_EMPEROR,
    Card.CARD_REVERSE_HIEROPHANT, Card.CARD_REVERSE_LOVERS, Card.CARD_REVERSE_CHARIOT, Card.CARD_REVERSE_JUSTICE, Card.CARD_REVERSE_HERMIT,
    Card.CARD_REVERSE_WHEEL_OF_FORTUNE, Card.CARD_REVERSE_STRENGTH, Card.CARD_REVERSE_HANGED_MAN, Card.CARD_REVERSE_DEATH, Card.CARD_REVERSE_TEMPERANCE,
    Card.CARD_REVERSE_DEVIL, Card.CARD_REVERSE_TOWER, Card.CARD_REVERSE_STARS, Card.CARD_REVERSE_MOON, Card.CARD_REVERSE_SUN,
    Card.CARD_REVERSE_JUDGEMENT, Card.CARD_REVERSE_WORLD,
}

local FACE_CARDS = {
    Card.CARD_CLUBS_2, Card.CARD_DIAMONDS_2, Card.CARD_SPADES_2, Card.CARD_HEARTS_2,
    Card.CARD_ACE_OF_CLUBS, Card.CARD_ACE_OF_DIAMONDS, Card.CARD_ACE_OF_SPADES, Card.CARD_ACE_OF_HEARTS,
    Card.CARD_JOKER, Card.CARD_QUEEN_OF_HEARTS,
}

local SPECIAL_CARDS = {
    Card.CARD_CHAOS, Card.CARD_CREDIT, Card.CARD_RULES, Card.CARD_HUMANITY, Card.CARD_SUICIDE_KING,
    Card.CARD_GET_OUT_OF_JAIL, Card.CARD_QUESTIONMARK, Card.CARD_DICE_SHARD, Card.CARD_EMERGENCY_CONTACT, Card.CARD_HOLY,
    Card.CARD_HUGE_GROWTH, Card.CARD_ANCIENT_RECALL, Card.CARD_ERA_WALK, Card.CARD_CRACKED_KEY, Card.CARD_WILD,
}

local RUNES = {
    Card.RUNE_HAGALAZ, Card.RUNE_JERA, Card.RUNE_EHWAZ, Card.RUNE_DAGAZ, Card.RUNE_ANSUZ,
    Card.RUNE_PERTHRO, Card.RUNE_BERKANO, Card.RUNE_ALGIZ, Card.RUNE_BLANK, Card.RUNE_BLACK,
}

local SOUL_STONES = {
    Card.CARD_SOUL_ISAAC, Card.CARD_SOUL_MAGDALENE, Card.CARD_SOUL_CAIN, Card.CARD_SOUL_JUDAS, Card.CARD_SOUL_BLUEBABY,
    Card.CARD_SOUL_EVE, Card.CARD_SOUL_SAMSON, Card.CARD_SOUL_AZAZEL, Card.CARD_SOUL_LAZARUS, Card.CARD_SOUL_EDEN,
    Card.CARD_SOUL_LOST, Card.CARD_SOUL_LILITH, Card.CARD_SOUL_KEEPER, Card.CARD_SOUL_APOLLYON, Card.CARD_SOUL_FORGOTTEN,
    Card.CARD_SOUL_BETHANY, Card.CARD_SOUL_JACOB,
}

local NORMAL_PILLS = {
    PillColor.PILL_BLUE_BLUE, PillColor.PILL_WHITE_BLUE, PillColor.PILL_ORANGE_ORANGE, PillColor.PILL_WHITE_WHITE,
    PillColor.PILL_REDDOTS_RED, PillColor.PILL_PINK_RED, PillColor.PILL_BLUE_CADETBLUE, PillColor.PILL_YELLOW_ORANGE,
    PillColor.PILL_ORANGEDOTS_WHITE, PillColor.PILL_WHITE_AZURE, PillColor.PILL_BLACK_YELLOW, PillColor.PILL_WHITE_BLACK,
    PillColor.PILL_WHITE_YELLOW,
}

local GOLD_PILLS = {
    PillColor.PILL_GOLD,
}

local CARD_GROUPS = {
    { Weight = 66.66, Pool = TAROT_CARDS },           --3.03% each
    { Weight = 11.22, Pool = REVERSE_TAROT_CARDS },   --0.51% each
    { Weight = 8.60,  Pool = FACE_CARDS },            --0.86% each
    { Weight = 4.05,  Pool = SPECIAL_CARDS },         --0.27% each
    { Weight = 3.60,  Pool = RUNES },                 --0.36% each
    { Weight = 5.95,  Pool = SOUL_STONES },           --0.35% each
}

local PILL_GROUPS = {
    { Weight = 97.86, Pool = NORMAL_PILLS },                  --7.53% each
    { Weight = 0.70,  Pool = GOLD_PILLS },
    { Weight = 1.43,  Pool = NORMAL_PILLS, Horse = true },    --0.11% each
    { Weight = 0.01,  Pool = GOLD_PILLS,   Horse = true },
}

local function anyoneHasItem(items)
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        for _, item in ipairs(items) do
            if player:HasCollectible(item) then
                return true
            end
        end
    end
    return false
end

local function getPillChance()
    local onlyCards = anyoneHasItem(ONLY_CARD_ITEMS)
    local onlyPills = anyoneHasItem(ONLY_PILL_ITEMS)
    if onlyCards and not onlyPills then
        return 0
    elseif onlyPills and not onlyCards then
        return 1
    end
    return SETTINGS.PILL_CHANCE
end

---@param rng RNG
local function rollPayout(rng, halfHeartsPaid)
    local mult = SETTINGS.MULT_MIN + rng:RandomFloat() * (SETTINGS.MULT_MAX - SETTINGS.MULT_MIN)
    local flat = SETTINGS.FLAT_MIN + rng:RandomInt(SETTINGS.FLAT_MAX - SETTINGS.FLAT_MIN + 1)
    local amount = halfHeartsPaid * SETTINGS.PAYOUT_PER_HALF_HEART * mult + flat

    local payout = math.floor(amount)
    if rng:RandomFloat() < amount - payout then
        payout = payout + 1
    end
    if rng:RandomFloat() < SETTINGS.JACKPOT_CHANCE then
        payout = payout + SETTINGS.JACKPOT_BONUS
    end
    return math.max(SETTINGS.MIN_PAYOUT, math.min(payout, SETTINGS.MAX_PAYOUT))
end

---@param rng RNG
local function rollGroup(rng, groups)
    local totalWeight = 0
    for _, group in ipairs(groups) do
        totalWeight = totalWeight + group.Weight
    end

    local roll = rng:RandomFloat() * totalWeight
    for _, group in ipairs(groups) do
        if roll < group.Weight then
            return group
        end
        roll = roll - group.Weight
    end
    return groups[#groups]
end

---@param rng RNG
local function rollConsumable(rng, pillChance)
    if rng:RandomFloat() < pillChance then
        local group = rollGroup(rng, PILL_GROUPS)
        local pill = group.Pool[rng:RandomInt(#group.Pool) + 1]
        if group.Horse then
            pill = pill | PillColor.PILL_GIANT_FLAG
        end
        return PickupVariant.PICKUP_PILL, pill
    end

    local group = rollGroup(rng, CARD_GROUPS)
    return PickupVariant.PICKUP_TAROTCARD, group.Pool[rng:RandomInt(#group.Pool) + 1]
end

function Box_Of_Chocolates:postUpdate()

---@param player EntityPlayer
    function Box_Of_Chocolates:onUse(item, rng, player, useFlags, slot, varData)
        local halfHeartsPaid = player:GetHearts() - SETTINGS.KEEP_HALF_HEARTS
        if halfHeartsPaid <= 0 then
            SFXManager():Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ, 1, 0, false, 1)
            return { Discharge = false, Remove = false, ShowAnim = false }
        end

        player:AddHearts(-halfHeartsPaid)
        SFXManager():Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)

        local pillChance = getPillChance()
        local payout = rollPayout(rng, halfHeartsPaid)
        for _ = 1, payout do
            local variant, subType = rollConsumable(rng, pillChance)
            local speed = SETTINGS.SPAWN_SPEED_MIN + rng:RandomFloat() * (SETTINGS.SPAWN_SPEED_MAX - SETTINGS.SPAWN_SPEED_MIN)
            local velocity = Vector.FromAngle(rng:RandomInt(360)) * speed
            game:Spawn(EntityType.ENTITY_PICKUP, variant, player.Position, velocity, player, subType, rng:Next())
        end
        return true
    end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Box_Of_Chocolates.onUse, CollectibleType.COLLECTIBLE_BOX_OF_CHOCOLATES)

end

return Box_Of_Chocolates
