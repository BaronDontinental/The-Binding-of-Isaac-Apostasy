-- vars
local mod = RegisterMod("Gomp", 1)
local json = require("json")
local game = Game()
local pool = game:GetItemPool()
require "scripts.constants"

if EID then
    EID:addCollectible(SPINUP_DICE, "Reroll all items in the room by increasing their ID by 1")
    EID:addCollectible(WEIGHTED_DICE, "Reroll items in the room by another items with the same quality at 85% or better quality at 15% (from all pools)")
    EID:addCollectible(SATANIC_DICE, "Reroll items to items from the devil deal pool but bosses will be stronger")
    EID:addCollectible(EDEN_DICE, "Reroll items to items from any pool")
    EID:addCollectible(FAMILIAR_DICE, "Reroll all your familiars by anothers familiars (only vanilla)")
end

function mod:useSpinupDice(type, rng, player, usedFlags, currentSlot, vars)
    local entities = Isaac.GetRoomEntities()
    player:AnimateCollectible(SPINUP_DICE, "UseItem", "PlayerPickupSparkle")

    for i=1, #entities do
        if entities[i].Variant == PickupVariant.PICKUP_COLLECTIBLE or entities[i].Variant == PickupVariant.PICKUP_SHOPITEM then
            local currentVariant = entities[i].Variant

            if entities[i].SubType ~= 0 then
                if entities[i].SubType ~= GetMaxItemID() then
                    local newID = entities[i].SubType + 1
                    local configNewID = Isaac.GetItemConfig():GetCollectible(newID)

                    if configNewID ~= nil then
                        while configNewID.hidden do
                            newID = newID + 1
                            configNewID = Isaac.GetItemConfig():GetCollectible(newID)
                        end
                        entities[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, currentVariant, newID, true)
                    else
                        while configNewID == nil do
                            newID = newID + 1
                            configNewID = Isaac.GetItemConfig():GetCollectible(newID)
                        end
                        entities[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, currentVariant, newID, true)
                    end
                else
                    entities[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, currentVariant, 1, true)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useSpinupDice, SPINUP_DICE)

function mod:useWeightedDice(type, rng, player, usedFlags, currentSlot, vars)
    local entities = Isaac.GetRoomEntities()
    player:AnimateCollectible(WEIGHTED_DICE, "UseItem", "PlayerPickupSparkle")

    for i=1, #entities do
        if entities[i].Variant == PickupVariant.PICKUP_COLLECTIBLE or entities[i].Variant == PickupVariant.PICKUP_SHOPITEM then
            local currentVariant = entities[i].Variant

            if entities[i].SubType ~= 0 then
                local oldID = entities[i].SubType
                local qualityDown = false
                local rand = GetNewID(1, 100, rng)

                local room = Game():GetLevel():GetCurrentRoom()
	                local pool = Game():GetItemPool():GetPoolForRoom(room:GetType(), room:GetAwardSeed())
	                    if pool == ItemPoolType.POOL_NULL then
	                       pool = ItemPoolType.POOL_TREASURE
	                    end

                local rerolledItem = Game():GetItemPool():GetCollectible(pool, true)
                local oldItemConfig = Isaac.GetItemConfig():GetCollectible(oldID)
                local newID = oldID
                local newItemConfig = Isaac.GetItemConfig():GetCollectible(rerolledItem)

                if  oldItemConfig.Quality > 0 then
                    qualityDown = true
                end

                if qualityDown then
                    while newItemConfig.Hidden or oldID == rerolledItem or newItemConfig.Quality ~= (oldItemConfig.Quality-1) do
                        newID = GetNewID(1, GetMaxItemID(), rng)
                        newItemConfig = Isaac.GetItemConfig():GetCollectible(rerolledItem)
                        while newItemConfig == nil do

                            newItemConfig = Isaac.GetItemConfig():GetCollectible(rerolledItem)
                        end
                    end
                    entities[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, currentVariant, rerolledItem, true)
                else
                    while newItemConfig.Hidden or oldID == newID or 4 ~= newItemConfig.Quality do
                        newID = GetNewID(1, GetMaxItemID(), rng)
                        newItemConfig = Isaac.GetItemConfig():GetCollectible(rerolledItem)
                        while newItemConfig == nil do

                            newItemConfig = Isaac.GetItemConfig():GetCollectible(rerolledItem)
                        end
                    end
                    entities[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, currentVariant, rerolledItem, true)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useWeightedDice, WEIGHTED_DICE)

function mod:useSatanicDice(type, rng, player, usedFlags, currentSlot, vars)
    local entities = Isaac.GetRoomEntities()
    player:AnimateCollectible(SATANIC_DICE, "UseItem", "PlayerPickupSparkle")
    for i=1, #entities do
        if entities[i].Variant == PickupVariant.PICKUP_COLLECTIBLE or entities[i].Variant == PickupVariant.PICKUP_SHOPITEM then
            local currentVariant = entities[i].Variant

            if entities[i].SubType ~= 0 then
                local oldID = entities[i].SubType
                local oldItemConfig = Isaac.GetItemConfig():GetCollectible(oldID)
                local newID = pool:GetCollectible(ItemPoolType.POOL_DEVIL)
                -- print(newID)
                if self.storage.numberSatanicDiceUsed == nil then
                    self.storage.numberSatanicDiceUsed = 0
                end
                self.storage.numberSatanicDiceUsed = self.storage.numberSatanicDiceUsed + 1
                self.storage.newChapterSatanicDice = false
                local currentStage = game:GetLevel():GetStage()
                local chapter = currentStage / 2
                if chapter <= 1 then
                    currentBosses = 0
                elseif chapter <= 2 then
                    currentBosses = 1
                elseif chapter <= 3 then
                    currentBosses = 2
                elseif chapter <= 4 then
                    currentBosses = 3
                else
                    currentBosses = 4
                end
                self.storage.lastUsedCurrentBosses = currentBosses
                entities[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, currentVariant, newID, true)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useSatanicDice, SATANIC_DICE)

function mod:spawnBossSatanicDice()
    local entities = Isaac.GetRoomEntities()
    local mustSpawn = false
    local currentStage = game:GetLevel():GetStage()
    local chapter = currentStage / 2
    local currentBosses = 0

    if chapter <= 1 then
        currentBosses = 0
    elseif chapter <= 2 then
        currentBosses = 1
    elseif chapter <= 3 then
        currentBosses = 2
    elseif chapter <= 4 then
        currentBosses = 3
    else
        currentBosses = 4
    end
    -- print("currentStage: " .. currentStage .. " - chapter: " .. chapter .. " - currentBosses" .. currentBosses)
    if self.storage.lastUsedCurrentBosses == nil then
        self.storage.lastUsedCurrentBosses = 0
    end
    if self.storage.newChapterSatanicDice == nil then
        self.storage.newChapterSatanicDice = 0
    end
    if self.storage.numberSatanicDiceUsed == nil then
        self.storage.numberSatanicDiceUsed = 0
    end
    if self.storage.lastUsedCurrentBosses < currentBosses then
        self.storage.newChapterSatanicDice = true
    end

    -- print("self.storage.newChapterSatanicDice: " .. self.storage.newChapterSatanicDice .. " - self.storage.lastUsedCurrentBosses:" .. self.storage.lastUsedCurrentBosses .. " - self.storage.numberSatanicDiceUsed:" .. self.storage.numberSatanicDiceUsed)

    if not self.storage.newChapterSatanicDice and self.storage.lastUsedCurrentBosses == currentBosses and self.storage.numberSatanicDiceUsed ~= nil and game:GetRoom():GetType() == RoomType.ROOM_BOSS and currentStage ~= 9 and currentStage ~= 12 and currentStage ~= 13 then
        for i=1, #entities do
            if entities[i]:IsBoss() then
                if currentStage ~= LevelStage.STAGE4_2 and currentStage ~= LevelStage.STAGE3_2 then
                    entities[i]:Remove()
                    mustSpawn = true
                end
            end
        end
        if mustSpawn then
            -- print ("numberSatanicDiceUsed: " .. self.storage.numberSatanicDiceUsed .. " - nextBoss: " .. SATANIC_DICE_BOSSES[currentBosses * 5 + self.storage.numberSatanicDiceUsed])
            if currentBosses * 5 + self.storage.numberSatanicDiceUsed > 20 then
                nextBoss = EntityType.ENTITY_THE_LAMB
            else
                nextBoss = SATANIC_DICE_BOSSES[currentBosses * 5 + self.storage.numberSatanicDiceUsed]
            end

            if nextBoss == EntityType.ENTITY_PEEP then
                Isaac.Spawn(nextBoss, 1, 0, game:GetRoom():GetCenterPos(), Vector(0,0), nil)
            else
                Isaac.Spawn(nextBoss, 0, 0, game:GetRoom():GetCenterPos(), Vector(0,0), nil)
            end
            mustSpawn = false
            -- self.storage.numberSatanicDiceUsed = self.storage.numberSatanicDiceUsed + 1
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.spawnBossSatanicDice)

function mod:useEdenDice(type, rng, player, usedFlags, currentSlot, vars)
    local entities = Isaac.GetRoomEntities()
    player:AnimateCollectible(EDEN_DICE, "UseItem", "PlayerPickupSparkle")

    for i=1, #entities do
        if entities[i].Variant == PickupVariant.PICKUP_COLLECTIBLE or entities[i].Variant == PickupVariant.PICKUP_SHOPITEM then
            local currentVariant = entities[i].Variant

            if entities[i].SubType ~= 0 then
                local oldID = entities[i].SubType
                local qualityUp = false
                local oldItemConfig = Isaac.GetItemConfig():GetCollectible(oldID)
                local newID = oldID
                local newItemConfig = Isaac.GetItemConfig():GetCollectible(oldID)

                while newItemConfig.Hidden or oldID == newID do
                    newID = GetNewID(1, GetMaxItemID(), rng)
                    newItemConfig = Isaac.GetItemConfig():GetCollectible(newID)
                    while newItemConfig == nil do
                        newID = GetNewID(1, GetMaxItemID(), rng)
                        newItemConfig = Isaac.GetItemConfig():GetCollectible(newID)
                    end
                end
                entities[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, currentVariant, newID, true)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useEdenDice, EDEN_DICE)

function mod:useFamiliarDice(type, rng, player, usedFlags, currentSlot, vars)
    player:AnimateCollectible(FAMILIAR_DICE, "UseItem", "PlayerPickupSparkle")

    for i=1, #FAMILIARS do
        if player:HasCollectible(FAMILIARS[i]) then
            player:RemoveCollectible(FAMILIARS[i], false, ActiveSlot.SLOT_PRIMARY, true)
            local rand = GetNewID(1, 121, rng)
            player:AddCollectible(FAMILIARS[rand])
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useFamiliarDice, FAMILIAR_DICE)

function mod:init(_, isContinued)
    if mod:HasData() then
        local tempstorage = json.decode(mod:LoadData())
        mod:RemoveData()
        -- self.storage.notches = tempstorage.notches
        mod:SaveData(json.encode(self.storage))
    end

    if not isContinued then
        self.storage.numberSatanicDiceUsed = 0
        self.storage.lastUsedCurrentBosses = 0
        self.storage.newChapterSatanicDice = 0
    end
end

function mod:exit()
    if self.storage then
        mod:SaveData(json.encode(self.storage))
    end
end

function mod:initStore()
    self.storage = {}
end

function GetMaxItemID()
    return Isaac.GetItemConfig():GetCollectibles().Size - 1
end

function GetNewID(min, max, rng)
    if type(rng) == "number" then
        local seed = rng
        rng = RNG()
        rng:SetSeed(seed, 1)
    end

    return rng:Next() % (max - min + 1) + min
end

mod:initStore()
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.init);
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.exit);


local useCustomErrorChecker = false -- should the custom error checker be used?

-- file loc
local suc, err = pcall(require, "")
local modName = err:match("/mods/(.*)/%.lua")
local path = "mods/" .. modName .. "/"

local function loadFile(loc, ...)
  return assert(loadfile(path .. loc .. ".lua"))(...)
end

local status, ogerr = pcall(function()
  local stats = loadFile("mod/stats")
  local imports = loadFile("mod/imports")
  loadFile("mod/MainMod",{modName, path, loadFile, stats, imports, useCustomErrorChecker})
end)

if (ogerr) then
  if (useCustomErrorChecker) then
    local errorChecker = loadFile("lib/cerror")

    errorChecker.mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(_, IsContin)
      local room = Game():GetRoom()

      for i = 0, 8 do
        room:RemoveDoor(i)
      end

      Game():GetHUD():SetVisible(false)
    end)

    local str = errorChecker.formatError(ogerr)

    if (str) then
      local file = str:match("%w+%.lua")
      local line = str:match(":(%d+):")
      local err = str:match(":%d+: (.*)")
      errorChecker.out(modName .. " has hit an error:")
      errorChecker.out("File:", file)
      errorChecker.out("Line:", line)
      errorChecker.out("Error:", err)
      errorChecker.out("For full error report, open log.txt")
      errorChecker.out("Log Root: C:\\Users\\<YOUR USER>\\Documents\\")
      errorChecker.out("My Games\\Binding of Isaac Repentance\\log.txt")
      errorChecker.out("")
      errorChecker.out("Reload the mod, then start a new run")
      errorChecker.out("Holding R works")
    else
      errorChecker.out("Unexpected error occured, please open log.txt!")
      errorChecker.out("Log Root: C:\\Users\\<YOUR USER>\\Documents\\")
      errorChecker.out("My Games\\Binding of Isaac Repentance\\log.txt")
      errorChecker.out("")
      errorChecker.out(ogerr)
    end
    Isaac.DebugString("-- START OF " .. modName:upper() .. " ERROR --")
    Isaac.DebugString(ogerr)
    Isaac.DebugString("-- END OF " .. modName:upper() .. " ERROR --")

    local room = Game():GetRoom()

    for i = 0, 8 do
      room:RemoveDoor(i)
    end

    Game():GetHUD():SetVisible(false)

    error()
  else
    Isaac.ConsoleOutput(modName .. " has hit an error, see Log.txt for more info\n")
    Isaac.ConsoleOutput("Log Root: C:\\Users\\<YOUR USER>\\Documents\\My Games\\Binding of Isaac Repentance\\log.txt")
    Isaac.DebugString("-- START OF " .. modName:upper() .. " ERROR --")
    Isaac.DebugString(ogerr)
    Isaac.DebugString("-- END OF " .. modName:upper() .. " ERROR --")
    error()
  end
end
