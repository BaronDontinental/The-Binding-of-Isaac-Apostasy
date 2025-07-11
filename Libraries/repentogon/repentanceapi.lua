---@meta
---@version 1.12.1
---@diagnostic disable: missing-return, duplicate-doc-alias

---@class PathFinder
local PathFinder = {}

---@param TargetPos Vector
function PathFinder:EvadeTarget(TargetPos)
end

---@param Pos Vector
---@param Speed number
---@param PathMarker integer
---@param UseDirectPath boolean
function PathFinder:FindGridPath(Pos, Speed, PathMarker, UseDirectPath)
end

---@return integer
function PathFinder:GetEvadeMovementCountdown()
end

---@return integer
function PathFinder:GetGridIndex()
end

---@return boolean
function PathFinder:HasDirectPath()
end

---@param Pos Vector
---@param IgnorePoop boolean
---@return boolean
function PathFinder:HasPathToPos(Pos, IgnorePoop)
end

---@param IgnoreStatusEffects boolean
---@return boolean
function PathFinder:MoveRandomly(IgnoreStatusEffects)
end

---@param Speed number
---@param IgnoreStatusEffects boolean
function PathFinder:MoveRandomlyAxisAligned(Speed, IgnoreStatusEffects)
end

---@param IgnoreStatusEffects boolean
function PathFinder:MoveRandomlyBoss(IgnoreStatusEffects)
end

function PathFinder:Reset()
end

function PathFinder:ResetMovementTarget()
end

---@param value boolean
function PathFinder:SetCanCrushRocks(value)
end

function PathFinder:UpdateGridIndex()
end



---@class RoomConfig_Entry
---@field Subtype integer
---@field Type EntityType
---@field Variant integer
---@field Weight number
local RoomConfigEntry = {}



---@class TemporaryEffect
---@field Cooldown integer
---@field Count integer
---@field Item ItemConfigItem
local TemporaryEffect = {}


---@class ItemPool
local ItemPool = {}

---@param Add integer
---@param PoolType ItemPoolType
function ItemPool:AddBibleUpgrade(Add, PoolType)
end

---@param Item CollectibleType
function ItemPool:AddRoomBlacklist(Item)
end

---@param ID PillEffect
---@return PillColor
function ItemPool:ForceAddPillEffect(ID)
end

---@param Seed integer
---@param Playing boolean
---@param Rune boolean
---@param OnlyRunes boolean
---@return Card
function ItemPool:GetCard(Seed, Playing, Rune, OnlyRunes)
end

---@return ItemPoolType
function ItemPool:GetLastPool()
end

---@param Seed integer
---@return PillColor
function ItemPool:GetPill(Seed)
end

---@param PillColor PillColor
---@param Player? EntityPlayer @default: `nil`
---@return PillEffect
function ItemPool:GetPillEffect(PillColor, Player)
end

---@param RoomType RoomType
---@param Seed integer
---@return ItemPoolType
function ItemPool:GetPoolForRoom(RoomType, Seed)
end

---@param DontAdvanceRNG? boolean @default: `false`
---@return TrinketType
function ItemPool:GetTrinket(DontAdvanceRNG)
end

---@param PillColor PillColor
function ItemPool:IdentifyPill(PillColor)
end

---@param PillColor PillColor
---@return boolean
function ItemPool:IsPillIdentified(PillColor)
end

---@param Collectible CollectibleType
---@return boolean
function ItemPool:RemoveCollectible(Collectible)
end

---@param Trinket TrinketType
---@return boolean
function ItemPool:RemoveTrinket(Trinket)
end

function ItemPool:ResetRoomBlacklist()
end

function ItemPool:ResetTrinkets()
end


---@param PoolType ItemPoolType
---@param Decrease? boolean @default: `false`
---@param Seed? integer @default: `Random()`
---@param DefaultItem? CollectibleType @default: `CollectibleType.COLLECTIBLE_NULL`
---@param Flags? GetCollectibleFlag @default: `0`
---@return CollectibleType
function ItemPool:GetCollectible(PoolType, Decrease, Seed, DefaultItem, Flags)
end

---Returns true if the collectible can be spawned.
---@param collectible CollectibleType
---@param ignoreLocked boolean If set to `true`, this function will return true for items that could appear but are locked behind achievements.
---@return boolean canSpawn Will still return `false` if the item was removed from the item pool or if it can't appear because other effects (Tainted Lost offensive items mechanic or NO! trinket effect).
function ItemPool:CanSpawnCollectible(collectible, ignoreLocked)
end

---More sophisticated version of `ItemPool:GetCard` that allows individual chances to be defined.
---@param seed integer
---@param specialChance integer
---@param runeChance integer
---@param suitChance integer
---@param allowNonCards boolean
---@return Card
function ItemPool:GetCardEx(seed, specialChance, runeChance, suitChance, allowNonCards)
end

---Returns a collectible from a list.
---@param collectibles CollectibleType[] The collectibles to choose from.
---@param seed? integer @default: `Random`. The seed to use.
---@param defaultItem CollectibleType? @default: `CollectibleType.COLLECTIBLE_BREAKFAST`. The default item to resort to.
---@param addToBlacklist? boolean @default: `true`. If `true`, the collectible is added to the blacklist and can't normally spawn again.
---@param excludeLockedItems? boolean @default: `false`. If `true`, collectibles that haven't been unlocked yet can't be chosen.
---@return CollectibleType
function ItemPool:GetCollectibleFromList(collectibles, seed, defaultItem, addToBlacklist, excludeLockedItems)
end

---@class PoolRegistration
---@field decreaseBy number
---@field initialWeight number
---@field itemID CollectibleType
---@field removeOn number
---@field weight number

---Returns a table of registered collectibles in the pool.
---@param poolType ItemPoolType
---@return PoolRegistration[]
function ItemPool:GetCollectiblesFromPool(poolType)
end

---Returns the amount of trinkets available in the item pool.
---@return integer
function ItemPool:GetNumAvailableTrinkets()
end

---Returns a PillColor matching the specified PillEffect. Returns -1 if the effect is not in rotation.
---
---Currently not applied by pill modifications, such as PHD/False PHD.
---@param pillEffect PillEffect
---@return PillColor
function ItemPool:GetPillColor(pillEffect)
end

---@param rng RNG
---@param advancedSearch? boolean @default: false. Setting to `true` allows you to make use of the `filter` parameter.
---@param filter? ItemPoolType[] @default: {}. Normally acts as a blacklist of unwanted item pools, however setting `isWhitelist` to `true` turns it into a list from which to choose from.
---@param isWhitelist? boolean @default: false
function ItemPool:GetRandomPool(rng, advancedSearch, filter, isWhitelist)
end

---Returns a table of collectibles removed from all pools.
---@return CollectibleType[]
function ItemPool:GetRemovedCollectibles()
end

---Returns a table of room blacklisted collectibles.
---@return CollectibleType[]
function ItemPool:GetRoomBlacklistedCollectibles()
end

---Returns `true` if the collectible is available in item pools.
---@param collectible CollectibleType
---@return boolean
function ItemPool:HasCollectible(collectible)
end

---Returns `true` if the trinket is available in the trinket pool.
---@param trinket TrinketType
---@return boolean
function ItemPool:HasTrinket(trinket)
end

---Unidentifies a pill and returns it back to the unidentified (displaying as ???) state.
---@param pill PillColor
function ItemPool:UnidentifyPill(pill)
end

---@param poolType ItemPoolType
function ItemPool:GetBibleUpgrades(poolType)
end

---Retrieves the total number of itempools in the game, including custom itempools.
---@return integer
function ItemPool:GetNumItemPools()
end

---@class QueuedItemData
---@field Charge integer
---@field Item ItemConfigItem
---@field Touched boolean
local QueuedItemData = {}


---@class Options
---@field AnnouncerVoiceMode integer
---@field BulletVisibility boolean
---@field CameraStyle integer
---@field ChargeBars boolean
---@field ConsoleFont integer
---@field DisplayPopups boolean
---@field DebugConsoleEnabled boolean
---@field ExtraHUDStyle integer
---@field FadedConsoleDisplay boolean
---@field Filter boolean
---@field FoundHUD boolean
---@field Fullscreen boolean
---@field Gamma number
---@field HUDOffset number
---@field Language string
---@field MapOpacity number
---@field MaxRenderScale integer
---@field MaxScale integer
---@field MouseControl boolean
---@field MusicVolume number
---@field PauseOnFocusLost boolean
---@field RumbleEnabled boolean
---@field SaveCommandHistory boolean
---@field SFXVolume number
---@field UseBorderlessFullscreen boolean
---@field VSync boolean
---@field JacobEsauControls integer --Repentance Plus only. 0 for classic controls, 1 for better controls
_G.Options = {}


---@type boolean
Options.BetterVoidGeneration = nil
---@type boolean 
Options.HushPanicStateFix = nil
---@type boolean 
Options.KeyMasterDealChance = nil
---@type boolean 
Options.PreventModUpdates = nil
---@type boolean 
Options.QuickRoomClear = nil


---@class CppList
---@field Size integer
local CppList = {}

-- missing metamethod len as not supported for now

---@param idx integer
---@return any
function CppList:Get(idx)
end

---@class CppList_RoomDescriptor : CppList
local CppList_RoomDescriptor = {}

---@param idx integer
---@return RoomDescriptor
function CppList_RoomDescriptor:Get(idx)
end

---@class CppList_RoomConfigSpawn : CppList
local CppList_RoomConfigSpawn = {}

---@param idx integer
---@return RoomConfig_Spawn
function CppList_RoomConfigSpawn:Get(idx)
end

---@class CppList_RoomConfigEntries : CppList
local CppList_RoomConfigEntries = {}

---@param idx integer
---@return userdata
function CppList_RoomConfigEntries:Get(idx)
end

---@class EntityList : CppList
local EntityList = {}

---@param idx integer
---@return Entity
function EntityList:Get(idx)
end

---@class CardConfigList : CppList
local CardConfigList = {}

---@param idx integer
---@return ItemConfigCard
function CardConfigList:Get(idx)
end

---@class CostumeConfigList : CppList
local CostumeConfigList = {}

---@param idx integer
---@return ItemConfigCostume
function CostumeConfigList:Get(idx)
end

---@class EffectList : CppList
local EffectList = {}

---@param idx integer
---@return TemporaryEffect
function EffectList:Get(idx)
end

---@class ItemConfigList : CppList
local ItemConfigList = {}

---@param idx integer
---@return ItemConfigItem
function ItemConfigList:Get(idx)
end

---@class PillConfigList : CppList
local PillConfigList = {}

---@param idx integer
---@return ItemConfigPillEffect
function PillConfigList:Get(idx)
end

---@class VectorList : CppList
local VectorList = {}

---@param idx integer
---@return Vector
function VectorList:Get(idx)
end

---@class CppList_intValues : CppList
local CppList_intValues = {}


---@class RoomDescriptor
---@field AwardSeed integer
---@field ChallengeDone boolean
---@field Clear boolean
---@field ClearCount integer
---@field Data RoomConfigRoom
---@field DecorationSeed integer
---@field DeliriumDistance integer
---@field DisplayFlags integer
---@field Flags integer
---@field GridIndex integer
---@field HasWater boolean
---@field ListIndex integer
---@field NoReward boolean
---@field OverrideData RoomConfigRoom
---@field PitsCount integer
---@field PoopCount integer
---@field PressurePlatesTriggered boolean
---@field SacrificeDone boolean
---@field SafeGridIndex integer
---@field ShopItemDiscountIdx integer
---@field ShopItemIdx integer
---@field SpawnSeed integer
---@field SurpriseMiniboss boolean
---@field VisitedCount integer
local RoomDescriptor_Class = {}

---@class RoomDescriptorDoors

---@class RoomDescriptor
---Allows you to check which level grid index each DoorSlot in the room connects to.
---
---For example, roomdesc.Doors[DoorSlot.UP0] provides the level grid index that the upwards door would connect to.
---
---The value will be -1 if the RoomShape does not allow a door in that slot.
---
---Note that this typically provides a valid index even if there is no door present, and even if the room itself does not allow a door in that slot.
---@field Doors {[DoorSlot]: RoomDescriptorDoors}
---Returns a bitmask corresponding to which door slots are currently enabled.
---
---Doors are typically only included in this bitmask when there is a door currently present, even if the room would allow a door in that slot.
---@field AllowedDoors integer
---@field BossDeathSeed integer
local RoomDescriptor_RGON = {}

-- Note: in current emmylua, defining class twice to add fields to it is valid, as done above

---@param gridIndex integer
function RoomDescriptor_RGON:AddRestrictedGridIndex(gridIndex) end

---@return EntitiesSaveStateVector
function RoomDescriptor_RGON:GetGridEntitiesSaveState(gridIndex) end

---@return EntitiesSaveStateVector
function RoomDescriptor_RGON:GetEntitiesSaveState() end

---@return integer[]
function RoomDescriptor_RGON:GetRestrictedGridIndexes() end

---@param rng RNG
function RoomDescriptor_RGON:InitSeeds(rng)
end

---@return Dimension
function RoomDescriptor_RGON:GetDimension()
end

---@return {[DoorSlot]: RoomDescriptor}
function RoomDescriptor_RGON:GetNeighboringRooms()
end

-- Others (mostly constructors) are defined in their own files

---@param object any
---@return integer
function GetPtrHash(object)
end

---@return integer
function Random()
end

---@return Vector
function RandomVector()
end

---This global is `true` in Repentance DLC and `nil` in Afterbirth+
_G.REPENTANCE = true ---@type true|nil

---This global is `true` in Repentance+ DLC and `nil` in Afterbirth+ and Repentance
_G.REPENTANCE_PLUS = true ---@type true|nil


_G.include = require

---@class SFXManager
local SFXManager = {}

---@return SFXManager
function _G.SFXManager()
end

---@param ID SoundEffect
---@param Pitch number
function SFXManager:AdjustPitch(ID, Pitch)
end

---@param ID SoundEffect
---@param Volume number
function SFXManager:AdjustVolume(ID, Volume)
end

---@param ID SoundEffect
---@return number
function SFXManager:GetAmbientSoundVolume(ID)
end

---@param ID SoundEffect
---@return boolean
function SFXManager:IsPlaying(ID)
end

---@param ID SoundEffect
---@param Volume? number @default: `1`
---@param FrameDelay? integer @default: `2`
---@param Loop? boolean @default: `false`
---@param Pitch? number @default: `1`
---@param Pan? number @default: `0`
function SFXManager:Play(ID, Volume, FrameDelay, Loop, Pitch, Pan)
end

---@param ID SoundEffect
function SFXManager:Preload(ID)
end

---@param ID SoundEffect
---@param Volume number
---@param Pitch number
function SFXManager:SetAmbientSound(ID, Volume, Pitch)
end

---@param ID SoundEffect
function SFXManager:Stop(ID)
end

function SFXManager:StopLoopingSounds()
end


---@class Room
local Room = {}

---@param Index integer
---@param Damage integer
---@return boolean
function Room:DamageGrid(Index, Damage)
end

---@param Index integer
---@param Immediate boolean
---@return boolean
function Room:DestroyGrid(Index, Immediate)
end

---@param Duration integer
---@param Count integer
function Room:EmitBloodFromWalls(Duration, Count)
end

---@param Pos Vector
---@param InitialStep? number @default: `0`
---@param AvoidActiveEntities? boolean @default: `false`
---@param AllowPits? boolean @default: `false`
---@return Vector
function Room:FindFreePickupSpawnPosition(Pos, InitialStep, AvoidActiveEntities, AllowPits)
end

---@param Pos Vector
---@param DistanceThreshold number
---@return Vector
function Room:FindFreeTilePosition(Pos, DistanceThreshold)
end

---@return integer
function Room:GetAliveBossesCount()
end

---@return integer
function Room:GetAliveEnemiesCount()
end

---@return integer
function Room:GetAwardSeed()
end

---@return BackdropType
function Room:GetBackdropType()
end

---@return integer
function Room:GetBossID()
end

---@return Vector
function Room:GetBottomRightPos()
end

---@return integer
function Room:GetBrokenWatchState()
end

---@return Vector
function Room:GetCenterPos()
end

---@param Position Vector
---@return integer
function Room:GetClampedGridIndex(Position)
end

---@param Pos Vector
---@param Margin number
---@return Vector
function Room:GetClampedPosition(Pos, Margin)
end

---@return integer
function Room:GetDecorationSeed()
end

---@return integer
function Room:GetDeliriumDistance()
end

---@return number
function Room:GetDevilRoomChance()
end

---@param Slot DoorSlot
---@return GridEntityDoor
function Room:GetDoor(Slot)
end

---@param Slot DoorSlot
---@return Vector
function Room:GetDoorSlotPosition(Slot)
end

---@return integer
function Room:GetDungeonRockIdx()
end

---@return number
function Room:GetEnemyDamageInflicted()
end

---@return EntityList
function Room:GetEntities()
end

---@return integer
function Room:GetFrameCount()
end

---@param GridIndex integer
---@return GridCollisionClass
function Room:GetGridCollision(GridIndex)
end

---@param Pos Vector
---@return GridCollisionClass
function Room:GetGridCollisionAtPos(Pos)
end

---@param Index integer
---@return GridEntity
function Room:GetGridEntity(Index)
end

---@param Position Vector
---@return GridEntity
function Room:GetGridEntityFromPos(Position)
end

---@return integer
function Room:GetGridHeight()
end

---@param Position Vector
---@return integer
function Room:GetGridIndex(Position)
end

---GridPath values pseudo-enumeration:
---
---`900` : Set by some enemies when they pass through a tile. De-prioritises the tile for pathfinders. Degrades over time in steps of 100.
---
---`950` : Set by fire places. De-prioritises the tile for pathfinders. Does not degrade.
---
---`1000` : Set by grid entities. Invalidates the tile for pathfinders. Impedes grounded player movement. Does not degrade.
---
---`3000` : Set by pits. Invalidates the tile for pathfinders. Impedes grounded player movement. Does not degrade.
---
---`3999` : Set by grimaces. Invalidates the tile for pathfinders. Impedes grounded player movement. Drops to 900 and then degrades over time in steps of 100 (Grimaces reset value every frame).
---@param Index integer
---@return integer
function Room:GetGridPath(Index)
end

---GridPath values pseudo-enumeration:
---
---`900` : Set by some enemies when they pass through a tile. De-prioritises the tile for pathfinders. Degrades over time in steps of 100.
---
---`950` : Set by fire places. De-prioritises the tile for pathfinders. Does not degrade.
---
---`1000` : Set by grid entities. Invalidates the tile for pathfinders. Impedes grounded player movement. Does not degrade.
---
---`3000` : Set by pits. Invalidates the tile for pathfinders. Impedes grounded player movement. Does not degrade.
---
---`3999` : Set by grimaces. Invalidates the tile for pathfinders. Impedes grounded player movement. Drops to 900 and then degrades over time in steps of 100 (Grimaces reset value every frame).
---@param Position Vector
---@return integer
function Room:GetGridPathFromPos(Position)
end

---@param GridIndex integer
---@return Vector
function Room:GetGridPosition(GridIndex)
end

---@return integer
function Room:GetGridSize()
end

---@return integer
function Room:GetGridWidth()
end

---@param Pos Vector
---@param Dir Vector
---@return Vector
function Room:GetLaserTarget(Pos, Dir)
end

---@return number
function Room:GetLavaIntensity()
end

---@return number
function Room:GetLightingAlpha()
end

---@deprecated # Removed from the game! Keeping for old information
---@return integer
function Room:GetNextShockwaveId()
end

---@param Margin number
---@return Vector
function Room:GetRandomPosition(Margin)
end

---@param Seed integer
---@return integer
function Room:GetRandomTileIndex(Seed)
end

---@return boolean
function Room:GetRedHeartDamage()
end

---@return RenderMode
function Room:GetRenderMode()
end

---@return Vector
function Room:GetRenderScrollOffset()
end

---@return Vector
function Room:GetRenderSurfaceTopLeft()
end

---@return integer
function Room:GetRoomConfigStage()
end

---@return RoomShape
function Room:GetRoomShape()
end

---@return integer
function Room:GetSecondBossID()
end

---@param Seed integer
---@param noDecrease? boolean @default: `false`
---@return CollectibleType
function Room:GetSeededCollectible(Seed, noDecrease)
end

---@return integer
function Room:GetShopLevel()
end

---@return integer
function Room:GetSpawnSeed()
end

---@return integer
function Room:GetTintedRockIdx()
end

---@return Vector
function Room:GetTopLeftPos()
end

---@return RoomType
function Room:GetType()
end

---@return Vector
function Room:GetWaterCurrent()
end

---@return boolean
function Room:HasCurseMist()
end

---@return boolean
function Room:HasLava()
end

---@return boolean
function Room:HasSlowDown()
end

---@return boolean
function Room:HasTriggerPressurePlates()
end

---@return boolean
function Room:HasWater()
end

---@return boolean
function Room:HasWaterPits()
end

function Room:InvalidatePickupVision()
end

---@return boolean
function Room:IsAmbushActive()
end

---@return boolean
function Room:IsAmbushDone()
end

---@return boolean
function Room:IsClear()
end

---@return boolean
function Room:IsCurrentRoomLastBoss()
end

---@param Slot DoorSlot
---@return boolean
function Room:IsDoorSlotAllowed(Slot)
end

---@return boolean
function Room:IsFirstEnemyDead()
end

---@return boolean
function Room:IsFirstVisit()
end

---@return boolean
function Room:IsInitialized()
end

---@return boolean
function Room:IsLShapedRoom()
end

---@return boolean
function Room:IsMirrorWorld()
end

---@param Pos Vector
---@param Margin number
---@return boolean
function Room:IsPositionInRoom(Pos, Margin)
end

---@return boolean
function Room:IsSacrificeDone()
end

function Room:KeepDoorsClosed()
end

---@param Position Vector
function Room:MamaMegaExplosion(Position)
end

function Room:PlayMusic()
end

---@param Slot DoorSlot
function Room:RemoveDoor(Slot)
end


---`GridIndex` is the location of the grid as shown with the `debug 11` console command.
---`PathTrail` is the "cost" to leave behind on the square. In most cases, you would want to pass 0 for this argument.
---
---Note that after removing a grid entity, you cannot spawn another grid entity on the same tile until a frame has passed. If doing this is absolutely required, you can get around the restriction in two different ways:
---
---By calling the `Room:Update()` method between removing the old grid entity and spawning the new one, you can simulate a frame passing. However, this can have other unwanted side effects, so it is only recommended to do this as a last resort. Specifically, `Room:Update` will update every entity in the room, including the player, causing them to continue to move in the direction that they are already moving. Furthermore, if Room:Update is called in the PostNewRoom callback, it will still cause the player to drift, even though they are standing still. (This is because their velocity has not been zeroed out at time that the callback fires.)
---
---By calling `GridEntity:Update()` on the removed grid entity after it is removed, you will be able to immediately spawn another grid entity on the same tile. However, the new grid entity will be automatically removed at the end of the frame, so you must spawn it again on the next frame. This method can also lead to unwanted side effects, such as an explosion not destroying a rock properly (because it would be erronenously respawned on the subsequent frame).
---@param GridIndex integer
---@param PathTrail integer
---@param KeepDecoration boolean
function Room:RemoveGridEntity(GridIndex, PathTrail, KeepDecoration)
end

function Room:Render()
end

function Room:RespawnEnemies()
end

---@param Pos Vector
---@param Margin number
---@return Vector
function Room:ScreenWrapPosition(Pos, Margin)
end

---@param Value boolean
function Room:SetAmbushDone(Value)
end

---@param State integer
function Room:SetBrokenWatchState(State)
end

function Room:SetCardAgainstHumanity()
end

---@param Clear boolean
function Room:SetClear(Clear)
end

---@param Value boolean
function Room:SetFirstEnemyDead(Value)
end

---@param FloorColor Color
function Room:SetFloorColor(FloorColor)
end

---@param Index integer
---@param Value integer
---@return boolean
function Room:SetGridPath(Index, Value)
end

function Room:SetRedHeartDamage()
end

---@param Done boolean
function Room:SetSacrificeDone(Done)
end

---@deprecated # Removed from the game! Keeping for old information
---@param ShockwaveId integer
---@param Params unknown
function Room:SetShockwaveParam(ShockwaveId, Params)
end

---@param Duration integer
function Room:SetSlowDown(Duration)
end

---@param WallColor Color
function Room:SetWallColor(WallColor)
end

---@param KeepCollectibleIdx boolean
---@param ReselectSaleItem boolean
function Room:ShopReshuffle(KeepCollectibleIdx, ReselectSaleItem)
end

function Room:ShopRestockFull()
end

function Room:ShopRestockPartial()
end

function Room:SpawnClearAward()
end

function Room:StopRain()
end

---@param Silent? boolean @default: `false`
function Room:TriggerClear(Silent)
end

---@param pit GridEntity
---@param rock GridEntity
---@return boolean
function Room:TryMakeBridge(pit, rock)
end

---@param PlayerPos Vector
---@param PlayerVelocity Vector
---@param Ladder Entity
function Room:TryPlaceLadder(PlayerPos, PlayerVelocity, Ladder)
end

---@param FirstTime? boolean @default: `true`
---@param IgnoreTime? boolean @default: `false`
---@param Force? boolean @default: `false`
---@return boolean
function Room:TrySpawnBlueWombDoor(FirstTime, IgnoreTime, Force)
end

---@param IgnoreTime? boolean @default: `false`
---@param Force? boolean @default: `false`
---@return boolean
function Room:TrySpawnBossRushDoor(IgnoreTime, Force)
end

---@param Animate? boolean @default: `false`
---@param Force? boolean @default: `false`
---@return boolean
function Room:TrySpawnDevilRoomDoor(Animate, Force)
end

---@param Force? boolean @default: `false`
---@return boolean
function Room:TrySpawnMegaSatanRoomDoor(Force)
end

---@param Animate? boolean @default: `false`
---@param Force? boolean @default: `false`
---@return boolean
function Room:TrySpawnSecretExit(Animate, Force)
end

---@param Force? boolean @default: `false`
---@return boolean
function Room:TrySpawnSecretShop(Force)
end

---@param Force? boolean @default: `false`
---@return boolean
function Room:TrySpawnTheVoidDoor(Force)
end

function Room:TurnGold()
end

function Room:Update()
end

---@param WorldPos Vector
---@return Vector
function Room:WorldToScreenPosition(WorldPos)
end


---GridPath values pseudo-enumeration:
---
---`900` : Set by some enemies when they pass through a tile. De-prioritises the tile for pathfinders. Degrades over time in steps of 100.
---
---`950` : Set by fire places. De-prioritises the tile for pathfinders. Does not degrade.
---
---`1000` : Set by grid entities. Invalidates the tile for pathfinders. Impedes grounded player movement. Does not degrade.
---
---`3000` : Set by pits. Invalidates the tile for pathfinders. Impedes grounded player movement. Does not degrade.
---
---`3999` : Set by grimaces. Invalidates the tile for pathfinders. Impedes grounded player movement. Drops to 900 and then degrades over time in steps of 100 (Grimaces reset value every frame).
---@param Pos1 Vector
---@param Pos2 Vector
---@param Mode LineCheckMode
---@param GridPathThreshold? integer @default: `0`. See `GetGridPath` for GridPath values pseudo-enumeration.
---@param IgnoreWalls? boolean @default: `false`
---@param IgnoreCrushable? boolean @default: `false`
---@return boolean, Vector
function Room:CheckLine(Pos1, Pos2, Mode, GridPathThreshold, IgnoreWalls, IgnoreCrushable)
end

---Returns true if the grid entity at the given position can be picked up.
---@param gridIndex integer
---@return boolean
function Room:CanPickupGridEntity(gridIndex)
end

---TODO: Document me!
---@param gridIndex integer
---@param force boolean
---@return boolean
function Room:CanSpawnObstacleAtPosition(gridIndex, force)
end

---Creates a lightning effect as seen in Downpour.
---@param seed? integer @default: `RandomSeed`. Determines intensity (1.3 + RandomFloat()*.6) and sound pitch (0.9 + RandomFloat()*0.2)
function Room:DoLightningStrike(seed)
end

---@return Backdrop
function Room:GetBackdrop()
end

---@return Music
function Room:GetBossVictoryJingle()
end

---@return Camera
function Room:GetCamera()
end

---Returns the probability that boss spawns in this room will be champions.
---@return number
function Room:GetChampionBossChance()
end

---TODO: Document me!
---@return TemporaryEffects
function Room:GetEffects()
end

---@return Color
function Room:GetFloorColor()
end

---Returns the room's FXParams.
---@return FXParams
function Room:GetFXParams() end

---Returns the frames until the next greed wave spawns.
---@return integer --Returns `-1` if the timer is not active or you're not in Greed Mode
function Room:GetGreedWaveTimer() end

---Returns the grid index from the provided row and column.
---@param gridRow integer
---@param gridColumn integer
---@return integer --Returns `-1` if the function fails to find a valid grid index.
---@overload fun(self: Room, gridTable: {[1]: integer, [2]: integer})
function Room:GetGridIndexByTile(gridRow, gridColumn)
end

---Retrieves the pool the game would use to generate random collectibles in the current room. Unlike `ItemPool:GetPoolForRoom()`, this takes into account the pool set using SetItemPool(), and runs the game's pool selection code, which handles unique cases (ex. Boss Room + Used Satanic Bible = Devil Pool).
---@param Seed integer
---@param Raw? boolean @default: `false`. If set to true and the pool is set to `POOL_NULL` then `POOL_NULL` will be returned, instead of running the game's pool selection code.
---@return ItemPoolType
function Room:GetItemPool(Seed, Raw)
end

---Returns the intensity of the lightning effect used in Downpour. This variable will affect the visibility of Wraiths.
---
---This is set by the game in a random range between `1.3` and `2.1`, and decays by `value * .75` per render.
function Room:GetLightningIntensity()
end

---@return LRoomAreaDesc
function Room:GetLRoomAreaDesc()
end

---@return LRoomTileDesc
function Room:GetLRoomTileDesc()
end

---The number of areas in a room that spawn rain effects in a tight radius.
function Room:GetNumRainSpawners()
end

---Returns the rail variant at the grid index.
---@param gridIndex integer
---@return StbRailVariant
function Room:GetRail(gridIndex) end

---Returns the room's RailManager class.
---@return RailManager
function Room:GetRailManager()
end

---Used by the positional rain effect spawners in Downpour. No noticable effect beyond `1.0`.
function Room:GetRainIntensity()
end

---TODO: Document me!
---@return integer
function Room:GetRoomClearDelay() end

---Returns the price of the item.
---@param entityVariant integer
---@param entitySubType integer
---@param shopItemID integer
---@return integer
function Room:GetShopItemPrice(entityVariant, entitySubType, shopItemID)
end

---Returns the amount of water in the room.
---
---If the room has no water, 0 is returned. If the room is flooded, 1 is returned.
---
---It is possible for the value to be in between 0 and 1 and over 1.
---@return number
function Room:GetWaterAmount() end

---Returns the color of the water in the room.
---@return KColor
function Room:GetWaterColor() end

---Returns the room's water color multiplier.
---@return KColor
function Room:GetWaterColorMultiplier() end

---Returns true if boss spawns in the room will be champions.
---@return boolean
function Room:IsChampionBossSeed() end

---Returns true if the entity is persistent.
---@param type EntityType
---@param variant? integer @default: `0`.
---@return boolean
function Room:IsPersistentRoomEntity(type, variant)
end

---Tries to pick up the grid entity at the provided index and returns an effect of the picked up grid entity.
---@param gridIndex integer
---@return EntityEffect?
function Room:PickupGridEntity(gridIndex) end

--- Immediately removes the GridEntity at the given index. This means grids can be properly removed and immediately replaced, without the need to call `Room:Update()`.
---@param gridIndex integer
---@param pathTrail integer TODO: Document me!
---@param keepDecoration boolean TODO: Document me!
function Room:RemoveGridEntityImmediate(gridIndex, pathTrail, keepDecoration) end

--Saves the current state of the room
function Room:SaveState()
end

---Changes the room's backdrop.
---
---The backdrop variant chosen is seeded based on the room and does not persist when leaving and re-entering. Calling this function again on re-entry will result in the same backdrop variant as before.
---@param backdrop BackdropType
---@param unknown integer TODO: Document me! This function does not work if it's set to 0.
function Room:SetBackdropType(backdrop, unknown) end

---Sets the current time of the greed wave timer.
---@param time integer
function Room:SetGreedWaveTimer(time) end

---Sets the pool to use when the game needs to generate random collectibles in the current room. This takes priority over the game's regular pool selection code. Can be set to `POOL_NULL` to let the game handle pool selection. This is reset every room transition.
---@param PoolType ItemPoolType
function Room:SetItemPool(PoolType)
end

---This primarily affects `UpdateColorModifier` (if `Process` is true, an orange glow is added based on the number of pits and lava intensity).
---@param intensity number
function Room:SetLavalIntensity(intensity)
end

---Sets the intensity of the lightning effect used in Downpour. This variable will affect the visibility of Wraiths.
---
---This is set by the game in a random range between `1.3` and `2.1`, and decays by `value * .75` per render.
---@param intensity number
function Room:SetLightningIntensity(intensity)
end

---Sets the amount of drames the pause effect is activated for in the room.
---@param time integer
function Room:SetPauseTimer(time) end

---TODO: Document me!
---@param gridIndex integer
---@param railVariant StbRailVariant
function Room:SetRail(gridIndex, railVariant) end

---Used by the positional rain effect spawners in Downpour. No noticable effect beyond `1.0`.
---@param intensity number
function Room:SetRainIntensity(intensity)
end

---TODO: Document me!
---@param delay integer
function Room:SetRoomClearDelay(delay) end

---Sets the amount of water in the room.
---@param amount number
function Room:SetWaterAmount(amount) end

---@param waterColor KColor
function Room:SetWaterColor(waterColor) end

---Sets the room's water current velocity. The game will automatically add the sounds and particles.
---@param velocity Vector The velocity of the water current. Setting it to `Vector(0, 0)` will remove the water current.
function Room:SetWaterCurrent(velocity) end

---@param GridIndex integer
---@param Type GridEntityType
---@param Variant? integer
---@param Seed? integer
---@param VarData? integer
---@return boolean
---@overload fun(self: Room, GridIndex: integer, Descriptor: GridEntityDesc)
function Room:SpawnGridEntity(GridIndex, Type, Variant, Seed, VarData)
end

---@param shopItemIndex integer
---@param price integer
---@return integer
function Room:TryGetShopDiscount(shopItemIndex, price) end

---An `IgnoreStageType` parameter has been added to allow spawning the Mirror & Mineshaft door outside of `STAGETYPE_REPENTANCE` and `STAGETYPE_REPENTANCE_B` stages. Note that the `KNIFE_PUZZLE` dimension must be set up properly for these doors not to crash on entry!
---@param IgnoreStageType? boolean @default: `false`
function Room:TrySpawnSpecialQuestDoor(IgnoreStageType)
end

---@param process boolean
---@param lerp boolean
---@param rate? number @default: `0.015`.
function Room:UpdateColorModifier(process, lerp, rate) end


---@class Color
---@field A number
---@field B number
---@field BO number
---@field G number
---@field GO number
---@field R number
---@field RO number
---@operator mul(Color): Color
local Color = {}

---@param m1 Color
---@param m2 Color
---@param t number
---@return Color
function _G.Color.Lerp(m1, m2, t)
end

function Color:Reset()
end

---@param Red number
---@param Green number
---@param Blue number
---@param Amount number
function Color:SetColorize(Red, Green, Blue, Amount)
end

---@param RedOffset number
---@param GreenOffset number
---@param BlueOffset number
function Color:SetOffset(RedOffset, GreenOffset, BlueOffset)
end

---@param RedTint number
---@param GreenTint number
---@param BlueTint number
---@param AlphaTint number
function Color:SetTint(RedTint, GreenTint, BlueTint, AlphaTint)
end

_G.Color = {
	---@type Color
	Default = Color(1,1,1,1)
}

---@param R? number @default: `1`
---@param G? number @default: `1`
---@param B? number @default: `1`
---@param A? number @default: `1`
---@param RO? number @default: `0`
---@param GO? number @default: `0`
---@param BO? number @default: `0`
---@param RC? number @default: `0`
---@param GC? number @default: `0`
---@param BC? number @default: `0`
---@param AC? number @default: `0`
---@return Color
function _G.Color(R, G, B, A, RO, GO, BO, RC, GC, BC, AC)
end

--- Returns a dictionary corresponding to the color's current Colorize values: `{R, G, B, A}`
---@return {R: number, G: number, B: number, A: number}
function Color:GetColorize() end

--- Returns a dictionary corresponding to the color's current Offset values: `{R, G, B}`
---@return {R: number, G: number, B: number}
function Color:GetOffset() end

--- Returns a dictionary corresponding to the color's current Tint values: `{R, G, B}`
---@return {R: number, G: number, B: number, A: number}
function Color:GetTint() end

--- Prints a string representation of the color object.
function Color:Print() end

--- Returns a string representation of the color object.
---@return string
function Color:__tostring() end

_G.Color = {
    ---@type Color
    TearIpecac = Color(0, 0, 0),
    ---@type Color
    TearHoming = Color(),
    ---@type Color
    TearTar = Color(),
    ---@type Color
    TearSoy = Color(),
    ---@type Color
    TearChocolate = Color(),
    ---@type Color
    TearAlmond = Color(),
    ---@type Color
    TearScorpio = Color(),
    ---@type Color
    TearSerpentsKiss = Color(),
    ---@type Color
    TearCommonCold = Color(),
    ---@type Color
    TearCoal = Color(),
    ---@type Color
    TearNumberOne = Color(),
    ---@type Color

    ---@type Color
    ProjectileIpecac = Color(),
    ---@type Color
    ProjectileHoming = Color(),
    ---@type Color
    ProjectileTar = Color(),
    ---@type Color
    ProjectileSoy = Color(),
    ---@type Color
    ProjectileFireWave = Color(),
    ---@type Color

    ---@type Color
    ProjectileCageBlue = Color(),
    ---@type Color
    ProjectileMegaSatanBlack = Color(),
    ---@type Color
    ProjectileMegaSatanWhite = Color(),
    ---@type Color
    ProjectileHushBlue = Color(),
    ---@type Color
    ProjectileHushYellow = Color(),
    ---@type Color
    ProjectileHushGreen = Color(),

    ---@type Color
    LaserIpecac = Color(),
    ---@type Color
    LaserHoming = Color(),
    ---@type Color
    LaserSoy = Color(),
    ---@type Color
    LaserChocolate = Color(),
    ---@type Color
    LaserAlmond = Color(),
    ---@type Color
    LaserPoison = Color(),
    ---@type Color
    LaserCoal = Color(),
    ---@type Color
    LaserFireMind = Color(),
    ---@type Color
    LaserNumberOne = Color(),
    ---@type Color
    LaserMother = Color(),
    ---@type Color

    ---@type Color
    ProjectileCorpsePink = Color(),
    ---@type Color
    ProjectileCorpseWhite = Color(),
    ---@type Color
    ProjectileCorpseGreen = Color(),
    ---@type Color
    ProjectileCorpseYellow = Color(),
    ---@type Color
    ProjectileCorpseClusterLight = Color(),
    ---@type Color
    ProjectileCorpseClusterDark = Color(),

    ---@type Color
    EmberFade = Color(),
}


---@class EntityPtr
---@field Ref Entity
local EntityPtr = {}

---@param Entity Entity
---@return EntityPtr
function _G.EntityPtr(Entity)
end

---@param ref Entity
function EntityPtr:SetReference(ref)
end

---@class RoomConfig_Spawn
---@field Entries CppList_RoomConfigEntries # Not officially documented but functional
---@field EntryCount integer
---@field SumWeights number
---@field X integer
---@field Y integer
local RoomConfigSpawn = {}

---@param r number
---@return RoomConfig_Entry
function RoomConfigSpawn:PickEntry(r)
end



---@class TearParams
---@field BombVariant integer
---@field TearColor Color
---@field TearDamage number
---@field TearFlags TearFlags
---@field TearHeight number
---@field TearScale number
---@field TearVariant integer
local TearParams = {}



---@class PosVel
---@field Position Vector
---@field Velocity Vector
local PosVel = {}



---@class Input
_G.Input = {}

---@param action integer
---@param controllerId integer
---@return number
function Input.GetActionValue(action, controllerId)
end

---@param button integer
---@param controllerId integer
---@return number
function Input.GetButtonValue(button, controllerId)
end

---@param gameCoords boolean
---@return Vector
function Input.GetMousePosition(gameCoords)
end

---@param action integer
---@param controllerId integer
---@return boolean
function Input.IsActionPressed(action, controllerId)
end

---@param action integer
---@param controllerId integer
---@return boolean
function Input.IsActionTriggered(action, controllerId)
end

---@param button integer
---@param controllerId integer
---@return boolean
function Input.IsButtonPressed(button, controllerId)
end

---@param button integer
---@param controllerId integer
---@return boolean
function Input.IsButtonTriggered(button, controllerId)
end

---@param button integer
---@return boolean
function Input.IsMouseBtnPressed(button)
end

---@param idx integer
---@return string
function Input.GetDeviceNameByIdx(idx)
end

---@return Vector
function Input.GetMouseWheel()
end

---@class Level
---@field DungeonReturnPosition Vector
---@field DungeonReturnRoomIndex integer
---@field EnterDoor integer
---@field GreedModeWave integer
---@field LeaveDoor integer
local Level = {}

---@param Chance number
function Level:AddAngelRoomChance(Chance)
end

---@param Curse LevelCurse
---@param ShowName boolean
function Level:AddCurse(Curse, ShowName)
end

function Level:ApplyBlueMapEffect()
end

---@param Persistent? boolean @default: `false`. Set to `true` for it to persist across exiting and contiuing the run. It will reset regardless on the next floor.
function Level:ApplyCompassEffect(Persistent)
end

function Level:ApplyMapEffect()
end

---@param RoomIndex integer
---@return boolean
function Level:CanOpenChallengeRoom(RoomIndex)
end

---@return boolean
function Level:CanSpawnDevilRoom()
end

---@param Stage LevelStage
---@return boolean
function Level:CanStageHaveCurseOfLabyrinth(Stage)
end

---@param RoomIndex integer
---@param Dimension? integer @default: `-1`
function Level:ChangeRoom(RoomIndex, Dimension)
end

function Level:DisableDevilRoom()
end

---@param Seed integer
---@return boolean
function Level:ForceHorsemanBoss(Seed)
end

---@return LevelStage
function Level:GetAbsoluteStage()
end

---@return number
function Level:GetAngelRoomChance()
end

---@return boolean
function Level:GetCanSeeEverything()
end

---@return Room
function Level:GetCurrentRoom()
end

---@return RoomDescriptor
function Level:GetCurrentRoomDesc()
end

---@return integer
function Level:GetCurrentRoomIndex()
end

---@return string
function Level:GetCurseName()
end

---@return integer
function Level:GetCurses()
end

---@return RNG
function Level:GetDevilAngelRoomRNG()
end

---@return integer
function Level:GetDungeonPlacementSeed()
end

---@return Vector
function Level:GetEnterPosition()
end

---@return boolean
function Level:GetHeartPicked()
end

---@return integer
function Level:GetLastBossRoomListIndex()
end

---@return RoomDescriptor
function Level:GetLastRoomDesc()
end

---@return string
function Level:GetName()
end

---@return integer
function Level:GetNonCompleteRoomIndex()
end

---@return number
function Level:GetPlanetariumChance()
end

---@return integer
function Level:GetPreviousRoomIndex()
end

---@param IAmErrorRoom boolean
---@param Seed integer
---@return integer
function Level:GetRandomRoomIndex(IAmErrorRoom, Seed)
end

---@param RoomIdx integer
---@param Dimension? integer @default: `-1`
---@return RoomDescriptor
function Level:GetRoomByIdx(RoomIdx, Dimension)
end

---@return integer
function Level:GetRoomCount()
end

---@return CppList_RoomDescriptor
function Level:GetRooms()
end

---@return LevelStage
function Level:GetStage()
end

---@return StageType
function Level:GetStageType()
end

---@return integer
function Level:GetStartingRoomIndex()
end

---@param LevelStateFlag LevelStateFlag
---@return boolean
function Level:GetStateFlag(LevelStateFlag)
end

---@return boolean
function Level:HasBossChallenge()
end

---@param ForceAngel boolean
---@param ForceDevil boolean
function Level:InitializeDevilAngelRoom(ForceAngel, ForceDevil)
end

---@return boolean
function Level:IsAltStage()
end

---@return boolean
function Level:IsAscent()
end

---@return boolean
function Level:IsDevilRoomDisabled()
end

---@return boolean
function Level:IsNextStageAvailable()
end

---@return boolean
function Level:IsPreAscent()
end

---@param CurrentRoomIdx integer
---@param Slot DoorSlot
---@return boolean
function Level:MakeRedRoomDoor(CurrentRoomIdx, Slot)
end

---@param RoomType RoomType
---@param Visited boolean
---@param rng RNG
---@param IgnoreGroup? boolean @default: `false`
---@return integer
function Level:QueryRoomTypeIndex(RoomType, Visited, rng, IgnoreGroup)
end

function Level:RemoveCompassEffect()
end

---@param Curses LevelCurse
function Level:RemoveCurses(Curses)
end

---@param Value boolean
function Level:SetCanSeeEverything(Value)
end

function Level:SetHeartPicked()
end

function Level:SetNextStage()
end

function Level:SetRedHeartDamage()
end

---Changes the current floor, and it's stage. For the changes to fully apply, either use the reseed console command, or Game.StartStageTransition.
---@param StageOffset integer @Acts as the new "floor". 1 is Basement I, 2 Basmement II, 3 Caves I, etc
---@param StageTypeOffset integer @Acts as the new "stage" based on the listed IDs in stages.xml. See [this link](https://wofsauge.github.io/IsaacDocs/rep/Level.html?h=setstage#setstage) for more details.
function Level:SetStage(StageOffset, StageTypeOffset)
end

---@param LevelStateFlag LevelStateFlag
---@param Val boolean
function Level:SetStateFlag(LevelStateFlag, Val)
end

function Level:ShowMap()
end

---@param Sticky boolean
function Level:ShowName(Sticky)
end

---@param CurrentRoomIdx integer
---@param Slot DoorSlot
function Level:UncoverHiddenDoor(CurrentRoomIdx, Slot)
end

function Level:Update()
end

function Level:UpdateVisibility()
end


---Returns true of the Red Key door outline can spawn on the door slot.
---@param roomIndex integer
---@param doorSlot DoorSlot
---@return boolean
function Level:CanSpawnDoorOutline(roomIndex, doorSlot)
end

---Returns the current Dimension.
---@return Dimension
function Level:GetDimension()
end

--If set, the level will automatically attempt to place the Knife Piece puzzle door for this `LevelStage`.
---@return SpecialQuest
function Level:GetForceSpecialQuest()
end

---Returns true if the floor has the abandoned mineshaft room used for the second knife piece puzzle.
---@return boolean
function Level:HasAbandonedMineshaft()
end

---Returns true if the floor has a mirror dimension used for the first knife piece puzzle.
---@return boolean
function Level:HasMirrorDimension()
end

---Returns true if the floor has the photo door used to enter Mausoleum/Gehenna leading to the Ascent sequence.
---@return boolean
function Level:HasPhotoDoor()
end

---Returns `true` if the provided `levelStage` and `stageType` combination is available to be generated in any given run. Returns `false` if locked behind an achievement.
---@param levelStage LevelStage
---@param stageType StageType
---@return boolean
function Level:IsStageAvailable(levelStage, stageType)
end

---@param room LevelGeneratorEntry
---@param roomConfig RoomConfigRoom
---@param seed integer
---@return boolean successful True if the room was placed successfully.
function Level:PlaceRoom(room, roomConfig, seed)
end

---Sets whether the level should attempt to place the Knife Piece puzzle door for this LevelStage.
---
---This is set to `SpecialQuest.DEFAULT` immediately before calling MC_PRE_LEVEL_INIT.
---@param Quest SpecialQuest
function Level:SetForceSpecialQuest(Quest)
end

---Sets the name of the level.
---@param name string
function Level:SetName(name)
end

---@return integer
function Level:GetGreedWavesClearedWithoutRedHeartDamage()
end

---@param wavesCleared integer
function Level:SetGreedWavesClearedWithoutRedHeartDamage(wavesCleared)
end

---Returns the pickups that will be transferred to the next floor by the Myosotis trinket effect.
---@return EntitiesSaveStateVector
function Level:GetMyosotisPickups()
end

---Returns true if the room would be able to fit at this location.`.
---@param roomConfigRoom RoomConfigRoom
---@param gridIndex integer
---@param dimension Dimension @default: `Dimension.CURRENT`
---@param allowMultipleDoors? boolean @default: `true`. Set to false to only allow successful placement if the room would only have one door (for placing special rooms).
---@param allowSpecialNeighbors? boolean @default: `false`. Set to true to allow connections to existing special rooms (note secret rooms are always allowed, but boss rooms are never allowed).
---@param allowNoNeighbors? boolean @default: `false`. Set to true to allow placing the room out in the void with no neighbors.
---@return boolean
function Level:CanPlaceRoom(roomConfigRoom, gridIndex, dimension, allowMultipleDoors, allowSpecialNeighbors, allowNoNeighbors)
end

---Will only place the room if it can fit and all doors can be successfully connected to neighboring rooms.
---
---If successful, returns the new RoomDescriptor, returns nil otherwise.
---
---If a seed of nil or 0 is provided, a seed will be auto-generated based on the location, room shape, and level seed.
---@param roomConfigRoom RoomConfigRoom
---@param gridIndex integer
---@param dimension? Dimension @default: `Dimension.CURRENT`
---@param seed? integer @default: `0`
---@param allowMultipleDoors? boolean @default: `true`. Set to false to only allow successful placement if the room would only have one door (for placing special rooms).
---@param allowSpecialNeighbors? boolean @default: `false`. Set to true to allow connections to existing special rooms (note secret rooms are always allowed, but boss rooms are never allowed).
---@param allowNoNeighbors? boolean @default: `false`. Set to true to allow placing the room out in the void with no neighbors.
---@return RoomDescriptor?
function Level:TryPlaceRoom(roomConfigRoom, gridIndex, dimension, seed, allowMultipleDoors, allowSpecialNeighbors, allowNoNeighbors)
end

---Returns true if the room could be successfully placed connected to the specified DoorSlot of an existing room.
---@param roomConfigRoomToPlace RoomConfigRoom
---@param neightborRoomDescriptor RoomDescriptor
---@param doorSlot DoorSlot
---@param allowMultipleDoors? boolean @default: `true`. Set to false to only allow successful placement if the room would only have one door (for placing special rooms).
---@param allowSpecialNeighbors? boolean @default: `false`. Set to true to allow connections to existing special rooms (note secret rooms are always allowed, but boss rooms are never allowed).
---@return boolean
function Level:CanPlaceRoomAtDoor(roomConfigRoomToPlace, neightborRoomDescriptor, doorSlot, allowMultipleDoors, allowSpecialNeighbors)
end

---Similar to `TryPlaceRoom`, but attempts to place the provided room (the RoomConfigRoom) as a neighbor of an existing room (the RoomDescriptor) at the specified DoorSlot.
---@param roomConfigRoomToPlace RoomConfigRoom
---@param neightborRoomDescriptor RoomDescriptor
---@param doorSlot DoorSlot
---@param seed? integer @default: `0`
---@param allowMultipleDoors? boolean @default: `true`. Set to false to only allow successful placement if the room would only have one door (for placing special rooms).
---@param allowSpecialNeighbors? boolean @default: `false`. Set to true to allow connections to existing special rooms (note secret rooms are always allowed, but boss rooms are never allowed).
---@return RoomDescriptor?
function Level:TryPlaceRoomAtDoor(roomConfigRoomToPlace, neightborRoomDescriptor, doorSlot, seed, allowMultipleDoors, allowSpecialNeighbors)
end

---Returns a table of level GridIndexes that would be valid locations to place the given room.
---@param roomConfigRoom RoomConfigRoom
---@param dimension? Dimension @default: `-1`
---@param allowMultipleDoors? boolean @default: `true`. Set to false to only allow successful placement if the room would only have one door (for placing special rooms).
---@param allowSpecialNeighbors? boolean @default: `false`. Set to true to allow connections to existing special rooms (note secret rooms are always allowed, but boss rooms are never allowed).
---@return integer[]
function Level:FindValidRoomPlacementLocations(roomConfigRoom, dimension, allowMultipleDoors, allowSpecialNeighbors)
end

---Returns a table map of DoorSlot->RoomDescriptor. Don't use ipairs!
---
---Can be used to determine the neighbors of a room before even placing it.
---
---Note that this does not give you any signal of if a room would actually fit, or if the neighbors would even allow a connection.
---@param gridIndex integer
---@param roomShape RoomShape
---@param dimension? Dimension @default: `Dimension.CURRENT`
---@return {[DoorSlot]: RoomDescriptor}
function Level:GetNeighboringRooms(gridIndex, roomShape, dimension)
end

---Since enums were moves to json files and the TearFlags enum still uses the TEARFLAG function as its value, function is placed here.

local function TEARFLAG(x)
    return x >= 64 and BitSet128(0,1<<(x-64)) or BitSet128(1<<x,0)
end

---@class Isaac
_G.Isaac = {}

---@alias CallbackID ModCallbacks | string

---@param modRef table
---@param callbackId CallbackID # Vanilla IDs are integers, custom IDs can be any type including strings
---@param callbackFn function
---@param entityId? integer
function Isaac.AddCallback(modRef, callbackId, callbackFn, entityId)
end

---@param modRef table
---@param callbackId CallbackID # Vanilla IDs are integers, custom IDs can be any type including strings
---@param priority CallbackPriority # Default priority is 0, higher goes later, using the CallbackPriority table is recommended
---@param callbackFn function
---@param entityId? integer
function Isaac.AddPriorityCallback(modRef, callbackId, priority, callbackFn, entityId)
end

---@param modRef table
---@param callbackId CallbackID # Vanilla IDs are integers, custom IDs can be any type including strings
---@param callbackFn function
function Isaac.RemoveCallback(modRef, callbackId, callbackFn)
end

---@vararg any # Callback args
---@param callbackId CallbackID # Vanilla IDs are integers, custom IDs can be any type including strings
---@return any # Type of callback return
function Isaac.RunCallback(callbackId, ...)
end

---@vararg any # Callback args
---@param param any # Param to check against
---@param callbackId CallbackID # Vanilla IDs are integers, custom IDs can be any type including strings
---@return any # Type of callback return
function Isaac.RunCallbackWithParam(callbackId, param, ...)
end

---@class CallbackEntry
---@field Mod table
---@field Function function
---@field Priority integer @default: `0`
---@field Param integer @default: `-1`; entity ID or anything else

---@param callbackId CallbackID
---@param createIfMissing? boolean
---@return CallbackEntry[] callbackList #sorted by priority and addition order, can set __matchParams metamethod (see https://wofsauge.github.io/IsaacDocs/rep/tutorials/CustomCallbacks.html)
function Isaac.GetCallbacks(callbackId, createIfMissing)
end

---@param pillEffect integer
---@return integer
function Isaac.AddPillEffectToPool(pillEffect)
end

---@param text string
function Isaac.ConsoleOutput(text)
end

---@return integer
function Isaac.CountBosses()
end

---@return integer
function Isaac.CountEnemies()
end

---@param Spawner? Entity  Optionally specify only entities spawned by this entity
---@param Type? EntityType @default: `EntityType.ENTITY_NULL`
---@param Variant? integer @default: `-1`
---@param SubType? integer @default: `-1`
---@return integer
function Isaac.CountEntities(Spawner, Type, Variant, SubType)
end

---@param str string
function Isaac.DebugString(str)
end

---@param command string
---@return string
function Isaac.ExecuteCommand(command)
end

---@param pos Vector
---@param source Entity
---@param damage number
function Isaac.Explode(pos, source, damage)
end

---@param Type EntityType
---@param Variant? integer @default: `-1`
---@param SubType? integer @default: `-1`
---@param Cache? boolean @default: `false`
---@param IgnoreFriendly? boolean @default: `false`
---@return Entity[]
function Isaac.FindByType(Type, Variant, SubType, Cache, IgnoreFriendly)
end

---@param Position Vector
---@param Radius number
---@param Partitions? EntityPartition @default: `0xFFFFFFFF`
---@return Entity[]
function Isaac.FindInRadius(Position, Radius, Partitions)
end

---@param cardHudName string
---@return Card
function Isaac.GetCardIdByName(cardHudName)
end

---@return Challenge
function Isaac.GetChallenge()
end

---@param challengeName string
---@return Challenge
function Isaac.GetChallengeIdByName(challengeName)
end

---@param path string
---@return integer
function Isaac.GetCostumeIdByPath(path)
end

---@param curseName string
---@return LevelCurse
function Isaac.GetCurseIdByName(curseName)
end

---@param entityName string
---@return EntityType
function Isaac.GetEntityTypeByName(entityName)
end

---@param entityName string
---@return integer
function Isaac.GetEntityVariantByName(entityName)
end

---@return integer
function Isaac.GetFrameCount()
end

---@param pos Vector
---@param step number
---@return Vector
function Isaac.GetFreeNearPosition(pos, step)
end

---@return ItemConfig
function Isaac.GetItemConfig()
end

---@param itemName string
---@return CollectibleType
function Isaac.GetItemIdByName(itemName)
end

---@param musicName string
---@return Music
function Isaac.GetMusicIdByName(musicName)
end

---@param pillEffect string
---@return PillEffect
function Isaac.GetPillEffectByName(pillEffect)
end

---@param playerID? integer @default: `0`
---@return EntityPlayer
function Isaac.GetPlayer(playerID)
end

---@param playerName string
---@param Tainted? boolean @default: `false`
---@return PlayerType
function Isaac.GetPlayerTypeByName(playerName, Tainted)
end

---@return Vector
function Isaac.GetRandomPosition()
end

---@return Entity[]
function Isaac.GetRoomEntities()
end

---@return number
function Isaac.GetScreenHeight()
end

---@return number
function Isaac.GetScreenPointScale()
end

---@return number
function Isaac.GetScreenWidth()
end

---@param soundName string
---@return SoundEffect
function Isaac.GetSoundIdByName(soundName)
end

---@param str string
---@return integer
function Isaac.GetTextWidth(str)
end

---@return integer
function Isaac.GetTime()
end

---@param trinketName string
---@return TrinketType
function Isaac.GetTrinketIdByName(trinketName)
end

---@param gridEntityType GridEntityType
---@param variant integer
---@param position Vector
---@param forced? boolean **BUG**: Currently doesn't have any effect
---@return GridEntity
function Isaac.GridSpawn(gridEntityType, variant, position, forced)
end

---@param modRef table
---@return boolean
function Isaac.HasModData(modRef)
end

---@param modRef table
---@return string
function Isaac.LoadModData(modRef)
end

---@param modRef table
---@param modName string
---@param apiVersion integer
function Isaac.RegisterMod(modRef, modName, apiVersion)
end

---@param modRef table
function Isaac.RemoveModData(modRef)
end

---@param str string
---@param X number
---@param Y number
---@param ScaleX number
---@param ScaleY number
---@param R number
---@param G number
---@param B number
---@param A number
function Isaac.RenderScaledText(str, X, Y, ScaleX, ScaleY, R, G, B, A)
end

---@param str string
---@param X number
---@param Y number
---@param R number
---@param G number
---@param B number
---@param A number
function Isaac.RenderText(str, X, Y, R, G, B, A)
end

---@param modRef table
---@param data string
function Isaac.SaveModData(modRef, data)
end

---@param pos Vector
---@return Vector
function Isaac.ScreenToWorld(pos)
end

---@param pos Vector
---@return Vector
function Isaac.ScreenToWorldDistance(pos)
end

---@param entityType EntityType
---@param entityVariant integer
---@param entitySubtype integer
---@param position Vector
---@param velocity Vector
---@param Spawner Entity | nil @Despite being listed as optional, the function requires you input a value here, as it will error otherwise. Directly inserting `nil` will suffice.
---@return Entity
function Isaac.Spawn(entityType, entityVariant, entitySubtype, position, velocity, Spawner)
end

---@param pos Vector
---@return Vector
function Isaac.WorldToRenderPosition(pos)
end

---@param pos Vector
---@return Vector
function Isaac.WorldToScreen(pos)
end

---@param pos Vector
---@return Vector
function Isaac.WorldToScreenDistance(pos)
end


---Checks if a given character has completed all marks and returns the
---highest difficulty it was accomplished in.
---@param playerType PlayerType
---@return integer
---|0 # None
---|1 # Normal
---|2 # Hard
function Isaac.AllMarksFilled(playerType)
end

---Checks if a given character has completed all tainted-related marks
---and returns the highest difficulty it was accomplished in.
---@param playerType PlayerType
---@param taintedMarksGroup TaintedMarksGroup
---@return integer
---|0 # None
---|1 # Normal
---|2 # Hard
function Isaac.AllTaintedCompletion(playerType, taintedMarksGroup)
end

---@return boolean
function Isaac.CanStartTrueCoop()
end

--- Moves the windows mouse cursor to the center of the game's window. It
---won't move the cursor if the game's window is out of focus.
function Isaac.CenterCursor()
end

---Kills all projectiles and non-friendly NPCs capable of keeping doors closed..
---@param includeNpcs? boolean @default: `false`. If `true`, will not kill aforementioned NPCs.
function Isaac.ClearBossHazards(includeNpcs)
end

---Sets the challenge of the corresponding `challengeId` to completed.
---@param challengeId Challenge
function Isaac.ClearChallenge(challengeId)
end

---Deletes all completion marks for the provided character.
---@param playerType PlayerType
function Isaac.ClearCompletionMarks(playerType)
end

---Spawns a timer effect.
---
---The timer is called every game update. This means the timer only runs
---while the game is unpaused and uses update frames for its delay parameter
---(30 frames per second).
---
---If your use case requires a timer that takes paused time into acount, stick with a custom timer running on a RENDER callback.
---@param intervalFunction fun()
---@param interval number How many frames until intervalFunction is ran.
---@param times number The amount of times intervalFunction can be called after enough interval frames passed.
---@param persistent boolean If true, the timer will persist across rooms.
---@return EntityEffect
function Isaac.CreateTimer(intervalFunction, interval, times, persistent)
end

---Creates and returns a Weapon object. It is not automatically useable by
---`owner` and `Isaac.SetWeaponType` must be used in tandem.
---@param weaponType WeaponType
---@param owner Entity Advised that this only be used for `EntityPlayer` and `EntityFamiliar` objects.
---@return Weapon
function Isaac.CreateWeapon(weaponType, owner)
end

---Destroys the provided Weapon object.
---@param weapon Weapon
function Isaac.DestroyWeapon(weapon)
end

---Draws a line between two positions on the current render frame.
---@param startPos Vector
---@param endPos Vector
---@param startColor KColor
---@param endColor KColor
---@param thickness integer
function Isaac.DrawLine(startPos, endPos, startColor, endColor, thickness)
end

---Draws a quad for the current render frame.
---@param topLeftPosition Vector
---@param topRightPosition Vector
---@param bottomLeftPosition Vector
---@param bottomRightPosition Vector
---@param color KColor
---@param thickness integer
function Isaac.DrawQuad(topLeftPosition, topRightPosition, bottomLeftPosition, bottomRightPosition, color, thickness)
end

---Fills all of the completion marks for the character.
---@param playerType PlayerType
function Isaac.FillCompletionMarks(playerType)
end

---Returns entities inside of the given capsule, filtered by partitions mask.
---@param Capsule Capsule
---@param EntityPartitions? EntityPartition @default: `-1`
---@return Entity[]
function Isaac.FindInCapsule(Capsule, EntityPartitions)
end

---Returns the achievement ID by name.
---@param name string
---@return Achievement --Returns `-1` if it fails to find an achievement with the provided name
function Isaac.GetAchievementIdByName(name)
end

---@param direction? Direction @default: `Direction.NO_DIRECTION`
---@return Vector --Returns a vector with a length of 1 or 0 corresponding to the provided direction.
---`NO_DIRECTION`: `Vector(0, 0)`
---
---`LEFT`: `Vector(-1, 0)`
---
---`UP`: `Vector(0, -1)`
---
---`RIGHT`: `Vector(1, 0)`
---
---`DOWN`: `Vector(0, 1)`
function Isaac.GetAxisAlignedUnitVectorFromDir(direction)
end

---Returns the bosscoloridx
---@param name string
---@return integer --Returns `-1` if it fails to find a boss color with the provided name
function Isaac.GetBossColorIdxByName(name)
end

---Returns the contents of the player's clipboard. If nothing is in the
---clipboard, `nil` is returned instead.
---@return string?
function Isaac.GetClipboard()
end

---Returns what position a collectible would actually spawn at from the
---provided position.
---@param position Vector
---@return Vector
function Isaac.GetCollectibleSpawnPosition(position)
end

---Returns a completion mark value for the provided character.
---@param playerType PlayerType
---@param markType CompletionType
---@return Difficulty
function Isaac.GetCompletionMark(playerType, markType)
end

---@class CompletionMarks
---@field PlayerType PlayerType
---@field MomsHeart Difficulty
---@field Isaac Difficulty
---@field Satan Difficulty
---@field BossRush Difficulty
---@field BlueBaby Difficulty
---@field Lamb Difficulty
---@field MegaSatan Difficulty
---@field UltraGreed Difficulty
---@field Hush Difficulty
---@field UltraGreedier Difficulty
---@field Delirium Difficulty
---@field Mother Difficulty
---@field Beast Difficulty

---Returns a dictionary of the character's current completion marks.
---@param playerType PlayerType
---@return CompletionMarks
function Isaac.GetCompletionMarks(playerType)
end

---Sets the completion marks of a character to match an input table.
---Requires a dictionary containing all the marks for the character,
---getting it from GetCompletionMarks is advised for convenience.
---@param marks CompletionMarks
function Isaac.SetCompletionMarks(marks)
end

---Returns the cursor sprite that is rendered when `Options.MouseControl`
---is true.
---@return Sprite
function Isaac.GetCursorSprite()
end

---@param name string
---@return Ending
function Isaac.GetCutsceneIdByName(name)
end

---@param name string
---@return integer
function Isaac.GetEntitySubTypeByName(name)
end

---Returns the giantbook id by name. For vanilla giantbooks, the png filename, from the gfx xml attribute, is used as the giantbook name.
---@param name string
---@return Giantbook
function Isaac.GetGiantBookIdByName(name)
end

---@param name string
---@return BackdropType
function Isaac.GetBackdropIdByName(name)
end

---Returns a key-value table of all loaded script values, where the key is the path of the script and the value is what it returns.
---@return table<string, any>
function Isaac.GetLoadedModules()
end

---Returns the translation string associated with the given key in the given catagory.
---@param category string
---@param key string
---@param language Language
---@overload fun(category: string, key: string, languageCode: string)
function Isaac.GetLocalizedString(category, key, language)
end

---@param challengeId Challenge
function Isaac.GetModChallengeClearCount(challengeId)
end

---@param name string
---@return integer
function Isaac.GetNullItemIdByName(name)
end

---@return PersistentGameData
function Isaac.GetPersistentGameData()
end

---@param position Vector
---@param scale? boolean @default: `true`
---@return Vector
function Isaac.GetRenderPosition(position, scale)
end

---Returns the translation string associated with the given key in the given category. The translation is given in the currently selected language.
---@param category string
---@param key string
---@return string
function Isaac.GetString(category, key)
end

---Returns true if the challenge of the corresponding challengeid is completed.
---@param challengeId Challenge
---@return boolean
function Isaac.IsChallengeDone(challengeId)
end

---Returns `true` if `Game` is non-nil and the current state is correct.
---@return boolean
function Isaac.IsInGame()
end

---Creates a new blank `LevelGeneratorEntry` object.
---@return LevelGeneratorEntry
function Isaac.LevelGeneratorEntry()
end

---@param challengeId Challenge
function Isaac.MarkChallengeAsNotDone(challengeId)
end

---Plays a cutscene.
---@param cutsceneId Ending
---@param clearGameState? boolean @default: `false`
function Isaac.PlayCutscene(cutsceneId, clearGameState)
end

---Sets the contents of the player's clipboard.
---@param clipboardData string
---@return boolean wasSet True if the player's clipboard contents were set successfully.
function Isaac.SetClipboard(clipboardData)
end

---Sets a completion mark value of a character.
---@param playerType PlayerType
---@param markType CompletionType
---@param value integer
function Isaac.SetCompletionMark(playerType, markType, value)
end

---Displays a Win32 message box.
---@param title string The title of the message box.
---@param text string The text of the message box.
---@param icon? DialogIcons @default: `DialogIcons.ERROR`. The icon of the message box.
---@param buttons? DialogButtons @default: `DialogButtons.OK`. The buttons on the message box.
---@return DialogReturn buttonPRessed The value that indicates the button pressed.
function Isaac.ShowErrorDialog(title, text, icon, buttons)
end

---Simulates a window resize, useful to refresh some option changes like `MaxRenderScale`.
function Isaac.TriggerWindowResize()
end

---Converts the World position from input to a pinned main menu position that varies depending on the enum selected. It's important to reconvert this every frame, in a similar fashion to `Isaac.WorldToRender`, in order to properly render when menus are changed or the window is resized.
---@param menuId MainMenuType
---@param position Vector
---@return Vector
function Isaac.WorldToMenuPosition(menuId, position)
end

---@param musicid Music
function Isaac.SetCurrentFloorMusic(musicid)
end

---@param backdropid BackdropType
function Isaac.GetCurrentFloorBackdrop(backdropid)
end

---@param name string
function Isaac.SetCurrentFloorName(name)
end

---@return integer
function Isaac.GetCurrentStageConfigId()
end

---Allows starting the game from within the main menu.
---@param playerType PlayerType
---@param challenge? Challenge @default: `Challenge.CHALLENGE_NULL`
---@param difficulty? Difficulty @default: `Difficulty.DIFFICULTY_NORMAL`
---@param seed? integer @default: `Random()`
function Isaac.StartNewGame(playerType, challenge, difficulty, seed)
end

---@return DwmWindowAttributes
function Isaac.GetDwmWindowAttribute()
end

---@param attribute DwmWindowAttributes
function Isaac.SetDwmWindowAttribute(attribute)
end

---Returns the appended text on the game window's title.
---@return string
function Isaac.GetWindowTitle()
end

---Sets the appended text on the game window's title.
---@param title string
function Isaac.SetWindowTitle(title)
end

---Sets the 16x16 icon located on the game window. Does not update the icon elsewhere, such as the taskbar.
---@param icon integer | string Set to 0 for the default Isaac icon, 1 for the Tainted Isaac icon, or a string for the path to a custom icon.
---@param bypassSize? boolean @default: `false`. Set to `true` to bypass the 16x16 resolution cap.
function Isaac.SetIcon(icon, bypassSize)
end

---@param name string
---@return ItemPoolType
function Isaac.GetPoolIdByName(name)
end

---@class TemporaryEffects
local TemporaryEffects = {}

---@param CollectibleType CollectibleType
---@param AddCostume? boolean @default: `true`
---@param Count? integer @default: `1`
function TemporaryEffects:AddCollectibleEffect(CollectibleType, AddCostume, Count)
end

---@param NullId integer @ItemConfigNullItemID
---@param AddCostume? boolean @default: `true`
---@param Count? integer @default: `1`
function TemporaryEffects:AddNullEffect(NullId, AddCostume, Count)
end

---@param TrinketType TrinketType
---@param AddCostume? boolean @default: `true`
---@param Count? integer @default: `1`
function TemporaryEffects:AddTrinketEffect(TrinketType, AddCostume, Count)
end

function TemporaryEffects:ClearEffects()
end

---@param CollectibleType CollectibleType
---@return TemporaryEffect
function TemporaryEffects:GetCollectibleEffect(CollectibleType)
end

---@param CollectibleType CollectibleType
---@return integer
function TemporaryEffects:GetCollectibleEffectNum(CollectibleType)
end

---@return EffectList
function TemporaryEffects:GetEffectsList()
end

---@param NullId integer @ItemConfigNullItemID
---@return TemporaryEffect
function TemporaryEffects:GetNullEffect(NullId)
end

---@param NullId integer @ItemConfigNullItemID
---@return integer
function TemporaryEffects:GetNullEffectNum(NullId)
end

---@param TrinketType TrinketType
---@return TemporaryEffect
function TemporaryEffects:GetTrinketEffect(TrinketType)
end

---@param TrinketType TrinketType
---@return integer
function TemporaryEffects:GetTrinketEffectNum(TrinketType)
end

---@param CollectibleType CollectibleType
---@return boolean
function TemporaryEffects:HasCollectibleEffect(CollectibleType)
end

---@param NullId integer @ItemConfigNullItemID
---@return boolean
function TemporaryEffects:HasNullEffect(NullId)
end

---@param TrinketType TrinketType
---@return boolean
function TemporaryEffects:HasTrinketEffect(TrinketType)
end

---@param CollectibleType CollectibleType
---@param Count? integer @default: `1`. Setting this to -1 removes all instances of the effect
function TemporaryEffects:RemoveCollectibleEffect(CollectibleType, Count)
end

---@param NullId integer @ItemConfigNullItemID
---@param Count? integer @default: `1`. Setting this to -1 removes all instances of the effect
function TemporaryEffects:RemoveNullEffect(NullId, Count)
end

---@param TrinketType TrinketType
---@param Count? integer @default: `1`. Setting this to -1 removes all instances of the effect
function TemporaryEffects:RemoveTrinketEffect(TrinketType, Count)
end


---@class HUD
local HUD = {}

function HUD:AssignPlayerHUDs()
end

---@param Player EntityPlayer
---@param ActiveSlot ActiveSlot
function HUD:FlashChargeBar(Player, ActiveSlot)
end

---@param Player EntityPlayer
---@param ActiveSlot ActiveSlot
function HUD:InvalidateActiveItem(Player, ActiveSlot)
end

---@param Player EntityPlayer
function HUD:InvalidateCraftingItem(Player)
end

---@return boolean
function HUD:IsVisible()
end

---@param MainString? string
---@param SecondaryString? string
---@vararg string
function HUD:ShowFortuneText(MainString, SecondaryString, ...)
end

---@param MainString string
---@param SecondaryString? string
---@param IsCurseDisplay? boolean @default: `false`
---@param ClearStack? boolean @default: `false`. Repentance+ Exclusive
---@diagnostic disable-next-line: duplicate-set-field
function HUD:ShowItemText(MainString, SecondaryString, IsCurseDisplay, ClearStack)
end

---@param Player EntityPlayer
---@param Item ItemConfigItem
---@param ClearStack? boolean @default: `false`. Repentance+ Exclusive
---@diagnostic disable-next-line: duplicate-set-field
function HUD:ShowItemText(Player, Item, ClearStack)
end

---@param Visible? boolean @default: `false`
function HUD:SetVisible(Visible)
end

function HUD:Update()
end

function HUD:PostUpdate()
end

function HUD:Render()
end


---@class HUD
local HUD = {}

---Flashes the red hearts on the hud tied to the provided player.
---@param player EntityPlayer
function HUD:FlashRedHearts(player)
end

---Get the fill of the boss hp bar
---@return number
function HUD:GetBossHPBarFill()
end

---Sprite object used to render pills, cards and rune sprites in the hud.
---@return Sprite
function HUD:GetCardsPillsSprite()
end

---@return Sprite
function HUD:GetChargeBarSprite()
end

---Sprite object used to render the coop player selection menu.
---@return Sprite
function HUD:GetCoopMenuSprite()
end

---Sprite object used for bag of crafting hud.
---@return Sprite
function HUD:GetCraftingSprite()
end

---Sprite object used for the fortune popup window.
---@return Sprite
function HUD:GetFortuneSprite()
end

---@return Sprite
function HUD:GetHeartsSprite()
end

---Sprite object used for Tainted Isaac inventory system.
---@return Sprite
function HUD:GetInventorySprite()
end

---@return Sprite
function HUD:GetPickupsHUDSprite()
end

---@param index? integer @default: `0`
---@return PlayerHUD	
function HUD:GetPlayerHUD(index)
end

---Tainted blue baby poop spell sprite
---@return Sprite
function HUD:GetPoopSpellSprite()
end

---Sprite object used for text streak popups. For example: picking up items, displaying floor name, etc.
---@return Sprite
function HUD:GetStreakSprite()
end

---Sets the fill of the boss hp bar.
---@param percent number Accepts values between `0` and `1`. Numbers below `0` cause the boss hp bar to not be rendered.
function HUD:SetBossHPBarFill(percent)
end


---@class MusicManager
local MusicManager = {}

---@return MusicManager
function _G.MusicManager()
end

---@param ID Music
---@param FadeRate? number @default: `0.08`
function MusicManager:Crossfade(ID, FadeRate)
end

function MusicManager:Disable()
end

---@param LayerId? integer @default: `0`
function MusicManager:DisableLayer(LayerId)
end

function MusicManager:Enable()
end

---@param LayerId? integer @default: `0`
---@param Instant? boolean @default: `false`
function MusicManager:EnableLayer(LayerId, Instant)
end

---@param ID Music
---@param Volume? number @default: `1`
---@param FadeRate? number @default: `0.08`
function MusicManager:Fadein(ID, Volume, FadeRate)
end

---@param FadeRate? number @default: `0.08`
function MusicManager:Fadeout(FadeRate)
end

---@return Music
function MusicManager:GetCurrentMusicID()
end

---@return Music
function MusicManager:GetQueuedMusicID()
end

---@return boolean
function MusicManager:IsEnabled()
end

---@param LayerId? integer @default: `0`
---@return boolean
function MusicManager:IsLayerEnabled(LayerId)
end

function MusicManager:Pause()
end

---@param TargetPitch number
function MusicManager:PitchSlide(TargetPitch)
end

---@param ID Music
---@param Volume number
function MusicManager:Play(ID, Volume)
end

---@param ID Music
function MusicManager:Queue(ID)
end

function MusicManager:ResetPitch()
end

function MusicManager:Resume()
end

function MusicManager:UpdateVolume()
end

---@param TargetVolume number
---@param FadeRate? number @default: `0.08`
function MusicManager:VolumeSlide(TargetVolume, FadeRate)
end


function MusicManager:GetCurrentPitch()
end

---Plays a jingle.
---@param musicId Music
---@param duration integer
function MusicManager:PlayJingle(musicId, duration)
end

---@param pitch number
function MusicManager:SetCurrentPitch(pitch)
end

---Stops the currently playing jingle.
function MusicManager:StopJingle()
end


---@class Vector
---@field X number
---@field Y number
---@operator add(Vector): Vector
---@operator sub(Vector): Vector
---@operator unm: Vector
---@operator mul(number|Vector): Vector
---@operator div(number|Vector): Vector
local Vector = {}

---@param x number
---@param y number
---@return Vector
function _G.Vector(x, y) end

_G.Vector = {
    ---@type Vector
    One = Vector(1, 1),
    ---@type Vector
    Zero = Vector(0, 0),
}

---@param AngleDegrees number
---@return Vector
function _G.Vector.FromAngle(AngleDegrees)
end

---@param first Vector
---@param second Vector
---@param t number
---@return Vector
function Vector.Lerp(first, second, t)
end

---@param Right Vector
---@return Vector
function Vector:__add(Right)
end

---@param Modifier number|Vector
---@return Vector
function Vector:__div(Modifier)
end

---@param Modifier number|Vector
---@return Vector
function Vector:__mul(Modifier)
end

---@param Right Vector
---@return Vector
function Vector:__sub(Right)
end

---@return Vector
function Vector:__unm()
end

---@param MinX number
---@param MinY number
---@param MaxX number
---@param MaxY number
function Vector:Clamp(MinX, MinY, MaxX, MaxY)
end

---@param MinX number
---@param MinY number
---@param MaxX number
---@param MaxY number
---@return Vector
function Vector:Clamped(MinX, MinY, MaxX, MaxY)
end

---@param second Vector
---@return number
function Vector:Cross(second)
end

---@param second Vector
---@return number
function Vector:Distance(second)
end

---@param second Vector
---@return number
function Vector:DistanceSquared(second)
end

---@param second Vector
---@return number
function Vector:Dot(second)
end

---@return number
function Vector:GetAngleDegrees()
end

---@return number
function Vector:Length()
end

---@return number
function Vector:LengthSquared()
end

function Vector:Normalize()
end

---@return Vector
function Vector:Normalized()
end

---@param NewLength number
function Vector:Resize(NewLength)
end

---@param NewLength number
---@return Vector
function Vector:Resized(NewLength)
end

---@param AngleDegrees number
---@return Vector
function Vector:Rotated(AngleDegrees)
end

---@class Sprite
---@field Color Color
---@field FlipX boolean
---@field FlipY boolean
---@field Offset Vector
---@field PlaybackSpeed number
---@field Scale Vector
---@field Rotation number
local Sprite = {}

---@return string
function Sprite:GetAnimation()
end

---@return string
function Sprite:GetDefaultAnimation()
end

---@return string
function Sprite:GetDefaultAnimationName()
end

---@return string
function Sprite:GetFilename()
end

---@return integer
function Sprite:GetFrame()
end

---@return integer
function Sprite:GetLayerCount()
end

---@return string
function Sprite:GetOverlayAnimation()
end

---@return integer
function Sprite:GetOverlayFrame()
end

---@param SamplePos Vector
---@param RenderPos Vector
---@param AlphaThreshold number
---@param LayerID? integer @default: `0`
---@return KColor
function Sprite:GetTexel(SamplePos, RenderPos, AlphaThreshold, LayerID)
end

---@param EventName string
---@return boolean
function Sprite:IsEventTriggered(EventName)
end

---@param AnimationName? string
---@return boolean
function Sprite:IsFinished(AnimationName)
end

---@return boolean
function Sprite:IsLoaded()
end

---@param AnimationName? string
---@return boolean
function Sprite:IsOverlayFinished(AnimationName)
end

---@param AnimationName? string
---@return boolean
function Sprite:IsOverlayPlaying(AnimationName)
end

---@param AnimationName? string
---@return boolean
function Sprite:IsPlaying(AnimationName)
end

---@param Filename string
---@param LoadGraphics? boolean
function Sprite:Load(Filename, LoadGraphics)
end

function Sprite:LoadGraphics()
end

---@param AnimationName string
---@param Force? boolean
function Sprite:Play(AnimationName, Force)
end

---@param AnimationName string
---@param Force? boolean
function Sprite:PlayOverlay(AnimationName, Force)
end

---@param Seed integer
function Sprite:PlayRandom(Seed)
end

function Sprite:Reload()
end

function Sprite:RemoveOverlay()
end

---@param Position Vector
---@param TopLeftClamp? Vector @default: `Vector.Zero`
---@param BottomRightClamp? Vector @default: `Vector.Zero`
function Sprite:Render(Position, TopLeftClamp, BottomRightClamp)
end

---@param LayerId integer
---@param Position Vector
---@param TopLeftClamp? Vector @default: `Vector.Zero`
---@param BottomRightClamp? Vector @default: `Vector.Zero`
function Sprite:RenderLayer(LayerId, Position, TopLeftClamp, BottomRightClamp)
end

function Sprite:Reset()
end

--- Passing Reset as false will continue the animation from the current frame.
--- This is a really good tool for familiars that alternate between different
--- FloatDirection animations dynamically and other entities that follow
--- similar behaviors.
---@param AnimationName string
---@param Reset? boolean @default: `true`
---@return boolean
function Sprite:SetAnimation(AnimationName, Reset)
end

---@param AnimationName string
---@param FrameNum integer
---@overload fun(self: Sprite, FrameNum: integer)
function Sprite:SetFrame(AnimationName, FrameNum)
end

function Sprite:SetLastFrame()
end

---@param LayerId integer
---@param FrameNum integer
function Sprite:SetLayerFrame(LayerId, FrameNum)
end

---@param AnimationName string
---@return boolean
function Sprite:SetOverlayAnimation(AnimationName)
end

---@param RenderFirst boolean
function Sprite:SetOverlayRenderPriority(RenderFirst)
end

function Sprite:Update()
end

---@param EventName string
---@return boolean
function Sprite:WasEventTriggered(EventName)
end


---@param ANM2Path string
---@param LoadGraphics? boolean
---@return Sprite, boolean wasLoadSuccessful
---@overload fun(): Sprite
function _G.Sprite(ANM2Path, LoadGraphics)
end

---Continues the current animation. If the animation is currently stopped, it will play again from the current frame.
---
---If the animation does not loop and is finished, it will not restart.
---@param continueOverlay? boolean @default: `true`. If true, the overlay animation is also continued.
function Sprite:Continue(continueOverlay) end

---Continues the current overlay animation. If the animation is currently stopped, it will play again from the current frame.
---
---If the overlay animation does not loop and is finished, it will not restart.
function Sprite:ContinueOverlay() end

---Returns a table of AnimationData representing all animations in the sprite's .anm2 file.
---@return AnimationData[]
function Sprite:GetAllAnimationData() end

---Returns a table of all of the LayerStates in the sprite.
---@return LayerState[]
function Sprite:GetAllLayers() end

---Returns the AnimationData of the provided animation.
---@param animationName string
---@return AnimationData?
function Sprite:GetAnimationData(animationName) end

---Returns the AnimationData of the current animation.
---@return AnimationData
function Sprite:GetCurrentAnimationData() end

---Returns the layer data from the provided layer id.
---@param layerId integer
---@return LayerState?
---@overload fun(self: Sprite, layerName: string):LayerState?
function Sprite:GetLayer(layerId) end

---Returns the NullFrame from the provided layer name.
---@param layerName string
---@return NullFrame?
function Sprite:GetNullFrame(layerName) end

---Returns the AnimationData of the currently playing overlay.
---@return AnimationData?
function Sprite:GetOverlayAnimationData()
end

---Returns a NullFrame from the provided layer name.
---@param layerName string
---@return NullFrame?
function Sprite:GetOverlayNullFrame(layerName) end

---Returns the bitflags of the sprite's render flags.
---@return AnimRenderFlags
function Sprite:GetRenderFlags() end

---Returns `true` if the currently playing overlay animation just reached the event with the provided name.
---@param eventName string
---@return boolean
function Sprite:IsOverlayEventTriggered(eventName) end

---@param LayerId integer
---@param PngFilename string
---@param LoadGraphics? boolean
function Sprite:ReplaceSpritesheet(LayerId, PngFilename, LoadGraphics)
end

---@overload fun(self: Sprite, FrameNum: integer)
---@param AnimationName string
---@param FrameNum integer
function Sprite:SetOverlayFrame(AnimationName, FrameNum) end

---Sets the sprite's render flags.
---@param renderFlags AnimRenderFlags
function Sprite:SetRenderFlags(renderFlags) end

---@param StopOverlay? boolean @default is `true`.
function Sprite:Stop(StopOverlay) end

---Stops the current overlay animation.
function Sprite:StopOverlay() end

---Returns true if the currently playing overlay animation already reached the event with the provided name.
---@param eventName string
---@return boolean
function Sprite:WasOverlayEventTriggered(eventName)
end

---@param path string
function Sprite:SetCustomShader(path)
end

function Sprite:ClearCustomShader()
end

---Returns `true` if the specified shader is currently set. If no string is provided, returns true if any custom shader is applied.
---@param path? string
---@return boolean
function Sprite:HasCustomShader(path)
end

---@param path string
function Sprite:SetCustomChampionShader(path)
end

function Sprite:ClearCustomChampionShader()
end

---Returns `true` if the specified shader is currently set. If no string is provided, returns true if any custom shader is applied.
---@param path? string
---@return boolean
function Sprite:HasCustomChampionShader(path)
end

---`SetLayerFrame` for overlays.
---@param layer integer
---@param frame integer
function Sprite:SetOverlayLayerFrame(layer, frame)
end

---Returns the current AnimationFrame for the given layer.
---@param layer integer
---@return AnimationFrame
function Sprite:GetLayerFrameData(layer)
end

---`GetLayerFrameData` for overlays.
---@param layer integer
---@return AnimationFrame
function Sprite:GetOverlayLayerFrameData(layer)
end

---@class Font
local Font = {}

---@return Font
function _G.Font()
end

---@param String string
---@param PositionX number
---@param PositionY number
---@param RenderColor KColor
---@param BoxWidth? integer @default: `0`
---@param Center? boolean @default: `false`
function Font:DrawString(String, PositionX, PositionY, RenderColor, BoxWidth, Center)
end

---@param String string
---@param PositionX number
---@param PositionY number
---@param ScaleX number
---@param ScaleY number
---@param RenderColor KColor
---@param BoxWidth? integer @default: `0`
---@param Center? boolean @default: `false`
function Font:DrawStringScaled(String, PositionX, PositionY, ScaleX, ScaleY, RenderColor, BoxWidth, Center)
end

---@param String string
---@param PositionX number
---@param PositionY number
---@param ScaleX number
---@param ScaleY number
---@param RenderColor KColor
---@param BoxWidth? integer @default: `0`
---@param Center? boolean @default: `false`
function Font:DrawStringScaledUTF8(String, PositionX, PositionY, ScaleX, ScaleY, RenderColor, BoxWidth, Center)
end

---@param String string
---@param PositionX number
---@param PositionY number
---@param RenderColor KColor
---@param BoxWidth? integer @default: `0`
---@param Center? boolean @default: `false`
function Font:DrawStringUTF8(String, PositionX, PositionY, RenderColor, BoxWidth, Center)
end

---@return integer
function Font:GetBaselineHeight()
end

---@param Character string
---@return integer
function Font:GetCharacterWidth(Character)
end

---@return integer
function Font:GetLineHeight()
end

---@param String string
---@return integer
function Font:GetStringWidth(String)
end

---@param String string
---@return integer
function Font:GetStringWidthUTF8(String)
end

---@return boolean
function Font:IsLoaded()
end

---@param FilePath string
---@return boolean
function Font:Load(FilePath)
end

---@param MissingCharacter string
function Font:SetMissingCharacter(MissingCharacter)
end

function Font:Unload()
end


---@return ProjectileParams
function ProjectileParams()
end


---@class ProjectileParams
---@field Acceleration number
---@field BulletFlags integer
---@field ChangeFlags integer
---@field ChangeTimeout integer
---@field ChangeVelocity number
---@field CircleAngle number
---@field Color Color
---@field CurvingStrength number
---@field Damage number **WARNING:** Enemies that are champions will cap the damage at `2.0`.
---@field DepthOffset number
---@field DotProductLimit number
---@field FallingAccelModifier number
---@field FallingSpeedModifier number
---@field FireDirectionLimit Vector
---@field GridCollision boolean
---@field HeightModifier number
---@field HomingStrength number
---@field PositionOffset Vector
---@field Scale number
---@field Spread number
---@field TargetPosition Vector
---@field Variant integer
---@field VelocityMulti number
---@field WiggleFrameOffset integer

---@class EntityRef
---@field Entity Entity
---@field IsCharmed boolean
---@field IsFriendly boolean
---@field Position Vector
---@field SpawnerType integer @EntityType
---@field SpawnerVariant integer
---@field Type integer @EntityType
---@field Variant integer

---@param Entity Entity | nil
---@return EntityRef
function EntityRef(Entity)

end

---@param Entity Entity?
---@return EntityRef
function EntityRef(Entity)
end

---@class Seeds
_G.Seeds = {}

---@param Value SeedEffect
function Seeds:AddSeedEffect(Value)
end

---@param Value SeedEffect
---@return boolean
function Seeds:CanAddSeedEffect(Value)
end

function Seeds:ClearSeedEffects()
end

function Seeds:ClearStartSeed()
end

---@return integer
function Seeds:CountSeedEffects()
end

---@return integer
function Seeds.CountUnlockedSeedEffects()
end

---@param Stage LevelStage
function Seeds:ForgetStageSeed(Stage)
end

---@return integer
function Seeds:GetNextSeed()
end

---@return integer
function Seeds:GetPlayerInitSeed()
end

---@param str string
---@return SeedEffect
function Seeds.GetSeedEffect(str)
end

---@param Stage LevelStage
---@return integer
function Seeds:GetStageSeed(Stage)
end

---@return integer
function Seeds:GetStartSeed()
end

---@return string
function Seeds:GetStartSeedString()
end

---@param Value SeedEffect
---@return boolean
function Seeds:HasSeedEffect(Value)
end

function Seeds.InitSeedInfo()
end

---@return boolean
function Seeds:IsCustomRun()
end

---@return boolean
function Seeds:IsInitialized()
end

---@param Seed1 SeedEffect
---@param Seed2 SeedEffect
---@return boolean
function Seeds:IsSeedComboBanned(Seed1, Seed2)
end

---@param str string
---@return boolean
function Seeds.IsSpecialSeed(str)
end

---@param str string
---@return boolean
function Seeds.IsStringValidSeed(str)
end

---@param Value SeedEffect
function Seeds:RemoveBlockingSeedEffects(Value)
end

---@param Value SeedEffect
function Seeds:RemoveSeedEffect(Value)
end

function Seeds:Reset()
end

---@param CurrentChallenge Challenge
function Seeds:Restart(CurrentChallenge)
end

---@param seed integer
---@return string
function Seeds.Seed2String(seed)
end

---@param StartSeed string
function Seeds:SetStartSeed(StartSeed)
end

---@param str string
---@return integer
function Seeds.String2Seed(str)
end



---@class Game
---@field BlueWombParTime integer
---@field BossRushParTime integer
---@field Challenge Challenge
---@field Difficulty Difficulty @const
---@field ScreenShakeOffset Vector @const
---@field TimeCounter integer
local Game = {}

---@return Game
function _G.Game()
end

function Game:AddDevilRoomDeal()
end

---@param Boss EntityType
---@param Variant integer
function Game:AddEncounteredBoss(Boss, Variant)
end

---@param Duration integer
function Game:AddPixelation(Duration)
end

function Game:AddStageWithoutDamage()
end

function Game:AddStageWithoutHeartsPicked()
end

function Game:AddTreasureRoomsVisited()
end

---@param Position Vector
---@param Damage number
---@param Radius number
---@param LineCheck? boolean @default: `true`
---@param Source? Entity @default: `nil`
---@param TearFlags? TearFlags @default: `TearFlags.TEAR_NORMAL`
---@param DamageFlags? integer @default: `DamageFlags.DAMAGE_EXPLOSION`
---@param DamageSource? boolean @default: `false`
function Game:BombDamage(Position, Damage, Radius, LineCheck, Source, TearFlags, DamageFlags, DamageSource)
end

---@param Position Vector
---@param Damage number
---@param TearFlags? TearFlags @default: `TearFlags.TEAR_NORMAL`
---@param Color? Color @default: `Color.Default`
---@param Source? Entity @default: `nil`
---@param RadiusMult? number @default: `1`
---@param LineCheck? boolean @default: `true`
---@param DamageSource? boolean @default: `false`
---@param DamageFlags? integer @default: `DamageFlags.DAMAGE_EXPLOSION`
function Game:BombExplosionEffects(Position, Damage, TearFlags, Color, Source, RadiusMult, LineCheck, DamageSource,
								   DamageFlags)
end

---@param Position Vector
---@param Radius number
---@param TearFlags TearFlags
---@param Source? Entity @default: `nil`
---@param RadiusMult? number @default: `1`
function Game:BombTearflagEffects(Position, Radius, TearFlags, Source, RadiusMult)
end

---@param Position Vector
---@param Radius number
---@param Source Entity
---@param ShowEffect boolean
---@param DoSuperKnockback boolean
function Game:ButterBeanFart(Position, Radius, Source, ShowEffect, DoSuperKnockback)
end

---@param RoomIndex integer
---@param Dimension? integer @default: `-1`
function Game:ChangeRoom(RoomIndex, Dimension)
end

---@param Position Vector
---@param Radius number
---@param Source Entity
function Game:CharmFart(Position, Radius, Source)
end

function Game:ClearDonationModAngel()
end

function Game:ClearDonationModGreed()
end

function Game:ClearStagesWithoutDamage()
end

function Game:ClearStagesWithoutHeartsPicked()
end

---@param Darkness number
---@param Timeout integer
function Game:Darken(Darkness, Timeout)
end

---@param Donate integer
function Game:DonateAngel(Donate)
end

---@param Donate integer
function Game:DonateGreed(Donate)
end

---@param Ending integer @Ending
function Game:End(Ending)
end

---@param Speed number
function Game:Fadein(Speed)
end

---@param Speed number
---@param Target integer @FadeoutTarget
function Game:Fadeout(Speed, Target)
end

---@param Position Vector
---@param Radius? number @default: `85`
---@param Source? Entity @default: `nil`
---@param FartScale? number @default: `1`
---@param FartSubType? integer @default: `0`
---@param FartColor? Color @default: `Color.Default`
function Game:Fart(Position, Radius, Source, FartScale, FartSubType, FartColor)
end

function Game:FinishChallenge()
end

---@return userdata @Ambush
function Game:GetAmbush()
end

---@return number
function Game:GetDarknessModifier()
end

---@return integer
function Game:GetDevilRoomDeals()
end

---Returns how many times you've donated to a donation machine this floor, used for increasing angel deal chance when after 10 coins donated. Resets on the next floor.
---@return integer
function Game:GetDonationModAngel()
end

---Used for Greed Donation Machine jam chance.
---@return integer
function Game:GetDonationModGreed()
end

---@return Font
function Game:GetFont()
end

---@return integer
function Game:GetFrameCount()
end

---@return integer
function Game:GetGreedBossWaveNum()
end

---@return integer
function Game:GetGreedWavesNum()
end

---@return HUD
function Game:GetHUD()
end

---@return ItemPool
function Game:GetItemPool()
end

---@return LevelStage
function Game:GetLastDevilRoomStage()
end

---@return LevelStage
function Game:GetLastLevelWithDamage()
end

---@return LevelStage
function Game:GetLastLevelWithoutHalfHp()
end

---@return Level
function Game:GetLevel()
end

---@param Pos Vector
---@return EntityPlayer
function Game:GetNearestPlayer(Pos)
end

---@return integer
function Game:GetNumEncounteredBosses()
end

---@return integer
function Game:GetNumPlayers()
end

---@param Index integer
---@return EntityPlayer
function Game:GetPlayer(Index)
end

---@param Pos Vector
---@param Radius number
---@return EntityPlayer
function Game:GetRandomPlayer(Pos, Radius)
end

---@return Room
function Game:GetRoom()
end

---@return integer
function Game:GetScreenShakeCountdown()
end

---@return Seeds
function Game:GetSeeds()
end

---@return integer
function Game:GetStagesWithoutDamage()
end

---@return integer
function Game:GetStagesWithoutHeartsPicked()
end

---@param GameStateFlag GameStateFlag
---@return boolean
function Game:GetStateFlag(GameStateFlag)
end

---@return number
function Game:GetTargetDarkness()
end

---@return integer
function Game:GetTreasureRoomVisitCount()
end

---@return integer
function Game:GetVictoryLap()
end

---@param Boss EntityType
---@param Variant integer
---@return boolean
function Game:HasEncounteredBoss(Boss, Variant)
end

---@return boolean
function Game:HasHallucination()
end

---@return boolean
function Game:IsGreedMode()
end

---@return boolean
function Game:IsPaused()
end

---@param IAmErrorRoom boolean
---@param Seed integer
---@param Player EntityPlayer
function Game:MoveToRandomRoom(IAmErrorRoom, Seed, Player)
end

function Game:NextVictoryLap()
end

function Game:Render()
end

---@param e Entity
---@return boolean
function Game:RerollEnemy(e)
end

function Game:RerollLevelCollectibles()
end

---@param Seed integer
function Game:RerollLevelPickups(Seed)
end

---@param Stage LevelStage
function Game:SetLastDevilRoomStage(Stage)
end

---@param Stage LevelStage
function Game:SetLastLevelWithDamage(Stage)
end

---@param Stage LevelStage
function Game:SetLastLevelWithoutHalfHp(Stage)
end

---@param GameStateFlag GameStateFlag
---@param Val boolean
function Game:SetStateFlag(GameStateFlag, Val)
end

---@param Timeout integer
function Game:ShakeScreen(Timeout)
end

function Game:ShowFortune()
end

---@param FrameCount integer
---@param Backdrop? BackdropType @default: `BackdropType.NUM_BACKDROPS`
function Game:ShowHallucination(FrameCount, Backdrop)
end

function Game:ShowRule()
end

---@param Type EntityType
---@param Variant integer
---@param Position Vector
---@param Velocity Vector
---@param Spawner Entity?
---@param SubType integer
---@param Seed integer
---@return Entity
function Game:Spawn(Type, Variant, Position, Velocity, Spawner, SubType, Seed)
end

---@param desc userdata @EntityDesc
---@param Position Vector
---@param Spawner Entity
---@return EntityNPC
function Game:SpawnEntityDesc(desc, Position, Spawner)
end

---@param Pos Vector
---@param ParticleType EffectVariant
---@param NumParticles integer
---@param Speed number
---@param Color? Color @default: `Color.Default`
---@param Height? number @default: `100000`
---@param SubType? integer @default: `0`
function Game:SpawnParticles(Pos, ParticleType, NumParticles, Speed, Color, Height, SubType)
end

---@param RoomIndex integer
---@param Direction Direction
---@param Animation? RoomTransitionAnim @default: `RoomTransitionAnim.WALK`
---@param Player? EntityPlayer @default: `nil`
---@param Dimension? integer @default: `-1`
function Game:StartRoomTransition(RoomIndex, Direction, Animation, Player, Dimension)
end

function Game:Update()
end

---@param Position Vector
---@param Force? number @default: `10`
---@param Radius? number @default: `250`
function Game:UpdateStrangeAttractor(Position, Force, Radius)
end

---For reference, Monstro's stomp has Amplitude=0.035, Speed=0.025, Duration=10
---@param Position Vector
---@param Amplitude number
---@param Speed number
---@param Duration integer
function Game:MakeShockwave(Position, Amplitude, Speed, Duration)
end


---@diagnostic disable: inject-field
---Returns true if achievements can't be unlocked this run.
---@return boolean
function Game:AchievementUnlocksDisallowed()
end

---Adds a debug flag to the game. Multiple can be added simultaneously with 
---bitwise concatenation (e.g. 
---`DebugFlag.ENTITY_POSITIONS | DebugFlag.HITSPHERES`).
---@param flags DebugFlag
function Game:AddDebugFlags(flags)
end

---Devolves an enemy, as if the item D10 was used on it.
---@param entity Entity
function Game:DevolveEnemy(entity)
end

---@return ChallengeParams
function Game:GetChallengeParams()
end

---Returns the current color modifier for the screen.
---@return ColorModifier
function Game:GetCurrentColorModifier()
end

---Returns a DebugFlags bitmask.
---@return DebugFlag
function Game:GetDebugFlags()
end

---Deprecated as `ItemOverlay` is now a global table.
---@deprecated
---@return userdata @ItemOverlay
function Game:GetItemOverlay()
end

---Returns the lerped color modifier. This is formatted as the absolute 
---rate of change (ie, all values are positive).
---@return ColorModifier
function Game:GetLerpColorModifier()
end

---@return PauseMenuStates
function Game:GetPauseMenuState()
end

---Returns the amount of planetariums that have been entered in the current run.
---@return integer
function Game:GetPlanetariumsVisited()
end

---Returns the target ColorModifier.
---If currently lerping between two ColorModifier states, returns the target state.
---It is otherwise the same as `Game:GetCurrentColorModifier`.
---@return ColorModifier
function Game:GetTargetColorModifier()
end

---Returns true if the entity was erased for the run.
---@param entity Entity
---@return boolean
---@overload fun(self: Game, type: EntityType, variant?: integer, subType?: integer): boolean
function Game:IsErased(entity)
end

---Returns `true` if the next or current wave is a boss wave. Returns `false`
---otherwise or if not in Greed Mode.
---@return boolean
function Game:IsGreedBoss()
end

---Returns `true` if the next or current wave is the optional "nightmare" wave. Returns `false` otherwise or if not in Greed Mode.
---@return boolean
function Game:IsGreedFinalBoss()
end

---Returns `true` if current mode is Hard Mode or Greedier
---@return boolean
function Game:IsHardMode()
end

---@return boolean
function Game:IsPauseMenuOpen()
end

---Returns `true` if the current run is a rerun.
---@return boolean
function Game:IsRerun()
end

---Sets marks and unlocks achievements associated with this type for all players. Used by the game to award marks as well as tainted completion paper groups.
---@param completionType CompletionType
function Game:RecordPlayerCompletion(completionType)
end

---@param colorModifier ColorModifier
---@param lerp? boolean @default: `true`
---@param rate? number @default: `0.015`.
function Game:SetColorModifier(colorModifier, lerp, rate)
end

---TODO: Document me!
function Game:ShowGenericLeaderboard()
end

---@param position Vector
---@return Entity
function Game:SpawnBombCrater(position)
end

---@param SameStage boolean
---@param Animation integer @StageTransition::Animation
---@param Player? EntityPlayer
function Game:StartStageTransition(SameStage, Animation, Player)
end

---Sets how many times you've donated to a donation machine this floor, used for increasing angel deal chance when after 10 coins donated. Resets on the next floor.
---@param donation integer
function Game:SetDonationModAngel(donation)
end

---Sets how many times you've donated to a donation machine this floor, used for Greed Donation Machine jam chance. Resets on the next floor.
---@param donation integer
function Game:SetDonationModGreed(donation)
end

---Sets the dizzy amount akin to Wavy Cap. The current intensity of the effect will gradually move towards the "TargetIntensity".
---
---**NOTE**: Best to stay within `0`-`1` and increment by `0.1` while using this function. `1` has the most extreme effect on the screen while `0` removes the effect.
---@param TargetIntensity number @If provided, the current intensity is instantly changed to that amount. If unspecified, the current intensity will remain unchanged.
---@param CurrentIntensity? number @Starting intensity of the effect.
function Game:SetDizzyAmount(TargetIntensity, CurrentIntensity)
end

---Returns the current dizzy amount akin to Wavy Cap.
---@return integer
function Game:GetDizzyAmount()
end

---@param duration number
---@param amount number
function Game:SetBloom(duration, amount)
end

---Clears out all enemies listed as an erased enemy, allowing them to spawn again.
function Game:ClearErasedEnemies()
end

---Returns the amount of shops the player has entered this run.
---@return integer
function Game:GetShopVisits()
end

---Adds the amount of shops the player has entered this run.
---@param count integer
function Game:AddShopVisits(count)
end

---Returns the currently active `GenericPrompt` object.
---**BUG**: Will crash if used during a run while no generic prompt is active.
---@return GenericPrompt
function Game:GetGenericPrompt()
end

---@class BitSet128
---@field l integer
---@field h integer
---@operator bnot: BitSet128
---@operator bor(BitSet128): BitSet128
---@operator band(BitSet128): BitSet128
---@operator bxor(BitSet128): BitSet128
---@operator shl(BitSet128): BitSet128
---@operator shr(BitSet128): BitSet128

---@param l? integer @default = `0`
---@param h? integer @default = `0`
---@return BitSet128
function _G.BitSet128(l, h)
end


---@class ActiveItemDesc
---@field BatteryCharge integer
---@field Charge integer
---@field Item CollectibleType
---@field PartialCharge number
---@field SubCharge integer
---@field TimedRechargeCooldown integer
---@field VarData integer
local ActiveItemDesc = {}



---@class GridEntityDesc
---@field Initialized boolean
---@field SpawnCount integer
---@field SpawnSeed integer
---@field State integer
---@field Type GridEntityType
---@field VarData integer
---@field VariableSeed integer
---@field Variant integer
local GridEntityDesc = {}



---@class KColor
---@field Alpha number
---@field Blue number
---@field Green number
---@field Red number
local KColor = {}

---@param red number
---@param green number
---@param blue number
---@param alpha number
---@return KColor
function _G.KColor(red, green, blue, alpha)
end

_G.KColor = {
	---@type KColor
	Black = 		KColor(0,0,0,1),
	---@type KColor
	Red = 			KColor(1,0,0,1),
	---@type KColor
	Green = 		KColor(0,1,0,1),
	---@type KColor
	Blue = 			KColor(0,0,1,1),
	---@type KColor
	Yellow = 		KColor(1,1,0,1),
	---@type KColor
	Cyan = 			KColor(0,1,1,1),
	---@type KColor
	Magenta = 		KColor(1,0,1,1),
	---@type KColor
	White = 		KColor(1,1,1,1),
	---@type KColor
	Transparent = 	KColor(0,0,0,0),
}

---@class RNG
local RNG = {}

---Returns the current seed of the RNG object.
---@return integer
function RNG:GetSeed()
end

---"Iterates" the RNG's seed to the next random number in the psuedo-random sequence. (The internal PRNG algorithm used is Xorshift.)
---@return integer --Integer returned is the new seed of the RNG object.
function RNG:Next()
end

---Returns a float between `0` (inclusive) and `1` (exclusive).
---
---Note that this will automatically call the `RNG.Next` method before retrieving the random number. Since this mutates the RNG object, you should use this method with care.
---@return number
function RNG:RandomFloat()
end


---@param Seed? integer @default: `2853650767`
---@param ShiftIdx? integer @default: `35`
---@return RNG
function _G.RNG(Seed, ShiftIdx)
end

---@overload fun(self: RNG, Min: integer, Max: integer): integer
---@return integer
function RNG:RandomInt(Max)
end

---@param Seed integer
---@param ShiftIdx? integer
function RNG:SetSeed(Seed, ShiftIdx)
end

---Returns a float between `0` (inclusive) and `1` (exclusive).
---
---This does not advance the internal state of the RNG object.
---@return number
function RNG:PhantomFloat()
end

---Returns an integer between `0` (inclusive) and the max value (exclusive).
---
---This does not advance the internal state of the RNG object.
---@param max integer
---@return integer
function RNG:PhantomInt(max)
end

---Returns a random vector with length `1`.
---
---This does not advance the internal state of the RNG object.
---@return Vector
function RNG:PhantomVector()
end

---Returns a random vector with length `1`.
---@return Vector
function RNG:RandomVector()
end

---Returns the shift index used by the RNG object. By default, vanilla RNG objects use `35`.
---@return integer
function RNG:GetShiftIdx()
end

---Similar to `:Next()`, except it does not affect the internal state of the RNG object and serves to only return its seed if it did.
---@return integer
function RNG:PhantomNext()
end

---"Iterates" the RNG's seed to the previous random number in the psuedo-random sequence. (The internal PRNG algorithm used is Xorshift.)
---@return integer --Integer returned is the new seed of the RNG object.
function RNG:Previous()
end

---Similar to `:Previous()`, except it does not affect the internal state of the RNG object and serves to only return its seed if it did.
---@return integer
function RNG:PhantomPrevious()
end


---@class ModReference
---@field Name string
local ModReference = {}

---@param callbackID ModCallbacks | string
---@param callbackFn function
---@param entityID? integer
function ModReference:AddCallback(callbackID, callbackFn, entityID)
end

---@param callbackID ModCallbacks | string
---@param priority CallbackPriority
---@param callbackFn function
---@param entityID? integer
function ModReference:AddPriorityCallback(callbackID, priority, callbackFn, entityID)
end

---@return boolean
function ModReference:HasData()
end

---@return string
function ModReference:LoadData()
end

---@param callbackID integer
---@param callbackFn function
function ModReference:RemoveCallback(callbackID, callbackFn)
end

function ModReference:RemoveData()
end

---@param data string
function ModReference:SaveData(data)
end

-- Disabled as it will complain about mod tables with added functions
-- in mods with more files, depending on how they are handled; you can
-- re-enable it and keep it if you don't have that problem
--[[ ---@param modname string
---@param apiversion number
---@return ModReference
function RegisterMod(modname, apiversion)
end ]]

---@class ItemConfigCostume
---@field Anm2Path string
---@field HasOverlay boolean
---@field HasSkinAlt boolean
---@field ID integer
---@field IsFlying boolean
---@field OverwriteColor boolean
---@field Priority integer
---@field SkinColor SkinColor
local ItemConfigCostume = {}


---@class ItemConfigPillEffect
---@field AchievementID integer
---@field GreedModeAllowed boolean
---@field ID integer
---@field Name string
---@field AnnouncerVoice integer # accepts any value from the SoundEffect.SOUND_* enum
---@field AnnouncerVoiceSuper integer # accepts any value from the SoundEffect.SOUND_* enum
---@field AnnouncerDelay integer
---@field MimicCharge integer
---@field EffectClass integer
---@field EffectSubClass integer
local ItemConfigPillEffect = {}

---@return boolean
function ItemConfigPillEffect:IsAvailable()
end


---@class ItemConfigCard
---@field AchievementID integer
---@field Description string
---@field GreedModeAllowed boolean
---@field HudAnim string
---@field ID integer
---@field Name string
---@field PickupSubtype integer
---@field CardType integer @Accepts any value from the ItemConfig.CARDTYPE_* enum
---@field AnnouncerVoice integer @Accepts any value from the SoundEffect.SOUND_* enum
---@field AnnouncerDelay integer
---@field MimicCharge integer
local ItemConfigCard = {}

---@return boolean
function ItemConfigCard:IsCard()
end

---@return boolean
function ItemConfigCard:IsRune()
end

---@return boolean
function ItemConfigCard:IsAvailable()
end


---@class ItemConfigClass
---@field ModdedCardFront Sprite
---@field Hidden boolean
---@field InitialWeight number
---@field Weight number @Can be modified

---@return function
function ItemConfigCard:GetAvailabilityCondition()
end

---@param func function
function ItemConfigCard:SetAvailabilityCondition(func)
end

function ItemConfigCard:ClearAvailabilityCondition()
end


---@class ItemConfigItem
---@field AchievementID integer
---@field AddBlackHearts integer
---@field AddBombs integer
---@field AddCoins integer
---@field AddCostumeOnPickup boolean # Not officially documented but functional
---@field AddHearts integer
---@field AddKeys integer
---@field AddMaxHearts integer
---@field AddSoulHearts integer
---@field CacheFlags integer
---@field ChargeType integer
---@field ClearEffectsOnRemove boolean
---@field Costume ItemConfigCostume @const
---@field CraftingQuality integer
---@field Description string
---@field DevilPrice integer
---@field Discharged boolean
---@field GfxFileName string
---@field Hidden boolean
---@field ID integer
---@field InitCharge integer
---@field MaxCharges integer
---@field MaxCooldown integer
---@field Name string
---@field PassiveCache boolean
---@field PersistentEffect boolean
---@field Quality integer
---@field ShopPrice integer
---@field Special boolean
---@field Tags integer
---@field Type ItemType
local ItemConfigItem = {}

---@param Tags integer
---@return boolean
function ItemConfigItem:HasTags(Tags)
end

---@return boolean
function ItemConfigItem:IsCollectible()
end

---@return boolean
function ItemConfigItem:IsNull()
end

---@return boolean
function ItemConfigItem:IsTrinket()
end

---@return boolean
function ItemConfigItem:IsAvailable()
end


---Returns `true` if the `ItemConfigItem` has the provided `tagName` as a custom tag,
---@param tagName string
---@return boolean
function ItemConfigItem:HasCustomTag(tagName)
end

---Returns a table of strings containing the `ItemConfigItem`'s custom tags,
---@return string[]
function ItemConfigItem:GetCustomTags()
end

---Returns `true` if the `ItemConfigItem` has the provided `tagName` as a custom cache tag,
---@param tagName string
---@return boolean
function ItemConfigItem:HasCustomCacheTag(tagName)
end

---Returns a table of strings containing the `ItemConfigItem`'s custom cache tags,
---@return string[]
function ItemConfigItem:GetCustomCacheTags()
end

ItemConfig.Config = {}

---@param ID CollectibleType
---@return boolean
function ItemConfig.Config.IsValidCollectible(ID)
end

---@param Item ItemConfigItem
---@return boolean
function ItemConfig.Config.ShouldAddCostumeOnPickup(Item)
end

---@class ItemConfig
local ItemConfig_Class = {}

---@param ID Card
---@return ItemConfigCard
function ItemConfig_Class:GetCard(ID)
end

---@return CardConfigList
function ItemConfig_Class:GetCards()
end

---@param ID CollectibleType
---@return ItemConfigItem
function ItemConfig_Class:GetCollectible(ID)
end

---@return userdata
function ItemConfig_Class:GetCollectibles()
end

---@param ID NullItemID
---@return ItemConfigItem
function ItemConfig_Class:GetNullItem(ID)
end

---@return ItemConfigList
function ItemConfig_Class:GetNullItems()
end

---@param ID PillEffect
---@return ItemConfigPillEffect
function ItemConfig_Class:GetPillEffect(ID)
end

---@return PillConfigList
function ItemConfig_Class:GetPillEffects()
end

---@param ID TrinketType
---@return ItemConfigItem
function ItemConfig_Class:GetTrinket(ID)
end

---@return ItemConfigList
function ItemConfig_Class:GetTrinkets()
end


---Returns true if the collectible can be rerolled.
---@param collectible CollectibleType
---@return boolean
function ItemConfig_Class:CanRerollCollectible(collectible)
end

---Returns a table of ItemConfigItem objects with the provided tag.
---@param tag integer @Uses `ItemConfig.TAG_` enumeration
---@return ItemConfigItem[]
function ItemConfig_Class:GetTaggedItems(tag)
end

---Returns true if the trinket is valid.
---@param trinketType TrinketType
---@return boolean
function ItemConfig_Class:IsValidTrinket(trinketType)
end


---@class Entity
---@field Child Entity
---@field CollisionDamage number
---@field DepthOffset number
---@field DropSeed integer
---@field EntityCollisionClass EntityCollisionClass
---@field FlipX boolean
---@field FrameCount integer
---@field Friction number
---@field GridCollisionClass EntityGridCollisionClass
---@field HitPoints number
---@field Index integer
---@field InitSeed integer
---@field Mass number
---@field MaxHitPoints number
---@field Parent Entity
---@field Position Vector
---@field PositionOffset Vector
---@field RenderZOffset integer
---@field Size number
---@field SizeMulti Vector
---@field SpawnerEntity Entity?
---@field SpawnerType EntityType
---@field SpawnerVariant integer
---@field SpawnGridIndex integer
---@field Color Color
---@field SortingLayer SortingLayer # Affects render priority, see enum
---@field SplatColor Color
---@field SpriteOffset Vector
---@field SpriteRotation number
---@field SpriteScale Vector
---@field SubType integer
---@field Target Entity
---@field TargetPosition Vector
---@field Type EntityType
---@field Variant integer
---@field Velocity Vector
---@field Visible boolean
local Entity = {}

---@param Source EntityRef
---@param Duration integer
---@param Damage number
function Entity:AddBurn(Source, Duration, Damage)
end

---@param sourceEntity EntityRef
---@param Duration integer
function Entity:AddCharmed(sourceEntity, Duration)
end

---@param Source EntityRef
---@param Duration integer
---@param IgnoreBosses boolean
function Entity:AddConfusion(Source, Duration, IgnoreBosses)
end

---@param Flags EntityFlag
function Entity:AddEntityFlags(Flags)
end

---@param Source EntityRef
---@param Duration integer
function Entity:AddFear(Source, Duration)
end

---@param Source EntityRef
---@param Duration integer
function Entity:AddFreeze(Source, Duration)
end

---@param HitPoints number
function Entity:AddHealth(HitPoints)
end

---@param Source EntityRef
---@param Duration integer
function Entity:AddMidasFreeze(Source, Duration)
end

---@param Source EntityRef
---@param Duration integer
---@param Damage number
function Entity:AddPoison(Source, Duration, Damage)
end

---@param Source EntityRef
---@param Duration integer
function Entity:AddShrink(Source, Duration)
end

---@param Source EntityRef
---@param Duration integer
---@param SlowValue number
---@param SlowColor Color
function Entity:AddSlowing(Source, Duration, SlowValue, SlowColor)
end

---@param Velocity Vector
function Entity:AddVelocity(Velocity)
end

function Entity:BloodExplode()
end

---@return boolean
function Entity:CanShutDoors()
end

---@param Flags EntityFlag
function Entity:ClearEntityFlags(Flags)
end

---@return boolean
function Entity:CollidesWithGrid()
end

function Entity:Die()
end

---@return boolean
function Entity:Exists()
end

---@return integer
function Entity:GetBossID()
end

---@return Color
function Entity:GetColor()
end

---@return table
function Entity:GetData()
end

---@return RNG
function Entity:GetDropRNG()
end

---@return EntityFlag
function Entity:GetEntityFlags()
end

---@return Entity
function Entity:GetLastChild()
end

---@return Entity
function Entity:GetLastParent()
end

---@return Sprite
function Entity:GetSprite()
end

---@param Other Entity
---@return boolean
function Entity:HasCommonParentWithEntity(Other)
end

---@param Flags EntityFlag
---@return boolean
function Entity:HasEntityFlags(Flags)
end

---@return boolean
function Entity:HasFullHealth()
end

---@return boolean
function Entity:HasMortalDamage()
end

---@param includeDead? boolean
---@return boolean
function Entity:IsActiveEnemy(includeDead)
end

---@return boolean
function Entity:IsBoss()
end

---@return boolean
function Entity:IsDead()
end

---@return boolean
function Entity:IsEnemy()
end

---@return boolean
function Entity:IsFlying()
end

---@param Frame integer
---@param Offset integer
---@return boolean
function Entity:IsFrame(Frame, Offset)
end

---@return boolean
function Entity:IsInvincible()
end

---@return boolean
function Entity:IsVisible()
end

---@return boolean
function Entity:IsVulnerableEnemy()
end

function Entity:Kill()
end

---@param Value number
function Entity:MultiplyFriction(Value)
end

function Entity:PostRender()
end

function Entity:Remove()
end

function Entity:RemoveStatusEffects()
end

---@param Offset Vector
function Entity:Render(Offset)
end

---@param Offset Vector
---@return boolean
function Entity:RenderShadowLayer(Offset)
end

---@param Color Color
---@param Duration integer
---@param Priority integer
---@param Fadeout boolean
---@param Share boolean
function Entity:SetColor(Color, Duration, Priority, Fadeout, Share)
end

---@param Size number
---@param SizeMulti Vector
---@param NumGridCollisionPoints integer
function Entity:SetSize(Size, SizeMulti, NumGridCollisionPoints)
end

---@param AnimationName string
---@param FrameNum integer
function Entity:SetSpriteFrame(AnimationName, FrameNum)
end

---@param AnimationName string
---@param FrameNum integer
function Entity:SetSpriteOverlayFrame(AnimationName, FrameNum)
end

---@param Damage number
---@param Flags integer
---@param Source EntityRef
---@param DamageCountdown integer
---@return boolean
function Entity:TakeDamage(Damage, Flags, Source, DamageCountdown)
end

---Used to cast an `Entity` object to an `EntityBomb` object.
---@return EntityBomb? --`nil` if conversion is not successful.
function Entity:ToBomb()
end

---Used to cast an `Entity` object to an `EntityEffect` object.
---@return EntityEffect? --`nil` if conversion is not successful.
function Entity:ToEffect()
end

---Used to cast an `Entity` object to an `EntityFamiliar` object.
---@return EntityFamiliar? --`nil` if conversion is not successful.
function Entity:ToFamiliar()
end

---Used to cast an `Entity` object to an `EntityKnife` object.
---@return EntityKnife? --`nil` if conversion is not successful.
function Entity:ToKnife()
end

---Used to cast an `Entity` object to an `EntityLaser` object.
---@return EntityLaser? --`nil` if conversion is not successful.
function Entity:ToLaser()
end

---Used to cast an `Entity` object to an `EntityNPC` object.
---@return EntityNPC? --`nil` if conversion is not successful.
function Entity:ToNPC()
end

---Used to cast an `Entity` object to an `EntityPickup` object.
---@return EntityPickup? --`nil` if conversion is not successful.
function Entity:ToPickup()
end

---Used to cast an `Entity` object to an `EntityPlayer` object.
---@return EntityPlayer? --`nil` if conversion is not successful.
function Entity:ToPlayer()
end

---Used to cast an `Entity` object to an `EntityProjectile` object.
---@return EntityProjectile? --`nil` if conversion is not successful.
function Entity:ToProjectile()
end

---Used to cast an `Entity` object to an `EntityTear` object.
---@return EntityTear? --`nil` if conversion is not successful.
function Entity:ToTear()
end

function Entity:Update()
end

---@param source EntityRef
---@param duration integer
function Entity:AddBaited(source, duration)
end

---@param source EntityRef
---@param duration integer
function Entity:AddBleeding(source, duration)
end

---@param source EntityRef
---@param duration integer
function Entity:AddBrimstoneMark(source, duration)
end

---@param source EntityRef
---@param duration integer
function Entity:AddIce(source, duration)
end

---@param source EntityRef
---@param pushDirection Vector
---@param duration integer
---@param takeImpactDamage boolean
function Entity:AddKnockback(source, pushDirection, duration, takeImpactDamage)
end

---@param source EntityRef
---@param duration integer
function Entity:AddMagnetized(source, duration)
end

---@param source EntityRef
---@param duration integer
function Entity:AddWeakness(source, duration)
end

---@param initialLength integer
---@param source EntityRef
---@return integer
function Entity:ComputeStatusEffectDuration(initialLength, source)
end

---@param target? Entity @default: `nil`. If `nil`, this will recursively copy status effects to all Child Entities.
---@param overwrite? boolean @default: `false`. If `true`, removes all other status effects from `target`, and sets the properties of existing once to match the entity. default: false
function Entity:CopyStatusEffects(target, overwrite)
end

---@param entity Entity
---@param low boolean
---@return boolean
function Entity:ForceCollide(entity, low)
end

---@return integer
function Entity:GetBaitedCountdown()
end

---@return integer
function Entity:GetBleedingCountdown()
end

---@return integer
function Entity:GetBossStatusEffectCooldown()
end

---@return integer
function Entity:GetBrimstoneMarkCooldown()
end

---@return integer
function Entity:GetBurnCountdown()
end

---@return integer
function Entity:GetBurnDamageTimer()
end

---@return integer
function Entity:GetCharmedCountdown()
end

---@param vector? Vector @default: 'Vector.Zero'
---@return Capsule
function Entity:GetCollisionCapsule(vector)
end

---If the entity recently took damage with the DAMAGE_COUNTDOWN `DamageFlag`, 
---this returns how many more frames must pass before they can take damage with 
---the DAMAGE_COUNTDOWN `DamageFlag` again.
---
---Note that this is NOT the same as the player's invincibility frames 
---(`EntityPlayer:GetDamageCooldown()`). The DAMAGE_COUNTDOWN `DamageFlag` and
---this associated countdown are typically used to control how rapidly an enemy
---will take damage from the few sources that uses that flag, such as the the
---collision damage effects from the "My Little Unicorn", "The Nail", and "The 
---Gamekid".
---@return integer
function Entity:GetDamageCountdown()
end

---@param unknown boolean
---@return Shape
function Entity:GetDebugShape(unknown)
end

--- Returns the corresponding `EntityConfig` entry for this entity.
---@return EntityConfigEntity
function Entity:GetEntityConfigEntity()
end

---@return integer
function Entity:GetFearCountdown()
end

---@return integer
function Entity:GetFireDamageCooldown()
end

---@return integer
function Entity:GetFreezeCountdown()
end

---@return integer
function Entity:GetHitListIndex()
end

---@return integer
function Entity:GetIceCountdown()
end

---@return integer
function Entity:GetKnockbackCountdown()
end

---@return Vector
function Entity:GetKnockbackDirection()
end

---@return integer
function Entity:GetMagnetizedCountdown()
end

---@return integer
function Entity:GetMidasFreezeCountdown()
end

--- Returns the minecart the entity is riding.
---
--- If the entity is not riding a minecart, the function returns nil.
---@return EntityNPC?
function Entity:GetMinecart()
end

---@param nullLayerName string
---@return Capsule
function Entity:GetNullCapsule(nullLayerName)
end

--- Returns position of null layer mark. Alternatively returns `Vector.Zero` if the layer is not visible, has no frame available for the current animation, or for other unknown reasons.
---@param nullLayerName string
---@return Vector
function Entity:GetNullOffset(nullLayerName)
end

---@return integer
function Entity:GetPauseTime()
end

---@return integer
function Entity:GetPoisonDamageTimer()
end

--- Returns 2 values, both Vectors. 1st the Position of the entity, 2nd the Velocity of the entity.
---@return PosVel
function Entity:GetPosVel()
end

---The prediction is the target's current position plus their velocity
---multiplied by the distance between this and the target. `Delay` acts
---as a multiplier for how far ahead the prediction should be. For 
---example, `1.0` would predict where the target's velocity would place 
---them on the next update.
---@param target Entity
---@param strength integer
---@return Vector
function Entity:GetPredictedTargetPosition(target, strength)
end

---@return number
function Entity:GetShadowSize()
end

---@return integer
function Entity:GetShrinkCountdown()
end

---@return integer
function Entity:GetSlowingCountdown()
end

---@return number
function Entity:GetSpeedMultiplier()
end

---@return EntityType
function Entity:GetType()
end

---@return integer
function Entity:GetWeaknessCountdown()
end

---@param position Vector
---@param velocity Vector
---@return EntityNPC
function Entity:GiveMinecart(position, velocity)
end

---@param ref EntityRef
---@return boolean
function Entity:IgnoreEffectFromFriendly(ref)
end

---This function spawns two dust poof effects of subtypes 3 and 4;
---the second of which will be the the Child of the one returned.
---@param position Vector? @default: `self.Position`
---@param color Color? @default: `Color.Default`
---@param scale? number @default: `1.0`
function Entity:MakeBloodPoof(position, color, scale)
end

---This function spawns two dust poof effects of subtypes 1 and 2;
---the second of which will be the the Child of the one returned.
---@param position Vector? @default: `self.Position`
---@param color Color? @default: `Color.Default`
---@param scale? number @default: `1.0`
function Entity:MakeGroundPoof(position, color, scale)
end

---@param countdown integer
function Entity:SetBaitedCountdown(countdown)
end

---@param countdown integer
function Entity:SetBleedingCountdown(countdown)
end

---@param cooldown integer
function Entity:SetBossStatusEffectCooldown(cooldown)
end

---@param countdown integer
function Entity:SetBrimstoneMarkCountdown(countdown)
end

---@param countdown integer
function Entity:SetBurnCountdown(countdown)
end

---@param timer integer
function Entity:SetBurnDamageTimer(timer)
end

---@param countdown integer
function Entity:SetCharmedCountdown(countdown)
end

---Sets colors to be used alongside their parameters.
---@param params ColorParams[]
function Entity:SetColorParams(params)
end

---@param countdown integer
function Entity:SetConfusionCountdown(countdown)
end

---Sets how many frames must pass before the entity can take damage that has the DAMAGE_COUNTDOWN `DamageFlag`.
---
---Note that this is NOT the same as the player's invincibility frames (`EntityPlayer:GetDamageCooldown()`). The DAMAGE_COUNTDOWN `DamageFlag` and this associated countdown are typically used to control how rapidly an enemy will take damage from the few sources that uses that flag, such as the the collision damage effects from the "My Little Unicorn", "The Nail", and "The Gamekid".
---@param countdown integer
function Entity:SetDamageCountdown(countdown)
end

---@param isDead boolean
function Entity:SetDead(isDead)
end

---@param countdown integer
function Entity:SetFearCountdown(countdown)
end

---@param cooldown integer
function Entity:SetFireDamageCooldown(cooldown)
end

---@param countdown integer
function Entity:SetFreezeCountdown(countdown)
end

---@param countdown integer
function Entity:SetIceCountdown(countdown)
end

---@param isInvincible boolean
function Entity:SetInvincible(isInvincible)
end

---@param countdown integer
function Entity:SetKnockbackCountdown(countdown)
end

---@param direction Vector
function Entity:SetKnockbackDirection(direction)
end

---@param countdown integer
function Entity:SetMagnetizedCountdown(countdown)
end

---@param countdown integer
function Entity:SetMidasFreezeCountdown(countdown)
end

---@param duration integer
function Entity:SetPauseTime(duration)
end

---@param countdown integer
function Entity:SetPoisonCountdown(countdown)
end

---@param timer integer
function Entity:SetPoisonDamageTimer(timer)
end

---@param size number
function Entity:SetShadowSize(size)
end

---@param countdown integer
function Entity:SetShrinkCountdown(countdown)
end

---@param countdown integer
function Entity:SetSlowingCountdown(countdown)
end

---@param amount number
function Entity:SetSpeedMultiplier(amount)
end

---@param countdown integer
function Entity:SetWeaknessCountdown(countdown)
end

---@param subType? integer @default: `0`
---@param position? Vector @default: `self.Position`
---@param offset? Vector @default: `Vector.Zero`
---@param color? Color @default: `Color.Default`
---@param velocity? Vector @default: `Vector.Zero`
---@return EntityEffect
function Entity:SpawnBloodEffect(subType, position, offset, color, velocity)
end

---@param position Vector
---@param velocity Vector
---@param strength integer
function Entity:SpawnWaterImpactEffects(position, velocity, strength)
end

---Deprecated in favor of `Entity:SpawnWaterImpactEffects()`
---@deprecated
---@param position Vector
---@param velocity Vector
---@param strength integer
function Entity:SpawnGroundImpactEffects(position, velocity, strength)
end

function Entity:TeleportToRandomPosition()
end

---Used to cast an `Entity` object to an `EntityDelirium` object. 
---The conversion will only succeed if the source entity is an instance 
---of Delirium (in its normal form or in a transformed form).
---@return EntityDelirium? `nil` is conversion is not successful
function Entity:ToDelirium()
end

---Used to cast an `Entity` object to an `EntitySlot` object.
---@return EntitySlot? `nil` if conversion is not successful.
function Entity:ToSlot()
end

---@param source EntityRef
---@param throwDirection Vector
---@param force number
function Entity:TryThrow(source, throwDirection, force)
end


---@class EntityEffect : Entity
---@field DamageSource integer
---@field FallingAcceleration number
---@field FallingSpeed number
---@field IsFollowing boolean
---@field LifeSpan integer
---@field m_Height number
---@field MaxRadius number
---@field MinRadius number
---@field ParentOffset Vector
---@field Rotation number
---@field Scale number
---@field State integer
---@field Timeout integer
_G.EntityEffect = {}

---@param Parent Entity
function EntityEffect:FollowParent(Parent)
end

---@param Variant integer
---@return boolean
function EntityEffect.IsPlayerCreep(Variant)
end

---@param DamageSource EntityType
function EntityEffect:SetDamageSource(DamageSource)
end

---@param min number
---@param max number
function EntityEffect:SetRadii(min, max)
end

---@param Timeout integer
function EntityEffect:SetTimeout(Timeout)
end



---@param position Vector
---@param scale number default: RandomFloat[`0.0`-`0.1`]
---@param lifespan? integer @default: `1`
---@param state? integer @default: `6`
---@param color? Color @default: `Color.Default`
---@return EntityEffect
function EntityEffect.CreateLight(position, scale, lifespan, state, color)
end


---@class EntityNPC : Entity
---@field CanShutDoors boolean
---@field ChildNPC EntityNPC @const
---@field EntityRef Entity
---@field GroupIdx integer
---@field I1 integer
---@field I2 integer
---@field ParentNPC EntityNPC @const
---@field Pathfinder PathFinder
---@field ProjectileCooldown integer
---@field ProjectileDelay integer
---@field Scale number
---@field State integer
---@field StateFrame integer
---@field V1 Vector
---@field V2 Vector
_G.EntityNPC = {}

---@param HorizontalAnim string
---@param VerticalAnim string
---@param SpeedThreshold number
function EntityNPC:AnimWalkFrame(HorizontalAnim, VerticalAnim, SpeedThreshold)
end

---@param DistanceLimit number
---@return Vector
function EntityNPC:CalcTargetPosition(DistanceLimit)
end

---@param Velocity Vector
---@return boolean
function EntityNPC:CanBeDamagedFromVelocity(Velocity)
end

---@return boolean
function EntityNPC:CanReroll()
end

---@param NumProjectiles integer
---@param TargetPos Vector
---@param TrajectoryModifier number
---@param Params ProjectileParams
---@return EntityProjectile
function EntityNPC:FireBossProjectiles(NumProjectiles, TargetPos, TrajectoryModifier, Params)
end

---@param Pos Vector
---@param Velocity Vector
---@param Mode integer @ProjectilesMode
---@param Params ProjectileParams
function EntityNPC:FireProjectiles(Pos, Velocity, Mode, Params)
end

---@return integer
function EntityNPC:GetAliveEnemyCount()
end

---@return integer
function EntityNPC:GetBossColorIdx()
end

---@return integer
function EntityNPC:GetChampionColorIdx()
end

---@return Entity
function EntityNPC:GetPlayerTarget()
end

---@return boolean
function EntityNPC:IsBoss()
end

---@return boolean
function EntityNPC:IsChampion()
end

function EntityNPC:KillUnique()
end

---@param Seed integer
---@param ChampionColorIdx? ChampionColor @default: `-1`
---@param Init? boolean @default: `false`
function EntityNPC:MakeChampion(Seed, ChampionColorIdx, Init)
end

---@param Size number
---@return EntityEffect
function EntityNPC:MakeSplat(Size)
end

---@param type EntityType
---@param Variant integer
---@param SubType integer
---@param ChampionColorIdx integer
---@return boolean
function EntityNPC:Morph(type, Variant, SubType, ChampionColorIdx)
end


---@param GroupIdx integer
---@return EntityList
function EntityNPC:QueryNPCsGroup(GroupIdx)
end

---@param SpawnerType EntityType
---@param Type EntityType
---@param OnlyEnemies boolean
---@return EntityList
function EntityNPC:QueryNPCsSpawnerType(SpawnerType, Type, OnlyEnemies)
end

---@param Type EntityType
---@param Variant integer
---@return EntityList
function EntityNPC:QueryNPCsType(Type, Variant)
end

function EntityNPC:ResetPathFinderTarget()
end

---@param Position Vector
---@param Spawner? Entity
---@param TargetPos Vector
---@param Big boolean
---@param YOffset number
---@return EntityNPC
function EntityNPC.ThrowSpider(Position, Spawner, TargetPos, Big, YOffset)
end


---Same as `FireBossProjectiles`, but returns a table containing the list of
---spawned projectiles.
---@param NumProjectiles integer
---@param TargetPos Vector
---@param TrajectoryModifier number
---@param Params ProjectileParams
---@return EntityProjectile[]
function EntityNPC:FireBossProjectilesEx(NumProjectiles, TargetPos, TrajectoryModifier, Params)
end

---@param sprite Sprite
---@param desc GridEntityDesc
---@param velocity Vector
---@param backdrop BackdropType? @default: `BackdropType.BASEMENT`.
---@return EntityProjectile
function EntityNPC:FireGridEntity(sprite, desc, velocity, backdrop)
end

---Same as `FireProjectiles`, but returns a table containing the list of 
---spawned projectiles.
---@param Position Vector
---@param Velocity Vector
---@param Mode ProjectileMode
---@param Params ProjectileParams
---@return EntityProjectile[]
function EntityNPC:FireProjectilesEx(Position, Velocity, Mode, Params)
end

---Returns the ControllerId for the NPC, which indicates which player 
---is controlling it. Will return -1 when its not being controlled by 
---any player.
---@return integer
function EntityNPC:GetControllerId()
end

---Returns the dynamic dirt color of the entity. This lets entities like 
---Nightcrawler blend in to the environment.
---@return Color
function EntityNPC:GetDirtColor()
end

---@return integer[]
function EntityNPC:GetHitList()
end

---@return number
function EntityNPC:GetShieldStrength()
end

---@param ID SoundEffect
---@param Volume? number @default: `1`
---@param FrameDelay? integer @default: `2`
---@param Loop? boolean @default: `false`
---@param Pitch? number @default: `1`
function EntityNPC:PlaySound(ID, Volume, FrameDelay, Loop, Pitch)
end

---Sets the ControllerId for the NPC, which indicates which player will 
---control it. Set it to `-1` for no player controls (back to normal behaviour).
---@param ControllerID integer
function EntityNPC:SetControllerId(ControllerID)
end

---@param Strength number
function EntityNPC:SetShieldStrength(Strength)
end

---@param Position Vector
---@param Target Vector
---@param Velocity? number @default: `-24`
---@param YOffset? number @default: `-8`
---@return EntityNPC @Returns the `EntityNPC` of the maggot being fired.
function EntityNPC:ShootMaggotProjectile(Position, Target, Velocity, YOffset)
end

---@param Position Vector
---@param Color Color
---@return EntityEffect
function EntityNPC:SpawnBloodCloud(Position, Color)
end

function EntityNPC:SpawnBloodSplash()
end

---@param Source Entity
---@param Target Vector
---@param YPosOffset? number @default: `-10`
---@param Big? boolean @default: `false`
---@return EntityNPC
function EntityNPC:ThrowLeech(Source, Target, YPosOffset, Big)
end

---@param Origin Vector
---@param Velocity Vector @default: `-8.0`
---@param YOffset? number @default: `0.0`
---@return EntityNPC
function EntityNPC:ThrowMaggotAtPos(Origin, Velocity, YOffset)
end

---@param Source Entity
---@param Target Vector
---@param Variant? integer @default: `0`
---@param YPosOffset? number @default: `-10.0`
---@return EntityNPC
function EntityNPC:ThrowRockSpider(Source, Target, Variant, YPosOffset)
end

---@param Source Entity
---@param Target Vector
---@return EntityNPC
function EntityNPC:ThrowStrider(Source, Target)
end

---Used by Lost Fly to force this NPC to focus on a specific target.
---@param Target Entity
---@param Duration integer
---@return boolean
function EntityNPC:TryForceTarget(Target, Duration)
end

---`Force` only applies to NPC poop (it's modified and then used as V1.y, 
---with V1.x being -20.0) and may be incorrect. This needs further investigation.
---@param Source EntityRef
---@param Direction Vector
---@param Force integer
---@return boolean
function EntityNPC:TryThrow(Source, Direction, Force)
end

---Instructs the entity to update its dirt color. This is generally done 
---automatically on vanilla entities.
---@param immediate boolean If true, the dirt color will be set to exactly what is beneath the entity. Otherwise, it will be updated smoothly over the course of multiple frames.
function EntityNPC:UpdateDirtColor(immediate)
end

---@return integer
function EntityNPC:GetDarkRedChampionRegenTimer()
end

---Returns the unique `LootList` used by Fireplaces.
---@return LootList
function EntityNPC:GetFireplaceLoot()
end

---Returns the unique `LootList` used by Shopkeepers.
---@return LootList
function EntityNPC:GetShopkeeperLoot()
end

---Sets an override to the return value of IsFlying, which is normally based on EntityGridCollisionClass. Can be used to make grounded enemies ignore creep, or flying enemies get hit by creep.
---@param IsFlying boolean
function EntityNPC:SetFlyingOverride(IsFlying)
end

---Removes any value set by `SetFlyingOverride()`.
function EntityNPC:ClearFlyingOverride()
end

---Will attempt to split the enemy in two like the Meat Cleaver collectible. Returns `false` if the enemy dies from the damage before they split, `true` otherwise.
---@param DefaultDamage number
---@param Source EntityRef
---@param DoScreenEffects? boolean @default: `true`
function EntityNPC:TrySplit(DefaultDamage, Source, DoScreenEffects)
end

---Similar to Sprite:ReplaceSpritesheet. Appends "_champion"/stage suffix to PngFilename if possible.
---@param LayerID integer
---@param PngFilename string
---@param LoadGraphics? boolean
function EntityNPC:ReplaceSpritesheet(LayerID, PngFilename, LoadGraphics)
end

---When Siren controls familiars, they have their own EntityPlayer in order to do so. This returns that specific player if called on Siren
---@return EntityPlayer?
function EntityNPC:GetSirenPlayerEntity()
end

---@class EntityProjectile : Entity
---@field Acceleration number
---@field ChangeFlags integer
---@field ChangeTimeout integer
---@field ChangeVelocity number
---@field CurvingStrength number
---@field Damage number
---@field DepthOffset number
---@field FallingAccel number
---@field FallingSpeed number
---@field Height number
---@field HomingStrength number
---@field ProjectileFlags ProjectileFlags
---@field Scale number
---@field WiggleFrameOffset integer
local EntityProjectile = {}

---@param Flags integer
function EntityProjectile:AddChangeFlags(Flags)
end

---@param Value number
function EntityProjectile:AddFallingAccel(Value)
end

---@param Value number
function EntityProjectile:AddFallingSpeed(Value)
end

---@param Value number
function EntityProjectile:AddHeight(Value)
end

---@param Flags integer
function EntityProjectile:AddProjectileFlags(Flags)
end

---@param Value number
function EntityProjectile:AddScale(Value)
end

---@param Flags integer
function EntityProjectile:ClearProjectileFlags(Flags)
end

---@param Flags integer
---@return boolean
function EntityProjectile:HasProjectileFlags(Flags)
end



---Deflects the projectile.
---@param velocity Vector
function EntityProjectile:Deflect(velocity)
end



---@class EntityKnife : Entity
---@field Charge number
---@field MaxDistance number
---@field PathFollowSpeed number
---@field PathOffset number
---@field Rotation number
---@field RotationOffset number
---@field Scale number
---@field TearFlags TearFlags
local EntityKnife = {}

---@param Flags TearFlags
function EntityKnife:AddTearFlags(Flags)
end

---@param Flags TearFlags
function EntityKnife:ClearTearFlags(Flags)
end

---@return number
function EntityKnife:GetKnifeDistance()
end

---@return number
function EntityKnife:GetKnifeVelocity()
end

---@return integer
function EntityKnife:GetRenderZ()
end

---@param Flags TearFlags
---@return boolean
function EntityKnife:HasTearFlags(Flags)
end

---@return boolean
function EntityKnife:IsFlying()
end

function EntityKnife:Reset()
end

---@param Speed number
function EntityKnife:SetPathFollowSpeed(Speed)
end

---@param Charge number
---@param Range number
function EntityKnife:Shoot(Charge, Range)
end



---@return integer[]
function EntityKnife:GetHitList()
end

---Returns `true` if the knife is being swung.
---@return boolean
function EntityKnife:GetIsSwinging()
end

---Sets if the knife is being swung
---@param bool boolean
function EntityKnife:SetIsSwinging(bool)
end

---Returns `true` if the using the Spirit Sword spin attack.
---@return boolean
function EntityKnife:GetIsSpinAttack()
end

---Sets if the Spirit Sword is doing its spin attack.
---@param bool boolean
function EntityKnife:SetIsSpinAttack(bool)
end

---Returns if the knife was created through the Multi Dimensional Baby effect.
---@return boolean
function EntityKnife:IsMultidimensionalTouched()
end

---Returns if the knife was created through the Angelic Prism effect.
---@return boolean
function EntityKnife:IsPrismTouched()
end

---Sets if the knife was created through the Multi Dimensional Baby effect.
---@param IsTouched boolean
function EntityKnife:SetMultidimensionalTouched(IsTouched)
end

---Sets if the knife was created through the Angelic Prism effect.
---@param IsTouched boolean
function EntityKnife:SetPrismTouched(IsTouched)
end


---@class EntityBomb : Entity
---@field ExplosionDamage number
---@field Flags TearFlags
---@field IsFetus boolean
---@field RadiusMultiplier number
local EntityBomb = {}

---@param Flags TearFlags
function EntityBomb:AddTearFlags(Flags)
end

---@param Flags TearFlags
function EntityBomb:ClearTearFlags(Flags)
end

---@param Flags TearFlags
---@return boolean
function EntityBomb:HasTearFlags(Flags)
end

---@param Countdown integer
function EntityBomb:SetExplosionCountdown(Countdown)
end



---@param layerID BombCostumeLayer
---@return Sprite
function EntityBomb:GetCostumeLayerSprite(layerID)
end

---@return integer
function EntityBomb:GetExplosionCountdown()
end

---@return number
function EntityBomb:GetFallingSpeed()
end

---@return number
function EntityBomb:GetHeight()
end

---@return integer[]
function EntityBomb:GetHitList()
end

---@return number
function EntityBomb:GetScale()
end

---@return boolean
function EntityBomb:IsLoadingCostumes()
end

---@param speed number
function EntityBomb:SetFallingSpeed(speed)
end

---@param height number
function EntityBomb:SetHeight(height)
end

---@param load? boolean @default: `true`
function EntityBomb:SetLoadCostumes(load)
end

---@param scale number
function EntityBomb:SetScale(scale)
end

function EntityBomb:UpdateDirtColor()
end

---Target angle for rocket bombs. It influences both their movement and the orientation of their sprite.
---@return number
function EntityBomb:GetRocketAngle()
end

---Target angle for rocket bombs. It influences both their movement and the orientation of their sprite.
---@param angle number
function EntityBomb:SetRocketAngle(angle)
end

---Target speed for rocket bombs. Naturally increases by 1 every frame.
---@return number
function EntityBomb:GetRocketSpeed()
end

---Target speed for rocket bombs. Naturally increases by 1 every frame.
---@param speed number
function EntityBomb:SetRocketSpeed(speed)
end

---Returns if the bomb was created through the Angelic Prism effect.
---@return boolean
function EntityBomb:IsPrismTouched()
end

---Sets if the bomb was created through the Angelic Prism effect.
---@param IsTouched boolean
function EntityBomb:SetPrismTouched(IsTouched)
end


---@class EntityFamiliar : Entity
---@field Coins integer
---@field FireCooldown integer
---@field HeadFrameDelay integer
---@field Hearts integer
---@field IsDelayed boolean # Not officially documented but functional
---@field IsFollower boolean # Not officially documented but functional
---@field Keys integer
---@field LastDirection Direction
---@field MoveDirection Direction
---@field OrbitAngleOffset number
---@field OrbitLayer integer # Not officially documented but functional
---@field OrbitSpeed number # Not officially documented but functional
---@field OrbitDistance Vector
---@field Player EntityPlayer
---@field RoomClearCount integer
---@field ShootDirection Direction
---@field State integer
_G.EntityFamiliar = {}

---@param Value integer
function EntityFamiliar:AddCoins(Value)
end

---@param Hearts integer
function EntityFamiliar:AddHearts(Hearts)
end

---@param Keys integer
function EntityFamiliar:AddKeys(Keys)
end

function EntityFamiliar:AddToDelayed()
end

function EntityFamiliar:AddToFollowers()
end

---@param Layer integer
function EntityFamiliar:AddToOrbit(Layer)
end

---@param Dir Vector
---@return EntityTear
function EntityFamiliar:FireProjectile(Dir)
end

function EntityFamiliar:FollowParent()
end

---@param Pos Vector
function EntityFamiliar:FollowPosition(Pos)
end

---@param Layer integer
---@return Vector
function EntityFamiliar.GetOrbitDistance(Layer)
end

---@param Pos Vector
---@return Vector
function EntityFamiliar:GetOrbitPosition(Pos)
end

---@param NumFrames integer
function EntityFamiliar:MoveDelayed(NumFrames)
end

---@param Speed number
function EntityFamiliar:MoveDiagonally(Speed)
end

---@param MaxDistance number
---@param FrameInterval? integer @default: `13`
---@param Flags? integer @default: `0`
---@param ConeDir? Vector @default: `Vector.Zero`
---@param ConeAngle? number @default: `15`
function EntityFamiliar:PickEnemyTarget(MaxDistance, FrameInterval, Flags, ConeDir, ConeAngle)
end

---@param Dir Direction
function EntityFamiliar:PlayChargeAnim(Dir)
end

---@param Dir Direction
function EntityFamiliar:PlayFloatAnim(Dir)
end

---@param Dir Direction
function EntityFamiliar:PlayShootAnim(Dir)
end

---@param Layer integer
---@param Add boolean
---@return integer
function EntityFamiliar:RecalculateOrbitOffset(Layer, Add)
end

function EntityFamiliar:RemoveFromDelayed()
end

function EntityFamiliar:RemoveFromFollowers()
end

function EntityFamiliar:RemoveFromOrbit()
end

---When called in POST_FAMILIAR_UPDATE on a custom familiar, appears to handle everything for a basic shooting familiar. This includes handling animations, firing tears, and synergies.
function EntityFamiliar:Shoot()
end



---@return boolean
function EntityFamiliar:CanBeDamagedByEnemies()
end

---@return boolean
function EntityFamiliar:CanBeDamagedByLasers()
end

---@return boolean
function EntityFamiliar:CanBeDamagedByProjectiles()
end

---@return boolean
function EntityFamiliar:CanBlockProjectiles()
end

---@return boolean
function EntityFamiliar:CanCharm()
end

---@return Color
function EntityFamiliar:GetDirtColor()
end

---@return FollowerPriority
function EntityFamiliar:GetFollowerPriority()
end

---@return ItemConfigItem
function EntityFamiliar:GetItemConfig()
end

---Returns the amount in frames that the familiar's movements are delayed from the player's. 30 frames = 1 second.
function EntityFamiliar:GetMoveDelayNum()
end

---@return number
function EntityFamiliar:GetMultiplier()
end

---@return PathFinder
function EntityFamiliar:GetPathFinder()
end

---Returns `nil` for familiars that don't mimic the player's attacks
---(Incubus, etc).
---@return Weapon?
function EntityFamiliar:GetWeapon()
end

---Makes it so that the next time GetMultiplier is called (which doesn't exist yet), `MC_EVALUATE_FAMILIAR_MULTIPLIER` is triggered to recalculate/allow modifying the multiplier.
function EntityFamiliar:InvalidateCachedMultiplier()
end

---@return boolean
function EntityFamiliar:IsCharmed()
end

function EntityFamiliar:RemoveFromPlayer()
end

---Sets the amount in frames that the familiar's movements are delayed from the player's. 30 frames = 1 second.
---@param delay integer
function EntityFamiliar:SetMoveDelayNum(delay)
end

---Triggers effects on the familiar as if a room was cleared and incrementing `.RoomClearCount` (i.e. Sack of pennies dropping a coin).
function EntityFamiliar:TriggerRoomClear()
end

---@param aimDirection Vector
---@param direction Direction
---@return Vector?
function EntityFamiliar:TryAimAtMarkedTarget(aimDirection, direction)
end

function EntityFamiliar:UpdateDirtColor()
end



---@class EntityLaser : Entity
---@field Angle number
---@field AngleDegrees number
---@field BlackHpDropChance number
---@field BounceLaser Entity
---@field CurveStrength number
---@field DisableFollowParent boolean
---@field EndPoint Vector
---@field FirstUpdate boolean
---@field GridHit boolean
---@field HomingLaser userdata @LaserHomingType
---@field HomingType integer @LaserHomingType
---@field IsActiveRotating boolean
---@field LaserLength number
---@field LastAngleDegrees number
---@field MaxDistance number
---@field OneHit boolean
---@field ParentOffset Vector
---@field Radius number
---@field RotationDegrees number
---@field RotationDelay integer
---@field RotationSpd number
---@field SampleLaser boolean
---@field Shrink boolean
---@field StartAngleDegrees number
---@field TearFlags TearFlags
---@field Timeout integer
_G.EntityLaser = {}

---@param Flags TearFlags
function EntityLaser:AddTearFlags(Flags)
end

---@param Start Vector
---@param Dir Vector
---@param PositionOffset Vector
---@param Parent Entity
---@param Margin number
---@return Vector
function EntityLaser.CalculateEndPoint(Start, Dir, PositionOffset, Parent, Margin)
end

---@param Flags TearFlags
function EntityLaser:ClearTearFlags(Flags)
end

---@return Vector
function EntityLaser:GetEndPoint()
end

---@return VectorList
function EntityLaser:GetNonOptimizedSamples()
end

---@return integer
function EntityLaser:GetRenderZ()
end

---@return VectorList
function EntityLaser:GetSamples()
end

---@param Flags TearFlags
---@return boolean
function EntityLaser:HasTearFlags(Flags)
end

---@return boolean
function EntityLaser:IsCircleLaser()
end

---@return boolean
function EntityLaser:IsSampleLaser()
end

---@param Delay integer
---@param AngleDegrees number
---@param RotationSpd number
---@param TimeoutComplete boolean
function EntityLaser:SetActiveRotation(Delay, AngleDegrees, RotationSpd, TimeoutComplete)
end

---@param Chance number
function EntityLaser:SetBlackHpDropChance(Chance)
end

---@param Type integer @LaserHomingType
function EntityLaser:SetHomingType(Type)
end

---@param Distance number
function EntityLaser:SetMaxDistance(Distance)
end

---@param Value boolean
function EntityLaser:SetMultidimensionalTouched(Value)
end

---@param Value boolean
function EntityLaser:SetOneHit(Value)
end

---@param Value integer
function EntityLaser:SetTimeout(Value)
end

---@param Variant integer
---@param SourcePos Vector
---@param AngleDegrees number
---@param Timeout integer
---@param PosOffset Vector
---@param Source Entity
---@return EntityLaser
function EntityLaser.ShootAngle(Variant, SourcePos, AngleDegrees, Timeout, PosOffset, Source)
end



---@return boolean
function EntityLaser:GetDisableFollowParent()
end

---@return integer[]
function EntityLaser:GetHitList()
end

---@return boolean
function EntityLaser:GetOneHit()
end

---@return number
function EntityLaser:GetScale()
end

---@return boolean
function EntityLaser:GetShrink()
end

---@return integer
function EntityLaser:GetTimeout()
end

function EntityLaser:ResetSpriteScale()
end

---@param angle number
---@param speed? number @default: `8`
function EntityLaser:RotateToAngle(angle, speed)
end

---@param isDisabled boolean
function EntityLaser:SetDisableFollowParent(isDisabled)
end

---@param scale number
function EntityLaser:SetScale(scale)
end

---@param isShrink boolean
function EntityLaser:SetShrink(isShrink)
end

---@return number
function EntityLaser:GetDamageMultiplier()
end

---@param damageMult number
function EntityLaser:SetDamageMultiplier(damageMult)
end

---Requests the laser's shape to be fully recalculated next time it updates. Can be used to force the laser to instantly change its MaxDistance/Radius instead of transitioning to it. No effect for OneHit or non-sample lasers.
function EntityLaser:RecalculateSamplesNextUpdate()
end

---Sets if the laser was created through the Multi Dimensional Baby effect.
---@return boolean
function EntityLaser:IsMultidimensionalTouched()
end

---Returns if the laser was created through the Angelic Prism effect.
---@return boolean
function EntityLaser:IsPrismTouched()
end

---Returns if the laser was created through the Angelic Prism effect.
---@return boolean
function EntityLaser:SetPrismTouched()
end

---@class EntityTear : Entity
---@field BaseDamage number @const
---@field BaseScale number @const
---@field Bounced boolean
---@field CanTriggerStreakEnd boolean
---@field ContinueVelocity Vector
---@field FallingAcceleration number
---@field FallingSpeed number
---@field Height number
---@field HomingFriction number
---@field KnockbackMultiplier number
---@field ParentOffset Vector
---@field PosDisplacement Vector @const
---@field Rotation number
---@field Scale number
---@field StickDiff Vector
---@field StickTarget Entity
---@field StickTimer integer
---@field TearFlags TearFlags
---@field TearIndex integer @const
---@field WaitFrames integer
local EntityTear = {}

---@param Flags TearFlags
function EntityTear:AddTearFlags(Flags)
end

---@param NewVariant TearVariant
function EntityTear:ChangeVariant(NewVariant)
end

---@param Flags TearFlags
function EntityTear:ClearTearFlags(Flags)
end

---@param Flags TearFlags
---@return boolean
function EntityTear:HasTearFlags(Flags)
end

---@param Intensity number
function EntityTear:SetDeadEyeIntensity(Intensity)
end

---@param Multiplier number
function EntityTear:SetKnockbackMultiplier(Multiplier)
end

---@param Offset Vector
function EntityTear:SetParentOffset(Offset)
end

---@param Value integer
function EntityTear:SetWaitFrames(Value)
end


---Returns the intensity value of the tear as a result of the Dead Eye collectible. It is between 0 and 1.
---@return number
function EntityTear:GetDeadEyeIntensity()
end

---Copies the tear and applies a black and white effect to it. This effect is the same one used by the Multidimensional Baby familiar.
---@return EntityTear newTear The newly created tear.
function EntityTear:MakeMultidimensionalCopy()
end

---Returns the tear halo sprite used by Godhead tears.
---@return Sprite
function EntityTear:GetTearHaloSprite()
end

---Returns the tear effect sprite used by tear variants like Fire Mind and Mysterious Liquid.
---@return Sprite
function EntityTear:GetTearEffectSprite()
end

---Returns the red aura sprite used by Dead Eye.
---@return Sprite
function EntityTear:GetDeadEyeSprite()
end

---@param force? boolean @default: `false`. If set to `true`, forces the tear to re-evaluate which scale animation it should be playing.
function EntityTear:ResetSpriteScale(force)
end

---Returns if the tear was created through the Multi Dimensional Baby effect.
---@return boolean
function EntityTear:IsMultidimensionalTouched()
end

---Returns if the tear was created through the Angelic Prism effect.
---@return boolean
function EntityTear:IsPrismTouched()
end

---Sets if the tear was created through the Multi Dimensional Baby effect.
---@param IsTouched boolean
function EntityTear:SetMultidimensionalTouched(IsTouched)
end

---Sets if the tear was created through the Angelic Prism effect.
---@param IsTouched boolean
function EntityTear:SetPrismTouched(IsTouched)
end


---@class EntityPlayer : Entity
---@field BabySkin BabySubType
---@field CanFly boolean
---@field ControllerIndex integer @const
---@field ControlsCooldown integer
---@field ControlsEnabled boolean
---@field Damage number
---@field FireDelay number
---@field FriendBallEnemy userdata @EntityDesc @const
---@field HeadFrameDelay integer
---@field IBSCharge number
---@field ItemHoldCooldown integer
---@field LaserColor Color
---@field Luck number
---@field MaxFireDelay number
---@field MoveSpeed number
---@field QueuedItem QueuedItemData
---@field SamsonBerserkCharge integer
---@field SecondaryActiveItem ActiveItemDesc
---@field ShotSpeed number
---@field TearColor Color
---@field TearFallingAcceleration number
---@field TearFallingSpeed number
---@field TearFlags TearFlags
---@field TearHeight number
---@field TearRange number
---@field TearsOffset Vector
local EntityPlayer = {}

---@param BlackHearts integer
function EntityPlayer:AddBlackHearts(BlackHearts)
end

---@param Amount integer
function EntityPlayer:AddBloodCharge(Amount)
end

---@param Amount integer
---@param Position Vector
---@param Target Entity?
---@return Entity
function EntityPlayer:AddBlueFlies(Amount, Position, Target)
end

---@param Position Vector
---@return Entity
function EntityPlayer:AddBlueSpider(Position)
end

---@param Amount integer
function EntityPlayer:AddBombs(Amount)
end

---@param Hearts integer
function EntityPlayer:AddBoneHearts(Hearts)
end

---@param BrokenHearts integer
function EntityPlayer:AddBrokenHearts(BrokenHearts)
end

---@param ID Card
function EntityPlayer:AddCard(ID)
end

---@param Amount integer
function EntityPlayer:AddCoins(Amount)
end

---@param Type CollectibleType
---@param Charge? integer @default: `0`
---@param FirstTimePickingUp? boolean @default: `true`
---@param Slot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
---@param VarData? integer @default: `0`
function EntityPlayer:AddCollectible(Type, Charge, FirstTimePickingUp, Slot, VarData)
end

---@param Cooldown integer
function EntityPlayer:AddControlsCooldown(Cooldown)
end

---@param Item ItemConfigItem
---@param ItemStateOnly? boolean
function EntityPlayer:AddCostume(Item, ItemStateOnly)
end

function EntityPlayer:AddCurseMistEffect()
end

function EntityPlayer:AddDeadEyeCharge()
end

function EntityPlayer:AddDollarBillEffect()
end

---@param EternalHearts integer
function EntityPlayer:AddEternalHearts(EternalHearts)
end

---@param Subtype integer
---@param Position Vector
function EntityPlayer:AddFriendlyDip(Subtype, Position)
end

---@param GigaBombs integer
function EntityPlayer:AddGigaBombs(GigaBombs)
end

function EntityPlayer:AddGoldenBomb()
end

---@param Hearts integer
function EntityPlayer:AddGoldenHearts(Hearts)
end

function EntityPlayer:AddGoldenKey()
end

---@param Hearts integer
function EntityPlayer:AddHearts(Hearts)
end

---@param Collectible CollectibleType
---@param Position Vector
---@param AdjustOrbitLayer? boolean @default: `false`
---@return EntityFamiliar
function EntityPlayer:AddItemWisp(Collectible, Position, AdjustOrbitLayer)
end

---@param Flies integer
function EntityPlayer:AddJarFlies(Flies)
end

---@param Hearts integer
function EntityPlayer:AddJarHearts(Hearts)
end

---@param Amount integer
function EntityPlayer:AddKeys(Amount)
end

---@param MaxHearts integer
---@param IgnoreKeeper? boolean
function EntityPlayer:AddMaxHearts(MaxHearts, IgnoreKeeper)
end

---@param Position Vector
---@param PlayAnim? boolean @default: `true`
---@return EntityFamiliar
function EntityPlayer:AddMinisaac(Position, PlayAnim)
end

---@param NullId NullItemID
function EntityPlayer:AddNullCostume(NullId)
end

---@param Pill PillColor
function EntityPlayer:AddPill(Pill)
end

---@param Num integer
function EntityPlayer:AddPoopMana(Num)
end

---@param Form PlayerForm
function EntityPlayer:AddPlayerFormCostume(Form)
end

function EntityPlayer:AddPrettyFly()
end

---@param RottenHearts integer
function EntityPlayer:AddRottenHearts(RottenHearts)
end

---@param Amount integer
function EntityPlayer:AddSoulCharge(Amount)
end

---@param SoulHearts integer
function EntityPlayer:AddSoulHearts(SoulHearts)
end

---@param Position Vector
---@return EntityFamiliar
function EntityPlayer:AddSwarmFlyOrbital(Position)
end

---@param Type TrinketType
---@param FirstTimePickingUp? boolean @default: `true`
function EntityPlayer:AddTrinket(Type, FirstTimePickingUp)
end

---@param Collectible CollectibleType
---@param Position Vector
---@param AdjustOrbitLayer? boolean @default: `false`
---@param DontUpdate? boolean @default: `false`
---@return EntityFamiliar
function EntityPlayer:AddWisp(Collectible, Position, AdjustOrbitLayer, DontUpdate)
end

function EntityPlayer:AnimateAppear()
end

---@param ID Card
---@param AnimName? string @default: `"Pickup"`
function EntityPlayer:AnimateCard(ID, AnimName)
end

---@param Collectible CollectibleType
---@param AnimName? string @default: `"Pickup"`
---@param SpriteAnimName? string @default: `"PlayerPickupSparkle"`
function EntityPlayer:AnimateCollectible(Collectible, AnimName, SpriteAnimName)
end

function EntityPlayer:AnimateHappy()
end

function EntityPlayer:AnimateLightTravel()
end

---@param sprite Sprite
---@param HideShadow? boolean @default: `false`
---@param AnimName? string @default: `"Pickup"`
function EntityPlayer:AnimatePickup(sprite, HideShadow, AnimName)
end

---@param Pill PillColor
---@param AnimName? string @default: `"Pickup"`
function EntityPlayer:AnimatePill(Pill, AnimName)
end

function EntityPlayer:AnimatePitfallIn()
end

function EntityPlayer:AnimatePitfallOut()
end

function EntityPlayer:AnimateSad()
end

---@param Up? boolean
function EntityPlayer:AnimateTeleport(Up)
end

function EntityPlayer:AnimateTrapdoor()
end

---@param Trinket TrinketType
---@param AnimName? string @default: `"Pickup"`
---@param SpriteAnimName? string @default: `"PlayerPickupSparkle"`
function EntityPlayer:AnimateTrinket(Trinket, AnimName, SpriteAnimName)
end

---@return boolean
function EntityPlayer:AreControlsEnabled()
end

---@return boolean
function EntityPlayer:AreOpposingShootDirectionsPressed()
end

---@param Type? CollectibleType @default: `CollectibleType.COLLECTIBLE_NULL`
---@return boolean
function EntityPlayer:CanAddCollectible(Type)
end

---@return boolean
function EntityPlayer:CanPickBlackHearts()
end

---@return boolean
function EntityPlayer:CanPickBoneHearts()
end

---@return boolean
function EntityPlayer:CanPickGoldenHearts()
end

---@return boolean
function EntityPlayer:CanPickRedHearts()
end

---@return boolean
function EntityPlayer:CanPickRottenHearts()
end

---@return boolean
function EntityPlayer:CanPickSoulHearts()
end

---@return boolean
function EntityPlayer:CanPickupItem()
end

---@return boolean
function EntityPlayer:CanShoot()
end

---@return boolean
function EntityPlayer:CanTurnHead()
end

---@param PlayerType PlayerType
function EntityPlayer:ChangePlayerType(PlayerType)
end

---@param FamiliarVariant integer
---@param TargetCount integer
---@param rng RNG
---@param SourceItemConfigItem? ItemConfigItem @default: `nil`
---@param FamiliarSubType? integer @default: `-1`
function EntityPlayer:CheckFamiliar(FamiliarVariant, TargetCount, rng, SourceItemConfigItem, FamiliarSubType)
end

function EntityPlayer:ClearCostumes()
end

function EntityPlayer:ClearTemporaryEffects()
end

---@param ActiveSlot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
function EntityPlayer:DischargeActiveItem(ActiveSlot)
end

---@param Luck integer
function EntityPlayer:DonateLuck(Luck)
end

---@param Direction Vector
function EntityPlayer:DoZitEffect(Direction)
end

---@param PocketNum integer
---@param Pos Vector
function EntityPlayer:DropPocketItem(PocketNum, Pos)
end

---@param DropPos Vector
---@param ReplaceTick? boolean
function EntityPlayer:DropTrinket(DropPos, ReplaceTick)
end

function EntityPlayer:EvaluateItems()
end

---@param Position Vector
---@param Velocity Vector
---@param Source? Entity @default: `nil`
---@return EntityBomb
function EntityPlayer:FireBomb(Position, Velocity, Source)
end

---@param Direction Vector
---@param Source? Entity @default: `nil`
---@param DamageMultiplier? number @default: `1`
---@return EntityLaser
function EntityPlayer:FireBrimstone(Direction, Source, DamageMultiplier)
end

---@param Angle number
---@param Parent Entity
---@return EntityLaser
function EntityPlayer:FireDelayedBrimstone(Angle, Parent)
end

---@param Parent Entity
---@param RotationOffset? number @default: `0`
---@param CantOverwrite? boolean @default: `false`
---@param SubType? integer @default: `0`
---@param Variant? integer @default: `0`
---@return EntityKnife
function EntityPlayer:FireKnife(Parent, RotationOffset, CantOverwrite, SubType, Variant)
end

---@param Position Vector
---@param Velocity Vector
---@param CanBeEye? boolean @default: `true`
---@param NoTractorBeam? boolean @default: `false`
---@param CanTriggerStreakEnd? boolean @default: `true`
---@param Source? Entity @default: `nil`
---@param DamageMultiplier? number @default: `1`
---@return EntityTear
function EntityPlayer:FireTear(Position, Velocity, CanBeEye, NoTractorBeam, CanTriggerStreakEnd, Source, DamageMultiplier)
end

---@param Position Vector
---@param OffsetID LaserOffset
---@param Direction Vector
---@param LeftEye? boolean
---@param OneHit? boolean @default: `false`
---@param Source? Entity @default: `nil`
---@param DamageMultiplier? number @default: `1`
---@return EntityLaser
function EntityPlayer:FireTechLaser(Position, OffsetID, Direction, LeftEye, OneHit, Source, DamageMultiplier)
end

---@param Position Vector
---@param Direction Vector
---@param Radius number
---@param Source? Entity @default: `nil`
---@param DamageMultiplier? number @default: `1`
---@return EntityLaser
function EntityPlayer:FireTechXLaser(Position, Direction, Radius, Source, DamageMultiplier)
end

---@return boolean
function EntityPlayer:FlushQueueItem()
end

---@param ActiveSlot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
---@param Force? boolean @default: `false`
---@return boolean
function EntityPlayer:FullCharge(ActiveSlot, Force)
end

---@param ActiveSlot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
---@return integer
function EntityPlayer:GetActiveCharge(ActiveSlot)
end

---@param ActiveSlot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
---@return CollectibleType
function EntityPlayer:GetActiveItem(ActiveSlot)
end

---@param ActiveSlot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
---@return integer
function EntityPlayer:GetActiveSubCharge(ActiveSlot)
end

---@return Entity
function EntityPlayer:GetActiveWeaponEntity()
end

---@return Vector
function EntityPlayer:GetAimDirection()
end

---@return BabySubType
function EntityPlayer:GetBabySkin()
end

---@param ActiveSlot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
---@return integer
function EntityPlayer:GetBatteryCharge(ActiveSlot)
end

---@return integer
function EntityPlayer:GetBlackHearts()
end

---@return integer
function EntityPlayer:GetBloodCharge()
end

---@return SkinColor
function EntityPlayer:GetBodyColor()
end

---@return integer
function EntityPlayer:GetBombFlags()
end

---@param TearFlags TearFlags
---@param ForceSmallBomb? boolean
---@return BombVariant
function EntityPlayer:GetBombVariant(TearFlags, ForceSmallBomb)
end

---@return integer
function EntityPlayer:GetBoneHearts()
end

---@return integer
function EntityPlayer:GetBrokenHearts()
end

---@param SlotId integer
---@return Card
function EntityPlayer:GetCard(SlotId)
end

---@param ID Card
---@return RNG
function EntityPlayer:GetCardRNG(ID)
end

---@return integer
function EntityPlayer:GetCollectibleCount()
end

---@param ID CollectibleType
---@return RNG
function EntityPlayer:GetCollectibleRNG(ID)
end

---@param NullFrameName string
---@param HeadScale boolean
---@param Direction Vector
---@return Vector
function EntityPlayer:GetCostumeNullPos(NullFrameName, HeadScale, Direction)
end

---@return integer
function EntityPlayer:GetDamageCooldown()
end

---@return integer
function EntityPlayer:GetEffectiveMaxHearts()
end

---@return integer
function EntityPlayer:GetEffectiveBloodCharge()
end

---@return integer
function EntityPlayer:GetEffectiveSoulCharge()
end

---@return TemporaryEffects
function EntityPlayer:GetEffects()
end

---@return integer
function EntityPlayer:GetEternalHearts()
end

---@return integer
function EntityPlayer:GetExtraLives()
end

---@return Direction
function EntityPlayer:GetFireDirection()
end

---@return Vector
function EntityPlayer:GetFlyingOffset()
end

---@return integer
function EntityPlayer:GetGoldenHearts()
end

---@return number
function EntityPlayer:GetGreedDonationBreakChance()
end

---@return SkinColor
function EntityPlayer:GetHeadColor()
end

---@return Direction
function EntityPlayer:GetHeadDirection()
end

---@return integer
function EntityPlayer:GetHeartLimit()
end

---@return integer
function EntityPlayer:GetHearts()
end

---@return CollectibleType
function EntityPlayer:GetItemState()
end

---@return integer
function EntityPlayer:GetJarFlies()
end

---@return integer
function EntityPlayer:GetJarHearts()
end

---@param ID LaserOffset
---@param Direction Vector
---@return Vector
function EntityPlayer:GetLaserOffset(ID, Direction)
end

---@return integer
function EntityPlayer:GetLastActionTriggers()
end

---@return integer
function EntityPlayer:GetLastDamageFlags()
end

---@return EntityRef
function EntityPlayer:GetLastDamageSource()
end

---@return Vector
function EntityPlayer:GetLastDirection()
end

---@return EntityPlayer
function EntityPlayer:GetMainTwin()
end

---@return integer
function EntityPlayer:GetMaxHearts()
end

---@return integer
function EntityPlayer:GetMaxPocketItems()
end

---@return integer
function EntityPlayer:GetMaxPoopMana()
end

---@return integer
function EntityPlayer:GetMaxTrinkets()
end

---@return CollectibleType
function EntityPlayer:GetModelingClayEffect()
end

---@return Direction
function EntityPlayer:GetMovementDirection()
end

---@return Vector
function EntityPlayer:GetMovementInput()
end

---@return Vector
function EntityPlayer:GetMovementJoystick()
end

---@return Vector
function EntityPlayer:GetMovementVector()
end

---@return string
function EntityPlayer:GetName()
end

---@return Entity
function EntityPlayer:GetNPCTarget()
end

---@return integer
function EntityPlayer:GetNumBlueFlies()
end

---@return integer
function EntityPlayer:GetNumBlueSpiders()
end

---@return integer
function EntityPlayer:GetNumBombs()
end

---@return integer
function EntityPlayer:GetNumCoins()
end

---@return integer
function EntityPlayer:GetNumGigaBombs()
end

---@return integer
function EntityPlayer:GetNumKeys()
end

---@return EntityPlayer
function EntityPlayer:GetOtherTwin()
end

---@param SlotId integer
---@return PillColor
function EntityPlayer:GetPill(SlotId)
end

---@param ID PillEffect
---@return RNG
function EntityPlayer:GetPillRNG(ID)
end

---@return PlayerType
function EntityPlayer:GetPlayerType()
end

---@return integer
function EntityPlayer:GetPoopMana()
end

---@param Position integer
---@return PoopSpellType
function EntityPlayer:GetPoopSpell(Position)
end

---@return Vector
function EntityPlayer:GetRecentMovementVector()
end

---@return integer
function EntityPlayer:GetRottenHearts()
end

---@return Vector
function EntityPlayer:GetShootingInput()
end

---@return Vector
function EntityPlayer:GetShootingJoystick()
end

---@return number
function EntityPlayer:GetSmoothBodyRotation()
end

---@return integer
function EntityPlayer:GetSoulHearts()
end

---@return integer
function EntityPlayer:GetSoulCharge()
end

---@return EntityPlayer
function EntityPlayer:GetSubPlayer()
end

---@param WeaponType WeaponType
---@param DamageScale? number @default: `1`
---@param TearDisplacement? integer @default: `1`
---@param Source? Entity @default: `nil`
---@return TearParams
function EntityPlayer:GetTearHitParams(WeaponType, DamageScale, TearDisplacement, Source)
end

---@param ShotDirection Vector
---@return Vector
function EntityPlayer:GetTearMovementInheritance(ShotDirection)
end

---@return number
function EntityPlayer:GetTearPoisonDamage()
end

---For Experimental Treatement, returns `-1`, `0` or `1` depending on the range rolled.
---@return integer
function EntityPlayer:GetTearRangeModifier()
end

---@return integer
function EntityPlayer:GetTotalDamageTaken()
end

---@return Entity
function EntityPlayer:GetTractorBeam()
end

---@param TrinketIndex integer
---@return TrinketType
function EntityPlayer:GetTrinket(TrinketIndex)
end

---@param TrinketID TrinketType
---@return integer
function EntityPlayer:GetTrinketMultiplier(TrinketID)
end

---@param TrinketID TrinketType
---@return RNG
function EntityPlayer:GetTrinketRNG(TrinketID)
end

---@return Vector
function EntityPlayer:GetVelocityBeforeUpdate()
end

---@return CollectibleType
function EntityPlayer:GetZodiacEffect()
end

---@return boolean
function EntityPlayer:HasCurseMistEffect()
end

---@return boolean
function EntityPlayer:HasFullHearts()
end

---@return boolean
function EntityPlayer:HasFullHeartsAndSoulHearts()
end

---@return boolean
function EntityPlayer:HasGoldenBomb()
end

---@return boolean
function EntityPlayer:HasGoldenKey()
end

---@param Flags? DamageFlag @default: `0`
---@return boolean
function EntityPlayer:HasInvincibility(Flags)
end

---@param Form PlayerForm
---@return boolean
function EntityPlayer:HasPlayerForm(Form)
end

---@return boolean
function EntityPlayer:HasTimedItem()
end

---@param Type TrinketType
---@param IgnoreModifiers? boolean @default: `false`
---@return boolean
function EntityPlayer:HasTrinket(Type, IgnoreModifiers)
end

---@param WeaponType WeaponType
---@return boolean
function EntityPlayer:HasWeaponType(WeaponType)
end

function EntityPlayer:InitBabySkin()
end

---@param Heart integer
---@return boolean
function EntityPlayer:IsBlackHeart(Heart)
end

---@param heart integer
---@return boolean
function EntityPlayer:IsBoneHeart(heart)
end

---@return boolean
function EntityPlayer:IsCoopGhost()
end

---@return boolean
function EntityPlayer:IsExtraAnimationFinished()
end

---@return boolean
function EntityPlayer:IsFullSpriteRendering()
end

---@return boolean
function EntityPlayer:IsHeldItemVisible()
end

---@return boolean
function EntityPlayer:IsHoldingItem()
end

---@return boolean
function EntityPlayer:IsItemQueueEmpty()
end

---@return boolean
function EntityPlayer:IsP2Appearing()
end

---@param Position Vector
---@return boolean
function EntityPlayer:IsPosInSpotLight(Position)
end

---@return boolean
function EntityPlayer:IsSubPlayer()
end

---@param ActiveSlot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
---@return boolean
function EntityPlayer:NeedsCharge(ActiveSlot)
end

---@param Animation string
function EntityPlayer:PlayExtraAnimation(Animation)
end

---@param Animation string
function EntityPlayer:QueueExtraAnimation(Animation)
end

---@param Item ItemConfigItem
---@param Charge? integer @default: `0`
---@param Touched? boolean @default: `false`
---@param Golden? boolean @default: `false`
---@param VarData? integer @default: `0`
function EntityPlayer:QueueItem(Item, Charge, Touched, Golden, VarData)
end

---@param BlackHeart integer
function EntityPlayer:RemoveBlackHeart(BlackHeart)
end

function EntityPlayer:RemoveBlueFly()
end

function EntityPlayer:RemoveBlueSpider()
end

---@param Type CollectibleType
---@param IgnoreModifiers? boolean @default: `false`
---@param ActiveSlot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
---@param RemoveFromPlayerForm? boolean @default: `true`
function EntityPlayer:RemoveCollectible(Type, IgnoreModifiers, ActiveSlot, RemoveFromPlayerForm)
end

---@param Item ItemConfigItem
function EntityPlayer:RemoveCostume(Item)
end

function EntityPlayer:RemoveCurseMistEffect()
end

function EntityPlayer:RemoveGoldenBomb()
end

function EntityPlayer:RemoveGoldenKey()
end

function EntityPlayer:RemoveSkinCostume()
end

---@param position Vector
function EntityPlayer:RenderBody(position)
end

---@param position Vector
function EntityPlayer:RenderGlow(position)
end

---@param position Vector
function EntityPlayer:RenderHead(position)
end

---@param position Vector
function EntityPlayer:RenderTop(position)
end

---@param Item ItemConfigItem
---@param SpritePath string
---@param SpriteId integer
function EntityPlayer:ReplaceCostumeSprite(Item, SpritePath, SpriteId)
end

function EntityPlayer:ResetDamageCooldown()
end

function EntityPlayer:ResetItemState()
end

function EntityPlayer:RespawnFamiliars()
end

function EntityPlayer:Revive()
end

---@param Charge integer
---@param ActiveSlot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
function EntityPlayer:SetActiveCharge(Charge, ActiveSlot)
end

---@param Amount integer
function EntityPlayer:SetBloodCharge(Amount)
end

---@param SlotId integer
---@param ID Card
function EntityPlayer:SetCard(SlotId, ID)
end

function EntityPlayer:SetFullHearts()
end

---@param DamageCooldown integer
function EntityPlayer:SetMinDamageCooldown(DamageCooldown)
end

---@param SlotId integer
---@param Pill PillColor
function EntityPlayer:SetPill(SlotId, Pill)
end

---@param Type CollectibleType
---@param Slot? ActiveSlot
---@param KeepInPools? boolean
function EntityPlayer:SetPocketActiveItem(Type, Slot, KeepInPools)
end

---@param Cooldown integer
function EntityPlayer:SetShootingCooldown(Cooldown)
end

---@param Amount integer
function EntityPlayer:SetSoulCharge(Amount)
end

---@param TrapDoor GridEntity
function EntityPlayer:SetTargetTrapDoor(TrapDoor)
end

---@param Direction Vector
function EntityPlayer:ShootRedCandle(Direction)
end

---@param Timeout integer
---@return EntityLaser
function EntityPlayer:SpawnMawOfVoid(Timeout)
end

function EntityPlayer:StopExtraAnimation()
end

function EntityPlayer:SwapActiveItems()
end

---@param Position Vector
---@param Target Vector
---@return Entity
function EntityPlayer:ThrowBlueSpider(Position, Target)
end

---@param Subtype integer
---@param Position Vector
---@param Target? Vector @default: `Vector.Zero`
---@return EntityFamiliar
function EntityPlayer:ThrowFriendlyDip(Subtype, Position, Target)
end

---@param Velocity Vector
---@return Entity
function EntityPlayer:ThrowHeldEntity(Velocity)
end

---@param Type? CollectibleType @default: `CollectibleType.COLLECTIBLE_NULL`
---@param Charge? integer @default: `0`
function EntityPlayer:TriggerBookOfVirtues(Type, Charge)
end

---@param Entity Entity
---@return boolean
function EntityPlayer:TryHoldEntity(Entity)
end

---@param Type TrinketType
---@return boolean
function EntityPlayer:TryHoldTrinket(Type)
end

---@param Collectible CollectibleType
---@param KeepPersistent? boolean
function EntityPlayer:TryRemoveCollectibleCostume(Collectible, KeepPersistent)
end

---@param NullId NullItemID
function EntityPlayer:TryRemoveNullCostume(NullId)
end

---@param Type TrinketType
---@return boolean
function EntityPlayer:TryRemoveTrinket(Type)
end

---@param Trinket TrinketType
function EntityPlayer:TryRemoveTrinketCostume(Trinket)
end

---@return boolean
function EntityPlayer:TryUseKey()
end

function EntityPlayer:UpdateCanShoot()
end

---@param Item CollectibleType
---@param UseFlags? UseFlag @default: `0`
---@param Slot? ActiveSlot | -1 @default: `-1`
---@overload fun(self: EntityPlayer, Item: CollectibleType, ShowAnim?: boolean, KeepActiveItem?: boolean, AllowNonMainPlayer?: boolean, ToAddCostume?: boolean, Slot?: ActiveSlot | -1)
function EntityPlayer:UseActiveItem(Item, UseFlags, Slot)
end

---@param ID Card
---@param UseFlags? UseFlag @default: `0`
function EntityPlayer:UseCard(ID, UseFlags)
end

---@param ID PillEffect
---@param PillColor PillColor
---@param UseFlags? UseFlag @default: `0`
function EntityPlayer:UsePill(ID, PillColor, UseFlags)
end

---@return boolean
function EntityPlayer:WillPlayerRevive()
end

---@param type PoopSpellType
function EntityPlayer:UsePoopSpell(type)
end


---@param charge integer
---@param slot ActiveSlot
---@param flashHUD boolean Currently appears to be redundant. Chargebar flashes regardless of using true or false
---@param overcharge boolean
---@param force boolean
---@return integer chargesAdded The true amount of charges added, which may have been capped by the targeted item's max charges.
function EntityPlayer:AddActiveCharge(charge, slot, flashHUD, overcharge, force)
end

---@param position Vector
function EntityPlayer:AddBoneOrbital(position)
end

---@param CacheFlag CacheFlag
---@param EvaluateItems? boolean @default: `false`
function EntityPlayer:AddCacheFlags(CacheFlag, EvaluateItems)
end

---@param collectible CollectibleType
---@param amount? integer @default: `1`
function EntityPlayer:AddInnateCollectible(collectible, amount)
end

---This is currently capped at a max of three familiars.
function EntityPlayer:AddLeprocy()
end

---@param collectibleType CollectibleType
---@param position Vector
function EntityPlayer:AddLocust(collectibleType, position)
end

---Adds a smelted trinket directly to the player's inventory.
---@param trinketType TrinketType
---@param firstTimePickingUp? boolean @default: `true`
---@return boolean wasAdded `true` if the trinket was added successfully, `false` otherwise.
function EntityPlayer:AddSmeltedTrinket(trinketType, firstTimePickingUp)
end

---@param count? integer @default: `1`
function EntityPlayer:AddUrnSouls(count)
end

---In the works, isn't exposed yet
--[[ ---@param minecart EntityNPC
function EntityPlayer:AttachMinecart(minecart)
end ]]

---@param collectibleType CollectibleType
---@return boolean
function EntityPlayer:CanAddCollectibleToInventory(collectibleType)
end

---@return boolean
function EntityPlayer:CanCrushRocks()
end

---@param collectibleType CollectibleType
---@return boolean
function EntityPlayer:CanOverrideActiveItem(collectibleType)
end

--- By some conditions, usually health-related, determines whether a player can use the given pill effect.
---@param pillEffect PillEffect
function EntityPlayer:CanUsePill(pillEffect)
end

---Same as `CheckFamiliar`, but returns a table containing the list of spawned familiars
---@param FamiliarVariant integer
---@param TargetCount integer
---@param rng RNG
---@param SourceItemConfigItem? ItemConfigItem @default: `nil`
---@param FamiliarSubType? integer @default: `-1`
---@return EntityFamiliar[]
function EntityPlayer:CheckFamiliarEx(FamiliarVariant, TargetCount, rng, SourceItemConfigItem, FamiliarSubType)
end

---@param collectible CollectibleType
function EntityPlayer:ClearCollectibleAnim(collectible)
end

---@param Force? boolean @default: `false`. If set to `true`, the charge is reset instead of only rolling for a chance to reset.
function EntityPlayer:ClearDeadEyeCharge(Force)
end

---@param collectible CollectibleType
function EntityPlayer:ClearItemAnimCollectible(collectible)
end

function EntityPlayer:ClearItemAnimNullItems()
end

---@param collectible CollectibleType
---@param existingPedestal? EntityPickup @default: `nil`. If defined, the collectible will be swapped out for the dropped collectible instead of a new pedestal spawning.
---@param removeFromPlayerForm? boolean @default: `false`
function EntityPlayer:DropCollectible(collectible, existingPedestal, removeFromPlayerForm)
end

---@param index integer
---@param pickup? EntityPickup @default: `nil`
---@return EntityPickup
function EntityPlayer:DropCollectibleByHistoryIndex(index, pickup)
end

---@param weaponType WeaponType
---@param set boolean
function EntityPlayer:EnableWeaponType(weaponType, set)
end

---@param position Vector
---@param Velocity Vector
---@param Offset? Vector @default: `Vector.Zero`
---@return EntityEffect
function EntityPlayer:FireBrimstoneBall(position, Velocity, Offset)
end

---@param slot? ActiveSlot @default: `ActiveSlot.SLOT_PRIMARY`
---@return ActiveItemDesc
function EntityPlayer:GetActiveItemDesc(slot)
end

---@param collectible CollectibleType
---@return ActiveSlot
function EntityPlayer:GetActiveItemSlot(collectible)
end

---@param slot ActiveSlot
---@return integer
function EntityPlayer:GetActiveMaxCharge(slot)
end

---@param slot ActiveSlot
---@return integer
function EntityPlayer:GetActiveMinUsableCharge(slot)
end

---@return integer
function EntityPlayer:GetActiveWeaponNumFired()
end

---@return BagOfCraftingPickup[]
function EntityPlayer:GetBagOfCraftingContent()
end

---@return CollectibleType
function EntityPlayer:GetBagOfCraftingOutput()
end

---Returns the current content of the bag in the given Slot ID.
---@param slotId integer
---@return BagOfCraftingPickup
function EntityPlayer:GetBagOfCraftingSlot(slotId)
end

---Returns the current charge for when the player stops shooting
---and charges the Kidney Stone item.
---@return integer
function EntityPlayer:GetBladderCharge()
end

---@return integer
function EntityPlayer:GetBloodLustCounter()
end

---@return Vector
function EntityPlayer:GetBodyMoveDirection()
end

---Returns how many times the player has taken damage with the
---Cambion Conception item.
---@return integer
function EntityPlayer:GetCambionConceptionState()
end

---Corresponds to the current visible state of Cambion Conception's costume (0-2).
---@return integer
function EntityPlayer:GetCambionPregnancyLevel()
end

---Returns a table with the amount of each collectible the player
---has without counting innate items.
---@return table<CollectibleType, integer>
function EntityPlayer:GetCollectiblesList()
end

---@class CostumeLayerMap
---@field costumeIndex integer
---@field layerID integer
---@field priority integer
---@field isBodyLayer boolean

---@return CostumeLayerMap[]
function EntityPlayer:GetCostumeLayerMap()
end

---@return CostumeSpriteDesc[]
function EntityPlayer:GetCostumeSpriteDescs()
end

---@return integer
function EntityPlayer:GetD8DamageModifier()
end

---@return integer
function EntityPlayer:GetD8FireDelayModifier()
end

---@return integer
function EntityPlayer:GetD8RangeModifier()
end

---@return integer
function EntityPlayer:GetD8SpeedModifier()
end

---@return integer
function EntityPlayer:GetDamageModifier()
end

---@return integer
function EntityPlayer:GetDeadEyeCharge()
end

---Returns the name of the player's death animation.
---@return string
---|"Death" # The regular death animation name
---|"LostDeath" # When playing as the Lost, under the Lost Curse, or in Tainted Jacob's Ghost form
function EntityPlayer:GetDeathAnimName()
end

---Returns the offset of the player's damage stat for Eden's random stats.
---@return number
function EntityPlayer:GetEdenDamage()
end

---Returns the offset of the player's fire delay stat for Eden's random stats.
---@return number
function EntityPlayer:GetEdenFireDelay()
end

---Returns the offset of the player's luck stat for Eden's random stats.
---@return number
function EntityPlayer:GetEdenLuck()
end

---Returns the offset of the player's range stat for Eden's random stats.
---@return number
function EntityPlayer:GetEdenRange()
end

---Returns the offset of the player's shot speed stat for Eden's random stats.
---@return number
function EntityPlayer:GetEdenShotSpeed()
end

---Returns the offset of the player's speed stat for Eden's random stats.
---@return number
function EntityPlayer:GetEdenSpeed()
end

---@return Vector
function EntityPlayer:GetEnterPosition()
end

---@return EntityConfigPlayer
function EntityPlayer:GetEntityConfigPlayer()
end

---@return integer
function EntityPlayer:GetEpiphoraCharge()
end

---Returns the current charge of Tainted Eve's innate Sumptorium ability
---@return integer
function EntityPlayer:GetEveSumptoriumCharge()
end

---For Experimental Treatement, returns `-1`, `0` or `1` depending on the fire delay rolled.
---@return integer
function EntityPlayer:GetFireDelayModifier()
end

---Returns flipped form of the current character (only used for Tainted Lazarus), otherwise `nil`.
---@return EntityPlayer?
function EntityPlayer:GetFlippedForm()
end

---Returns the entity used by Active Camera to determine where the camera should focus. This can be either the Marked target EntityEffect or a weapon's entity. If none of these exist, this returns `nil`.
---@return Entity?
function EntityPlayer:GetFocusEntity()
end

---@param isLeftFootprint boolean If true, the left footprint color is returned. Otherwise, the right footprint color is returned.
---@return KColor
function EntityPlayer:GetFootprintColor(isLeftFootprint)
end

---@return integer
function EntityPlayer:GetGlitchBabySubType()
end

---Returns a table containing the variant and subtype for the pickup that can spawn from the Glyph of Balance.
---@param variant PickupVariant? @default: `-1`. TODO: Find out what this does.
---@param subtype? integer @default: `-1`. TODO: Find out what this does.
---@return integer[] pickups
function EntityPlayer:GetGlyphOfBalanceDrop(variant, subtype)
end

---@return integer
function EntityPlayer:GetGreedsGulletHearts()
end

---@return HealthType
function EntityPlayer:GetHealthType()
end

---Returns the Entity that the player is holding over the head, such as throwable red bombs or enemies grabbed with the Suplex! collectible.
---@return Entity?
function EntityPlayer:GetHeldEntity()
end

---Returns the Sprite object that is used when the player is holding a collectible sprite over their head, such as active item usage.
---@return Sprite
function EntityPlayer:GetHeldSprite()
end

---@return History
function EntityPlayer:GetHistory()
end

---Returns how many hearts have been collected with the Immaculate Conception item. Resets to 0 after spawning a familiar/soul heart.
---@return integer
function EntityPlayer:GetImmaculateConceptionState()
end

---Returns the coins spent while the player is holding the Keeper's Sack collectible.
---@return integer
function EntityPlayer:GetKeepersSackBonus()
end

---Returns the color of the player's laser.
---@return Color
function EntityPlayer:GetLaserColor()
end

---For Experimental Treatement, returns `-1`, `0` or `1` depending on the luck rolled.
---@return integer
function EntityPlayer:GetLuckModifier()
end

---Returns the amount of frames left until Tainted Magdalene's swing attack from being damaged can be used again. Returns `0` if the player is not Tainted Magdalene.
---@return integer
function EntityPlayer:GetMaggySwingCooldown()
end

---Returns the target cross effect of the Marked collectible. If the effect is not being displayed, this function returns `nil`.
---@return EntityEffect?
function EntityPlayer:GetMarkedTarget()
end

---Returns the maximum charge for when the player stops shooting and charges the Kidney Stone item.
---@return integer
function EntityPlayer:GetMaxBladderCharge()
end

---Returns the maximum attack duration of the Kidney Stone item.
---@return integer
function EntityPlayer:GetMaxPeeBurstCooldown()
end

---Returns the amount of frames left until the laser from the Mega Blast collectible deactivates.
---@return integer
function EntityPlayer:GetMegaBlastDuration()
end

---Returns the CollectibleType corresponding to the collectible given to the player by the Metronome collectible. Returns `CollectibleType.COLLECTIBLE_NULL` if Metronome hasn't been used in the room.
---@return CollectibleType
function EntityPlayer:GetMetronomeCollectibleID()
end

---@param WeaponType? WeaponType @default: `WeaponType.WEAPON_TEARS`
---@return MultiShotParams
function EntityPlayer:GetMultiShotParams(WeaponType)
end

---Returns the frame at which the player stops shooting and starts charging the Kidney Stone item.
---@return MultiShotParams
---@return integer
function EntityPlayer:GetNextUrethraBlockFrame()
end

---Returns the attack duration of the Kidney Stone item.
---@return integer
function EntityPlayer:GetPeeBurstCooldown()
end

---Returns the amount of collectibles the player has tied to the specified transformation.
---@param playerForm PlayerForm
---@return integer
function EntityPlayer:GetPlayerFormCounter(playerForm)
end

---Gets the card/pill/rune in the specified pocket slot.
---@param SlotId PillCardSlot
---@return PocketItem
function EntityPlayer:GetPocketItem(SlotId)
end

---Returns the amount of frames left until the charging effect from the A Pony or White Pony item deactivates.
---@return integer
function EntityPlayer:GetPonyCharge()
end

---Returns the current state of the Purity collectible. Returns `PurityState.BLUE` if the player does not have the Purity collectible.
---@return PurityState
function EntityPlayer:GetPurityState()
end

---Returns the frames left until the damage bonus from Red Stew expires.
---@return integer
function EntityPlayer:GetRedStewBonusDuration()
end

---For Experimental Treatement, returns `-1`, `0` or `1` depending on the shot speed rolled.
---@return integer
function EntityPlayer:GetShotSpeedModifier()
end

---@class SmeltedTrinket
---@field trinketAmount integer
---@field goldenTrinketAmount integer

---Returns a table containing all of the trinkets the player has smelted and their corresponding amounts.
---@return SmeltedTrinket[]
function EntityPlayer:GetSmeltedTrinkets()
end

---TODO: Document me!
---@param position? Vector @default: `self.Position`
---@return integer
function EntityPlayer:GetSpecialGridCollision(position)
end

---For Experimental Treatement, returns `-1`, `0` or `1` depending on the speed rolled.
---@return integer
function EntityPlayer:GetSpeedModifier()
end

---Returns the amount of charges the active item in the provided slot has.
---@param slot ActiveSlot The slot to get the active item's charges from. Returns `0` if the slot does not have an active item.
---@return integer
function EntityPlayer:GetTotalActiveCharge(slot)
end

---Returns a table of all of the collectibles the player has consumed with the Void collectible.
---@return CollectibleType[]
function EntityPlayer:GetVoidedCollectiblesList()
end

---Returns the Weapon object in the corresponding slot, or `nil` if no Weapon can be found.
---
---Blindfolded players still have a Weapon in slot 1.
---
---Always check for `nil`, even for slot 1, as it can be deleted by mods via `Isaac.DestroyWeapon`
---@param weaponSlot integer
---|0 # Backup Weapon such as Notched Axe and Urn of Souls.
---|1 # Primary Weapon.
---|2 # Additional Weapon. Few instances of this exist in the vanilla game but can also be populated by mods.
---|3 # Additional Weapon.
---|4 # Additional Weapon.
---@return Weapon?
function EntityPlayer:GetWeapon(weaponSlot)
end

---Returns a bitmask of weapon modifiers.
---@return WeaponModifier
function EntityPlayer:GetWeaponModifiers()
end

---Returns the item that was last used by the player and would be activated again upon using Wild Card.
---
---If the player used an active item, its `CollectibleType` is returned. If the player used a consumable, its variant is returned. If the player used ? Mark Card, returns `1`. If no active item had ever been used by the player before, turns `0`.
---@return integer
function EntityPlayer:GetWildCardItem()
end

---Returns the type of item that was last used by the player and would be activated again upon using Wild Card.
---
---If the player used a consumable (including ? Mark Card), returns `ItemType.ITEM_PASSIVE`. If no active item had been used by the player before, returns `255`.
---@return PocketItemType
function EntityPlayer:GetWildCardItemType()
end

---Returns a table of CollectibleTypes corresponding to the item wisps the player has.
---@return table
function EntityPlayer:GetWispCollectiblesList()
end

---Returns true when the player is in the Lost form triggered by the white fire in Downpour or when in Tainted Jacob's ghost form when being touched by Dark Esau.
---@return boolean
function EntityPlayer:HasInstantDeathCurse()
end

---@return boolean
function EntityPlayer:HasPoisonImmunity()
end

---Increases or decreases the counter towards one of the player's transformations.
---@param form PlayerForm
---@param num integer
function EntityPlayer:IncrementPlayerFormCounter(form, num)
end

---Call this after spawning characters with "special" tears (Forgotten, Lilith, Azazel etc) with InitTwin, or they won't have their proper tear type.
function EntityPlayer:InitPostLevelInitStats()
end

---Initializes a new player that is controlled by the player's same controller.
---
---**BUG:** The twin player will desync from its main twin on save and continue. This softlocks the game in singleplayer, as the game prompts for a controller. This is a result of hardcoded behavior.
---@param playerType PlayerType
---@return EntityPlayer
function EntityPlayer:InitTwin(playerType)
end

---Returns true if the animation associated with the collectible is visible.
---@param collectibleType CollectibleType
---@param animationName string
---@return boolean
function EntityPlayer:IsCollectibleAnimFinished(collectibleType, animationName)
end

---Returns true if the costume associated with the collectible is visible.
---@param collectibleType CollectibleType
---@param playerSpriteLayer integer
---@return boolean
function EntityPlayer:IsCollectibleCostumeVisible(collectibleType, playerSpriteLayer)
end

---TODO: Document me!
---@param entity Entity
---@return boolean
function EntityPlayer:IsEntityValidTarget(entity)
end

---TODO: Document me!
---@param foot? integer @default: `-1`.
---|-1 # Returns true every 12 frames
---|0 # Returns true every 24 frames
---|1 # Always false
---@return boolean
function EntityPlayer:IsFootstepFrame(foot)
end

---Returns `true` is the player is headless due to collectibles such as Guillotine, The Intruder, Scissors, and Decap Attack.
---@return boolean
function EntityPlayer:IsHeadless()
end

---Returns `true` if the player is the non-active form of Tainted Lazarus with Birthright
---@return boolean
function EntityPlayer:IsHologram()
end

---TODO: Document me!
---@return boolean
function EntityPlayer:IsInvisible()
end

---@param item ItemConfigItem
---@param layerID PlayerSpriteLayer
---@return boolean
---@overload fun(self: EntityPlayer, item: ItemConfigItem, layerName: string)
function EntityPlayer:IsItemCostumeVisible(item, layerID)
end

---For online play. Returns `true` if you're a local player, `false` otherwise.
---@return boolean
function EntityPlayer:IsLocalPlayer()
end

---@param nullItem NullItemID
---@param layerID PlayerSpriteLayer
---@overload fun(self: EntityPlayer, nullItem: NullItemID, layerName: string)
function EntityPlayer:IsNullItemCostumeVisible(nullItem, layerID)
end

---TODO: Document me!
---@return boolean
function EntityPlayer:IsPacifist()
end

---Returns true if the player can no longer shoot due to charging the Kidney Stone item.
---@return boolean
function EntityPlayer:IsUrethraBlocked()
end

---Turns the player into a co-op ghost.
function EntityPlayer:MorphToCoopGhost()
end

---Plays an animation tied to the provided collectible.
---@param collectible CollectibleType
---@param checkBodyLayers boolean TODO: Document me!
---@param animName string
---@param frameNum? integer TODO: Document me!
function EntityPlayer:PlayCollectibleAnim(collectible, checkBodyLayers, animName, frameNum)
end

---Plays a sound effect after a delay.
---@param soundEffect SoundEffect The sound to play.
---@param soundDelay? integer @default: `2`. TODO: Document me!
---@param frameDelay? integer @default: `2`. TODO: Document me!
---@param volume? number @default: `1`. The volume of the sound.
function EntityPlayer:PlayDelayedSFX(soundEffect, soundDelay, frameDelay, volume)
end

---Removes the collectible from the player associated with the specified history index.
---@param index integer
function EntityPlayer:RemoveCollectibleByHistoryIndex(index)
end

---@param slot PillCardSlot
function EntityPlayer:RemovePocketItem(slot)
end

---Removes the poop spell from the specified queue position and shifts all spells to fill the space. A new spell is randomly picked to fill the last space.
---
---Poop spells are used only by Tainted Blue Baby.
---@param position? integer @default: `0`. The queue position of the spell.
function EntityPlayer:RemovePoopSpell(position)
end

---Rerolls all of the player's collectibles.
---@param rng RNG
---@param includeActiveItems boolean
function EntityPlayer:RerollAllCollectibles(rng, includeActiveItems)
end

---This is used by the Genesis active item.
function EntityPlayer:ResetPlayer()
end

---Revives the player if they are a co-op ghost.
---@return boolean didRevive `true` if the player was revived successfully.
function EntityPlayer:ReviveCoopGhost()
end

---Produces a random quantity of various pickups, similar to Tainted Cain's ability.
---
---If an EntityPickup is passed, it will be removed by this function. Use the other version of this function to avoid this.
---@param collectible CollectibleType
---@param position? Vector @default: `self.Position`
---@param rng? RNG @default: PlayerDropRNG
---@param itemPool? ItemPoolType @default: `ItemPoolType.POOL_NULL`.
---@overload fun(pickup: EntityPickup, rng?: RNG, itemPool?: ItemPoolType)
function EntityPlayer:SalvageCollectible(collectible, position, rng, itemPool)
end

---TODO: Document me!
---@param varData integer
---@param slot ActiveSlot
function EntityPlayer:SetActiveVarData(varData, slot)
end

---Sets the content of the player's Bag of Crafting.
---@param contentTable BagOfCraftingPickup[]
function EntityPlayer:SetBagOfCraftingContent(contentTable)
end

---Sets the output of the player's Bag of Crafting to the specified collectible.
---@param collectible CollectibleType
function EntityPlayer:SetBagOfCraftingOutput(collectible)
end

---Sets the specified slot in the player's Bag of Crafting to the specified pickup or collectible.
---@param slot integer
---@param pickup BagOfCraftingPickup
function EntityPlayer:SetBagOfCraftingSlot(slot, pickup)
end

---Sets the charge for when the player stops shooting and charges the Kidney Stone item.
---
---**BUG:** The player's head turns pitch black when this function is used without Kidney Stone.
---@param charge integer
function EntityPlayer:SetBladderCharge(charge)
end

---@param counter integer
function EntityPlayer:SetBloodLustCounter(counter)
end

---Sets how much damage has been taken for the Cambion Conception item.
---@param state integer
function EntityPlayer:SetCambionConceptionState(state)
end

---Disables or enables the player's ability to shoot.
---@param canShoot boolean
---@return boolean unknown TODO: Document me!
function EntityPlayer:SetCanShoot(canShoot)
end

---Changes the player's controller index.
---@param index integer
function EntityPlayer:SetControllerIndex(index)
end

---For Experimental Treatement, set to `-1`, `0` or `1` to adjust the multiplier applied to the stat.
---@param modifier integer
function EntityPlayer:SetDamageModifier(modifier)
end

---Sets the offset of the player's damage stat for Eden's random stats.
---
---Has no effect on players that aren't Eden or Tainted Eden
---@param damage number
function EntityPlayer:SetEdenDamage(damage)
end

---Sets the offset of the player's fire delay stat for Eden's random stats.
---
---Has no effect on players that aren't Eden or Tainted Eden
---@param damage number
function EntityPlayer:SetEdenFireDelay(damage)
end

---Sets the offset of the player's luck stat for Eden's random stats.
---
---Has no effect on players that aren't Eden or Tainted Eden
---@param luck number
function EntityPlayer:SetEdenLuck(luck)
end

---Sets the offset of the player's range stat for Eden's random stats.
---
---Has no effect on players that aren't Eden or Tainted Eden
---@param range number
function EntityPlayer:SetEdenRange(range)
end

---Sets the offset of the player's shot speed stat for Eden's random stats.
---
---Has no effect on players that aren't Eden or Tainted Eden
---@param shotSpeed number
function EntityPlayer:SetEdenShotSpeed(shotSpeed)
end

---Sets the offset of the player's speed stat for Eden's random stats.
---
---Has no effect on players that aren't Eden or Tainted Eden
---@param speed number
function EntityPlayer:SetEdenSpeed(speed)
end

---Sets the current charge of Tainted Eve's innate Sumptorium ability
---@param chargeNumber integer
function EntityPlayer:SetEveSumptoriumCharge(chargeNumber)
end

---For Experimental Treatement, set to `-1`, `0` or `1` to adjust the multiplier applied to the stat.
---@param modifier integer
function EntityPlayer:SetFireDelayModifier(modifier)
end

---Sets the player's footprint color.
---@param color KColor
---@param isRightFootprint? boolean @default: `false`. If true, the left footprint color is returned. Otherwise, the right footprint color is returned.
function EntityPlayer:SetFootprintColor(color, isRightFootprint)
end

---Sets how many hearts have been collected for the Immaculate Conception item.
---@param state integer @Can only be between `0`-`14`, inclusive. Values outside this are clamped to this range.
function EntityPlayer:SetImmaculateConceptionState(state)
end

---Changes the player's item state to the specified collectible. This is usually used for collectibles that the player holds above their head before activating (i.e: Bob's Rotten Head, Glass Cannon)
---@param collectible CollectibleType
function EntityPlayer:SetItemState(collectible)
end

---Sets the current coin bonus for the player's Keeper Sack collectible.
---@param bonus integer
function EntityPlayer:SetKeepersSackBonus(bonus)
end

---Sets the player's laser color.
---@param color Color
function EntityPlayer:SetLaserColor(color)
end

---For Experimental Treatement, set to `-1`, `0` or `1` to adjust the multiplier applied to the stat.
---@param modifier integer
function EntityPlayer:SetLuckModifier(modifier)
end

---Sets the cooldown of Tainted Magdalene's swing attack to the specified amount of frames.
---@param cooldown integer
function EntityPlayer:SetMaggySwingCooldown(cooldown)
end

---Sets the maximum charge for when the player stops shooting and charges the Kidney Stone item.
---@param charge integer
function EntityPlayer:SetMaxBladderCharge(charge)
end

---Sets the duration of the Mega Blast laser to the specified amount of frames. Setting the duration above zero will activate the effect if it hasn't already.
---
---**Bug:** If the Mega Blast laser is active and you call the function again with a lower duration, the laser will persist even after the amount of frames has passed until the player leaves the room.
---@param duration integer
function EntityPlayer:SetMegaBlastDuration(duration)
end

---Sets the frame at which the player stops shooting and starts charging the Kidney Stone item.
---
---Setting the frame to a number before the current game frame will activate the chargeup for Kidney Stone.
---@param frame integer
function EntityPlayer:SetNextUrethraBlockFrame(frame)
end

---Sets the duration of the charge effect from the A Pony and White Pony to the specified amount of frames.
---
---Setting the duration above 0 will activate the effect.
---@param duration integer
function EntityPlayer:SetPonyCharge(duration)
end

---Sets the specified slot in the poop list to a type of poop. This is only used by Tainted Blue Baby.
---@param position integer
---@param spellType PoopSpellType
function EntityPlayer:SetPoopSpell(position, spellType)
end

---Sets the duration of the damage bonus given by the Red Stew collectible to the specified amount of frames.
---
---Setting the duration above 0 will activate the effect.
---@param duration integer
function EntityPlayer:SetRedStewBonusDuration(duration)
end

---For Experimental Treatement, set to `-1`, `0` or `1` to adjust the multiplier applied to the stat.
---@param modifier integer
function EntityPlayer:SetShotSpeedModifier(modifier)
end

---For Experimental Treatement, set to `-1`, `0` or `1` to adjust the multiplier applied to the stat.
---@param modifier integer
function EntityPlayer:SetSpeedModifier(modifier)
end

---TODO: Document me!
---@param damage number
function EntityPlayer:SetTearPoisonDamage(damage)
end

---For Experimental Treatement, set to `-1`, `0` or `1` to adjust the multiplier applied to the stat.
---@param modifier integer
function EntityPlayer:SetTearRangeModifier(modifier)
end

---Sets whether the tear spam attack from the Kidney Stone collectible is about to activate.
---
---If the player does not have the Kidney Stone collectible, the effect is immediately activated.
---
---**Bug:** Setting the `block` argument to false seems to do nothing at all.
---@param block boolean
function EntityPlayer:SetUrethraBlock(block)
end

---Sets the active Weapon in the assigned `weaponSlot`
---@param weapon Weapon
---@param weaponSlot integer
---|0 # Backup Weapon such as Notched Axe and Urn of Souls.
---|1 # Primary Weapon.
---|2 # Additional Weapon.
---|3 # Additional Weapon.
---|4 # Additional Weapon.
function EntityPlayer:SetWeapon(weapon, weaponSlot)
end

---Makes the player shoot a blue flame from the Candle collectible.
---@param direction Vector
function EntityPlayer:ShootBlueCandle(direction)
end

---Randomizes the player's current costumes.
---@param seed integer
function EntityPlayer:ShuffleCostumes(seed)
end

---Spawns a creep effect that acts like the ones created by the Aquarius collectible.
---@param tearParams? TearParams @default: `self.TearParams`. The tear parameters that the creep will inherit from.
---@return EntityEffect
function EntityPlayer:SpawnAquariusCreep(tearParams)
end

---Acts like a use of Sumptorium, removing health and spawning a clot with the type of health removed.
---@param position Vector The position of the blood clot to spawn at.
---@param allowPlayerDeath? boolean @default: `false`. If `true`, the blood clot will still spawn even if the player has half a heart or no health and kill the player.
function EntityPlayer:SpawnClot(position, allowPlayerDeath)
end

---Spawns a ring of tears that orbit around the player akin to the Saturnus collectible
---@return integer tearsSpawned The amount of tears spawned.
function EntityPlayer:SpawnSaturnusTears()
end

---If the player is The Forgotten/The Soul, the two will swap forms. Otherwise, this function does nothing.
---@param force? boolean @default: `false`. If true, the two will swap even if one of them does not have any health or a room/stage transition is active.
---@param noEffects? boolean @default: `false`. If true, the dust and fade effect will be disabled when switching from The Soul to The Forgotten.
function EntityPlayer:SwapForgottenForm(force, noEffects)
end

---TODO: Document me!
---@param player EntityPlayer
---@param collectibleFlags integer
function EntityPlayer:SyncConsumableCounts(player, collectibleFlags)
end

---Teleports the player to the specified position in the current room.
---@param position Vector
---@param showEffects? boolean @default: `true`. If `true`, the teleport animation and sound plays.
---@param teleportTwinPlayers? boolean @default: `false`. If `true`, the player's twins (i.e: Jacon & Esau, Tainted Lazarus with Birthright) are both teleported to the position.
function EntityPlayer:Teleport(position, showEffects, teleportTwinPlayers)
end

---Triggers effects on the player as if a room was cleared (i.e. Charging actives).
function EntityPlayer:TriggerRoomClear()
end

---Tries to add the specified pickup to the player's Bag of Crafting.
---@param pickup EntityPickup
function EntityPlayer:TryAddToBagOfCrafting(pickup)
end

---Attempts to decrease the uses left for the Glowing Hourglass collectible, if the player has it.
---@param uses integer **BUG**: Uses will decrease by one no matter what this is set to.
---@param forceHourglass? boolean Optional. If true, all of the charges are removed and the hourglass is turned into its regular form.
function EntityPlayer:TryDecreaseGlowingHourglassUses(uses, forceHourglass)
end

---Spawns a copy of the player at its current position and plays the death animation and sound.
---@return boolean unknown TODO: Document me!
function EntityPlayer:TryFakeDeath()
end

---If the player is holding Tainted Forgotten, he is thrown towards the specified direction.
---@param direction Vector
---@return boolean wasThrown `true` if Tainted Forgotten was thrown, false otherwise.
function EntityPlayer:TryForgottenThrow(direction)
end

---Adds a heart container to the player if there are none left in order to prevent death.
---@return boolean didPrevent `true` if death was presented, false otherwise.
function EntityPlayer:TryPreventDeath()
end

---Tries to remove the specified smelted trinket from the player.
---@param trinket TrinketType
function EntityPlayer:TryRemoveSmeltedTrinket(trinket)
end

---Updates the costume of Cambion Conception or Immaculate Conception
---@param cambion boolean Set to `true` for Cambion Conception, otherwise Immaculate Conception.
function EntityPlayer:UpdateIsaacPregnancy(cambion)
end

---Returns true if the specified collectible has been consumed by the Void collectible.
---@param collectible CollectibleType
---@return boolean
function EntityPlayer:VoidHasCollectible(collectible)
end

---@return integer
function EntityPlayer:GetUrnSouls()
end

---@param type NullItemID
---@param costume boolean
---@param cooldown? integer @default: `default cooldown`
---@param additive? boolean @default: `true`
function EntityPlayer:AddNullItemEffect(type, costume, cooldown, additive)
end

---@param type CollectibleType
---@param costume boolean
---@param cooldown? integer @default: `default cooldown`
---@param additive? boolean @default: `true`
function EntityPlayer:AddCollectibleEffect(type, costume, cooldown, additive)
end

---@param direction Direction
---@param time integer
---@param force? boolean
function EntityPlayer:SetHeadDirection(direction, time, force)
end

---@return integer
function EntityPlayer:GetHeadDirectionLockTime()
end

---@param time integer
function EntityPlayer:SetHeadDirectionLockTime(time)
end

---@param LoopIndex integer
---@param Weapon WeaponType
---@param ShotDirection Vector
---@param ShotSpeed number
---@param params MultiShotParams
---@return PosVel
function EntityPlayer:GetMultiShotPositionVelocity(LoopIndex, Weapon, ShotDirection, ShotSpeed, params)
end

---@return integer --May return -1 in some circumstances
function EntityPlayer:GetPlayerIndex()
end

---@return integer
function EntityPlayer:GetBombPlaceDelay()
end

---@param delay integer
function EntityPlayer:SetBombPlaceDelay(delay)
end

---Returns a map of CollectibleType to tables for all currently spoofed (innate) collectibles.
---@return {[CollectibleType]: {CollectibleID: CollectibleType, AppendedCount: integer, IsBlocked: boolean}}
function EntityPlayer:GetSpoofedCollectiblesList()
end

---Blocks the provided `CollectibleType`. This will make it so the game thinks you don't have the item, even if it's in your inventory.
---@param itemID CollectibleType
function EntityPlayer:BlockCollectible(itemID)
end

---Unblocks a `CollectibleType` set by EntityPlayer::BlockCollectible().
---@param itemID CollectibleType
function EntityPlayer:UnblockCollectible(itemID)
end

---Returns if the `CollectibleType` was blocked through EntityPlayer::BlockCollectible().
---@param itemID CollectibleType
---@return boolean
function EntityPlayer:IsCollectibleBlocked(itemID)
end

---@param Type CollectibleType
---@param IgnoreModifiers? boolean @default: `false`
---@param IgnoreSpoof? boolean @default: `false`. Ignores innate items when set to true.
---@return boolean
function EntityPlayer:HasCollectible(Type, IgnoreModifiers, IgnoreSpoof)
end

---@param Type CollectibleType
---@param OnlyCountTrueItems? boolean @default: `false`
---@param IgnoreSpoof? boolean @default: `false`. Ignores innate items when set to true.
---@return integer
function EntityPlayer:GetCollectibleNum(Type, OnlyCountTrueItems, IgnoreSpoof)
end

---Returns `true` if you have a golden variant of the provided `TrinketType`.
---@param trinketType TrinketType
---@return boolean
function EntityPlayer:HasGoldenTrinket(trinketType)
end

---Returns the grace period countdown of retaining stats from the Hallowed Ground/Star of Bethlehem aura.
---@return integer
function EntityPlayer:GetHallowedGroundCountdown()
end

---Sets the grace period countdown of retaining stats from the Hallowed Ground/Star of Bethlehem aura.
---@param countdown integer
function EntityPlayer:SetHallowedGroundCountdown(countdown)
end

---Returns `true` if a "?" would be displayed on the player's extra life count (ie, Guppy's Collar)
---@return boolean
function EntityPlayer:HasChanceRevive()
end

---Returns the bitmask corresponding to which familiars have been spawned by Cambion/Immaculate Conception. The additional familiars provided by this bitmask are spawned during familiar cache evaluation, but only while the player has one of those two items.
---@return ConceptionFamiliarFlag
function EntityPlayer:GetConceptionFamiliarFlags()
end

---Sets the bitmask corresponding to which familiars have been spawned by Cambion/Immaculate Conception. The additional familiars provided by this bitmask are spawned during familiar cache evaluation, but only while the player has one of those two items.
---@param flag ConceptionFamiliarFlag
function EntityPlayer:SetConceptionFamiliarFlags(flag)
end

---Converts a soul heart into a black heart.
---@param soulHeartIndex integer @Determines which soul heart gets converted. 1 for the first Soul Heart, 2 for the second, and so on.
function EntityPlayer:SetBlackHeart(soulHeartIndex)
end

---Returns the pickups that are stored on the player through the use of the Moving Box collectible.
---@return EntitiesSaveStateVector
function EntityPlayer:GetMovingBoxContents()
end

---Returns the player's TearDisplacement value, used to check what eye the player was last shooting from.
---@return integer
---|-1 # Left eye
---|1 # Right eye
function EntityPlayer:GetTearDisplacement()
end

---Add CustomCacheTag(s) to be evaluated next time EvaluateItems runs (which is right now, if the optional boolean is passed).
---@param tag string | string[]
---@param EvaluateItems? boolean @default: `false`.
function EntityPlayer:AddCustomCacheTag(tag, EvaluateItems)
end

---Returns the current cached value for the specified CustomCacheTag.
---@param CustomCacheTag string
---@return integer @Will return `0` by default if the provided tag has not been evaluated.
function EntityPlayer:GetCustomCacheValue(CustomCacheTag)
end

---@return integer
function EntityPlayer:GetMaxCoins()
end

---@return integer
function EntityPlayer:GetMaxKeys()
end

---@return integer
function EntityPlayer:GetMaxBombs()
end

---@class EntityPickup : Entity
---@field AutoUpdatePrice boolean
---@field Charge integer
---@field OptionsPickupIndex integer
---@field Price PickupPrice
---@field ShopItemId integer
---@field State integer
---@field Timeout integer
---@field Touched boolean
---@field Wait integer
local EntityPickup = {}

function EntityPickup:AppearFast()
end

---@return boolean
function EntityPickup:CanReroll()
end

---@return integer
function EntityPickup:GetCoinValue()
end

---@return boolean
function EntityPickup:IsShopItem()
end

---@param Type EntityType
---@param Variant integer
---@param SubType integer
---@param KeepPrice? boolean @default: `false`
---@param KeepSeed? boolean @default: `false`
---@param IgnoreModifiers? boolean @default: `false`
function EntityPickup:Morph(Type, Variant, SubType, KeepPrice, KeepSeed, IgnoreModifiers)
end

function EntityPickup:PlayDropSound()
end

function EntityPickup:PlayPickupSound()
end

---@param Player? EntityPlayer @default: `nil`
---@return boolean
function EntityPickup:TryOpenChest(Player)
end


---Adds the specified collectible to cycle with the pedestal's collectibles.
---
---Does nothing for non-collectible EntityPickups.
---@param collectible CollectibleType
---@return boolean wasAdded Returns `true` if adding the collectible was successful.
function EntityPickup:AddCollectibleCycle(collectible)
end

---Returns the pickup's alternate pedestal.
---@return PedestalType --Returns -1 for non-collectible EntityPickups
function EntityPickup:GetAlternatePedestal()
end

---Returns a table of all collectibles types being used inside its collectible cycle (i.e. Cracked Crown).
---@return CollectibleType[] --Table will be empty if used on non-collectible EntityPickups
function EntityPickup:GetCollectibleCycle()
end

---@return integer
function EntityPickup:GetDropDelay()
end

---Returns the sprite of the pickup's price label.
---@return Sprite
function EntityPickup:GetPriceSprite()
end

---Shoots the pickup in a random direction.
---
---This is a static function and must be called via EntityPickup.GetRandomPickupVelocity(Position, RNG, VelocityType).
---@param Position Vector
---@param RNG RNG
---@param VelocityType? integer @default: `0`. VelocityType 0 will shoot pickups in a random direction around the wanted position. VelocityType 1 will shoot pickups in a cone pointing down, mostly used for Beggar payouts. VelocityType also seems to affect pickups in Challenge Rooms, causing them to have a weaker velocity.
function EntityPickup.GetRandomPickupVelocity(Position, RNG, VelocityType)
end

---@return integer
function EntityPickup:GetVarData()
end

---@param checkForceBlindOnly? boolean Set to `true` to ignore the Curse of the Blind and only check for forced blinded items, such as in alt path rooms
---@return boolean `true` if the pickup is a collectible pedestal and is hidden. Always returns `false` for non-collectible EntityPickups.
function EntityPickup:IsBlind(checkForceBlindOnly)
end

---Turns the pickup into a shop item for sale.
---@param shopItemId integer TODO: Document me!
function EntityPickup:MakeShopItem(shopItemId)
end

---Sets the graphics of the item pedestal.
---
---Does nothing for non-collectible EntityPickups.
---@param pedestalType PedestalType
function EntityPickup:SetAlternatePedestal(pedestalType)
end

---@param delay integer
function EntityPickup:SetDropDelay(delay)
end

---Hides pedestal items similar to Curse of the Blind.
---
---Does nothing for non-collectible EntityPickups.
---@param isBlind boolean
function EntityPickup:SetForceBlind(isBlind)
end

---Returns the new pickup index.
---
---TODO: Document me!
---@return integer pickupIndex
function EntityPickup:SetNewOptionsPickupIndex()
end

---@param varData integer
function EntityPickup:SetVarData(varData)
end

---Will try to flip the collectible, such as when using the Flip item on a collectible pedestal with a second, holographic collectible present behind the first one.
---@return boolean wasFlipped Returns `true` if the collectible was successfully flipped. Returns `false` otherwise, or if used on non-collectible EntityPickups.
function EntityPickup:TryFlip()
end

---Causes the collectible pedestal to start cycling through the specified amount of collectibles, including its own collectible type.
---@param numCycle integer The amount of collectibles to add to the cycle.
---@return boolean didCycleInit Returns `true` if the cycle was successfully initialized. Returns `false` if the collectible was already cycling, or if use on non-collectible EntityPickups.
function EntityPickup:TryInitOptionCycle(numCycle)
end

---Tries to remove the collectible from the pedestal.
---
---Does nothing for non-collectible EntityPickups.
---@return boolean wasRemoved Returns `true` if the collectible was removed. Returns `false` if it was already empty, or if use on non-collectible EntityPickups.
function EntityPickup:TryRemoveCollectible()
end

---**NOTE**: This is read-only. You will not be able to use `LootList:PushEntry` for this. Instead, use `MC_PRE_PICKUP_GET_LOOT_LIST` in tandem with the `LootList()` constructor.
---@param shouldAdvance? boolean @default: `false`
---@return LootList
function EntityPickup:GetLootList(shouldAdvance)
end

---Returns the `EffectVariant.PICKUP_GHOST` EntityEffect visible through Guppy's Eye. If not visible, returns `nil`.
---@return EntityEffect?
function EntityPickup:GetPickupGhost()
end

---Updates the `EffectVariant.PICKUP_GHOST` EntityEffect in accordance to the pickup's current `LootList`.
function EntityPickup:UpdatePickupGhosts()
end

---Removes pickups with the same option group `EntityPickup.OptionsPickupIndex` as the target pickup.
function EntityPickup:TriggerTheresOptionsPickup()
end

---@class GridEntitySpikes : GridEntity
---@field Timeout integer
local GridEntitySpikes = {}



---@class GridEntityPoop : GridEntity
---@field ReducedSpawnRate boolean
---@field ReviveTimer integer
---@field StateAnimation string
---@field UnderPlayer boolean
local GridEntityPoop = {}

function GridEntityPoop:ReduceSpawnRate()
end

function GridEntityPoop:RespawnRedPoop()
end



---@class GridEntityPressurePlate : GridEntity
---@field GreedModeRNG RNG
---@field NextGreedAnimation string
---@field TimerPlate Sprite
local GridEntityPressurePlate = {}

function GridEntityPressurePlate:Reward()
end



---@class GridEntityTNT : GridEntity
---@field FrameCnt integer
local GridEntityTNT = {}



---@class GridEntityPit : GridEntity
---@field HasLadder boolean
local GridEntityPit = {}

---@param parentEntity GridEntity | nil
function GridEntityPit:MakeBridge(parentEntity)
end

---@param Value boolean
function GridEntityPit:SetLadder(Value)
end

function GridEntityPit:UpdateCollision()
end



---@class GridEntityDoor : GridEntity
---@field Busted boolean
---@field CloseAnimation string
---@field CurrentRoomType RoomType
---@field Direction Direction
---@field ExtraSprite Sprite
---@field ExtraVisible boolean
---@field LockedAnimation string
---@field OpenAnimation string
---@field OpenLockedAnimation string
---@field PreviousState integer
---@field PreviousVariant integer
---@field Slot DoorSlot
---@field TargetRoomIndex integer
---@field TargetRoomType RoomType
local GridEntityDoor = {}

function GridEntityDoor:Bar()
end

---@return boolean
function GridEntityDoor:CanBlowOpen()
end

---@param Force? boolean
function GridEntityDoor:Close(Force)
end

---@return Vector
function GridEntityDoor:GetSpriteOffset()
end

---@return boolean
function GridEntityDoor:IsBusted()
end

---@return boolean
function GridEntityDoor:IsKeyFamiliarTarget()
end

---@return boolean
function GridEntityDoor:IsLocked()
end

---@return boolean
function GridEntityDoor:IsOpen()
end

---@param Type RoomType
---@return boolean
function GridEntityDoor:IsRoomType(Type)
end

---@return boolean
function GridEntityDoor:IsTargetRoomArcade()
end

function GridEntityDoor:Open()
end

---@param Locked boolean
function GridEntityDoor:SetLocked(Locked)
end

---@param CurrentRoomType RoomType
---@param TargetRoomType RoomType
function GridEntityDoor:SetRoomTypes(CurrentRoomType, TargetRoomType)
end

function GridEntityDoor:SpawnDust()
end

---@param FromExplosion boolean
---@param source Entity
---@return boolean
function GridEntityDoor:TryBlowOpen(FromExplosion, source)
end

---@param player EntityPlayer
---@param Force? boolean
---@return boolean
function GridEntityDoor:TryUnlock(player, Force)
end



---Returns the door's ExtraSprite.
---@return Sprite
function GridEntityDoor:GetExtraSprite()
end


---@class GridEntityRock : GridEntity
---@field Anim string
---@field FrameCnt integer
---@field RubbleAnim string
local GridEntityRock = {}

---@return integer
function GridEntityRock:GetBigRockFrame()
end

---@return string
function GridEntityRock:GetRubbleAnim()
end

---@return Sprite
function GridEntityRock:GetSprite()
end

---@param Frame integer
function GridEntityRock:SetBigRockFrame(Frame)
end

function GridEntityRock:UpdateAnimFrame()
end



---Returns the rock's altrock type.
---@param backdrop? BackdropType @default: `BackdropType.BACKDROP_NULL`.
---@return integer
function GridEntityRock:GetAltRockType(backdrop)
end

---TODO: Document me!
---@param gridType GridEntityType
---@param backdrop? BackdropType @default: `BackdropType.BACKDROP_NULL`.
function GridEntityRock:PlayBreakSound(gridType, backdrop)
end

---TODO: Document me!
---@param gridType GridEntityType
function GridEntityRock:RegisterRockDestroyed(gridType)
end

---TODO: Document me!
---@param offset Vector
function GridEntityRock:RenderTop(offset)
end

---TODO: Document me!
---@param gridType GridEntityType
---@param gridVariant integer
---@param seed integer
---@param unknown boolean TODO: Document me!
---@param backdrop? BackdropType @default: `BackdropType.BACKDROP_NULL`.
function GridEntityRock:SpawnDrops(gridType, gridVariant, seed, unknown, backdrop)
end

---TODO: Document me!
function GridEntityRock:TrySpawnLadder()
end

---TODO: Document me!
function GridEntityRock:TrySpawnWorms()
end

---Updates the rock's collision.
function GridEntityRock:UpdateCollision()
end

---Updates the rock's neighbors.
function GridEntityRock:UpdateNeighbors()
end


---@class GridEntity
---@field CollisionClass GridCollisionClass
---@field Desc GridEntityDesc
---@field Position Vector @const
---@field State integer
---@field VarData integer
local GridEntity = {}

---@param Immediate? boolean
---@return boolean
function GridEntity:Destroy(Immediate)
end

---@return integer
function GridEntity:GetGridIndex()
end

--This RNG is initialized with the same seed for all grid entities in the whole run. Instead, it's advised to create a custom data structure or use either the SpawnSeed or VariableSeed fields from the GridEntityDesc object (GridEntity:GetSaveState()).
---@return RNG
function GridEntity:GetRNG()
end

---@return GridEntityDesc
function GridEntity:GetSaveState()
end

---@return Sprite
function GridEntity:GetSprite()
end

---@return GridEntityType
function GridEntity:GetType()
end

---@return integer
function GridEntity:GetVariant()
end

---@param Damage integer
---@return boolean
function GridEntity:Hurt(Damage)
end

---@param Seed integer
function GridEntity:Init(Seed)
end

function GridEntity:PostInit()
end

---@param Offset Vector
function GridEntity:Render(Offset)
end

---@param Type GridEntityType
function GridEntity:SetType(Type)
end

---@param Variant integer
function GridEntity:SetVariant(Variant)
end

---@return GridEntityDoor
function GridEntity:ToDoor()
end

---@return GridEntityPit
function GridEntity:ToPit()
end

---@return GridEntityPoop
function GridEntity:ToPoop()
end

---@return GridEntityPressurePlate
function GridEntity:ToPressurePlate()
end

---@return GridEntityRock
function GridEntity:ToRock()
end

---@return GridEntitySpikes
function GridEntity:ToSpikes()
end

---@return GridEntityTNT
function GridEntity:ToTNT()
end

function GridEntity:Update()
end



---@return integer
function GridEntity:GetAltRockType()
end

---@return Vector
function GridEntity:GetRenderPosition()
end

---TODO: Document me!
---@param entity Entity
---@param damage integer
---@param damageFlags DamageFlag
---@param unknown number TODO: Document me!
---@param unknown2 boolean TODO: Document me!
function GridEntity:HurtDamage(entity, damage, damageFlags, unknown, unknown2)
end

---TODO: Document me!
---@param damage integer
---@param damageFlags DamageFlag
---@param unknown number TODO: Document me!
---@param unknown2 boolean TODO: Document me!
function GridEntity:HurtSurroundings(damage, damageFlags, unknown, unknown2)
end

---Returns true if the rock can be broken.
---@return boolean
function GridEntity:IsBreakableRock()
end

---TODO: Document me!
---@param gridType GridEntityType
---@param backdropType BackdropType
function GridEntity:PlayBreakSound(gridType, backdropType)
end

---TODO: Document me!
---@param gridType GridEntityType
function GridEntity:RegisterRockDestroyed(gridType)
end

---TODO: Document me!
---@param offset Vector
function GridEntity:RenderTop(offset)
end

---Used to cast a `GridEntity` object to a `GridEntityDecoration` object.
---@return GridEntityDecoration? `nil` is conversion is not successful
function GridEntity:ToDecoration()
end

---Used to cast a `GridEntity` object to a `GridEntityFire` object.
---@return GridEntityFire? `nil` is conversion is not successful
function GridEntity:ToFire()
end

---Used to cast a `GridEntity` object to a `GridEntityGravity` object.
---@return GridEntityGravity? `nil` is conversion is not successful
function GridEntity:ToGravity()
end

---Used to cast a `GridEntity` object to a `GridEntityLock` object.
---@return GridEntityLock? `nil` is conversion is not successful
function GridEntity:ToLock()
end

---Used to cast a `GridEntity` object to a `GridEntityStairs` object.
---@return GridEntityStairs? `nil` is conversion is not successful
function GridEntity:ToStairs()
end

---Used to cast a `GridEntity` object to a `GridEntityStatue` object.
---@return GridEntityStatue? `nil` is conversion is not successful
function GridEntity:ToStatue()
end

---Used to cast a `GridEntity` object to a `GridEntityTeleporter` object.
---@return GridEntityTeleporter? `nil` is conversion is not successful
function GridEntity:ToTeleporter()
end

---Used to cast a `GridEntity` object to a `GridEntityTrapDoor` object.
---@return GridEntityTrapDoor? `nil` is conversion is not successful
function GridEntity:ToTrapDoor()
end

---Used to cast a `GridEntity` object to a `GridEntityWall` object.
---@return GridEntityWall? `nil` is conversion is not successful
function GridEntity:ToWall()
end

---Used to cast a `GridEntity` object to a `GridEntityWeb` object.
---@return GridEntityWeb? `nil` is conversion is not successful
function GridEntity:ToWeb()
end

---TODO: Document me!
function GridEntity:TrySpawnLadder()
end

---TODO: Document me!
function GridEntity:TrySpawnWorms()
end

function GridEntity:UpdateCollision()
end

---Updates the GridEntity's neighbors.
function GridEntity:UpdateNeighbors()
end


---@class RoomConfigRoom
---@field Difficulty Difficulty @const
---@field Doors integer @const
---@field Height integer @const
---@field InitialWeight number @const
---@field Mode integer @const
---@field Name string @const
---@field Shape RoomShape @const
---@field OriginalVariant integer @const | Not officially documented but functional
---@field SpawnCount integer @const
---@field Spawns CppList_RoomConfigSpawn @const
---@field StageID integer @const
---@field Subtype integer @const
---@field Type RoomType @const
---@field Variant integer @const
---@field Weight number @const
---@field Width integer @const
local RoomConfigRoom = {}


---@class RoomConfigSet : CppList
local RoomConfigSet = {}

---@param idx integer
---@return RoomConfigRoom
function RoomConfigSet:Get(idx)
end

---@class LRoomAreaDesc
local LRoomAreaDesc = {}

---Returns the top left corner of the high half of the L-room.
---@return Vector
function LRoomAreaDesc:GetHighTopLeft()
end

---Returns the top left corner of the low half of the L-room.
---@return Vector
function LRoomAreaDesc:GetLowTopLeft()
end

---Returns the bottom right corner of the high half of the L-room.
---@return Vector
function LRoomAreaDesc:GetHighBottomRight()
end

---Returns the bottom right corner of the low half of the L-room.
---@return Vector
function LRoomAreaDesc:GetLowBottomRight()
end

---@class DailyChallenge
_G.DailyChallenge = {}

---@return ChallengeParams
function DailyChallenge.GetChallengeParams()
end


---@class ColorParams
local ColorParams = {}

---@param color Color
---@param priority integer
---@param duration1 integer
---@param duration2 integer
---@param fadeout boolean
---@param shared boolean
---@return ColorParams
function _G.ColorParams(color, priority, duration1, duration2, fadeout, shared)
end

---@return Color
function ColorParams:GetColor()
end

---Defines the time in update frames that these parameters should last. Has no effect on how many frames are left, but does affect fadeout speed (calculated as `lifespan / duration`) if `fadeout` is enabled.
---@return integer
function ColorParams:GetDuration()
end

---@return boolean
function ColorParams:GetFadeout()
end

---Defines how many update frames are left before this expires. This is decremented by `1` each non-interpolation update at a rate of `30` per second. Altering this will directly effect how many frames are left before these parameters expire.

---@return integer
function ColorParams:GetLifespan()
end

---@return integer
function ColorParams:GetPriority()
end

---@return boolean
function ColorParams:GetShared()
end

---@param color Color
function ColorParams:SetColor(color)
end

---@param duration integer
function ColorParams:SetDuration(duration)
end

---@param value boolean
function ColorParams:SetFadeout(value)
end

---@param duration integer
function ColorParams:SetLifespan(duration)
end

---@param priority integer
function ColorParams:SetPriority(priority)
end

---@param value boolean
function ColorParams:SetShared(value)
end


---@diagnostic disable: duplicate-set-field
---@class StageTransition
_G.StageTransition = {}

---Returns true if the stage transition screen will display Isaac's head moving from one stage to another stage.
---@return boolean
function StageTransition.GetSameStage()
end

---Configure whether the stage transition will display Isaac's head moving from one stage to the other (false) or not (true).
---
---This function is useful if you want to move the player to the first stage, or want to repeat the last stage on the progress
---bar of the transition screen, and have it be less jarring.
---
---If transitioning back to the first floor, and `sameStage` is not set to true, Isaac's head will appear outside of the progress
---bar. Otherwise, Isaac's head will appear on the first floor.
---
---If repeating the last floor, and `sameStage` is not set to true, Isaac's head will move from the previous stage to the last one.
---Otherwise, Isaac's head will appear on the last floor.
---
---Calling this function before the current stage transition has called `SetNextStage` will override the transition itself. This
---means that instead of merely displaying Isaac's head not moving, it will actually change whether the next stage will be a repeat
---of the current one, or the actual next stage. Ideally, you should use this function in the context of the
---`ModCallbacks.MC_PRE_LEVEL_SELECT` callback.
---@param sameStage boolean
function StageTransition.SetSameStage(sameStage)
end


---@class CostumeSpriteDesc
local CostumeSpriteDesc = {}

---@return boolean
function CostumeSpriteDesc:CanOverwriteColor() end

---@return SkinColor
function CostumeSpriteDesc:GetBodyColor() end

---@return SkinColor
function CostumeSpriteDesc:GetHeadColor() end

---@return ItemConfigItem
function CostumeSpriteDesc:GetItemConfig() end

---@return boolean
function CostumeSpriteDesc:GetPlayerType() end

---@return boolean
function CostumeSpriteDesc:GetPriority() end

---Returns sprite of associated to the costume.
---@return Sprite
function CostumeSpriteDesc:GetSprite() end

---@return boolean
function CostumeSpriteDesc:HasOverlay() end

---@return boolean
function CostumeSpriteDesc:HasSkinAlt() end

---@return boolean
function CostumeSpriteDesc:IsFlying() end

---@return boolean
function CostumeSpriteDesc:IsItemAnimPlaying() end

---@return boolean
function CostumeSpriteDesc:IsItemStateOnly() end


---@class Debug
Debug = {}

---@param moduleName string
function Debug.ForceUnload(moduleName)
end

---@param addr integer
---@return string
function Debug.GetSignature(addr)
end

--- Returns a list of all files loaded into the LUA environment.
---@return string[]
function Debug.ListLoadedFiles()
end

---@class Camera
local Camera = {}

---The camera will attempt to focus on the specified position. Currently, this must be called every frame or else the game will stop trying to focus on it.
---@param pos Vector
function Camera:SetFocusPosition(pos)
end

---Immediately moves the camera to the specified position.
---
---**BUG:** This function currently does not work with Active Cam enabled as the camera snaps back to its original position in each update.
---@param pos Vector
function Camera:SnapToPosition(pos)
end

---Returns if the provided in-world position is visible to the camera.
---@param pos Vector
---@return boolean
function Camera:IsPosVisible(pos)
end

---@class EntitiesSaveState
local EntitiesSaveState = {}

---TODO: Document me!
---@return boolean
function EntitiesSaveState:GetB1()
end

---TODO: Document me!
---@return boolean
function EntitiesSaveState:GetB2()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetDropSeed()
end

---TODO: Document me!
---@return number
function EntitiesSaveState:GetF1()
end

---TODO: Document me!
---@return number
function EntitiesSaveState:GetF2()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetGridSpawnIdx()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetI1()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetI2()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetI3()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetI4()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetI5()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetI6()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetI7()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetI8()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetInitSeed()
end

---TODO: Document me!
---@return EntityType
function EntitiesSaveState:GetSpawnerType()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetSpawnerVariant()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetSubType()
end

---TODO: Document me!
---@return EntityType
function EntitiesSaveState:GetType()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetU1()
end

---TODO: Document me!
---@return integer
function EntitiesSaveState:GetVariant()
end

---TODO: Document me!
---@param value boolean
function EntitiesSaveState:SetB1(value)
end

---TODO: Document me!
---@param value boolean
function EntitiesSaveState:SetB2(value)
end

---TODO: Document me!
---@param value number
function EntitiesSaveState:SetF1(value)
end

---TODO: Document me!
---@param value number
function EntitiesSaveState:SetF2(value)
end

---TODO: Document me!
---@param value integer
function EntitiesSaveState:SetI1(value)
end

---TODO: Document me!
---@param value integer
function EntitiesSaveState:SetI2(value)
end

---TODO: Document me!
---@param value integer
function EntitiesSaveState:SetI3(value)
end

---TODO: Document me!
---@param value integer
function EntitiesSaveState:SetI4(value)
end

---TODO: Document me!
---@param value integer
function EntitiesSaveState:SetI5(value)
end

---TODO: Document me!
---@param value integer
function EntitiesSaveState:SetI6(value)
end

---TODO: Document me!
---@param value integer
function EntitiesSaveState:SetI7(value)
end

---TODO: Document me!
---@param value integer
function EntitiesSaveState:SetI8(value)
end

---TODO: Document me!
---@param position Vector
function EntitiesSaveState:SetPos(position)
end

---TODO: Document me!
---@param subType integer
function EntitiesSaveState:SetSubType(subType)
end

---TODO: Document me!
---@param type integer
function EntitiesSaveState:SetType(type)
end

---TODO: Document me!
---@param num integer
function EntitiesSaveState:SetU1(num)
end

---TODO: Document me!
---@param variant integer
function EntitiesSaveState:SetVariant(variant)
end


---@class PocketItem
local PocketItem = {}

---Returns the ID of the PocketItem. Returns `0` if the slot is empty.
---
---For cards, returns `Card`.
---
---For pills, returns `PillColor`.
---
---For items, returns the corresponding `ActiveSlot` (either `ActiveSlot.SLOT_POCKET` or `ActiveSlot.SLOT_POCKET2`).
---@return Card | PillColor | ActiveSlot
function PocketItem:GetSlot()
end

---Returns the `PocketItemType`.
---
---This value is unreliable if the slot is currently empty, as the game sometimes does not clear it.
---@return PocketItemType
function PocketItem:GetType()
end

---@class GridEntitiesSaveStateVector
local GridEntitiesSaveStateVector = {}

---TODO: Document me!
---@param index integer
---@return GridEntityDesc
function GridEntitiesSaveStateVector:Get(index)
end

---TODO: Document me!
---@param type GridEntityType
---@return GridEntityDesc
function GridEntitiesSaveStateVector:GetByType(type)
end


---@class ItemOverlay
_G.ItemOverlay = {}

---Returns the overlay's delay.
---@return integer
function ItemOverlay.GetDelay()
end

---Returns the Mega Mush player sprite.
---@return Sprite
function ItemOverlay.GetMegaMushPlayerSprite()
end


---@return Giantbook
function ItemOverlay.GetOverlayID()
end

---Returns the player.
---@return EntityPlayer
function ItemOverlay.GetPlayer()
end

---Returns the sprite.
---@return Sprite
function ItemOverlay.GetSprite()
end

---Shows the overlay.
---@param giantbookId Giantbook
---@param delay? integer @default: `3`
---@param player? EntityPlayer @default: `nil`
function ItemOverlay.Show(giantbookId, delay, player)
end


---@class LootList
local LootList = {}

---@return LootList
function _G.LootList()
end

---@return LootListEntry[]
function LootList:GetEntries()
end

---@param type EntityType
---@param variant integer
---@param subtype integer
---@param seed? integer @default: `Random()`
---@param rng? RNG @default: `nil`
function LootList:PushEntry(type, variant, subtype, seed, rng)
end

---@class BossPoolManager
_G.BossPoolManager = {}

---@param stageID StbType
---@return BossPool
function BossPoolManager.GetPool(stageID)
end

---Returns the removed status of all bosses
---
---BossPoolManager.GetRemovedBosses()[BossType.MONSTRO] to check if Monstro is removed.
---@return {[BossType | integer]: boolean}
function BossPoolManager.GetRemovedBosses()
end

---Returns the current's level boss blacklist
---
---BossPoolManager.GetRemovedSpecialBosses()[BossType.MONSTRO] to check if Monstro has been blacklisted.
---@return {[BossType | integer]: boolean}
function BossPoolManager.GetRemovedSpecialBosses()
end

---@class Weapon
local Weapon = {}

---TODO: Document me!
---@param collectible CollectibleType
function Weapon:ClearItemAnim(collectible)
end

---@return integer
function Weapon:GetCharge()
end

---@return Vector
function Weapon:GetDirection()
end

---@return integer
function Weapon:GetFireDelay()
end

---@return integer
function Weapon:GetMaxFireDelay()
end

---Returns the weapon's modifiersin bitmask form.
---@return WeaponModifier
function Weapon:GetModifiers()
end

---Returns the number of times the player has "fired". Not affected by multi-shot or additional shots, such as Mutant Spider and Mom's Eye. Some `WeaponType`s increase this in a different way, such as with Brimstone, which increases it by 1 every
---@return integer
function Weapon:GetNumFired()
end

---Returns the weapon's owner. Returns an `Entity` object, but is expected to be restricted to `EntityPlayer` and `EntityFamiliar`.
---@return Entity
function Weapon:GetOwner()
end

---@return WeaponType
function Weapon:GetWeaponType()
end

---Returns `false` for having collectibles like Marked and Analog Stick. Will still return true for `WeaponType`s that naturally allow you to shoot in any direction like Forgotten's Bone, Ludovico Technique, etc.
---@return boolean
function Weapon:IsAxisAligned()
end

---TODO: Document me!
---@param item CollectibleType
---@return boolean
function Weapon:IsItemAnimFinished(item)
end

---TODO: Document me!
---@param item CollectibleType
---@param anim integer
---@param position Vector
---@param charge number
function Weapon:PlayItemAnim(item, anim, position, charge)
end

---@param charge integer
function Weapon:SetCharge(charge)
end

---@param delay number
function Weapon:SetFireDelay(delay)
end

---@param time integer
function Weapon:SetHeadLockTime(time)
end

---@param modifiers WeaponModifier
function Weapon:SetModifiers(modifiers)
end


---@class AnimationFrame
local AnimationFrame = {}

---@return Color **READONLY**
function AnimationFrame:GetColor() end

---@return Vector crop **READONLY**
function AnimationFrame:GetCrop() end

---@return number
function AnimationFrame:GetHeight() end

---@return Vector **READONLY**
function AnimationFrame:GetPivot() end

---@return Vector **READONLY**
function AnimationFrame:GetPos() end

---@return number
function AnimationFrame:GetRotation() end

---@return Vector **READONLY**
function AnimationFrame:GetScale() end

---@return number
function AnimationFrame:GetWidth() end

---@return boolean
function AnimationFrame:IsInterpolated() end

---@return boolean
function AnimationFrame:IsVisible() end

---@return integer
function AnimationFrame:GetStartFrame() end

---@return integer
function AnimationFrame:GetEndFrame() end


---@class NullFrame
local NullFrame = {}

---@return Color
function NullFrame:GetColor()
end

---@return Vector
function NullFrame:GetPos()
end

---@return number
function NullFrame:GetRotation()
end

---@return Vector
function NullFrame:GetScale()
end

---@return boolean
function NullFrame:IsVisible()
end


---@class FXParams
---@field ColorModifier ColorModifier
---@field LightColor KColor
---@field ShadowAlpha number
---@field ShadowColor KColor
---@field UseWaterV2 boolean If `true`, water will use the reflective shader featured in Downpour and Dross.
---@field WaterColorMultiplier KColor
---@field WaterEffectColor Color
local FXParams = {}

---@class RoomTransition
_G.RoomTransition = {}

---TODO: Might become an enum. Documenting directly under function for now.
---@return integer TransitionMode
---|0 # NONE --When no transition is happening.
---|1 # EXIT_ROOM --When exiting the room.
---|2 # PAUSE_EXIT_ROOM --Still within the room you're exiting from, but playing a special non-directional room transition such as when teleporting.
---|3 # ENTER_ROOM --Entering and loading the room you moved into.
---|4 # PAUSE_ENTER_ROOM --Still within the room you're entering, but playing a special non-directional room transition such as when teleporting.
function RoomTransition.GetTransitionMode()
end

---Returns the versus screen sprite.
---@return Sprite
function RoomTransition.GetVersusScreenSprite()
end

---Returns true if the boss intro is currently rendering.
---@return boolean
function RoomTransition.IsRenderingBossIntro()
end

---Starts a boss intro.
---@param boss1 BossType
---@param boss2? BossType @default: `0`. If it is a non-zero value, a second boss will be rendered if the room is a Double Trouble encounter.
function RoomTransition.StartBossIntro(boss1, boss2)
end

---@return Sprite
function RoomTransition.GetPlayerExtraPortraitSprite()
end


---@class ScoreSheet
_G.ScoreSheet = {}

---TODO: Document me!
---@param Stage LevelStage
---@param StageType StageType
---@param Time integer
function ScoreSheet.AddFinishedStage(Stage, StageType, Time)
end

---TODO: Document me!
function ScoreSheet.Calculate()
end

---Returns the obtained points for defeating Blue Baby in the Chest.
---@return integer
---|0 # Blue Baby has not been defeated.
---|4000 # Blue Baby has been defeated.
function ScoreSheet.GetBlueBabyBonus()
end

---Returns the current amount of points lost for suffering damage.
---@return integer
function ScoreSheet.GetDamagePenalty()
end

---Returns the obtained points for visiting rooms, clearing rooms, and killing enemies.
---@return integer
function ScoreSheet.GetExplorationBonus()
end

---Returns the current amount of points lost for collecting items throughout the run.
---@return integer
function ScoreSheet.GetItemPenalty()
end

---Returns the obtained points for defeating The Lamb in the Dark Room.
---@return integer
---|0 # The Lamb has not been defeated.
---|4000 # The Lamb has been defeated.
function ScoreSheet.GetLambBonus()
end

---Returns the obtained points for defeating Mega Satan.
---@return integer
---|0 # Mega Satan has not been defeated.
---|6666 # Mega Satan has been defeated.
function ScoreSheet.GetMegaSatanBonus()
end

---Returns the run's ending.
---@return Ending
function ScoreSheet.GetRunEnding()
end

---Returns the amount of time the run has lasted for in the score sheet.
---@return integer
function ScoreSheet.GetRunTime()
end

---Returns the `LevelStage` goal set for the run.
---@return LevelStage
function ScoreSheet.GetRunTimeLevel()
end

---Returns the `StageType` goal set for the run.
---@return StageType
function ScoreSheet.GetRunTimeLevelType()
end

---Returns the obtained points for clearing Boss Rush and/or defeating Hush.
---@return integer
---|0 # Neither events have been completed.
---|4444 # Boss Rush has been cleared.
---|5555 # Hush has been defeated.
---|9999 # Both events have been completed.
function ScoreSheet.GetRushBonus()
end

---Returns the obtained points for the raw amount of pickups collected.
---@return integer
function ScoreSheet.GetSchwagBonus()
end

---Returns the amount of points for reaching certain floors. Each floor's bonus can only be activated once per run. `StageType` is ignored. Below is a list of floors and their respective bonuses.
---
---Basement 1: `500`
---
---Basement 2: `1000`
---
---Caves 1/2: `1500`
---
---Depths 1/2: `2500`
---
---Womb 1/2, Cathedral, Sheol: `3000`
---
---Chest, Dark Room: `4000`
---@return integer
function ScoreSheet.GetStageBonus()
end

---Returns how many points you lose in a run for spending time clearing floors, which varies according to the events you've cleared throughout the run.
---@return integer
function ScoreSheet.GetTimePenalty()
end

---Returns the total amount of points for the run.
---
---This is the same as the score displayed when expanding the map.
---@return integer
function ScoreSheet.GetTotalScore()
end

---Sets the run's ending.
---@param ending Ending
function ScoreSheet.SetRunEnding(ending)
end


---**NOTE**: In upcoming release of REPENTOGON v1.0.6
_G.PauseMenu = {}

---@return Sprite
function PauseMenu.GetPauseMenuSprite()
end

---@return Sprite
function PauseMenu.GetMyStuffSprite()
end

---@return Sprite
function PauseMenu.GetCompletionMarksSprite()
end

---@return Sprite
function PauseMenu.GetStatsSprite()
end

---@return PauseMenuStates
function PauseMenu.GetState()
end

---@param pauseMenuState PauseMenuStates
function PauseMenu.SetState(pauseMenuState)
end

function PauseMenu.GetSelectedElement()
end

---@param elementId integer
function PauseMenu.SetSelectedElement(elementId)
end

---@class NightmareScene
_G.NightmareScene = {}

---@return Sprite 
function NightmareScene.GetBackgroundSprite()
end

---@return Sprite 
function NightmareScene.GetBubbleSprite()
end

---@return integer[]
function NightmareScene.GetProgressBarMap()
end

---@return Sprite
function NightmareScene.GetProgressBarSprite()
end

---Returns true if the Dogma nightmare scene is playing (when interacting with Mom's Bed in Home).
---@return boolean 
function NightmareScene.IsDogmaNightmare()
end

---@return Sprite
function NightmareScene.GetPlayerExtraPortraitSprite()
end

---@class PlayerManager
_G.PlayerManager = {}

---Returns true if any player has the provided collectible.
---@param collectible CollectibleType
---@return boolean
function PlayerManager.AnyoneHasCollectible(collectible)
end

---Returns true if any player has the provided trinket.
---@param trinket TrinketType
---@return boolean
function PlayerManager.AnyoneHasTrinket(trinket)
end

---Returns true if any player matches the provided PlayerType.
---@param PlayerType PlayerType
---@return boolean
function PlayerManager.AnyoneIsPlayerType(PlayerType)
end

---Returns true if any player matching the provided PlayerType has Birthright.
---@param PlayerType PlayerType
---@return boolean
function PlayerManager.AnyPlayerTypeHasBirthright(PlayerType)
end

---Returns the player of the provided PlayerType which picked up the Birthright first. If no player has picked up Birthright first, returns `nil`
---@param PlayerType PlayerType
---@return EntityPlayer?
function PlayerManager.FirstBirthrightOwner(PlayerType)
end

---Returns the first player to pick up the provided collectible. If no player has picked up the collectible yet, returns `nil`.
---@param collectible CollectibleType
---@param lazarusSharedGlobalTag? boolean @default: `true`
---@return EntityPlayer?
function PlayerManager.FirstCollectibleOwner(collectible, lazarusSharedGlobalTag)
end

---Returns the player of the provided PlayerType which was initialized first. If said player does not exist, returns `nil`.
---@param PlayerType PlayerType
---@return EntityPlayer?
function PlayerManager.FirstPlayerByType(PlayerType)
end

---Returns the first player to pick up the provided trinket. If no player has picked up the trinket yet, returns `nil`.
---@param trinket TrinketType
---@param rng? RNG @default: `nil`
---@param lazarusSharedGlobalTag? boolean @default: `true`
---@return EntityPlayer?
function PlayerManager.FirstTrinketOwner(trinket, rng, lazarusSharedGlobalTag)
end

---Returns the Esau Jr `EntityPlayer` from the player at the provided `index`.
---@param index? integer @default: `0`.
---@return EntityPlayer? `nil` if the Esau Jr. collectible had not been used by that player
function PlayerManager.GetEsauJrState(index)
end

---Returns the total number of the specified collectible held by all players.
---@param collectible CollectibleType
---@return integer
function PlayerManager.GetNumCollectibles(collectible)
end

---Returns a table containing all players.
---@return EntityPlayer[]
function PlayerManager.GetPlayers()
end

---Returns the total trinket multiplier of the provided trinket. This is calculated from all players holding the trinket.
---@param trinket TrinketType
---@return integer
function PlayerManager.GetTotalTrinketMultiplier(trinket)
end

---Returns true if the game is in co-op mode.
---@return boolean
function PlayerManager.IsCoopPlay()
end

---Spawns a co-player.
---@param playerType PlayerType
---@return EntityPlayer
function PlayerManager.SpawnCoPlayer2(playerType)
end

---Triggers the effects of a room clear for players and familiars.
function PlayerManager.TriggerRoomClear()
end

---@param playerType PlayerType
---@param trinketType TrinketType
---@param ignoreModifiers? boolean @default: `false`
function PlayerManager.AnyPlayerTypeHasTrinket(playerType, trinketType, ignoreModifiers)
end

---@param playerType PlayerType
---@param itemID TrinketType
---@param ignoreModifiers? boolean @default: `false`
function PlayerManager.AnyPlayerTypeHasCollectible(playerType, itemID, ignoreModifiers)
end

---Instantly removes a player.
---@param player EntityPlayer
function PlayerManager.RemoveCoPlayer(player)
end

---@class Ambush
_G.Ambush = {}

---@return integer
function Ambush.GetCurrentWave() end

---Returns the maximum amount of boss rush waves.
---@return integer numWaves By default, the maximum amount of boss rush waves are `15`. It's important to note that mods can modify the maximum amount of boss rush waves.
function Ambush.GetMaxBossrushWaves() end

---Returns the maximum amount of challenge room waves.
---@return integer numWaves By default, the maximum amount of challenge room waves are `3`. It's important to note that mods can modify the maximum amount of challenge room waves.
function Ambush.GetMaxChallengeWaves() end

---@return RoomConfigRoom
function Ambush.GetNextWave() end

---@return RoomConfigRoom[]
function Ambush.GetNextWaves() end

---Sets the maximum amount of boss rush waves. This caps out at `25`.
---@param waves integer
function Ambush.SetMaxBossrushWaves(waves) end

---**BUG:** Currently, the value returned from this function is not reset on game restart.
---@param waves integer
function Ambush.SetMaxChallengeWaves(waves) end

---**BUG:** Calling this function will do nothing unless a boss rush has been triggered at least once during the current game session.
function Ambush.SpawnBossrushWave() end

---**BUG:** Calling this function crashes the game if the current game mode is Greed or Greedier.
---
---The game also crashes if the current floor is Blue Womb.
function Ambush.SpawnWave() end

---**BUG:** Calling this function outside of the boss rush room or a challenge room will do nothing except permanently close the doors, resulting in a softlock.
function Ambush.StartChallenge() end

---Gets the number of waves in a boss challenge room
---@return integer
function Ambush.GetMaxBossChallengeWaves() end

---Sets the number of waves in a boss challenge room
function Ambush.SetMaxBossChallengeWaves() end

---@class RoomConfig
_G.RoomConfig = {}

---Returns a RoomConfigRoom corresponding to the given arguments.
---@param seed integer
---@param reduceWeight boolean If true, the selected room's weight is decreased.
---@param stage StbType The stage the room belongs to.
---@param type RoomType
---@param shape? RoomShape @default: `RoomShape.NUM_ROOMSHAPES`, which allows the function to pick a room regardless of its shape.
---@param minVariant? integer @default: `-1`.
---@param maxVariant? integer @default: `-1`
---@param minDifficulty? integer @default: `0.`
---@param maxDifficulty? integer @default: `10.`
---@param requiredDoors? integer @default: `0.`
---@param subType? integer @default: `-1`.
---@param mode? integer @default: `-1`. TODO: Document me!
---@return RoomConfigRoom
function RoomConfig.GetRandomRoom(seed, reduceWeight, stage, type, shape, minVariant, maxVariant, minDifficulty,
										maxDifficulty, requiredDoors, subType, mode)
end

---Returns a RoomConfigRoom corresponding to the given arguments.
---@param stage StbType
---@param type RoomType
---@param variant integer
---@param difficulty? integer @default: `-1`, pulling from all difficulties.
---@return RoomConfigRoom
function RoomConfig.GetRoomByStageTypeAndVariant(stage, type, variant, difficulty)
end

---@param StbType StbType
---@return RoomConfigStage
function RoomConfig.GetStage(StbType)
end

---@alias RoomConfigHolder RoomConfig
_G.RoomConfigHolder = RoomConfig

---@diagnostic disable: duplicate-set-field
---@class ImGui
_G.ImGui = {}

---Adds a button.
---@param parentId string The id of the parent element.
---@param elementId string The id of the button.
---@param label? string @default: `""`. The button's label.
---@param clickCallback? nil | fun(clickCount: number) @default: `nil`. If defined, the function is called when the button is clicked on.
---@param isSmall? boolean @default: `false`. If `true`, the button is small.
function ImGui.AddButton(parentId, elementId, label, clickCallback, isSmall)
end

---Adds a callback to an ImGui element. An element can have one callback per type.
---@param elementId string The id of the element that the callback is tied to.
---@param type ImGuiCallback The type of callback to add.
---@param func fun(isChecked: boolean) The function that is tied to the added callback.
function ImGui.AddCallback(elementId, type, func)
end

---Adds a checkbox.
---@param parentId string The id of the parent element.
---@param elementId string The id of the element.
---@param label? string default: `""`. The button's label.
---@param changeCallback? nil | fun(newValue: boolean) default: `nil`. If defined, the function is called when the checkbox is ticked or unticked.
---@param isActive? boolean @default: `false`. If `true`, the checkbox will be checked on creation. If `false`, the checkbox won't be checked upon creation.
function ImGui.AddCheckbox(parentId, elementId, label, changeCallback, isActive)
end

---Adds a combobox element which represents a single line element that allows you to select a value from a dropdown menu.
---@param parentId string The id of the parent element.
---@param elementId string The id of the combobox.
---@param label? string @default: `""`. The combobox's label.
---@param changeCallback nil | fun(selectedIndex: integer, optionValue: string) @default: `nil`. If defined, the function is called when an option is selected.
---@param options? string[] @default: `{}`. A table of strings of each element in the combobox.
---@param selectedIndex? integer @default: `0`. The index of the element in the options table that is initially selected when the combobox is created.
---@param isSlider? boolean @default: `false`. If `true`, instead of a dropdown menu, the values can be selected by interacting with a slider element.
function ImGui.AddCombobox(parentId, elementId, label, changeCallback, options, selectedIndex, isSlider)
end

---Adds a float dragger element.
---@param parentId string The id of the parent element.
---@param elementId string The id of the dragger.
---@param label? string @default: `false`. The dragger's label.
---@param changeCallback? nil | fun(newValue: number) @default: `nil`. If defined, the function is called when the dragger is dragged on.
---@param startingValue? number @default: `0`. The initial value of the dragger.
---@param speed? number @default: `1`. The speed of the dragger.
---@param min? number @default: 0`. The minimum value of the dragger.
---@param max? number @default: `100`. The maximum value of the dragger.
---@param formatting? string @default: `%.3f`. The format specifier used to format the label displaying the current value of the dragger.
function ImGui.AddDragFloat(parentId, elementId, label, changeCallback, startingValue, speed, min, max, formatting)
end

---Adds an integer dragger element.
---@param parentId string The id of the parent element.
---@param elementId string The id of the dragger.
---@param label? string @default: `""`. The dragger's label.
---@param changeCallback? nil | fun(newValue: integer) @default: `nil`. If defined, the function is called when the dragger is dragged on.
---@param startingValue? integer @default: `0`. The initial value of the dragger.
---@param speed? number  @default: `1`. The speed of the dragger.
---@param min? integer  @default: `0`. The minimum value of the dragger.
---@param max? integer  @default: `100`. The maximum value of the dragger.
---@param formatting? string  @default: `%d%`. The format specifier used to format the label displaying the current value of the dragger.
function ImGui.AddDragInteger(parentId, elementId, label, changeCallback, startingValue, speed, min, max, formatting)
end

---Adds a generic element. This is useful for adding simple elements that do not require interaction such as bullets as an element id is not required.
---@param parentId string The id of the parent element.
---@param elementId? string @default: `""`. The id of the element.
---@param elementType ImGuiElement The type of element being created.
---@param label? string @default: `""`. The element's label.
function ImGui.AddElement(parentId, elementId, elementType, label)
end

---Adds a RGB or RGBA selector.
---@param parentId string The id of the parent element.
---@param elementId string The id of the RGB selector.
---@param label? string @default: `""`. The RGB selector's label.
---@param changeCallback? nil | fun(r: number, g: number, b: number) @default: `nil`. If defined, the function is called when a color is selected.
---@param r? number @default: `0`. The initial selected color's red component.
---@param g? number @default: `0`. The initial selected color's green component.
---@param b? number @default: `0`. The initial selected color's blue component.
---@param a? number @default: `1`. The initial selected color's alpha component.
---@overload fun(parentId: string, elementId: string, label?: string, changeCallback?: fun(r: number, g: number, b: number), r?: number, g?: number, b?: number)
function ImGui.AddInputColor(parentId, elementId, label, changeCallback, r, g, b, a)
end

---Adds a controller input element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the controller input.
---@param buttonLabel? string @default: `""`. The controller input's label.
---@param changeCallback? nil | fun(selectedButton: integer) @default: `nil`. If defined, the function is called when a new button is selected.
---@param defaultValue? integer @default: `0`. The initial selected element.
function ImGui.AddInputController(parentId, elementId, buttonLabel, changeCallback, defaultValue)
end

---Adds a float input element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the float input.
---@param label? string @default: `""`. The float input's label.
---@param changeCallback? nil | fun(newValue: number) @default: `nil`. If defined, the function is called when a new value is selected.
---@param defaultValue? number @default: `0`. The starting value of the float input.
---@param step? number @default: `1`. How much the current value is incremented if the player clicks on the plus or minus button.
---@param stepFast? number @default: `100`. TODO: Document me!
function ImGui.AddInputFloat(parentId, elementId, label, changeCallback, defaultValue, step, stepFast)
end

---Adds an integer input element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the integer input.
---@param label? string @default: `""`. The integer input's label.
---@param changeCallback? nil | fun(newValue: integer) @default: `nil`. If defined, the function is called when a new value is selected.
---@param defaultValue? integer @default: `0`. The starting value of the integer input.
---@param step? integer @default: `1`. How much the current value is incremented if the player clicks on the plus or minus button.
---@param stepFast? integer @default: `100`. TODO: Document me! @default: `.
function ImGui.AddInputInteger(parentId, elementId, label, changeCallback, defaultValue, step, stepFast)
end

---Adds an input for keyboard buttons.
---@param parentId string The id of the parent element.
---@param elementId string The id of the keyboard input element.
---@param buttonLabel? string @default: `""`. The keyboard input element's label
---@param changeCallback? nil | fun(key: Keyboard, buttonName: string) @default: `nil`.
---@param defaultValue? number @default: `0`.
function ImGui.AddInputKeyboard(parentId, elementId, buttonLabel, changeCallback, defaultValue)
end

---Adds a text input element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the text input.
---@param label? string @default: `""`. The text input's label.
---@param changeCallback? nil | fun(newValue: string) @default: `nil`. If defined, the function is called when a new value is typed in.
---@param defaultValue? string @default: `""`. The default value of the text input.
---@param hintText? string @default: `""`. The hint text is displayed in the textbox if the player did not type anything in it.
function ImGui.AddInputText(parentId, elementId, label, changeCallback, defaultValue, hintText)
end

---Adds a multiline text input element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the multiline text input.
---@param label? string @default: `""`. The text input's label.
---@param changeCallback? nil | fun(newValue: string) @default: `. If defined, the function is called when a new value is typed in.
---@param defaultValue? string @default: `""`. The default value of the text input.
---@param displayedLines? integer @default: `6`. The amount of lines that the textbox can display.
function ImGui.AddInputTextMultiline(parentId, elementId, label, changeCallback, defaultValue, displayedLines)
end

---Adds a plot histogram element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the histogram.
---@param label? string @default: `""`. The histogram's label.
---@param values? number[] @default: `{}`. The list of values to display on the histogram.
---@param overlayText? string @default: `""`. The overlay text.
---@param minimum? number @default: `FLT_MIN`. The minimum size on the histogram.
---@param maximum? number @default: `FLT_MAX`. The maximum size on the histogram.
---@param height? number @default: `40`. The height of the histogram.
function ImGui.AddPlotHistogram(parentId, elementId, label, values, overlayText, minimum, maximum, height)
end

---Adds a line-diagram element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the line-diagram.
---@param label? string @default: `""`. The line-diagram's label.
---@param values? number[] @default: `{}`. The list of values to display on the line-diagram.
---@param overlayText? string @default: `""`. The overlay text.
---@param minimum? number @default: `FLT_MIN`. The minimum size on the line-diagram.
---@param maximum? number @default: `FLT_MAX`. The maximum size on the line-diagram.
---@param height? number @default: `40`. The height of the line-diagram.
function ImGui.AddPlotLines(parentId, elementId, label, values, overlayText, minimum, maximum, height)
end

---Adds a progress bar element. The progress value must be inbetween 0 and 1.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the progress bar input.
---@param label? string @default: `""`. The progress bar's label. If the string is empty, the progress bar will render over the full width of the parent element.
---@param progress? number @default: `0`. The initial progress value.
---@param overlayText? string @default: `""`. The overlay text. If the overlay text is empty, the progress bar will display the current fill state in percent inside the progress bar (for example, 50%, when the progress is set to 0.5).
function ImGui.AddProgressBar(parentId, elementId, label, progress, overlayText)
end

---Adds a radio buttons element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the radio buttons input.
---@param changeCallback? nil | fun(newValue: number) @default: `nil`. If defined, the function is called when a radio button is selected.
---@param options? string[] @default: `{}`. The list radio buttons to display.
---@param selectedIndex? integer @default: `0`. The index of the initially selected radio button in the options argument.
---@param renderSameLine? boolean @default: `true`. If true, all of the radio buttons will display on the same line.
function ImGui.AddRadioButtons(parentId, elementId, changeCallback, options, selectedIndex, renderSameLine)
end

---Adds a float slider element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the slider.
---@param label? string @default: `""`. The float slider's label.
---@param changeCallback? nil | fun(newValue: number) @default: `nil`. If defined, the function is called when a radio button is selected.
---@param defaultValue? number @default: `0`. The initial value of the slider.
---@param min? number @default: `0`. The minimum value of the slider.
---@param max? number @default: `100`. The maximum value of the slider.
---@param stringFormatting? string @default: `%.3f`. The format specifier used to format the label displaying the current value of the dragger.
function ImGui.AddSliderFloat(parentId, elementId, label, changeCallback, defaultValue, min, max, stringFormatting)
end

---Adds an integer slider element.
---@param parentId string The id of the parent element.
---@param elementId string The element id of the radio buttons input.
---@param label? string @default: ""`. The integer slider's label.
---@param changeCallback? nil | fun(newValue: integer) @default: `nil`. If defined, the function is called when a radio button is selected.
---@param defaultValue? integer @default: 0``. The initial value of the slider.
---@param min? integer @default: `0`. The minimum value of the slider.
---@param max? integer @default: `100`. The maximum value of the slider.
---@param stringFormatting? string @default: `%d%`. The format specifier used to format the label displaying the current value of the dragger.
function ImGui.AddSliderInteger(parentId, elementId, label, changeCallback, defaultValue, min, max, stringFormatting)
end

---Adds a tab.
---@param parentId string The id of the parent element. It must be a tab bar.
---@param elementId string The element of the tab.
---@param label string The tab's label.
function ImGui.AddTab(parentId, elementId, label)
end

---Adds a tab bar.
---@param parentId string The id of the parent element.
---@param elementId string The element of the tab bar.
function ImGui.AddTabBar(parentId, elementId)
end

---Adds a text element.
---@param parentId string The id of the parent element.
---@param text string The element's text.
---@param wrapText? boolean @default: `false`. If true, the text will wrap on the window borders.
---@param elementId? string @default: `""`. The element of the text.
function ImGui.AddText(parentId, text, wrapText, elementId)
end

---Creates an entry to the main menu bar in Repentogon.
---@param elementId string The menu's id.
---@param label? string @default: `""`. The menu's text.
function ImGui.CreateMenu(elementId, label)
end

---Creates a new window. You will need to use `ImGui:LinkToWindowElement()` or `ImGui:SetVisible()` to toggle the visibility of the window.
---@param elementId string The id of the window.
---@param title string @default: `""`. The window's title.
function ImGui.CreateWindow(elementId, title)
end

---Returns true if an element with the provided id exists
---@param elementId string
---@return boolean
function ImGui.ElementExists(elementId)
end

---Returns the player's mouse positions in screen coordinates.
---
---Use this instead of `Input.GetMousePosition()` when working with imgui.
---@return Vector
function ImGui.GetMousePosition()
end

---Returns true if an element with the provided id is visible.
---@param elementId string
---@return boolean
function ImGui.GetMousePosition(elementId)
end

---Returns true if an element with the provided id is a window and is pinined.
---@param elementId string
---@return boolean
function ImGui.GetWindowPinned(elementId)
end

---Closes ImGui
function ImGui.Hide()
end

---Converts ImGui coordinates into World coordinates.
---
---**BUG:** This function does not work correctly when the game's scale factor exceeds MaxRenderScale.
---@param position Vector
---@return Vector
function ImGui.ImGuiToWorld(position)
end

---Connects a Window or Popup element to another element, making said element act as a "toggle" for that window.
---
---**Example:**
---
---```lua
---local imgui = Isaac.GetImGui()
---imgui:CreateMenu("myMenu", "Test Menu")
---imgui:AddElement("myMenu", "myButton", ImGuiElement.MenuItem, "Some Text")
---imgui:CreateWindow("myWindow", "Some Window title")
---imgui:LinkWindowToElement("myWindow", "myButton")
---```
---@param windowId string
---@param elementId string
function ImGui.LinkWindowToElement(windowId, elementId)
end

---Displays a pop-up message window in the style of a notification. Severity values are 0 = Info, 1 = success, 2 = warning, 3 = error.
---@param text string
---@param severity? ImGuiNotificationType @default: `ImGuiNotificationType.INFORMATION`
---@param lifetime? integer @default: `5000`
function ImGui.PushNotification(text, severity, lifetime)
end

---Removes the callback of the given type from the element.
---@param elementId string
---@param callback ImGuiCallback
function ImGui.RemoveCallback(elementId, callback)
end

---Removes a color modifier of the given type from the element.
---@param elementId string
---@param colorType ImGuiColor
function ImGui.RemoveColor(elementId, colorType)
end

---Removes an element.
---@param elementId string
function ImGui.RemoveElement(elementId)
end

---Removes a menu.
---@param menuId string
function ImGui.RemoveMenu(menuId)
end

---Removes all custom defined Imgui elements and resets Imgui back to its original state.
function ImGui.Reset()
end

---Adds a color modifier to the element.
---@param elementId string
---@param colorType ImGuiColor
---@param red number
---@param green number
---@param blue number
---@param alpha? number @default: `1`
function ImGui.SetColor(elementId, colorType, red, green, blue, alpha)
end

---Adds a helpmarker to a given element. A Helpmarker is a (?) element rendered on the right of an element, which when hovered displays a tooltip.
---@param elementId string
---@param text string
function ImGui.SetHelpmarker(elementId, text)
end

---Adds a color modifier to text of the provided element.
---@param elementId string
---@param red number
---@param green number
---@param blue number
---@param alpha? number @default: `1`
function ImGui.SetTextColor(elementId, red, green, blue, alpha)
end

---Adds a tooltip to an element. The tooltip is displayed when hovering over the element.
---@param elementId string
---@param text string
function ImGui.SetTooltip(elementId, text)
end

---Sets an element's visibility.
---@param elementId string
---@param isVisible boolean
function ImGui.SetVisible(elementId, isVisible)
end

---Sets the pinned state of a window, making it visible when the ImGui interface is not active.
---@param elementId string
---@param isPinned boolean
function ImGui.SetWindowPinned(elementId, isPinned)
end

---Sets the position of the window in screen coordinates.
---@param windowId string
---@param x number
---@param y number
function ImGui.SetWindowPosition(windowId, x, y)
end

---Sets the width and height of the window, in pixels.
---@param windowId string
---@param width number
---@param height number
function ImGui.SetWindowSize(windowId, width, height)
end

---Opens ImGui
function ImGui.Show()
end

---Update arbitrary data of a given element.
---
---The dataTypes and the expected newDataValue are evaluated per element. Therefore, if you try to update data of an element where this data is not used,
---this function will throw an error for you.
---@param elementId string
---@param dataType ImGuiData
---@param newDataValue any
function ImGui.UpdateData(elementId, dataType, newDataValue)
end

---Updates the element's text or label.
---@param elementId string
---@param text string
function ImGui.UpdateText(elementId, text)
end

---Converts world coordinates into ImGui coordinates.
---
---**BUG:** This function does not work correctly when the game's scale factor exceeds MaxRenderScale.
---@param position Vector
---@return Vector
function ImGui.WorldToImGui(position)
end


---@class GenericPrompt
_G.GenericPrompt = {}

---Returns a GenericPrompt object. Allows for rendering a popup paper with the option to include text and tracking input for a yes/no decision.
---@return GenericPrompt
function GenericPrompt()
end

---@param SmallPrompt? boolean @default: `false`. If `true`, the prompt will be with much smaller paper instead
function GenericPrompt:Initialize(SmallPrompt)
end

---Starts showing the prompt on-screen.
function GenericPrompt:Show()
end

---Returns whether the prompt is active or not.
---@return boolean
function GenericPrompt:IsActive()
end

---Updates the animation of the prompt paper.
---@param ProcessInput boolean @`true` to track the player's input for selecting yes/no, `false` otherwise.
function GenericPrompt:Update(ProcessInput)
end

---Renders the prompt on-screen. Place this in any of the non-entity-specific RENDER callbacks.
function GenericPrompt:Render()
end

---Set text that will appear on the paper.
---@param Text1? string @default: `""`. Top line. Used as header text. Will be bold with a higher font size.
---@param Text2? string @default: `""`. Top-middle line. Used as header text. Will be bold with a higher font size.
---@param Text3? string @default: `""`. Middle line. Used as description text.
---@param Text4? string @default: `""`. Bottom-middle line. Used as description text.
---@param Text5? string @default: `""`. Bottom line. Used as description text.
function GenericPrompt:SetText(Text1, Text2, Text3, Text4, Text5)
end

---Returns the paper sprite of the prompt.
---@return Sprite
function GenericPrompt:GetSprite()
end

---Returns what selection the player is currently hovering over.
---@return integer
---|0 # No
---|1 # Yes
function GenericPrompt:GetCurrentSelection()
end

---Returns the chosen selection. Can return as 0 for "None" if the player dismisses the prompt.
---@return integer
---|0 # None
---|1 # Yes
---|2 # No
function GenericPrompt:GetSubmittedSelection()
end

---@class LayerState
local LayerState = {}

---@return BlendMode
function LayerState:GetBlendMode()
end

---@return Color
function LayerState:GetColor()
end

---@return Vector
function LayerState:GetCropOffset()
end

---@return string
function LayerState:GetDefaultSpritesheetPath()
end

---@return integer
function LayerState:GetLayerID()
end

---@return string
function LayerState:GetName()
end

---@return Vector
function LayerState:GetPos()
end

---Returns the bitflags of the current render flags.
---@return AnimRenderFlags
function LayerState:GetRenderFlags()
end

---@return number
function LayerState:GetRotation()
end

---@return Vector
function LayerState:GetSize()
end

---@return string
function LayerState:GetSpritesheetPath()
end

---Returns the wrap mode for the x coordinate. See [this website](https://open.gl/textures) for a general overview.
---@return integer
function LayerState:GetWrapSMode()
end

---Returns the wrap mode for the y coordinate. See [this website](https://open.gl/textures) for a general overview.
---@return integer
function LayerState:GetWrapTMode()
end

---@return boolean
function LayerState:IsVisible()
end

---@param color Color
function LayerState:SetColor(color)
end

---@param offset Vector
function LayerState:SetCropOffset(offset)
end

---@param position Vector
function LayerState:SetPos(position)
end

---Sets the current render flags. Accepts a bitmask.
---@param renderFlags AnimRenderFlags
function LayerState:SetRenderFlags(renderFlags)
end

---@param rotation number
function LayerState:SetRotation(rotation)
end

---@param size Vector
function LayerState:SetSize(size)
end

---@param isVisible boolean
function LayerState:SetVisible(isVisible)
end

---Sets the wrap mode for the x coordinate. See [this website](https://open.gl/textures) for a general overview.
---@param mode integer
---@return integer
function LayerState:SetWrapSMode(mode)
end

---Sets the wrap mode for the y coordinate. See [this website](https://open.gl/textures) for a general overview.
---@param mode integer
---@return integer
function LayerState:SetWrapTMode(mode)
end

---@param path string
function LayerState:SetCustomShader(path)
end

function LayerState:ClearCustomShader()
end

---Returns `true` if the specified shader is currently set. If no string is provided, returns true if any custom shader is applied.
---@param path? string
---@return boolean
function LayerState:HasCustomShader(path)
end

---@param path string
function LayerState:SetCustomChampionShader(path)
end

function LayerState:ClearCustomChampionShader()
end

---Returns `true` if the specified shader is currently set. If no string is provided, returns true if any custom shader is applied.
---@param path? string
---@return boolean
function LayerState:HasCustomChampionShader(path)
end

---@return boolean
function LayerState:GetFlipX()
end

---@return boolean
function LayerState:GetFlipY()
end

---@param FlipX boolean
function LayerState:SetFlipX(FlipX)
end

---@param FlipY boolean
function LayerState:SetFlipY(FlipY)
end


---@class AnimationData
local AnimationData = {}

---Returns a table of all the animation's `AnimationLayer` objects, ordered from bottom to top (NOT ordered by layer ID).
---@return AnimationLayer[]
function AnimationData:GetAllLayers() end

---@param layerId integer
---@return AnimationLayer
function AnimationData:GetLayer(layerId) end

---Returns the amount of frames the animation has.
---@return integer
function AnimationData:GetLength() end

---@return string
function AnimationData:GetName() end

---@return boolean
function AnimationData:IsLoopingAnimation() end


---@class REPENTOGON
---@field Version string
---@field Real true
---@field Name "REPENTOGON"
---@field Extras REPENTOGON_Extras
_G.REPENTOGON = {}

---Checks if REPENTOGON meets specified version. Always returns `true` on dev builds.
---@param targetVersion string
---@return boolean
function REPENTOGON.MeetsVersion(targetVersion) end

---@class REPENTOGON_Extras
---@field Changelog REPENTOGON_Changelog
---@field StatsMenu REPENTOGON_StatsMenu
---@field BestiaryMenu REPENTOGON_BestiaryMenu
---@field Misc {NoRPTGNFldrErr: function}

---@class REPENTOGON_Changelog
---@field AssetsLoaded boolean
---@field CurrentSheet integer
---@field CurrentState boolean
---@field ChangelogSprite Sprite
---@field Font Font
---@field FontColor KColor
---@field LineHeight number
---@field NoteOffset Vector
---@field NoteSprite Sprite
---@field PaperOffset Vector
---@field Sheets {Text: string, TextArray: string[]}[]
---@field ScrollSpeed number
---@field ScrollItertia number
---@field VersionFont Font
---@field VersionOffset Vector
---@field EvaluateText function
---@field LoadAssets function
---@field MenuRender function

---@class REPENTOGON_StatsMenu
---@field ArrowSprite Sprite
---@field CurrentlyDisplayedCategoryID integer
---@field LeftArrowSpritePos Vector
---@field RightArrowSpritePos Vector
---@field ScheduleRefresh boolean
---@field StatPageAngleOffsetX number
---@field StatPageNumberOffsetX number
---@field StatSheetSprite Sprite
---@field StatSheetSpritePos Vector
---@field Stats [string,[string, number|string|fun():number|string][]][]

---@class REPENTOGON_BestiaryMenu
---@field ArrowSprite Sprite
---@field BestiarySheetSprite Sprite
---@field BestiarySheetSpritePos Vector
---@field PageTextPos Vector
---@field PageWidgetPos Vector


_G.Console = {}

---Returns a table containing current command history.
---@return string[]
function Console.GetCommandHistory()
end

---Returns a table containing every previous entry printed to the console.
---
---This is ordered last-to-first- the first entry will be the currently blank line awaiting user input, followed by the previous print, and so on. The last line will always be "Repentance Console".
---@return string[]
function Console.GetHistory()
end

---Removes previous lines from history.
---@param amount? number @default: `1`. The amount of lines to remove from the history.
function Console.PopHistory(amount)
end

---Prints an error to the console, errors display in red text.
---@param error string
function Console.PrintError(error)
end

---Prints a warning to the console, warnings display in yellow text.
---@param warning string
function Console.PrintWarning(warning)
end

---Registers a command in the new console. These will show up in the new console's autocomplete.
---@param name string The name of the command
---@param description string The description of the command. It will show when typing the `help` command.
---@param helpText string Helpful information about the command. It will show up when typing `help (name)`.
---@param showOnMenu boolean
---@param autoCompleteType AutocompleteType Has the command inherit the autocomplete type. If the command doesn't fit into any of the standard types, use `AutocompleteType.CUSTOM` combined with the `MC_CONSOLE_AUTOCOMPLETE` callback to create a bespoke one for this command.
function Console.RegisterCommand(name, description, helpText, showOnMenu, autoCompleteType)
end

---Registers a macro in the new console. These will show up in the new console's autocomplete for the `macro` command.
---@param name string The name of the macro
---@param commands string[] Table of strings containing the commands to be executed in order
function Console.RegisterMacro(name, commands)
end

---@class Backdrop
local Backdrop = {}

---@return Image
function Backdrop:GetFloorImage() end

---@return Image
function Backdrop:GetWallImage() end


---@class RoomConfigStage
local RoomConfigStage = {}

---Returns the `BackdropType` used in default rooms on the stage.
---@return BackdropType
function RoomConfigStage:GetBackdrop()
end

---Returns the png used for the boss portrait on the boss intro.
---@return string
function RoomConfigStage:GetBossSpot()
end

---Returns the name of the stage.
---@return string
function RoomConfigStage:GetDisplayName()
end

---Returns the `Music` used in default rooms on the stage.
---@return Music
function RoomConfigStage:GetMusic()
end

---Returns the png used for the player portrait on the boss intro and nightmare transition.
---@return string
function RoomConfigStage:GetPlayerSpot()
end

---@param mode? integer @default: `0`
---|0 # Normal Mode rooms
---|1 # Greed Mode rooms
---@return RoomConfigSet
function RoomConfigStage:GetRoomSet(mode)
end

---Returns the suffix used by the stage for stage-unique sprites, such as the boss/player spot and unique variants for enemies.
---@return string
function RoomConfigStage:GetSuffix()
end

---Returns the `BackdropType` used in default rooms on the stage.
---@param backdropType BackdropType
function RoomConfigStage:SetBackdrop(backdropType)
end

---Sets the png used for the boss portrait on the boss intro.
---@param spritePath string
function RoomConfigStage:SetBossSpot(spritePath)
end

---Sets the name of the stage.
---@param name string 
function RoomConfigStage:SetDisplayName(name)
end

---Sets the `Music` used in default rooms on the stage.
---@param music Music
function RoomConfigStage:SetMusic(music)
end

---Sets the png used for the player portrait on the boss intro and nightmare transition.
---@param spritePath string
function RoomConfigStage:SetPlayerSpot(spritePath)
end

---Sets the suffix used by the stage for stage-unique sprites, such as the boss/player spot and unique variants for enemies.
---@param suffix string
function RoomConfigStage:SetSuffix(suffix)
end

---@class EntitiesSaveStateVector
local EntitiesSaveStateVector = {}

---TODO: Document me!
---@param index integer
---@return EntitiesSaveState
function EntitiesSaveStateVector:Get(index)
end

---TODO: Document me!
---@param type EntityType
---@param variant? integer @default: `0`
---@param subType? integer @default: `0`
---@return EntitiesSaveState
function EntitiesSaveStateVector:GetByType(type, variant, subType)
end

function EntitiesSaveStateVector:Clear()
end

---@class ChallengeParams
_G.ChallengeParam = {}

---@return boolean
function ChallengeParam.CanShoot()
end

---@return Achievement[]
function ChallengeParam.GetAchievementList()
end

---@return number
function ChallengeParam.GetAddDamage()
end

---@return integer
function ChallengeParam.GetBlackHearts()
end

---@return integer
function ChallengeParam.GetCoins()
end

---@return CollectibleType[]
function ChallengeParam.GetCollectibleList()
end

---@return CollectibleType[]
function ChallengeParam.GetCollectibleTwinList()
end

---@return integer
function ChallengeParam.GetCurse()
end

---@return integer
function ChallengeParam.GetCurseFilter()
end

---@return Difficulty
function ChallengeParam.GetDifficulty()
end

---@return LevelStage
function ChallengeParam.GetEndStage()
end

---@return integer
function ChallengeParam.GetHearts()
end

---@return integer
function ChallengeParam.GetMaxHearts()
end

---@return number
function ChallengeParam.GetMinFireRate()
end

---@return string
function ChallengeParam.GetName()
end

---@return PlayerType
function ChallengeParam.GetPlayerType()
end

---@return RoomType[]
function ChallengeParam.GetRoomFilter()
end

---@return integer
function ChallengeParam.GetSoulHearts()
end

---@return Card
function ChallengeParam.GetStartingCard()
end

---@return PillEffect
function ChallengeParam.GetStartingPill()
end

---@return TrinketType[]
function ChallengeParam.GetTrinketList()
end

---@return boolean
function ChallengeParam.IsAltPath()
end

---@return boolean
function ChallengeParam.IsBigRangeEnabled()
end

---@return boolean
function ChallengeParam.IsMaxDamageEnabled()
end

---@return boolean
function ChallengeParam.IsMegaSatanRun()
end

---@return boolean
function ChallengeParam.IsMinShotspeedEnabled()
end

---@return boolean
function ChallengeParam.IsSecretPath()
end


---@class MultiShotParams
local MultiShotParams = {}

---Returns the angle the eyes are offset from each other. For example, The Wiz makes them `45` degrees.
---@return number
function MultiShotParams:GetMultiEyeAngle()
end

---Returns the number of eyes simultaniously shooting. For example, for The Wiz, it's `2`, for Mutant Spider, it's `1`.
---@return integer
function MultiShotParams:GetNumEyesActive()
end

---Returns the amount of lanes used to spread the shot tears onto. Lane positions are calculated by dividing the area,
---defined by the shooting direction +- the spreadAngle, by the number of lanes. This will create a pattern similar to
---a symetrical hand fan. Normally the number of lanes should be the same number as the amount of tears divided by
---the number of eyes.
---
---A smaller number of lanes than the amount of tears will cause tears to overlap each other. A higher lane count than
---tears will make the fan pattern asymetrical.
---@return integer
function MultiShotParams:GetNumLanesPerEye()
end

---Returns the amount of tears additionally shot in random directions. Same effect as "Eye Sore" collectible.
---@return integer
function MultiShotParams:GetNumRandomDirTears()
end

---Returns the number of tears the player can simultaneously fire.
---@return integer
function MultiShotParams:GetNumTears()
end

---Returns the spread angle for the given `WeaponType`.
---@param weaponType WeaponType
---@return number
function MultiShotParams:GetSpreadAngle(weaponType)
end

---Returns true if the cross eye effect is active (i.e: player shoots in two directions with 45 degrees offset to each other).
---@return boolean
function MultiShotParams:IsCrossEyed()
end

---Returns true if two additional shots will be triggered. This is similar to Mom's Eye.
---@return boolean
function MultiShotParams:IsShootingBackwards()
end

---Returns true if two additional shots will be triggered. This is similar to Loki's Horns.
---@return boolean
function MultiShotParams:IsShootingSideways()
end

---Sets if the cross eyes effect is active.
---@param active boolean
function MultiShotParams:SetIsCrossEyed(active)
end

---Sets if the player can have an additional tear be shot backwards. This is similar to Mom's Eye.
---@param active boolean
function MultiShotParams:SetIsShootingBackwards(active)
end

---Sets if the player can have an additional tear be shot sideways. This is similar to Loki's Horns.
---@param active boolean
function MultiShotParams:SetIsShootingSideways(active)
end

---When more than one eye is active, defines the angle the eyes are offset to eachother. For example, The Wiz makes them `45` degrees.
---@param angle number
function MultiShotParams:SetMultiEyeAngle(angle)
end

---Sets the number of eyes active. For example, for The Wiz, it's `2`, for Mutant Spider, it's `1`.
---@param value integer
function MultiShotParams:SetNumEyesActive(value)
end

---Sets the number of lanes per eye. See `GetNumLanesPerEye` for more information.
---@param amount integer
function MultiShotParams:SetNumLanesPerEye(amount)
end

---Sets the amount of tears additionally shot in random directions. Same effect as "Eye Sore" collectible.
---@param value integer
function MultiShotParams:SetNumRandomDirTears(value)
end

---Sets the number of tears the player can fire simultaneously.
---@param amount integer
function MultiShotParams:SetNumTears(amount)
end

---Sets the spread angle for the given `WeaponType`.
---@param weaponType WeaponType
---@param angle number
function MultiShotParams:SetSpreadAngle(weaponType, angle)
end


---@class LRoomTileDesc
local LRoomTileDesc = {}

---Returns the grid coordinates of the high half's top left corner.
---@return {[1]: integer, [2]: integer}
function LRoomTileDesc:GetHighTopLeft()
end

---Returns the grid coordinates of the low half's top left corner.
---@return {[1]: integer, [2]: integer}
function LRoomTileDesc:GetLowTopLeft()
end

---Returns the grid coordinates of the high half's bottom right corner.
---@return {[1]: integer, [2]: integer}
function LRoomTileDesc:GetHighBottomRight()
end

---Returns the grid coordinates of the low half's bottom right corner.
---@return {[1]: integer, [2]: integer}
function LRoomTileDesc:GetLowBottomRight()
end

---Returns the grid coordinates of a random tile in this L
---@param seed integer
---@return {[1]: integer, [2]: integer}
function LRoomTileDesc:GetRandomTile(seed)
end

---@class PersistentGameData
local PersistentGameData = {}

---Returns the amount of deaths from an entity that's recorded in the Bestiary.
---@param entityType EntityType
---@param entityVariant integer
---@return integer
function PersistentGameData:GetBestiaryDeathCount(entityType, entityVariant)
end

---Returns the amount of times an entity has been countered that's recorded in the Bestiary.
---@param entityType EntityType
---@param entityVariant integer
---@return integer
function PersistentGameData:GetBestiaryEncounterCount(entityType, entityVariant)
end

---Returns the amount of times an entity has been killed that's recorded in the Bestiary.
---@param entityType EntityType
---@param entityVariant integer
---@return integer
function PersistentGameData:GetBestiaryKillCount(entityType, entityVariant)
end

---Returns an event counter.
---@param eventCounter EventCounter
---@return integer
function PersistentGameData:GetEventCounter(eventCounter)
end

---Increases the counter towards the provided `EventCounter` by `incrementAmount`. Also accepts negative values to decrease.
---@param eventCounter EventCounter
---@param incrementAmount integer
function PersistentGameData:IncreaseEventCounter(eventCounter, incrementAmount)
end

---Returns true if the provided challenge has been completed.
---
---This function is the same as `Isaac.IsChallengeDone` and is recommended you use that version instead, as it's categorized with the other challenge-related functions.
---@param challengeId Challenge
---@return boolean
function PersistentGameData:IsChallengeCompleted(challengeId)
end

---Returns true if the collectible is in the collection (at least picked up once in any run)
---@param collectible CollectibleType
---@return boolean
function PersistentGameData:IsItemInCollection(collectible)
end

---Tries to unlock an achievement.
---@param achievement Achievement
---@param blockPaperPopup? boolean @default: `false`. Prevents popping up the achievement paper for modded achievements.
---@return boolean successful Returns `true` if the achievement was successfully unlocked, `false` if it has already been unlocked or the unlock failed.
function PersistentGameData:TryUnlock(achievement, blockPaperPopup)
end

---Returns true if the provided achievement is unlocked.
---@param achievement Achievement
---@return boolean
function PersistentGameData:Unlocked(achievement)
end

---@param entType EntityType
---@param variant? integer @default: `0`
function PersistentGameData:AddBestiaryKill(entType, variant)
end

---@param bossType BossType
function PersistentGameData:AddBossKilled(bossType)
end

---@param bossType BossType
---@return boolean
function PersistentGameData:IsBossKilled(bossType)
end

---@class WeightedOutcomePicker
local WeightedOutcomePicker = {}

---@return WeightedOutcomePicker
function _G.WeightedOutcomePicker()
end

---Adds an outcome to the outcome selector with the specified `weight`. The internal weight is still an integer calculated like this: `fWeight * scaleFactor`, where `scaleFactor` is the maximum weight (equivalent to `1.0`).
---
--**Example Code**
---local picker = WeightedOutcomePicker()
---
---picker:AddOutcomeFloat(1, 1.0) -- ~45%
---picker:AddOutcomeFloat(2, 1.0) -- ~45%
---picker:AddOutcomeFloat(3, 0.2) -- ~9%
---@param value integer
---@param weight number
---@param scaleFactor? integer @default: `100`
function WeightedOutcomePicker:AddOutcomeFloat(value, weight, scaleFactor)
end

---Adds an outcome to the outcome selector with the specified `weight`.
---
---**Example Code**
---```lua
---local picker = WeightedOutcomePicker()
---
---picker:AddOutcomeWeight(1, 65) -- 65%
---picker:AddOutcomeWeight(2, 30) -- 30%
---picker:AddOutcomeWeight(3, 5) -- 5%
---```
---@param value integer
---@param weight integer
function WeightedOutcomePicker:AddOutcomeWeight(value, weight)
end

---Clears all outcomes from the outcome picker.
function WeightedOutcomePicker:ClearOutcomes()
end

---Returns the number of outcomes in the outcome picker.
---@return integer
function WeightedOutcomePicker:GetNumOutcomes()
end

---@class WeightedOutcomePickerTable
---@field Value integer
---@field Weight number

---Returns a table containing a list of all outcomes in the outcome picker.
---@return WeightedOutcomePickerTable[]
function WeightedOutcomePicker:GetOutcomes()
end

---Returns a random outcome from the list in WeightedOutcomePicker.
---@param rng RNG
---@return integer
function WeightedOutcomePicker:PickOutcome(rng)
end

---Removes an outcome from the outcome picker with the given `value`.
---@param value integer
function WeightedOutcomePicker:RemoveOutcome(value)
end


---@class XMLData
_G.XMLData = {}

---@param type EntityType
---@param variant? integer @default: `0`
---@param subType? integer @default: `0`
---Returns a table containing the attributes of the bosscolor on bosscolors.xml that match the given type variant and subtype.
---
---**Example Code**
---```lua
---	print("Red Monstro's suffix:", XMLData.GetBossColorByTypeVarSub(20,0,1).suffix)
---	```
function XMLData.GetBossColorByTypeVarSub(type, variant, subType)
end

---Returns a table containing the attributes of the entity in `entities2.xml`.
---
---Child nodes are returned as tables alongside the rest of the attributes. For example,
---if you want to access the samples of a sound entry, you can just do soundentry.sample[1].
---@param type EntityType
---@param variant? integer @default: `0`
---@param subType? integer @default: `0`
---@param strict? boolean @default: `false`. If `true`, the function will only return a value if the entity node in entities2.xml matches the type, variant, and subType, rather than partial matches.
---@return table<string, unknown>
function XMLData.GetEntityByTypeVarSub(type, variant, subType, strict)
end

---Returns a table containing the attributes of the corresponding xml, the matching nodetype
---
---(Ex: `XMLNode.TRINKET` returns trinket nodes from pocketitems.xml) and match the given name parameter.
---@param nodeType XMLNode
---@param index integer
---@return table<string, unknown>
function XMLData.GetEntryById(nodeType, index)
end

---Returns a table containing the attributes of the corresponding xml, the matching NodeType
---
---(Ex: XMLNode.TRINKET returns trinket nodes from pocketitems.xml) and match the given name parameter.
---@param nodeType XMLNode
---@param name string
---@return table<string, unknown>
function XMLData.GetEntryByName(nodeType, name)
end

---@param entity Entity
---@param autoXMLPick? boolean @default: `true`. If set to `true`, picks the xml that matches the `EntityType`. If `false`, picks the entry from entities2.xml.
---@param strict boolean If set to `true`, only returns a value when the type, variant and subtype attributes match. If `false`, only matches an entry with the type.
function XMLData.GetEntryFromEntity(entity, autoXMLPick, strict)
end

---Returns the number of entries a given xmlnode structure has.
---@param nodeType XMLNode
---@return integer
function XMLData.GetNumEntries(nodeType)
end

---Returns a table containing the attributes of the metdata xml of the matching mod id.
---
---**Example Code**
---```lua
---print("Car's mod name:", XMLData.GetModById("2788006730").name)
---```
---@param id integer | string
---@return table<string, unknown>
function XMLData.GetModById(id)
end

---Similar to GetByName or GetById, but it returns the node based on the order in which it appears on the xmls (1 will return the first node, 2 the second one and so on). Useful to iterate through xmls in combination with GetNumEntries, specially for redundant xmls like entities.xml.
---@param nodeType XMLNode
---@param order integer
function XMLData.GetEntryByOrder(nodeType, order)
end

---@class BossPoolEntry
---@field bossID BossType | integer
---@field weight number
---@field weightAlt float
---@field achievementID Achievement | integer

---@class BossPool
local BossPool = {}

---Return the start of the double trouble room set.
---Any boss room that has a variant in the [doubleTroubleRoomID, doubleTroubleRoomID + 50) range is considered a double trouble room for the stage.
---@return integer
function BossPool:GetDoubleTroubleRoomID()
end

---@return BossPoolEntry[]
function BossPool:GetEntries()
end

---@return string
function BossPool:GetName()
end

---@return RNG
function BossPool:GetRNG()
end

---@return number
function BossPool:GetWeight()
end

---@class AnimationLayer
local AnimationLayer = {}

---Returns the frame data from the provided frame number.
---@param frame integer
---@return AnimationFrame?
function AnimationLayer:GetFrame(frame) end

---@return integer
function AnimationLayer:GetLayerID() end

---@return boolean
function AnimationLayer:IsVisible() end


---@class RailManager
local RailManager = {}

---@return Sprite
function RailManager:GetRailsSprite()
end

---@class ColorModifier
---@field A number
---@field B number
---@field Brightness number 
---@field Contrast number
---@field G number
---@field R number
local ColorModifier = {}

---@param r? number @default: `1`
---@param g? number @default: `1`
---@param b? number @default: `1`
---@param a? number @default: `0`
---@param brightness? number @default: `0`
---@param contrast? number @default: `1`
---@return ColorModifier
function _G.ColorModifier(r, g, b, a, brightness, contrast)
end

---@param Right ColorModifier
---@return ColorModifier
function ColorModifier:__add(Right)
end

---@param Right ColorModifier
---@return ColorModifier
function ColorModifier:__div(Right)
end

---@param Right ColorModifier
---@return ColorModifier
function ColorModifier:__eq(Right)
end

---@param Right ColorModifier
---@return ColorModifier
function ColorModifier:__mul(Right)
end

---@param Right ColorModifier
---@return ColorModifier
function ColorModifier:__sub(Right)
end

---@class LootListEntry
local LootListEntry = {}

---@return EntityType
function LootListEntry:GetType()
end

---@return integer
function LootListEntry:GetVariant()
end

---@return integer
function LootListEntry:GetSubType()
end

---@return integer
function LootListEntry:GetSeed()
end

---May return `nil`.
---@return RNG?
function LootListEntry:GetRNG()
end

---@class ProceduralItemManager
_G.ProceduralItemManager = {}

---Creates a glitched item based on a given seed.
---@param seed integer
---@param unknown integer TODO: Document me
---@return integer itemId The id of the item
function ProceduralItemManager.CreateProceduralItem(seed, unknown)
end

---Returns the glitched item at the given index.
---@param index integer
---@return ProceduralItem
function ProceduralItemManager.GetProceduralItem(index)
end

---Returns the total amount of procedural items.
---@return integer
function ProceduralItemManager.GetProceduralItemCount()
end


---@class ProceduralItem
local ProceduralItem = {}

---@return number
function ProceduralItem:GetDamage()
end

---Returns the procedural item's effect by an index.
---@param index integer The effect's index.
---@return ProceduralEffect?
function ProceduralItem:GetEffect(index)
end

---Returns the amount of effects the procedural item has.
---@return integer
function ProceduralItem:GetEffectCount()
end

---@return number
function ProceduralItem:GetFireDelay()
end

---@return integer
function ProceduralItem:GetID()
end

---Retuns the item config of the current glitched item.
---@return ItemConfigItem
function ProceduralItem:GetItem()
end

---@return number
function ProceduralItem:GetLuck()
end

---@return number
function ProceduralItem:GetRange()
end

---@return number
function ProceduralItem:GetShotSpeed()
end

---@return number
function ProceduralItem:GetSpeed()
end

---Returns the item config that is randomly selected by the current glitched item.
---@return ItemConfigItem? `nil` if the selected `ItemConfigItem` does not exist
function ProceduralItem:GetTargetItem()
end


---@class ProceduralEffect
local ProceduralEffect = {}

---Returns a table that describes the action argument.
---
---If `GetActionType` returns `ProceduralEffectActionType.USE_ACTIVE_ITEM`, the returned
---table has the following fields:
---
--- - id: integer
---
---If `GetActionType` returns `ProceduralEffectActionType.ADD_TEMPRORY_EFFECT`, the returned
---table has the following fields:
---
--- - id: integer
---
---If `GetActionType` returns `ProceduralEffectActionType.SPAWN_ENTITY`, the returned
---table has the following fields:
---
--- - type: integer
--- - variant: integer
---
---If `GetActionType` returns `ProceduralEffectActionType.CONVERT_ENTITY`, the returned
---table has the following fields:
---
--- - fromType: integer
--- - fromvariant: integer
--- - toType: integer
--- - tovariant: integer
---
---If `GetActionType` returns `ProceduralEffectActionType.AREA_DAMAGE`, the returned
---table has the following fields:
---
--- - radius: number
--- - damage: number
---
---If `GetActionType` returns `ProceduralEffectActionType.FART`, the returned
---table has the following fields:
---
--- - fromType: number
--- - radius: number
---@return table
function ProceduralEffect:GetProceduralEffect()
end

---Returns the action type.
---@return ProceduralEffectActionType
function ProceduralEffect:GetActionType()
end

---Returns a table that describes the condition argument.
---
---When `ProceduralEffect:GetConditionType` returns `ProceduralEffectConditionType.ENTITY_SPAWN`, the returned
---table has the following fields:
---
--- - type: integer
--- - variant: integer
---
---@return table
function ProceduralEffect:GetConditionProperty()
end

---Returns the condition type.
---@return ProceduralEffectConditionType
function ProceduralEffect:GetConditionType()
end

---Returns the trigger chance. The returned value is between 0 and 1.
---@return number
function ProceduralEffect:GetTriggerChance()
end


---@class EntityConfigPlayer
local EntityConfigPlayer = {}

---Returns true if the character can shoot.
---@return boolean
function EntityConfigPlayer:CanShoot()
end

---Returns the achivement tied to the character.
---
---If the character is not locked behind a vanilla achievement, -1 is returned. Alternatively, if the character is a vanilla Tainted Character, -2 is returned instead.
---@return Achievement
function EntityConfigPlayer:GetAchievementID()
end

---Returns the character's Birthright description.
---@return string
function EntityConfigPlayer:GetBirthrightDescription()
end

---Returns the amount of black hearts (in halves) the character starts with. For example, if they start with half a black heart, 1 is returned. If they start with a full black heart, 2 is returned. And so on.
---@return integer
function EntityConfigPlayer:GetBlackHearts()
end

---Returns the amount of bombs the character starts with.
---@return integer
function EntityConfigPlayer:GetBombs()
end

---Returns the amount of brocken hearts the character starts with.
---@return integer
function EntityConfigPlayer:GetBrokenHearts()
end

---Returns the card the character starts with. If the character does not start with a card, `Card.CARD_NULL` is returned.
---
---This does not include starting cards obtained via unlocks or cards added by mods.
---@return Card
function EntityConfigPlayer:GetCard()
end

---Returns the amount of coins the character starts with.
---@return integer
function EntityConfigPlayer:GetCoins()
end

---Returns a table of the collectibles the character starts with.
---@return CollectibleType[]
function EntityConfigPlayer:GetCollectibles()
end

---Returns the id of the character's XML defined starting costume. Returns -1 if there is no costume.
---@return integer
function EntityConfigPlayer:GetCostumeID()
end

---Returns the character's costume directory suffix.
---@return string
function EntityConfigPlayer:GetCostumeSuffix()
end

---Returns the character's starting keys.
---@return integer
function EntityConfigPlayer:GetKeys()
end

---Returns the sprite used for the a modded character's starting room controls.
---@return Sprite? `nil` if the character is a vanilla character or if it has no corresponding animation.
function EntityConfigPlayer:GetModdedControlsSprite()
end

---Returns the sprite used for a modded character's icon in the co-op character select wheel.
---
---Note that this sprite is shared by other characters from the same mod - there is an animation with the same name as this character.
---@return Sprite? `nil` for vanilla characters, or characters with no corresponding animation.
function EntityConfigPlayer:GetModdedCoopMenuSprite()
end

---Returns the sprite for a modded character's game over screen (ie, their name).
---
---Note that this sprite is shared by other characters from the same mod - there is an animation with the same name as this character.
---@return Sprite? `nil` for vanilla characters, or characters with no corresponding animation.
function EntityConfigPlayer:GetModdedMenuPortraitSprite()
end

---Returns the character's name.
---@return string
function EntityConfigPlayer:GetName()
end

---Returns the path to the .png file used for the character's name on the boss VS screen.
---@return string
function EntityConfigPlayer:GetNameImagePath()
end

---Returns the pillcolor tied to the character's starting pill. Does not include starting pills obtained via unlocks.
---@return PillColor
function EntityConfigPlayer:GetPill()
end

---Returns the character's PlayerType
---@return PlayerType
function EntityConfigPlayer:GetPlayerType()
end

---Returns the character's starting pocket active. Does not include items added by mods for vanilla characters.
---@return CollectibleType
function EntityConfigPlayer:GetPocketActive()
end

---Returns the path to the .png file used for the character's main level transition and boss VS screen portrait.
---@return string
function EntityConfigPlayer:GetPortraitPath()
end

---Returns the amount of red hearts (in halves) the character starts with. For example, if they start with half a red heart, 1 is returned. If they start with a whole red heart, 2 is returned, and so on.
---@return integer
function EntityConfigPlayer:GetRedHearts()
end

---Returns the character's skin color.
---@return SkinColor
function EntityConfigPlayer:GetSkinColor()
end

---Returns a path to the .png file used for the character's primary spritesheet.
---@return string
function EntityConfigPlayer:GetSkinPath()
end

---Returns the amount of soul hearts (in halves) the character starts with. For example, if they start with half a soul heart, 1 is returned. If they start with a whole soul heart, 2 is returned, and so on.
---@return integer
function EntityConfigPlayer:GetSoulHearts()
end

---Returns the character's tainted counterpart.
---
---If the character is a tainted character, their non-tainted counterpart is returned instead.
---@return EntityConfigPlayer? `nil` if the character does not have a tainted counterpart.
function EntityConfigPlayer:GetTaintedCounterpart()
end

---Returns the character's starting trinket. Does not include starting trinkets obtained via unlocks or trinkets added by mods to vanilla characters.
---@return TrinketType
function EntityConfigPlayer:GetTrinket()
end

---Returns true if the character can never appear on the character select screen. This does not include characters who are only hidden until unlocked.
---@return boolean
function EntityConfigPlayer:IsHidden()
end

---Returns true if the character is tainted.
---@return boolean
function EntityConfigPlayer:IsTainted()
end


---@class EntityConfig
_G.EntityConfig = {}

---Returns the config of the provided entity.
---@param type EntityType
---@param variant? integer @default: `-1`
---@param subType? integer @default: `-1`
---@return EntityConfigEntity?
function EntityConfig.GetEntity(type, variant, subType)
end

---Returns the highest PlayerType currently assigned to a valid character.
---@return PlayerType
function EntityConfig.GetMaxPlayerType()
end

---Returns the config associated with the character of the specified PlayerType.
---@param playerType PlayerType
---@return EntityConfigPlayer?
function EntityConfig.GetPlayer(playerType)
end

---Returns nil if there is no co-op baby with the given ID.
---@param type BabySubType
---@return EntityConfigBaby?
function EntityConfig.GetBaby(type)
end

---Returns the highest ID (corresponds to SubType) currently assigned to a valid co-op baby.
---@return integer
function EntityConfig.GetMaxBabyID()
end

---@class EntityConfigBaby
local EntityConfigBaby = {}

---@return Achievement
function EntityConfigBaby:GetAchievementID ( )
end

---@return BabySubType
function EntityConfigBaby:GetID ( )
end

---@return string
function EntityConfigBaby:GetName ( )
end

---@return string
function EntityConfigBaby:GetSpritesheetPath ( )
end


---@class EntityConfigEntity
local EntityConfigEntity = {}

---Returns true if the entity can be a champion.
---@return boolean
function EntityConfigEntity:CanBeChampion()
end

---Returns true if the entity can be rerolled.
---@return boolean
function EntityConfigEntity:CanBeRerolledInto()
end

---Returns true if the entity can shut doors while active.
---@return boolean
function EntityConfigEntity:CanShutDoors()
end

---Returns the path of the entity's .anm2 file.
---@return string
function EntityConfigEntity:GetAnm2Path()
end

---Returns the entity's base hp.
---@return number
function EntityConfigEntity:GetBaseHP()
end

---Returns the name of the entity's bestiary entry animation.
---@return string
function EntityConfigEntity:GetBestiaryAnimation()
end

---Returns the path of the entity's .anm2 file used for the bestiary.
---@return string
function EntityConfigEntity:GetBestiaryAnm2Path()
end

---TODO: Document me!
---@return string
function EntityConfigEntity:GetBestiaryFloorAlt()
end

---Returns a readonly vector of the entity's bestiary sprite offset.
---@return Vector
function EntityConfigEntity:GetBestiaryOffset()
end

---Returns the name of the entity's bestiary overlay animation.
---@return string
function EntityConfigEntity:GetBestiaryOverlay()
end

---Returns the entity's scale in the bestiary.
---@return number
function EntityConfigEntity:GetBestiaryScale()
end

---Returns the entity's BossID.
---@return BossType
function EntityConfigEntity:GetBossID()
end

---Returns the entity's collision damage.
---@return number
function EntityConfigEntity:GetCollisionDamage()
end

---Returns the entity's collision interval.
---@return integer
function EntityConfigEntity:GetCollisionInterval()
end

---Returns the entity's collision radius.
---@return number
function EntityConfigEntity:GetCollisionRadius()
end

---Returns a readonly vector of the entity's collision radius multiplier.
---@return Vector
function EntityConfigEntity:GetCollisionRadiusMultiplier()
end

---Returns the bitmask of the entity's EntityTags.
---@return integer
function EntityConfigEntity:GetEntityTags()
end

---Returns the entity's friction.
---@return number
function EntityConfigEntity:GetFriction()
end

---Returns the bitmask of the entity's GibFlags
---@return integer
function EntityConfigEntity:GetGibFlags()
end

---Returns the amount of gibs the entity spawns upon death.
---@return NullItemID
function EntityConfigEntity:GetGibsAmount()
end

---Returns the entity's grid collision points.
---@return integer
function EntityConfigEntity:GetGridCollisionPoints()
end

---Returns the entity's mass.
---@return number
function EntityConfigEntity:GetMass()
end

---Returns the name of the mod the entity is from. If the entity is not from a mod, `nil` is returned instead.
---@return string? 
function EntityConfigEntity:GetModName()
end

---Returns the entity's name.
---@return string
function EntityConfigEntity:GetName()
end

---Returns the entity's portrait id.
---@return integer
function EntityConfigEntity:GetPortraitID()
end

---Returns the entity's shadow size. Note that this is the value of the `shadowSize` attribute in `entities2.xml` divided by 100.
---@return number
function EntityConfigEntity:GetShadowSize()
end

---Returns the entity's shield strength.
---@return number
function EntityConfigEntity:GetShieldStrength()
end

---Returns the entity's stage hp.
---@return number
function EntityConfigEntity:GetStageHP()
end

---Returns the entity's subtype.
function EntityConfigEntity:GetSubType()
end

---Returns the entity's type.
---@return integer
function EntityConfigEntity:GetType()
end

---Returns the entity's variant.
---@return integer
function EntityConfigEntity:GetVariant()
end

---Returns true if the entity has the all of the EntityTags in the provided bitset.
---@param tags integer
---@return boolean
function EntityConfigEntity:HasEntityTags(tags)
end

---Returns true if the entity has all of the GibFlags in the provided bitset.
---@param flags integer
---@return boolean
function EntityConfigEntity:HasGibFlags(flags)
end

---Returns true if the entity is a boss.
---@return boolean
function EntityConfigEntity:IsBoss()
end


---@class LevelGeneratorRoom
local LevelGeneratorRoom = {}

---TODO: Document me!
---@return integer
function LevelGeneratorRoom:Column()
end

---Return a mask of the available doors of the room slot. In order to check if a door at a given slot is available, use the DoorSlot enumeration.
---@return integer
function LevelGeneratorRoom:DoorMask()
end

---Index of the room during generation.
---@return integer `0` if the room was the first to be generated, `1` if it was the second, etc.
function LevelGeneratorRoom:GenerationIndex()
end

---@return boolean
function LevelGeneratorRoom:IsDeadEnd() end

---Returns a table of the generation indices of the neighboring rooms.
---@return integer[]
function LevelGeneratorRoom:Neighbors()
end

---Return the row of the room slot on the level grid.
---@return integer `0` for the first row, `1` for the second, etc.
function LevelGeneratorRoom:Row()
end

---Return the shape of the room, as per the `RoomShape` enumeration.
---@return RoomShape
function LevelGeneratorRoom:Shape()
end


---@class LevelGeneratorEntry
local LevelGeneratorEntry = {}

---TODO: Document me!
---@param doors integer 
function LevelGeneratorEntry:SetAllowedDoors(doors)
end

---TODO: Document me!
---@param colIdx integer 
function LevelGeneratorEntry:SetColIdx(colIdx)
end

---TODO: Document me!
---@param lineIndex integer
function LevelGeneratorEntry:SetLineIdx(lineIndex)
end


---@class LevelGenerator
local LevelGenerator = {}

---Returns a table of all of the `LevelGeneratorRoom` objects.
---@return LevelGeneratorRoom[]
function LevelGenerator:GetAllRooms()
end

---Returns a table of all of the `LevelGeneratorRoom` objects that are deadends.
---@return LevelGeneratorRoom[]
function LevelGenerator:GetDeadEnds()
end

---Returns a table of all of the `LevelGeneratorRoom` objects that are not deadends.
---@return LevelGeneratorRoom[]
function LevelGenerator:GetNonDeadEnds()
end

---Places a LevelGeneratorRoom object onto the level-grid.
---@param column integer The column. It must be between `0` and `12`.
---@param row integer The row. It must be between `0` and `12`.
---@param shape RoomShape The shape of the room.
---@param room LevelGeneratorRoom The level generator room.
---@return integer?  generationIndex If the room was placed, the generation index is returned. Otherwise it is `nil`.
function LevelGenerator:PlaceRoom(column, row, shape, room)
end


---@class GLSLValue
local GLSLValue = {}

---meta function to access data in a given table key.
function GLSLValue:__index()
end

---meta function to write data in a given table key.
---@param value number
function GLSLValue:__newindex(value)
end

---@class Capsule
local Capsule = {}

---Causes the capsule to run collision code with `capsule2`
---@param capsule2 Capsule 
---@param vec Vector 
---@return boolean 
function Capsule:Collide(capsule2, vec)
end

---TODO: Document me!
---@return Vector 
function Capsule:GetDirection()
end

---TODO: Document me!
---@return number 
function Capsule:GetF1()
end

---TODO: Document me!
---@return number 
function Capsule:GetF2()
end

---TODO: Returns the capsule's position.
---@return Vector 
function Capsule:GetPosition()
end

---TODO: Document me!
---@return Vector 
function Capsule:GetV2()
end

---TODO: Document me!
---@return Vector 
function Capsule:GetV3()
end

---@param position Vector
---@param sizeMultiplier Vector
---@param rotation number
---@param size number
---@return Capsule
function _G.Capsule(position, sizeMultiplier, rotation, size)
end

---@param position Vector
---@param targetPosition Vector
---@param size number 
---@return Capsule
function _G.Capsule(position, targetPosition, size)
end



---@class Shader 
local Shader = {}

---TODO: Document me!
---@param name string 
---@param value GLSLValue
function Shader:BindFloat(name, value)
end

---TODO: Document me!
---@param name string 
---@param value GLSLValue
function Shader:BindVec2(name, value)
end

---TODO: Document me!
---@param name string 
---@param value GLSLValue
function Shader:BindVec4(name, value)
end

---TODO: Document me!
---@param name string 
---@param value GLSLValue
function Shader:BindVec3(name, value)
end

---TODO: Document me!
---@param name string 
---@param value GLSLValue
function Shader:BindMat2(name, value)
end

---TODO: Document me!
---@param name string 
---@param value GLSLValue
function Shader:BindMat3(name, value)
end

---TODO: Document me!
---@param name string 
---@param value GLSLValue
function Shader:BindMat4(name, value)
end

---@class Shape
local Shape = {}

---TODO: Document me!
---@return integer
function Shape:GetTimeout()
end

---TODO: Document me!
---@param timeout integer
function Shape:SetTimeout(timeout)
end

---Assigns a capsule to the shape.
---@param capsule Capsule
function Shape:Capsule(capsule)
end


---@class RenderSet
local RenderSet = {}

---TODO: Document me!
---@param vertexBuffer VertexBuffer
---@param shader Shader
---@param nElements integer
---@param first integer
---@param second? integer default: `-1`
function RenderSet:SliceSingle(vertexBuffer, shader, nElements, first, second)
end

---TODO: Document me!
---@param filePath string
function RenderSet:SlicePipeline(filePath)
end


---@class Renderer
local Renderer = {}

---TODO: Document me!
---@param filePath string The path to the image.
---@return Image
function Renderer:LoadImage(filePath)
end

---TODO: Document me!
---@return Pipeline
function Renderer:Pipeline()
end

---TODO: Document me!
---@return GLSLValue
function Renderer:ProjectionMatrix()
end

---TODO: Document me!
function Renderer:RenderSet()
end

---TODO: Document me!
---@param vertexShader string
---@param fragmentShader string
---@param vertexDescriptor VertexDescriptor
---@return Shader
function Renderer:Shader(vertexShader, fragmentShader, vertexDescriptor)
end

---TODO: Document me!
---@return Transformer
function Renderer:StartTransformation()
end

---TODO: Document me!
---@param x? number @default: `0`
---@param y? number @default: `0`
---@return GLSLValue
function Renderer:Vec2(x, y)
end

---TODO: Document me!
---@param x? number @default: `0`
---@param y? number @default: `0`
---@param z? number @default: `0`
---@return GLSLValue
function Renderer:Vec3(x, y, z)
end

---TODO: Document me!
---@param x? number @default: `0`
---@param y? number @default: `0`
---@param z? number @default: `0`
---@param w? number @default: `0`
---@return GLSLValue
function Renderer:Vec4(x, y, z, w)
end

---TODO: Document me!
---@return VertexDescriptor
function Renderer:VertexDescriptor()
end


---@class Transformer
local Transformer = {}

---TODO: Document me!
function Transformer:Apply()
end

---TODO: Document me!
---@return boolean
function Transformer:IsValid()
end

---TODO: Document me!
---@param image Image
---@param source SourceQuad
---@param dest DestinationQuad
---@param modifier Color
function Transformer:Render(image, source, dest, modifier)
end

---TODO: Document me!
---@param image Image
---@param source SourceQuad
---@param dest DestinationQuad
---@param modifier1 Color
---@param modifier2 Color
---@param modifier3 Color
---@param modifier4 Color
function Transformer:RenderEx(image, source, dest, modifier1, modifier2, modifier3, modifier4)
end


---@class BlendMode
---@field AlphaDestinationFactor BlendFactor 
---@field AlphaSourceFactor BlendFactor 
---@field RGBDestinationFactor BlendFactor 
---@field RGBSourceFactor BlendFactor 
local BlendMode = {}

---@param type BlendType
function BlendMode:SetMode(type)
end

---@class Pipeline
local Pipeline = {}

---TODO: Document me!
---@param nbVertices integer
---@param shader Shader
---@param nbElements integer
---@return VertexBuffer
function Pipeline:NewPass(nbVertices, shader, nbElements)
end


---@class VertexDescriptor
local VertexDescriptor = {}

---TODO: Document me!
---@param type GLSLValue 
---@param name string
function VertexDescriptor:AddAttribute(type, name)
end


---@class VertexBuffer
local VertexBuffer = {}

---TODO: Document me
---@return Vertex[]
function VertexBuffer:GetElements()
end

---TODO: Document me!
---@param vertexId integer
---@return Vertex?
function VertexBuffer:GetVertex(vertexId)
end


---@class DestinationQuad
local DestinationQuad = {}

---Constructs a new destination quad object.
---@param topLeft Vector
---@param topRight Vector
---@param bottomLeft Vector
---@param bottomRight Vector
---@return DestinationQuad
function _G.DestinationQuad(topLeft, topRight, bottomLeft, bottomRight)
end

---@return Vector
function DestinationQuad:GetBottomLeft()
end

---@return Vector
function DestinationQuad:GetBottomRight()
end

---@return Vector
function DestinationQuad:GetTopLeft()
end

---@return Vector
function DestinationQuad:GetTopRight()
end

---@param vector Vector
function DestinationQuad:SetBottomLeft(vector)
end

---@param vector Vector
function DestinationQuad:SetBottomRight(vector)
end

---@param vector Vector
function DestinationQuad:SetTopLeft(vector)
end

---@param vector Vector
function DestinationQuad:SetTopRight(vector)
end


---@class Vertex
local Vertex = {}

---TODO: Document me
---@return table 
function Vertex:Dump()
end

---@class Beam
local Beam = {}

---Constructs a new beam object.
---
---**Example**
---
---```lua
---
---local sprite = Sprite()
---sprite:Load("gfx/893.000_ball and chain.anm2", true)
---chain = Beam(sprite, "chain", true, false)---
---
---mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, function(_, player)
---    chain:GetSprite():PlayOverlay("Chain", false)
---    local center = game:GetLevel():GetCurrentRoom():GetCenterPos()
---    chain:Add(Isaac.WorldToScreen(center))
---    chain:Add(Isaac.WorldToScreen(player.Position))
---    chain:Render()
---end)
---```
---@param sprite Sprite
---@param layerId integer
---@param useOverlay boolean
---@param unknownBool boolean TODO: Document me!
---@return Beam
---@overload fun(sprite: Sprite, layerName: string, useOverlay: boolean, unknownBool: boolean)
function _G.Beam(sprite, layerId, useOverlay, unknownBool)
end

---Adds a point to the beam.
---@param position Vector
---@param spritesheetCoordinate number The Y position of the spritesheet that should be drawn by the time this Point is reached. For example, two points of `0` and `64` SpritesheetCoordinate will render the spritesheet starting from `y 0` to `y 64`, while an additional third point of `0` will draw it in reverse from `y 64` to `y 0`. `width` acts as 
---@param width? number @default: `1.0`. A multiplier for how wide the beam should be. A non-zero value will scale the spritesheet width accordingly. This is interpolated between points.
---@overload fun(self: Beam, point: Point)
function Beam:Add(position, spritesheetCoordinate, width)
end

---@return integer
function Beam:GetLayer()
end

---Returns a table of the `Point` objects currently stored.
---@return Point[]
function Beam:GetPoints()
end

---@return Sprite
function Beam:GetSprite()
end

---TODO: Document me!
---@return boolean
function Beam:GetUnkBool()
end

---Returns if the beam is currently using the overlay sprite or not.
---@return boolean
function Beam:GetUseOverlay()
end

---Renders the beam.
---@param clearPoints? boolean @default: `true`
function Beam:Render(clearPoints)
end

---Sets the beam's layer.
---@param layerId integer
---@overload fun(self: Beam, layerName: string)
function Beam:SetLayer(layerId)
end

---Sets the beam's sprite.
---@param sprite Sprite
---@overload fun(self: Beam, sprite: Sprite, layerName: string, useOverlay: boolean)
---@overload fun(self: Beam, sprite: Sprite, layerId: integer, useOverlay: boolean)
function Beam:SetSprite(sprite)
end

---TODO: Document me!
---@param unknownBool boolean
function Beam:SetUnkBool(unknownBool)
end

---TODO: Document me!
---@param useOverlay boolean
function Beam:SetUseOverlay(useOverlay)
end


---@class Image

---@class Point
local Point = {}

---@param position Vector
---@param spritesheetCoordinate number The Y position of the spritesheet that should be drawn by the time this Point is reached. For example, two points of `0` and `64` SpritesheetCoordinate will render the spritesheet starting from `y 0` to `y 64`, while an additional third point of `0` will draw it in reverse from `y 64` to `y 0`. `width` acts as 
---@param width? number @default: `1.0`. A multiplier for how wide the beam should be. A non-zero value will scale the spritesheet width accordingly. This is interpolated between points.
---@param color? Color @default: `Color.Default`
---@param isWorldSpace? boolean @default: `false`
---@return Point
function _G.Point(position, spritesheetCoordinate, width, color, isWorldSpace)
end

---@return number
function Point:GetSpritesheetCoordinate()
end

---@return number
function Point:GetWidth()
end

---@return Vector
function Point:GetPosition()
end

---@param height number
function Point:SetSpritesheetCoordinate(height)
end

---@param width number
function Point:SetWidth(width)
end

---@param position Vector
function Point:SetPosition(position)
end

---@return Color
function Point:GetColor()
end

---@param color Color
function Point:SetColor(color)
end

---If false, Point is using screenspace when rendering. Otherwise, it's using worldspace.
---@return boolean
function Point:GetIsWorldSpace()
end

---If false, automatically converts this Point's position from worldspace to screenspace when rendering.
---@param isWorldSpace boolean
function Point:SetIsWorldSpace(isWorldSpace)
end

---@class SourceQuad
local SourceQuad = {}

---Constructs a new destination quad object.
---@param topLeft Vector
---@param topRight Vector
---@param bottomLeft Vector
---@param bottomRight Vector
function _G.SourceQuad(topLeft, topRight, bottomLeft, bottomRight)
end

---@return Vector
function SourceQuad:GetBottomLeft()
end

---@return Vector
function SourceQuad:GetBottomRight()
end

---@return Vector
function SourceQuad:GetTopLeft()
end

---@return Vector
function SourceQuad:GetTopRight()
end

---@param vector Vector
function SourceQuad:SetBottomLeft(vector)
end

---@param vector Vector
function SourceQuad:SetBottomRight(vector)
end

---@param vector Vector
function SourceQuad:SetTopLeft(vector)
end

---@param vector Vector
function SourceQuad:SetTopRight(vector)
end


---@class HistoryItem
local HistoryItem = {}

---Returns the CollectibleType tied to the history item.
---@return CollectibleType
function HistoryItem:GetItemID()
end

---Returns the ItemPool tied to the history item.
---@return ItemPool
function HistoryItem:GetItemPoolType()
end

---Returns the LevelStage tied to the history item.
---@return LevelStage
function HistoryItem:GetLevelStage()
end

---Returns the RoomType tied to the history item.
---@return RoomType
function HistoryItem:GetRoomType()
end

---Returns the time the history item was added.
---@return integer
function HistoryItem:GetTime()
end

---@return boolean
function HistoryItem:IsTrinket()
end


---@class History
local History = {}

---Returns a table of collectible `HistoryItem` objects.
---@return HistoryItem[]
function History:GetCollectiblesHistory()
end

---Removes an item from the item history tracker on the right-hand side of the screen. Note that this does not remove the item effect from Isaac.
---@param index integer
---@return boolean `true` if an item was removed, `false` if not.
function History:RemoveItemByIndex(index)
end

---@class PlayerHUD
local PlayerHUD = {}

---Returns the PlayerHUDHeart from the provided index.
---@param index integer
---@return PlayerHUDHeart?
function PlayerHUD:GetHeartByIndex(index)
end

---Returns a table of `PlayerHUDHeart` objects.
---@return PlayerHUDHeart[]
function PlayerHUD:GetHearts()
end

---@return HUD
function PlayerHUD:GetHUD()
end

---@return EntityPlayer
function PlayerHUD:GetPlayer()
end

---@param slot ActiveSlot
---@param position Vector
---@param alpha? number @default: `1`.
---@param scale? number @default: `1`.
function PlayerHUD:RenderActiveItem(slot, position, alpha, scale)
end


---@class DebugRenderer
_G.DebugRenderer = {}

---TODO: Document me!
---@param index integer 
---@param unknown boolean TODO: Document me!
---@return Shape 
function DebugRenderer.Get(index, unknown)
end

---@class Minimap
_G.Minimap = {}

---Returns the minimap's current display size.
---@return Vector --When not expanded, always returns `Vector(47,47)`.
function Minimap.GetDisplayedSize()
end

---@return MinimapState
function Minimap.GetState()
end

---Returns how long the button action for the map has been held down to expand the map
---@return integer
function Minimap.GetHoldTime()
end

---Returns the Sprite object that holds map icons for Curses, Restock, and map-revealing effects
---@return Sprite
function Minimap.GetItemIconsSprite()
end

---Returns the Sprite object that holds all map icons 
---@return Sprite
function Minimap.GetIconsSprite()
end

---@return integer
function Minimap.GetShakeDuration()
end

---@return Vector
function Minimap.GetShakeOffset()
end

---@param duration integer
function Minimap.SetShakeDuration(duration)
end

---@param offset Vector
function Minimap.SetShakeOffset(offset)
end

---@param state MinimapState
function Minimap.SetState(state)
end

---Sets how long the button action for the map has been held down to expand the map
---@param time integer
function Minimap.SetHoldTime(time)
end

---@class PlayerHUDHeart
local PlayerHUDHeart = {}

---TODO: Document me!
---@return integer
function PlayerHUDHeart:GetFlashType()
end

---Returns the name of the heart's animation.
---@return string
function PlayerHUDHeart:GetHeartAnim()
end

---Returns the name of the heart's overlay animation.
---@return string 
function PlayerHUDHeart:GetHeartOverlayAnim()
end 

---Returns true if the golden heart overlay is visible.
---@return boolean 
function PlayerHUDHeart:IsGoldenHeartOverlayVisible()
end

---Returns true if the heart is visible.
---@return boolean 
function PlayerHUDHeart:IsVisible()
end

---Returns true if the eternal heart overlay is visible.
---@return boolean
function PlayerHUDHeart:IsEternalHeartOverlayVisible()
end

---Returns true if affected under Tainted Magdeline's fading heart mechanic.
function PlayerHUDHeart:IsFadingHeart()
end

---@class MainMenu
_G.MainMenu = {}

---@return Sprite 
function MainMenu.GetContinueWidgetSprite()
end

---@return Sprite 
function MainMenu.GetGameMenuSprite()
end

---@return integer 
function MainMenu.GetSelectedElement()
end

---@param elementNumber integer 
function MainMenu.SetSelectedElement(elementNumber)
end

---@class ChallengeMenu
_G.ChallengeMenu = {}

---Returns the challenge menu paper sprite.
---@return Sprite 
function ChallengeMenu.GetSprite()
end

---Returns the id of the currently selected challenge.
---@return Challenge
function ChallengeMenu.GetSelectedChallengeID()
end

---Sets the currently selected challenge.
---@param challenge Challenge
function ChallengeMenu.SetSelectedChallengeID(challenge)
end


---@class CutscenesMenu
_G.CutscenesMenu = {}

---@return Sprite 
function CutscenesMenu.GetSprite()
end

---@return integer 
function CutscenesMenu.GetSelectedElement()
end

---@param elementNumber integer 
function CutscenesMenu.SetSelectedElement(elementNumber)
end

---@class CharacterMenu
_G.CharacterMenu = {}

---Returns the big "Who Am I?" page sprite
---@return Sprite
function CharacterMenu.GetBigCharPageSprite()
end

---Returns the background sprite (BG drawings, tainted menu swap in/out animations)
---@return Sprite
function CharacterMenu.GetBGSprite()
end

---@return Sprite
function CharacterMenu.GetCharacterPortraitSprite()
end

---@return number
function CharacterMenu.GetCharacterWheelDepth()
end

---@return number
function CharacterMenu.GetCharacterWheelWidth()
end

---@return Difficulty
function CharacterMenu.GetDifficulty()
end

---@return Sprite
function CharacterMenu.GetDifficultyPageSprite()
end

---Returns the sprite of the blood stain when selecting Hard mode / Greedier.
---@return Sprite
function CharacterMenu.GetDifficultyOverlaySprite()
end

---@return Sprite
function CharacterMenu.GetEastereggPageSprite()
end

---Returns `true` if the currently selected character is unlocked.
---@return boolean
function CharacterMenu.GetIsCharacterUnlocked()
end

---Returns the greed decoration sprite (When selecting Greed or Greedier Mode).
---@return Sprite
function CharacterMenu.GetGreedDecoSprite()
end

---Returns the number of characters in the wheel.
---@return integer
function CharacterMenu.GetNumCharacters()
end

---@return Sprite
function CharacterMenu.GetPageSwapWidgetSprite()
end

---Returns the speed of the animation playing when rotating the selection wheel.
---@return number
function CharacterMenu.GetScrollSpeed()
end

---@return Sprite
function CharacterMenu.GetSeedEntrySprite()
end

---@return Sprite
function CharacterMenu.GetSeedPageSprite()
end

---@return Sprite
function CharacterMenu.GetSeedUnlockPageSprite()
end

---Returns the currently selected character menu.
---@return integer
---|0 # Normal
---|1 # Tainted
function CharacterMenu.GetSelectedCharacterMenu()
end

---Returns the element ID of the currently selected character.
---@return integer
function CharacterMenu.GetSelectedCharacterID()
end

---Returns the tainted background decoration sprite.
---@return Sprite
function CharacterMenu.GetTaintedBGDecoSprite()
end

---Returns the win streak page sprite.
---@return Sprite
function CharacterMenu.GetWinStreakPageSprite()
end

---Sets the character wheel's depth.
---@param depth number
function CharacterMenu.SetCharacterWheelDepth(depth)
end

---Sets the character wheel's width.
---@param width number
function CharacterMenu.SetCharacterWheelWidth(width)
end

---@param difficulty Difficulty
function CharacterMenu.SetDifficulty(difficulty)
end

---Locks or unlocks the currently selected character.
---@param unlocked boolean
function CharacterMenu.SetIsCharacterUnlocked(unlocked)
end

---Sets the character wheel's scroll speed.
---@param speed number
function CharacterMenu.SetScrollSpeed(speed)
end

---Sets the current character menu.
---@param menu integer
---|0 # Normal
---|1 # Tainted
function CharacterMenu.SetSelectedCharacterMenu(menu)
end

---Sets the current character ID.
---@param ID integer
function CharacterMenu.SetSelectedCharacterID(ID)
end

---@class DailyChallengeMenu
_G.DailyChallengeMenu = {}

---Returns the daily challenge menu sprite (background, most of the visible papers).
---@return Sprite 
function DailyChallengeMenu.GetSprite()
end

---Returns the leaderboard sprite.
---@return Sprite
function DailyChallengeMenu.GetLeaderboardSprite()
end

---Returns the leaderboard score menu sprite.
---@return Sprite 
function DailyChallengeMenu.GetLeaderboardScoreMenuSprite()
end

---@return integer
function DailyChallengeMenu.GetSelectedElement()
end

---Returns the hours left until the daily challenge resets.
---@return integer
function DailyChallengeMenu.GetTimeLeftHours()
end

---Returns the minutes left until the daily challenge resets.
---@return integer
function DailyChallengeMenu.GetTimeLeftMinutes()
end

---Returns the seconds left until the daily challenge resets.
---@return integer
function DailyChallengeMenu.GetTimeLeftSeconds()
end

---@return boolean 
function DailyChallengeMenu.IsLeaderboardVisible()
end

---@param element integer 
function DailyChallengeMenu.SetSelectedElement(element)
end

---@return integer
function DailyChallengeMenu.GetState()
end

---@param state integer
function DailyChallengeMenu.SetState(state)
end

---@class TitleMenu
_G.TitleMenu = {}

---@return Sprite 
function TitleMenu.GetSprite()
end



---@class StatsMenu
_G.StatsMenu = {}

---@return Sprite 
function StatsMenu.GetSecretsMenuSprite()
end

---@return Sprite 
function StatsMenu.GetSecretsMenuCursorLeftSprite()
end

---@return Sprite 
function StatsMenu.GetSecretsMenuCursorRightSprite()
end

--Returns the secrets menu mini sprite #1. Used for the left scroll transition animation.
---@return Sprite 
function StatsMenu.GetSecretsMenuMiniSprite1()
end

---@return Sprite 
function StatsMenu.GetSecretsMenuMiniSprite2()
end

---@return Sprite 
function StatsMenu.GetSecretsMenuMiniSprite3()
end

---@return Sprite 
function StatsMenu.GetSecretsMenuMiniSprite4()
end

---Returns the secrets menu mini sprite #5. Used to display the currently highlighted achievement.
---@return Sprite 
function StatsMenu.GetSecretsMenuMiniSprite5()
end

---@return Sprite 
function StatsMenu.GetSecretsMenuMiniSprite6()
end

---@return Sprite 
function StatsMenu.GetSecretsMenuMiniSprite7()
end

---@return Sprite 
function StatsMenu.GetSecretsMenuMiniSprite8()
end

---Returns the secrets menu mini sprite #9. Used for the right scroll transition animation.
---@return Sprite 
function StatsMenu.GetSecretsMenuMiniSprite9()
end

---@return Sprite 
function StatsMenu.GetStatsMenuSprite()
end

---@return boolean 
function StatsMenu.IsSecretsMenuActive()
end

---@param element integer
function StatsMenu.SetSelectedElement(element)
end

---@return integer
function StatsMenu.GetSelectedElement()
end






---@class KeyConfigMenu
_G.KeyConfigMenu = {}

---@return Sprite 
function KeyConfigMenu.GetSprite()
end

---@return integer
function KeyConfigMenu.GetColumn()
end

---@return integer 
function KeyConfigMenu.GetSelectedElement()
end

---@param column integer 
function KeyConfigMenu.SetSelectedColumn(column)
end

---@param elementNumber integer 
function KeyConfigMenu.SetSelectedElement(elementNumber)
end

---Returns true if the player is editing their key config.
---@return boolean
function KeyConfigMenu.IsEditActive()
end

---@class ControllerSelectMenu
_G.ControllerSelectMenu = {}

---@return Sprite 
function ControllerSelectMenu.GetSprite()
end

---@return integer 
function ControllerSelectMenu.GetSelectedElement()
end

---@param elementNumber integer 
function ControllerSelectMenu.SetSelectedElement(elementNumber)
end

---@class MenuManager
_G.MenuManager = {}

---Returns the active menu on the main menu matching `MainMenuType`.
---@return MainMenuType
function MenuManager.GetActiveMenu()
end

---@return Sprite 
function MenuManager.GetBackWidgetSprite()
end

---Returns the color modifier lerp amount. This is formatted as the absolute rate of change.
---@return number
function MenuManager.GetColorModifierLerpAmount()
end

---@return ColorModifier
function MenuManager.GetCurrentColorModifier()
end

---@return Sprite 
function MenuManager.GetSelectWidgetSprite()
end

---@return Sprite 
function MenuManager.GetShadowSprite()
end

---@return ColorModifier
function MenuManager.GetTargetColorModifier()
end

---@return Vector 
function MenuManager.GetViewPosition()
end

---Changes the active menu on the main menu to match the given `MainMenuType`.
---@param menuType MainMenuType
function MenuManager.SetActiveMenu(menuType)
end

---@param colorModifier ColorModifier
---@param lerp? boolean @default: `true`
---@param rate? number @default: `0.015`.
function MenuManager.SetColorModifier(colorModifier, lerp, rate)
end

---@param position Vector 
function MenuManager.SetViewPosition(position)
end

---Selectively allows/disallows the game's menu to read certain inputs. Useful for custom menus.
---@param mask ButtonActionBitwise
function MenuManager.SetInputMask(mask)
end

---@return ButtonActionBitwise
function MenuManager.GetInputMask()
end

---@class OptionsMenu
_G.OptionsMenu = {}

---@return Sprite 
function OptionsMenu.GetGammaWidgetSprite()
end

---@return Sprite 
function OptionsMenu.GetOptionsMenuSprite()
end

---@return integer 
function OptionsMenu.GetSelectedElement()
end

---@param elementNumber integer 
function OptionsMenu.SetSelectedElement(elementNumber)
end

---@class CollectionMenu
_G.CollectionMenu = {}

---Returns the collection menu sprite (Paper sprite and all other decoration).
---@return Sprite 
function CollectionMenu.GetCollectionMenuSprite()
end

---Returns the sprite of the selectable elements that shows the "DeathScreen" item sprites.
---@return Sprite 
function CollectionMenu.GetDeathScreenSprite()
end

---@return integer
function CollectionMenu.GetSelectedPage()
end

---@return integer
function CollectionMenu.GetSelectedElement()
end

---Sets the current page.
---@param page integer 
function CollectionMenu.SetSelectedPage(page)
end

---@param elementNumber integer
function CollectionMenu.SetSelectedElement(elementNumber)
end

---@class CustomChallengeMenu
_G.CustomChallengeMenu = {}

---@return Sprite 
function CustomChallengeMenu.GetSprite()
end

---Returns the currently selected modded challenge.
---@return Challenge
function CustomChallengeMenu.GetSelectedChallengeID()
end

---Sets the current modded challenge.
---@param challenge Challenge 
function CustomChallengeMenu.SetSelectedChallengeID(challenge)
end

---@class ModsMenu
_G.ModsMenu = {}

---@return Sprite 
function ModsMenu.GetSprite()
end

---@return integer 
function ModsMenu.GetSelectedElement()
end

---@param elementNumber integer 
function ModsMenu.SetSelectedElement(elementNumber)
end

---Returns true if the mod list was edited.
---@return boolean
function ModsMenu.WasListEdited()
end

---@class BestiaryMenu
_G.BestiaryMenu = {}

---Returns the bestiary menu sprite.
---@return Sprite
function BestiaryMenu.GetBestiaryMenuSprite()
end

---Returns the sprite of the selectable elements that shows the "DeathScreen" enemy sprite.
---@return Sprite
function BestiaryMenu.GetDeathScreenSprite()
end

---Returns the animated enemy preview sprite.
---@return Sprite
function BestiaryMenu.GetEnemySprite()
end

---Returns the current page number.
---@return integer
function BestiaryMenu.GetSelectedPage()
end

---@return integer
function BestiaryMenu.GetLastEnemyPageID()
end

---@return integer
function BestiaryMenu.GetNumBossPages()
end

---@return integer
function BestiaryMenu.GetNumMonsterPages()
end

---@return integer
function BestiaryMenu.GetNumPages()
end

---Returns the selected element on the current page.
---@return integer
function BestiaryMenu.GetSelectedElement()
end

---Sets the current page.
---@param page integer
function BestiaryMenu.SetSelectedPage(page)
end

---Sets the selected element on the current page.
---@param element integer
function BestiaryMenu.SetSelectedElement(element)
end


---@class SaveMenu
_G.SaveMenu = {}

---@return Sprite 
function SaveMenu.GetSaveSelectionMenuSprite()
end

---@return Sprite 
function SaveMenu.GetDeleteButtonSprite()
end

---@return Sprite 
function SaveMenu.GetDeletePopupSprite()
end

---@return Sprite 
function SaveMenu.GetSave1DrawingSprite()
end

---@return Sprite 
function SaveMenu.GetSave2DrawingSprite()
end

---@return Sprite 
function SaveMenu.GetSave3DrawingSprite()
end

---@return integer 
function SaveMenu.GetSelectedElement()
end

---Returns true if the save file deletion mode is active.
---@return boolean
function SaveMenu.IsDeleteActive()
end

---Sets the current element.
---@param elementNumber integer 
function SaveMenu.SetSelectedElement(elementNumber)
end

---@class SpecialSpeedsMenu
_G.SpecialSpeedsMenu = {}

---@return Sprite 
function SpecialSpeedsMenu.GetSprite()
end

---@return integer 
function SpecialSpeedsMenu.GetSelectedElement()
end

---@param elementNumber integer 
function SpecialSpeedsMenu.SetSelectedElement(elementNumber)
end

---@class EntityDelirium : Entity
---@field Angle integer This variable is an eight bit integers, so the allowed values are the integers from 0 to 255 (inclusive). You can use a linear interpolation between the [0: 255] and the [0: 360[ ranges in order to convert angles in degree to this system.
---@field AttackID integer Internal `I1` value used by Delirium to identify the bullet hell pattern it is currently executing.
---@field BossType integer `EntityType` of the boss Delirium is currently transformed as.
---@field BossVariant integer Variant of the boss Delirium is currently transformed as.
---@field Cycle integer Internal `I2` value used by Delirium to identify whether red mode is activated and the amount of time before a teleportation. You should not use this variable directly and instead rely on the `GetTeleportationTimer`, `SetTeleportationTimer`, `IsRedMode` and `SetRedMode` functions instead. The only reason to use this variable directly is if you want to freeze it to a certain value that you know will do exactly what you want (for instance disable red mode and prevent teleportation).
---@field RemainingAttacks integer Number of attacks remaining before Delirium transforms into another boss.
---@field StateD NpcState Internal `State` of Delirium.
---@field TransformationTimer integer Get or set the amount of time before Delirium transforms into another boss.
local EntityDelirium = {}

---@return integer
function EntityDelirium:GetTeleportationTimer()
end

---Returns a boolean indicating if the red mode is activated or not.
---@return boolean
function EntityDelirium:IsRedMode()
end

---Enable or disable red mode according to the parameter on. 
---@param on boolean
function EntityDelirium:SetRedMode(on)
end

---Set the number of frames before Delirium teleports. Negative values are not allowed.
---@param timer integer
function EntityDelirium:SetTeleportationTimer(timer)
end

---Transform Delirium into the entity with the specified type and variant.
---@param type EntityType
---@param variant? integer @default: `0`
function EntityDelirium:Transform(type, variant)
end


---@class EntitySlot : Entity
local EntitySlot = {}

---Causes the slot to drop what it typically would if blown up.
function EntitySlot:CreateDropsFromExplosion()
end

---Beggar: How many coins have been donated.
---
---Demon Beggar: How many hearts have been donated.
---
---Battery Bum/Rotten Beggar: Increases with each payment by random amounts, up to 3, and resets back to 0 upon reward or payout.
---
---Returns `0` for all other vanilla slots.
---@return integer
function EntitySlot:GetDonationValue()
end

---Shell Game and Hell Game: Returns the `PickupVariant` of the potential prize.
--
---Slot Machine: Returns the type of prize it had output. Successful prize types are `3`-`12`.
---
---Bomb Bum: Returns the type of prize it had output. `1` - Coins. `2` - A heart. `3` - Collectible.
---
---Returns `0` for all other vanilla slots.
---@return integer
function EntitySlot:GetPrizeType()
end

---Returns the current state of the slot.
---@return integer
---|1 # Idle
---|2 # Reward / Idle Reward
---|3 # Bombed
---|4 # Payout
---|5 # Shell/Hell Game Exclusive: Reward
function EntitySlot:GetState()
end

---Returns the timeout in frames until the slot determines its prize. Not used by all slots.
---
---All Beggars except Bomb Beggar: Increases randomly with each payment, returning either `1 << 16`, `1 << 17`, or the sum of them, resetting to 0 upon giving a reward.
---
---Crane Game: For the first successful payout, minimum timeout is `1 << 16`, still increasing by 30 and counting down. Second payout is `1 << 17`. Third payout is `1 << 16` + `1 << 17`.
---
---Returns `0` for all other vanilla slots.
---@return integer
function EntitySlot:GetTimeout()
end

---Returns the slot's touch counter. The touch counter goes up by one every frame a player is touching the slot and is reset once no player is touching it.
---@return integer
function EntitySlot:GetTouch()
end

---Returns a random string from the following options: CoinJam, CoinJam2, CoinJam3, CoinJam4. Presumably only used on the donation machines.
---@return string
function EntitySlot:RandomCoinJamAnim()
end

---Sets the slot's donation value.
---@param value integer
function EntitySlot:SetDonationValue(value)
end


---Seems to only be used by Crane Game and Hell Game. This gets the collectible that the games will pay out with.
---@return CollectibleType
function EntitySlot:GetPrizeCollectible()
end

---Seems to only be used by Crane Game and Hell Game. This sets the collectible that the games will pay out with and updates the rendered collectible accordingly.
---@param collectible CollectibleType
function EntitySlot:SetPrizeCollectible(collectible)
end

---Sets the prize type of the slot. See `EntitySlot:GetPrizeType` for more information.
---@param prizeType integer
function EntitySlot:SetPrizeType(prizeType)
end

---Sets the state of the slot. See `EntitySlot:GetState` for more information.
---@param state integer
function EntitySlot:SetState(state)
end

---Sets the timeout of the slot. See `EntitySlot:GetTimeout` for more information.
---@param timeout integer
function EntitySlot:SetTimeout(timeout)
end

---Sets the slot's touch counter. The touch counter goes up by one every frame a player is touching the slot and is reset once no player is touching it.
---@param newValue integer
function EntitySlot:SetTouch(newValue)
end

---Returns the index used by Shell Game and Hell Game to determine which prize animation to play.
---@return integer
function EntitySlot:GetShellGameAnimationIndex()
end

---Sets the index used by Shell Game and Hell Game to determine which prize animation to play.
---@param index integer
function EntitySlot:SetShellGameAnimationIndex(index)
end

---Returns a number used by Bomb Bum and Reroll Machine
---
---When bombing Bomb Bum, this is set to `30`
---
---Reroll Machine increments this by `1` for every successful reroll. When bombed, has a chance to set it to 11 and reroll another item.
function EntitySlot:GetTriggerTimerNum()
end

---Sets a number used by Bomb Bum and Reroll Machine
---
---When bombing Bomb Bum, this is set to `30`
---
---Reroll Machine increments this by `1` for every successful reroll. When bombed, has a chance to set it to 11 and reroll another item.
---@param num integer
function EntitySlot:SetTriggerTimerNum(num)
end

---@class GridEntityDecoration : GridEntity
local GridEntityDecoration = {}

---@class GridEntityLock : GridEntity
local GridEntityLock = {}

---@class GridEntityGravity : GridEntity
local GridEntityGravity = {}

---@class GridEntityStairs : GridEntity
local GridEntityStairs = {}

---@class GridEntityFire : GridEntity
local GridEntityFire = {}

---@class GridEntityWall : GridEntity
local GridEntityWall = {}

---@class GridEntityTeleporter : GridEntity
local GridEntityTeleporter = {}

---@class GridEntityTrapDoor : GridEntity
local GridEntityTrapDoor = {}

---@class GridEntityWeb : GridEntity
local GridEntityWeb = {}

---@class GridEntityStatue : GridEntity
local GridEntityStatue = {}



-- Enums
---@enum ModCallbacks
ModCallbacks = {
    MC_NPC_UPDATE = 0, -- (EntityNPC NPC) | Optional Arg: EntityType - Called after an NPC is updated.
    MC_POST_UPDATE = 1, -- Callback has no arguments. Called after game update.
    MC_POST_RENDER = 2, -- Callback has no arguments. Called after game render.
    MC_USE_ITEM = 3, -- (CollectibleType ItemID, RNG RNG, EntityPlayer Player, UseFlags Flags, ActiveSlot Slot, integer CustomVarData): boolean | table, Optional Arg: CollectibleType - Called when a custom active item is used. The item RNG allows for the item's random events to be seeded. Return true to show the "use item" animation, otherwise false. If a table is returned instead of a boolean, the following fields can be set to a non-nil value for extra functionality: {Discharge: Determines whether the item should be discharged or not after being used, Remove: Determines whether the item should be removed from the player or not after being used, ShowAnim: Plays the default use animation if set to true (equivalent to simply returning true in AB+)}
    MC_POST_PEFFECT_UPDATE = 4, -- (EntityPlayer Player), Optional Arg: PlayerType - Called for each player, each frame, after the player evaluates the effects of items that must be constantly evaluated.
    MC_USE_CARD = 5, -- (Card CardID, EntityPlayer Player, UseFlags integer), Optional Arg: Card - Called when a custom card is used.
    MC_FAMILIAR_UPDATE = 6, -- (EntityFamiliar Familiar), Optional Arg: FamiliarVariant - Called every frame for each custom familiar.
    MC_FAMILIAR_INIT = 7, -- (EntityFamiliar Familiar), Optional Arg: FamiliarVariant - Called just after a custom familiar is initialized.
    MC_EVALUATE_CACHE = 8, -- (EntityPlayer Player, CacheFlag CacheFlag), Optional Arg: CacheFlag. Called one or more times when a player's stats are re-evaluated. For example, this will fire after the player picks up a collectible item that grants stats or uses a stat pill.
    MC_POST_PLAYER_INIT = 9, -- (EntityPlayer Player), Optional Arg: PlayerVariant - Called after the player is initialized.
    MC_USE_PILL = 10, -- (PillEffect PillEffectID, EntityPlayer Player, UseFlags Flags), Optional Arg: PillEffect - Called when a custom pill is used.
    MC_ENTITY_TAKE_DMG = 11, -- (Entity Entity, float Amount, integer DamageFlags, EntityRef Source, integer CountdownFrames): boolean, Optional Arg: EntityType - Called before new damage is applied. Return true or nil if the entity or player should sustain the damage, otherwise false to ignore it.
    MC_POST_CURSE_EVAL = 12, -- (integer Curses) - Curses is a bitmask containing current curses. Called after Level applied it's curses. Return the new curse bitmask. Use Isaac.GetCurseIdByName to get a custom curse
    MC_INPUT_ACTION = 13, -- (Entity Entity, InputHook InputHook, ButtonAction ButtonAction): boolean | float, Optional Arg: InputHook - This callback fires every time the game polls for a ButtonAction input, often several times per frame even for the same action. Since it has to do with polling, it fires regardless of whether or not the player is actually pressing any particular input. Return nil if you do not want to overwrite the input. If you do want to overwrite the input, then you have to return a boolean for the IS_ACTION_PRESSED (0) and IS_ACTION_TRIGGERED (1) input hooks, or a float between 0.0 and 1.0 for the GET_ACTION_VALUE (2) input hook.
    MC_LEVEL_GENERATOR = 14, -- This callback doesn't work right now and will never be called by the game!
    MC_POST_GAME_STARTED = 15, -- (boolean IsContinued) - This function gets called when you start a game. IsContinued is true when you continue a run, false when you start a new one.
    MC_POST_GAME_END = 16, -- (boolean IsGameOver) - This function gets called when the game over screen appears, or when the an ending starts playing. IsGameOver is true when you died and got a game over, false when you won and got an ending.
    MC_PRE_GAME_EXIT = 17, -- (boolean ShouldSave) - This function gets called when you quit a run. ShouldSave is true when the game would normally create a continuable save, false when it wouldn't. Called twice when the game plays an ending.
    MC_POST_NEW_LEVEL = 18, -- Callback has no arguments. This triggers after transitioning a level or stage.
    MC_POST_NEW_ROOM = 19, -- Callback has no arguments. This triggers after entering a room.
    MC_GET_CARD = 20, -- (RNG RNG, Card CurrentCard, boolean Playing, boolean Runes, boolean OnlyRunes): Card - This is used for Card Pools. Because not all cards have the same chance to spawn, use RNG for seeded random and return your card id (if you don't want to change the current card, return CurrentCard or nil). If desired, Playing (can include playing cards), Runes (can include runes), OnlyRunes (only return runes) filter can be used to make your selection.
    MC_GET_SHADER_PARAMS = 21, -- (string shaderName): table - Return a table containing a key -> value pair for custom shader parameters. Will skip remaining callbacks when returning a table.
    MC_EXECUTE_CMD = 22, -- (string cmd, string params): string - Return a string separated by \n (newline) per output line.
    MC_PRE_USE_ITEM = 23, -- (CollectibleType ItemID, RNG ItemRng, EntityPlayer Player, UseFlags Flags, ActiveSlot Slot, integer CustomVarData): boolean, Optional Arg: CollectibleType - Called before an item is used. Return true to prevent the default code of an item to be triggered. This will still discharge the item.
    MC_PRE_ENTITY_SPAWN = 24, -- (EntityType Type, integer Variant, integer SubType, const Vector Position, const Vector Velocity, const Entity Spawner, integer Seed): table{ EntityType Type, integer Variant, integer Subtype, integer Seed }
    MC_POST_FAMILIAR_RENDER = 25, -- (EntityFamiliar Familiar, Vector Offset), Optional Arg: FamiliarVariant.
    MC_PRE_FAMILIAR_COLLISION = 26, -- (EntityFamiliar Familiar, Entity Collider, boolean Low): boolean, Optional Arg: FamiliarVariant - Return true/false to ignore collision code (true to ignore collision, false to collide), or nil to continue the internal code.
    MC_POST_NPC_INIT = 27, -- (EntityNPC NPC), Optional Arg: EntityType.
    MC_POST_NPC_RENDER = 28, -- (EntityNPC NPC, Vector Offset, Optional Arg: EntityType).
    MC_POST_NPC_DEATH = 29, -- (EntityNPC NPC), Optional Arg: EntityType - Gets called after the Death animation is played.
    MC_PRE_NPC_COLLISION = 30, -- (EntityNPC NPC, Entity Collider, boolean Low): boolean, Optional Arg: EntityType - Return true/false to ignore collision code (true to ignore collision, false to collide), or nil to continue the internal code.
    MC_POST_PLAYER_UPDATE = 31, -- (EntityPlayer Player), Optional Arg: PlayerVariant.
    MC_POST_PLAYER_RENDER = 32, -- (EntityPlayer Player, Vector Offset), Optional Arg: PlayerVariant.
    MC_PRE_PLAYER_COLLISION = 33, -- (EntityPlayer Player, Entity Collider, boolean Low): boolean, Optional Arg: PlayerVariant - Return true/false to ignore collision code (true to ignore collision, false to collide), or nil to continue the internal code.
    MC_POST_PICKUP_INIT = 34, -- (EntityPickup Pickup), Optional Arg: PickupVariant.
    MC_POST_PICKUP_UPDATE = 35, -- (EntityPickup Pickup), Optional Arg: PickupVariant.
    MC_POST_PICKUP_RENDER = 36, -- (EntityPickup Pickup, Vector Offset), Optional Arg: PickupVariant.
    MC_POST_PICKUP_SELECTION = 37, -- (EntityPickup Pickup, integer Variant, integer Subtype): table{integer Variant, integer SubType} - Called after a Pickup was chosen from a list of random pickups to be spawned. Return table nil to continue with default game code.
    MC_PRE_PICKUP_COLLISION = 38, -- (EntityPickup Pickup, Entity Collider, boolean Low): boolean - Return true/false to ignore collision code (true to ignore collision, false to collide), or nil to continue the internal code.
    MC_POST_TEAR_INIT = 39, -- (EntityTear Tear), Optional Arg: TearVariant
    MC_POST_TEAR_UPDATE = 40, -- (EntityTear Tear), Optional Arg: TearVariant
    MC_POST_TEAR_RENDER = 41, -- (EntityTear Tear, Vector Offset), Optional Arg: TearVariant
    MC_PRE_TEAR_COLLISION = 42, -- (EntityTear Tear, Entity Collider, boolean Low): boolean - Return true/false to ignore collision code (true to ignore collision, false to collide), or nil to continue the internal code.
    MC_POST_PROJECTILE_INIT = 43, -- (EntityProjectile Projectile), Optional Arg: ProjectileVariant
    MC_POST_PROJECTILE_UPDATE = 44, -- (EntityProjectile Projectile), Optional Arg: ProjectileVariant
    MC_POST_PROJECTILE_RENDER = 45, -- (EntityProjectile Projectile, Vector Offset), Optional Arg: ProjectileVariant
    MC_PRE_PROJECTILE_COLLISION = 46, -- (EntityProjectile Projectile, Entity Collider, boolean Low): boolean - Return true/false to ignore collision code (true to ignore collision, false to collide), or nil to continue the internal code.
    MC_POST_LASER_INIT = 47, -- (EntityLaser Laser), Optional Arg: LaserVariant
    MC_POST_LASER_UPDATE = 48, -- (EntityLaser Laser), Optional Arg: LaserVariant
    MC_POST_LASER_RENDER = 49, -- (EntityLaser Laser, Vector Offset), Optional Arg: LaserVariant
    MC_POST_KNIFE_INIT = 50, -- (EntityKnife Knife), Optional Arg: KnifeSubType
    MC_POST_KNIFE_UPDATE = 51, -- (EntityKnife Knife), Optional Arg: KnifeSubType
    MC_POST_KNIFE_RENDER = 52, -- (EntityKnife Knife, Vector Offset), Optional Arg: KnifeSubType
    MC_PRE_KNIFE_COLLISION = 53, -- (EntityKnife Knife, Entity Collider, boolean Low): boolean, Optional Arg: KnifeSubType - Return true/false to ignore collision code (true to ignore collision, false to collide), or nil to continue the internal code.
    MC_POST_EFFECT_INIT = 54, -- (EntityEffect Effect), Optional Arg: EffectVariant
    MC_POST_EFFECT_UPDATE = 55, -- (EntityEffect Effect), Optional Arg: EffectVariant
    MC_POST_EFFECT_RENDER = 56, -- (EntityEffect Effect, Vector Offset), Optional Arg: EffectVariant
    MC_POST_BOMB_INIT = 57, -- (EntityBomb Bomb), Optional Arg: BombVariant
    MC_POST_BOMB_UPDATE = 58, -- (EntityBomb Bomb), Optional Arg: BombVariant
    MC_POST_BOMB_RENDER = 59, -- (EntityBomb Bomb, Vector Offset), Optional Arg: BombVariant
    MC_PRE_BOMB_COLLISION = 60, -- (EntityBomb Bomb, Entity Collider, boolean Low): boolean, Optional Arg: BombVariant - Return true/false to ignore collision code (true to ignore collision, false to collide), or nil to continue the internal code.
    MC_POST_FIRE_TEAR = 61, -- (EntityTear Tear) - Called when the player fires a tear.
    MC_PRE_GET_COLLECTIBLE = 62, -- (ItemPoolType PoolType, boolean Decrease, integer Seed): CollectibleType - This callback is called when the game needs to get a new random item from an item pool.
    MC_POST_GET_COLLECTIBLE = 63, -- (CollectibleType SelectedCollectible, integer PoolType, boolean Decrease, integer Seed): CollectibleType - This function is called right after MC_PRE_GET_COLLECTIBLE and determines the Collectible that will be spawned from the given ItemPoolType.
    MC_GET_PILL_COLOR = 64, -- (PillColor SelectedPill, integer Seed): PillColor - This function is called when the game is spawning a pill and needs to determine its PillColor.
    MC_GET_PILL_EFFECT = 65, -- (PillEffect SelectedPillEffect, PillColor PillColorID): PillEffect - Called every frame when the game gets the PillEffect of a pill. The effect of the pill can be chosen by returning the chosen PillEffect.
    MC_GET_TRINKET = 66, -- (TrinketType SelectedTrinket, RNG TrinketRNG): TrinketType - Called when the TrinketType of a trinket needs to be determined.
    MC_POST_ENTITY_REMOVE = 67, -- (Entity Entity), Optional Arg: EntityType - Called whenever an Entity gets removed by the game. This includes deaths, kills, removals and even unloading an entity on room transition or ending a run.
    MC_POST_ENTITY_KILL = 68, -- (Entity Entity), Optional Arg: EntityType - Called right before a death animation is triggered for an Entity.
    MC_PRE_NPC_UPDATE = 69, -- (EntityNPC NPC): boolean, Optional Arg: EntityType - Return true if the internal AI should be ignored, false or `nil`/nothing otherwise.
    MC_PRE_SPAWN_CLEAN_AWARD = 70, -- (RNG Rng, Vector SpawnPos): boolean - Return true if the spawn routine after any room clear should be ignored, false or `nil`/nothing otherwise.
    MC_PRE_ROOM_ENTITY_SPAWN = 71, -- (EntityType Type, integer Variant, integer SubType, integer GridIndex, integer Seed) - This is called when entering a new room, before spawning entities which are part its layout. Grid entities will also trigger this callback and their type will the same as the type used by the gridspawn command. Because of this, effects are assigned the type 999 instead of 1000 in this callback. Optional return: an array table with new values { Type, Variant, Subtype }. Returning a table will override any replacements that might naturally occur i.e. enemy variants.
    MC_PRE_ENTITY_DEVOLVE = 72, -- (Entity Entity) - Return true if the internal devolving behavior should be ignored - When returning true, this callback is responsible for spawning the devolved entity and removing the original one.
    MC_PRE_MOD_UNLOAD = 73, -- (table Mod) - This is called right before any mod is unloaded (when disabling a mod or reloading it using luamod), the mod's table is passed as an argument.
    MC_PRE_ADD_COLLECTIBLE = 1004, -- (CollectibleType Type, integer Charge, boolean FirstTime, integer Slot, integer VarData, EntityPlayer Player): `CollectibleType` | {Type Charge FirstTime Slot VarData Player} - Returning a `CollectibleType` overrides the collectible. You can also return a table of parameters to further modify the collectible given.
    MC_POST_ADD_COLLECTIBLE = 1005, -- (CollectibleType Type, integer Charge, boolean FirstTime, integer Slot, integer VarData, EntityPlayer Player)
    MC_POST_TAKE_DMG = 1006, -- (Entity Entity, float Damage, DamageFlags DamageFlags, EntityRef Source, integer DamageCountdown) - Leftover for backwards compatibility. Use MC_POST_ENTITY_TAKE_DMG instead.
    MC_POST_ENTITY_TAKE_DMG = 1006, -- (Entity Entity, float Damage, DamageFlags DamageFlags, EntityRef Source, integer DamageCountdown)
    MC_PRE_PLAYER_TAKE_DMG = 1008, -- (EntityPlayer Player, float Damage, DamageFlags DamageFlags, EntityRef Source, integer DamageCountdown) - Runs earlier than MC_ENTITY_TAKE_DMG, and even if the player is considered invincible or has Holy Mantles. Only accepts returning `false` to cancel the damage. Good for giving the player invincibility that takes precedence over other damage negation effects, such as Holy Mantle.
    MC_PRE_PLAYER_ADD_HEARTS = 1009, -- (EntityPlayer Player, integer Amount, AddHealthType AddHealthType, boolean ExtraArg): integer, Optional Arg: AddHealthType - Runs before Add(...)Hearts functions, allows returning a value to change the given amount of health. Functions that include an argument (e.g. ignoreKeeper for AddMaxHearts) provide the value using ExtraArg.
    MC_POST_PLAYER_ADD_HEARTS = 1010, -- (EntityPlayer Player, integer Amount, AddHealthType AddHealthType, boolean ExtraArg), Optional Arg: AddHealthType - Runs after Add(...)Hearts functions, allows returning a value to change the given amount of health. Functions that include an argument (e.g. ignoreKeeper for AddMaxHearts) provide the value using ExtraArg.
    MC_POST_GRID_ROCK_DESTROY = 1011, -- (GridEntityRock Rock, GridEntityType Type, boolean Immediate) - When adding callback, specify a GridEntityType to only respond to that one grid type.
    MC_GRID_HURT_DAMAGE = 1012, -- (GridEntity GridEntity, Entity Entity, integer DamageAmount, DamageFlags DamageFlags, float Unknown, boolean Unknown) - Return `false` if entity or player should ignore damage from it. When adding callback, specify a GridEntityType to only respond to that grid type.
    MC_POST_GRID_HURT_DAMAGE = 1013, -- (GridEntity GridEntity, Entity Entity, integer DamageAmount, DamageFlags DamageFlags, float Unknown, boolean Unknown) - Runs after MC_GRID_HURT_DAMAGE.
    MC_HUD_UPDATE = 1020, -- Callback has no arguments. Called during HUD update.
    MC_HUD_POST_UPDATE = 1021, -- Callback has no arguments. Called after HUD update.
    MC_HUD_RENDER = 1022, -- Callback has no arguments. Called during HUD render.
    MC_POST_HUD_RENDER = 1024, -- Callback has no arguments. Called after HUD render.
    MC_MAIN_MENU_RENDER = 1023, -- Callback has no arguments. Called after HUD render.
    MC_PRE_SFX_PLAY = 1030, -- (SoundEffect ID, float Volume, integer FrameDelay, boolean Loop, float Pitch, float Pan): table{ID, Volume, FrameDelay, Loop, Pitch, Pan} | boolean, Optional Arg: SoundEffect - Called before a sound plays. Accepts a table of parameters to override the sound, or `false` to cancel the sound.
    MC_POST_SFX_PLAY = 1031, -- (SoundEffect ID, float Volume, integer FrameDelay, boolean Loop, float Pitch, float Pan), Optional Arg: Sound Effect - Called after a sound plays.
    MC_PRE_MUSIC_PLAY = 1034, -- (Music ID, float Volume | float FadeRate, boolean IsFade): table{ID, Volume | FadeRate}, Optional Arg: Music - Called before a music track plays. Accepts a table of parameters to override the music, or `false` to cancel the track.
    MC_PRE_MUSIC_LAYER_TOGGLE = 1035, -- (integer ID, boolean CurrentState): integer | boolean, Optional Arg: integer - Accepts a music layer ID (enum pending) to change the layer, or a boolean to change the state of the layer: `true` to keep it running, `false` to stop it.
    MC_PRE_RENDER_PLAYER_HEAD = 1038, -- (EntityPlayer Player, Vector RenderPos): Vector | boolean, Optional Arg: PlayerType - Called before a player's head is rendered. Accepts an override Vector for RenderPos, alternatively accepts `false` to stop the rendering.
    MC_POST_RENDER_PLAYER_HEAD = 1045, -- (EntityPlayer Player, Vector RenderPos), Optional Arg: PlayerType - Called before a player's head is rendered, assuming it wasn't skipped.
    MC_PRE_RENDER_PLAYER_BODY = 1039, -- (EntityPlayer Player, Vector RenderPos): Vector | boolean, Optional Arg: PlayerType - Called before a player's body is rendered. Accepts an override Vector for RenderPos, alternatively accepts `false` to stop the rendering.
    MC_POST_RENDER_PLAYER_BODY = 1046, -- (EntityPlayer Player, Vector RenderPos), Optional Arg: PlayerType - Called before a player's body is rendered, assuming it wasn't skipped.
    MC_PRE_ENTITY_THROW = 1040, -- (EntityPlayer ThrowingPlayer, Entity HeldEntity, Vector Velocity): Vector - Called before a held entity is thrown. Accepts a Vector which will modify the velocity of the thrown entity.
    MC_POST_ENTITY_THROW = 1041, -- (EntityPlayer ThrowingPlayer, Entity HeldEntity, Vector Velocity) - Called after a held entity is thrown.
    MC_PLAYER_INIT_POST_LEVEL_INIT_STATS = 1042, -- (EntityPlayer Player), Optional Arg: PlayerType. Called after a player is initialized for the first time, being when starting the run, joining the game as a co-op player, or when activating Genesis.
    MC_PRE_ROOM_EXIT = 1043, -- (EntityPlayer Player, boolean NewLevel) - Called before exiting the current room. NewLevel is `true` if the room is transitioning into a new floor.
    MC_PRE_LEVEL_INIT = 1060, -- Callback has no arguments. Called before a new level is initialized.
    MC_PRE_TRIGGER_PLAYER_DEATH = 1050, -- (EntityPlayer Player): boolean - Called right before the game over screen. Return `false` to cancel the death, reviving the player in-place with half a heart, or true/`nil`/nothing to allow the death to go through.
    MC_PRE_RESTOCK_SHOP = 1070, -- (boolean Partial) - Return `false` to cancel the restock, blocking shop rerolls from restock machines or restocks from Restock altogether. Partial is `true` for Room::ShopRestockPartial() and Restock, `false` for Room::ShopRestockFull() and restock machines.
    MC_POST_RESTOCK_SHOP = 1071, -- (boolean Partial) - Called after a shop rerolls from restock machines or Restock. Partial is `true` for Room::ShopRestockPartial() and Restock, `false` for Room::ShopRestockFull() and restock machines.
    MC_PRE_CHANGE_ROOM = 1061, -- (integer TargetRoomIdx, integer Dimension): table{TargetRoomIdx, Dimension} - Called before the room changes. Accepts a table of parameters to change what room you enter.
    MC_POST_PICKUP_SHOP_PURCHASE = 1062, -- (EntityPickup Pickup, EntityPlayer Player, integer MoneySpent), Optional Arg: PickupVariant - Called after an item is purchased. This includes devil deals.
    MC_GET_FOLLOWER_PRIORITY = 1063, -- (EntityFamiliar Familiar): FollowerPriority | integer, Optional Arg: FamiliarVariant - Accepts FollowerPriority to give familiar priority. Can accept any integer.
    MC_PRE_NPC_MORPH = 1212, -- (EntityNPC NPC, EntityType EntityType, integer Variant, integer SubType, ChampionColor ChampionId): table{EntityType, Variant, SubType, ChampionId} | {EntityType, Variant, SubType} | boolean - Called before an NPC morphs. Accepts a table of parameters to change what entity they morph into, or `false` to cancel the morph.
    MC_PRE_PICKUP_MORPH = 1213, -- (EntityPickup Pickup, integer EntityType, integer Variant, integer SubType, boolean KeepPrice, boolean KeepSeed, boolean IgnoreModifiers): table{EntityType, Variant, SubType, KeepPrice, KeepSeed, IgnoreModifiers} | table{EntityType, Variant, SubType} | boolean - Called before a pickup is morphed. Accepts a table of parameters to change what pickup it morphs into, or `false` to cancel the morph.
    MC_POST_NPC_MORPH = 1214, -- (EntityNPC NPC, EntityType EntityType, integer Variant, integer SubType, ChampionColor ChampionId). Called after an NPC morphs, assuming it wasn't cancelled.
    MC_POST_PICKUP_MORPH = 1215, -- (EntityPickup Pickup, integer EntityType, integer Variant, integer SubType, boolean KeepPrice, boolean KeepSeed, boolean IgnoreModifiers). Called after a pickup morphs, assuming it wasn't cancelled.
    MC_PRE_COMPLETION_MARKS_RENDER = 1216, -- (Sprite CompletionMarksSprite, Vector RenderPos, Vector RenderScale, PlayerType PlayerType): boolean - Called before a character's completion marks are rendered on the character selection screen. Return `false` to prevent the completion marks from rendering.
    MC_POST_COMPLETION_MARKS_RENDER = 1217, -- (Sprite CompletionMarksSprite, Vector RenderPos, Vector RenderScale, PlayerType PlayerType) - Called before a character's completion marks are rendered on the character selection screen, assuming it wasn't skipped.
    MC_PRE_PAUSE_SCREEN_RENDER = 1218, -- (Sprite PauseBody, Sprite PauseStats): boolean - Called before the pause screen is rendered in-game. Return `false` to prevent the pause screen from rendering. Doing so will also prevent the screen from darkening.
    MC_POST_PAUSE_SCREEN_RENDER = 1219, -- (Sprite PauseBody, Sprite PauseStats): boolean - Called before the pause screen is rendered in-game, assuming it wasn't skipped.
    MC_PRE_USE_CARD = 1064, -- (Card CardID, EntityPlayer Player, integer UseFlag): boolean - Called before a card is used. Return `false` to cancel card use. This will still consume the card.
    MC_PRE_USE_PILL = 1065, -- (PillEffect PillEffectID, PillColor PillColorID, EntityPlayer Player, integer UseFlag): boolean - Called before a pill is used. Return `false` to cancel pill use. This will still consume the pill.
    MC_GET_SHOP_ITEM_PRICE = 1066, -- (integer PickupVariant, integer PickupSubType, integer ShopItemID, integer Price): PickupPrice | integer, Optional Arg: PickupVariant - Called after the price for a shop item was calculated. Return an integer or `PickupPrice` to change the price of the item.
    MC_PLAYER_GET_HEALTH_TYPE = 1067, -- (EntityPlayer Player): HealthType, Optional Arg: PlayerType - Called when getting the health type of the player. Return a `HealthType` to change the health type of the character.
    MC_PRE_ROOM_TRIGGER_CLEAR = 1068, -- (boolean PlaySound) - Called before a room is cleared.
    MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR = 1069, -- (EntityPlayer Player): boolean, Optional Arg: PlayerVariant. Called before all room clear-related effects for a player is triggered. This also accounts for challenge waves. Return `false` to cancel trigger effects.
    MC_PRE_FAMILIAR_RENDER = 1080, -- (EntityFamiliar Familiar, Vector Offset): Vector | boolean, Optional Arg: FamiliarVariant - Called before a familiar is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_NPC_RENDER = 1081, -- (EntityNPC NPC, Vector Offset): Vector | boolean, Optional Arg: EntityType - Called before an NPC is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_PLAYER_RENDER = 1082, -- (EntityPlayer Player, Vector Offset): Vector | boolean, Optional Arg: PlayerVariant - Called before a player is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_PICKUP_RENDER = 1083, -- (EntityPickup Pickup, Vector Offset): Vector | boolean, Optional Arg: PickupVariant - Called before a pickup is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_TEAR_RENDER = 1084, -- (EntityTear Tear, Vector Offset): Vector | boolean, Optional Arg: TearVariant - Called before a tear is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_PROJECTILE_RENDER = 1085, -- (EntityProjectile Projectile, Vector Offset): Vector | boolean, Optional Arg: ProjectileVariant - Called before a projectile is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_KNIFE_RENDER = 1086, -- (EntityKnife Knife, Vector Offset): Vector | boolean, Optional Arg: KnifeVariant - Called before a knife is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_EFFECT_RENDER = 1087, -- (EntityEffect Effect, Vector Offset): Vector | boolean, Optional Arg: EffectVariant - Called before an effect is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_BOMB_RENDER = 1088, -- (EntityBomb Bomb, Vector Offset): Vector | boolean, Optional Arg: BombVariant - Called before a bomb is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_SLOT_RENDER = 1089, -- (EntitySlot Slot, Vector Offset): Vector | boolean, Optional Arg: SlotVariant - Called before a slot is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_POST_SLOT_RENDER = 1090, -- (EntityFamiliar Familiar, Vector Offset): Vector | boolean, Optional Arg: FamiliarVariant - Called after a familiar is rendered, assuming it wasn't skipped.
    MC_PLAYER_GET_ACTIVE_MAX_CHARGE = 1072, -- (CollectibleType ItemID, EntityPlayerPlayer, integer VarData, integer CurrentMaxCharge): integer, Optional Arg: CollectibleType - Called when getting the active charge of an active item. Return an integer to override the max charge for the active item.
    MC_PLAYER_GET_ACTIVE_MIN_USABLE_CHARGE = 1073, -- (ActiveSlot Slot, EntityPlayer Player, integer CurrentMinUsableCharge): integer, Optional Arg: CollectibleType - Called when getting the minimum charge requirement for using an active item (seen in items such as Larynx). Return an integer to override the minimum charge to use the active item.
    MC_PLAYER_GET_HEART_LIMIT = 1074, -- (EnityPlayer Player, integer HeartLimit, boolean IsKeeper): integer, Optional Arg: PlayerType - Called when getting the max amount of hearts the player can have. Return an integer to override the heart limit (1 unit equals half a heart).
    MC_POST_ITEM_OVERLAY_UPDATE = 1075, -- Callback has no arguments. Optional Arg: Giantbook - Called after an item overlay updates.
    MC_PRE_ITEM_OVERLAY_SHOW = 1076, -- (Giantbook GiantBookID, integer Delay, EntityPlayer Player): Giantbook | boolean, Optional Arg: Giantbook - Called before an item overlay is shown. Return `Giantbook` to change what Giantbook is shown or `false` to cancel it.
    MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS = 1077, -- (EntityPlayer Player), Optional Arg: PlayerType - Called after a player's TemporaryEffects are reset after a new room.
    MC_POST_PLAYER_NEW_LEVEL = 1078, -- (EntityPlayer Player), Optional Arg: PlayerType - Called after entering a new level, but provides the player. Useful for player-specific effects on a new level.
    MC_POST_PLAYER_GET_MULTI_SHOT_PARAMS = 1251, -- (EntityPlayer Player): MultiShotParams, Optional Arg: PlayerType - Called after getting the player's MultiShotParams. Return a `MultiShotParams` object to change the properties of the players shooting behavior in regards to the MultiShotParams object properties.
    MC_PRE_REPLACE_SPRITESHEET = 1116, -- (integer LayerID, string PNGFilename): table{LayerID, PNGFilename}, Optional Arg: string ANM2Filename - Called before a Sprite object's spritesheet is replaced. Return a table of parameters to change what spritesheet is replaced.
    MC_POST_REPLACE_SPRITESHEET = 1117, -- (integer LayerID, string PNGFilename), Optional Arg: string ANM2Filename - Called after a Sprite object's spritesheet is replaced.
    MC_PRE_PLANETARIUM_APPLY_STAGE_PENALTY = 1110, -- Callback has no arguments. Start of planetarium calculation. Return `false` to bypass the normal planetarium stage penalty, such as when its at 0% for floors past Depths II/Womb II with Telescope Lens.
    MC_PRE_PLANETARIUM_APPLY_PLANETARIUM_PENALTY = 1111, -- (integer Chance): boolean - Called if on a valid stage and before applying the penalty for entering a Planetarium. Chance will be 1% (10% with Telescope Lens). Return `false` to bypass the penalty.
    MC_PRE_PLANETARIUM_APPLY_TREASURE_PENALTY = 1112, -- (integer TreasureRoomsVisited): boolean | integer - Called if no planetariums have been entered before and during calculation for applying the penalty for entering treasure rooms. Return `false` to bypass the penalty or an integer to modify how many treasure rooms the game believes have been entered. 
    MC_PRE_PLANETARIUM_APPLY_ITEMS = 1113, -- (float Chance): float - Called after checking the amount of treasure rooms entered and during calculation for applying additional planetarium chance from Crystal Ball, Magic 8 Ball, Sausage, and Telescope Lens' +15% planetarium chance. Return a float to modify the chance in this step of this calculation.
    MC_PRE_PLANETARIUM_APPLY_TELESCOPE_LENS = 1114, -- (float Chance): float - Called after checking all previous calculations steps and during calculation for applying Telescope Lens' +9% base planetarium chance. Return a float to modify the chance in this step of the calculation.
    MC_POST_PLANETARIUM_CALCULATE = 1115, -- (float Chance): float - Last step of planetarium chance calculation. Return a float to override the final chance.
    MC_POST_SLOT_INIT = 1121, -- (EntitySlot Slot), Optional Arg: SlotVariant - Called after a slot is initialized.
    MC_POST_SLOT_UPDATE = 1122, -- (EntitySlot Slot), Optional Arg: SlotVariant - Called after a slot is updated.
    MC_PRE_SLOT_CREATE_EXPLOSION_DROPS = 1123, -- (EntitySlot Slot), Optional Arg: SlotVariant - Called before a slot creates explosion drops, whether from exploding or having EntitySlot::CreateExplosionDrops() called. Return `false` to stop explosions from dropping the standard consumables.
    MC_POST_SLOT_CREATE_EXPLOSION_DROPS = 1124, -- (EntitySlot Slot), Optional Arg: SlotVariant - Called after a slot creates explosion drops, whether from exploding or having EntitySlot::CreateExplosionDrops() called, assuming it wasn't cancelled.
    MC_PRE_SLOT_SET_PRIZE_COLLECTIBLE = 1125, -- (EntitySlot Slot, CollectibleType ItemID): CollectibleType, Optional Arg: SlotVariant - Used by Shell Game, Hell Game, and Crane Game before determining the `CollectibleType` it gives on payout. Return a `CollectibleType` to override what the game will pay out with.
    MC_POST_SLOT_SET_PRIZE_COLLECTIBLE = 1126, -- (EntitySlot Slot, CollectibleType ItemID): CollectibleType, Optional Arg: SlotVariant - Used by Shell Game, Hell Game, and Crane Game for the `CollectibleType` is gives on payout.
    MC_PRE_DEVIL_APPLY_ITEMS = 1130, -- (): float - Start of devil deal calculation. Called before stage penalty and during calculation for most items that affect devil deal chance. Return a float to modify the chance in this step of the calculation.
    MC_PRE_DEVIL_APPLY_STAGE_PENALTY = 1131, -- (): boolean - Called during calculation for stage penalty. If a deal spawned anywhere on the previous two floors, the game decays the resulting chance by either 50% or 25% depending on how many deals have spawned. Return a boolean to bypass the stage penalty.
    MC_PRE_DEVIL_APPLY_SPECIAL_ITEMS = 1132, -- (): float - Called after stage penalty and during calculation for items like Goat Head and Eucharist. Return a float to modify the chance in this step of the calculation.
    MC_POST_DEVIL_CALCULATE = 1133, -- (integer Chance): float - Last step of devil deal chance calculation. Return a float to override the final chance.
    MC_COMPLETION_MARK_GET = 1047, -- (CompletionType Completion, PlayerType PlayerType): boolean, Optional Arg: PlayerType - Called when the player gets a completion mark. Return `false` to cancel the completion mark.
    MC_POST_COMPLETION_MARK_GET = 1048, -- (CompletionType Completion, PlayerType PlayerType), Optional Arg: PlayerType - Called when the player gets a completion mark, assuming it wasn't cancelled.
    MC_PRE_COMPLETION_EVENT = 1049, -- (CompletionType Completion): boolean | `CompletionType` - Triggers before a completion event gets triggered, such as when defeating a major boss or beating Boss Rush. Can return a new [CompletionType](CompletionType.md) or `false` to cancel the completion event. Canceling it will prevent all marks and completion event related stuff to trigger for all players.
    MC_POST_COMPLETION_EVENT = 1052, -- (CompletionType Completion): boolean - Triggers after a completion event gets triggered, such as when defeating a major boss or beating Boss Rush.
    MC_POST_PLAYERHUD_RENDER_ACTIVE_ITEM = 1079, -- (EntityPlayer Player, ActiveSlot Slot, Vector Offset, float Alpha, float Scale, Vector ChargeBarOffset) - Called after the player's active item is rendered.
    MC_POST_PLAYERHUD_RENDER_HEARTS = 1091, -- (Vector Offset(?), Sprite HeartsSprite, Vector Position, float Unknown, EntityPlayer Player) - Called after the player's hearts are rendered, both on the corners of the HUD and above Strawman-like players, assuming it wasn't skipped.
    MC_PRE_GET_LIGHTING_ALPHA = 1150, -- (float OriginalAlpha): float - Called when getting the alpha of the lighting in the room. Return a float to modify the lightning alpha. Generally this is between 0 and 1 but you can technically go higher than this.
    MC_PRE_RENDER_GRID_LIGHTING = 1151, -- (GridEntity GridEntity, Vector Offset) - Called before the the lighting of a grid entity is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_RENDER_ENTITY_LIGHTING = 1152, -- (Entity Entity, Vector Offset) - Called before the lighting of an entity is rendered. Return a Vector to modify render offset or `false` to cancel rendering.
    MC_PRE_PLAYER_APPLY_INNATE_COLLECTIBLE_NUM = 1092, -- (integer ModCount, EntityPlayer Player, CollectibleType Type, boolean OnlyCountTrueItems): integer - Called when getting the amount of innate items on the player. Return an integer to modify how many of a specific innate item the player has.
    MC_PRE_MUSIC_PLAY_JINGLE = 1094, -- (Music MusicID): Music | boolean, Optional Arg: Music - Called before a music jingle is played. Return `Music` to change the track or `false` to cancel the track.
    MC_POST_TRIGGER_COLLECTIBLE_REMOVED = 1095, -- (EntityPlayer Player, CollectibleType ItemID), Optional Arg: CollectibleType. Called after a collectible is removed from the player.
    MC_POST_TRIGGER_TRINKET_ADDED = 1096, -- (EntityPlayer Player, TrinketType TrinketID, boolean FirstTimePickingUp), Optional Arg: TrinketType. Called after a trinket is added to the player.
    MC_POST_TRIGGER_TRINKET_REMOVED = 1097, -- (EntityPlayer Player, TrinketType TrinketID), Optional Arg: TrinketType. Called after a trinket is removed from the player.
    MC_POST_TRIGGER_WEAPON_FIRED = 1098, -- (Vector FireDirection, integer FireAmount, Entity Owner, Weapon Weapon), Optional Arg: WeaponType - Called after a weapon is fired. A weapon can count as 'fired' while its continuously active, such as Brimstone.
    MC_POST_LEVEL_LAYOUT_GENERATED = 1099, -- (LevelGenerator LevelGen) - Called after the layout of a level is generated.
    MC_POST_NIGHTMARE_SCENE_RENDER = 1102, -- Callback has no arguments. Called after the nightmare scene transition between floors or during the interaction with Mom's Bed in Home is rendered.
    MC_POST_NIGHTMARE_SCENE_SHOW = 1103, -- (boolean IsDogmaNightmare) - Called after triggering the nightmare scene transition between floors or during the interaction with Mom's Bed in Home.
    MC_PRE_LEVEL_SELECT = 1104, -- (LevelStage Level, StageType Type): table{Level, Type} - Called when the game selects which level (also known as stage) to load, usually when the player enters a trapdoor. Return a table of parameters to change what level is loaded.
    MC_POST_WEAPON_FIRE = 1105, -- (Weapon Weapon, Vector FireDirection, boolean IsShooting, boolean IsInterpolated), Optional Arg: WeaponType - Called after every weapon update, whether the Weapon owner is actually firing or not.
    MC_PRE_BACKDROP_RENDER_WALLS = 1106, -- (ColorModifier ColorModifier) - Called the backdrop's walls are rendered.
    MC_PRE_BACKDROP_CHANGE = 1141, -- (BackdropType Type) - Accepts an integer to change BackdropType.
    MC_PRE_BACKDROP_RENDER_FLOOR = 1107, -- (ColorModifier ColorModifier) - Called before the backdrop's floor is rendered.
    MC_PRE_BACKDROP_RENDER_WATER = 1108, -- Callback has no arguments. Called before water over the floor is rendered.
    MC_POST_BACKDROP_PRE_RENDER_WALLS = 1109, -- (ColorModifier ColorModifier) - Called after the backdrop's walls are rendered.
    MC_PRE_PLAYER_USE_BOMB = 1220, -- (EntityPlayer Player): boolean, Optional Arg: PlayerVariant - Called before the player uses a bomb. Return `false` to stop the player from using a bomb. This will still consume the bomb.
    MC_POST_PLAYER_USE_BOMB = 1221, -- (EntityPlayer Player): boolean, Optional Arg: PlayerVariant - Called after the player uses a bomb, assuming it hasn't been cancelled.
    MC_NPC_PICK_TARGET = 1222, -- (EntityNPC NPC, Entity CurrentTarget): Entity, Optional Arg: EntityType - Called whenever an EntityNPC selects its target, such as when EntityNPC:GetPlayerTarget() is called.
    MC_POST_PLAYER_COLLISION = 1231, -- (EntityPlayer Player, Entity Collider, boolean Low), Optional Arg: PlayerVariant - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_POST_TEAR_COLLISION = 1233, -- (EntityTear Tear, Entity Collider, boolean Low), Optional Arg: TearVariant - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_POST_FAMILIAR_COLLISION = 1235, -- (EntityFamiliar Familiar, Entity Collider, boolean Low), Optional Arg: FamiliarVariant - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_POST_BOMB_COLLISION = 1237, -- (EntityBomb Bomb, Entity Collider, boolean Low), Optional Arg: BombVariant - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_POST_PICKUP_COLLISION = 1239, -- (EntityPickup Pickup, Entity Collider, boolean Low), Optional Arg: PickupVariant - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_PRE_SLOT_COLLISION = 1240, -- (EntitySlot, Entity Collider, boolean Low): boolean, Optional Arg: SlotVariant  - Return a boolean to ignore collision code (`true` to respond to collision, `false` to not), or nil to continue the internal code.
    MC_POST_SLOT_COLLISION = 1241, -- (EntitySlot Slot, Entity Collider, boolean Low), Optional Arg: SlotVariant - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_POST_KNIFE_COLLISION = 1243, -- (EntityKnife Knife, Entity Collider, boolean Low), Optional Arg: KnifeSubType - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_POST_PROJECTILE_COLLISION = 1245, -- (EntityProjectile Projectile, Entity Collider, boolean Low), Optional Arg: ProjectileVariant - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_POST_NPC_COLLISION = 1247, -- (EntityNPC NPC, Entity Collider, boolean Low), Optional Arg: EntityType - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_PRE_LASER_COLLISION = 1248, -- (EntityLaser Laser, Entity Collider, boolean Low): boolean, Optional Arg: LaserVariant - Runs after the on-collision code of this entity. Return `true` to ignore the collision
    MC_POST_LASER_COLLISION = 1249, -- (EntityLaser Laser, Entity Collider, boolean Low), Optional Arg: LaserVariant - Runs after the on-collision code of this entity, assuming it wasn't skipped.
    MC_CONSOLE_AUTOCOMPLETE = 1120, -- (string Command, string Params): table, Optional Arg: string Command - Called whenever a function with the CUSTOM AutocompleteType enum is being entered into the console. Called every time the console input changes.
    MC_PLAYER_INIT_PRE_LEVEL_INIT_STATS = 1127, -- (EntityPlayer Player), Optional Arg: PlayerType. Called before a player is initialized for the first time, being when starting the run, joining the game as a co-op player, or when activating Genesis.
    MC_PRE_NEW_ROOM = 1200, -- (Room Room, RoomDescriptor Descriptor) - Called before entering a new room.
    MC_PRE_MEGA_SATAN_ENDING = 1201, -- (): boolean - Called right before Mega Satan forcibly ends the game. Return `true` to suppress the ending, guaranteeing a portal to the Void while retaining the completion mark for active characters.
    MC_POST_MODS_LOADED = 1210, -- Callback has no arguments. Called after all Lua scripts have been loaded. Ideal for running code that is expected to run after all mods are initialized, but without the need for load order idiocy!
    MC_POST_ITEM_OVERLAY_SHOW = 1134, -- (Giantbook GiantBookID, integer Delay, EntityPlayer Player), Optional Arg: Giantbook - Called after an item overlay is shown, assuming it wasn't cancelled.
    MC_PRE_RENDER = 1135, -- Callback has no arguments. Gets called right before the Manager::Render() function gets called.
    MC_PRE_OPENGL_RENDER = 1136, -- (VertexBuffer VertexBuffer, integer ShaderID, RenderContext Unknown): Unknown - Gets called right before the Manager::Render() function gets called.
    MC_PRE_LEVEL_PLACE_ROOM = 1137, -- (LevelGeneratorRoom Slot, RoomConfigRoom RoomConfig, integer Seed): RoomConfigRoom - Called before a room is placed during level generation. Return `RoomConfigRoom` to change the room being placed.
    MC_PRE_M_MORPH_ACTIVE = 1190, -- (EntityPlayer Player, CollectibleType ItemID): CollectibleType | boolean - Called before an active gets rerolled by 'M (trinket id 138). Return `CollectibleType` to change the CollectibleType it rerolls into or `false` to prevent the active from being rerolled entirely.
    MC_PRE_NPC_SPLIT = 1191, -- (EntityNPC NPC, boolean IsBlacklisted), Optional Arg: EntityType - Called when the game is about to decide whether or not an EntityNPC can be split, i.e. the Meat Cleaver effect. Return `true` to prevent the split, `false` to allow it even if blacklisted, or `nil` to continue default behavior.
    MC_PICKUP_GET_COIN_VALUE = 1250, -- (EntityPickup Pickup): integer, Optional Arg: CoinSubType - Called when getting the coin value of a coin pickup. Return an integer to modify the amount of coins the coin can give you on pickup.
    MC_POST_FAMILIAR_FIRE_PROJECTILE = 1252, -- (EntityTear Tear), Optional Arg: FamiliarVariant - Called when a familiar fires a tear. (Is this just for Weapon familiars or all familiars??)
    MC_POST_FIRE_BOMB = 1253, -- (EntityBomb Bomb) - Called when the player fires a Dr. Fetus bomb.
    MC_POST_FIRE_BONE_CLUB = 1254, -- (EntityKnife Knife) - Called when the player fired The Forgotten's bone club. This is only called when the club is initially spawned, not when swung or charged and shot.
    MC_POST_FIRE_BRIMSTONE = 1255, -- (EntityLaser Laser) - Called when the player fires a brimstone laser. This is also called for delayed Brimstone.
    MC_POST_FIRE_BRIMSTONE_BALL = 1256, -- (EntityEffect Effect) - Called when the player fires a brimstone ball.
    MC_POST_FIRE_KNIFE = 1257, -- (EntityKnife Knife) - Called when the player fires the knife from Mom's Knife. This is only called when the knife is initially spawned, not when charged and shot.
    MC_POST_FIRE_SWORD = 1258, -- (EntityKnife Knife) - Called when the player swings the sword from Spirit Sword. This is not called for the sword's charged swing.
    MC_POST_FIRE_TECH_LASER = 1259, -- (EntityLaser Laser) - Called when the player fires a Tech laser.
    MC_POST_FIRE_TECH_X_LASER = 1260, -- (EntityLaser Laser) - Called when the player fires a Tech X laser.
    MC_POST_FAMILIAR_FIRE_BRIMSTONE = 1261, -- (EntityLaser Laser), Optional Arg: FamiliarVariant - Called when a familiar fires a brimstone laser.
    MC_POST_FAMILIAR_FIRE_TECH_LASER = 1262, -- (EntityLaser Laser), Optional Arg: FamiliarVariant - Called when a familiar fires a Tech laser.
    MC_IS_PERSISTENT_ROOM_ENTITY = 1263, -- (EntityType Type, int Variant): boolean - Return `true` to allow the entity to respawn when moving out and back into the room it was located in.
    MC_PRE_PLAYERHUD_TRINKET_RENDER = 1264, -- (integer Slot, Vector Position, float Scale, EntityPlayer Player, Vector CropOffset): table{Position, Scale, CropOffset} | boolean, Optional Arg: integer - Called before the player's trinket on the HUD is rendered. Return a table with any combination of its parameters to override those respective fields or `true` to cancel rendering.
    MC_MENU_INPUT_ACTION = 1464, -- (Entity Entity, InputHook InputHook, ButtonAction ButtonAction): boolean | float, Optional Arg: InputHook - Same as MC_INPUT_ACTION, but only works in the main menu.
    MC_POST_SAVESLOT_LOAD = 1465, -- (integer SaveSlot, boolean IsSaveSlotSelected, integer RawSlot) - This is called whenever a save slot is loaded by the game. 
    MC_PRE_PICKUP_VOIDED = 1265, -- (EntityPickup Pickup, boolean IsBlackRune): boolean, Optional Arg: PickupVariant - Called when a pickup is consumed with the Void active or Black Rune. The IsBlackRune parameter indicates the source. If Black Rune is used, the callback gets fired both for pedestal items and for small pickups that turn into flies. Return `false` to cancel the pickup getting consumed.
    MC_PRE_PICKUP_VOIDED_ABYSS = 1266, -- (EntityPickup Pickup): boolean, Optional Arg: PickupVariant - Called when a pickup is consumed with the Abyss active. Return `false` to cancel the pickup getting consumed.
    MC_PRE_PICKUP_COMPOSTED = 1267, -- (EntityPickup Pickup) - Called when a pickup is consumed with the Compost active. Return `false` to cancel the pickup getting consumed.
    MC_PRE_GRID_ENTITY_DECORATION_UPDATE = 1400, -- (GridEntityDecoration Decoration): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_DECORATION_UPDATE = 1401, -- (GridEntityDecoration Decoration), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_DOOR_UPDATE = 1402, -- (GridEntityDoor Door): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_DOOR_UPDATE = 1403, -- (GridEntityDoor Door), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_FIRE_UPDATE = 1404, -- (GridEntityFire Fire): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_FIRE_UPDATE = 1405, -- (GridEntityFire Fire), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_GRAVITY_UPDATE = 1406, -- (GridEntityGravity Gravity): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_GRAVITY_UPDATE = 1407, -- (GridEntityGravity Gravity), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_LOCK_UPDATE = 1408, -- (GridEntityLock Lock): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_LOCK_UPDATE = 1409, -- (GridEntityLock Lock), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_PIT_UPDATE = 1410, -- (GridEntityPit Pit): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_PIT_UPDATE = 1411, -- (GridEntityPit Pit), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_POOP_UPDATE = 1412, -- (GridEntityPoop Poop): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_POOP_UPDATE = 1413, -- (GridEntityPoop Poop), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_PRESSUREPLATE_UPDATE = 1414, -- (GridEntityPressurePlate PressurePlate): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_PRESSUREPLATE_UPDATE = 1415, -- (GridEntityPressurePlate PressurePlate), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_ROCK_UPDATE = 1416, -- (GridEntityRock Rock): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_ROCK_UPDATE = 1417, -- (GridEntityRock Rock), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_SPIKES_UPDATE = 1418, -- (GridEntitySpikes Spikes): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_SPIKES_UPDATE = 1419, -- (GridEntitySpikes Spikes), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_STAIRCASE_UPDATE = 1420, -- (GridEntityStaircase Staircase): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_STAIRCASE_UPDATE = 1421, -- (GridEntityStaircase Staircase), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_STATUE_UPDATE = 1422, -- (GridEntityStatue Statue): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_STATUE_UPDATE = 1423, -- (GridEntityStatue Statue), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_TELEPORTER_UPDATE = 1424, -- (GridEntityTeleporter Teleporter): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_TELEPORTER_UPDATE = 1425, -- (GridEntityTeleporter Teleporter), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_TRAPDOOR_UPDATE = 1426, -- (GridEntityTrapdoor Trapdoor): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_TRAPDOOR_UPDATE = 1427, -- (GridEntityTrapdoor Trapdoor), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_WEB_UPDATE = 1428, -- (GridEntityWeb Web): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_WEB_UPDATE = 1429, -- (GridEntityWeb Web), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_TNT_UPDATE = 1430, -- (GridEntityTNT TNT): boolean, Optional Arg: GridEntityType - Called before this grid entity is updated. Return `false` to cancel the update.
    MC_POST_GRID_ENTITY_TNT_UPDATE = 1431, -- (GridEntityTNT TNT), Optional Arg: GridEntityType - Called after this grid entity is updated, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_SPIKES_RENDER = 1432, -- (GridEntitySpikes Spikes, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_SPIKES_RENDER = 1433, -- (GridEntitySpikes Spikes, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_WEB_RENDER = 1434, -- (GridEntityWeb Web, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_WEB_RENDER = 1435, -- (GridEntityWeb Web, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_TNT_RENDER = 1436, -- (GridEntityTNT TNT, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_TNT_RENDER = 1437, -- (GridEntityTNT TNT, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_TRAPDOOR_RENDER = 1438, -- (GridEntityTrapdoor Trapdoor, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_TRAPDOOR_RENDER = 1439, -- (GridEntityTrapdoor Trapdoor, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_STAIRCASE_RENDER = 1440, -- (GridEntityStaircase Staircase, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_STAIRCASE_RENDER = 1441, -- (GridEntityStaircase Staircase, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_DECORATION_RENDER = 1444, -- (GridEntityDecoration Decoration, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_DECORATION_RENDER = 1445, -- (GridEntityDecoration Decoration, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_DOOR_RENDER = 1446, -- (GridEntityDoor Door, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_DOOR_RENDER = 1447, -- (GridEntityDoor Door, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_FIRE_RENDER = 1448, -- (GridEntityFire Fire, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_FIRE_RENDER = 1449, -- (GridEntityFire Fire, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_LOCK_RENDER = 1450, -- (GridEntityLock Lock, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_LOCK_RENDER = 1451, -- (GridEntityLock Lock, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_TELEPORTER_RENDER = 1452, -- (GridEntityTeleporter Teleporter, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_TELEPORTER_RENDER = 1453, -- (GridEntityTeleporter Teleporter, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_PIT_RENDER = 1454, -- (GridEntityPit Pit, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_PIT_RENDER = 1455, -- (GridEntityPit Pit, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_POOP_RENDER = 1456, -- (GridEntityPoop Poop, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_POOP_RENDER = 1457, -- (GridEntityPoop Poop, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_ROCK_RENDER = 1458, -- (GridEntityRock Rock, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_ROCK_RENDER = 1459, -- (GridEntityRock Rock, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_PRESSUREPLATE_RENDER = 1460, -- (GridEntityPressurePlate PressurePlate, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_PRESSUREPLATE_RENDER = 1461, -- (GridEntityPressurePlate PressurePlate, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_PRE_GRID_ENTITY_WALL_RENDER = 1462, -- (GridEntityWall Wall, Vector Offset): Vector | boolean, Optional Arg: GridEntityType - Called before this grid entity is rendered. Return `false` to cancel the render.
    MC_POST_GRID_ENTITY_WALL_RENDER = 1463, -- (GridEntityWall Wall, Vector Offset), Optional Arg: GridEntityType - Called after this grid entity is rendered, assuming it wasn't skipped.
    MC_POST_NPC_DARK_RED_CHAMPION_REGEN = 1223, -- (EntityNPC NPC) - Runs right after a dark red champion regenerates out of the goo form.
    MC_POST_ACHIEVEMENT_UNLOCK = 1476, -- (AchievementID Achievement), Optional Arg: Achievement - Called after an achievement is unlocked.
    MC_PRE_MINIMAP_UPDATE = 1477, -- Callback has no arguments. Called right before the minimap is updated
    MC_POST_MINIMAP_UPDATE = 1478, -- Callback has no arguments. Called right after the minimap is updated
    MC_PRE_MINIMAP_RENDER = 1479, -- Callback has no arguments. Called right before the minimap is rendered
    MC_POST_MINIMAP_RENDER = 1480, -- Callback has no arguments. Called right after the minimap is rendered
    MC_PRE_PICKUP_GET_LOOT_LIST = 1333, -- (EntityPickup Pickup, boolean ShouldAdvance): LootList - Called before the pickup determines its loot content. Return `LootList` to change loot content.
    MC_PRE_PICKUP_UPDATE_GHOST_PICKUPS = 1334, -- (EntityPickup Pickup) - Called before a ghost pickup of the loot content is applied to the pickup. Return `true` to apply pickup ghost to your pickup entity, `false` to cancel it.
    MC_POST_PLAYER_TRIGGER_EFFECT_REMOVED = 1268, -- (EntityPlayer Player, ItemConfigItem ItemConfigItem) - Called after the player's `ItemConfigItem` TemporaryEffect is removed
    MC_POST_ROOM_TRIGGER_EFFECT_REMOVED = 1269, -- (ItemConfigItem ItemConfigItem) - Called after the room's `TemporaryEffects` is removed. Room has its own `TemporaryEffects` that are accessed through `Room::GetEffects()`
    MC_PRE_PLAYER_GRID_COLLISION = 1171, -- (EntityPlayer Player, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: PlayerVariant - Called before this entity collides with a GridEntity or other solid grid tile. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PLAYER_GRID_COLLISION = 1172, -- (EntityPlayer Player, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: PlayerVariant - Called when this entity collides with a `GridEntity`, assuming it wasn't skipped. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PRE_TEAR_GRID_COLLISION = 1173, -- (EntityTear Tear, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: TearVariant - Called before this entity collides with a GridEntity or other solid grid tile. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_TEAR_GRID_COLLISION = 1174, -- (EntityTear Tear, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: TearVariant - Called when this entity collides with a `GridEntity`, assuming it wasn't skipped. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PRE_FAMILIAR_GRID_COLLISION = 1175, -- (EntityFamiliar Familiar, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: FamiliarVariant - Called before this entity collides with a GridEntity or other solid grid tile. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_FAMILIAR_GRID_COLLISION = 1176, -- (EntityFamiliar Familiar, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: FamiliarVariant - Called when this entity collides with a `GridEntity`, assuming it wasn't skipped. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PRE_BOMB_GRID_COLLISION = 1177, -- (EntityBomb Bomb, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: BombVariant - Called before this entity collides with a GridEntity or other solid grid tile. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_BOMB_GRID_COLLISION = 1178, -- (EntityBomb Bomb, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: BombVariant - Called when this entity collides with a `GridEntity`, assuming it wasn't skipped. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PRE_PICKUP_GRID_COLLISION = 1179, -- (EntityPickup Pickup, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: PickupVariant - Called before this entity collides with a GridEntity or other solid grid tile. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PICKUP_GRID_COLLISION = 1180, -- (EntityPickup Pickup, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: PickupVariant - Called when this entity collides with a `GridEntity`, assuming it wasn't skipped. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PRE_PROJECTILE_GRID_COLLISION = 1181, -- (EntityProjectile Projectile, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: ProjectileVariant - Called before this entity collides with a GridEntity or other solid grid tile. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PROJECTILE_GRID_COLLISION = 1182, -- (EntityProjectile Projectile, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: ProjectileVariant - Called when this entity collides with a `GridEntity`, assuming it wasn't skipped. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PRE_NPC_GRID_COLLISION = 1183, -- (EntityNPC NPC, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: EntityType - Called before this entity collides with a GridEntity or other solid grid tile. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_NPC_GRID_COLLISION = 1184, -- (EntityNPC NPC, integer GridIndex, GridEntity | nil GridEntity): boolean, Optional Arg: EntityType - Called when this entity collides with a `GridEntity`, assuming it wasn't skipped. `GridEntity` can be nil, as entities may collide with "empty" grid indexes if the GridPath value is >= 1000. Return `true` to ignore collision
    MC_PRE_PLAYERHUD_RENDER_HEARTS = 1118, -- (Vector Offset(?), Sprite HeartsSprite, Vector Position, float Unknown, EntityPlayer Player): boolean - Called before the player's hearts are rendered, both on the corners of the HUD and above Strawman-like players. Return `true` to cancel hearts HUD rendering.
    MC_PRE_PLAYERHUD_RENDER_ACTIVE_ITEM = 1119, -- (EntityPlayer Player, ActiveSlot Slot, Vector Offset, float Alpha, float Scale, Vector ChargeBarOffset) - Called before the player's active item is rendered. Return `true` to cancel rendering.
    MC_PRE_PLAYER_REVIVE = 1481, -- (EntityPlayer Player) - Called before the player revives. Return `false` to prevent the player from reviving.
    MC_POST_PLAYER_REVIVE = 1482, -- (EntityPlayer Player) - Called after the player revives, assuming it wasn't cancelled.
    MC_POST_PROJECTILE_DEATH = 1032, -- (EntityProjectile Projectile), Optional Arg: ProjectileVariant - Called after the projectile dies.
    MC_POST_TEAR_DEATH = 1032, -- (EntityTear Tear), Optional Arg: TearVariant - Called after the tear dies.
    MC_POST_BOSS_INTRO_SHOW = 1270, -- (BossType BossID1, BossType BossID2) - Called right after the boss intro is initialized. `BossID2` is for Double Trouble.
    MC_POST_ROOM_TRANSITION_UPDATE = 1271, -- Callback has no arguments. Called on an update frame during the boss intro.
    MC_POST_ROOM_TRANSITION_RENDER = 1272, -- Callback has no arguments. Called on a render frame during the boss intro.
    MC_PRE_PLAYER_UPDATE = 1160, -- (EntityPlayer Player), Optional Arg: PlayerVariant - Called before the player is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_PRE_TEAR_UPDATE = 1161, -- (EntityTear Tear), Optional Arg: TearVariant - Called before the tear is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_PRE_FAMILIAR_UPDATE = 1162, -- (EntityFamiliar Familiar), Optional Arg: FamiliarVariant - Called before the familiar is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_PRE_BOMB_UPDATE = 1163, -- (EntityBomb Bomb), Optional Arg: BombVariant - Called before the bomb is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_PRE_PICKUP_UPDATE = 1164, -- (EntityPickup Pickup), Optional Arg: PickupVariant - Called before the pickup is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_PRE_KNIFE_UPDATE = 1165, -- (EntityKnife Knife), Optional Arg: KnifeSubType - Called before the knife is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_PRE_PROJECTILE_UPDATE = 1166, -- (EntityProjectile Projectile), Optional Arg: ProjectileVariant - Called before the projectile is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_PRE_LASER_UPDATE = 1167, -- (EntityLaser Laser), Optional Arg: LaserVariant - Called before the laser is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_PRE_EFFECT_UPDATE = 1168, -- (EntityEffect Effect), Optional Arg: EffectVariant - Called before the effect is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_PRE_SLOT_UPDATE = 1169, -- (EntitySlot Slot), Optional Arg: SlotVariant - Called before the slot is updated. Return `true` if the internal AI should be ignored, `false` or `nil`/nothing otherwise.
    MC_TRIGGER_PLAYER_DEATH_POST_CHECK_REVIVES = 1051, -- (EntityPlayer Player) - Called upon player death after the game is done checking for vanilla revives. Return `false` to cancel the death, reviving the player in-place with half a heart, or `true`/`nil`/nothing to allow the death to go through.
    MC_PRE_FORTUNE_DISPLAY = 1483, -- Callback has no arguments. Called before a fortune is displayed. Return false to cancel it.
    MC_PRE_ITEM_TEXT_DISPLAY = 1484, -- (string Title, string Subtitle, boolean IsSticky, boolean IsCurseDisplay): boolean - Called before an item text is displayed. `IsSticky` is `true` is if the item text stays on screen for an indefinite amount of time, namely when holding down the map key. `IsCurseDisplay` is `true` if the text is for displaying a curse. Return `false` to cancel showing the item text.
    MC_PRE_GET_RANDOM_ROOM_INDEX = 1290, -- (integer RoomIndex, bool IAmErrorRoom, integer Seed): integer - Called when the game wishes to get a random available room index on the floor. Return an integer to override the target room index.
    MC_POST_GLOWING_HOURGLASS_SAVE = 1300, -- (integer Slot) - Called after the Glowing Hourglass state is saved.
    MC_POST_GLOWING_HOURGLASS_LOAD = 1301, -- (integer Slot) - Called after the Glowing Hourglass state is loaded.
    MC_PRE_GLOWING_HOURGLASS_SAVE = 1302, -- (integer Slot) - Called before the Glowing Hourglass state is saved.
    MC_PRE_GLOWING_HOURGLASS_LOAD = 1303, -- (integer Slot) - Called before the Glowing Hourglass state is loaded
    MC_PRE_PLAYER_ADD_CARD = 1350, -- (EntityPlayer Player, Card CardID, PillCardSlot Slot): boolean | int, Optional Arg: Card - Called before a card gets added to the player's inventory. Return `Card` to change the card being added or `false` to cancel adding it entirely.
    MC_POST_PLAYER_ADD_CARD = 1351, -- (EntityPlayer Player, Card CardID, PillCardSlot Slot), Optional Arg: Card - Called after a card gets added to the player's inventory.
    MC_PRE_PLAYER_ADD_PILL = 1352, -- (EntityPlayer Player, PillColor PillColor, PillCardSlot Slot): boolean | int, Optional Arg: PillColor - Called before a pill gets added to the player's inventory. Return `PillColor` to change the pill being added or `false` to cancel adding it entirely.
    MC_POST_PLAYER_ADD_PILL = 1353, -- (EntityPlayer Player, PillColor PillColor, PillCardSlot Slot), Optional Arg: PillColor - Called after a pill gets added to the player's inventory.
    MC_POST_PLAYER_REMOVE_CARD = 1354, -- (EntityPlayer Player, Card CardID, PillCardSlot Slot), Optional Arg: Card - Called after a card gets removed from the player's inventory by any means (dropped, direct removal, use, etc).
    MC_POST_PLAYER_REMOVE_PILL = 1355, -- (EntityPlayer Player, PillColor PillColor, PillCardSlot Slot), Optional Arg: PillColor - Called after a pill gets removed from the player's inventory by any means (dropped, direct removal, use, etc).
    MC_PRE_PLAYER_COLLECT_CARD = 1356, -- (EntityPlayer Player, EntityPickup Pickup): boolean, Optional Arg: Card - Called before a player picks up a card off the ground. Return `false` to prevent the card from being picked up.
    MC_POST_PLAYER_COLLECT_CARD = 1357, -- (EntityPlayer Player, EntityPickup Pickup), Optional Arg: Card - Called after a player picks up a card off the ground.
    MC_PRE_PLAYER_COLLECT_PILL = 1358, -- (EntityPlayer Player, EntityPickup Pickup): boolean, Optional Arg: PillColor - Called before a player picks up a pill off the ground. Return `false` to prevent the pill from being picked up.
    MC_POST_PLAYER_COLLECT_PILL = 1359, -- (EntityPlayer Player, EntityPickup Pickup), Optional Arg: PillColor - Called after a player picks up a pill off the ground.
    MC_POST_PLAYER_DROP_CARD = 1360, -- (EntityPlayer Player, EntityPickup Pickup, PillCardSlot Slot), Optional Arg: Card - Called after a player drops a card onto the ground from their inventory.
    MC_POST_PLAYER_DROP_PILL = 1361, -- (EntityPlayer Player, EntityPickup Pickup, PillCardSlot Slot), Optional Arg: PillColor - Called after a player drops a pill onto the ground from their inventory.
    MC_PRE_CHALLENGE_DONE = 1471, -- (Challenge ChallengeID, EntityPlayer Player): boolean, Optional Arg: Challenge - Called before a challenge is marked as completed. Return `false` to prevent further execution of the challenge completion-tracking function.
    MC_POST_CHALLENGE_DONE = 1472, -- (Challenge ChallengeID), Optional Arg: Challenge - Called after a challenge is marked as completed.
    MC_PRE_PLAYER_GIVE_BIRTH_CAMBION = 1474, -- (EntityPlayer Player, ConceptionFamiliarFlag Flag): boolean, Optional Arg: ConceptionFamiliarFlag - Called before the player gives birth to a familiar through the Cambion Conception collectible. Return `false` to cancel adding the familiar.
    MC_PRE_PLAYER_GIVE_BIRTH_IMMACULATE = 1475, -- (EntityPlayer Player, ConceptionFamiliarFlag Flag): boolean, Optional Arg: ConceptionFamiliarFlag - Called before the player gives birth to a familiar through the Immaculate Conception collectible. Return `false` to cancel adding the familiar.
    MC_PRE_PLAYER_ADD_COSTUME = 1281, -- (ItemConfigItem itemConfig, EntityPlayer Player, boolean ItemStateOnly): ItemConfigItem | boolean - Called before the costume is added to the player. Return `ItemConfigItem` to replace the costume or `true` to cancel adding it entirely.
    MC_PRE_PLAYER_REMOVE_COSTUME = 1282, -- (ItemConfigItem itemConfig, EntityPlayer Player): boolean - Called before the costume is removed from the player. Return `true` to cancel the removal.
    MC_POST_PLAYER_ADD_COSTUME = 1283, -- (ItemConfigItem itemConfig, EntityPlayer Player, boolean ItemStateOnly) - Called after the costume is added to the player, assuming it wasn't skipped.
    MC_POST_PLAYER_REMOVE_COSTUME = 1284, -- (ItemConfigItem itemConfig, EntityPlayer Player): boolean - Called after the costume is removed from the player, assuming it wasn't skipped.
    MC_POST_FORCE_PILL_EFFECT = 1129, -- (PillEffect PillEffectID, PillColor PillColorID) - TODO: Document me!
    MC_EVALUATE_CUSTOM_CACHE = 1224, -- (EntityPlayer Player, CustomCacheTag string, float Value): float, Optional Arg: CustomCacheTag - Called when a custom cache tag is evaluated. Return a number to modify the value. Modified values are passed onto the next callback.
    MC_EVALUATE_FAMILIAR_MULTIPLIER = 1225, -- (EntityFamiliar Familiar, float Mult, EntityPlayer Player): float, Optional Arg: FamiliarVariant. Called when a familiar's cached multiplier needs to be re-evaluated. Return a number to modify the multiplier. Modified values are passed to the next callback.
}
---@enum CallbackPriority
CallbackPriority = {
    IMPORTANT = -200,
    EARLY = -100,
    DEFAULT = 0,
    LATE = 100,
}
---@enum EntityType
EntityType = {
    ENTITY_NULL = 0,
    ENTITY_PLAYER = 1, -- 1 player
    ENTITY_TEAR = 2, -- 2 tear projectile
    ENTITY_FAMILIAR = 3, -- 3 familiar
    ENTITY_BOMB = 4, -- 4 bomb drop
    ENTITY_PICKUP = 5, -- 5 pickup item
    ENTITY_SLOT = 6, -- 6 slot machine
    ENTITY_LASER = 7, -- 7 laser beam
    ENTITY_KNIFE = 8, -- 8 mom's knife
    ENTITY_PROJECTILE = 9, -- 9 blood projectile
    ENTITY_GAPER = 10, -- 10 enemy: Gaper
    ENTITY_GUSHER = 11, -- 11 enemy: Gusher
    ENTITY_HORF = 12, -- 12 enemy: Horf
    ENTITY_FLY = 13, -- 13 enemy: Fly
    ENTITY_POOTER = 14, -- 14 enemy: Pooter
    ENTITY_CLOTTY = 15, -- 15 enemy: Clotty
    ENTITY_MULLIGAN = 16, -- 16 enemy: Mulligan
    ENTITY_SHOPKEEPER = 17,
    ENTITY_ATTACKFLY = 18, -- 18 enemy: Attack Fly
    ENTITY_LARRYJR = 19, -- 19 boss: Larry Jr./Hollow
    ENTITY_MONSTRO = 20, -- 20 boss: Monstro
    ENTITY_MAGGOT = 21,
    ENTITY_HIVE = 22,
    ENTITY_CHARGER = 23,
    ENTITY_GLOBIN = 24,
    ENTITY_BOOMFLY = 25,
    ENTITY_MAW = 26,
    ENTITY_HOST = 27,
    ENTITY_CHUB = 28,
    ENTITY_HOPPER = 29, -- 29 enemy: Hopper
    ENTITY_BOIL = 30, -- 30 enemy: Boil, variants: 1 - Gut, 2 - Sack
    ENTITY_SPITTY = 31,
    ENTITY_BRAIN = 32,
    ENTITY_FIREPLACE = 33,
    ENTITY_LEAPER = 34,
    ENTITY_MRMAW = 35,
    ENTITY_GURDY = 36,
    ENTITY_BABY = 38,
    ENTITY_VIS = 39,
    ENTITY_GUTS = 40,
    ENTITY_KNIGHT = 41,
    ENTITY_STONEHEAD = 42,
    ENTITY_MONSTRO2 = 43,
    ENTITY_POKY = 44,
    ENTITY_MOM = 45,
    ENTITY_SLOTH = 46, -- 46 miniboss: Sloth
    ENTITY_LUST = 47, -- 47 miniboss: Lust
    ENTITY_WRATH = 48, -- 48 miniboss: Wrath
    ENTITY_GLUTTONY = 49, -- 49 miniboss: Gluttony
    ENTITY_GREED = 50, -- 50 miniboss: Greed
    ENTITY_ENVY = 51, -- 51 miniboss: Envy
    ENTITY_PRIDE = 52, -- 52 miniboss: Pride
    ENTITY_DOPLE = 53,
    ENTITY_FLAMINGHOPPER = 54, -- 54 enemy: Flaming Hopper
    ENTITY_LEECH = 55,
    ENTITY_LUMP = 56,
    ENTITY_MEMBRAIN = 57, -- 57 enemy: Membrain and Mama Guts
    ENTITY_PARA_BITE = 58,
    ENTITY_FRED = 59,
    ENTITY_EYE = 60,
    ENTITY_SUCKER = 61, -- 61 enemy: Sucker
    ENTITY_PIN = 62, -- 62 boss: Pin
    ENTITY_FAMINE = 63,
    ENTITY_PESTILENCE = 64,
    ENTITY_WAR = 65, -- variant 1: Conquest
    ENTITY_DEATH = 66,
    ENTITY_DUKE = 67, -- 67 boss: Duke of Flies/Husk
    ENTITY_PEEP = 68,
    ENTITY_LOKI = 69,
    ENTITY_FISTULA_BIG = 71,
    ENTITY_FISTULA_MEDIUM = 72,
    ENTITY_FISTULA_SMALL = 73,
    ENTITY_BLASTOCYST_BIG = 74, -- 74 boss: Blastocyst
    ENTITY_BLASTOCYST_MEDIUM = 75,
    ENTITY_BLASTOCYST_SMALL = 76,
    ENTITY_EMBRYO = 77,
    ENTITY_MOMS_HEART = 78,
    ENTITY_GEMINI = 79, -- 79 boss: Gemini
    ENTITY_MOTER = 80, -- 80 enemy: Moter
    ENTITY_FALLEN = 81, -- variant 1: Krampus
    ENTITY_HEADLESS_HORSEMAN = 82, -- Headless Horseman
    ENTITY_HORSEMAN_HEAD = 83, -- Head for Headless Horseman
    ENTITY_SATAN = 84,
    ENTITY_SPIDER = 85, -- 85 enemy: Spider
    ENTITY_KEEPER = 86,
    ENTITY_GURGLE = 87,
    ENTITY_WALKINGBOIL = 88, -- ai for WalkingBoil, WalkingGut and WalkingSack
    ENTITY_BUTTLICKER = 89,
    ENTITY_HANGER = 90, -- 90 enemy: Hanger
    ENTITY_SWARMER = 91,
    ENTITY_HEART = 92,
    ENTITY_MASK = 93,
    ENTITY_BIGSPIDER = 94,
    ENTITY_ETERNALFLY = 96, -- 96 enemy: Eternal Fly
    ENTITY_MASK_OF_INFAMY = 97,
    ENTITY_HEART_OF_INFAMY = 98,
    ENTITY_GURDY_JR = 99, -- 99 enemy: Gurdy Jr.
    ENTITY_WIDOW = 100,
    ENTITY_DADDYLONGLEGS = 101,
    ENTITY_ISAAC = 102,
    ENTITY_STONE_EYE = 201,
    ENTITY_CONSTANT_STONE_SHOOTER = 202,
    ENTITY_BRIMSTONE_HEAD = 203,
    ENTITY_MOBILE_HOST = 204,
    ENTITY_NEST = 205,
    ENTITY_BABY_LONG_LEGS = 206,
    ENTITY_CRAZY_LONG_LEGS = 207,
    ENTITY_FATTY = 208,
    ENTITY_FAT_SACK = 209,
    ENTITY_BLUBBER = 210,
    ENTITY_HALF_SACK = 211,
    ENTITY_DEATHS_HEAD = 212,
    ENTITY_MOMS_HAND = 213,
    ENTITY_FLY_L2 = 214,
    ENTITY_SPIDER_L2 = 215,
    ENTITY_SWINGER = 216,
    ENTITY_DIP = 217,
    ENTITY_WALL_HUGGER = 218,
    ENTITY_WIZOOB = 219,
    ENTITY_SQUIRT = 220,
    ENTITY_COD_WORM = 221,
    ENTITY_RING_OF_FLIES = 222,
    ENTITY_DINGA = 223,
    ENTITY_OOB = 224,
    ENTITY_BLACK_MAW = 225,
    ENTITY_SKINNY = 226,
    ENTITY_BONY = 227,
    ENTITY_HOMUNCULUS = 228,
    ENTITY_TUMOR = 229,
    ENTITY_CAMILLO_JR = 230,
    ENTITY_NERVE_ENDING = 231,
    ENTITY_SKINBALL = 232,
    ENTITY_MOM_HEAD = 233,
    ENTITY_ONE_TOOTH = 234,
    ENTITY_GAPING_MAW = 235,
    ENTITY_BROKEN_GAPING_MAW = 236,
    ENTITY_GURGLING = 237,
    ENTITY_SPLASHER = 238,
    ENTITY_GRUB = 239,
    ENTITY_WALL_CREEP = 240,
    ENTITY_RAGE_CREEP = 241,
    ENTITY_BLIND_CREEP = 242,
    ENTITY_CONJOINED_SPITTY = 243,
    ENTITY_ROUND_WORM = 244,
    ENTITY_POOP = 245,
    ENTITY_RAGLING = 246,
    ENTITY_FLESH_MOBILE_HOST = 247,
    ENTITY_PSY_HORF = 248,
    ENTITY_FULL_FLY = 249,
    ENTITY_TICKING_SPIDER = 250,
    ENTITY_BEGOTTEN = 251,
    ENTITY_NULLS = 252,
    ENTITY_PSY_TUMOR = 253,
    ENTITY_FLOATING_KNIGHT = 254,
    ENTITY_NIGHT_CRAWLER = 255,
    ENTITY_DART_FLY = 256,
    ENTITY_CONJOINED_FATTY = 257,
    ENTITY_FAT_BAT = 258,
    ENTITY_IMP = 259,
    ENTITY_THE_HAUNT = 260,
    ENTITY_DINGLE = 261,
    ENTITY_MEGA_MAW = 262,
    ENTITY_GATE = 263,
    ENTITY_MEGA_FATTY = 264,
    ENTITY_CAGE = 265,
    ENTITY_MAMA_GURDY = 266,
    ENTITY_DARK_ONE = 267,
    ENTITY_ADVERSARY = 268,
    ENTITY_POLYCEPHALUS = 269,
    ENTITY_MR_FRED = 270,
    ENTITY_URIEL = 271,
    ENTITY_GABRIEL = 272,
    ENTITY_THE_LAMB = 273,
    ENTITY_MEGA_SATAN = 274,
    ENTITY_MEGA_SATAN_2 = 275,
    ENTITY_ROUNDY = 276,
    ENTITY_BLACK_BONY = 277,
    ENTITY_BLACK_GLOBIN = 278,
    ENTITY_BLACK_GLOBIN_HEAD = 279,
    ENTITY_BLACK_GLOBIN_BODY = 280,
    ENTITY_SWARM = 281,
    ENTITY_MEGA_CLOTTY = 282,
    ENTITY_BONE_KNIGHT = 283,
    ENTITY_CYCLOPIA = 284,
    ENTITY_RED_GHOST = 285,
    ENTITY_FLESH_DEATHS_HEAD = 286,
    ENTITY_MOMS_DEAD_HAND = 287,
    ENTITY_DUKIE = 288,
    ENTITY_ULCER = 289,
    ENTITY_MEATBALL = 290,
    ENTITY_PITFALL = 291,
    ENTITY_MOVABLE_TNT = 292,
    ENTITY_ULTRA_COIN = 293,
    ENTITY_ULTRA_DOOR = 294,
    ENTITY_CORN_MINE = 295,
    ENTITY_HUSH_FLY = 296,
    ENTITY_HUSH_GAPER = 297,
    ENTITY_HUSH_BOIL = 298,
    ENTITY_GREED_GAPER = 299,
    ENTITY_MUSHROOM = 300,
    ENTITY_POISON_MIND = 301,
    ENTITY_STONEY = 302,
    ENTITY_BLISTER = 303,
    ENTITY_THE_THING = 304,
    ENTITY_MINISTRO = 305,
    ENTITY_PORTAL = 306,
    ENTITY_TARBOY = 307,
    ENTITY_FISTULOID = 308,
    ENTITY_GUSH = 309,
    ENTITY_LEPER = 310,
    ENTITY_MR_MINE = 311,
    ENTITY_STAIN = 401,
    ENTITY_BROWNIE = 402,
    ENTITY_FORSAKEN = 403,
    ENTITY_LITTLE_HORN = 404,
    ENTITY_RAG_MAN = 405,
    ENTITY_ULTRA_GREED = 406,
    ENTITY_HUSH = 407,
    ENTITY_HUSH_SKINLESS = 408,
    ENTITY_RAG_MEGA = 409,
    ENTITY_SISTERS_VIS = 410,
    ENTITY_BIG_HORN = 411,
    ENTITY_DELIRIUM = 412,
    ENTITY_MATRIARCH = 413,
    ENTITY_BONE_WORM = 801,
    ENTITY_BLOOD_PUPPY = 802,
    ENTITY_QUAKE_GRIMACE = 804,
    ENTITY_BISHOP = 805,
    ENTITY_BUBBLES = 806,
    ENTITY_WRAITH = 807,
    ENTITY_WILLO = 808,
    ENTITY_BOMB_GRIMACE = 809,
    ENTITY_SMALL_LEECH = 810,
    ENTITY_DEEP_GAPER = 811,
    ENTITY_SUB_HORF = 812,
    ENTITY_BLURB = 813,
    ENTITY_STRIDER = 814,
    ENTITY_FISSURE = 815,
    ENTITY_POLTY = 816,
    ENTITY_PREY = 817,
    ENTITY_ROCK_SPIDER = 818,
    ENTITY_FLY_BOMB = 819,
    ENTITY_DANNY = 820,
    ENTITY_BLASTER = 821,
    ENTITY_BOUNCER = 822,
    ENTITY_QUAKEY = 823,
    ENTITY_GYRO = 824,
    ENTITY_FIRE_WORM = 825,
    ENTITY_HARDY = 826,
    ENTITY_FACELESS = 827,
    ENTITY_NECRO = 828,
    ENTITY_MOLE = 829,
    ENTITY_BIG_BONY = 830,
    ENTITY_GUTTED_FATTY = 831,
    ENTITY_EXORCIST = 832,
    ENTITY_CANDLER = 833,
    ENTITY_WHIPPER = 834,
    ENTITY_PEEPER_FATTY = 835,
    ENTITY_VIS_VERSA = 836,
    ENTITY_HENRY = 837,
    ENTITY_WILLO_L2 = 838,
    ENTITY_PON = 840,
    ENTITY_REVENANT = 841,
    ENTITY_BOMBGAGGER = 844,
    ENTITY_GAPER_L2 = 850,
    ENTITY_TWITCHY = 851,
    ENTITY_SPIKEBALL = 852,
    ENTITY_SMALL_MAGGOT = 853,
    ENTITY_ADULT_LEECH = 854,
    ENTITY_CHARGER_L2 = 855,
    ENTITY_GASBAG = 856,
    ENTITY_COHORT = 857,
    ENTITY_FLOATING_HOST = 859,
    ENTITY_UNBORN = 860,
    ENTITY_PUSTULE = 861,
    ENTITY_CYST = 862,
    ENTITY_MORNINGSTAR = 863,
    ENTITY_MOCKULUS = 864,
    ENTITY_EVIS = 865,
    ENTITY_DARK_ESAU = 866,
    ENTITY_MOTHERS_SHADOW = 867,
    ENTITY_ARMYFLY = 868,
    ENTITY_MIGRAINE = 869,
    ENTITY_DRIP = 870,
    ENTITY_SPLURT = 871,
    ENTITY_CLOGGY = 872,
    ENTITY_FLY_TRAP = 873,
    ENTITY_FARTIGAN = 874,
    ENTITY_POOT_MINE = 875,
    ENTITY_DUMP = 876,
    ENTITY_GRUDGE = 877,
    ENTITY_BUTT_SLICKER = 878,
    ENTITY_BLOATY = 879,
    ENTITY_FLESH_MAIDEN = 880,
    ENTITY_NEEDLE = 881,
    ENTITY_DUST = 882,
    ENTITY_BABY_BEGOTTEN = 883,
    ENTITY_SWARM_SPIDER = 884,
    ENTITY_CULTIST = 885,
    ENTITY_VIS_FATTY = 886,
    ENTITY_DUSTY_DEATHS_HEAD = 887,
    ENTITY_SHADY = 888,
    ENTITY_CLICKETY_CLACK = 889,
    ENTITY_MAZE_ROAMER = 890,
    ENTITY_GOAT = 891,
    ENTITY_POOFER = 892,
    ENTITY_BALL_AND_CHAIN = 893,
    ENTITY_REAP_CREEP = 900,
    ENTITY_LIL_BLUB = 901,
    ENTITY_RAINMAKER = 902,
    ENTITY_VISAGE = 903,
    ENTITY_SIREN = 904,
    ENTITY_HERETIC = 905,
    ENTITY_HORNFEL = 906,
    ENTITY_GIDEON = 907,
    ENTITY_BABY_PLUM = 908,
    ENTITY_SCOURGE = 909,
    ENTITY_CHIMERA = 910,
    ENTITY_ROTGUT = 911,
    ENTITY_MOTHER = 912,
    ENTITY_MIN_MIN = 913,
    ENTITY_CLOG = 914,
    ENTITY_SINGE = 915,
    ENTITY_BUMBINO = 916,
    ENTITY_COLOSTOMIA = 917,
    ENTITY_TURDLET = 918,
    ENTITY_RAGLICH = 919, -- currently unused
    ENTITY_HORNY_BOYS = 920,
    ENTITY_CLUTCH = 921, -- currently unused
    ENTITY_CADAVRA = 922, -- currently unused
    ENTITY_DOGMA = 950,
    ENTITY_BEAST = 951,
    ENTITY_GENERIC_PROP = 960,
    ENTITY_FROZEN_ENEMY = 963,
    ENTITY_DUMMY = 964,
    ENTITY_MINECART = 965,
    ENTITY_SIREN_HELPER = 966,
    ENTITY_HORNFEL_DOOR = 967,
    ENTITY_TRIGGER_OUTPUT = 969,
    ENTITY_ENVIRONMENT = 970,
    ENTITY_EFFECT = 1000, -- 1000 special effects
    ENTITY_TEXT = 9001,
}
---@enum GridEntityType
GridEntityType = {
    GRID_NULL = 0,
    GRID_DECORATION = 1,
    GRID_ROCK = 2,
    GRID_ROCKB = 3,
    GRID_ROCKT = 4,
    GRID_ROCK_BOMB = 5,
    GRID_ROCK_ALT = 6,
    GRID_PIT = 7,
    GRID_SPIKES = 8,
    GRID_SPIKES_ONOFF = 9,
    GRID_SPIDERWEB = 10,
    GRID_LOCK = 11,
    GRID_TNT = 12,
    GRID_FIREPLACE = 13, -- not used!
    GRID_POOP = 14,
    GRID_WALL = 15,
    GRID_DOOR = 16,
    GRID_TRAPDOOR = 17,
    GRID_STAIRS = 18,
    GRID_GRAVITY = 19,
    GRID_PRESSURE_PLATE = 20,
    GRID_STATUE = 21,
    GRID_ROCK_SS = 22,
    GRID_TELEPORTER = 23,
    GRID_PILLAR = 24,
    GRID_ROCK_SPIKED = 25,
    GRID_ROCK_ALT2 = 26, -- special skull in Depths 2
    GRID_ROCK_GOLD = 27,
}
---@enum EffectVariant
EffectVariant = {
    EFFECT_NULL = 0,
    BOMB_EXPLOSION = 1,
    BLOOD_EXPLOSION = 2,
    FLY_EXPLOSION = 3,
    ROCK_PARTICLE = 4,
    BLOOD_PARTICLE = 5,
    DEVIL = 6,
    BLOOD_SPLAT = 7,
    LADDER = 8,
    ANGEL = 9,
    BLUE_FLAME = 10,
    BULLET_POOF = 11,
    TEAR_POOF_A = 12,
    TEAR_POOF_B = 13,
    RIPPLE_POOF = 14,
    CROSS_POOF = 14, -- AB+ backwards compatibility
    POOF01 = 15,
    POOF02 = 16,
    POOF04 = 17,
    BOMB_CRATER = 18,
    CRACK_THE_SKY = 19,
    SCYTHE_BREAK = 20,
    TINY_BUG = 21,
    CREEP_RED = 22,
    CREEP_GREEN = 23,
    CREEP_YELLOW = 24,
    CREEP_WHITE = 25,
    CREEP_BLACK = 26,
    WOOD_PARTICLE = 27,
    MONSTROS_TOOTH = 28,
    MOM_FOOT_STOMP = 29,
    TARGET = 30,
    ROCKET = 31,
    PLAYER_CREEP_LEMON_MISHAP = 32,
    TINY_FLY = 33,
    FART = 34,
    TOOTH_PARTICLE = 35,
    XRAY_WALL = 36,
    PLAYER_CREEP_HOLYWATER = 37,
    SPIDER_EXPLOSION = 38,
    HEAVEN_LIGHT_DOOR = 39,
    STARFLASH = 40,
    WATER_DROPLET = 41,
    BLOOD_GUSH = 42,
    POOP_EXPLOSION = 43,
    PLAYER_CREEP_WHITE = 44,
    PLAYER_CREEP_BLACK = 45,
    PLAYER_CREEP_RED = 46,
    TRINITY_SHIELD = 47,
    BATTERY = 48,
    HEART = 49,
    LASER_IMPACT = 50,
    HOT_BOMB_FIRE = 51,
    RED_CANDLE_FLAME = 52,
    PLAYER_CREEP_GREEN = 53,
    PLAYER_CREEP_HOLYWATER_TRAIL = 54,
    SPIKE = 55,
    CREEP_BROWN = 56,
    PULLING_EFFECT = 57,
    POOP_PARTICLE = 58,
    DUST_CLOUD = 59,
    BOOMERANG = 60,
    SHOCKWAVE = 61,
    ROCK_EXPLOSION = 62,
    WORM = 63,
    BEETLE = 64,
    WISP = 65,
    EMBER_PARTICLE = 66,
    SHOCKWAVE_DIRECTIONAL = 67,
    WALL_BUG = 68,
    BUTTERFLY = 69,
    BLOOD_DROP = 70,
    BRIMSTONE_SWIRL = 71,
    CRACKWAVE = 72,
    SHOCKWAVE_RANDOM = 73,
    ISAACS_CARPET = 74,
    BAR_PARTICLE = 75,
    DICE_FLOOR = 76,
    LARGE_BLOOD_EXPLOSION = 77,
    PLAYER_CREEP_LEMON_PARTY = 78,
    TEAR_POOF_SMALL = 79,
    TEAR_POOF_VERYSMALL = 80,
    FRIEND_BALL = 81,
    WOMB_TELEPORT = 82,
    SPEAR_OF_DESTINY = 83,
    EVIL_EYE = 84,
    DIAMOND_PARTICLE = 85,
    NAIL_PARTICLE = 86,
    FALLING_EMBER = 87,
    DARK_BALL_SMOKE_PARTICLE = 88,
    ULTRA_GREED_FOOTPRINT = 89,
    PLAYER_CREEP_PUDDLE_MILK = 90,
    MOMS_HAND = 91,
    PLAYER_CREEP_BLACKPOWDER = 92,
    PENTAGRAM_BLACKPOWDER = 93,
    CREEP_SLIPPERY_BROWN = 94,
    GOLD_PARTICLE = 95,
    HUSH_LASER = 96,
    IMPACT = 97,
    COIN_PARTICLE = 98,
    WATER_SPLASH = 99,
    HUSH_ASHES = 100,
    HUSH_LASER_UP = 101,
    BULLET_POOF_HUSH = 102,
    ULTRA_GREED_BLING = 103,
    FIREWORKS = 104,
    BROWN_CLOUD = 105,
    FART_RING = 106,
    BLACK_HOLE = 107,
    MR_ME = 108,
    DEATH_SKULL = 109,
    ENEMY_BRIMSTONE_SWIRL = 110,
    HAEMO_TRAIL = 111,
    HALLOWED_GROUND = 112,
    BRIMSTONE_BALL = 113,
    FORGOTTEN_CHAIN = 114,
    BROKEN_SHOVEL_SHADOW = 115,
    DIRT_PATCH = 116,
    FORGOTTEN_SOUL = 117,
    SMALL_ROCKET = 118,
    TIMER = 119,
    SPAWNER = 120,
    LIGHT = 121,
    BIG_HORN_HOLE_HELPER = 122,
    HALO = 123,
    TAR_BUBBLE = 124,
    BIG_HORN_HAND = 125,
    TECH_DOT = 126,
    MAMA_MEGA_EXPLOSION = 127,
    OPTION_LINE = 128, -- unused
    LEECH_EXPLOSION = 130,
    MAGGOT_EXPLOSION = 131,
    BIG_SPLASH = 132,
    WATER_RIPPLE = 133,
    PEDESTAL_RIPPLE = 134,
    RAIN_DROP = 135,
    GRID_ENTITY_PROJECTILE_HELPER = 136,
    WORMWOOD_HOLE = 137,
    MIST = 138,
    TRAPDOOR_COVER = 139,
    BACKDROP_DECORATION = 140,
    SMOKE_CLOUD = 141,
    WHIRLPOOL = 142,
    FARTWAVE = 143,
    ENEMY_GHOST = 144,
    ROCK_POOF = 145,
    DIRT_PILE = 146,
    FIRE_JET = 147,
    FIRE_WAVE = 148,
    BIG_ROCK_EXPLOSION = 149,
    BIG_CRACKWAVE = 150,
    BIG_ATTRACT = 151,
    HORNFEL_ROOM_CONTROLLER = 152,
    OCCULT_TARGET = 153,
    DOOR_OUTLINE = 154,
    CREEP_SLIPPERY_BROWN_GROWING = 155,
    TALL_LADDER = 156,
    WILLO_SPAWNER = 157,
    TADPOLE = 158,
    LIL_GHOST = 159,
    BISHOP_SHIELD = 160,
    PORTAL_TELEPORT = 161,
    HERETIC_PENTAGRAM = 162,
    CHAIN_GIB = 163,
    SIREN_RING = 164,
    CHARM_EFFECT = 165,
    SPRITE_TRAIL = 166,
    CHAIN_LIGHTNING = 167,
    COLOSTOMIA_PUDDLE = 168,
    CREEP_STATIC = 169,
    DOGMA_DEBRIS = 170,
    DOGMA_BLACKHOLE = 171,
    DOGMA_ORB = 172,
    CRACKED_ORB_POOF = 173,
    SHOP_SPIKES = 174,
    KINETI_BEAM = 175,
    CLEAVER_SLASH = 176,
    REVERSE_EXPLOSION = 177,
    URN_OF_SOULS = 178,
    ENEMY_SOUL = 179,
    RIFT = 180,
    LAVA_SPAWNER = 181,
    BIG_KNIFE = 182,
    MOTHER_SHOCKWAVE = 183,
    WORM_FRIEND_SNARE = 184,
    REDEMPTION = 185,
    HUNGRY_SOUL = 186,
    EXPLOSION_WAVE = 187,
    DIVINE_INTERVENTION = 188,
    PURGATORY = 189,
    MOTHER_TRACER = 190,
    PICKUP_GHOST = 191,
    FISSURE_SPAWNER = 192,
    ANIMA_CHAIN = 193,
    DARK_SNARE = 194,
    CREEP_LIQUID_POOP = 195,
    GROUND_GLOW = 196,
    DEAD_BIRD = 197,
    GENERIC_TRACER = 198,
    ULTRA_DEATH_SCYTHE = 199,
}
---@enum PickupVariant
PickupVariant = {
    PICKUP_NULL = 0,
    PICKUP_HEART = 10,
    PICKUP_COIN = 20,
    PICKUP_KEY = 30,
    PICKUP_BOMB = 40,
    PICKUP_THROWABLEBOMB = 41,
    PICKUP_POOP = 42,
    PICKUP_CHEST = 50,
    PICKUP_BOMBCHEST = 51,
    PICKUP_SPIKEDCHEST = 52,
    PICKUP_ETERNALCHEST = 53,
    PICKUP_MIMICCHEST = 54,
    PICKUP_OLDCHEST = 55,
    PICKUP_WOODENCHEST = 56,
    PICKUP_MEGACHEST = 57,
    PICKUP_HAUNTEDCHEST = 58,
    PICKUP_LOCKEDCHEST = 60,
    PICKUP_GRAB_BAG = 69,
    PICKUP_PILL = 70,
    PICKUP_LIL_BATTERY = 90,
    PICKUP_COLLECTIBLE = 100,
    PICKUP_BROKEN_SHOVEL = 110,
    PICKUP_SHOPITEM = 150,
    PICKUP_TAROTCARD = 300,
    PICKUP_BIGCHEST = 340,
    PICKUP_TRINKET = 350,
    PICKUP_REDCHEST = 360,
    PICKUP_TROPHY = 370,
    PICKUP_BED = 380,
    PICKUP_MOMSCHEST = 390,
}
---@enum HeartSubType
HeartSubType = {
    HEART_FULL = 1,
    HEART_HALF = 2,
    HEART_SOUL = 3,
    HEART_ETERNAL = 4,
    HEART_DOUBLEPACK = 5,
    HEART_BLACK = 6,
    HEART_GOLDEN = 7,
    HEART_HALF_SOUL = 8,
    HEART_SCARED = 9,
    HEART_BLENDED = 10,
    HEART_BONE = 11,
    HEART_ROTTEN = 12,
}
---@enum CoinSubType
CoinSubType = {
    COIN_PENNY = 1,
    COIN_NICKEL = 2,
    COIN_DIME = 3,
    COIN_DOUBLEPACK = 4,
    COIN_LUCKYPENNY = 5,
    COIN_STICKYNICKEL = 6,
    COIN_GOLDEN = 7,
}
---@enum KeySubType
KeySubType = {
    KEY_NORMAL = 1,
    KEY_GOLDEN = 2,
    KEY_DOUBLEPACK = 3,
    KEY_CHARGED = 4,
}
---@enum BatterySubType
BatterySubType = {
    BATTERY_NORMAL = 1,
    BATTERY_MICRO = 2,
    BATTERY_MEGA = 3,
    BATTERY_GOLDEN = 4,
}
---@enum SackSubType
SackSubType = {
    SACK_NORMAL = 1,
    SACK_BLACK = 2,
}
---@enum ChestSubType
ChestSubType = {
    CHEST_OPENED = 0,
    CHEST_CLOSED = 1,
}
---@enum BombSubType
BombSubType = {
    BOMB_NORMAL = 1,
    BOMB_DOUBLEPACK = 2,
    BOMB_TROLL = 3,
    BOMB_GOLDEN = 4,
    BOMB_SUPERTROLL = 5,
    BOMB_GOLDENTROLL = 6,
    BOMB_GIGA = 7,
}
---@enum BedSubType
BedSubType = {
    BED_ISAAC = 0,
    BED_MOM = 1,
}
---@enum PickupPrice
PickupPrice = {
    PRICE_ONE_HEART = -1,
    PRICE_TWO_HEARTS = -2,
    PRICE_THREE_SOULHEARTS = -3,
    PRICE_ONE_HEART_AND_TWO_SOULHEARTS = -4,
    PRICE_SPIKES = -5,
    PRICE_SOUL = -6,
    PRICE_ONE_SOUL_HEART = -7,
    PRICE_TWO_SOUL_HEARTS = -8,
    PRICE_ONE_HEART_AND_ONE_SOUL_HEART = -9,
    PRICE_FREE = -1000,
}
---@enum PoopPickupSubType
PoopPickupSubType = {
    POOP_SMALL = 0,
    POOP_BIG = 1,
}
---@enum Challenge
Challenge = {
    CHALLENGE_NULL = 0,
    CHALLENGE_PITCH_BLACK = 1,
    CHALLENGE_HIGH_BROW = 2,
    CHALLENGE_HEAD_TRAUMA = 3,
    CHALLENGE_DARKNESS_FALLS = 4,
    CHALLENGE_THE_TANK = 5,
    CHALLENGE_SOLAR_SYSTEM = 6,
    CHALLENGE_SUICIDE_KING = 7,
    CHALLENGE_CAT_GOT_YOUR_TONGUE = 8,
    CHALLENGE_DEMO_MAN = 9,
    CHALLENGE_CURSED = 10,
    CHALLENGE_GLASS_CANNON = 11,
    CHALLENGE_WHEN_LIFE_GIVES_LEMONS = 12,
    CHALLENGE_BEANS = 13,
    CHALLENGE_ITS_IN_THE_CARDS = 14,
    CHALLENGE_SLOW_ROLL = 15,
    CHALLENGE_COMPUTER_SAVY = 16,
    CHALLENGE_WAKA_WAKA = 17,
    CHALLENGE_THE_HOST = 18,
    CHALLENGE_THE_FAMILY_MAN = 19,
    CHALLENGE_PURIST = 20,
    CHALLENGE_XXXXXXXXL = 21,
    CHALLENGE_SPEED = 22,
    CHALLENGE_BLUE_BOMBER = 23,
    CHALLENGE_PAY_TO_PLAY = 24,
    CHALLENGE_HAVE_A_HEART = 25,
    CHALLENGE_I_RULE = 26,
    CHALLENGE_BRAINS = 27,
    CHALLENGE_PRIDE_DAY = 28,
    CHALLENGE_ONANS_STREAK = 29,
    CHALLENGE_GUARDIAN = 30,
    CHALLENGE_BACKASSWARDS = 31,
    CHALLENGE_APRILS_FOOL = 32,
    CHALLENGE_POKEY_MANS = 33,
    CHALLENGE_ULTRA_HARD = 34,
    CHALLENGE_PONG = 35,
    CHALLENGE_SCAT_MAN = 36,
    CHALLENGE_BLOODY_MARY = 37,
    CHALLENGE_BAPTISM_BY_FIRE = 38,
    CHALLENGE_ISAACS_AWAKENING = 39,
    CHALLENGE_SEEING_DOUBLE = 40,
    CHALLENGE_PICA_RUN = 41,
    CHALLENGE_HOT_POTATO = 42,
    CHALLENGE_CANTRIPPED = 43,
    CHALLENGE_RED_REDEMPTION = 44,
    CHALLENGE_DELETE_THIS = 45,
    NUM_CHALLENGES = 46,
}
---@enum BombVariant
BombVariant = {
    BOMB_NORMAL = 0,
    BOMB_BIG = 1,
    BOMB_DECOY = 2,
    BOMB_TROLL = 3,
    BOMB_SUPERTROLL = 4,
    BOMB_POISON = 5,
    BOMB_POISON_BIG = 6,
    BOMB_SAD = 7,
    BOMB_HOT = 8,
    BOMB_BUTT = 9,
    BOMB_MR_MEGA = 10,
    BOMB_BOBBY = 11,
    BOMB_GLITTER = 12,
    BOMB_THROWABLE = 13,
    BOMB_SMALL = 14,
    BOMB_BRIMSTONE = 15,
    BOMB_SAD_BLOOD = 16,
    BOMB_GIGA = 17,
    BOMB_GOLDENTROLL = 18,
    BOMB_ROCKET = 19,
    BOMB_ROCKET_GIGA = 20,
}
---@enum LaserVariant
LaserVariant = {
    LASER_NULL = 0,
    THICK_RED = 1,
    THIN_RED = 2,
    SHOOP = 3,
    PRIDE = 4,
    LIGHT_BEAM = 5,
    GIANT_RED = 6,
    TRACTOR_BEAM = 7,
    LIGHT_RING = 8,
    BRIM_TECH = 9,
    ELECTRIC = 10,
    THICKER_RED = 11,
    THICK_BROWN = 12,
    BEAST = 13,
    THICKER_BRIM_TECH = 14,
    GIANT_BRIM_TECH = 15,
}
---@enum CacheFlag
CacheFlag = {
    CACHE_DAMAGE = 0x1,
    CACHE_FIREDELAY = 0x2,
    CACHE_SHOTSPEED = 0x4,
    CACHE_RANGE = 0x8,
    CACHE_SPEED = 0x10,
    CACHE_TEARFLAG = 0x20,
    CACHE_TEARCOLOR = 0x40,
    CACHE_FLYING = 0x80,
    CACHE_WEAPON = 0x100,
    CACHE_FAMILIARS = 0x200,
    CACHE_LUCK = 0x400,
    CACHE_SIZE = 0x800, -- invalidates player size
    CACHE_COLOR = 0x1000, -- invalidates player color
    CACHE_PICKUP_VISION = 0x2000, -- invalidates effects that predict pickup drops (i.e. Guppy's Eye)
    CACHE_ALL = 0xFFFF,
    CACHE_TWIN_SYNC = 0x80000000, -- special cache flag used when syncing Jacob and Esau's speed
}
---@enum NpcState
NpcState = {
    STATE_INIT = 0,
    STATE_APPEAR = 1,
    STATE_APPEAR_CUSTOM = 2,
    STATE_IDLE = 3,
    STATE_MOVE = 4,
    STATE_SUICIDE = 5,
    STATE_JUMP = 6,
    STATE_STOMP = 7,
    STATE_ATTACK = 8,
    STATE_ATTACK2 = 9,
    STATE_ATTACK3 = 10,
    STATE_ATTACK4 = 11,
    STATE_ATTACK5 = 12,
    STATE_SUMMON = 13,
    STATE_SUMMON2 = 14,
    STATE_SUMMON3 = 15,
    STATE_SPECIAL = 16,
    STATE_UNIQUE_DEATH = 17,
    STATE_DEATH = 18,
}
---@enum EntityGridCollisionClass
EntityGridCollisionClass = {
    GRIDCOLL_NONE = 0,
    GRIDCOLL_WALLS_X = 1, -- only collide with vertical walls
    GRIDCOLL_WALLS_Y = 2, -- only collide with horizontal walls
    GRIDCOLL_WALLS = 3, -- only collide with walls
    GRIDCOLL_BULLET = 4, -- detect collision with solids (no pits), don't correct position
    GRIDCOLL_GROUND = 5, -- collide with all grid entities (rocks, pits, ..), correct position
    GRIDCOLL_NOPITS = 6, -- collide with all grid entities except pits and correct position
    GRIDCOLL_PITSONLY = 7, -- moving inside a pit, collide with everything else, correct position
}
---@enum EntityCollisionClass
EntityCollisionClass = {
    ENTCOLL_NONE = 0, -- no collision with other entities
    ENTCOLL_PLAYERONLY = 1, -- collide with player only
    ENTCOLL_PLAYEROBJECTS = 2, -- collide with player, tears, familiars, ..
    ENTCOLL_ENEMIES = 3, -- collide with enemies
    ENTCOLL_ALL = 4, -- collide with everything
}
---@enum EntityFlag
EntityFlag = {
    FLAG_NO_STATUS_EFFECTS = 1, -- prevent freeze/poison/slow/charm/confusion/fear/burn
    FLAG_NO_INTERPOLATE = 1 << 0,
    FLAG_APPEAR = 1 << 1,
    FLAG_RENDER_FLOOR = 1 << 2,
    FLAG_NO_TARGET = 1 << 3,
    FLAG_FREEZE = 1 << 4,
    FLAG_POISON = 1 << 5,
    FLAG_SLOW = 1 << 6,
    FLAG_CHARM = 1 << 7,
    FLAG_CONFUSION = 1 << 8,
    FLAG_MIDAS_FREEZE = 1 << 9,
    FLAG_FEAR = 1 << 10,
    FLAG_BURN = 1 << 11,
    FLAG_RENDER_WALL = 1 << 12,
    FLAG_INTERPOLATION_UPDATE = 1 << 13,
    FLAG_APPLY_GRAVITY = 1 << 14,
    FLAG_NO_BLOOD_SPLASH = 1 << 15,
    FLAG_NO_REMOVE_ON_TEX_RENDER = 1 << 16,
    FLAG_NO_DEATH_TRIGGER = 1 << 17,
    FLAG_NO_SPIKE_DAMAGE = 1 << 18,
    FLAG_LASER_POP = 1 << 19,
    FLAG_ITEM_SHOULD_DUPLICATE = 1 << 19,
    FLAG_BOSSDEATH_TRIGGERED = 1 << 20,
    FLAG_DONT_OVERWRITE = 1 << 21,
    FLAG_SPAWN_STICKY_SPIDERS = 1 << 22,
    FLAG_SPAWN_BLACK_HP = 1 << 23,
    FLAG_SHRINK = 1 << 24,
    FLAG_NO_FLASH_ON_DAMAGE = 1 << 25,
    FLAG_NO_KNOCKBACK = 1 << 26,
    FLAG_SLIPPERY_PHYSICS = 1 << 27,
    FLAG_ADD_JAR_FLY = 1 << 28,
    FLAG_FRIENDLY = 1 << 29,
    FLAG_NO_PHYSICS_KNOCKBACK = 1 << 30,
    FLAG_DONT_COUNT_BOSS_HP = 1 << 31,
    FLAG_NO_SPRITE_UPDATE = 1 << 32,
    FLAG_CONTAGIOUS = 1 << 33,
    FLAG_BLEED_OUT = 1 << 34,
    FLAG_HIDE_HP_BAR = 1 << 35,
    FLAG_NO_DAMAGE_BLINK = 1 << 36,
    FLAG_PERSISTENT = 1 << 37,
    FLAG_BACKDROP_DETAIL = 1 << 38,
    FLAG_AMBUSH = 1 << 39,
    FLAG_GLITCH = 1 << 40,
    FLAG_SPIN = 1 << 41,
    FLAG_NO_REWARD = 1 << 42,
    FLAG_REDUCE_GIBS = 1 << 43,
    FLAG_TRANSITION_UPDATE = 1 << 44,
    FLAG_NO_PLAYER_CONTROL = 1 << 45,
    FLAG_NO_QUERY = 1 << 46,
    FLAG_KNOCKED_BACK = 1 << 47,
    FLAG_APPLY_IMPACT_DAMAGE = 1 << 48,
    FLAG_ICE_FROZEN = 1 << 49,
    FLAG_ICE = 1 << 50,
    FLAG_MAGNETIZED = 1 << 51,
    FLAG_BAITED = 1 << 52,
    FLAG_KILLSWITCH = 1 << 53,
    FLAG_WEAKNESS = 1 << 54,
    FLAG_EXTRA_GORE = 1 << 55,
    FLAG_BRIMSTONE_MARKED = 1 << 56,
    FLAG_HELD = 1 << 57,
    FLAG_THROWN = 1 << 58,
    FLAG_FRIENDLY_BALL = 1 << 59,
}
---@enum DamageFlag
DamageFlag = {
    DAMAGE_NOKILL = 1 << 0, -- damage can not kill the receiver
    DAMAGE_FIRE = 1 << 1,
    DAMAGE_EXPLOSION = 1 << 2,
    DAMAGE_LASER = 1 << 3,
    DAMAGE_ACID = 1 << 4,
    DAMAGE_RED_HEARTS = 1 << 5,
    DAMAGE_COUNTDOWN = 1 << 6,
    DAMAGE_SPIKES = 1 << 7,
    DAMAGE_CLONES = 1 << 8,
    DAMAGE_POOP = 1 << 9,
    DAMAGE_DEVIL = 1 << 10,
    DAMAGE_ISSAC_HEART = 1 << 11,
    DAMAGE_TNT = 1 << 12,
    DAMAGE_INVINCIBLE = 1 << 13,
    DAMAGE_SPAWN_FLY = 1 << 14,
    DAMAGE_POISON_BURN = 1 << 15,
    DAMAGE_CURSED_DOOR = 1 << 16,
    DAMAGE_TIMER = 1 << 17,
    DAMAGE_IV_BAG = 1 << 18,
    DAMAGE_PITFALL = 1 << 19,
    DAMAGE_CHEST = 1 << 20,
    DAMAGE_FAKE = 1 << 21,
    DAMAGE_BOOGER = 1 << 22,
    DAMAGE_SPAWN_BLACK_HEART = 1 << 23,
    DAMAGE_CRUSH = 1 << 24,
    DAMAGE_NO_MODIFIERS = 1 << 25,
    DAMAGE_SPAWN_RED_HEART = 1 << 26,
    DAMAGE_SPAWN_COIN = 1 << 27,
    DAMAGE_NO_PENALTIES = 1 << 28,
    DAMAGE_SPAWN_TEMP_HEART = 1 << 29,
    DAMAGE_IGNORE_ARMOR = 1 << 30,
    DAMAGE_SPAWN_CARD = 1 << 31,
    DAMAGE_SPAWN_RUNE = 1 << 32,
}
---@enum SortingLayer
SortingLayer = {
    SORTING_BACKGROUND = 0, -- Background level, behind grid entities (creep, pitfalls)
    SORTING_DOOR = 1, -- Used by door Xray animation
    SORTING_NORMAL = 2, -- Uses Y position to determine Z sorting
}
---@enum FamiliarVariant
FamiliarVariant = {
    FAMILIAR_NULL = 0,
    BROTHER_BOBBY = 1,
    DEMON_BABY = 2,
    LITTLE_CHUBBY = 3,
    LITTLE_GISH = 4,
    LITTLE_STEVEN = 5,
    ROBO_BABY = 6,
    SISTER_MAGGY = 7,
    ABEL = 8,
    GHOST_BABY = 9,
    HARLEQUIN_BABY = 10,
    RAINBOW_BABY = 11,
    ISAACS_HEAD = 12,
    BLUE_BABY_SOUL = 13,
    DEAD_BIRD = 14,
    EVES_BIRD_FOOT = 15,
    DADDY_LONGLEGS = 16,
    PEEPER = 17,
    BOMB_BAG = 20,
    SACK_OF_PENNIES = 21,
    LITTLE_CHAD = 22,
    RELIC = 23,
    BUM_FRIEND = 24,
    HOLY_WATER = 25,
    KEY_PIECE_1 = 26,
    KEY_PIECE_2 = 27,
    KEY_FULL = 28,
    FOREVER_ALONE = 30,
    DISTANT_ADMIRATION = 31,
    GUARDIAN_ANGEL = 32,
    FLY_ORBITAL = 33,
    SACRIFICIAL_DAGGER = 35,
    DEAD_CAT = 40,
    ONE_UP = 41,
    GUPPYS_HAIRBALL = 42,
    BLUE_FLY = 43,
    CUBE_OF_MEAT_1 = 44,
    CUBE_OF_MEAT_2 = 45,
    CUBE_OF_MEAT_3 = 46,
    CUBE_OF_MEAT_4 = 47,
    ISAACS_BODY = 48,
    SMART_FLY = 50,
    DRY_BABY = 51,
    JUICY_SACK = 52,
    ROBO_BABY_2 = 53,
    ROTTEN_BABY = 54,
    HEADLESS_BABY = 55,
    LEECH = 56,
    MYSTERY_SACK = 57,
    BBF = 58,
    BOBS_BRAIN = 59,
    BEST_BUD = 60,
    LIL_BRIMSTONE = 61,
    ISAACS_HEART = 62,
    LIL_HAUNT = 63,
    DARK_BUM = 64,
    BIG_FAN = 65,
    SISSY_LONGLEGS = 66,
    PUNCHING_BAG = 67,
    GUILLOTINE = 68,
    BALL_OF_BANDAGES_1 = 69,
    BALL_OF_BANDAGES_2 = 70,
    BALL_OF_BANDAGES_3 = 71,
    BALL_OF_BANDAGES_4 = 72,
    BLUE_SPIDER = 73,
    MONGO_BABY = 74,
    SAMSONS_CHAINS = 75,
    CAINS_OTHER_EYE = 76,
    BLUEBABYS_ONLY_FRIEND = 77,
    SCISSORS = 78,
    GEMINI = 79,
    INCUBUS = 80,
    FATES_REWARD = 81,
    LIL_CHEST = 82,
    SWORN_PROTECTOR = 83,
    FRIEND_ZONE = 84,
    LOST_FLY = 85,
    CHARGED_BABY = 86,
    LIL_GURDY = 87,
    BUMBO = 88,
    CENSER = 89,
    KEY_BUM = 90,
    RUNE_BAG = 91,
    SERAPHIM = 92,
    GB_BUG = 93,
    SPIDER_MOD = 94,
    FARTING_BABY = 95,
    SUCCUBUS = 96,
    LIL_LOKI = 97,
    OBSESSED_FAN = 98,
    PAPA_FLY = 99,
    MILK = 100,
    MULTIDIMENSIONAL_BABY = 101,
    SUPER_BUM = 102,
    TONSIL = 103,
    BIG_CHUBBY = 104,
    DEPRESSION = 105,
    SHADE = 106,
    HUSHY = 107,
    LIL_MONSTRO = 108,
    KING_BABY = 109,
    FINGER = 110,
    YO_LISTEN = 111,
    ACID_BABY = 112,
    SPIDER_BABY = 113,
    SACK_OF_SACKS = 114,
    BROWN_NUGGET_POOTER = 115,
    BLOODSHOT_EYE = 116,
    MOMS_RAZOR = 117,
    ANGRY_FLY = 118,
    BUDDY_IN_A_BOX = 119,
    SPRINKLER = 120,
    LEPROSY = 121,
    LIL_HARBINGERS = 122,
    ANGELIC_PRISM = 123,
    MYSTERY_EGG = 124,
    LIL_SPEWER = 125,
    SLIPPED_RIB = 126,
    POINTY_RIB = 127,
    BONE_ORBITAL = 128,
    HALLOWED_GROUND = 129,
    JAW_BONE = 130,
    INTRUDER = 200,
    DIP = 201,
    DAMOCLES = 202,
    BLOOD_OATH = 203,
    PSY_FLY = 204,
    MENORAH = 205,
    WISP = 206,
    PEEPER_2 = 207,
    BOILED_BABY = 208,
    FREEZER_BABY = 209,
    BIRD_CAGE = 210,
    LOST_SOUL = 211,
    LIL_DUMPY = 212,
    KNIFE_PIECE_1 = 213,
    KNIFE_PIECE_2 = 214,
    TINYTOMA = 216,
    TINYTOMA_2 = 217,
    BOT_FLY = 218,
    SIREN_MINION = 220,
    PASCHAL_CANDLE = 221,
    STITCHES = 222,
    KNIFE_FULL = 223,
    BABY_PLUM = 224,
    FRUITY_PLUM = 225,
    SPIN_TO_WIN = 226,
    MINISAAC = 228,
    SWARM_FLY_ORBITAL = 229,
    LIL_ABADDON = 230,
    ABYSS_LOCUST = 231,
    LIL_PORTAL = 232,
    WORM_FRIEND = 233,
    BONE_SPUR = 234,
    TWISTED_BABY = 235,
    STAR_OF_BETHLEHEM = 236,
    ITEM_WISP = 237,
    BLOOD_BABY = 238,
    CUBE_BABY = 239,
    UMBILICAL_BABY = 240,
    BLOOD_PUPPY = 241,
    VANISHING_TWIN = 242,
    DECAP_ATTACK = 243,
    FORGOTTEN_BODY = 900,
}
---@enum LocustSubtypes
LocustSubtypes = {
    LOCUST_OF_WRATH = 1,
    LOCUST_OF_PESTILENCE = 2,
    LOCUST_OF_FAMINE = 3,
    LOCUST_OF_DEATH = 4,
    LOCUST_OF_CONQUEST = 5,
}
---@enum ItemType
ItemType = {
    ITEM_NULL = 0,
    ITEM_PASSIVE = 1,
    ITEM_TRINKET = 2,
    ITEM_ACTIVE = 3,
    ITEM_FAMILIAR = 4,
}
---@enum NullItemID
NullItemID = {
    ID_NULL = -1,
    ID_EXPLOSIVE_DIARRHEA = 0,
    ID_PUBERTY = 1,
    ID_I_FOUND_PILLS = 2,
    ID_LORD_OF_THE_FLIES = 3,
    ID_STATUE = 4,
    ID_GUPPY = 5,
    ID_WIZARD = 6,
    ID_MAGDALENE = 7,
    ID_CAIN = 8,
    ID_JUDAS = 9,
    ID_EVE = 10,
    ID_AZAZEL = 11,
    ID_EDEN = 12,
    ID_SAMSON = 13,
    ID_BLINDFOLD = 14,
    ID_BLANKFACE = 15,
    ID_CHRISTMAS = 16,
    ID_PURITY_GLOW = 17,
    ID_EMPTY_VESSEL = 18,
    ID_MAW_MARK = 19,
    ID_MUSHROOM = 20,
    ID_ANGEL = 21,
    ID_BOB = 22,
    ID_DRUGS = 23,
    ID_MOM = 24,
    ID_BABY = 25,
    ID_EVIL_ANGEL = 26,
    ID_POOP = 27,
    ID_RELAX = 28,
    ID_OVERDOSE = 29,
    ID_BOOMERANG = 30,
    ID_MEGABLAST = 31,
    ID_LAZARUS = 32,
    ID_LAZARUS2 = 33,
    ID_LILITH = 34,
    ID_IWATA = 35,
    ID_APOLLYON = 36,
    ID_BOOKWORM = 37,
    ID_ADULTHOOD = 38,
    ID_SPIDERBABY = 39,
    ID_BATWING_WINGS = 40,
    ID_HUGE_GROWTH = 41,
    ID_ERA_WALK = 42,
    ID_SACRIFICIAL_ALTAR = 43,
    ID_FORGOTTEN = 44,
    ID_BRIMSTONE2 = 45,
    ID_HOLY_CARD = 46,
    ID_KEEPER = 47,
    ID_CAMO_BOOST = 48,
    ID_LAZARUS_BOOST = 49,
    ID_SPIN_TO_WIN = 50,
    ID_BETHANY = 51,
    ID_JACOB = 52,
    ID_ESAU = 53,
    ID_BLOOD_OATH = 54,
    ID_INTRUDER = 55,
    ID_SOL = 56,
    ID_IT_HURTS = 57,
    ID_MARS = 58,
    ID_TOOTH_AND_NAIL = 59,
    ID_REVERSE_MAGICIAN = 60,
    ID_REVERSE_HIGH_PRIESTESS = 61,
    ID_REVERSE_EMPRESS = 62,
    ID_REVERSE_CHARIOT = 63,
    ID_REVERSE_STRENGTH = 64,
    ID_REVERSE_HANGED_MAN = 65,
    ID_REVERSE_SUN = 66,
    ID_REVERSE_DEVIL = 67,
    ID_REVERSE_CHARIOT_ALT = 68,
    ID_REVERSE_TEMPERANCE = 69,
    ID_REVERSE_STARS = 70,
    ID_WAVY_CAP_1 = 71,
    ID_WAVY_CAP_2 = 72,
    ID_WAVY_CAP_3 = 73,
    ID_LUNA = 74,
    ID_JUPITER_BODY = 75,
    ID_JUPITER_BODY_ANGEL = 76,
    ID_JUPITER_BODY_PONY = 77,
    ID_JUPITER_BODY_WHITEPONY = 78,
    ID_ISAAC_B = 79,
    ID_MAGDALENE_B = 80,
    ID_CAIN_B = 81,
    ID_JUDAS_B = 82,
    ID_BLUEBABY_B = 83,
    ID_EVE_B = 84,
    ID_SAMSON_B = 85,
    ID_AZAZEL_B = 86,
    ID_LAZARUS_B = 87,
    ID_EDEN_B = 88,
    ID_LOST_B = 89,
    ID_LILITH_B = 90,
    ID_KEEPER_B = 91,
    ID_APOLLYON_B = 92,
    ID_FORGOTTEN_B = 93,
    ID_BETHANY_B = 94,
    ID_JACOB_B = 95,
    ID_AZAZELS_RAGE_1 = 96,
    ID_AZAZELS_RAGE_2 = 97,
    ID_AZAZELS_RAGE_3 = 98,
    ID_AZAZELS_RAGE_4 = 99,
    ID_ESAU_JR = 100,
    ID_SPIRIT_SHACKLES_SOUL = 101,
    ID_SPIRIT_SHACKLES_DISABLED = 102,
    ID_BERSERK_SAMSON = 103,
    ID_LAZARUS2_B = 104,
    ID_SOUL_B = 105,
    ID_FORGOTTEN_BOMB = 106,
    ID_EXTRA_BIG_FAN = 107,
    ID_JACOB2_B = 108,
    ID_JACOBS_CURSE = 109,
    ID_BLOODY_BABYLON = 110,
    ID_DARK_ARTS = 111,
    ID_LOST_CURSE = 112,
    ID_LAZARUS_SOUL_REVIVE = 113,
    ID_SOUL_MAGDALENE = 114,
    ID_SOUL_BLUEBABY = 115,
    ID_MIRROR_DEATH = 116,
    ID_HEMOPTYSIS = 117,
    ID_I_FOUND_HORSE_PILLS = 118,
    ID_HORSE_PUBERTY = 119,
    ID_SOUL_FORGOTTEN = 120,
    ID_SOUL_JACOB = 121,
    ID_BETHANY_B_BIRTHRIGHT = 122,
    ID_JUDAS_BIRTHRIGHT = 123,
    ID_JUDAS_BIRTHRIGHT_TIMED = 124,
    ID_DOUBLE_GUPPYS_EYE = 125,
    ID_DOUBLE_GLASS_EYE = 126,
    ID_HEMOPTYSIS_BOOST = 127,
    ID_SOUL_JUDAS = 128,
    ID_JUDAS_BIRTHRIGHT_STAGE = 129,
    ID_JUDAS_BIRTHRIGHT_PERMANENT = 130,
    ID_ESAU_JR_FAMILIAR = 131,
    NUM_NULLITEMS = 132,
}
---@enum WeaponType
WeaponType = {
    WEAPON_TEARS = 1,
    WEAPON_BRIMSTONE = 2,
    WEAPON_LASER = 3,
    WEAPON_KNIFE = 4,
    WEAPON_BOMBS = 5,
    WEAPON_ROCKETS = 6,
    WEAPON_MONSTROS_LUNGS = 7,
    WEAPON_LUDOVICO_TECHNIQUE = 8,
    WEAPON_TECH_X = 9,
    WEAPON_BONE = 10,
    WEAPON_NOTCHED_AXE = 11, -- Notched Axe
    WEAPON_URN_OF_SOULS = 12, -- Urn of Souls
    WEAPON_SPIRIT_SWORD = 13, -- Spirit Sword
    WEAPON_FETUS = 14, -- (currently unused)
    WEAPON_UMBILICAL_WHIP = 15, -- Fetus whip
    NUM_WEAPON_TYPES = 16,
}
---@enum PlayerSpriteLayer
PlayerSpriteLayer = {
    SPRITE_GLOW = 0,
    SPRITE_BODY = 1,
    SPRITE_BODY0 = 2,
    SPRITE_BODY1 = 3,
    SPRITE_HEAD = 4,
    SPRITE_HEAD0 = 5,
    SPRITE_HEAD1 = 6,
    SPRITE_HEAD2 = 7,
    SPRITE_HEAD3 = 8,
    SPRITE_HEAD4 = 9,
    SPRITE_HEAD5 = 10,
    SPRITE_TOP0 = 11,
    SPRITE_EXTRA = 12,
    SPRITE_GHOST = 13,
    SPRITE_BACK = 14,
    NUM_SPRITE_LAYERS = 15,
}
---@enum BabySubType
BabySubType = {
    BABY_UNASSIGNED = -1,
    BABY_SPIDER = 0,
    BABY_LOVE = 1,
    BABY_BLOAT = 2,
    BABY_WATER = 3,
    BABY_PSY = 4,
    BABY_CURSED = 5,
    BABY_TROLL = 6,
    BABY_YBAB = 7,
    BABY_COCKEYED = 8,
    BABY_HOST = 9,
    BABY_LOST = 10,
    BABY_CUTE = 11,
    BABY_CROW = 12,
    BABY_SHADOW = 13,
    BABY_GLASS = 14,
    BABY_GOLD = 15,
    BABY_CY = 16,
    BABY_BEAN = 17,
    BABY_MAG = 18,
    BABY_WRATH = 19,
    BABY_WRAPPED = 20,
    BABY_BEGOTTEN = 21,
    BABY_DEAD = 22,
    BABY_FIGHTING = 23,
    BABY_0 = 24,
    BABY_GLITCH = 25,
    BABY_MAGNET = 26,
    BABY_BLACK = 27,
    BABY_RED = 28,
    BABY_WHITE = 29,
    BABY_BLUE = 30,
    BABY_RAGE = 31,
    BABY_CRY = 32,
    BABY_YELLOW = 33,
    BABY_LONG = 34,
    BABY_GREEN = 35,
    BABY_LIL = 36,
    BABY_BIG = 37,
    BABY_BROWN = 38,
    BABY_NOOSE = 39,
    BABY_HIVE = 40,
    BABY_BUDDY = 41,
    BABY_COLORFUL = 42,
    BABY_WHORE = 43,
    BABY_CRACKED = 44,
    BABY_DRIPPING = 45,
    BABY_BLINDING = 46,
    BABY_SUCKY = 47,
    BABY_DARK = 48,
    BABY_PICKY = 49,
    BABY_REVENGE = 50,
    BABY_BELIAL = 51,
    BABY_SALE = 52,
    BABY_GOAT = 53,
    BABY_SUPER_GREED = 54,
    BABY_MORT = 55,
    BABY_APOLLYON = 56,
    BABY_BONE = 57,
    BABY_BOUND = 58,
    BABY_FOUND_SOUL = 59,
    BABY_LOST_WHITE = 60,
    BABY_LOST_BLACK = 61,
    BABY_LOST_BLUE = 62,
    BABY_LOST_GREY = 63,
    BABY_WISP = 64,
    BABY_DOUBLE = 65,
    BABY_GLOWING = 66,
    BABY_ILLUSION = 67,
    BABY_HOPE = 68,
    BABY_SOLOMON_A = 69,
    BABY_SOLOMON_B = 70,
    BABY_BASIC = 71,
}
---@enum LaserOffset
LaserOffset = {
    LASER_TECH1_OFFSET = 0,
    LASER_TECH2_OFFSET = 1,
    LASER_TECH5_OFFSET = 2,
    LASER_SHOOP_OFFSET = 3,
    LASER_BRIMSTONE_OFFSET = 4,
    LASER_MOMS_EYE_OFFSET = 5,
    LASER_TRACTOR_BEAM_OFFSET = 6,
}
---@enum ActionTriggers
ActionTriggers = {
    ACTIONTRIGGER_NONE = 0,
    ACTIONTRIGGER_BOMBPLACED = 1,
    ACTIONTRIGGER_MOVED = 1,
    ACTIONTRIGGER_SHOOTING = 1,
    ACTIONTRIGGER_CARDPILLUSED = 1,
    ACTIONTRIGGER_ITEMACTIVATED = 1,
    ACTIONTRIGGER_ITEMSDROPPED = 1,
}
---@enum GridCollisionClass
GridCollisionClass = {
    COLLISION_NONE = 0,
    COLLISION_PIT = 1,
    COLLISION_OBJECT = 2,
    COLLISION_SOLID = 3,
    COLLISION_WALL = 4,
    COLLISION_WALL_EXCEPT_PLAYER = 5,
}
---@enum Direction
Direction = {
    NO_DIRECTION = -1,
    LEFT = 0,
    UP = 1,
    RIGHT = 2,
    DOWN = 3,
}
---@enum LevelStage
LevelStage = {
    STAGE_NULL = 0,
    STAGE1_1 = 1,
    STAGE1_2 = 2,
    STAGE2_1 = 3,
    STAGE2_2 = 4,
    STAGE3_1 = 5,
    STAGE3_2 = 6,
    STAGE4_1 = 7,
    STAGE4_2 = 8,
    STAGE4_3 = 9,
    STAGE5 = 10,
    STAGE6 = 11,
    STAGE7 = 12,
    STAGE8 = 13, -- Home
    NUM_STAGES = 14,
    STAGE1_GREED = 1,
    STAGE2_GREED = 2,
    STAGE3_GREED = 3,
    STAGE4_GREED = 4,
    STAGE5_GREED = 5,
    STAGE6_GREED = 6,
    STAGE7_GREED = 7,
    NUM_BACKWARDS_STAGES = 7, -- Save stages up to Mausoleum II for the Ascent (7 stages)
}
---@enum StageType
StageType = {
    STAGETYPE_ORIGINAL = 0,
    STAGETYPE_WOTL = 1,
    STAGETYPE_AFTERBIRTH = 2,
    STAGETYPE_GREEDMODE = 3, -- deprecated, Greed Mode no longer has its own stages
    STAGETYPE_REPENTANCE = 4,
    STAGETYPE_REPENTANCE_B = 5,
}
---@enum RoomType
RoomType = {
    ROOM_NULL = 0,
    ROOM_DEFAULT = 1,
    ROOM_SHOP = 2,
    ROOM_ERROR = 3,
    ROOM_TREASURE = 4,
    ROOM_BOSS = 5,
    ROOM_MINIBOSS = 6,
    ROOM_SECRET = 7,
    ROOM_SUPERSECRET = 8,
    ROOM_ARCADE = 9,
    ROOM_CURSE = 10,
    ROOM_CHALLENGE = 11,
    ROOM_LIBRARY = 12,
    ROOM_SACRIFICE = 13,
    ROOM_DEVIL = 14,
    ROOM_ANGEL = 15,
    ROOM_DUNGEON = 16,
    ROOM_BOSSRUSH = 17,
    ROOM_ISAACS = 18,
    ROOM_BARREN = 19,
    ROOM_CHEST = 20,
    ROOM_DICE = 21,
    ROOM_BLACK_MARKET = 22,
    ROOM_GREED_EXIT = 23,
    ROOM_PLANETARIUM = 24,
    ROOM_TELEPORTER = 25, -- Mausoleum teleporter entrance, currently unused
    ROOM_TELEPORTER_EXIT = 26, -- Mausoleum teleporter exit, currently unused
    ROOM_SECRET_EXIT = 27, -- Trapdoor room to the alt path floors
    ROOM_BLUE = 28, -- Blue Womb rooms spawned by Blue Key
    ROOM_ULTRASECRET = 29, -- Red secret rooms
    NUM_ROOMTYPES = 30,
}
---@enum RoomShape
RoomShape = {
    ROOMSHAPE_1x1 = 1,
    ROOMSHAPE_IH = 2,
    ROOMSHAPE_IV = 3,
    ROOMSHAPE_1x2 = 4,
    ROOMSHAPE_IIV = 5,
    ROOMSHAPE_2x1 = 6,
    ROOMSHAPE_IIH = 7,
    ROOMSHAPE_2x2 = 8,
    ROOMSHAPE_LTL = 9,
    ROOMSHAPE_LTR = 10,
    ROOMSHAPE_LBL = 11,
    ROOMSHAPE_LBR = 12,
    NUM_ROOMSHAPES = 13,
}
---@enum DoorSlot
DoorSlot = {
    NO_DOOR_SLOT = -1,
    LEFT0 = 0,
    UP0 = 1,
    RIGHT0 = 2,
    DOWN0 = 3,
    LEFT1 = 4,
    UP1 = 5,
    RIGHT1 = 6,
    DOWN1 = 7,
    NUM_DOOR_SLOTS = 8,
}
---@enum LevelCurse
LevelCurse = {
    CURSE_NONE = 0 << -1,
    CURSE_OF_DARKNESS = 1 << 0,
    CURSE_OF_LABYRINTH = 1 << 1,
    CURSE_OF_THE_LOST = 1 << 2,
    CURSE_OF_THE_UNKNOWN = 1 << 3,
    CURSE_OF_THE_CURSED = 1 << 4,
    CURSE_OF_MAZE = 1 << 5,
    CURSE_OF_BLIND = 1 << 6,
    CURSE_OF_GIANT = 1 << 7,
    NUM_CURSES = 9,
}
---@enum PlayerType
PlayerType = {
    PLAYER_POSSESSOR = -1,
    PLAYER_ISAAC = 0,
    PLAYER_MAGDALENE = 1,
    PLAYER_CAIN = 2,
    PLAYER_JUDAS = 3,
    PLAYER_BLUEBABY = 4,
    PLAYER_EVE = 5,
    PLAYER_SAMSON = 6,
    PLAYER_AZAZEL = 7,
    PLAYER_LAZARUS = 8,
    PLAYER_EDEN = 9,
    PLAYER_THELOST = 10,
    PLAYER_LAZARUS2 = 11,
    PLAYER_BLACKJUDAS = 12,
    PLAYER_LILITH = 13,
    PLAYER_KEEPER = 14,
    PLAYER_APOLLYON = 15,
    PLAYER_THEFORGOTTEN = 16,
    PLAYER_THESOUL = 17,
    PLAYER_BETHANY = 18,
    PLAYER_JACOB = 19,
    PLAYER_ESAU = 20,
    PLAYER_ISAAC_B = 21,
    PLAYER_MAGDALENE_B = 22,
    PLAYER_CAIN_B = 23,
    PLAYER_JUDAS_B = 24,
    PLAYER_BLUEBABY_B = 25,
    PLAYER_EVE_B = 26,
    PLAYER_SAMSON_B = 27,
    PLAYER_AZAZEL_B = 28,
    PLAYER_LAZARUS_B = 29,
    PLAYER_EDEN_B = 30,
    PLAYER_THELOST_B = 31,
    PLAYER_LILITH_B = 32,
    PLAYER_KEEPER_B = 33,
    PLAYER_APOLLYON_B = 34,
    PLAYER_THEFORGOTTEN_B = 35,
    PLAYER_BETHANY_B = 36,
    PLAYER_JACOB_B = 37,
    PLAYER_LAZARUS2_B = 38,
    PLAYER_JACOB2_B = 39,
    PLAYER_THESOUL_B = 40,
    NUM_PLAYER_TYPES = 41,
}
---@enum PlayerForm
PlayerForm = {
    PLAYERFORM_GUPPY = 0,
    PLAYERFORM_LORD_OF_THE_FLIES = 1,
    PLAYERFORM_MUSHROOM = 2,
    PLAYERFORM_ANGEL = 3,
    PLAYERFORM_BOB = 4,
    PLAYERFORM_DRUGS = 5,
    PLAYERFORM_MOM = 6,
    PLAYERFORM_BABY = 7,
    PLAYERFORM_EVIL_ANGEL = 8,
    PLAYERFORM_POOP = 9,
    PLAYERFORM_BOOK_WORM = 10,
    PLAYERFORM_ADULTHOOD = 11,
    PLAYERFORM_SPIDERBABY = 12,
    PLAYERFORM_STOMPY = 13,
    PLAYERFORM_FLIGHT = 14, -- AB+, unused
    NUM_PLAYER_FORMS = 15,
}
---@enum PillColor
PillColor = {
    PILL_NULL = 0,
    PILL_BLUE_BLUE = 1,
    PILL_WHITE_BLUE = 2,
    PILL_ORANGE_ORANGE = 3,
    PILL_WHITE_WHITE = 4,
    PILL_REDDOTS_RED = 5,
    PILL_PINK_RED = 6,
    PILL_BLUE_CADETBLUE = 7,
    PILL_YELLOW_ORANGE = 8,
    PILL_ORANGEDOTS_WHITE = 9,
    PILL_WHITE_AZURE = 10,
    PILL_BLACK_YELLOW = 11,
    PILL_WHITE_BLACK = 12,
    PILL_WHITE_YELLOW = 13,
    NUM_STANDARD_PILLS = 14,
    PILL_GOLD = 14,
    NUM_PILLS = 15,
    PILL_GIANT_FLAG = 0x800,
    PILL_COLOR_MASK = 0x7ff,
}
---@enum Music
Music = {
    MUSIC_NULL = 0,
    MUSIC_BASEMENT = 1,
    MUSIC_CAVES = 2,
    MUSIC_DEPTHS = 3,
    MUSIC_CELLAR = 4,
    MUSIC_CATACOMBS = 5,
    MUSIC_NECROPOLIS = 6,
    MUSIC_WOMB_UTERO = 7,
    MUSIC_GAME_OVER = 8,
    MUSIC_BOSS = 9,
    MUSIC_CATHEDRAL = 10,
    MUSIC_SHEOL = 11,
    MUSIC_DARK_ROOM = 12,
    MUSIC_CHEST = 13,
    MUSIC_BURNING_BASEMENT = 14,
    MUSIC_FLOODED_CAVES = 15,
    MUSIC_DANK_DEPTHS = 16,
    MUSIC_SCARRED_WOMB = 17,
    MUSIC_BLUE_WOMB = 18,
    MUSIC_UTERO = 19,
    MUSIC_MOM_BOSS = 20,
    MUSIC_MOMS_HEART_BOSS = 21,
    MUSIC_ISAAC_BOSS = 22,
    MUSIC_SATAN_BOSS = 23,
    MUSIC_DARKROOM_BOSS = 24,
    MUSIC_BLUEBABY_BOSS = 25,
    MUSIC_BOSS2 = 26,
    MUSIC_HUSH_BOSS = 27,
    MUSIC_ULTRAGREED_BOSS = 28,
    MUSIC_LIBRARY_ROOM = 30,
    MUSIC_SECRET_ROOM = 31,
    MUSIC_SECRET_ROOM2 = 32,
    MUSIC_DEVIL_ROOM = 33,
    MUSIC_ANGEL_ROOM = 34,
    MUSIC_SHOP_ROOM = 35,
    MUSIC_ARCADE_ROOM = 36,
    MUSIC_BOSS_OVER = 37,
    MUSIC_CHALLENGE_FIGHT = 38,
    MUSIC_BOSS_RUSH = 39,
    MUSIC_JINGLE_BOSS_RUSH_OUTRO = 40,
    MUSIC_BOSS3 = 41,
    MUSIC_JINGLE_BOSS_OVER3 = 42,
    MUSIC_MOTHER_BOSS = 43,
    MUSIC_DOGMA_BOSS = 44,
    MUSIC_BEAST_BOSS = 45,
    MUSIC_JINGLE_MOTHER_OVER = 47,
    MUSIC_JINGLE_DOGMA_OVER = 48,
    MUSIC_JINGLE_BEAST_OVER = 49,
    MUSIC_PLANETARIUM = 50,
    MUSIC_SECRET_ROOM_ALT_ALT = 51,
    MUSIC_BOSS_OVER_TWISTED = 52,
    MUSIC_CREDITS = 60,
    MUSIC_TITLE = 61,
    MUSIC_TITLE_AFTERBIRTH = 62,
    MUSIC_TITLE_REPENTANCE = 63,
    MUSIC_JINGLE_GAME_START_ALT = 64,
    MUSIC_JINGLE_NIGHTMARE_ALT = 65,
    MUSIC_MOTHERS_SHADOW_INTRO = 66,
    MUSIC_DOGMA_INTRO = 67,
    MUSIC_STRANGE_DOOR_JINGLE = 68,
    MUSIC_DARK_CLOSET = 69,
    MUSIC_CREDITS_ALT = 70,
    MUSIC_CREDITS_ALT_FINAL = 71,
    MUSIC_JINGLE_BOSS = 81,
    MUSIC_JINGLE_BOSS_OVER = 83,
    MUSIC_JINGLE_HOLYROOM_FIND = 84,
    MUSIC_JINGLE_SECRETROOM_FIND = 85,
    MUSIC_JINGLE_TREASUREROOM_ENTRY_0 = 87,
    MUSIC_JINGLE_TREASUREROOM_ENTRY_1 = 88,
    MUSIC_JINGLE_TREASUREROOM_ENTRY_2 = 89,
    MUSIC_JINGLE_TREASUREROOM_ENTRY_3 = 90,
    MUSIC_JINGLE_CHALLENGE_ENTRY = 91,
    MUSIC_JINGLE_CHALLENGE_OUTRO = 92,
    MUSIC_JINGLE_GAME_OVER = 93,
    MUSIC_JINGLE_DEVILROOM_FIND = 94,
    MUSIC_JINGLE_GAME_START = 95,
    MUSIC_JINGLE_NIGHTMARE = 96,
    MUSIC_JINGLE_BOSS_OVER2 = 97,
    MUSIC_JINGLE_HUSH_OVER = 98,
    MUSIC_INTRO_VOICEOVER = 100,
    MUSIC_EPILOGUE_VOICEOVER = 101,
    MUSIC_VOID = 102,
    MUSIC_VOID_BOSS = 103,
    MUSIC_DOWNPOUR = 104,
    MUSIC_MINES = 105,
    MUSIC_MAUSOLEUM = 106,
    MUSIC_CORPSE = 107,
    MUSIC_DROSS = 108,
    MUSIC_ASHPIT = 109,
    MUSIC_GEHENNA = 110,
    MUSIC_MORTIS = 111, -- unused
    MUSIC_ISAACS_HOUSE = 112,
    MUSIC_FINAL_VOICEOVER = 113,
    MUSIC_DOWNPOUR_REVERSE = 114,
    MUSIC_DROSS_REVERSE = 115,
    MUSIC_MINESHAFT_AMBIENT = 116,
    MUSIC_MINESHAFT_ESCAPE = 117,
    MUSIC_REVERSE_GENESIS = 118,
    NUM_MUSIC = 119,
}
---@enum SoundEffect
SoundEffect = {
    SOUND_NULL = 0,
    SOUND_1UP = 1,
    SOUND_BIRD_FLAP = 2,
    SOUND_BLOBBY_WIGGLE = 3,
    SOUND_INSECT_SWARM_LOOP = 4,
    SOUND_BLOOD_LASER = 5,
    SOUND_BLOOD_LASER_SMALL = 6, -- new
    SOUND_BLOOD_LASER_LARGE = 7,
    SOUND_BOOK_PAGE_TURN_12 = 8,
    SOUND_BOSS_BUG_HISS = 9,
    SOUND_BLOOD_LASER_LARGER = 10, -- new
    SOUND_BOSS_GURGLE_ROAR = 11,
    SOUND_BOSS_LITE_GURGLE = 12,
    SOUND_BOSS_LITE_HISS = 13,
    SOUND_BOSS_LITE_ROAR = 14,
    SOUND_BOSS_LITE_SLOPPY_ROAR = 15,
    SOUND_BOSS_SPIT_BLOB_BARF = 16,
    SOUND_PAPER_IN = 17, -- new
    SOUND_PAPER_OUT = 18, -- new
    SOUND_CHEST_DROP = 21,
    SOUND_CHEST_OPEN = 22,
    SOUND_CHOIR_UNLOCK = 23,
    SOUND_COIN_SLOT = 24,
    SOUND_CUTE_GRUNT = 25,
    SOUND_DEATH_BURST_BONE = 27, -- new
    SOUND_DEATH_BURST_LARGE = 28,
    SOUND_DEATH_REVERSE = 29, -- new
    SOUND_DEATH_BURST_SMALL = 30,
    SOUND_DEATH_CARD = 33,
    SOUND_DEVIL_CARD = 34,
    SOUND_DOOR_HEAVY_CLOSE = 35,
    SOUND_DOOR_HEAVY_OPEN = 36,
    SOUND_FART = 37,
    SOUND_FETUS_JUMP = 38,
    SOUND_FETUS_LAND = 40,
    SOUND_FIREDEATH_HISS = 43,
    SOUND_FLOATY_BABY_ROAR = 44,
    SOUND_COIN_INSERT = 45, -- new
    SOUND_METAL_DOOR_CLOSE = 46, -- new
    SOUND_METAL_DOOR_OPEN = 47, -- new
    SOUND_FORESTBOSS_STOMPS = 48,
    SOUND_SCYTHE_BREAK = 49, -- new
    SOUND_STONE_WALKER = 50, -- new
    SOUND_GASCAN_POUR = 51,
    SOUND_HELLBOSS_GROUNDPOUND = 52,
    SOUND_GLASS_BREAK = 53, -- new
    SOUND_HOLY = 54,
    SOUND_ISAAC_HURT_GRUNT = 55,
    SOUND_CHILD_HAPPY_ROAR_SHORT = 56,
    SOUND_CHILD_ANGRY_ROAR = 57,
    SOUND_KEYPICKUP_GAUNTLET = 58,
    SOUND_KEY_DROP0 = 59,
    SOUND_BABY_HURT = 60,
    SOUND_MAGGOT_BURST_OUT = 64,
    SOUND_MAGGOT_ENTER_GROUND = 66,
    SOUND_MEAT_FEET_SLOW0 = 68,
    SOUND_MEAT_IMPACTS = 69,
    SOUND_MEAT_IMPACTS_OLD = 70,
    SOUND_MEAT_JUMPS = 72,
    SOUND_MEATY_DEATHS = 77,
    SOUND_POT_BREAK_2 = 78, -- new
    SOUND_MUSHROOM_POOF_2 = 79, -- new
    SOUND_BLACK_POOF = 80, -- new
    SOUND_STATIC = 81, -- new
    SOUND_MOM_VOX_DEATH = 82,
    SOUND_MOM_VOX_EVILLAUGH = 84,
    SOUND_MOM_VOX_FILTERED_DEATH_1 = 85,
    SOUND_MOM_VOX_FILTERED_EVILLAUGH = 86,
    SOUND_MOM_VOX_FILTERED_HURT = 87,
    SOUND_MOM_VOX_FILTERED_ISAAC = 90,
    SOUND_MOM_VOX_GRUNT = 93,
    SOUND_MOM_VOX_HURT = 97,
    SOUND_MOM_VOX_ISAAC = 101,
    SOUND_MONSTER_GRUNT_0 = 104,
    SOUND_MONSTER_GRUNT_1 = 106,
    SOUND_MONSTER_GRUNT_2 = 108,
    SOUND_MONSTER_GRUNT_4 = 112,
    SOUND_MONSTER_GRUNT_5 = 114,
    SOUND_MONSTER_ROAR_0 = 115,
    SOUND_MONSTER_ROAR_1 = 116,
    SOUND_MONSTER_ROAR_2 = 117,
    SOUND_MONSTER_ROAR_3 = 118,
    SOUND_MONSTER_YELL_A = 119,
    SOUND_MONSTER_YELL_B = 122,
    SOUND_POWERUP1 = 128,
    SOUND_POWERUP2 = 129,
    SOUND_POWERUP3 = 130,
    SOUND_POWERUP_SPEWER = 132,
    SOUND_REDLIGHTNING_ZAP = 133,
    SOUND_REDLIGHTNING_ZAP_WEAK = 134, -- new
    SOUND_REDLIGHTNING_ZAP_STRONG = 135, -- new
    SOUND_REDLIGHTNING_ZAP_BURST = 136, -- new
    SOUND_ROCK_CRUMBLE = 137,
    SOUND_POT_BREAK = 138,
    SOUND_MUSHROOM_POOF = 139,
    SOUND_ROCKET_BLAST_DEATH = 141,
    SOUND_SMB_LARGE_CHEWS_4 = 142,
    SOUND_SCARED_WHIMPER = 143,
    SOUND_SHAKEY_KID_ROAR = 146,
    SOUND_SINK_DRAIN_GURGLE = 149,
    SOUND_TEARIMPACTS = 150,
    SOUND_TEARS_FIRE = 153,
    SOUND_UNLOCK00 = 156,
    SOUND_VAMP_GULP = 157,
    SOUND_WHEEZY_COUGH = 158,
    SOUND_SPIDER_COUGH = 159,
    SOUND_PORTAL_OPEN = 160,
    SOUND_PORTAL_LOOP = 161,
    SOUND_PORTAL_SPAWN = 162,
    SOUND_TAR_LOOP = 163,
    SOUND_ZOMBIE_WALKER_KID = 165,
    SOUND_ANIMAL_SQUISH = 166,
    SOUND_ANGRY_GURGLE = 167,
    SOUND_BAND_AID_PICK_UP = 169,
    SOUND_BATTERYCHARGE = 170,
    SOUND_BEEP = 171,
    SOUND_LIGHTBOLT = 172, -- new
    SOUND_LIGHTBOLT_CHARGE = 173, -- new
    SOUND_BLOODBANK_TOUCHED = 174,
    SOUND_BLOODBANK_SPAWN = 175,
    SOUND_BLOODSHOOT = 178,
    SOUND_BOIL_HATCH = 181,
    SOUND_BOSS1_EXPLOSIONS = 182,
    SOUND_EXPLOSION_WEAK = 183, -- new
    SOUND_EXPLOSION_STRONG = 184, -- new
    SOUND_BOSS2_BUBBLES = 185,
    SOUND_EXPLOSION_DEBRIS = 186, -- new
    SOUND_BOSS2INTRO_ERRORBUZZ = 187,
    SOUND_CASTLEPORTCULLIS = 190,
    SOUND_CHARACTER_SELECT_LEFT = 194,
    SOUND_CHARACTER_SELECT_RIGHT = 195,
    SOUND_DERP = 197,
    SOUND_DIMEDROP = 198,
    SOUND_DIMEPICKUP = 199,
    SOUND_LUCKYPICKUP = 200,
    SOUND_FETUS_FEET = 201,
    SOUND_GOLDENKEY = 204,
    SOUND_GOOATTACH0 = 205,
    SOUND_GOODEATH = 207,
    SOUND_HAND_LASERS = 211,
    SOUND_HEARTIN = 212,
    SOUND_HEARTOUT = 213,
    SOUND_HELL_PORTAL1 = 214,
    SOUND_HELL_PORTAL2 = 215,
    SOUND_ISAACDIES = 217,
    SOUND_ITEMRECHARGE = 218,
    SOUND_KISS_LIPS1 = 219,
    SOUND_LEECH = 221,
    SOUND_MAGGOTCHARGE = 224,
    SOUND_MEATHEADSHOOT = 226,
    SOUND_METAL_BLOCKBREAK = 229,
    SOUND_NICKELDROP = 231,
    SOUND_NICKELPICKUP = 232,
    SOUND_PENNYDROP = 233,
    SOUND_PENNYPICKUP = 234,
    SOUND_PLOP = 237,
    SOUND_SATAN_APPEAR = 238,
    SOUND_SATAN_BLAST = 239,
    SOUND_SATAN_CHARGE_UP = 240,
    SOUND_SATAN_GROW = 241,
    SOUND_SATAN_HURT = 242,
    SOUND_SATAN_RISE_UP = 243,
    SOUND_SATAN_SPIT = 245,
    SOUND_SATAN_STOMP = 246,
    SOUND_SCAMPER = 249,
    SOUND_SHELLGAME = 252,
    SOUND_SLOTSPAWN = 255,
    SOUND_SPLATTER = 258,
    SOUND_STEAM_HALFSEC = 261,
    SOUND_STONESHOOT = 262,
    SOUND_WEIRD_WORM_SPIT = 263,
    SOUND_SUMMONSOUND = 265,
    SOUND_SUPERHOLY = 266,
    SOUND_THUMBS_DOWN = 267,
    SOUND_THUMBSUP = 268,
    SOUND_FIRE_BURN = 269,
    SOUND_HAPPY_RAINBOW = 270,
    SOUND_LASERRING = 271, -- new (ab)
    SOUND_LASERRING_WEAK = 272, -- new (ab)
    SOUND_LASERRING_STRONG = 273, -- new (ab)
    SOUND_CASH_REGISTER = 274, -- new (ab+)
    SOUND_ANGEL_WING = 275,
    SOUND_ANGEL_BEAM = 276,
    SOUND_HOLY_MANTLE = 277,
    SOUND_MEGA_BLAST_START = 278,
    SOUND_MEGA_BLAST_LOOP = 279,
    SOUND_MEGA_BLAST_END = 280,
    SOUND_BLOOD_LASER_LOOP = 281,
    SOUND_MENU_SCROLL = 282,
    SOUND_MENU_NOTE_APPEAR = 283,
    SOUND_MENU_NOTE_HIDE = 284,
    SOUND_MENU_CHARACTER_SELECT = 285,
    SOUND_SUMMON_POOF = 286,
    SOUND_BOO_MAD = 300,
    SOUND_FART_GURG = 301,
    SOUND_FAT_GRUNT = 302,
    SOUND_FAT_WIGGLE = 303,
    SOUND_FIRE_RUSH = 304,
    SOUND_GHOST_ROAR = 305,
    SOUND_GHOST_SHOOT = 306,
    SOUND_GRROOWL = 307,
    SOUND_GURG_BARF = 308,
    SOUND_INHALE = 309,
    SOUND_LOW_INHALE = 310,
    SOUND_MEGA_PUKE = 311,
    SOUND_MOUTH_FULL = 312,
    SOUND_MULTI_SCREAM = 313,
    SOUND_SKIN_PULL = 314,
    SOUND_WHISTLE = 315,
    SOUND_DEVILROOM_DEAL = 316,
    SOUND_SPIDER_SPIT_ROAR = 317,
    SOUND_WORM_SPIT = 318,
    SOUND_LITTLE_SPIT = 319,
    SOUND_SATAN_ROOM_APPEAR = 320,
    SOUND_HEARTBEAT = 321,
    SOUND_HEARTBEAT_FASTER = 322,
    SOUND_HEARTBEAT_FASTEST = 323,
    SOUND_48_HR_ENERGY = 324,
    SOUND_ALGIZ = 325,
    SOUND_AMNESIA = 326,
    SOUND_ANZUS = 327,
    SOUND_BAD_GAS = 328,
    SOUND_BAD_TRIP = 329,
    SOUND_BALLS_OF_STEEL = 330,
    SOUND_BERKANO = 331,
    SOUND_BOMBS_ARE_KEY = 332,
    SOUND_CARD_VS_HUMAN = 333,
    SOUND_CHAOS_CARD = 334,
    SOUND_CREDIT_CARD = 335,
    SOUND_DAGAZ = 336,
    SOUND_DEATH = 337,
    SOUND_EHWAZ = 338,
    SOUND_EXPLOSIVE_DIAH = 339,
    SOUND_FULL_HP = 340,
    SOUND_HAGALAZ = 341,
    SOUND_HP_DOWN = 342,
    SOUND_HP_UP = 343,
    SOUND_HEMATEMISIS = 344,
    SOUND_I_FOUND_PILLS = 345,
    SOUND_JERA = 346,
    SOUND_JOKER = 347,
    SOUND_JUDGEMENT = 348,
    SOUND_JUSTICE = 349,
    SOUND_LEMON_PARTY = 350,
    SOUND_LUCK_DOWN = 351,
    SOUND_LUCK_UP = 352,
    SOUND_PARALYSIS = 353,
    SOUND_PERTHRO = 354,
    SOUND_PHEROMONES = 355,
    SOUND_PRETTY_FLY = 356,
    SOUND_PUBERTY = 357,
    SOUND_RUA_WIZ = 358,
    SOUND_RANGE_DOWN = 359,
    SOUND_RANGE_UP = 360,
    SOUND_RULES_CARD = 361,
    SOUND_SEE_4EVER = 362,
    SOUND_SPEED_DOWN = 363,
    SOUND_SPEED_UP = 364,
    SOUND_STRENGTH = 365,
    SOUND_SUICIDE_KING = 366,
    SOUND_TEARS_DOWN = 367,
    SOUND_TEARS_UP = 368,
    SOUND_TELEPILLS = 369,
    SOUND_TEMPERANCE = 370,
    SOUND_THE_CHARIOT = 371,
    SOUND_THE_DEVIL = 372,
    SOUND_THE_EMPEROR = 373,
    SOUND_EMPRESS = 374,
    SOUND_FOOL = 375,
    SOUND_HANGED_MAN = 376,
    SOUND_HERMIT = 377,
    SOUND_HIEROPHANT = 378,
    SOUND_HIGHT_PRIESTESS = 379,
    SOUND_THE_LOVERS = 380,
    SOUND_MAGICIAN = 381,
    SOUND_MOON = 382,
    SOUND_STARS = 383,
    SOUND_SUN = 384,
    SOUND_TOWER = 385,
    SOUND_WORLD = 386,
    SOUND_TWO_CLUBS = 387,
    SOUND_TWO_DIAMONDS = 388,
    SOUND_TWO_HEARTS = 389,
    SOUND_TWO_SPADES = 390,
    SOUND_WHEEL_OF_FORTUNE = 391,
    SOUND_RAGMAN_1 = 392,
    SOUND_RAGMAN_2 = 393,
    SOUND_RAGMAN_3 = 394,
    SOUND_RAGMAN_4 = 395,
    SOUND_FLUSH = 396,
    SOUND_WATER_DROP = 397,
    SOUND_WET_FEET = 398,
    SOUND_ADDICTED = 399,
    SOUND_DICE_SHARD = 400,
    SOUND_EMERGENCY = 401,
    SOUND_INFESTED_EXCL = 402,
    SOUND_INFESTED_QUEST = 403,
    SOUND_JAIL_CARD = 404,
    SOUND_LARGER = 405,
    SOUND_PERCS = 406,
    SOUND_POWER_PILL = 407,
    SOUND_QUESTION_MARK = 408,
    SOUND_RELAX = 409,
    SOUND_RETRO = 410,
    SOUND_SMALL = 411,
    SOUND_QQQ = 412, -- ??? pill
    SOUND_DANGLE_WHISTLE = 413,
    SOUND_LITTLE_HORN_COUGH = 414,
    SOUND_LITTLE_HORN_GRUNT_1 = 415,
    SOUND_LITTLE_HORN_GRUNT_2 = 416,
    SOUND_THE_FORSAKEN_LAUGH = 417,
    SOUND_THE_FORSAKEN_SCREAM = 418,
    SOUND_THE_STAIN_BURST = 419,
    SOUND_BROWNIE_LAUGH = 420,
    SOUND_HUSH_ROAR = 421,
    SOUND_HUSH_GROWL = 422,
    SOUND_HUSH_LOW_ROAR = 423,
    SOUND_FRAIL_CHARGE = 424,
    SOUND_HUSH_CHARGE = 425,
    SOUND_MAW_OF_VOID = 426,
    SOUND_ULTRA_GREED_COIN_DESTROY = 427,
    SOUND_ULTRA_GREED_COINS_FALLING = 428,
    SOUND_ULTRA_GREED_DEATH_SCREAM = 429,
    SOUND_ULTRA_GREED_TURN_GOLD_1 = 430,
    SOUND_ULTRA_GREED_TURN_GOLD_2 = 431,
    SOUND_ULTRA_GREED_ROAR_1 = 432,
    SOUND_ULTRA_GREED_ROAR_2 = 433,
    SOUND_ULTRA_GREED_SPIT = 434,
    SOUND_ULTRA_GREED_PULL_SLOT = 435,
    SOUND_ULTRA_GREED_SLOT_SPIN_LOOP = 436,
    SOUND_ULTRA_GREED_SLOT_STOP = 437,
    SOUND_ULTRA_GREED_SLOT_WIN_LOOP_END = 438,
    SOUND_ULTRA_GREED_SLOT_WIN_LOOP = 439,
    SOUND_ULTRA_GREED_SPINNING = 440,
    SOUND_DOG_BARK = 441,
    SOUND_DOG_HOWELL = 442,
    SOUND_X_LAX = 443,
    SOUND_WRONG = 444,
    SOUND_VURP = 445,
    SOUND_SUNSHINE = 446,
    SOUND_SPADES = 447,
    SOUND_HORF = 448,
    SOUND_HOLY_CARD = 449,
    SOUND_HEARTS = 450,
    SOUND_GULP = 451,
    SOUND_FRIENDS = 452,
    SOUND_EXCITED = 453,
    SOUND_DROWSY = 454,
    SOUND_DIAMONDS = 455,
    SOUND_CLUBS = 456,
    SOUND_BLACK_RUNE = 457,
    SOUND_PING_PONG = 458,
    SOUND_SPEWER = 459,
    SOUND_MOM_FOOTSTEPS = 460,
    SOUND_BONE_HEART = 461,
    SOUND_BONE_SNAP = 462,
    SOUND_SHOVEL_DROP = 463,
    SOUND_SHOVEL_DIG = 464,
    SOUND_GOLD_HEART = 465,
    SOUND_GOLD_HEART_DROP = 466,
    SOUND_BONE_DROP = 467,
    SOUND_UNHOLY = 468,
    SOUND_BUTTON_PRESS = 469,
    SOUND_GOLDENBOMB = 470,
    SOUND_CANDLE_LIGHT = 471,
    SOUND_THUNDER = 472,
    SOUND_WATER_FLOW_LOOP = 473,
    SOUND_BOSS2_DIVE = 474,
    SOUND_BOSS2INTRO_PIPES_TURNON = 475,
    SOUND_WATER_FLOW_LARGE = 476,
    SOUND_DEMON_HIT = 477,
    SOUND_PUNCH = 478,
    SOUND_FLUTE = 479,
    SOUND_LAVA_LOOP = 480,
    SOUND_WOOD_PLANK_BREAK = 481,
    SOUND_BULLET_SHOT = 482,
    SOUND_FLAME_BURST = 483,
    SOUND_INFLATE = 484,
    SOUND_CLAP = 485,
    SOUND_BOSS2INTRO_WATER_EXPLOSION = 486,
    SOUND_STONE_IMPACT = 487,
    SOUND_BOSS2_WATERTHRASHING = 488,
    SOUND_FART_MEGA = 489,
    SOUND_MATCHSTICK = 490,
    SOUND_FORTUNE_COOKIE = 491,
    SOUND_BULB_FLASH = 492,
    SOUND_BATTERYDISCHARGE = 493,
    SOUND_WHIP = 494,
    SOUND_WHIP_HIT = 495,
    SOUND_FREEZE = 496,
    SOUND_ROTTEN_HEART = 497,
    SOUND_FREEZE_SHATTER = 498,
    SOUND_BONE_BOUNCE = 499,
    SOUND_BONE_BREAK = 500,
    SOUND_BISHOP_HIT = 501,
    SOUND_CHAIN_LOOP = 503,
    SOUND_CHAIN_BREAK = 504,
    SOUND_MINECART_LOOP = 505,
    SOUND_TOOTH_AND_NAIL = 506,
    SOUND_TOOTH_AND_NAIL_TICK = 507,
    SOUND_STATIC_BUILDUP = 508,
    SOUND_THREAD_SNAP = 509,
    SOUND_BIG_LEECH = 510,
    SOUND_REVERSE_EXPLOSION = 511,
    SOUND_REVERSE_FOOL = 512,
    SOUND_REVERSE_MAGICIAN = 513,
    SOUND_REVERSE_HIGH_PRIESTESS = 514,
    SOUND_REVERSE_EMPRESS = 515,
    SOUND_REVERSE_EMPEROR = 516,
    SOUND_REVERSE_HIEROPHANT = 517,
    SOUND_REVERSE_LOVERS = 518,
    SOUND_REVERSE_CHARIOT = 519,
    SOUND_REVERSE_JUSTICE = 520,
    SOUND_REVERSE_HERMIT = 521,
    SOUND_REVERSE_WHEEL_OF_FORTUNE = 522,
    SOUND_REVERSE_STRENGTH = 523,
    SOUND_REVERSE_HANGED_MAN = 524,
    SOUND_REVERSE_DEATH = 525,
    SOUND_REVERSE_TEMPERANCE = 526,
    SOUND_REVERSE_DEVIL = 527,
    SOUND_REVERSE_TOWER = 528,
    SOUND_REVERSE_STARS = 529,
    SOUND_REVERSE_MOON = 530,
    SOUND_REVERSE_SUN = 531,
    SOUND_REVERSE_JUDGEMENT = 532,
    SOUND_REVERSE_WORLD = 533,
    SOUND_FLAMETHROWER_START = 534,
    SOUND_FLAMETHROWER_LOOP = 535,
    SOUND_FLAMETHROWER_END = 536,
    SOUND_ROCKET_LAUNCH = 537,
    SOUND_SWORD_SPIN = 538,
    SOUND_BABY_BRIM = 539,
    SOUND_KNIFE_PULL = 540,
    SOUND_DOGMA_APPEAR_SCREAM = 541,
    SOUND_DOGMA_DEATH = 542,
    SOUND_DOGMA_BLACKHOLE_CHARGE = 543,
    SOUND_DOGMA_BLACKHOLE_SHOOT = 544,
    SOUND_DOGMA_BLACKHOLE_OPEN = 545,
    SOUND_DOGMA_BLACKHOLE_CLOSE = 546,
    SOUND_DOGMA_BRIMSTONE_CHARGE = 547,
    SOUND_DOGMA_BRIMSTONE_SHOOT = 548,
    SOUND_DOGMA_GODHEAD = 549,
    SOUND_DOGMA_JACOBS = 550,
    SOUND_DOGMA_JACOBS_ZAP = 551,
    SOUND_DOGMA_SCREAM = 552,
    SOUND_DOGMA_PREACHER = 553,
    SOUND_DOGMA_RING_START = 554,
    SOUND_DOGMA_RING_LOOP = 555,
    SOUND_DOGMA_FEATHER_SPRAY = 556,
    SOUND_DOGMA_JACOBS_DOT = 557,
    SOUND_DOGMA_BLACKHOLE_LOOP = 558,
    SOUND_DOGMA_ANGEL_TRANSFORM = 559,
    SOUND_DOGMA_ANGEL_TRANSFORM_END = 560,
    SOUND_DOGMA_LIGHT_APPEAR = 561,
    SOUND_DOGMA_LIGHT_BALL_THROW = 562,
    SOUND_DOGMA_LIGHT_RAY_CHARGE = 563,
    SOUND_DOGMA_LIGHT_RAY_FIRE = 564,
    SOUND_DOGMA_SPIN_ATTACK = 565,
    SOUND_DOGMA_WING_FLAP = 566,
    SOUND_DOGMA_TV_BREAK = 567,
    SOUND_DIVINE_INTERVENTION = 568,
    SOUND_MENU_FLIP_LIGHT = 569,
    SOUND_MENU_FLIP_DARK = 570,
    SOUND_MENU_RIP = 571,
    SOUND_URN_OPEN = 572,
    SOUND_URN_CLOSE = 573,
    SOUND_RECALL = 574,
    SOUND_LARYNX_SCREAM_LO = 575,
    SOUND_LARYNX_SCREAM_MED = 576,
    SOUND_LARYNX_SCREAM_HI = 577,
    SOUND_GROUND_TREMOR = 578,
    SOUND_SOUL_PICKUP = 579,
    SOUND_BALL_AND_CHAIN_LOOP = 580,
    SOUND_BALL_AND_CHAIN_HIT = 581,
    SOUND_LAZARUS_FLIP_DEAD = 582,
    SOUND_LAZARUS_FLIP_ALIVE = 583,
    SOUND_RECALL_FINISH = 584,
    SOUND_ROCKET_LAUNCH_SHORT = 585,
    SOUND_ROCKET_LAUNCH_TINY = 586,
    SOUND_ROCKET_EXPLOSION = 587,
    SOUND_JELLY_BOUNCE = 588,
    SOUND_POOP_LASER = 589,
    SOUND_POISON_WARN = 590,
    SOUND_POISON_HURT = 591,
    SOUND_BERSERK_START = 592,
    SOUND_BERSERK_TICK = 593,
    SOUND_BERSERK_END = 594,
    SOUND_EDEN_GLITCH = 595,
    SOUND_RAILROAD_TRACK_RAISE = 596,
    SOUND_RAILROAD_TRACK_RAISE_FAR = 597,
    SOUND_MOM_AND_DAD_1 = 598,
    SOUND_MOM_AND_DAD_2 = 599,
    SOUND_MOM_AND_DAD_3 = 600,
    SOUND_MOM_AND_DAD_4 = 601,
    SOUND_THUMBSUP_AMPLIFIED = 602,
    SOUND_THUMBSDOWN_AMPLIFIED = 603,
    SOUND_POWERUP_SPEWER_AMPLIFIED = 604,
    SOUND_POOPITEM_THROW = 605,
    SOUND_POOPITEM_STORE = 606,
    SOUND_POOPITEM_HOLD = 607,
    SOUND_MIRROR_ENTER = 608,
    SOUND_MIRROR_EXIT = 609,
    SOUND_MIRROR_BREAK = 610,
    SOUND_ANIMA_TRAP = 611,
    SOUND_ANIMA_RATTLE = 612,
    SOUND_ANIMA_BREAK = 613,
    SOUND_VAMP_DOUBLE = 614,
    SOUND_FLASHBACK = 615,
    SOUND_DARK_ESAU_OPEN = 616,
    SOUND_DARK_ESAU_DEATH_OPEN = 617,
    SOUND_MOTHER_DEATH1 = 618,
    SOUND_MOTHER_DEATH2 = 619,
    SOUND_MOTHER_FISTPOUND1 = 620,
    SOUND_MOTHER_FISTPOUND2 = 621,
    SOUND_MOTHER_FISTPOUND3 = 622,
    SOUND_MOTHER_FISTULA = 623,
    SOUND_MOTHER_APPEAR1 = 624,
    SOUND_MOTHER_APPEAR2 = 625,
    SOUND_MOTHER_KNIFE_START = 626,
    SOUND_MOTHER_KNIFE_THROW = 627,
    SOUND_MOTHER_SUMMON_ISAACS_START = 628,
    SOUND_MOTHER_SUMMON_ISAACS_END = 629,
    SOUND_MOTHER_HAND_BOIL_START = 630,
    SOUND_MOTHER_GRUNT1 = 631,
    SOUND_MOTHER_GRUNT5 = 632,
    SOUND_MOTHER_GRUNT6 = 633,
    SOUND_MOTHER_GRUNT7 = 634,
    SOUND_MOTHER_LAUGH = 635,
    SOUND_MOTHER_SPIN_START = 636,
    SOUND_MOTHER_WALL_SHOT_START = 637,
    SOUND_MOTHER_MISC = 638,
    SOUND_MOTHER_SHOOT = 639,
    SOUND_MOTHER_SUCTION = 640,
    SOUND_MOTHER_ISAAC_RISE = 641,
    SOUND_MOTHER_ISAAC_HIT = 642,
    SOUND_MOTHER_WRIST_SWELL = 643,
    SOUND_MOTHER_WRIST_EXPLODE = 644,
    SOUND_MOTHER_DEATH_MELT = 645,
    SOUND_MOTHER_ANGER_SHAKE = 646,
    SOUND_MOTHER_CHARGE1 = 647,
    SOUND_MOTHER_CHARGE2 = 648,
    SOUND_MOTHER_LAND_SMASH = 649,
    SOUND_ISAAC_ROAR = 650,
    SOUND_FAMINE_APPEAR = 651,
    SOUND_FAMINE_DEATH_1 = 652,
    SOUND_FAMINE_DEATH_2 = 653,
    SOUND_FAMINE_DASH_START = 654,
    SOUND_FAMINE_DASH = 655,
    SOUND_FAMINE_SHOOT = 656,
    SOUND_FAMINE_BURST = 657,
    SOUND_FAMINE_GURGLE = 658,
    SOUND_PESTILENCE_MAGGOT_START = 659,
    SOUND_PESTILENCE_MAGGOT_SHOOT = 660,
    SOUND_PESTILENCE_MAGGOT_RETURN = 661,
    SOUND_PESTILENCE_BODY_SHOOT = 662,
    SOUND_PESTILENCE_HEAD_DEATH = 663,
    SOUND_PESTILENCE_DEATH = 664,
    SOUND_PESTILENCE_COUGH = 665,
    SOUND_PESTILENCE_BARF = 666,
    SOUND_PESTILENCE_APPEAR = 667,
    SOUND_PESTILENCE_HEAD_EXPLODE = 668,
    SOUND_PESTILENCE_MAGGOT_ENTER = 669,
    SOUND_PESTILENCE_MAGGOT_POPOUT = 670,
    SOUND_PESTILENCE_MAGGOT_SHOOT2 = 671,
    SOUND_PESTILENCE_NECK_PUKE = 672,
    SOUND_PESTILENCE_PUKE_START = 673,
    SOUND_WAR_APPEAR = 674,
    SOUND_WAR_APPEAR_LAVA = 675,
    SOUND_WAR_BOMB_TOSS = 676,
    SOUND_WAR_DASH_START = 677,
    SOUND_WAR_DASH = 678,
    SOUND_WAR_HORSE_DEATH = 679,
    SOUND_WAR_DEATH = 680,
    SOUND_WAR_FIRE_SCREEM = 681,
    SOUND_WAR_GRAB_PLAYER = 682,
    SOUND_WAR_BOMB_HOLD = 683,
    SOUND_WAR_BOMB_PULL_OUT = 684,
    SOUND_WAR_CHASE = 685,
    SOUND_WAR_BOMB_TICK = 686,
    SOUND_WAR_FLAME = 687,
    SOUND_WAR_LAVA_SPLASH = 688,
    SOUND_WAR_LAVA_DASH = 689,
    SOUND_DEATH_DIES = 690,
    SOUND_DEATH_DESTROY_SKULLS = 691,
    SOUND_DEATH_GROWL = 692,
    SOUND_DEATH_SWIPE_START = 693,
    SOUND_DEATH_SWIPE = 694,
    SOUND_DEATH_SUMMON_SCYTHES = 695,
    SOUND_DEATH_SUMMON_SKULLS = 696,
    SOUND_BEAST_DEATH = 697,
    SOUND_BEAST_LASER = 698,
    SOUND_BEAST_BACKGROUND_DIVE = 699,
    SOUND_BEAST_FIRE_RING = 700,
    SOUND_BEAST_GHOST_DASH = 701,
    SOUND_BEAST_GHOST_RISE = 702,
    SOUND_BEAST_LAVA_BALL_SPLASH = 703,
    SOUND_BEAST_LAVA_RISE = 704,
    SOUND_BEAST_SUCTION_LOOP = 705,
    SOUND_BEAST_FIRE_BARF = 706,
    SOUND_BEAST_GHOST_ROAR = 707,
    SOUND_BEAST_INTRO_SCREAM = 708,
    SOUND_BEAST_SUCTION_END = 709,
    SOUND_BEAST_SUCTION_START = 710,
    SOUND_BEAST_SPIT = 711,
    SOUND_BEAST_SURFACE_GROWL = 712,
    SOUND_BEAST_SWITCH_SIDES = 713,
    SOUND_MOTHERSHADOW_APPEAR = 714,
    SOUND_MOTHERSHADOW_CHARGE_UP = 715,
    SOUND_MOTHERSHADOW_DASH = 716,
    SOUND_MOTHERSHADOW_END = 717,
    SOUND_MOTHERSHADOW_INTRO = 718,
    SOUND_BUMBINO_DEATH = 719,
    SOUND_BUMBINO_DIZZY = 720,
    SOUND_BUMBINO_HIT_WALL = 721,
    SOUND_BUMBINO_MISC = 722,
    SOUND_BUMBINO_PUNCH = 723,
    SOUND_BUMBINO_RAM = 724,
    SOUND_BUMBINO_SLAM = 725,
    SOUND_BUMBINO_SNAP_OUT = 726,
    SOUND_SIREN_SCREAM = 727,
    SOUND_SIREN_SING = 728,
    SOUND_DEATH_SKULL_SUMMON_LOOP = 729,
    SOUND_DEATH_SKULL_SUMMON_END = 730,
    SOUND_BEAST_DEATH_2 = 731,
    SOUND_BEAST_ANGELIC_BLAST = 732,
    SOUND_ANCIENT_RECALL = 733,
    SOUND_ERA_WALK = 734,
    SOUND_HUGE_GROWTH = 735,
    SOUND_RUNE_SHARD = 736,
    SOUND_SHOT_SPEED_DOWN = 737,
    SOUND_SHOT_SPEED_UP = 738,
    SOUND_EXPERIMENTAL_PILL = 739,
    SOUND_CRACKED_KEY = 740,
    SOUND_QUEEN_OF_HEARTS = 741,
    SOUND_WILD_CARD = 742,
    SOUND_SOUL_OF_ISAAC = 743,
    SOUND_SOUL_OF_MAGDALENE = 744,
    SOUND_SOUL_OF_CAIN = 745,
    SOUND_SOUL_OF_JUDAS = 746,
    SOUND_SOUL_OF_XXX = 747,
    SOUND_SOUL_OF_EVE = 748,
    SOUND_SOUL_OF_SAMSON = 749,
    SOUND_SOUL_OF_AZAZEL = 750,
    SOUND_SOUL_OF_LAZARUS = 751,
    SOUND_SOUL_OF_EDEN = 752,
    SOUND_SOUL_OF_THE_LOST = 753,
    SOUND_SOUL_OF_LILITH = 754,
    SOUND_SOUL_OF_THE_KEEPER = 755,
    SOUND_SOUL_OF_APOLLYON = 756,
    SOUND_SOUL_OF_THE_FORGOTTEN = 757,
    SOUND_SOUL_OF_BETHANY = 758,
    SOUND_SOUL_OF_JACOB_AND_ESAU = 759,
    SOUND_MEGA_BAD_GAS = 760,
    SOUND_MEGA_BAD_TRIP = 761,
    SOUND_MEGA_BALLS_OF_STEEL = 762,
    SOUND_MEGA_BOMBS_ARE_KEY = 763,
    SOUND_MEGA_EXPLOSIVE_DIARRHEA = 764,
    SOUND_MEGA_FULL_HEALTH = 765,
    SOUND_MEGA_HEALTH_UP = 766,
    SOUND_MEGA_HEALTH_DOWN = 767,
    SOUND_MEGA_I_FOUND_PILLS = 768,
    SOUND_MEGA_PUBERTY = 769,
    SOUND_MEGA_PRETTY_FLY = 770,
    SOUND_MEGA_RANGE_DOWN = 771,
    SOUND_MEGA_RANGE_UP = 772,
    SOUND_MEGA_SPEED_DOWN = 773,
    SOUND_MEGA_SPEED_UP = 774,
    SOUND_MEGA_TEARS_DOWN = 775,
    SOUND_MEGA_TEARS_UP = 776,
    SOUND_MEGA_LUCK_DOWN = 777,
    SOUND_MEGA_LUCK_UP = 778,
    SOUND_MEGA_TELEPILLS = 779,
    SOUND_MEGA_48_HR_ENERGY = 780,
    SOUND_MEGA_HEMATEMESIS = 781,
    SOUND_MEGA_PARALYSIS = 782,
    SOUND_MEGA_I_CAN_SEE_FOREVER = 783,
    SOUND_MEGA_PHEROMONES = 784,
    SOUND_MEGA_AMNESIA = 785,
    SOUND_MEGA_LEMON_PARTY = 786,
    SOUND_MEGA_ARE_YOU_A_WIZARD = 787,
    SOUND_MEGA_PERCS = 788,
    SOUND_MEGA_ADDICTED = 789,
    SOUND_MEGA_RELAX = 790,
    SOUND_MEGA_TRIPLE_QUESTION_MARK = 791,
    SOUND_MEGA_ONE_MAKES_YOU_LARGER = 792,
    SOUND_MEGA_ONE_MAKES_YOU_SMALL = 793,
    SOUND_MEGA_INFESTED = 794,
    SOUND_MEGA_INFESTED_1 = 795,
    SOUND_MEGA_POWER_PILL = 796,
    SOUND_MEGA_RETRO_VISION = 797,
    SOUND_MEGA_FRIENDS_TIL_THE_END = 798,
    SOUND_MEGA_EXLAX = 799,
    SOUND_MEGA_SOMETHINGS_WRONG = 800,
    SOUND_MEGA_IM_DROWSY = 801,
    SOUND_MEGA_IM_EXCITED = 802,
    SOUND_MEGA_GULP = 803,
    SOUND_MEGA_HORF = 804,
    SOUND_MEGA_SUNSHINE = 805,
    SOUND_MEGA_VURP = 806,
    SOUND_MEGA_SHOT_SPEED_DOWN = 807,
    SOUND_MEGA_SHOT_SPEED_UP = 808,
    SOUND_MEGA_EXPERIMENTAL_PILL = 809,
    SOUND_SIREN_LUNGE = 810,
    SOUND_SIREN_MINION_SMOKE = 811,
    SOUND_SIREN_SCREAM_ATTACK = 812,
    SOUND_SIREN_SING_STAB = 813,
    SOUND_BEAST_LAVABALL_RISE = 814,
    SOUND_BEAST_GROWL = 815,
    SOUND_BEAST_GRUMBLE = 816,
    SOUND_FAMINE_GRUNT = 817,
    SOUND_GFUEL_1 = 818,
    SOUND_GFUEL_2 = 819,
    SOUND_GFUEL_3 = 820,
    SOUND_GFUEL_4 = 821,
    SOUND_GFUEL_EXPLOSION = 822,
    SOUND_GFUEL_EXPLOSION_BIG = 823,
    SOUND_GFUEL_GUNSHOT = 824,
    SOUND_GFUEL_GUNSHOT_SMALL = 825,
    SOUND_GFUEL_GUNSHOT_LARGE = 826,
    SOUND_GFUEL_GUNSHOT_SPREAD = 827,
    SOUND_GFUEL_AIR_HORN = 828,
    SOUND_GFUEL_ITEM_APPEAR = 829,
    SOUND_GFUEL_GUNSHOT_MINI = 830,
    SOUND_GFUEL_RICOCHET = 831,
    SOUND_GFUEL_ROCKETLAUNCHER = 832,
    NUM_SOUND_EFFECTS = 833,
}
---@enum DoorState
DoorState = {
    STATE_INIT = 0,
    STATE_CLOSED = 1,
    STATE_OPEN = 2,
    STATE_ONE_CHAIN = 3,
    STATE_HALF_CRACKED = 4,
}
---@enum DoorVariant
DoorVariant = {
    DOOR_UNSPECIFIED = 0,
    DOOR_LOCKED = 1,
    DOOR_LOCKED_DOUBLE = 2,
    DOOR_LOCKED_CRACKED = 3,
    DOOR_LOCKED_BARRED = 4,
    DOOR_LOCKED_KEYFAMILIAR = 5,
    DOOR_LOCKED_GREED = 6,
    DOOR_HIDDEN = 7,
    DOOR_UNLOCKED = 8,
}
---@enum Difficulty
Difficulty = {
    DIFFICULTY_NORMAL = 0,
    DIFFICULTY_HARD = 1,
    DIFFICULTY_GREED = 2,
    DIFFICULTY_GREEDIER = 3,
}
---@enum LevelStateFlag
LevelStateFlag = {
    STATE_BUM_KILLED = 0,
    STATE_EVIL_BUM_KILLED = 1,
    STATE_REDHEART_DAMAGED = 2,
    STATE_BUM_LEFT = 3,
    STATE_EVIL_BUM_LEFT = 4,
    STATE_DAMAGED = 5,
    STATE_SHOPKEEPER_KILLED_LVL = 6,
    STATE_COMPASS_EFFECT = 7,
    STATE_MAP_EFFECT = 8,
    STATE_BLUE_MAP_EFFECT = 9,
    STATE_FULL_MAP_EFFECT = 10,
    STATE_GREED_LOST_PENALTY = 11,
    STATE_GREED_MONSTRO_SPAWNED = 12,
    STATE_ITEM_DUNGEON_FOUND = 13,
    STATE_MAMA_MEGA_USED = 14,
    STATE_WOODEN_CROSS_REMOVED = 15,
    STATE_SHOVEL_QUEST_TRIGGERED = 16,
    STATE_SATANIC_BIBLE_USED = 17,
    STATE_SOL_EFFECT = 18,
    STATE_LEVEL_START_TRIGGERED = 19,
    STATE_LUNA_EFFECT = 20,
    STATE_VOID_DOOR_DISABLED = 21,
    STATE_MINESHAFT_ESCAPE = 22,
    STATE_MIRROR_BROKEN = 23,
    NUM_STATE_FLAGS = 24,
}
---@enum GameStateFlag
GameStateFlag = {
    STATE_FAMINE_SPAWNED = 0,
    STATE_PESTILENCE_SPAWNED = 1, -- obsolete
    STATE_WAR_SPAWNED = 2, -- obsolete
    STATE_DEATH_SPAWNED = 3, -- obsolete
    STATE_BOSSPOOL_SWITCHED = 4,
    STATE_DEVILROOM_SPAWNED = 5,
    STATE_DEVILROOM_VISITED = 6,
    STATE_BOOK_REVELATIONS_USED = 7,
    STATE_BOOK_PICKED_UP = 8,
    STATE_WRATH_SPAWNED = 9,
    STATE_GLUTTONY_SPAWNED = 10,
    STATE_LUST_SPAWNED = 11,
    STATE_SLOTH_SPAWNED = 12,
    STATE_ENVY_SPAWNED = 13,
    STATE_PRIDE_SPAWNED = 14,
    STATE_GREED_SPAWNED = 15,
    STATE_SUPERGREED_SPAWNED = 16,
    STATE_DONATION_SLOT_BROKEN = 17,
    STATE_DONATION_SLOT_JAMMED = 18,
    STATE_HEAVEN_PATH = 19,
    STATE_REBIRTH_BOSS_SWITCHED = 20, -- obsolete
    STATE_HAUNT_SELECTED = 21, -- obsolete
    STATE_ADVERSARY_SELECTED = 22, -- obsolete
    STATE_MR_FRED_SELECTED = 23, -- obsolete
    STATE_MAMA_GURDY_SELECTED = 24, -- obsolete
    STATE_URIEL_SPAWNED = 25,
    STATE_GABRIEL_SPAWNED = 26,
    STATE_FALLEN_SPAWNED = 27,
    STATE_HEADLESS_HORSEMAN_SPAWNED = 28, -- obsolete
    STATE_KRAMPUS_SPAWNED = 29,
    STATE_DONATION_SLOT_BLOWN = 30,
    STATE_SHOPKEEPER_KILLED = 31,
    STATE_ULTRAPRIDE_SPAWNED = 32,
    STATE_BOSSRUSH_DONE = 33,
    STATE_GREED_SLOT_JAMMED = 34,
    STATE_AFTERBIRTH_BOSS_SWITCHED = 35, -- obsolete
    STATE_BROWNIE_SELECTED = 36, -- obsolete
    STATE_SUPERBUM_APPEARED = 37,
    STATE_BOSSRUSH_DOOR_SPAWNED = 38,
    STATE_BLUEWOMB_DOOR_SPAWNED = 39,
    STATE_BLUEWOMB_DONE = 40,
    STATE_HEART_BOMB_COIN_PICKED = 41,
    STATE_ABPLUS_BOSS_SWITCHED = 42, -- obsolete
    STATE_SISTERS_VIS_SELECTED = 43, -- obsolete
    STATE_MAX_COINS_OBTAINED = 43, -- set when reaching 99 coins, used to check for the Golden Razor achievement
    STATE_SECRET_PATH = 44, -- set when entering a trapdoor that leads to the alternate path
    STATE_PERFECTION_SPAWNED = 45, -- set when Perfection has dropped from a boss
    STATE_MAUSOLEUM_HEART_KILLED = 46, -- set when Mom's Heart has been killed in the Mausoleum
    STATE_BACKWARDS_PATH_INIT = 47, -- set when entering Mausoleum/Gehenna II through the photo door, causes Dad's Note to spawn instead of the Mom boss room
    STATE_BACKWARDS_PATH = 48, -- set during the Ascent
    NUM_STATE_FLAGS = 49,
}
---@enum CollectibleType
CollectibleType = {
    COLLECTIBLE_NULL = 0,
    COLLECTIBLE_SAD_ONION = 1,
    COLLECTIBLE_INNER_EYE = 2,
    COLLECTIBLE_SPOON_BENDER = 3,
    COLLECTIBLE_CRICKETS_HEAD = 4,
    COLLECTIBLE_MY_REFLECTION = 5,
    COLLECTIBLE_NUMBER_ONE = 6,
    COLLECTIBLE_BLOOD_OF_THE_MARTYR = 7,
    COLLECTIBLE_BROTHER_BOBBY = 8,
    COLLECTIBLE_SKATOLE = 9,
    COLLECTIBLE_HALO_OF_FLIES = 10,
    COLLECTIBLE_1UP = 11,
    COLLECTIBLE_MAGIC_MUSHROOM = 12,
    COLLECTIBLE_VIRUS = 13,
    COLLECTIBLE_ROID_RAGE = 14,
    COLLECTIBLE_HEART = 15,
    COLLECTIBLE_RAW_LIVER = 16,
    COLLECTIBLE_SKELETON_KEY = 17,
    COLLECTIBLE_DOLLAR = 18,
    COLLECTIBLE_BOOM = 19,
    COLLECTIBLE_TRANSCENDENCE = 20,
    COLLECTIBLE_COMPASS = 21,
    COLLECTIBLE_LUNCH = 22,
    COLLECTIBLE_DINNER = 23,
    COLLECTIBLE_DESSERT = 24,
    COLLECTIBLE_BREAKFAST = 25,
    COLLECTIBLE_ROTTEN_MEAT = 26,
    COLLECTIBLE_WOODEN_SPOON = 27,
    COLLECTIBLE_BELT = 28,
    COLLECTIBLE_MOMS_UNDERWEAR = 29,
    COLLECTIBLE_MOMS_HEELS = 30,
    COLLECTIBLE_MOMS_LIPSTICK = 31,
    COLLECTIBLE_WIRE_COAT_HANGER = 32,
    COLLECTIBLE_BIBLE = 33,
    COLLECTIBLE_BOOK_OF_BELIAL = 34,
    COLLECTIBLE_NECRONOMICON = 35,
    COLLECTIBLE_POOP = 36,
    COLLECTIBLE_MR_BOOM = 37,
    COLLECTIBLE_TAMMYS_HEAD = 38,
    COLLECTIBLE_MOMS_BRA = 39,
    COLLECTIBLE_KAMIKAZE = 40,
    COLLECTIBLE_MOMS_PAD = 41,
    COLLECTIBLE_BOBS_ROTTEN_HEAD = 42,
    COLLECTIBLE_TELEPORT = 44,
    COLLECTIBLE_YUM_HEART = 45,
    COLLECTIBLE_LUCKY_FOOT = 46,
    COLLECTIBLE_DOCTORS_REMOTE = 47,
    COLLECTIBLE_CUPIDS_ARROW = 48,
    COLLECTIBLE_SHOOP_DA_WHOOP = 49,
    COLLECTIBLE_STEVEN = 50,
    COLLECTIBLE_PENTAGRAM = 51,
    COLLECTIBLE_DR_FETUS = 52,
    COLLECTIBLE_MAGNETO = 53,
    COLLECTIBLE_TREASURE_MAP = 54,
    COLLECTIBLE_MOMS_EYE = 55,
    COLLECTIBLE_LEMON_MISHAP = 56,
    COLLECTIBLE_DISTANT_ADMIRATION = 57,
    COLLECTIBLE_BOOK_OF_SHADOWS = 58,
    COLLECTIBLE_BOOK_OF_BELIAL_PASSIVE = 59,
    COLLECTIBLE_LADDER = 60,
    COLLECTIBLE_CHARM_VAMPIRE = 62,
    COLLECTIBLE_BATTERY = 63,
    COLLECTIBLE_STEAM_SALE = 64,
    COLLECTIBLE_ANARCHIST_COOKBOOK = 65,
    COLLECTIBLE_HOURGLASS = 66,
    COLLECTIBLE_SISTER_MAGGY = 67,
    COLLECTIBLE_TECHNOLOGY = 68,
    COLLECTIBLE_CHOCOLATE_MILK = 69,
    COLLECTIBLE_GROWTH_HORMONES = 70,
    COLLECTIBLE_MINI_MUSH = 71,
    COLLECTIBLE_ROSARY = 72,
    COLLECTIBLE_CUBE_OF_MEAT = 73,
    COLLECTIBLE_QUARTER = 74,
    COLLECTIBLE_PHD = 75,
    COLLECTIBLE_XRAY_VISION = 76,
    COLLECTIBLE_MY_LITTLE_UNICORN = 77,
    COLLECTIBLE_BOOK_OF_REVELATIONS = 78,
    COLLECTIBLE_MARK = 79,
    COLLECTIBLE_PACT = 80,
    COLLECTIBLE_DEAD_CAT = 81,
    COLLECTIBLE_LORD_OF_THE_PIT = 82,
    COLLECTIBLE_THE_NAIL = 83,
    COLLECTIBLE_WE_NEED_TO_GO_DEEPER = 84,
    COLLECTIBLE_DECK_OF_CARDS = 85,
    COLLECTIBLE_MONSTROS_TOOTH = 86,
    COLLECTIBLE_LOKIS_HORNS = 87,
    COLLECTIBLE_LITTLE_CHUBBY = 88,
    COLLECTIBLE_SPIDER_BITE = 89,
    COLLECTIBLE_SMALL_ROCK = 90,
    COLLECTIBLE_SPELUNKER_HAT = 91,
    COLLECTIBLE_SUPER_BANDAGE = 92,
    COLLECTIBLE_GAMEKID = 93,
    COLLECTIBLE_SACK_OF_PENNIES = 94,
    COLLECTIBLE_ROBO_BABY = 95,
    COLLECTIBLE_LITTLE_CHAD = 96,
    COLLECTIBLE_BOOK_OF_SIN = 97,
    COLLECTIBLE_RELIC = 98,
    COLLECTIBLE_LITTLE_GISH = 99,
    COLLECTIBLE_LITTLE_STEVEN = 100,
    COLLECTIBLE_HALO = 101,
    COLLECTIBLE_MOMS_BOTTLE_OF_PILLS = 102,
    COLLECTIBLE_COMMON_COLD = 103,
    COLLECTIBLE_PARASITE = 104,
    COLLECTIBLE_D6 = 105,
    COLLECTIBLE_MR_MEGA = 106,
    COLLECTIBLE_PINKING_SHEARS = 107,
    COLLECTIBLE_WAFER = 108,
    COLLECTIBLE_MONEY_EQUALS_POWER = 109,
    COLLECTIBLE_MOMS_CONTACTS = 110,
    COLLECTIBLE_BEAN = 111,
    COLLECTIBLE_GUARDIAN_ANGEL = 112,
    COLLECTIBLE_DEMON_BABY = 113,
    COLLECTIBLE_MOMS_KNIFE = 114,
    COLLECTIBLE_OUIJA_BOARD = 115,
    COLLECTIBLE_9_VOLT = 116,
    COLLECTIBLE_DEAD_BIRD = 117,
    COLLECTIBLE_BRIMSTONE = 118,
    COLLECTIBLE_BLOOD_BAG = 119,
    COLLECTIBLE_ODD_MUSHROOM_THIN = 120,
    COLLECTIBLE_ODD_MUSHROOM_LARGE = 121,
    COLLECTIBLE_WHORE_OF_BABYLON = 122,
    COLLECTIBLE_MONSTER_MANUAL = 123,
    COLLECTIBLE_DEAD_SEA_SCROLLS = 124,
    COLLECTIBLE_BOBBY_BOMB = 125,
    COLLECTIBLE_RAZOR_BLADE = 126,
    COLLECTIBLE_FORGET_ME_NOW = 127,
    COLLECTIBLE_FOREVER_ALONE = 128,
    COLLECTIBLE_BUCKET_OF_LARD = 129,
    COLLECTIBLE_PONY = 130,
    COLLECTIBLE_BOMB_BAG = 131,
    COLLECTIBLE_LUMP_OF_COAL = 132,
    COLLECTIBLE_GUPPYS_PAW = 133,
    COLLECTIBLE_GUPPYS_TAIL = 134,
    COLLECTIBLE_IV_BAG = 135,
    COLLECTIBLE_BEST_FRIEND = 136,
    COLLECTIBLE_REMOTE_DETONATOR = 137,
    COLLECTIBLE_STIGMATA = 138,
    COLLECTIBLE_MOMS_PURSE = 139,
    COLLECTIBLE_BOBS_CURSE = 140,
    COLLECTIBLE_PAGEANT_BOY = 141,
    COLLECTIBLE_SCAPULAR = 142,
    COLLECTIBLE_SPEED_BALL = 143,
    COLLECTIBLE_BUM_FRIEND = 144,
    COLLECTIBLE_GUPPYS_HEAD = 145,
    COLLECTIBLE_PRAYER_CARD = 146,
    COLLECTIBLE_NOTCHED_AXE = 147,
    COLLECTIBLE_INFESTATION = 148,
    COLLECTIBLE_IPECAC = 149,
    COLLECTIBLE_TOUGH_LOVE = 150,
    COLLECTIBLE_MULLIGAN = 151,
    COLLECTIBLE_TECHNOLOGY_2 = 152,
    COLLECTIBLE_MUTANT_SPIDER = 153,
    COLLECTIBLE_CHEMICAL_PEEL = 154,
    COLLECTIBLE_PEEPER = 155,
    COLLECTIBLE_HABIT = 156,
    COLLECTIBLE_BLOODY_LUST = 157,
    COLLECTIBLE_CRYSTAL_BALL = 158,
    COLLECTIBLE_SPIRIT_OF_THE_NIGHT = 159,
    COLLECTIBLE_CRACK_THE_SKY = 160,
    COLLECTIBLE_ANKH = 161,
    COLLECTIBLE_CELTIC_CROSS = 162,
    COLLECTIBLE_GHOST_BABY = 163,
    COLLECTIBLE_CANDLE = 164,
    COLLECTIBLE_CAT_O_NINE_TAILS = 165,
    COLLECTIBLE_D20 = 166,
    COLLECTIBLE_HARLEQUIN_BABY = 167,
    COLLECTIBLE_EPIC_FETUS = 168,
    COLLECTIBLE_POLYPHEMUS = 169,
    COLLECTIBLE_DADDY_LONGLEGS = 170,
    COLLECTIBLE_SPIDER_BUTT = 171,
    COLLECTIBLE_SACRIFICIAL_DAGGER = 172,
    COLLECTIBLE_MITRE = 173,
    COLLECTIBLE_RAINBOW_BABY = 174,
    COLLECTIBLE_DADS_KEY = 175,
    COLLECTIBLE_STEM_CELLS = 176,
    COLLECTIBLE_PORTABLE_SLOT = 177,
    COLLECTIBLE_HOLY_WATER = 178,
    COLLECTIBLE_FATE = 179,
    COLLECTIBLE_BLACK_BEAN = 180,
    COLLECTIBLE_WHITE_PONY = 181,
    COLLECTIBLE_SACRED_HEART = 182,
    COLLECTIBLE_TOOTH_PICKS = 183,
    COLLECTIBLE_HOLY_GRAIL = 184,
    COLLECTIBLE_DEAD_DOVE = 185,
    COLLECTIBLE_BLOOD_RIGHTS = 186,
    COLLECTIBLE_GUPPYS_HAIRBALL = 187,
    COLLECTIBLE_ABEL = 188,
    COLLECTIBLE_SMB_SUPER_FAN = 189,
    COLLECTIBLE_PYRO = 190,
    COLLECTIBLE_3_DOLLAR_BILL = 191,
    COLLECTIBLE_TELEPATHY_BOOK = 192,
    COLLECTIBLE_MEAT = 193,
    COLLECTIBLE_MAGIC_8_BALL = 194,
    COLLECTIBLE_MOMS_COIN_PURSE = 195,
    COLLECTIBLE_SQUEEZY = 196,
    COLLECTIBLE_JESUS_JUICE = 197,
    COLLECTIBLE_BOX = 198,
    COLLECTIBLE_MOMS_KEY = 199,
    COLLECTIBLE_MOMS_EYESHADOW = 200,
    COLLECTIBLE_IRON_BAR = 201,
    COLLECTIBLE_MIDAS_TOUCH = 202,
    COLLECTIBLE_HUMBLEING_BUNDLE = 203,
    COLLECTIBLE_FANNY_PACK = 204,
    COLLECTIBLE_SHARP_PLUG = 205,
    COLLECTIBLE_GUILLOTINE = 206,
    COLLECTIBLE_BALL_OF_BANDAGES = 207,
    COLLECTIBLE_CHAMPION_BELT = 208,
    COLLECTIBLE_BUTT_BOMBS = 209,
    COLLECTIBLE_GNAWED_LEAF = 210,
    COLLECTIBLE_SPIDERBABY = 211,
    COLLECTIBLE_GUPPYS_COLLAR = 212,
    COLLECTIBLE_LOST_CONTACT = 213,
    COLLECTIBLE_ANEMIC = 214,
    COLLECTIBLE_GOAT_HEAD = 215,
    COLLECTIBLE_CEREMONIAL_ROBES = 216,
    COLLECTIBLE_MOMS_WIG = 217,
    COLLECTIBLE_PLACENTA = 218,
    COLLECTIBLE_OLD_BANDAGE = 219,
    COLLECTIBLE_SAD_BOMBS = 220,
    COLLECTIBLE_RUBBER_CEMENT = 221,
    COLLECTIBLE_ANTI_GRAVITY = 222,
    COLLECTIBLE_PYROMANIAC = 223,
    COLLECTIBLE_CRICKETS_BODY = 224,
    COLLECTIBLE_GIMPY = 225,
    COLLECTIBLE_BLACK_LOTUS = 226,
    COLLECTIBLE_PIGGY_BANK = 227,
    COLLECTIBLE_MOMS_PERFUME = 228,
    COLLECTIBLE_MONSTROS_LUNG = 229,
    COLLECTIBLE_ABADDON = 230,
    COLLECTIBLE_BALL_OF_TAR = 231,
    COLLECTIBLE_STOP_WATCH = 232,
    COLLECTIBLE_TINY_PLANET = 233,
    COLLECTIBLE_INFESTATION_2 = 234,
    COLLECTIBLE_E_COLI = 236,
    COLLECTIBLE_DEATHS_TOUCH = 237,
    COLLECTIBLE_KEY_PIECE_1 = 238,
    COLLECTIBLE_KEY_PIECE_2 = 239,
    COLLECTIBLE_EXPERIMENTAL_TREATMENT = 240,
    COLLECTIBLE_CONTRACT_FROM_BELOW = 241,
    COLLECTIBLE_INFAMY = 242,
    COLLECTIBLE_TRINITY_SHIELD = 243,
    COLLECTIBLE_TECH_5 = 244,
    COLLECTIBLE_20_20 = 245,
    COLLECTIBLE_BLUE_MAP = 246,
    COLLECTIBLE_BFFS = 247,
    COLLECTIBLE_HIVE_MIND = 248,
    COLLECTIBLE_THERES_OPTIONS = 249,
    COLLECTIBLE_BOGO_BOMBS = 250,
    COLLECTIBLE_STARTER_DECK = 251,
    COLLECTIBLE_LITTLE_BAGGY = 252,
    COLLECTIBLE_MAGIC_SCAB = 253,
    COLLECTIBLE_BLOOD_CLOT = 254,
    COLLECTIBLE_SCREW = 255,
    COLLECTIBLE_HOT_BOMBS = 256,
    COLLECTIBLE_FIRE_MIND = 257,
    COLLECTIBLE_MISSING_NO = 258,
    COLLECTIBLE_DARK_MATTER = 259,
    COLLECTIBLE_BLACK_CANDLE = 260,
    COLLECTIBLE_PROPTOSIS = 261,
    COLLECTIBLE_MISSING_PAGE_2 = 262,
    COLLECTIBLE_CLEAR_RUNE = 263,
    COLLECTIBLE_SMART_FLY = 264,
    COLLECTIBLE_DRY_BABY = 265,
    COLLECTIBLE_JUICY_SACK = 266,
    COLLECTIBLE_ROBO_BABY_2 = 267,
    COLLECTIBLE_ROTTEN_BABY = 268,
    COLLECTIBLE_HEADLESS_BABY = 269,
    COLLECTIBLE_LEECH = 270,
    COLLECTIBLE_MYSTERY_SACK = 271,
    COLLECTIBLE_BBF = 272,
    COLLECTIBLE_BOBS_BRAIN = 273,
    COLLECTIBLE_BEST_BUD = 274,
    COLLECTIBLE_LIL_BRIMSTONE = 275,
    COLLECTIBLE_ISAACS_HEART = 276,
    COLLECTIBLE_LIL_HAUNT = 277,
    COLLECTIBLE_DARK_BUM = 278,
    COLLECTIBLE_BIG_FAN = 279,
    COLLECTIBLE_SISSY_LONGLEGS = 280,
    COLLECTIBLE_PUNCHING_BAG = 281,
    COLLECTIBLE_HOW_TO_JUMP = 282,
    COLLECTIBLE_D100 = 283,
    COLLECTIBLE_D4 = 284,
    COLLECTIBLE_D10 = 285,
    COLLECTIBLE_BLANK_CARD = 286,
    COLLECTIBLE_BOOK_OF_SECRETS = 287,
    COLLECTIBLE_BOX_OF_SPIDERS = 288,
    COLLECTIBLE_RED_CANDLE = 289,
    COLLECTIBLE_THE_JAR = 290,
    COLLECTIBLE_FLUSH = 291,
    COLLECTIBLE_SATANIC_BIBLE = 292,
    COLLECTIBLE_HEAD_OF_KRAMPUS = 293,
    COLLECTIBLE_BUTTER_BEAN = 294,
    COLLECTIBLE_MAGIC_FINGERS = 295,
    COLLECTIBLE_CONVERTER = 296,
    COLLECTIBLE_BLUE_BOX = 297,
    COLLECTIBLE_UNICORN_STUMP = 298,
    COLLECTIBLE_TAURUS = 299,
    COLLECTIBLE_ARIES = 300,
    COLLECTIBLE_CANCER = 301,
    COLLECTIBLE_LEO = 302,
    COLLECTIBLE_VIRGO = 303,
    COLLECTIBLE_LIBRA = 304,
    COLLECTIBLE_SCORPIO = 305,
    COLLECTIBLE_SAGITTARIUS = 306,
    COLLECTIBLE_CAPRICORN = 307,
    COLLECTIBLE_AQUARIUS = 308,
    COLLECTIBLE_PISCES = 309,
    COLLECTIBLE_EVES_MASCARA = 310,
    COLLECTIBLE_JUDAS_SHADOW = 311,
    COLLECTIBLE_MAGGYS_BOW = 312,
    COLLECTIBLE_HOLY_MANTLE = 313,
    COLLECTIBLE_THUNDER_THIGHS = 314,
    COLLECTIBLE_STRANGE_ATTRACTOR = 315,
    COLLECTIBLE_CURSED_EYE = 316,
    COLLECTIBLE_MYSTERIOUS_LIQUID = 317,
    COLLECTIBLE_GEMINI = 318,
    COLLECTIBLE_CAINS_OTHER_EYE = 319,
    COLLECTIBLE_BLUE_BABYS_ONLY_FRIEND = 320,
    COLLECTIBLE_SAMSONS_CHAINS = 321,
    COLLECTIBLE_MONGO_BABY = 322,
    COLLECTIBLE_ISAACS_TEARS = 323,
    COLLECTIBLE_UNDEFINED = 324,
    COLLECTIBLE_SCISSORS = 325,
    COLLECTIBLE_BREATH_OF_LIFE = 326,
    COLLECTIBLE_POLAROID = 327,
    COLLECTIBLE_NEGATIVE = 328,
    COLLECTIBLE_LUDOVICO_TECHNIQUE = 329,
    COLLECTIBLE_SOY_MILK = 330,
    COLLECTIBLE_GODHEAD = 331,
    COLLECTIBLE_LAZARUS_RAGS = 332,
    COLLECTIBLE_MIND = 333,
    COLLECTIBLE_BODY = 334,
    COLLECTIBLE_SOUL = 335,
    COLLECTIBLE_DEAD_ONION = 336,
    COLLECTIBLE_BROKEN_WATCH = 337,
    COLLECTIBLE_BOOMERANG = 338,
    COLLECTIBLE_SAFETY_PIN = 339,
    COLLECTIBLE_CAFFEINE_PILL = 340,
    COLLECTIBLE_TORN_PHOTO = 341,
    COLLECTIBLE_BLUE_CAP = 342,
    COLLECTIBLE_LATCH_KEY = 343,
    COLLECTIBLE_MATCH_BOOK = 344,
    COLLECTIBLE_SYNTHOIL = 345,
    COLLECTIBLE_SNACK = 346,
    COLLECTIBLE_DIPLOPIA = 347,
    COLLECTIBLE_PLACEBO = 348,
    COLLECTIBLE_WOODEN_NICKEL = 349,
    COLLECTIBLE_TOXIC_SHOCK = 350,
    COLLECTIBLE_MEGA_BEAN = 351,
    COLLECTIBLE_GLASS_CANNON = 352,
    COLLECTIBLE_BOMBER_BOY = 353,
    COLLECTIBLE_CRACK_JACKS = 354,
    COLLECTIBLE_MOMS_PEARLS = 355,
    COLLECTIBLE_CAR_BATTERY = 356,
    COLLECTIBLE_BOX_OF_FRIENDS = 357,
    COLLECTIBLE_THE_WIZ = 358,
    COLLECTIBLE_8_INCH_NAILS = 359,
    COLLECTIBLE_INCUBUS = 360,
    COLLECTIBLE_FATES_REWARD = 361,
    COLLECTIBLE_LIL_CHEST = 362,
    COLLECTIBLE_SWORN_PROTECTOR = 363,
    COLLECTIBLE_FRIEND_ZONE = 364,
    COLLECTIBLE_LOST_FLY = 365,
    COLLECTIBLE_SCATTER_BOMBS = 366,
    COLLECTIBLE_STICKY_BOMBS = 367,
    COLLECTIBLE_EPIPHORA = 368,
    COLLECTIBLE_CONTINUUM = 369,
    COLLECTIBLE_MR_DOLLY = 370,
    COLLECTIBLE_CURSE_OF_THE_TOWER = 371,
    COLLECTIBLE_CHARGED_BABY = 372,
    COLLECTIBLE_DEAD_EYE = 373,
    COLLECTIBLE_HOLY_LIGHT = 374,
    COLLECTIBLE_HOST_HAT = 375,
    COLLECTIBLE_RESTOCK = 376,
    COLLECTIBLE_BURSTING_SACK = 377,
    COLLECTIBLE_NUMBER_TWO = 378,
    COLLECTIBLE_PUPULA_DUPLEX = 379,
    COLLECTIBLE_PAY_TO_PLAY = 380,
    COLLECTIBLE_EDENS_BLESSING = 381,
    COLLECTIBLE_FRIEND_BALL = 382,
    COLLECTIBLE_TEAR_DETONATOR = 383,
    COLLECTIBLE_LIL_GURDY = 384,
    COLLECTIBLE_BUMBO = 385,
    COLLECTIBLE_D12 = 386,
    COLLECTIBLE_CENSER = 387,
    COLLECTIBLE_KEY_BUM = 388,
    COLLECTIBLE_RUNE_BAG = 389,
    COLLECTIBLE_SERAPHIM = 390,
    COLLECTIBLE_BETRAYAL = 391,
    COLLECTIBLE_ZODIAC = 392,
    COLLECTIBLE_SERPENTS_KISS = 393,
    COLLECTIBLE_MARKED = 394,
    COLLECTIBLE_TECH_X = 395,
    COLLECTIBLE_VENTRICLE_RAZOR = 396,
    COLLECTIBLE_TRACTOR_BEAM = 397,
    COLLECTIBLE_GODS_FLESH = 398,
    COLLECTIBLE_MAW_OF_THE_VOID = 399,
    COLLECTIBLE_SPEAR_OF_DESTINY = 400,
    COLLECTIBLE_EXPLOSIVO = 401,
    COLLECTIBLE_CHAOS = 402,
    COLLECTIBLE_SPIDER_MOD = 403,
    COLLECTIBLE_FARTING_BABY = 404,
    COLLECTIBLE_GB_BUG = 405,
    COLLECTIBLE_D8 = 406,
    COLLECTIBLE_PURITY = 407,
    COLLECTIBLE_ATHAME = 408,
    COLLECTIBLE_EMPTY_VESSEL = 409,
    COLLECTIBLE_EVIL_EYE = 410,
    COLLECTIBLE_LUSTY_BLOOD = 411,
    COLLECTIBLE_CAMBION_CONCEPTION = 412,
    COLLECTIBLE_IMMACULATE_CONCEPTION = 413,
    COLLECTIBLE_MORE_OPTIONS = 414,
    COLLECTIBLE_CROWN_OF_LIGHT = 415,
    COLLECTIBLE_DEEP_POCKETS = 416,
    COLLECTIBLE_SUCCUBUS = 417,
    COLLECTIBLE_FRUIT_CAKE = 418,
    COLLECTIBLE_TELEPORT_2 = 419,
    COLLECTIBLE_BLACK_POWDER = 420,
    COLLECTIBLE_KIDNEY_BEAN = 421,
    COLLECTIBLE_GLOWING_HOUR_GLASS = 422,
    COLLECTIBLE_CIRCLE_OF_PROTECTION = 423,
    COLLECTIBLE_SACK_HEAD = 424,
    COLLECTIBLE_NIGHT_LIGHT = 425,
    COLLECTIBLE_OBSESSED_FAN = 426,
    COLLECTIBLE_MINE_CRAFTER = 427,
    COLLECTIBLE_PJS = 428,
    COLLECTIBLE_HEAD_OF_THE_KEEPER = 429,
    COLLECTIBLE_PAPA_FLY = 430,
    COLLECTIBLE_MULTIDIMENSIONAL_BABY = 431,
    COLLECTIBLE_GLITTER_BOMBS = 432,
    COLLECTIBLE_MY_SHADOW = 433,
    COLLECTIBLE_JAR_OF_FLIES = 434,
    COLLECTIBLE_LIL_LOKI = 435,
    COLLECTIBLE_MILK = 436,
    COLLECTIBLE_D7 = 437,
    COLLECTIBLE_BINKY = 438,
    COLLECTIBLE_MOMS_BOX = 439,
    COLLECTIBLE_KIDNEY_STONE = 440,
    COLLECTIBLE_MEGA_BLAST = 441,
    COLLECTIBLE_DARK_PRINCES_CROWN = 442,
    COLLECTIBLE_APPLE = 443,
    COLLECTIBLE_LEAD_PENCIL = 444,
    COLLECTIBLE_DOG_TOOTH = 445,
    COLLECTIBLE_DEAD_TOOTH = 446,
    COLLECTIBLE_LINGER_BEAN = 447,
    COLLECTIBLE_SHARD_OF_GLASS = 448,
    COLLECTIBLE_METAL_PLATE = 449,
    COLLECTIBLE_EYE_OF_GREED = 450,
    COLLECTIBLE_TAROT_CLOTH = 451,
    COLLECTIBLE_VARICOSE_VEINS = 452,
    COLLECTIBLE_COMPOUND_FRACTURE = 453,
    COLLECTIBLE_POLYDACTYLY = 454,
    COLLECTIBLE_DADS_LOST_COIN = 455,
    COLLECTIBLE_MIDNIGHT_SNACK = 456,
    COLLECTIBLE_CONE_HEAD = 457,
    COLLECTIBLE_BELLY_BUTTON = 458,
    COLLECTIBLE_SINUS_INFECTION = 459,
    COLLECTIBLE_GLAUCOMA = 460,
    COLLECTIBLE_PARASITOID = 461,
    COLLECTIBLE_EYE_OF_BELIAL = 462,
    COLLECTIBLE_SULFURIC_ACID = 463,
    COLLECTIBLE_GLYPH_OF_BALANCE = 464,
    COLLECTIBLE_ANALOG_STICK = 465,
    COLLECTIBLE_CONTAGION = 466,
    COLLECTIBLE_FINGER = 467,
    COLLECTIBLE_SHADE = 468,
    COLLECTIBLE_DEPRESSION = 469,
    COLLECTIBLE_HUSHY = 470,
    COLLECTIBLE_LIL_MONSTRO = 471,
    COLLECTIBLE_KING_BABY = 472,
    COLLECTIBLE_BIG_CHUBBY = 473,
    COLLECTIBLE_BROKEN_GLASS_CANNON = 474,
    COLLECTIBLE_PLAN_C = 475,
    COLLECTIBLE_D1 = 476,
    COLLECTIBLE_VOID = 477,
    COLLECTIBLE_PAUSE = 478,
    COLLECTIBLE_SMELTER = 479,
    COLLECTIBLE_COMPOST = 480,
    COLLECTIBLE_DATAMINER = 481,
    COLLECTIBLE_CLICKER = 482,
    COLLECTIBLE_MAMA_MEGA = 483,
    COLLECTIBLE_WAIT_WHAT = 484,
    COLLECTIBLE_CROOKED_PENNY = 485,
    COLLECTIBLE_DULL_RAZOR = 486,
    COLLECTIBLE_POTATO_PEELER = 487,
    COLLECTIBLE_METRONOME = 488,
    COLLECTIBLE_D_INFINITY = 489,
    COLLECTIBLE_EDENS_SOUL = 490,
    COLLECTIBLE_ACID_BABY = 491,
    COLLECTIBLE_YO_LISTEN = 492,
    COLLECTIBLE_ADRENALINE = 493,
    COLLECTIBLE_JACOBS_LADDER = 494,
    COLLECTIBLE_GHOST_PEPPER = 495,
    COLLECTIBLE_EUTHANASIA = 496,
    COLLECTIBLE_CAMO_UNDIES = 497,
    COLLECTIBLE_DUALITY = 498,
    COLLECTIBLE_EUCHARIST = 499,
    COLLECTIBLE_SACK_OF_SACKS = 500,
    COLLECTIBLE_GREEDS_GULLET = 501,
    COLLECTIBLE_LARGE_ZIT = 502,
    COLLECTIBLE_LITTLE_HORN = 503,
    COLLECTIBLE_BROWN_NUGGET = 504,
    COLLECTIBLE_POKE_GO = 505,
    COLLECTIBLE_BACKSTABBER = 506,
    COLLECTIBLE_SHARP_STRAW = 507,
    COLLECTIBLE_MOMS_RAZOR = 508,
    COLLECTIBLE_BLOODSHOT_EYE = 509,
    COLLECTIBLE_DELIRIOUS = 510,
    COLLECTIBLE_ANGRY_FLY = 511,
    COLLECTIBLE_BLACK_HOLE = 512,
    COLLECTIBLE_BOZO = 513,
    COLLECTIBLE_BROKEN_MODEM = 514,
    COLLECTIBLE_MYSTERY_GIFT = 515,
    COLLECTIBLE_SPRINKLER = 516,
    COLLECTIBLE_FAST_BOMBS = 517,
    COLLECTIBLE_BUDDY_IN_A_BOX = 518,
    COLLECTIBLE_LIL_DELIRIUM = 519,
    COLLECTIBLE_JUMPER_CABLES = 520,
    COLLECTIBLE_COUPON = 521,
    COLLECTIBLE_TELEKINESIS = 522,
    COLLECTIBLE_MOVING_BOX = 523,
    COLLECTIBLE_TECHNOLOGY_ZERO = 524,
    COLLECTIBLE_LEPROSY = 525,
    COLLECTIBLE_7_SEALS = 526,
    COLLECTIBLE_MR_ME = 527,
    COLLECTIBLE_ANGELIC_PRISM = 528,
    COLLECTIBLE_POP = 529,
    COLLECTIBLE_DEATHS_LIST = 530,
    COLLECTIBLE_HAEMOLACRIA = 531,
    COLLECTIBLE_LACHRYPHAGY = 532,
    COLLECTIBLE_TRISAGION = 533,
    COLLECTIBLE_SCHOOLBAG = 534,
    COLLECTIBLE_BLANKET = 535,
    COLLECTIBLE_SACRIFICIAL_ALTAR = 536,
    COLLECTIBLE_LIL_SPEWER = 537,
    COLLECTIBLE_MARBLES = 538,
    COLLECTIBLE_MYSTERY_EGG = 539,
    COLLECTIBLE_FLAT_STONE = 540,
    COLLECTIBLE_MARROW = 541,
    COLLECTIBLE_SLIPPED_RIB = 542,
    COLLECTIBLE_HALLOWED_GROUND = 543,
    COLLECTIBLE_POINTY_RIB = 544,
    COLLECTIBLE_BOOK_OF_THE_DEAD = 545,
    COLLECTIBLE_DADS_RING = 546,
    COLLECTIBLE_DIVORCE_PAPERS = 547,
    COLLECTIBLE_JAW_BONE = 548,
    COLLECTIBLE_BRITTLE_BONES = 549,
    COLLECTIBLE_BROKEN_SHOVEL_1 = 550,
    COLLECTIBLE_BROKEN_SHOVEL_2 = 551,
    COLLECTIBLE_MOMS_SHOVEL = 552,
    COLLECTIBLE_MUCORMYCOSIS = 553,
    COLLECTIBLE_2SPOOKY = 554,
    COLLECTIBLE_GOLDEN_RAZOR = 555,
    COLLECTIBLE_SULFUR = 556,
    COLLECTIBLE_FORTUNE_COOKIE = 557,
    COLLECTIBLE_EYE_SORE = 558,
    COLLECTIBLE_120_VOLT = 559,
    COLLECTIBLE_IT_HURTS = 560,
    COLLECTIBLE_ALMOND_MILK = 561,
    COLLECTIBLE_ROCK_BOTTOM = 562,
    COLLECTIBLE_NANCY_BOMBS = 563,
    COLLECTIBLE_BAR_OF_SOAP = 564,
    COLLECTIBLE_BLOOD_PUPPY = 565,
    COLLECTIBLE_DREAM_CATCHER = 566,
    COLLECTIBLE_PASCHAL_CANDLE = 567,
    COLLECTIBLE_DIVINE_INTERVENTION = 568,
    COLLECTIBLE_BLOOD_OATH = 569,
    COLLECTIBLE_PLAYDOUGH_COOKIE = 570,
    COLLECTIBLE_SOCKS = 571,
    COLLECTIBLE_EYE_OF_THE_OCCULT = 572,
    COLLECTIBLE_IMMACULATE_HEART = 573,
    COLLECTIBLE_MONSTRANCE = 574,
    COLLECTIBLE_INTRUDER = 575,
    COLLECTIBLE_DIRTY_MIND = 576,
    COLLECTIBLE_DAMOCLES = 577,
    COLLECTIBLE_FREE_LEMONADE = 578,
    COLLECTIBLE_SPIRIT_SWORD = 579,
    COLLECTIBLE_RED_KEY = 580,
    COLLECTIBLE_PSY_FLY = 581,
    COLLECTIBLE_WAVY_CAP = 582,
    COLLECTIBLE_ROCKET_IN_A_JAR = 583,
    COLLECTIBLE_BOOK_OF_VIRTUES = 584,
    COLLECTIBLE_ALABASTER_BOX = 585,
    COLLECTIBLE_STAIRWAY = 586,
    COLLECTIBLE_SOL = 588,
    COLLECTIBLE_LUNA = 589,
    COLLECTIBLE_MERCURIUS = 590,
    COLLECTIBLE_VENUS = 591,
    COLLECTIBLE_TERRA = 592,
    COLLECTIBLE_MARS = 593,
    COLLECTIBLE_JUPITER = 594,
    COLLECTIBLE_SATURNUS = 595,
    COLLECTIBLE_URANUS = 596,
    COLLECTIBLE_NEPTUNUS = 597,
    COLLECTIBLE_PLUTO = 598,
    COLLECTIBLE_VOODOO_HEAD = 599,
    COLLECTIBLE_EYE_DROPS = 600,
    COLLECTIBLE_ACT_OF_CONTRITION = 601,
    COLLECTIBLE_MEMBER_CARD = 602,
    COLLECTIBLE_BATTERY_PACK = 603,
    COLLECTIBLE_MOMS_BRACELET = 604,
    COLLECTIBLE_SCOOPER = 605,
    COLLECTIBLE_OCULAR_RIFT = 606,
    COLLECTIBLE_BOILED_BABY = 607,
    COLLECTIBLE_FREEZER_BABY = 608,
    COLLECTIBLE_ETERNAL_D6 = 609,
    COLLECTIBLE_BIRD_CAGE = 610,
    COLLECTIBLE_LARYNX = 611,
    COLLECTIBLE_LOST_SOUL = 612,
    COLLECTIBLE_BLOOD_BOMBS = 614,
    COLLECTIBLE_LIL_DUMPY = 615,
    COLLECTIBLE_BIRDS_EYE = 616,
    COLLECTIBLE_LODESTONE = 617,
    COLLECTIBLE_ROTTEN_TOMATO = 618,
    COLLECTIBLE_BIRTHRIGHT = 619,
    COLLECTIBLE_RED_STEW = 621,
    COLLECTIBLE_GENESIS = 622,
    COLLECTIBLE_SHARP_KEY = 623,
    COLLECTIBLE_BOOSTER_PACK = 624,
    COLLECTIBLE_MEGA_MUSH = 625,
    COLLECTIBLE_KNIFE_PIECE_1 = 626,
    COLLECTIBLE_KNIFE_PIECE_2 = 627,
    COLLECTIBLE_DEATH_CERTIFICATE = 628,
    COLLECTIBLE_BOT_FLY = 629,
    COLLECTIBLE_MEAT_CLEAVER = 631,
    COLLECTIBLE_EVIL_CHARM = 632,
    COLLECTIBLE_DOGMA = 633,
    COLLECTIBLE_PURGATORY = 634,
    COLLECTIBLE_STITCHES = 635,
    COLLECTIBLE_R_KEY = 636,
    COLLECTIBLE_KNOCKOUT_DROPS = 637,
    COLLECTIBLE_ERASER = 638,
    COLLECTIBLE_YUCK_HEART = 639,
    COLLECTIBLE_URN_OF_SOULS = 640,
    COLLECTIBLE_AKELDAMA = 641,
    COLLECTIBLE_MAGIC_SKIN = 642,
    COLLECTIBLE_REVELATION = 643,
    COLLECTIBLE_CONSOLATION_PRIZE = 644,
    COLLECTIBLE_TINYTOMA = 645,
    COLLECTIBLE_BRIMSTONE_BOMBS = 646,
    COLLECTIBLE_4_5_VOLT = 647,
    COLLECTIBLE_FRUITY_PLUM = 649,
    COLLECTIBLE_PLUM_FLUTE = 650,
    COLLECTIBLE_STAR_OF_BETHLEHEM = 651,
    COLLECTIBLE_CUBE_BABY = 652,
    COLLECTIBLE_VADE_RETRO = 653,
    COLLECTIBLE_FALSE_PHD = 654,
    COLLECTIBLE_SPIN_TO_WIN = 655,
    COLLECTIBLE_DAMOCLES_PASSIVE = 656,
    COLLECTIBLE_VASCULITIS = 657,
    COLLECTIBLE_GIANT_CELL = 658,
    COLLECTIBLE_TROPICAMIDE = 659,
    COLLECTIBLE_CARD_READING = 660,
    COLLECTIBLE_QUINTS = 661,
    COLLECTIBLE_TOOTH_AND_NAIL = 663,
    COLLECTIBLE_BINGE_EATER = 664,
    COLLECTIBLE_GUPPYS_EYE = 665,
    COLLECTIBLE_STRAW_MAN = 667,
    COLLECTIBLE_DADS_NOTE = 668,
    COLLECTIBLE_SAUSAGE = 669,
    COLLECTIBLE_OPTIONS = 670,
    COLLECTIBLE_CANDY_HEART = 671,
    COLLECTIBLE_POUND_OF_FLESH = 672,
    COLLECTIBLE_REDEMPTION = 673,
    COLLECTIBLE_SPIRIT_SHACKLES = 674,
    COLLECTIBLE_CRACKED_ORB = 675,
    COLLECTIBLE_EMPTY_HEART = 676,
    COLLECTIBLE_ASTRAL_PROJECTION = 677,
    COLLECTIBLE_C_SECTION = 678,
    COLLECTIBLE_LIL_ABADDON = 679,
    COLLECTIBLE_MONTEZUMAS_REVENGE = 680,
    COLLECTIBLE_LIL_PORTAL = 681,
    COLLECTIBLE_WORM_FRIEND = 682,
    COLLECTIBLE_BONE_SPURS = 683,
    COLLECTIBLE_HUNGRY_SOUL = 684,
    COLLECTIBLE_JAR_OF_WISPS = 685,
    COLLECTIBLE_SOUL_LOCKET = 686,
    COLLECTIBLE_FRIEND_FINDER = 687,
    COLLECTIBLE_INNER_CHILD = 688,
    COLLECTIBLE_GLITCHED_CROWN = 689,
    COLLECTIBLE_JELLY_BELLY = 690,
    COLLECTIBLE_SACRED_ORB = 691,
    COLLECTIBLE_SANGUINE_BOND = 692,
    COLLECTIBLE_SWARM = 693,
    COLLECTIBLE_HEARTBREAK = 694,
    COLLECTIBLE_BLOODY_GUST = 695,
    COLLECTIBLE_SALVATION = 696,
    COLLECTIBLE_VANISHING_TWIN = 697,
    COLLECTIBLE_TWISTED_PAIR = 698,
    COLLECTIBLE_AZAZELS_RAGE = 699,
    COLLECTIBLE_ECHO_CHAMBER = 700,
    COLLECTIBLE_ISAACS_TOMB = 701,
    COLLECTIBLE_VENGEFUL_SPIRIT = 702,
    COLLECTIBLE_ESAU_JR = 703,
    COLLECTIBLE_BERSERK = 704,
    COLLECTIBLE_DARK_ARTS = 705,
    COLLECTIBLE_ABYSS = 706,
    COLLECTIBLE_SUPPER = 707,
    COLLECTIBLE_STAPLER = 708,
    COLLECTIBLE_SUPLEX = 709,
    COLLECTIBLE_BAG_OF_CRAFTING = 710,
    COLLECTIBLE_FLIP = 711,
    COLLECTIBLE_LEMEGETON = 712,
    COLLECTIBLE_SUMPTORIUM = 713,
    COLLECTIBLE_RECALL = 714,
    COLLECTIBLE_HOLD = 715,
    COLLECTIBLE_KEEPERS_SACK = 716,
    COLLECTIBLE_KEEPERS_KIN = 717,
    COLLECTIBLE_KEEPERS_BOX = 719,
    COLLECTIBLE_EVERYTHING_JAR = 720,
    COLLECTIBLE_TMTRAINER = 721,
    COLLECTIBLE_ANIMA_SOLA = 722,
    COLLECTIBLE_SPINDOWN_DICE = 723,
    COLLECTIBLE_HYPERCOAGULATION = 724,
    COLLECTIBLE_IBS = 725,
    COLLECTIBLE_HEMOPTYSIS = 726,
    COLLECTIBLE_GHOST_BOMBS = 727,
    COLLECTIBLE_GELLO = 728,
    COLLECTIBLE_DECAP_ATTACK = 729,
    COLLECTIBLE_GLASS_EYE = 730,
    COLLECTIBLE_STYE = 731,
    COLLECTIBLE_MOMS_RING = 732,
    NUM_COLLECTIBLES = 733,
}
---@enum TrinketType
TrinketType = {
    TRINKET_NULL = 0,
    TRINKET_SWALLOWED_PENNY = 1,
    TRINKET_PETRIFIED_POOP = 2,
    TRINKET_AAA_BATTERY = 3,
    TRINKET_BROKEN_REMOTE = 4,
    TRINKET_PURPLE_HEART = 5,
    TRINKET_BROKEN_MAGNET = 6,
    TRINKET_ROSARY_BEAD = 7,
    TRINKET_CARTRIDGE = 8,
    TRINKET_PULSE_WORM = 9,
    TRINKET_WIGGLE_WORM = 10,
    TRINKET_RING_WORM = 11,
    TRINKET_FLAT_WORM = 12,
    TRINKET_STORE_CREDIT = 13,
    TRINKET_CALLUS = 14,
    TRINKET_LUCKY_ROCK = 15,
    TRINKET_MOMS_TOENAIL = 16,
    TRINKET_BLACK_LIPSTICK = 17,
    TRINKET_BIBLE_TRACT = 18,
    TRINKET_PAPER_CLIP = 19,
    TRINKET_MONKEY_PAW = 20,
    TRINKET_MYSTERIOUS_PAPER = 21,
    TRINKET_DAEMONS_TAIL = 22,
    TRINKET_MISSING_POSTER = 23,
    TRINKET_BUTT_PENNY = 24,
    TRINKET_MYSTERIOUS_CANDY = 25,
    TRINKET_HOOK_WORM = 26,
    TRINKET_WHIP_WORM = 27,
    TRINKET_BROKEN_ANKH = 28,
    TRINKET_FISH_HEAD = 29,
    TRINKET_PINKY_EYE = 30,
    TRINKET_PUSH_PIN = 31,
    TRINKET_LIBERTY_CAP = 32,
    TRINKET_UMBILICAL_CORD = 33,
    TRINKET_CHILDS_HEART = 34,
    TRINKET_CURVED_HORN = 35,
    TRINKET_RUSTED_KEY = 36,
    TRINKET_GOAT_HOOF = 37,
    TRINKET_MOMS_PEARL = 38,
    TRINKET_CANCER = 39,
    TRINKET_RED_PATCH = 40,
    TRINKET_MATCH_STICK = 41,
    TRINKET_LUCKY_TOE = 42,
    TRINKET_CURSED_SKULL = 43,
    TRINKET_SAFETY_CAP = 44,
    TRINKET_ACE_SPADES = 45,
    TRINKET_ISAACS_FORK = 46,
    TRINKET_POLAROID_OBSOLETE = 47,
    TRINKET_MISSING_PAGE = 48,
    TRINKET_BLOODY_PENNY = 49,
    TRINKET_BURNT_PENNY = 50,
    TRINKET_FLAT_PENNY = 51,
    TRINKET_COUNTERFEIT_PENNY = 52,
    TRINKET_TICK = 53,
    TRINKET_ISAACS_HEAD = 54,
    TRINKET_MAGGYS_FAITH = 55,
    TRINKET_JUDAS_TONGUE = 56,
    TRINKET_SOUL = 57,
    TRINKET_SAMSONS_LOCK = 58,
    TRINKET_CAINS_EYE = 59,
    TRINKET_EVES_BIRD_FOOT = 60,
    TRINKET_LEFT_HAND = 61,
    TRINKET_SHINY_ROCK = 62,
    TRINKET_SAFETY_SCISSORS = 63,
    TRINKET_RAINBOW_WORM = 64,
    TRINKET_TAPE_WORM = 65,
    TRINKET_LAZY_WORM = 66,
    TRINKET_CRACKED_DICE = 67,
    TRINKET_SUPER_MAGNET = 68,
    TRINKET_FADED_POLAROID = 69,
    TRINKET_LOUSE = 70,
    TRINKET_BOBS_BLADDER = 71,
    TRINKET_WATCH_BATTERY = 72,
    TRINKET_BLASTING_CAP = 73,
    TRINKET_STUD_FINDER = 74,
    TRINKET_ERROR = 75,
    TRINKET_POKER_CHIP = 76,
    TRINKET_BLISTER = 77,
    TRINKET_SECOND_HAND = 78,
    TRINKET_ENDLESS_NAMELESS = 79,
    TRINKET_BLACK_FEATHER = 80,
    TRINKET_BLIND_RAGE = 81,
    TRINKET_GOLDEN_HORSE_SHOE = 82,
    TRINKET_STORE_KEY = 83,
    TRINKET_RIB_OF_GREED = 84,
    TRINKET_KARMA = 85,
    TRINKET_LIL_LARVA = 86,
    TRINKET_MOMS_LOCKET = 87,
    TRINKET_NO = 88,
    TRINKET_CHILD_LEASH = 89,
    TRINKET_BROWN_CAP = 90,
    TRINKET_MECONIUM = 91,
    TRINKET_CRACKED_CROWN = 92,
    TRINKET_USED_DIAPER = 93,
    TRINKET_FISH_TAIL = 94,
    TRINKET_BLACK_TOOTH = 95,
    TRINKET_OUROBOROS_WORM = 96,
    TRINKET_TONSIL = 97,
    TRINKET_NOSE_GOBLIN = 98,
    TRINKET_SUPER_BALL = 99,
    TRINKET_VIBRANT_BULB = 100,
    TRINKET_DIM_BULB = 101,
    TRINKET_FRAGMENTED_CARD = 102,
    TRINKET_EQUALITY = 103,
    TRINKET_WISH_BONE = 104,
    TRINKET_BAG_LUNCH = 105,
    TRINKET_LOST_CORK = 106,
    TRINKET_CROW_HEART = 107,
    TRINKET_WALNUT = 108,
    TRINKET_DUCT_TAPE = 109,
    TRINKET_SILVER_DOLLAR = 110,
    TRINKET_BLOODY_CROWN = 111,
    TRINKET_PAY_TO_WIN = 112,
    TRINKET_LOCUST_OF_WRATH = 113,
    TRINKET_LOCUST_OF_PESTILENCE = 114,
    TRINKET_LOCUST_OF_FAMINE = 115,
    TRINKET_LOCUST_OF_DEATH = 116,
    TRINKET_LOCUST_OF_CONQUEST = 117,
    TRINKET_BAT_WING = 118,
    TRINKET_STEM_CELL = 119,
    TRINKET_HAIRPIN = 120,
    TRINKET_WOODEN_CROSS = 121,
    TRINKET_BUTTER = 122,
    TRINKET_FILIGREE_FEATHERS = 123,
    TRINKET_DOOR_STOP = 124,
    TRINKET_EXTENSION_CORD = 125,
    TRINKET_ROTTEN_PENNY = 126,
    TRINKET_BABY_BENDER = 127,
    TRINKET_FINGER_BONE = 128,
    TRINKET_JAW_BREAKER = 129,
    TRINKET_CHEWED_PEN = 130,
    TRINKET_BLESSED_PENNY = 131,
    TRINKET_BROKEN_SYRINGE = 132,
    TRINKET_SHORT_FUSE = 133,
    TRINKET_GIGANTE_BEAN = 134,
    TRINKET_LIGHTER = 135,
    TRINKET_BROKEN_PADLOCK = 136,
    TRINKET_MYOSOTIS = 137,
    TRINKET_M = 138,
    TRINKET_TEARDROP_CHARM = 139,
    TRINKET_APPLE_OF_SODOM = 140,
    TRINKET_FORGOTTEN_LULLABY = 141,
    TRINKET_BETHS_FAITH = 142,
    TRINKET_OLD_CAPACITOR = 143,
    TRINKET_BRAIN_WORM = 144,
    TRINKET_PERFECTION = 145,
    TRINKET_DEVILS_CROWN = 146,
    TRINKET_CHARGED_PENNY = 147,
    TRINKET_FRIENDSHIP_NECKLACE = 148,
    TRINKET_PANIC_BUTTON = 149,
    TRINKET_BLUE_KEY = 150,
    TRINKET_FLAT_FILE = 151,
    TRINKET_TELESCOPE_LENS = 152,
    TRINKET_MOMS_LOCK = 153,
    TRINKET_DICE_BAG = 154,
    TRINKET_HOLY_CROWN = 155,
    TRINKET_MOTHERS_KISS = 156,
    TRINKET_TORN_CARD = 157,
    TRINKET_TORN_POCKET = 158,
    TRINKET_GILDED_KEY = 159,
    TRINKET_LUCKY_SACK = 160,
    TRINKET_WICKED_CROWN = 161,
    TRINKET_AZAZELS_STUMP = 162,
    TRINKET_DINGLE_BERRY = 163,
    TRINKET_RING_CAP = 164,
    TRINKET_NUH_UH = 165,
    TRINKET_MODELING_CLAY = 166,
    TRINKET_POLISHED_BONE = 167,
    TRINKET_HOLLOW_HEART = 168,
    TRINKET_KIDS_DRAWING = 169,
    TRINKET_CRYSTAL_KEY = 170,
    TRINKET_KEEPERS_BARGAIN = 171,
    TRINKET_CURSED_PENNY = 172,
    TRINKET_YOUR_SOUL = 173,
    TRINKET_NUMBER_MAGNET = 174,
    TRINKET_STRANGE_KEY = 175,
    TRINKET_LIL_CLOT = 176,
    TRINKET_TEMPORARY_TATTOO = 177,
    TRINKET_SWALLOWED_M80 = 178,
    TRINKET_RC_REMOTE = 179,
    TRINKET_FOUND_SOUL = 180,
    TRINKET_EXPANSION_PACK = 181,
    TRINKET_BETHS_ESSENCE = 182,
    TRINKET_THE_TWINS = 183,
    TRINKET_ADOPTION_PAPERS = 184,
    TRINKET_CRICKET_LEG = 185,
    TRINKET_APOLLYONS_BEST_FRIEND = 186,
    TRINKET_BROKEN_GLASSES = 187,
    TRINKET_ICE_CUBE = 188,
    TRINKET_SIGIL_OF_BAPHOMET = 189,
    NUM_TRINKETS = 190,
    TRINKET_GOLDEN_FLAG = 0x8000,
    TRINKET_ID_MASK = 0x7fff,
}
---@enum PillEffect
PillEffect = {
    PILLEFFECT_NULL = -1,
    PILLEFFECT_BAD_GAS = 0,
    PILLEFFECT_BAD_TRIP = 1,
    PILLEFFECT_BALLS_OF_STEEL = 2,
    PILLEFFECT_BOMBS_ARE_KEYS = 3,
    PILLEFFECT_EXPLOSIVE_DIARRHEA = 4,
    PILLEFFECT_FULL_HEALTH = 5,
    PILLEFFECT_HEALTH_DOWN = 6,
    PILLEFFECT_HEALTH_UP = 7,
    PILLEFFECT_I_FOUND_PILLS = 8,
    PILLEFFECT_PUBERTY = 9,
    PILLEFFECT_PRETTY_FLY = 10,
    PILLEFFECT_RANGE_DOWN = 11,
    PILLEFFECT_RANGE_UP = 12,
    PILLEFFECT_SPEED_DOWN = 13,
    PILLEFFECT_SPEED_UP = 14,
    PILLEFFECT_TEARS_DOWN = 15,
    PILLEFFECT_TEARS_UP = 16,
    PILLEFFECT_LUCK_DOWN = 17,
    PILLEFFECT_LUCK_UP = 18,
    PILLEFFECT_TELEPILLS = 19,
    PILLEFFECT_48HOUR_ENERGY = 20,
    PILLEFFECT_HEMATEMESIS = 21,
    PILLEFFECT_PARALYSIS = 22,
    PILLEFFECT_SEE_FOREVER = 23,
    PILLEFFECT_PHEROMONES = 24,
    PILLEFFECT_AMNESIA = 25,
    PILLEFFECT_LEMON_PARTY = 26,
    PILLEFFECT_WIZARD = 27,
    PILLEFFECT_PERCS = 28,
    PILLEFFECT_ADDICTED = 29,
    PILLEFFECT_RELAX = 30,
    PILLEFFECT_QUESTIONMARK = 31,
    PILLEFFECT_LARGER = 32,
    PILLEFFECT_SMALLER = 33,
    PILLEFFECT_INFESTED_EXCLAMATION = 34,
    PILLEFFECT_INFESTED_QUESTION = 35,
    PILLEFFECT_POWER = 36,
    PILLEFFECT_RETRO_VISION = 37,
    PILLEFFECT_FRIENDS_TILL_THE_END = 38,
    PILLEFFECT_X_LAX = 39,
    PILLEFFECT_SOMETHINGS_WRONG = 40,
    PILLEFFECT_IM_DROWSY = 41,
    PILLEFFECT_IM_EXCITED = 42,
    PILLEFFECT_GULP = 43,
    PILLEFFECT_HORF = 44,
    PILLEFFECT_SUNSHINE = 45,
    PILLEFFECT_VURP = 46,
    PILLEFFECT_SHOT_SPEED_DOWN = 47,
    PILLEFFECT_SHOT_SPEED_UP = 48,
    PILLEFFECT_EXPERIMENTAL = 49,
    NUM_PILL_EFFECTS = 50,
}
---@enum Card
Card = {
    CARD_RANDOM = -1,
    CARD_NULL = 0,
    CARD_FOOL = 1,
    CARD_MAGICIAN = 2,
    CARD_HIGH_PRIESTESS = 3,
    CARD_EMPRESS = 4,
    CARD_EMPEROR = 5,
    CARD_HIEROPHANT = 6,
    CARD_LOVERS = 7,
    CARD_CHARIOT = 8,
    CARD_JUSTICE = 9,
    CARD_HERMIT = 10,
    CARD_WHEEL_OF_FORTUNE = 11,
    CARD_STRENGTH = 12,
    CARD_HANGED_MAN = 13,
    CARD_DEATH = 14,
    CARD_TEMPERANCE = 15,
    CARD_DEVIL = 16,
    CARD_TOWER = 17,
    CARD_STARS = 18,
    CARD_MOON = 19,
    CARD_SUN = 20,
    CARD_JUDGEMENT = 21,
    CARD_WORLD = 22,
    CARD_CLUBS_2 = 23,
    CARD_DIAMONDS_2 = 24,
    CARD_SPADES_2 = 25,
    CARD_HEARTS_2 = 26,
    CARD_ACE_OF_CLUBS = 27,
    CARD_ACE_OF_DIAMONDS = 28,
    CARD_ACE_OF_SPADES = 29,
    CARD_ACE_OF_HEARTS = 30,
    CARD_JOKER = 31,
    RUNE_HAGALAZ = 32,
    RUNE_JERA = 33,
    RUNE_EHWAZ = 34,
    RUNE_DAGAZ = 35,
    RUNE_ANSUZ = 36,
    RUNE_PERTHRO = 37,
    RUNE_BERKANO = 38,
    RUNE_ALGIZ = 39,
    RUNE_BLANK = 40,
    RUNE_BLACK = 41,
    CARD_CHAOS = 42,
    CARD_CREDIT = 43,
    CARD_RULES = 44,
    CARD_HUMANITY = 45,
    CARD_SUICIDE_KING = 46,
    CARD_GET_OUT_OF_JAIL = 47,
    CARD_QUESTIONMARK = 48,
    CARD_DICE_SHARD = 49,
    CARD_EMERGENCY_CONTACT = 50,
    CARD_HOLY = 51,
    CARD_HUGE_GROWTH = 52,
    CARD_ANCIENT_RECALL = 53,
    CARD_ERA_WALK = 54,
    RUNE_SHARD = 55,
    CARD_REVERSE_FOOL = 56,
    CARD_REVERSE_MAGICIAN = 57,
    CARD_REVERSE_HIGH_PRIESTESS = 58,
    CARD_REVERSE_EMPRESS = 59,
    CARD_REVERSE_EMPEROR = 60,
    CARD_REVERSE_HIEROPHANT = 61,
    CARD_REVERSE_LOVERS = 62,
    CARD_REVERSE_CHARIOT = 63,
    CARD_REVERSE_JUSTICE = 64,
    CARD_REVERSE_HERMIT = 65,
    CARD_REVERSE_WHEEL_OF_FORTUNE = 66,
    CARD_REVERSE_STRENGTH = 67,
    CARD_REVERSE_HANGED_MAN = 68,
    CARD_REVERSE_DEATH = 69,
    CARD_REVERSE_TEMPERANCE = 70,
    CARD_REVERSE_DEVIL = 71,
    CARD_REVERSE_TOWER = 72,
    CARD_REVERSE_STARS = 73,
    CARD_REVERSE_MOON = 74,
    CARD_REVERSE_SUN = 75,
    CARD_REVERSE_JUDGEMENT = 76,
    CARD_REVERSE_WORLD = 77,
    CARD_CRACKED_KEY = 78,
    CARD_QUEEN_OF_HEARTS = 79,
    CARD_WILD = 80,
    CARD_SOUL_ISAAC = 81,
    CARD_SOUL_MAGDALENE = 82,
    CARD_SOUL_CAIN = 83,
    CARD_SOUL_JUDAS = 84,
    CARD_SOUL_BLUEBABY = 85,
    CARD_SOUL_EVE = 86,
    CARD_SOUL_SAMSON = 87,
    CARD_SOUL_AZAZEL = 88,
    CARD_SOUL_LAZARUS = 89,
    CARD_SOUL_EDEN = 90,
    CARD_SOUL_LOST = 91,
    CARD_SOUL_LILITH = 92,
    CARD_SOUL_KEEPER = 93,
    CARD_SOUL_APOLLYON = 94,
    CARD_SOUL_FORGOTTEN = 95,
    CARD_SOUL_BETHANY = 96,
    CARD_SOUL_JACOB = 97,
    NUM_CARDS = 98,
}
---@enum TearVariant
TearVariant = {
    BLUE = 0,
    BLOOD = 1,
    TOOTH = 2,
    METALLIC = 3,
    BOBS_HEAD = 4,
    FIRE_MIND = 5,
    DARK_MATTER = 6,
    MYSTERIOUS = 7,
    SCHYTHE = 8,
    CHAOS_CARD = 9,
    LOST_CONTACT = 10,
    CUPID_BLUE = 11,
    CUPID_BLOOD = 12,
    NAIL = 13,
    PUPULA = 14,
    PUPULA_BLOOD = 15,
    GODS_FLESH = 16,
    GODS_FLESH_BLOOD = 17,
    DIAMOND = 18,
    EXPLOSIVO = 19,
    COIN = 20,
    MULTIDIMENSIONAL = 21,
    STONE = 22,
    NAIL_BLOOD = 23,
    GLAUCOMA = 24,
    GLAUCOMA_BLOOD = 25,
    BOOGER = 26,
    EGG = 27,
    RAZOR = 28,
    BONE = 29,
    BLACK_TOOTH = 30,
    NEEDLE = 31,
    BELIAL = 32,
    EYE = 33,
    EYE_BLOOD = 34,
    BALLOON = 35,
    HUNGRY = 36,
    BALLOON_BRIMSTONE = 37,
    BALLOON_BOMB = 38,
    FIST = 39,
    GRIDENT = 40,
    ICE = 41,
    ROCK = 42,
    KEY = 43,
    KEY_BLOOD = 44,
    ERASER = 45,
    FIRE = 46,
    SWORD_BEAM = 47,
    SPORE = 48,
    TECH_SWORD_BEAM = 49,
    FETUS = 50,
}
---@enum TearFlags
TearFlags = {
    TEAR_NORMAL = BitSet128(0),
    TEAR_SPECTRAL = TEARFLAG(0), -- Ouija board type tear (goes thru obstacles)
    TEAR_PIERCING = TEARFLAG(1), -- Cupid's arrow type tear (goes thru enemy)
    TEAR_HOMING = TEARFLAG(2), -- Spoon bender type tear (homes to enemy)
    TEAR_SLOW = TEARFLAG(3), -- Spider bite type tear (slows on contact)
    TEAR_POISON = TEARFLAG(4), -- Common cold type tear (poisons on contact)
    TEAR_FREEZE = TEARFLAG(5), -- Mom's contact type tear (freezes on contact)
    TEAR_SPLIT = TEARFLAG(6), -- Parasite type tear (splits on collision)
    TEAR_GROW = TEARFLAG(7), -- Lump of coal type tear (grows by range)
    TEAR_BOOMERANG = TEARFLAG(8), -- My reflection type tear (returns back)
    TEAR_PERSISTENT = TEARFLAG(9), -- Polyphemus type tear (Damages the entity and if the damage is more then enemy hp it continues with less damage)
    TEAR_WIGGLE = TEARFLAG(10), -- Wiggle worm type tear (wiggles)
    TEAR_MULLIGAN = TEARFLAG(11), -- Mulligan type tear (creates fly on hit)
    TEAR_EXPLOSIVE = TEARFLAG(12), -- IPECAC type tear (explodes on hit)
    TEAR_CHARM = TEARFLAG(13), -- Mom's Eyeshadow tear
    TEAR_CONFUSION = TEARFLAG(14), -- Iron Bar tear
    TEAR_HP_DROP = TEARFLAG(15), -- These tears cause enemy to drop hearts if killed (33% chance)
    TEAR_ORBIT = TEARFLAG(16), -- Used for Little Planet (orbit arounds the player)
    TEAR_WAIT = TEARFLAG(17), -- Anti gravity type tear (floats in place for some time before finally moving) (unset after first update)
    TEAR_QUADSPLIT = TEARFLAG(18), -- Splits into 4 smaller tears if it hits the ground
    TEAR_BOUNCE = TEARFLAG(19), -- Bounce off of enemies, walls, rocks (Higher priority than PERSISTENT & PIERCING)
    TEAR_FEAR = TEARFLAG(20), -- Mom's Perfume type tear of fear (fear on contact)
    TEAR_SHRINK = TEARFLAG(21), -- Proptosis tears start large and shrink
    TEAR_BURN = TEARFLAG(22), -- Fire Mind tears cause Burn effect on enemies
    TEAR_ATTRACTOR = TEARFLAG(23), -- Attracts enemies and pickups
    TEAR_KNOCKBACK = TEARFLAG(24), -- Tear impact pushes enemies back further
    TEAR_PULSE = TEARFLAG(25), -- Makes the tear pulse
    TEAR_SPIRAL = TEARFLAG(26), -- Makes the tear path spiral
    TEAR_FLAT = TEARFLAG(27), -- Makes the tear oval in the direction of travel
    TEAR_SAD_BOMB = TEARFLAG(28), -- Used by Bombs (Sad Bomb)
    TEAR_BUTT_BOMB = TEARFLAG(29), -- Used by Bombs (Butt Bomb)
    TEAR_SQUARE = TEARFLAG(30), -- Used for Hook Worm
    TEAR_GLOW = TEARFLAG(31), -- Used for GodHead (they will have a glow around them)
    TEAR_GISH = TEARFLAG(32), -- Used for Gish player tears (to color enemy black on slowing)
    TEAR_MYSTERIOUS_LIQUID_CREEP = TEARFLAG(33), -- Mysterious Liquid tears spawn damaging green creep when hit
    TEAR_SHIELDED = TEARFLAG(34), -- Lost Contact tears, block enemy projectiles
    TEAR_GLITTER_BOMB = TEARFLAG(35), -- Used by Bombs (Glitter Bomb)
    TEAR_SCATTER_BOMB = TEARFLAG(36), -- Used for Scatter bombs
    TEAR_STICKY = TEARFLAG(37), -- Used for Sticky bombs and Explosivo tears
    TEAR_CONTINUUM = TEARFLAG(38), -- Tears loop around the screen
    TEAR_LIGHT_FROM_HEAVEN = TEARFLAG(39), -- Create damaging light beam on hit
    TEAR_COIN_DROP = TEARFLAG(40), -- Used by Bumbo, spawns a coin when tear hits
    TEAR_BLACK_HP_DROP = TEARFLAG(41), -- Enemy drops a black hp when dies
    TEAR_TRACTOR_BEAM = TEARFLAG(42), -- Tear with this flag will follow parent player's beam
    TEAR_GODS_FLESH = TEARFLAG(43), -- God's flesh flag to minimize enemies
    TEAR_GREED_COIN = TEARFLAG(44), -- Greed coin tears that has a chance to generate a coin when hit
    TEAR_CROSS_BOMB = TEARFLAG(45), -- Bomber Boy
    TEAR_BIG_SPIRAL = TEARFLAG(46), -- Ouroboros Worm, big radius oscilating tears
    TEAR_PERMANENT_CONFUSION = TEARFLAG(47), -- Glaucoma tears, permanently confuses enemies
    TEAR_BOOGER = TEARFLAG(48), -- Booger tears, stick and do damage over time
    TEAR_EGG = TEARFLAG(49), -- Egg tears, leave creep and spawns spiders or flies
    TEAR_ACID = TEARFLAG(50), -- Sulfuric Acid tears, can break grid entities
    TEAR_BONE = TEARFLAG(51), -- Bone tears, splits in 2
    TEAR_BELIAL = TEARFLAG(52), -- Belial tears, piecing tears gets double damage + homing
    TEAR_MIDAS = TEARFLAG(53), -- Midas touch tears
    TEAR_NEEDLE = TEARFLAG(54), -- Needle tears
    TEAR_JACOBS = TEARFLAG(55), -- Jacobs ladder tears
    TEAR_HORN = TEARFLAG(56), -- Little Horn tears
    TEAR_LASER = TEARFLAG(57), -- Technology Zero
    TEAR_POP = TEARFLAG(58), -- Pop!
    TEAR_ABSORB = TEARFLAG(59), -- Hungry Tears
    TEAR_LASERSHOT = TEARFLAG(60), -- Trisagion, generates a laser on top of the tear
    TEAR_HYDROBOUNCE = TEARFLAG(61), -- Flat Stone
    TEAR_BURSTSPLIT = TEARFLAG(62), -- Haemolacria
    TEAR_CREEP_TRAIL = TEARFLAG(63), -- Bob's Bladder
    TEAR_PUNCH = TEARFLAG(64), -- Knockout Drops
    TEAR_ICE = TEARFLAG(65), -- Uranus
    TEAR_MAGNETIZE = TEARFLAG(66), -- Lodestone
    TEAR_BAIT = TEARFLAG(67), -- Rotten Tomato
    TEAR_OCCULT = TEARFLAG(68), -- Eye of the Occult
    TEAR_ORBIT_ADVANCED = TEARFLAG(69), -- Orbiting tears with a more narrow and stable orbit (used by Saturnus and Immaculate Heart)
    TEAR_ROCK = TEARFLAG(70), -- Rock tears, chance to break rocks, deal extra damage to rock type enemies
    TEAR_TURN_HORIZONTAL = TEARFLAG(71), -- Brain Worm, tears turn and go horizontally when moving past an enemy
    TEAR_BLOOD_BOMB = TEARFLAG(72), -- Blood Bombs, leave blood creep on the ground
    TEAR_ECOLI = TEARFLAG(73), -- E. Coli tears, turn enemies into poop
    TEAR_COIN_DROP_DEATH = TEARFLAG(74), -- Killed enemies have a chance to drop a random coin (Reverse Hanged Man)
    TEAR_BRIMSTONE_BOMB = TEARFLAG(75), -- Brimstone Bombs, explosion creates a brimstone cross
    TEAR_RIFT = TEARFLAG(76), -- Rift tears, creates a black hole on impact
    TEAR_SPORE = TEARFLAG(77), -- Spore tears, stick to enemies and multiply on enemy death
    TEAR_GHOST_BOMB = TEARFLAG(78), -- Ghost bombs
    TEAR_CARD_DROP_DEATH = TEARFLAG(79), -- Killed enemies will drop a random tarot card
    TEAR_RUNE_DROP_DEATH = TEARFLAG(80), -- Killed enemies will drop a random rune
    TEAR_TELEPORT = TEARFLAG(81), -- Hit enemies will teleport to a different part of the room
    TEAR_DECELERATE = TEARFLAG(82), -- Decelerate over time
    TEAR_ACCELERATE = TEARFLAG(83), -- Accelerate over time
    TEAR_EFFECT_COUNT = 84,
    TEAR_BOUNCE_WALLSONLY = TEARFLAG(104), -- Similar to TEAR_BOUNCE but only bounces off walls, not enemies
    TEAR_NO_GRID_DAMAGE = TEARFLAG(105), -- Cannot deal damage to grid entities (used by Saturnus to prevent unfair damage in some rooms)
    TEAR_BACKSTAB = TEARFLAG(106), -- Deals extra damage from behind and inflicts bleeding
    TEAR_FETUS_SWORD = TEARFLAG(107), -- Fetuses whack their target with a sword and perform spin attacks
    TEAR_FETUS_BONE = TEARFLAG(108), -- Fetuses whack their target with a bone club instead of ramming into them
    TEAR_FETUS_KNIFE = TEARFLAG(109), -- Fetuses carry a knife
    TEAR_FETUS_TECHX = TEARFLAG(110), -- Fetuses have a Tech X ring around them
    TEAR_FETUS_TECH = TEARFLAG(111), -- Fetuses keep their distance and occasionally shoot tech lasers at their target
    TEAR_FETUS_BRIMSTONE = TEARFLAG(112), -- Fetuses shoot a brimstone beam at the first enemy they hit
    TEAR_FETUS_BOMBER = TEARFLAG(113), -- Fetuses drop a bomb on their first impact with an enemy
    TEAR_FETUS = TEARFLAG(114), -- Base flag for C Section fetuses
    TEAR_REROLL_ROCK_WISP = TEARFLAG(115),
    TEAR_MOM_STOMP_WISP = TEARFLAG(116),
    TEAR_ENEMY_TO_WISP = TEARFLAG(117),
    TEAR_REROLL_ENEMY = TEARFLAG(118), -- D10 Wisps, chance to reroll enemy on hit
    TEAR_GIGA_BOMB = TEARFLAG(119), -- Causes giant explosions that create holes in the ground (for Giga Bombs)
    TEAR_EXTRA_GORE = TEARFLAG(120), -- Causes enemies to explode into more gibs on death (for Donkey Jawbone)
    TEAR_RAINBOW = TEARFLAG(121), -- Causes lasers to visually cycle between rainbow colors
    TEAR_DETONATE = TEARFLAG(122), -- Can be detonated by Remote Detonator
    TEAR_CHAIN = TEARFLAG(123), -- Akeldama tears, stick to each other and form a chain that can be swung around
    TEAR_DARK_MATTER = TEARFLAG(124), -- Used to identify Dark Matter tears
    TEAR_GOLDEN_BOMB = TEARFLAG(125), -- Used to identify bombs dropped while having a golden bomb
    TEAR_FAST_BOMB = TEARFLAG(126), -- Used to identify bombs dropped while having Fast Bombs
    TEAR_LUDOVICO = TEARFLAG(127), -- Used as a weapon for Ludovico Technique
}
---@enum ButtonAction
ButtonAction = {
    ACTION_LEFT = 0,
    ACTION_RIGHT = 1,
    ACTION_UP = 2,
    ACTION_DOWN = 3,
    ACTION_SHOOTLEFT = 4,
    ACTION_SHOOTRIGHT = 5,
    ACTION_SHOOTUP = 6,
    ACTION_SHOOTDOWN = 7,
    ACTION_BOMB = 8,
    ACTION_ITEM = 9,
    ACTION_PILLCARD = 10,
    ACTION_DROP = 11,
    ACTION_PAUSE = 12,
    ACTION_MAP = 13,
    ACTION_MENUCONFIRM = 14,
    ACTION_MENUBACK = 15,
    ACTION_RESTART = 16,
    ACTION_FULLSCREEN = 17,
    ACTION_MUTE = 18,
    ACTION_JOINMULTIPLAYER = 19,
    ACTION_MENULEFT = 20,
    ACTION_MENURIGHT = 21,
    ACTION_MENUUP = 22,
    ACTION_MENUDOWN = 23,
    ACTION_MENULT = 24,
    ACTION_MENURT = 25,
    ACTION_MENUTAB = 26,
    ACTION_CONSOLE = 28, -- USE ONLY FOR HOOKING! To check the input use IsButtonTriggered with desired key
}
---@enum Keyboard
Keyboard = {
    KEY_SPACE = 32,
    KEY_APOSTROPHE = 39,
    KEY_COMMA = 44,
    KEY_MINUS = 45,
    KEY_PERIOD = 46,
    KEY_SLASH = 47,
    KEY_0 = 48,
    KEY_1 = 49,
    KEY_2 = 50,
    KEY_3 = 51,
    KEY_4 = 52,
    KEY_5 = 53,
    KEY_6 = 54,
    KEY_7 = 55,
    KEY_8 = 56,
    KEY_9 = 57,
    KEY_SEMICOLON = 59,
    KEY_EQUAL = 61,
    KEY_A = 65,
    KEY_B = 66,
    KEY_C = 67,
    KEY_D = 68,
    KEY_E = 69,
    KEY_F = 70,
    KEY_G = 71,
    KEY_H = 72,
    KEY_I = 73,
    KEY_J = 74,
    KEY_K = 75,
    KEY_L = 76,
    KEY_M = 77,
    KEY_N = 78,
    KEY_O = 79,
    KEY_P = 80,
    KEY_Q = 81,
    KEY_R = 82,
    KEY_S = 83,
    KEY_T = 84,
    KEY_U = 85,
    KEY_V = 86,
    KEY_W = 87,
    KEY_X = 88,
    KEY_Y = 89,
    KEY_Z = 90,
    KEY_LEFT_BRACKET = 91,
    KEY_BACKSLASH = 92,
    KEY_RIGHT_BRACKET = 93,
    KEY_GRAVE_ACCENT = 96,
    KEY_WORLD_1 = 161,
    KEY_WORLD_2 = 162,
    KEY_ESCAPE = 256,
    KEY_ENTER = 257,
    KEY_TAB = 258,
    KEY_BACKSPACE = 259,
    KEY_INSERT = 260,
    KEY_DELETE = 261,
    KEY_RIGHT = 262,
    KEY_LEFT = 263,
    KEY_DOWN = 264,
    KEY_UP = 265,
    KEY_PAGE_UP = 266,
    KEY_PAGE_DOWN = 267,
    KEY_HOME = 268,
    KEY_END = 269,
    KEY_CAPS_LOCK = 280,
    KEY_SCROLL_LOCK = 281,
    KEY_NUM_LOCK = 282,
    KEY_PRINT_SCREEN = 283,
    KEY_PAUSE = 284,
    KEY_F1 = 290,
    KEY_F2 = 291,
    KEY_F3 = 292,
    KEY_F4 = 293,
    KEY_F5 = 294,
    KEY_F6 = 295,
    KEY_F7 = 296,
    KEY_F8 = 297,
    KEY_F9 = 298,
    KEY_F10 = 299,
    KEY_F11 = 300,
    KEY_F12 = 301,
    KEY_F13 = 302,
    KEY_F14 = 303,
    KEY_F15 = 304,
    KEY_F16 = 305,
    KEY_F17 = 306,
    KEY_F18 = 307,
    KEY_F19 = 308,
    KEY_F20 = 309,
    KEY_F21 = 310,
    KEY_F22 = 311,
    KEY_F23 = 312,
    KEY_F24 = 313,
    KEY_F25 = 314,
    KEY_KP_0 = 320,
    KEY_KP_1 = 321,
    KEY_KP_2 = 322,
    KEY_KP_3 = 323,
    KEY_KP_4 = 324,
    KEY_KP_5 = 325,
    KEY_KP_6 = 326,
    KEY_KP_7 = 327,
    KEY_KP_8 = 328,
    KEY_KP_9 = 329,
    KEY_KP_DECIMAL = 330,
    KEY_KP_DIVIDE = 331,
    KEY_KP_MULTIPLY = 332,
    KEY_KP_SUBTRACT = 333,
    KEY_KP_ADD = 334,
    KEY_KP_ENTER = 335,
    KEY_KP_EQUAL = 336,
    KEY_LEFT_SHIFT = 340,
    KEY_LEFT_CONTROL = 341,
    KEY_LEFT_ALT = 342,
    KEY_LEFT_SUPER = 343,
    KEY_RIGHT_SHIFT = 344,
    KEY_RIGHT_CONTROL = 345,
    KEY_RIGHT_ALT = 346,
    KEY_RIGHT_SUPER = 347,
    KEY_MENU = 348,
}
---@enum Mouse
Mouse = {
    MOUSE_BUTTON_1 = 0,
    MOUSE_BUTTON_2 = 1,
    MOUSE_BUTTON_3 = 2,
    MOUSE_BUTTON_4 = 3,
    MOUSE_BUTTON_5 = 4,
    MOUSE_BUTTON_6 = 5,
    MOUSE_BUTTON_7 = 6,
    MOUSE_BUTTON_8 = 7,
    MOUSE_BUTTON_LAST = 7,
    MOUSE_BUTTON_LEFT = 0,
    MOUSE_BUTTON_RIGHT = 1,
    MOUSE_BUTTON_MIDDLE = 2,
}
---@enum InputHook
InputHook = {
    IS_ACTION_PRESSED = 0,
    IS_ACTION_TRIGGERED = 1,
    GET_ACTION_VALUE = 2,
}
---@enum SeedEffect
SeedEffect = {
    SEED_NORMAL = 0,
    SEED_MOVEMENT_PITCH = 1,
    SEED_HEALTH_PITCH = 2,
    SEED_CAMO_ISAAC = 3,
    SEED_CAMO_ENEMIES = 4,
    SEED_CAMO_PICKUPS = 5,
    SEED_CAMO_EVERYTHING = 6,
    SEED_FART_SOUNDS = 7,
    SEED_OLD_TV = 8,
    SEED_DYSLEXIA = 9,
    SEED_NO_HUD = 10,
    SEED_PICKUPS_SLIDE = 11,
    SEED_CONTROLS_REVERSED = 12,
    SEED_ALL_CHAMPIONS = 13,
    SEED_INVISIBLE_ISAAC = 14,
    SEED_INVISIBLE_ENEMIES = 15,
    SEED_INFINITE_BASEMENT = 16,
    SEED_ALWAYS_CHARMED = 17,
    SEED_ALWAYS_CONFUSED = 18,
    SEED_ALWAYS_AFRAID = 19,
    SEED_ALWAYS_ALTERNATING_FEAR = 20,
    SEED_ALWAYS_CHARMED_AND_AFRAID = 21,
    SEED_EXTRA_BLOOD = 23,
    SEED_POOP_TRAIL = 24,
    SEED_PACIFIST = 25,
    SEED_DAMAGE_WHEN_STOPPED = 26,
    SEED_DAMAGE_ON_INTERVAL = 27,
    SEED_DAMAGE_ON_TIME_LIMIT = 28,
    SEED_PILLS_NEVER_IDENTIFY = 29,
    SEED_MYSTERY_TAROT_CARDS = 30,
    SEED_ENEMIES_RESPAWN = 32,
    SEED_ITEMS_COST_MONEY = 33,
    SEED_BIG_HEAD = 35,
    SEED_SMALL_HEAD = 36,
    SEED_BLACK_ISAAC = 37,
    SEED_GLOWING_TEARS = 38,
    SEED_SLOW_MUSIC = 41,
    SEED_ULTRA_SLOW_MUSIC = 42,
    SEED_FAST_MUSIC = 43,
    SEED_ULTRA_FAST_MUSIC = 44,
    SEED_NO_FACE = 46,
    SEED_ISAAC_TAKES_HIGH_DAMAGE = 47,
    SEED_ISAAC_TAKES_MASSIVE_DAMAGE = 48,
    SEED_ICE_PHYSICS = 52,
    SEED_KAPPA = 53,
    SEED_CHRISTMAS = 54,
    SEED_KIDS_MODE = 55,
    SEED_PERMANENT_CURSE_DARKNESS = 56,
    SEED_PERMANENT_CURSE_LABYRINTH = 57,
    SEED_PERMANENT_CURSE_LOST = 58,
    SEED_PERMANENT_CURSE_UNKNOWN = 59,
    SEED_PERMANENT_CURSE_MAZE = 60,
    SEED_PERMANENT_CURSE_BLIND = 61,
    SEED_PERMANENT_CURSE_CURSED = 62,
    SEED_PREVENT_CURSE_DARKNESS = 63,
    SEED_PREVENT_CURSE_LABYRINTH = 64,
    SEED_PREVENT_CURSE_LOST = 65,
    SEED_PREVENT_CURSE_UNKNOWN = 66,
    SEED_PREVENT_CURSE_MAZE = 67,
    SEED_PREVENT_CURSE_BLIND = 68,
    SEED_PREVENT_ALL_CURSES = 70,
    SEED_NO_BOSS_ROOM_EXITS = 71,
    SEED_PICKUPS_TIMEOUT = 72,
    SEED_INVINCIBLE = 73,
    SEED_SHOOT_IN_MOVEMENT_DIRECTION = 74,
    SEED_SHOOT_OPPOSITE_MOVEMENT_DIRECTION = 75,
    SEED_AXIS_ALIGNED_CONTROLS = 76,
    SEED_SUPER_HOT = 77,
    SEED_RETRO_VISION = 78,
    SEED_G_FUEL = 79,
    NUM_SEEDS = 80,
}
---@enum GridRooms
GridRooms = {
    NO_ROOM_IDX = -99999,
    ROOM_DEVIL_IDX = -1,
    ROOM_ERROR_IDX = -2,
    ROOM_DEBUG_IDX = -3,
    ROOM_DUNGEON_IDX = -4,
    ROOM_BOSSRUSH_IDX = -5,
    ROOM_BLACK_MARKET_IDX = -6,
    ROOM_MEGA_SATAN_IDX = -7,
    ROOM_BLUE_WOOM_IDX = -8,
    ROOM_THE_VOID_IDX = -9,
    ROOM_SECRET_EXIT_IDX = -10,
    ROOM_GIDEON_DUNGEON_IDX = -11,
    ROOM_GENESIS_IDX = -12,
    ROOM_SECRET_SHOP_IDX = -13,
    ROOM_ROTGUT_DUNGEON1_IDX = -14,
    ROOM_ROTGUT_DUNGEON2_IDX = -15,
    ROOM_BLUE_ROOM_IDX = -16,
    ROOM_EXTRA_BOSS_IDX = -17,
    ROOM_ANGEL_SHOP_IDX = -18,
    NUM_OFF_GRID_ROOMS = 18,
    MAX_GRID_ROOMS = 507,
    MAX_ROOMS = 525,
    ROOM_MIRROR_IDX = -100,
    ROOM_MINESHAFT_IDX = -101,
}
---@enum ItemPoolType
ItemPoolType = {
    POOL_NULL = -1,
    POOL_TREASURE = 0,
    POOL_SHOP = 1,
    POOL_BOSS = 2,
    POOL_DEVIL = 3,
    POOL_ANGEL = 4,
    POOL_SECRET = 5,
    POOL_LIBRARY = 6,
    POOL_SHELL_GAME = 7, -- unused (for now)
    POOL_GOLDEN_CHEST = 8,
    POOL_RED_CHEST = 9,
    POOL_BEGGAR = 10,
    POOL_DEMON_BEGGAR = 11,
    POOL_CURSE = 12,
    POOL_KEY_MASTER = 13,
    POOL_BATTERY_BUM = 14,
    POOL_MOMS_CHEST = 15,
    POOL_GREED_TREASURE = 16,
    POOL_GREED_BOSS = 17,
    POOL_GREED_SHOP = 18,
    POOL_GREED_DEVIL = 19,
    POOL_GREED_ANGEL = 20,
    POOL_GREED_CURSE = 21,
    POOL_GREED_SECRET = 22,
    POOL_CRANE_GAME = 23,
    POOL_ULTRA_SECRET = 24,
    POOL_BOMB_BUM = 25,
    POOL_PLANETARIUM = 26,
    POOL_OLD_CHEST = 27,
    POOL_BABY_SHOP = 28,
    POOL_WOODEN_CHEST = 29,
    POOL_ROTTEN_BEGGAR = 30,
    NUM_ITEMPOOLS = 31,
}
---@enum ProjectileVariant
ProjectileVariant = {
    PROJECTILE_NORMAL = 0,
    PROJECTILE_BONE = 1,
    PROJECTILE_FIRE = 2,
    PROJECTILE_PUKE = 3,
    PROJECTILE_TEAR = 4,
    PROJECTILE_CORN = 5,
    PROJECTILE_HUSH = 6,
    PROJECTILE_COIN = 7,
    PROJECTILE_GRID = 8, -- rocks thrown by Polties
    PROJECTILE_ROCK = 9, -- stone shot
    PROJECTILE_RING = 10, -- unused
    PROJECTILE_MEAT = 11, -- globin shot
    PROJECTILE_FCUK = 12, -- steven shot
    PROJECTILE_WING = 13, -- feather shot (from Dogma)
    PROJECTILE_LAVA = 14, -- lava ball (from Beast boss fight)
    PROJECTILE_HEAD = 15, -- dead gaper flung by Mother
    PROJECTILE_PEEP = 16, -- eye shot
}
---@enum ProjectileFlags
ProjectileFlags = {
    SMART = 1, -- follow player
    EXPLODE = 1,
    ACID_GREEN = 1,
    GOO = 1,
    GHOST = 1,
    WIGGLE = 1,
    BOOMERANG = 1,
    HIT_ENEMIES = 1,
    ACID_RED = 1,
    GREED = 1,
    RED_CREEP = 1,
    ORBIT_CW = 1,
    ORBIT_CCW = 1,
    NO_WALL_COLLIDE = 1,
    CREEP_BROWN = 1,
    FIRE = 1,
    BURST = 1,
    ANY_HEIGHT_ENTITY_HIT = 1,
    CURVE_LEFT = 1,
    CURVE_RIGHT = 1,
    TURN_HORIZONTAL = 1,
    SINE_VELOCITY = 1,
    MEGA_WIGGLE = 1,
    SAWTOOTH_WIGGLE = 1,
    SLOWED = 1,
    TRIANGLE = 1,
    MOVE_TO_PARENT = 1,
    ACCELERATE = 1,
    DECELERATE = 1,
    BURST3 = 1,
    CONTINUUM = 1,
    CANT_HIT_PLAYER = 1,
    CHANGE_FLAGS_AFTER_TIMEOUT = 1,
    CHANGE_VELOCITY_AFTER_TIMEOUT = 1,
    STASIS = 1,
    FIRE_WAVE = 1,
    FIRE_WAVE_X = 1,
    ACCELERATE_EX = 1,
    BURST8 = 1,
    FIRE_SPAWN = 1,
    ANTI_GRAVITY = 1,
    TRACTOR_BEAM = 1,
    BOUNCE = 1,
    BOUNCE_FLOOR = 1,
    SHIELDED = 1,
    BLUE_FIRE_SPAWN = 1,
    LASER_SHOT = 1,
    GODHEAD = 1,
    SMART_PERFECT = 1,
    BURSTSPLIT = 1,
    WIGGLE_ROTGUT = 1,
    FREEZE = 1,
    ACCELERATE_TO_POSITION = 1,
    BROCCOLI = 1,
    BACKSPLIT = 1,
    SIDEWAVE = 1,
    ORBIT_PARENT = 1,
    FADEOUT = 1,
}
---@enum EntityPartition
EntityPartition = {
    FAMILIAR = 1,
    BULLET = 1,
    TEAR = 1,
    ENEMY = 1,
    PICKUP = 1,
    PLAYER = 1,
    EFFECT = 1,
}
---@enum ChampionColor
ChampionColor = {
    RED = 0, -- 33% more life, full heart
    YELLOW = 1, -- 33% faster, lil battery
    GREEN = 2, -- trail of green creep, pill
    ORANGE = 3, -- greed shot (drop coins when hit), 1-3 coins
    BLUE = 4, -- half speed, 3 blue flies
    BLACK = 5, -- explodes on death, bomb
    WHITE = 6, -- must be killed last, half eternal heart
    GREY = 7, -- 33% health half speed, key
    TRANSPARENT = 8, -- spectral, locked chest
    FLICKER = 9, -- partly invisible, red chest
    PINK = 10, -- random shots, no drop
    PURPLE = 11, -- pull player/tears, trinket
    DARK_RED = 12, -- regenerate, double heart
    LIGHT_BLUE = 13, -- spread shot on death, half heart
    CAMO = 14, -- camo kid like color, drops a rune when killed
    PULSE_GREEN = 15, -- when killed creates 2 mobs of same kind
    PULSE_GREY = 16, -- shots reflected while in gray state, drops random pickup
    FLY_PROTECTED = 17, -- has halo of fly like shopkeeper, spawns 2 attack flies on death
    TINY = 18, -- 33% less hp, half size, speed +33%, 20% chance of small pill
    GIANT = 19, -- double size, 50% more hp, does 2 hearts of damage, 10% slower, 20% chance of large pill
    PULSE_RED = 20, -- heals all enemies in the room including himself by 30hp every second  - spawns a red heart when killed
    SIZE_PULSE = 21, -- spawns flies when hit, one attack fly for each time it takes damage - spawns 4-6 blue flies when killed
    KING = 22, -- turns all enemies in the room into yellow champions and has tripple HP - spawns 2-3 random pickups when killed
    DEATH = 23, -- does 2 hearts of damage when touched - does death effect when killed
    BROWN = 24, -- constantly poops
    RAINBOW = 25, -- many champion effects combined, drops one of everything
}
---@enum ActiveSlot
ActiveSlot = {
    SLOT_PRIMARY = 0, -- main slot
    SLOT_SECONDARY = 1, -- schoolbag slot
    SLOT_POCKET = 2, -- permanent card/pill slot (tainted alts)
    SLOT_POCKET2 = 3, -- single use card/pill slot (Dice Bag)
}
---@enum UseFlag
UseFlag = {
    USE_NOANIM = 1, -- Don't play use animations
    USE_NOCOSTUME = 1,
    USE_OWNED = 1,
    USE_ALLOWNONMAIN = 1,
    USE_REMOVEACTIVE = 1,
    USE_CARBATTERY = 1,
    USE_VOID = 1,
    USE_MIMIC = 1,
    USE_NOANNOUNCER = 1,
    USE_ALLOWWISPSPAWN = 1,
    USE_CUSTOMVARDATA = 1,
    USE_NOHUD = 1,
}
---@enum RoomTransitionAnim
RoomTransitionAnim = {
    WALK = 0, -- mostly when using doors
    FADE = 1, -- fadein/fadout used for Mom's Hand
    PIXELATION = 2, -- fade+pixelation effect used for secret item dungeon
    TELEPORT = 3,
    MAZE = 4, -- for curse of the maze
    ANKH = 5,
    DEAD_CAT = 6,
    ONE_UP = 7,
    COLLAR = 8,
    JUDAS_SHADOW = 9,
    LAZARUS = 10,
    WOMB_TELEPORT = 11, -- for Ventricle razor teleport
    GLOWING_HOURGLASS = 12, -- for glowing hourglass teleport
    D7 = 13,
    MISSING_POSTER = 14,
    BOSS_FORCED = 15, -- No transition, goes directly to boss intro (for backwardass challenge)
    PORTAL_TELEPORT = 16, -- for card reading teleport
    FORGOTTEN_TELEPORT = 17, -- for the Forgotten's birthright
    FADE_MIRROR = 18,
    MINECART = 19,
    DEATH_CERTIFICATE = 20,
}
---@enum BackdropType
BackdropType = {
    BACKDROP_NULL = 0,
    BASEMENT = 1,
    CELLAR = 2,
    BURNT_BASEMENT = 3,
    CAVES = 4,
    CATACOMBS = 5,
    FLOODED_CAVES = 6,
    DEPTHS = 7,
    NECROPOLIS = 8,
    DANK_DEPTHS = 9,
    WOMB = 10,
    UTERO = 11,
    SCARRED_WOMB = 12,
    BLUE_WOMB = 13,
    SHEOL = 14,
    CATHEDRAL = 15,
    DARKROOM = 16,
    CHEST = 17,
    MEGA_SATAN = 18,
    LIBRARY = 19,
    SHOP = 20,
    ISAAC = 21,
    BARREN = 22,
    SECRET = 23,
    DICE = 24,
    ARCADE = 25,
    ERROR_ROOM = 26,
    BLUE_WOMB_PASS = 27,
    GREED_SHOP = 28,
    DUNGEON = 29,
    SACRIFICE = 30,
    DOWNPOUR = 31,
    MINES = 32,
    MAUSOLEUM = 33,
    CORPSE = 34,
    PLANETARIUM = 35,
    DOWNPOUR_ENTRANCE = 36,
    MINES_ENTRANCE = 37,
    MAUSOLEUM_ENTRANCE = 38,
    CORPSE_ENTRANCE = 39,
    MAUSOLEUM2 = 40,
    MAUSOLEUM3 = 41,
    MAUSOLEUM4 = 42,
    CORPSE2 = 43,
    CORPSE3 = 44,
    DROSS = 45,
    ASHPIT = 46,
    GEHENNA = 47,
    MORTIS = 48,
    ISAACS_BEDROOM = 49,
    HALLWAY = 50,
    MOMS_BEDROOM = 51,
    CLOSET = 52,
    CLOSET_B = 53,
    DOGMA = 54,
    DUNGEON_GIDEON = 55,
    DUNGEON_ROTGUT = 56,
    DUNGEON_BEAST = 57,
    MINES_SHAFT = 58,
    ASHPIT_SHAFT = 59,
    DARK_CLOSET = 60,
    NUM_BACKDROPS = 61,
}
---@enum PoopSpellType
PoopSpellType = {
    SPELL_NONE = 0,
    SPELL_POOP = 1,
    SPELL_CORNY = 2,
    SPELL_BURNING = 3,
    SPELL_STONE = 4,
    SPELL_STINKY = 5,
    SPELL_BLACK = 6,
    SPELL_HOLY = 7,
    SPELL_LIQUID = 8,
    SPELL_FART = 9,
    SPELL_BOMB = 10,
    SPELL_DIARRHEA = 11,
    NUM_POOP_SPELLS = 12,
    SPELL_BAG_SIZE = 20,
    SPELL_QUEUE_SIZE = 6,
}
---@enum LaserSubType
LaserSubType = {
    LASER_SUBTYPE_LINEAR = 0, -- Typical laser that has a start and end point.
    LASER_SUBTYPE_RING_LUDOVICO = 1, -- Controlled ring laser a la Tech+Ludovico, Brim+Ludovico
    LASER_SUBTYPE_RING_PROJECTILE = 2, -- Ring laser that travels like a projectile (Technology X)
    LASER_SUBTYPE_RING_FOLLOW_PARENT = 3, -- Ring lasers that encircle their parents (Maw of the Void)
    LASER_SUBTYPE_NO_IMPACT = 4, -- For Technology Zero, doesn't create an impact
}
---@enum ItemConfig
ItemConfig = {
    CHARGE_NORMAL = 0,
    CHARGE_TIMED = 1,
    CHARGE_SPECIAL = 2,
    TAG_DEAD = 1 >> 0, -- Dead things (for the Parasite unlock)
    TAG_SYRINGE = 1 << 1, -- Syringes (for Little Baggy and the Spun! transformation)
    TAG_MOM = 1 << 2, -- Mom's things (for Mom's Contact and the Yes Mother? transformation)
    TAG_TECH = 1 << 3, -- Technology items (for the Technology Zero unlock)
    TAG_BATTERY = 1 << 4, -- Battery items (for the Jumper Cables unlock)
    TAG_GUPPY = 1 << 5, -- Guppy items (Guppy transformation)
    TAG_FLY = 1 << 6, -- Fly items (Beelzebub transformation)
    TAG_BOB = 1 << 7, -- Bob items (Bob transformation)
    TAG_MUSHROOM = 1 << 8, -- Mushroom items (Fun Guy transformation)
    TAG_BABY = 1 << 9, -- Baby items (Conjoined transformation)
    TAG_ANGEL = 1 << 10, -- Angel items (Seraphim transformation)
    TAG_DEVIL = 1 << 11, -- Devil items (Leviathan transformation)
    TAG_POOP = 1 << 12, -- Poop items (Oh Shit transformation)
    TAG_BOOK = 1 << 13, -- Book items (Book Worm transformation)
    TAG_SPIDER = 1 << 14, -- Spider items (Spider Baby transformation)
    TAG_QUEST = 1 << 15, -- Quest item (cannot be rerolled or randomly obtained)
    TAG_MONSTER_MANUAL = 1 << 16, -- Can be spawned by Monster Manual
    TAG_NO_GREED = 1 << 17, -- Cannot appear in Greed Mode
    TAG_FOOD = 1 << 18, -- Food item (for Binge Eater)
    TAG_TEARS_UP = 1 << 19, -- Tears up item (for Lachryphagy unlock detection)
    TAG_OFFENSIVE = 1 << 20, -- Whitelisted item for Lost B
    TAG_NO_KEEPER = 1 << 21, -- Blacklisted item for Keeper/Keeper B
    TAG_NO_LOST_BR = 1 << 22, -- Blacklisted item for Lost's Birthright
    TAG_STARS = 1 << 23, -- Star themed items (for the Planetarium unlock)
    TAG_SUMMONABLE = 1 << 24, -- Summonable items (for Bethany B)
    TAG_NO_CANTRIP = 1 << 25, -- Can't be obtained in Cantripped challenge
    TAG_WISP = 1 << 26, -- Active items that have wisps attached to them (automatically set)
    TAG_UNIQUE_FAMILIAR = 1 << 27, -- Unique familiars that cannot be duplicated
    TAG_NO_CHALLENGE = 1 << 28, -- Items that shouldn't be obtainable in challenges
    TAG_NO_DAILY = 1 << 29, -- Items that shouldn't be obtainable in daily runs
    TAG_LAZ_SHARED = 1 << 30, -- Items that should be shared between Tainted Lazarus' forms
    TAG_LAZ_SHARED_GLOBAL = 1 << 31, -- Items that should be shared between Tainted Lazarus' forms but only through global checks (such as PlayerManager::HasCollectible)
    TAG_NO_EDEN = 1 << 32, -- Items that can't be randomly rolled
    CARDTYPE_TAROT = 0, -- Tarot cards
    CARDTYPE_SUIT = 1, -- Standard playing cards (twos, aces and Joker, does not include Suicide King, Rules Card or Queen of Hearts)
    CARDTYPE_RUNE = 2, -- Runes
    CARDTYPE_SPECIAL = 3, -- Special cards (anything that doesn't fall in the above categories excludes non-cards such as Dice Shard, see below)
    CARDTYPE_SPECIAL_OBJECT = 4, -- Special pocket items that do not qualify as "cards"
    CARDTYPE_TAROT_REVERSE = 5, -- Reversed tarot cards
    Config = table,
}
---@enum RoomDescriptor
RoomDescriptor = {
    DISPLAY_NONE = 0,
    DISPLAY_BOX = 1,
    DISPLAY_LOCK = 2,
    DISPLAY_ICON = 4,
    DISPLAY_ALL = 5,
    FLAG_CLEAR = 1 << 0,
    FLAG_PRESSURE_PLATES_TRIGGERED = 1 << 1,
    FLAG_SACRIFICE_DONE = 1 << 2,
    FLAG_CHALLENGE_DONE = 1 << 3,
    FLAG_SURPRISE_MINIBOSS = 1 << 4,
    FLAG_HAS_WATER = 1 << 5,
    FLAG_ALT_BOSS_MUSIC = 1 << 6,
    FLAG_NO_REWARD = 1 << 7,
    FLAG_FLOODED = 1 << 8,
    FLAG_PITCH_BLACK = 1 << 9,
    FLAG_RED_ROOM = 1 << 10,
    FLAG_DEVIL_TREASURE = 1 << 11,
    FLAG_USE_ALTERNATE_BACKDROP = 1 << 12,
    FLAG_CURSED_MIST = 1 << 13,
    FLAG_MAMA_MEGA = 1 << 14,
    FLAG_NO_WALLS = 1 << 15,
    FLAG_ROTGUT_CLEARED = 1 << 16,
    FLAG_PORTAL_LINKED = 1 << 17,
    FLAG_BLUE_REDIRECT = 1 << 18,
}
---@enum RenderMode
RenderMode = {
    RENDER_NULL = 0, -- Currently not rendering room entities
    RENDER_NORMAL = 1, -- Rendering room entities normally (in a dry room)
    RENDER_SKIP = 2,
    RENDER_WATER_ABOVE = 3, -- Rendering room entities above the water in a flooded room
    RENDER_WATER_REFRACT = 4, -- Rendering room entities below the water in a flooded room
    RENDER_WATER_REFLECT = 5, -- Rendering the reflection of room entities in a flooded room
}
---@enum SkinColor
SkinColor = {
    SKIN_PINK = -1,
    SKIN_WHITE = 0,
    SKIN_BLACK = 1,
    SKIN_BLUE = 2,
    SKIN_RED = 3,
    SKIN_GREEN = 4,
    SKIN_GREY = 5,
    SKIN_SHADOW = 6,
}
Renderer = {
    ---@enum GLSLType
    GLSLType = {
        Float = 0,
        Vec2 = 1,
        Vec3 = 2,
        Vec4 = 3,
    },
    ---@enum ShaderType
    ShaderType = {
        SHADER_COLOR_OFFSET = 0,
        SHADER_PIXELATION = 1,
        SHADER_BLOOM = 2,
        SHADER_COLOR_CORRECTION = 3,
        SHADER_HQ4X = 4,
        SHADER_SHOCKWAVE = 5,
        SHADER_OLDTV = 6,
        SHADER_WATER = 7,
        SHADER_HALLUCINATION = 8,
        SHADER_COLOR_MOD = 9,
        SHADER_COLOR_OFFSET_CHAMPION = 10,
        SHADER_WATER_V2 = 11,
        SHADER_BACKGROUND = 12,
        SHADER_WATER_OVERLAY = 13,
        SHADER_UNK = 14,
        SHADER_COLOR_OFFSET_DOGMA = 15,
        SHADER_COLOR_OFFSET_GOLD = 16,
        SHADER_DIZZY = 17,
        SHADER_HEAT_WAVE = 18,
        SHADER_MIRROR = 19,
    },
}
---@enum StbType
StbType = {
    SPECIAL_ROOMS = 0,
    BASEMENT = 1,
    CELLAR = 2,
    BURNING_BASEMENT = 3,
    CAVES = 4,
    CATACOMBS = 5,
    FLOODED_CAVES = 6,
    DEPTHS = 7,
    NECROPOLIS = 8,
    DANK_DEPTHS = 9,
    WOMB = 10,
    UTERO = 11,
    SCARRED_WOMB = 12,
    BLUE_WOMB = 13,
    SHEOL = 14,
    CATHEDRAL = 15,
    DARK_ROOM = 16,
    CHEST = 17,
    THE_VOID = 26,
    VOID = 26,
    DOWNPOUR = 27,
    DROSS = 28,
    MINES = 29,
    ASHPIT = 30,
    MAUSOLEUM = 31,
    GEHENNA = 32,
    CORPSE = 33,
    MORTIS = 34,
    HOME = 35,
    ASCENT = 36,
}
---@enum BossType
BossType = {
    MONSTRO = 1,
    LARRY_JR = 2,
    CHUB = 3,
    GURDY = 4,
    MONSTRO_II = 5,
    MOM = 6,
    SCOLEX = 7,
    MOMS_HEART = 8,
    FAMINE = 9,
    PESTILENCE = 10,
    WAR = 11,
    DEATH = 12,
    DUKE_OF_FLIES = 13,
    PEEP = 14,
    LOKI = 15,
    BLASTOCYST = 16,
    GEMINI = 17,
    FISTULA = 18,
    GISH = 19,
    STEVEN = 20,
    CHAD = 21,
    HEADLESS_HORSEMAN = 22,
    FALLEN = 23,
    SATAN = 24,
    IT_LIVES = 25,
    HOLLOW = 26,
    CARRION_QUEEN = 27,
    GURDY_JR = 28,
    HUSK = 29,
    BLOAT = 30,
    LOKII = 31,
    BLIGHTED_OVUM = 32,
    TERATOMA = 33,
    WIDOW = 34,
    MASK_OF_INFAMY = 35,
    WRETCHED = 36,
    PIN = 37,
    CONQUEST = 38,
    ISAAC = 39,
    BLUE_BABY = 40,
    DADDY_LONG_LEGS = 41,
    TRIACHNID = 42,
    HAUNT = 43,
    DINGLE = 44,
    MEGA_MAW = 45,
    GATE = 46,
    MEGA_FATTY = 47,
    CAGE = 48,
    MEGA_GURDY = 49,
    DARK_ONE = 50,
    ADVERSARY = 51,
    POLYCEPHALUS = 52,
    MR_FRED = 53,
    THE_LAMB = 54,
    LAMB = 54,
    MEGA_SATAN = 55,
    GURGLINGS = 56,
    STAIN = 57,
    BROWNIE = 58,
    FORSAKEN = 59,
    LITTLE_HORN = 60,
    RAG_MAN = 61,
    ULTRA_GREED = 62,
    HUSH = 63,
    DANGLE = 64,
    TURDLINGS = 65,
    FRAIL = 66,
    RAG_MEGA = 67,
    SISTERS_VIS = 68,
    BIG_HORN = 69,
    DELIRIUM = 70,
    ULTRA_GREEDIER = 71,
    MATRIARCH = 72,
    PILE = 73,
    REAP_CREEP = 74,
    BEELZEBLUB = 75,
    WORMWOOD = 76,
    RAINMAKER = 77,
    VISAGE = 78,
    SIREN = 79,
    TUFF_TWINS = 80,
    HERETIC = 81,
    HORNFEL = 82,
    GREAT_GIDEON = 83,
    BABY_PLUM = 84,
    SCOURGE = 85,
    CHIMERA = 86,
    ROTGUT = 87,
    MOTHER = 88,
    MOM_MAUSOLEUM = 89,
    MOMS_HEART_MAUSOLEUM = 90,
    MIN_MIN = 91,
    CLOG = 92,
    SINGE = 93,
    BUMBINO = 94,
    COLOSTOMIA = 95,
    SHELL = 96,
    TURDLET = 97,
    RAGLICH = 98,
    DOGMA = 99,
    BEAST = 100,
    HORNY_BOYS = 101,
    CLUTCH = 102,
    CADAVRA = 103,
}
---@enum NullPickupSubType
NullPickupSubType = {
    ANY = 0,
    NO_COLLECTIBLE_CHEST = 1,
    NO_COLLECTIBLE = 2,
    NO_COLLECTIBLE_CHEST_COIN = 3,
    GREED_MODE_ANY = 3,
    NO_COLLECTIBLE_TRINKET_CHEST = 4,
}
---@enum KnifeVariant
KnifeVariant = {
    MOMS_KNIFE = 0,
    BONE_CLUB = 1,
    BONE_SCYTHE = 2,
    BERSERK_CLUB = 3,
    BAG_OF_CRAFTING = 4,
    SUMPTORIUM = 5,
    NOTCHED_AXE = 9,
    SPIRIT_SWORD = 10,
    TECH_SWORD = 11,
}
---@enum KnifeSubType
KnifeSubType = {
    PROJECTILE = 1,
    CLUB_HITBOX = 4,
}
---@enum SlotVariant
SlotVariant = {
    SLOT_MACHINE = 1,
    BLOOD_DONATION_MACHINE = 2,
    FORTUNE_TELLING_MACHINE = 3,
    BEGGAR = 4,
    DEVIL_BEGGAR = 5,
    SHELL_GAME = 6,
    KEY_MASTER = 7,
    DONATION_MACHINE = 8,
    BOMB_BUM = 9,
    SHOP_RESTOCK_MACHINE = 10,
    GREED_DONATION_MACHINE = 11,
    MOMS_DRESSING_TABLE = 12,
    BATTERY_BUM = 13,
    HOME_CLOSET_PLAYER = 14,
    HELL_GAME = 15,
    CRANE_GAME = 16,
    CONFESSIONAL = 17,
    ROTTEN_BEGGAR = 18,
}
---@enum RoomSubType
RoomSubType = {
    NULL = 0,
    SHOP_LEVEL_1 = 0,
    SHOP_LEVEL_2 = 1,
    SHOP_LEVEL_3 = 2,
    SHOP_LEVEL_4 = 3,
    SHOP_LEVEL_5 = 4,
    SHOP_RARE_GOOD = 10,
    SHOP_RARE_BAD = 11,
    SHOP_KEEPER_LEVEL_1 = 100,
    SHOP_KEEPER_LEVEL_2 = 101,
    SHOP_KEEPER_LEVEL_3 = 102,
    SHOP_KEEPER_LEVEL_4 = 103,
    SHOP_KEEPER_LEVEL_5 = 104,
    SHOP_KEEPER_RARE_GOOD = 110,
    SHOP_KEEPER_RARE_BAD = 111,
    TREASURE_NORMAL = 1,
    TREASURE_OPTIONS = 1,
    TREASURE_PAY_TO_PLAY = 2,
    TREASURE_PAY_TO_PLAY_OPTIONS = 3,
    TREASURE_KNIFE_PIECE = 34,
    MINIBOSS_SLOTH = 0,
    MINIBOSS_LUST = 1,
    MINIBOSS_WRATH = 2,
    MINIBOSS_GLUTTONY = 3,
    MINIBOSS_GREED = 4,
    MINIBOSS_ENVY = 5,
    MINIBOSS_PRIDE = 6,
    MINIBOSS_SUPER_SLOTH = 7,
    MINIBOSS_SUPER_LUST = 8,
    MINIBOSS_SUPER_WRATH = 9,
    MINIBOSS_SUPER_GLUTTONY = 10,
    MINIBOSS_SUPER_GREED = 11,
    MINIBOSS_SUPER_ENVY = 12,
    MINIBOSS_SUPER_PRIDE = 13,
    MINIBOSS_ULTRA_PRIDE = 14,
    MINIBOSS_KRAMPUS = 15,
    CHALLENGE_NORMAL = 0,
    CHALLENGE_BOSS = 1,
    CHALLENGE_WAVE = 10,
    CHALLENGE_WAVE_BOSS = 11,
    CHALLENGE_WAVE_GIDEON = 12,
    LIBRARY_LEVEL_1 = 0,
    LIBRARY_LEVEL_2 = 1,
    LIBRARY_LEVEL_3 = 2,
    LIBRARY_LEVEL_4 = 3,
    LIBRARY_LEVEL_5 = 4,
    CRAWLSPACE_NORMAL = 0,
    CRAWLSPACE_GIDEON = 1,
    CRAWLSPACE_ROTGUT = 2,
    CRAWLSPACE_GUS = 2,
    CRAWLSPACE_ROTGUT_HEART = 3,
    CRAWLSPACE_ROTGUT_2 = 3,
    CRAWLSPACE_BEAST = 4,
    SECRET_EXIT_DOWNPOUR = 1,
    SECRET_EXIT_MINES = 2,
    SECRET_EXIT_MAUSOLEUM = 3,
    DOWNPOUR_WHITE_FIRE = 1,
    DOWNPOUR_MIRROR = 34,
    MINES_YELLOW_BUTTON = 1,
    MINES_MINESHAFT_ENTRANCE = 10,
    MINESHAFT_LOBBY = 11,
    MINESHAFT_KNIFE_PIECE = 20,
    MINESHAFT_ROOM = 30,
    MINESHAFT_ROOM_BACKWARDS = 31,
    ASCENT_EXIT = 0,
    ASCENT_BASEMENT = 1,
    ASCENT_CAVES = 4,
    ASCENT_DEPTHS = 7,
    ASCENT_DOWNPOUR = 27,
    ASCENT_MINES = 29,
    ASCENT_MAUSOLEUM = 31,
    HOME_ISAACS_BEDROOM = 0,
    HOME_HALLWAY = 1,
    HOME_MOMS_BEDROOM = 2,
    HOME_LIVING_ROOM = 3,
    HOME_CLOSET_PICKUPS = 10,
    HOME_CLOSET_TAINTED = 11,
    DEATH_CERTIFICATE_ENTRANCE = 33,
    DEATH_CERTIFICATE_NORMAL = 34,
    ARCADE_NORMAL = 0,
    ARCADE_CAIN = 1,
    CURSE_NORMAL = 0,
    CURSE_VOODOO_HEAD = 1,
    DEVIL_NORMAL = 0,
    DEVIL_NUMBER_MAGNET = 1,
    ANGEL_NORMAL = 0,
    ANGEL_STAIRWAY = 1,
    ISAACS_BEDROOM_NORMAL = 0,
    ISAACS_BEDROOM_GENESIS = 99,
    DEPTHS_NORMAL = 0,
    DEPTHS_FOOL_ROOM = 1,
    DEPTHS_MARKED_SKULL = 1,
}
---@enum Achievement
Achievement = {
    MAGDALENE = 1,
    CAIN = 2,
    JUDAS = 3,
    WOMB = 4,
    HORSEMEN = 5,
    CUBE_OF_MEAT = 6,
    BOOK_OF_REVELATIONS = 7,
    TRANSENDENCE = 8,
    NAIL = 9,
    QUARTER = 10,
    DR_FETUS = 11,
    SMALL_ROCK = 12,
    MONSTROS_LUNG = 13,
    LIL_CHUBBY = 14,
    LOKIS_HORNS = 15,
    STEVEN = 16,
    CHAD = 17,
    GISH = 18,
    SUPER_BANDAGE = 19,
    RELIC = 20,
    BAG_OF_PENNIES = 21,
    BOOK_OF_SIN = 23,
    LITTLE_GISH = 23,
    LITTLE_STEVEN = 24,
    LITTLE_CHAD = 25,
    GAMEKID = 26,
    HALO = 27,
    MR_MEGA = 28,
    ISAAC_HOLDS_THE_D6 = 29,
    SCISSORS = 30,
    PARASITE = 31,
    BLUE_BABY = 32,
    EVERYTHING_IS_TERRIBLE = 33,
    IT_LIVES = 34,
    MOMS_CONTACT = 35,
    NECRONOMICON = 36,
    BASEMENT_BOY = 37,
    SPELUNKER_BOY = 38,
    DARK_BOY = 39,
    MAMAS_BOY = 40,
    GOLDEN_GOD = 41,
    EVE = 42,
    MOMS_KNIFE = 43,
    RAZOR = 44,
    GUARDIAN_ANGEL = 45,
    BAG_OF_BOMBS = 46,
    DEMON_BABY = 47,
    FORGET_ME_NOW = 48,
    D20 = 49,
    CELTIC_CROSS = 50,
    ABEL = 51,
    CURVED_HORN = 52,
    SACRIFICIAL_DAGGER = 53,
    BLOODY_LUST = 54,
    BLOODY_PENNY = 55,
    BLOOD_RIGHTS = 56,
    POLAROID = 57,
    DADS_KEY = 58,
    BLUE_CANDLE = 59,
    BURNT_PENNY = 60,
    LUCKY_TOE = 61,
    EPIC_FETUS = 62,
    SMB_SUPER_FAN = 63,
    COUNTERFEIT_PENNY = 65,
    GUPPYS_HAIRBALL = 65,
    CONQUEST = 66,
    SAMSON = 67,
    TRIACHNID = 68,
    PLATINUM_GOD = 69,
    ISAACS_HEAD = 70,
    MAGGYS_FAITH = 71,
    JUDAS_TONGUE = 72,
    BLUE_BABYS_SOUL = 73,
    SAMSONS_LOCK = 74,
    CAINS_EYE = 75,
    EVES_BIRD_FOOT = 76,
    LEFT_HAND = 77,
    NEGATIVE = 78,
    AZAZEL = 79,
    LAZARUS = 80,
    EDEN = 81,
    LOST = 82,
    DEAD_BOY = 83,
    REAL_PLATINUM_GOD = 84,
    LUCKY_ROCK = 85,
    CELLAR = 86,
    CATACOMBS = 87,
    NECROPOLIS = 88,
    RUNE_OF_HAGALAZ = 89,
    RUNE_OF_JERA = 90,
    RUNE_OF_EHWAZ = 91,
    RUNE_OF_DAGAZ = 92,
    RUNE_OF_ANSUZ = 93,
    RUNE_OF_PERTHRO = 94,
    RUNE_OF_BERKANO = 95,
    RUNE_OF_ALGIZ = 96,
    CHAOS_CARD = 97,
    CREDIT_CARD = 98,
    RULES_CARD = 99,
    CARD_AGAINST_HUMANITY = 100,
    SWALLOWED_PENNY = 101,
    ROBO_BABY_2 = 102,
    DEATHS_TOUCH = 103,
    TECHNOLOGY_5 = 104,
    MISSING_NO = 105,
    ISAACS_TEARS = 106,
    GUILLOTINE = 107,
    JUDAS_SHADOW = 108,
    MAGGYS_BOW = 109,
    CAINS_OTHER_EYE = 110,
    BLACK_LIPSTICK = 111,
    EVES_MASCARA = 112,
    FATE = 113,
    BLUE_BABYS_ONLY_FRIEND = 114,
    SAMSONS_CHAINS = 115,
    LAZARUS_RAGS = 116,
    BROKEN_ANKH = 117,
    STORE_CREDIT = 118,
    PANDORAS_BOX = 119,
    SUICIDE_KING = 120,
    BLANK_CARD = 121,
    BOOK_OF_SECRETS = 122,
    MYSTERIOUS_PAPER = 123,
    MYSTERY_SACK = 124,
    UNDEFINED = 125,
    SATANIC_BIBLE = 126,
    DAEMONS_TAIL = 127,
    ABADDON = 128,
    ISAACS_HEART = 129,
    MIND = 130,
    BODY = 131,
    SOUL = 132,
    A_D100 = 133,
    D100 = 133,
    BLUE_MAP = 134,
    THERES_OPTIONS = 135,
    BLACK_CANDLE = 136,
    RED_CANDLE = 137,
    STOP_WATCH = 138,
    WIRE_COAT_HANGER = 139,
    IPECAC = 140,
    EXPERIMENTAL_TREATMENT = 141,
    KRAMPUS = 142,
    HEAD_OF_KRAMPUS = 143,
    SUPER_MEAT_BOY = 144,
    BUTTER_BEAN = 145,
    LITTLE_BAGGY = 146,
    BLOOD_BAG = 147,
    D4 = 148,
    MISSING_POSTER = 149,
    RUBBER_CEMENT = 150,
    STORE_UPGRADE_LV1 = 151,
    STORE_UPGRADE_LV2 = 152,
    STORE_UPGRADE_LV3 = 153,
    STORE_UPGRADE_LV4 = 154,
    ANGELS = 155,
    GODHEAD = 156,
    CHALLENGE_4_DARKNESS_FALLS = 157,
    CHALLENGE_5_THE_TANK = 158,
    CHALLENGE_6_SOLAR_SYSTEM = 159,
    CHALLENGE_7_SUICIDE_KING = 160,
    CHALLENGE_8_CAT_GOT_YOUR_TONGUE = 161,
    CHALLENGE_9_DEMO_MAN = 162,
    CHALLENGE_10_CURSED = 163,
    CHALLENGE_11_GLASS_CANNON = 164,
    CHALLENGE_19_THE_FAMILY_MAN = 165,
    CHALLENGE_20_PURIST = 166,
    LOST_BABY = 167,
    CUTE_BABY = 168,
    CROW_BABY = 169,
    SHADOW_BABY = 170,
    GLASS_BABY = 171,
    WRAPPED_BABY = 172,
    BEGOTTEN_BABY = 173,
    DEAD_BABY = 174,
    ZERO_BABY = 175,
    GLITCH_BABY = 176,
    FIGHTING_BABY = 177,
    BECAME_LORD_OF_THE_FLIES = 178,
    FARTING_BABY = 179,
    PURITY = 180,
    D12 = 181,
    BETRAYAL = 182,
    FATES_REWARD = 183,
    ATHAME = 184,
    BLIND_RAGE = 185,
    MAW_OF_THE_VOID = 186,
    EMPTY_VESSEL = 187,
    EDENS_BLESSING = 188,
    SWORN_PROTECTOR = 189,
    INCUBUS = 190,
    KEEPER_HOLDS_A_PENNY = 191,
    LIL_CHEST = 192,
    CENSER = 193,
    EVIL_EYE = 194,
    MY_SHADOW = 195,
    CRACKED_DICE = 196,
    BLACK_FEATHER = 197,
    LUSTY_BLOOD = 198,
    LILITH = 199,
    KEY_BUM = 200,
    GB_BUG = 201,
    ZODIAC = 202,
    BOX_OF_FRIENDS = 203,
    RIB_OF_GREED = 204,
    CRY_BABY = 205,
    RED_BABY = 206,
    GREEN_BABY = 207,
    BROWN_BABY = 208,
    BLUE_COOP_BABY = 209,
    LIL_BABY = 210,
    RAGE_BABY = 211,
    BLACK_BABY = 212,
    LONG_BABY = 213,
    YELLOW_BABY = 214,
    WHITE_BABY = 215,
    BIG_BABY = 216,
    NOOSE_BABY = 217,
    RUNE_BAG = 218,
    CAMBION_CONCEPTION = 219,
    SERPENTS_KISS = 220,
    SUCCUBUS = 221,
    IMMACULATE_CONCEPTION = 222,
    GOAT_HEAD_BABY = 223,
    GOLDEN_HEARTS = 224,
    GET_OUT_OF_JAIL_FREE_CARD = 225,
    GOLD_BOMB = 226,
    GOLDEN_BOMBS = 226,
    TWO_NEW_PILLS = 227,
    TWO_NEW_PILLS_2 = 228,
    POKER_CHIP = 229,
    STUD_FINDER = 230,
    D8 = 231,
    KIDNEY_STONE = 232,
    BLANK_RUNE = 233,
    BLUE_WOMB = 234,
    ONE_THOUSAND_AND_ONE_PERCENT = 235,
    KEEPER_HOLDS_WOODEN_NICKEL = 236,
    KEEPER_HOLDS_STORE_KEY = 237,
    DEEP_POCKETS = 238,
    KARMA = 239,
    STICKY_NICKELS = 240,
    SUPER_GREED_BABY = 241,
    LUCKY_PENNIES = 242,
    SPECIAL_HANGING_SHOPKEEPERS = 243,
    WOODEN_NICKEL = 244,
    CAIN_HOLDS_PAPERCLIP = 245,
    EVERYTHING_IS_TERRIBLE_2 = 246,
    SPECIAL_SHOPKEEPERS = 247,
    EVE_HOLDS_RAZOR_BLADE = 248,
    STORE_KEY = 249,
    LOST_HOLDS_HOLY_MANTLE = 250,
    KEEPER = 251,
    HIVE_BABY = 252,
    BUDDY_BABY = 253,
    COLORFUL_BABY = 254,
    WHORE_BABY = 255,
    CRACKED_BABY = 256,
    DRIPPING_BABY = 257,
    BLINDING_BABY = 258,
    SUCKY_BABY = 259,
    DARK_BABY = 260,
    PICKY_BABY = 261,
    REVENGE_BABY = 262,
    BELIAL_BABY = 263,
    SALE_BABY = 264,
    CHALLENGE_21_XXXXXXXXL = 265,
    CHALLENGE_22_SPEED = 266,
    CHALLENGE_23_BLUE_BOMBER = 267,
    CHALLENGE_24_PAY_TO_PLAY = 268,
    CHALLENGE_25_HAVE_A_HEART = 269,
    CHALLENGE_26_I_RULE = 270,
    CHALLENGE_27_BRAINS = 271,
    CHALLENGE_28_PRIDE_DAY = 272,
    CHALLENGE_29_ONANS_STREAK = 273,
    CHALLENGE_30_THE_GUARDIAN = 274,
    GENEROSITY = 275,
    MEGA_BLAST = 276,
    CHALLENGE_31_BACKASSWARDS = 277,
    CHALLENGE_32_APRILS_FOOL = 278,
    CHALLENGE_33_POKEY_MANS = 279,
    CHALLENGE_34_ULTRA_HARD = 280,
    CHALLENGE_35_PONG = 281,
    D_INFINITY = 282,
    EUCHARIST = 283,
    SILVER_DOLLAR = 284,
    SHADE = 285,
    KING_BABY = 286,
    BLOODY_CROWN = 287,
    DULL_RAZOR = 288,
    EDENS_SOUL = 289,
    DARK_PRINCES_CROWN = 290,
    COMPOUND_FRACTURE = 291,
    EUTHANASIA = 292,
    HOLY_CARD = 293,
    CROOKED_CARD = 294,
    VOID = 295,
    D1 = 296,
    GLYPH_OF_BALANCE = 297,
    SACK_OF_SACKS = 298,
    EYE_OF_BELIAL = 299,
    MECONIUM = 300,
    STEM_CELL = 301,
    CROW_HEART = 302,
    METRONOME = 303,
    BAT_WING = 304,
    PLAN_C = 305,
    DUALITY = 306,
    DADS_LOST_COIN = 307,
    EYE_OF_GREED = 308,
    BLACK_RUNE = 309,
    LOCUST_OF_WRATH = 310,
    LOCUST_OF_PESTILENCE = 311,
    LOCUST_OF_FAMINE = 312,
    LOCUST_OF_DEATH = 313,
    LOCUST_OF_CONQUEST = 314,
    HUSHY = 315,
    BROWN_NUGGET = 316,
    MORT_BABY = 317,
    SMELTER = 318,
    APOLLYON_BABY = 319,
    VOID_FLOOR = 320,
    GULP_PILL = 321,
    ACE_OF_CLUBS = 322,
    SUPER_SPECIAL_ROCKS = 323,
    SUNSHINE_PILL = 324,
    HORF = 325,
    ACE_OF_DIAMONDS = 326,
    ACE_OF_SPADES = 327,
    SCARED_HEART = 328,
    ACE_OF_HEARTS = 329,
    VURP = 330,
    LAZARUS_BLEEDS_MORE = 331,
    MAGDALENE_HOLDS_A_PILL = 332,
    CHARGED_KEY = 333,
    SAMMSON_FEELS_HEALTHY = 334,
    GREEDS_GULLET = 335,
    CRACKED_CROWN = 336,
    RERUNS = 337,
    DELIRIOUS = 338,
    JUST_STOP = 339,
    APOLLYON = 340,
    GREEDIER = 341,
    BURNING_BASEMENT = 342,
    FLOODED_CAVES = 343,
    DANK_DEPTHS = 344,
    SCARRED_WOMB = 345,
    SOMETHING_WICKED = 346,
    SOMETHING_WICKED_PLUS = 347,
    THE_GATE_IS_OPEN = 348,
    BLACK_HOLE = 349,
    MYSTERY_GIFT = 350,
    SPRINKLER = 351,
    ANGRY_FLY = 352,
    BOZO = 353,
    BROKEN_MODEM = 354,
    BUDDY_IN_A_BOX = 355,
    FAST_BOMBS = 356,
    LIL_DELIRIUM = 357,
    HAIRPIN = 358,
    WOODEN_CROSS = 359,
    BUTTER = 360,
    HUGE_GROWTH = 361,
    ANCIENT_RECALL = 362,
    ERA_WALK = 363,
    COUPON = 364,
    TELEKINESIS = 365,
    MOVING_BOX = 366,
    JUMPER_CABLES = 367,
    LEPROSY = 368,
    TECHNOLOGY_ZERO = 369,
    FILIGREE_FEATHER = 370,
    MR_ME = 371,
    SEVEN_SEALS = 372,
    ANGELIC_PRISM = 373,
    POP = 374,
    DOOR_STOP = 375,
    DEATHS_LIST = 376,
    HAEMOLACHRIA = 377,
    LACHRYPHAGY = 378,
    SCHOOLBAG = 379,
    TRISAGION = 380,
    EXTENSION_CORD = 381,
    FLAT_STONE = 382,
    SACRIFICAL_ALTAR = 383,
    LIL_SPEWER = 384,
    BLANKET = 385,
    MARBLES = 386,
    MYSTERY_EGG = 387,
    ROTTEN_PENNY = 388,
    BABY_BENDER = 389,
    FORGOTTEN = 390,
    BONE_HEARTS = 391,
    MARROW = 392,
    SLIPPED_RIB = 393,
    POINTY_RIB = 394,
    JAW_BONE = 395,
    BRITTLE_BONES = 396,
    DIVORCE_PAPERS = 397,
    HALLOWED_GROUND = 398,
    FINGER_BONE = 399,
    DADS_RING = 400,
    BOOK_OF_THE_DEAD = 401,
    BONE_BABY = 402,
    BOUND_BABY = 403,
    BETHANY = 404,
    JACOB_AND_ESAU = 405,
    PLANETARIUMS = 406,
    ALT_PATH = 407,
    FORGOTTEN_LULLABY = 408,
    FRUITY_PLUM = 409,
    PLUM_FLUTE = 410,
    ROTTEN_HEARTS = 411,
    DROSS = 412,
    ASHPIT = 413,
    GEHENNA = 414,
    RED_KEY = 415,
    WISP_BABY = 416,
    BOOK_OF_VIRTUES = 417,
    URN_OF_SOULS = 418,
    BLESSED_PENNY = 419,
    ALABASTER_BOX = 420,
    BETHS_FAITH = 421,
    SOUL_LOCKET = 422,
    DIVINE_INTERVENTION = 423,
    VADE_RETRO = 424,
    STAR_OF_BETHLEHEM = 425,
    HOPE_BABY = 426,
    GLOWING_BABY = 427,
    DOUBLE_BABY = 428,
    STAIRWAY = 429,
    RED_STEW = 430,
    BIRTHRIGHT = 431,
    DAMOCLES = 432,
    ROCK_BOTTOM = 433,
    INNER_CHILD = 434,
    VANISHING_TWIN = 435,
    GENESIS = 436,
    SUPLEX = 437,
    SOLOMONS_BABY = 438,
    ILLUSION_BABY = 439,
    MEAT_CLEAVER = 440,
    OPTIONS = 441,
    YUCK_HEART = 442,
    CANDY_HEART = 443,
    GUPPYS_EYE = 444,
    POUND_OF_FLESH = 445,
    AKELDAMA = 446,
    REDEMPTION = 447,
    ETERNAL_D6 = 448,
    MONTEZUMAS_REVENGE = 449,
    BIRD_CAGE = 450,
    CRACKED_ORB = 451,
    BLOODY_GUST = 452,
    EMPTY_HEART = 453,
    DEVILS_CROWN = 454,
    LIL_ABADDON = 455,
    TINYTOMA = 456,
    ASTRAL_PROJECTION = 457,
    M = 458,
    EVERYTHING_JAR = 459,
    LOST_SOUL = 460,
    HUNGRY_SOUL = 461,
    BLOOD_PUPPY = 462,
    C_SECTION = 463,
    KEEPERS_SACK = 464,
    KEEPERS_BOX = 465,
    LIL_PORTAL = 466,
    WORM_FRIEND = 467,
    BONE_SPURS = 468,
    SPIRIT_SHACKLES = 469,
    REVELATION = 470,
    JAR_OF_WISPS = 471,
    MAGIC_SKIN = 472,
    FRIEND_FINDER = 473,
    TAINTED_ISAAC = 474,
    TAINTED_MAGDALENE = 475,
    TAINTED_CAIN = 476,
    TAINTED_JUDAS = 477,
    TAINTED_BLUE_BABY = 478,
    TAINTED_EVE = 479,
    TAINTED_SAMSON = 480,
    TAINTED_AZAZEL = 481,
    TAINTED_LAZARUS = 482,
    TAINTED_EDEN = 483,
    TAINTED_LOST = 484,
    TAINTED_LILITH = 485,
    TAINTED_KEEPER = 486,
    TAINTED_APOLLYON = 487,
    TAINTED_FORGOTTEN = 488,
    TAINTED_BETHANY = 489,
    TAINTED_JACOB = 490,
    GLITCHED_CROWN = 491,
    BELLY_JELLY = 492,
    BLUE_KEY = 493,
    SANGUINE_BOND = 494,
    SWARM = 495,
    HEARTBREAK = 496,
    LARYNX = 497,
    AZAZELS_RAGE = 498,
    SALVATION = 499,
    TMTRAINER = 500,
    SACRED_ORB = 501,
    TWISTED_PAIR = 502,
    STRAWMAN = 503,
    ECHO_CHAMBER = 504,
    ISAACS_TOMB = 505,
    VENGEFUL_SPIRIT = 506,
    ESAU_JR = 507,
    CHALLENGE_37_BLOODY_MARY = 508,
    CHALLENGE_38_BAPTISM_BY_FIRE = 509,
    CHALLENGE_39_ISAACS_AWAKENING = 510,
    CHALLENGE_40_SEEING_DOUBLE = 511,
    CHALLENGE_41_PICA_RUN = 512,
    CHALLENGE_42_HOT_POTATO = 513,
    CHALLENGE_43_CANTRIPPED = 514,
    CHALLENGE_44_RED_REDEMPTION = 515,
    CHALLENGE_45_DELETE_THIS = 516,
    DIRTY_MIND = 517,
    SIGIL_OF_BAPHOMET = 518,
    PURGATORY = 519,
    SPIRIT_SWORD = 520,
    BROKEN_GLASSES = 521,
    ICE_CUBE = 522,
    CHARGED_PENNY = 523,
    REVERSED_FOOL = 524,
    REVERSED_MAGICIAN = 525,
    REVERSED_HIGH_PRIESTESS = 526,
    REVERSED_EMPRESS = 527,
    REVERSED_EMPEROR = 528,
    RESERVED_HEIROPHANT = 529,
    REVERSED_LOVERS = 530,
    REVERSED_CHARIOT = 531,
    REVERSED_JUSTICE = 532,
    REVERSED_HERMIT = 533,
    REVERSED_WHEEL_OF_FORTUNE = 534,
    REVERSED_STRENGTH = 535,
    REVERSED_HANGED_MAN = 536,
    REVERSED_DEATH = 537,
    REVERSED_TEMPERANCE = 538,
    REVERSED_DEVIL = 539,
    REVERSED_TOWER = 540,
    REVERSED_STARS = 541,
    REVERSED_SUN_AND_MOON = 542,
    REVERSED_JUDGEMENT = 543,
    REVERSED_WORLD = 544,
    OLD_CAPACITOR = 545,
    BRIMSTONE_BOMBS = 546,
    MEGA_MUSH = 547,
    MOMS_LOCK = 548,
    DICE_BAG = 549,
    HOLY_CROWN = 550,
    MOTHERS_KISS = 551,
    GILDED_KEY = 552,
    LUCKY_SACK = 553,
    YOUR_SOUL = 554,
    NUMBER_MAGNET = 555,
    DINGLE_BERRY = 556,
    RING_CAP = 557,
    STRANGE_KEY = 558,
    LIL_CLOT = 559,
    TEMPORARY_TATTOO = 560,
    SWALLOWED_M80 = 561,
    WICKED_CROWN = 562,
    AZAZELS_STUMP = 563,
    TORN_POCKET = 564,
    TORN_CARD = 565,
    NUH_UH = 566,
    MODELING_CLAY = 567,
    KIDS_DRAWING = 568,
    CRYSTAL_KEY = 569,
    THE_TWINS = 570,
    ADOPTION_PAPERS = 571,
    KEEPERS_BARGAIN = 572,
    CURSED_PENNY = 573,
    CRICKET_LEG = 574,
    APOLLYONS_BEST_FRIEND = 575,
    POLISHED_BONE = 576,
    HOLLOW_HEART = 577,
    EXPANSION_PACK = 578,
    BETHS_ESSENCE = 579,
    RC_REMOTE = 580,
    FOUND_SOUL = 581,
    MEMBER_CARD = 582,
    GOLDEN_RAZOR = 583,
    SPINDOWN_DICE = 584,
    HYPERCOAGULATION = 585,
    BAG_OF_CRAFTING = 586,
    DARK_ARTS = 587,
    IBS = 588,
    SUMPTORIUM = 589,
    BERSERK = 590,
    HEMOPTYSIS = 591,
    FLIP = 592,
    CORRUPTED_DATA = 593,
    GHOST_BOMBS = 594,
    GELLO = 595,
    KEEPERS_KIN = 596,
    ABYSS = 597,
    DECAP_ATTACK = 598,
    LEMEGETON = 599,
    ANIMA_SOLA = 600,
    MEGA_CHEST = 601,
    QUEEN_OF_HEARTS = 602,
    GOLDEN_PILLS = 603,
    BLACK_SACK = 604,
    CHARMING_POOP = 605,
    HORSE_PILLS = 606,
    CRANE_GAME = 607,
    HELL_GAME = 608,
    WOODEN_CHEST = 609,
    WILD_CARD = 610,
    HAUNTED_CHEST = 611,
    FOOLS_GOLD = 612,
    GOLDEN_PENNY = 613,
    ROTTEN_BEGGAR = 614,
    GOLDEN_BATTERY = 615,
    CONFESSIONAL = 616,
    GOLDEN_TRINKET = 617,
    SOUL_OF_ISAAC = 618,
    SOUL_OF_MAGDALENE = 619,
    SOUL_OF_CAIN = 620,
    SOUL_OF_JUDAS = 621,
    SOUL_OF_BLUE_BABY = 622,
    SOUL_OF_EVE = 623,
    SOUL_OF_SAMSON = 624,
    SOUL_OF_AZAZEL = 625,
    SOUL_OF_LAZARUS = 626,
    SOUL_OF_EDEN = 627,
    SOUL_OF_LOST = 628,
    SOUL_OF_LILITH = 629,
    SOUL_OF_KEEPER = 630,
    SOUL_OF_APOLLYON = 631,
    SOUL_OF_FORGOTTEN = 632,
    SOUL_OF_BETHANY = 633,
    SOUL_OF_JACOB = 634,
    STRANGE_DOOR = 635,
    DEATH_CERTIFICATE = 636,
    DEAD_GOD = 637,
}
---@enum FollowerPriority
FollowerPriority = {
    DEFAULT = 0,
    SHOOTER = 1,
    DEFENSIVE = 2, -- Dry Baby, Mongo Baby, Cencer, Lil Abaddon
    SHOOTER_SPECIAL = 3, -- Lil Brim, Lil Monstro
    INCUBUS = 10,
    KING_BABY = 9999,
}
---@enum HealthType
HealthType = {
    DEFAULT = 0,
    RED = 0,
    SOUL = 1,
    LOST = 2,
    NO_HEALTH = 2,
    COIN = 3,
    KEEPER = 3,
    BONE = 4,
}
---@enum Dimension
Dimension = {
    CURRENT = -1,
    NORMAL = 0,
    KNIFE_PUZZLE = 1,
    MIRROR = 1,
    MINESHAFT = 1,
    DEATH_CERTIFICATE = 2,
}
---@enum LineCheckMode
LineCheckMode = {
    ENTITY = 0,
    RAYCAST = 1, -- Similar to ENTITY, and cheaper, but can pass between diagonally adjacent GridEntities
    EXPLOSION = 2,
    PROJECTILE = 3,
}
---@enum ProjectileMode
ProjectileMode = {
    SINGLE = 0,
    SPREAD_TWO = 1,
    SPREAD_THREE = 2,
    SPREAD_THREE_NO_INHERITANCE = 3,
    SPREAD_FOUR = 4,
    SPREAD_FIVE = 5,
    PLUS = 6,
    CROSS = 7,
    CIRCLE_EIGHT = 8,
    CIRCLE_CUSTOM = 9,
}
---@enum StbGridType
StbGridType = {
    DECORATION = 0,
    ROCK = 1000,
    BOMB_ROCK = 1001,
    ALT_ROCK = 1002,
    TINTED_ROCK = 1003,
    MARKED_SKULL = 1008,
    EVENT_ROCK = 1009,
    SPIKE_ROCK = 1010,
    FOOLS_GOLD_ROCK = 1011,
    TNT = 1300,
    RED_POOP = 1490,
    RAINBOW_POOP = 1494,
    CORN_POOP = 1495,
    GOLDEN_POOP = 1496,
    BLACK_POOP = 1497,
    HOLY_POOP = 1498,
    GIANT_POOP = 1499,
    POOP = 1500,
    CHARMING_POOP = 1501,
    BLOCK = 1900,
    PILLAR = 1901,
    SPIKES = 1930,
    RETRACTING_SPIKES = 1931,
    COBWEB = 1940,
    INVISIBLE_BLOCK = 1999,
    PIT = 3000,
    EVENT_RAIL = 3002,
    EVENT_PIT = 3009,
    KEY_BLOCK = 4000,
    PRESSURE_PLATE = 4500,
    DEVIL_STATUE = 5000,
    ANGEL_STATUE = 5001,
    RAIL = 6000,
    RAIL_PIT = 6001,
    TELEPORTER = 6100,
    TRAP_DOOR = 9000,
    CRAWLSPACE = 9100,
    GRAVITY = 10000,
}
---@enum StbRockSubType
StbRockSubType = {
    NORMAL = 0,
    NON_REPLACEABLE = 1,
}
---@enum StbPoopSubType
StbPoopSubType = {
    NORMAL = 0,
    NON_REPLACEABLE = 1,
}
---@enum StbTeleporterSubType
StbTeleporterSubType = {
    ACTIVE = 0,
    INNACTIVE = 1,
}
---@enum StbRailVariant
StbRailVariant = {
    HORIZONTAL = 0,
    VERTICAL = 1,
    DOWN_TO_RIGHT = 2,
    DOWN_TO_LEFT = 3,
    UP_TO_RIGHT = 4,
    UP_TO_LEFT = 5,
    CROSSROAD = 6,
    END_LEFT = 7,
    END_RIGHT = 8,
    END_UP = 9,
    END_DOWN = 10,
    HORIZONTAL_CART_LEFT = 16,
    HORIZONTAL_CART_RIGHT = 32,
    VERTICAL_CART_UP = 17,
    VERTICAL_CART_DOWN = 33,
    MINESHAFT_HORIZONTAL_1 = 80,
    MINESHAFT_HORIZONTAL_2 = 96,
    MINESHAFT_HORIZONTAL_3 = 112,
    MINESHAFT_VERTICAL_1 = 81,
    MINESHAFT_VERTICAL_2 = 97,
    MINESHAFT_VERTICAL_3 = 113,
    MINESHAFT_DOWN_TO_RIGHT_1 = 82,
    MINESHAFT_DOWN_TO_RIGHT_2 = 98,
    MINESHAFT_DOWN_TO_LEFT_1 = 83,
    MINESHAFT_DOWN_TO_LEFT_2 = 99,
    MINESHAFT_UP_TO_RIGHT_1 = 84,
    MINESHAFT_UP_TO_RIGHT_2 = 100,
    MINESHAFT_UP_TO_LEFT_1 = 85,
    MINESHAFT_UP_TO_LEFT_2 = 101,
}
---@enum RetractingSpikesVariant
RetractingSpikesVariant = {
    NORMAL = 0,
    DOWN_1 = 1,
    DOWN_2 = 2,
    DOWN_3 = 3,
    DOWN_4 = 4,
    DOWN_5 = 5,
    UP_1 = 6,
    UP_2 = 7,
    UP_3 = 8,
    UP_4 = 9,
    UP_5 = 10,
}
---@enum PressurePlateVariant
PressurePlateVariant = {
    ROOM_CLEAR = 0,
    REWARD = 1,
    GREED_MODE = 2,
    MINES_PUZZLE = 3,
    RAIL_PLATE = 3,
    KILL_SWITCH = 9,
    EVENT_GROUP_0 = 10,
    EVENT_0 = 10,
    EVENT_GROUP_1 = 11,
    EVENT_1 = 11,
    EVENT_GROUP_2 = 12,
    EVENT_2 = 12,
    EVENT_GROUP_3 = 13,
    EVENT_3 = 13,
}
---@enum TeleporterVariant
TeleporterVariant = {
    SQUARE = 0,
    MOON = 1,
    RHOMBUS = 2,
    DIAMOND = 2,
    M = 3,
    HAGALAZ = 3,
    PENTAGRAM = 4,
    CROSS = 5,
    TRIANGLE = 6,
}
---@enum GridPoopVariant
GridPoopVariant = {
    NORMAL = 0,
    RED = 1,
    CHUNKY = 2,
    CORN = 2,
    GOLDEN = 3,
    RAINBOW = 4,
    BLACK = 5,
    HOLY = 6,
    WHITE = 6,
    GIANT_TL = 7,
    GIANT_TR = 8,
    GIANT_BL = 9,
    GIANT_BR = 10,
    CHARMING = 11,
}
---@enum EntityPoopVariant
EntityPoopVariant = {
    NORMAL = 0,
    GOLDEN = 1,
    STONE = 11,
    PETRIFIED = 11,
    CHUNKY = 12,
    CORN = 12,
    FLAMING = 13,
    STINKY = 14,
    POISON = 14,
    BLACK = 15,
    HOLY = 16,
    WHITE = 16,
}
---@enum PlayerVariant
PlayerVariant = {
    PLAYER = 0,
    FOUND_SOUL = 1,
    CO_OP_BABY = 1,
}
---@enum PillCardSlot
PillCardSlot = {
    PRIMARY = 0,
    SECONDARY = 1,
    TERTIARY = 2, -- Offset by 2 of: Pocket Item, Dice Bag Item, Pillcard (Otherwise unused)
    QUATERNARY = 3, -- Offset by Pocket Item and Dice Bag Item and Pillcard (Otherwise unused)
}
---@enum MainMenuType
MainMenuType = {
    TITLE = 1, -- 0 exists but its unusable
    SAVES = 2,
    GAME = 3, -- the actual menu where all the menus are
    DAILYRUN = 4,
    CHARACTER = 5,
    SPECIALSEEDS = 6,
    CHALLENGE = 7,
    COLLECTION = 8,
    STATS = 9,
    OPTIONS = 10,
    CONTROLS = 11,
    KEYCONFIG = 12,
    ENDINGS = 13,
    BESTIARY = 14,
    MODCHALLENGES = 15,
    MODS = 16,
    SEED = 17,
}
---@enum EventCounter
EventCounter = {
    NULL = 0, -- Seems unused
    MOM_KILLS = 1, -- Stat from the stat screen. Counts kills of Moms heart (Does only count instances where the kill is combined with run "progression". aka in final room and spawning a trapdoor/chest/trophy)
    ROCKS_DESTROYED = 2, -- Includes all rock types including tinted rocks
    TINTED_ROCKS_DESTROYED = 3,
    SUPER_SPECIAL_ROCKS_DESTROYED = 4, -- Super Special Rocks are Tinted Rock variants with smaller marks and lack of discoloration
    POOP_DESTROYED = 5, -- Includes all poop types. Red poop counts everytime it gets destroyed
    PILLS_EATEN = 6, -- Includes all pills including horse pills
    XIII_DEATH_CARD_USED = 7,
    UNKNOWN_EVENT_8 = 8,
    ARCADES_ENTERED = 9, -- Also includes teleports with goto.
    DEATHS = 10, -- does not increase when revived
    ISAAC_KILLS = 11, -- How often was the final boss of cathedral killed. (Isaac) (Does only count instances where the kill is combined with run "progression". aka in final room and spawning a trapdoor/chest/trophy)
    SHOPKEEPER_KILLED = 12,
    SATAN_KILLS = 13, -- How often was the final boss of sheol killed. (Satan) (Does only count instances where the kill is combined with run "progression". aka in final room and spawning a trapdoor/chest/trophy)
    SHELLGAMES_PLAYED = 14, -- How often the shellgame was played
    ANGEL_DEALS_TAKEN = 15,
    DEVIL_DEALS_TAKEN = 16,
    BLOOD_DONATION_MACHINE_USED = 17,
    SLOT_MACHINES_BROKEN = 18,
    DONATE_MACHINE_COUNTER = 20,
    DONATION_MACHINE_COUNTER = 20,
    EDEN_TOKENS = 21,
    STREAK_COUNTER = 22, -- counts your current streak.
    BEST_STREAK = 23,
    BLUE_BABY_KILLS = 24, -- How often was the final boss of chest killed. (??? - Blue Baby) (Does only count instances where the kill is combined with run "progression". aka in final room and spawning a trapdoor/chest/trophy)
    LAMB_KILLS = 25, -- How often was the final boss of dark room killed. (The lamb) (Does only count instances where the kill is combined with run "progression". aka in final room and spawning a trapdoor/chest/trophy)
    MEGA_SATAN_KILLS = 26,
    PROGRESSION_KILL_MOMS_HEART_WITH_ISAAC = 27, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_MAGDALENE = 28, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_CAIN = 29, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_JUDAS = 30, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_BLUE_BABY = 31, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_EVE = 32, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_SAMSON = 33, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_AZAZEL = 34, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_LAZARUS = 35, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_EDEN = 36, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_THE_LOST = 37, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_LILITH = 38, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_KEEPER = 39, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_APOLLYON = 40, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_ISAAC = 41, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_MAGDALENE = 42, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_CAIN = 43, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_JUDAS = 44, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_BLUE_BABY = 45, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_EVE = 46, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_SAMSON = 47, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_AZAZEL = 48, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_LAZARUS = 49, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_EDEN = 50, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_THE_LOST = 51, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_LILITH = 52, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_KEEPER = 53, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_APOLLYON = 54, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_ISAAC = 55, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_MAGDALENE = 56, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_CAIN = 57, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_JUDAS = 58, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_BLUE_BABY = 59, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_EVE = 60, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_SAMSON = 61, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_AZAZEL = 62, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_LAZARUS = 63, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_EDEN = 64, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_THE_LOST = 65, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_LILITH = 66, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_KEEPER = 67, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_APOLLYON = 68, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_ISAAC = 69, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_MAGDALENE = 70, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_CAIN = 71, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_JUDAS = 72, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_BLUE_BABY = 73, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_EVE = 74, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_SAMSON = 75, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_AZAZEL = 76, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_LAZARUS = 77, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_EDEN = 78, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_THE_LOST = 79, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_LILITH = 80, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_KEEPER = 81, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_APOLLYON = 82, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_ISAAC = 83, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_MAGDALENE = 84, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_CAIN = 85, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_JUDAS = 86, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_BLUE_BABY = 87, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_EVE = 88, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_SAMSON = 89, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_AZAZEL = 90, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_LAZARUS = 91, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_EDEN = 92, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_THE_LOST = 93, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_LILITH = 94, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_KEEPER = 95, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_APOLLYON = 96, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_ISAAC = 97, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_MAGDALENE = 98, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_CAIN = 99, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_JUDAS = 100, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_BLUE_BABY = 101, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_EVE = 102, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_SAMSON = 103, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_AZAZEL = 104, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_LAZARUS = 105, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_EDEN = 106, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_THE_LOST = 107, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_LILITH = 108, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_KEEPER = 109, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_APOLLYON = 110, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    BOSSRUSHS_CLEARED = 111,
    UNKNOWN_EVENT_112 = 112, -- seems to only be at 1 for a dead god file
    NEGATIVE_STREAK_COUNTER = 113, -- counts your current negative streak. aka consecutive runs ending with death.
    EDENS_BLESSINGS_NEXT_RUN = 114, -- number of edens blessing items added to the player in next run
    GREED_DONATION_MACHINE_COUNTER = 115,
    PROGRESSION_KILL_MEGA_SATAN_WITH_ISAAC = 116, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_MAGDALENE = 117, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_CAIN = 118, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_JUDAS = 119, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_BLUE_BABY = 120, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_EVE = 121, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_SAMSON = 122, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_AZAZEL = 123, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_LAZARUS = 124, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_EDEN = 125, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_THE_LOST = 126, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_LILITH = 127, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_KEEPER = 128, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_APOLLYON = 129, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_ISAAC = 130, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_MAGDALENE = 131, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_CAIN = 132, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_JUDAS = 133, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_BLUE_BABY = 134, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_EVE = 135, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_SAMSON = 136, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_AZAZEL = 137, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_LAZARUS = 138, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_EDEN = 139, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_THE_LOST = 140, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_LILITH = 141, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_KEEPER = 142, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_GREED_MODE_CLEARED_WITH_APOLLYON = 143, -- (value = 0, 1 for greed mode, 2 for greedier)
    PROGRESSION_KILL_HUSH_WITH_ISAAC = 144, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_MAGDALENE = 145, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_CAIN = 146, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_JUDAS = 147, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_BLUE_BABY = 148, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_EVE = 149, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_SAMSON = 150, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_AZAZEL = 151, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_LAZARUS = 152, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_EDEN = 153, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_THE_LOST = 154, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_LILITH = 155, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_KEEPER = 156, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_APOLLYON = 157, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    HUSH_KILLS = 158, -- How often Hush was killed. (Does only count instances where the kill is combined with run "progression". aka in final room and spawning a trapdoor/chest/trophy)
    GREED_MODE_COINS_DONATED_WITH_ISAAC = 159,
    GREED_MODE_COINS_DONATED_WITH_MAGDALENE = 160,
    GREED_MODE_COINS_DONATED_WITH_CAIN = 161,
    GREED_MODE_COINS_DONATED_WITH_JUDAS = 162,
    GREED_MODE_COINS_DONATED_WITH_BLUE = 163,
    GREED_MODE_COINS_DONATED_WITH_EVE = 164,
    GREED_MODE_COINS_DONATED_WITH_SAMSON = 165,
    GREED_MODE_COINS_DONATED_WITH_AZAZEL = 166,
    GREED_MODE_COINS_DONATED_WITH_LAZARUS = 167,
    GREED_MODE_COINS_DONATED_WITH_EDEN = 168,
    GREED_MODE_COINS_DONATED_WITH_THE_LOST = 169,
    GREED_MODE_COINS_DONATED_WITH_LILITH = 170,
    GREED_MODE_COINS_DONATED_WITH_KEEPER = 171,
    GREED_MODE_COINS_DONATED_WITH_APOLLYON = 172,
    PROGRESSION_KILL_DELIRIUM_WITH_ISAAC = 173, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_MAGDALENE = 174, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_CAIN = 175, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_JUDAS = 176, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_BLUE_BABY = 177, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_EVE = 178, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_SAMSON = 179, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_AZAZEL = 180, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_LAZARUS = 181, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_EDEN = 182, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_THE_LOST = 183, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_LILITH = 184, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_KEEPER = 185, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_APOLLYON = 186, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    DELIRIUM_KILLS = 187, -- How often was the final boss of the void was killed. (Delirium) (Does only count instances where the kill is combined with run "progression". aka in final room and spawning a trapdoor/chest/trophy)
    CHARACTER_LAST_RUN_WIN = 188, -- Potential Bitmask containing the ids of the characters that won the last run, including coop. gets cleared on run restart. TODO: Usage and pattern still unknown!!!
    UNKNOWN_EVENT_189 = 189, -- really big counter
    DAILYS_PLAYED = 190, -- counts dailies played
    DAILY_RUN_IS_ACTIVE = 191, -- Set to 1 when daily is currently played. Set to 0 when trophy was collected
    DAILYS_STREAK = 192, -- Numbers of dailies won in a row
    DAILYS_WON = 193, -- Number of dailies won
    RAINBOW_POOP_DESTROYED = 194,
    BATTERIES_COLLECTED = 195, -- Sum of all batteries collected
    CARDS_USED = 196, -- Sum of cards used
    SHOP_ITEMS_BOUGHT = 197, -- Sum of shop items bought. this includes devil deals, dark room red chest deals, and black market deals
    CHESTS_OPENED_WITH_KEY = 198, -- Sum of all golden and Eternal Chests opened. Mega chests dont count
    SECRET_ROOMS_WALLS_OPENED = 199, -- Includes super secret rooms and counts walls that lead to secret rooms already entered or discovered. Also counts the door towards the mines. Does not count X-Ray Vision effect
    BLOOD_CLOT_ITEM_AQUIRED = 200,
    RUBBER_CEMENT_ITEM_AQUIRED = 201,
    BEDS_USED = 202, -- Sleeping in a bed
    PROGRESSION_KILL_MOMS_HEART_WITH_THE_FORGOTTEN = 203, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_THE_FORGOTTEN = 204, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_THE_FORGOTTEN = 205, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_THE_FORGOTTEN = 206, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_THE_FORGOTTEN = 207, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_THE_FORGOTTEN = 208, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_THE_FORGOTTEN = 209, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_THE_FORGOTTEN = 210, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_THE_FORGOTTEN = 211, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    GREED_MODE_COINS_DONATED_WITH_FORGOTTEN = 212,
    PROGRESSION_KILL_DELIRIUM_WITH_THE_FORGOTTEN = 213, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_BETHANY = 214, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_JACOB_AND_ESAU = 215, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_ISAAC = 216, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_MAGDALENE = 217, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_CAIN = 218, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_JUDAS = 219, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_BLUE_BABY = 220, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_EVE = 221, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_SAMSON = 222, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_AZAZEL = 223, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_LAZARUS = 224, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_EDEN = 225, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_THE_LOST = 226, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_LILITH = 227, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_KEEPER = 228, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_APOLLYON = 229, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_THE_FORGOTTEN = 230, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_BETHANY = 231, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOMS_HEART_WITH_T_JACOB_AND_ESAU = 232, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_BETHANY = 233, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_JACOB_AND_ESAU = 234, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_ISAAC = 235, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_MAGDALENE = 236, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_CAIN = 237, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_JUDAS = 238, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_BLUE_BABY = 239, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_EVE = 240, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_SAMSON = 241, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_AZAZEL = 242, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_LAZARUS = 243, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_EDEN = 244, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_THE_LOST = 245, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_LILITH = 246, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_KEEPER = 247, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_APOLLYON = 248, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_THE_FORGOTTEN = 249, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_BETHANY = 250, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_ISAAC_WITH_T_JACOB_AND_ESAU = 251, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_BETHANY = 252, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_JACOB_AND_ESAU = 253, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_ISAAC = 254, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_MAGDALENE = 255, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_CAIN = 256, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_JUDAS = 257, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_BLUE_BABY = 258, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_EVE = 259, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_SAMSON = 260, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_AZAZEL = 261, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_LAZARUS = 262, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_EDEN = 263, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_THE_LOST = 264, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_LILITH = 265, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_KEEPER = 266, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_APOLLYON = 267, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_THE_FORGOTTEN = 268, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_BETHANY = 269, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_SATAN_WITH_T_JACOB_AND_ESAU = 270, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_BETHANY = 271, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_JACOB_AND_ESAU = 272, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_ISAAC = 273, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_MAGDALENE = 274, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_CAIN = 275, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_JUDAS = 276, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_BLUE_BABY = 277, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_EVE = 278, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_SAMSON = 279, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_AZAZEL = 280, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_LAZARUS = 281, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_EDEN = 282, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_THE_LOST = 283, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_LILITH = 284, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_KEEPER = 285, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_APOLLYON = 286, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_THE_FORGOTTEN = 287, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_BETHANY = 288, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_BOSSRUSH_CLEARED_WITH_T_JACOB_AND_ESAU = 289, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_BETHANY = 290, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_JACOB_AND_ESAU = 291, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_ISAAC = 292, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_MAGDALENE = 293, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_CAIN = 294, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_JUDAS = 295, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_BLUE_BABY = 296, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_EVE = 297, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_SAMSON = 298, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_AZAZEL = 299, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_LAZARUS = 300, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_EDEN = 301, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_THE_LOST = 302, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_LILITH = 303, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_KEEPER = 304, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_APOLLYON = 305, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_THE_FORGOTTEN = 306, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_BETHANY = 307, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BLUE_BABY_WITH_T_JACOB_AND_ESAU = 308, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_BETHANY = 309, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_JACOB_AND_ESAU = 310, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_ISAAC = 311, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_MAGDALENE = 312, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_CAIN = 313, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_JUDAS = 314, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_BLUE_BABY = 315, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_EVE = 316, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_SAMSON = 317, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_AZAZEL = 318, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_LAZARUS = 319, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_EDEN = 320, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_THE_LOST = 321, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_LILITH = 322, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_KEEPER = 323, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_APOLLYON = 324, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_THE_FORGOTTEN = 325, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_BETHANY = 326, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_THE_LAMB_WITH_T_JACOB_AND_ESAU = 327, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_BETHANY = 328, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_JACOB_AND_ESAU = 329, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_ISAAC = 330, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_MAGDALENE = 331, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_CAIN = 332, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_JUDAS = 333, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_BLUE_BABY = 334, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_EVE = 335, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_SAMSON = 336, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_AZAZEL = 337, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_LAZARUS = 338, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_EDEN = 339, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_THE_LOST = 340, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_LILITH = 341, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_KEEPER = 342, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_APOLLYON = 343, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_THE_FORGOTTEN = 344, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_BETHANY = 345, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MEGA_SATAN_WITH_T_JACOB_AND_ESAU = 346, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_BETHANY = 347, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_JACOB_AND_ESAU = 348, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_ISAAC = 349, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_MAGDALENE = 350, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_CAIN = 351, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_JUDAS = 352, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_BLUE_BABY = 353, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_EVE = 354, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_SAMSON = 355, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_AZAZEL = 356, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_LAZARUS = 357, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_EDEN = 358, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_THE_LOST = 359, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_LILITH = 360, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_KEEPER = 361, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_APOLLYON = 362, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_THE_FORGOTTEN = 363, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_BETHANY = 364, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_GREED_MODE_CLEARED_WITH_T_JACOB_AND_ESAU = 365, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_BETHANY = 366, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_JACOB_AND_ESAU = 367, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_ISAAC = 368, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_MAGDALENE = 369, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_CAIN = 370, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_JUDAS = 371, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_BLUE_BABY = 372, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_EVE = 373, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_SAMSON = 374, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_AZAZEL = 375, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_LAZARUS = 376, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_EDEN = 377, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_THE_LOST = 378, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_LILITH = 379, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_KEEPER = 380, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_APOLLYON = 381, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_THE_FORGOTTEN = 382, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_BETHANY = 383, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_HUSH_WITH_T_JACOB_AND_ESAU = 384, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    GREED_MODE_COINS_DONATED_WITH_BETHANY = 385,
    GREED_MODE_COINS_DONATED_WITH_JACOB_AND_ESAU = 386,
    GREED_MODE_COINS_DONATED_WITH_T_ISAAC = 387,
    GREED_MODE_COINS_DONATED_WITH_T_MAGDALENE = 388,
    GREED_MODE_COINS_DONATED_WITH_T_CAIN = 389,
    GREED_MODE_COINS_DONATED_WITH_T_JUDAS = 390,
    GREED_MODE_COINS_DONATED_WITH_T_BLUE_BABY = 391,
    GREED_MODE_COINS_DONATED_WITH_T_EVE = 392,
    GREED_MODE_COINS_DONATED_WITH_T_SAMSON = 393,
    GREED_MODE_COINS_DONATED_WITH_T_AZAZEL = 394,
    GREED_MODE_COINS_DONATED_WITH_T_LAZARUS = 395,
    GREED_MODE_COINS_DONATED_WITH_T_EDEN = 396,
    GREED_MODE_COINS_DONATED_WITH_T_THE_LOST = 397,
    GREED_MODE_COINS_DONATED_WITH_T_LILITH = 398,
    GREED_MODE_COINS_DONATED_WITH_T_KEEPER = 399,
    GREED_MODE_COINS_DONATED_WITH_T_THE_FORGOTTEN = 400,
    GREED_MODE_COINS_DONATED_WITH_T_BETHANY = 401,
    GREED_MODE_COINS_DONATED_WITH_T_JACOB_AND_ESAU = 402,
    PROGRESSION_KILL_DELIRIUM_WITH_BETHANY = 404, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_JACOB_AND_ESAU = 405, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_ISAAC = 406, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_MAGDALENE = 407, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_CAIN = 408, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_JUDAS = 409, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_BLUE_BABY = 410, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_EVE = 411, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_SAMSON = 412, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_AZAZEL = 413, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_LAZARUS = 414, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_EDEN = 415, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_THE_LOST = 416, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_LILITH = 417, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_KEEPER = 418, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_APOLLYON = 419, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_THE_FORGOTTEN = 420, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_BETHANY = 421, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_DELIRIUM_WITH_T_JACOB_AND_ESAU = 422, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_ISAAC = 423, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_MAGDALENE = 424, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_CAIN = 425, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_JUDAS = 426, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_BLUE_BABY = 427, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_EVE = 428, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_SAMSON = 429, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_AZAZEL = 430, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_LAZARUS = 431, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_EDEN = 432, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_THE_LOST = 433, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_LILITH = 434, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_KEEPER = 435, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_APOLLYON = 436, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_THE_FORGOTTEN = 437, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_BETHANY = 438, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_JACOB_AND_ESAU = 439, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_ISAAC = 440, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_MAGDALENE = 441, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_CAIN = 442, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_JUDAS = 443, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_BLUE_BABY = 444, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_EVE = 445, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_SAMSON = 446, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_AZAZEL = 447, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_LAZARUS = 448, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_EDEN = 449, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_THE_LOST = 450, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_LILITH = 451, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_KEEPER = 452, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_APOLLYON = 453, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_THE_FORGOTTEN = 454, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_BETHANY = 455, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_MOTHER_WITH_T_JACOB_AND_ESAU = 456, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_ISAAC = 457, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_MAGDALENE = 458, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_CAIN = 459, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_JUDAS = 460, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_BLUE_BABY = 461, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_EVE = 462, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_SAMSON = 463, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_AZAZEL = 464, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_LAZARUS = 465, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_EDEN = 466, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_THE_LOST = 467, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_LILITH = 468, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_KEEPER = 469, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_APOLLYON = 470, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_THE_FORGOTTEN = 471, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_BETHANY = 472, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_JACOB_AND_ESAU = 473, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_ISAAC = 474, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_MAGDALENE = 475, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_CAIN = 476, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_JUDAS = 477, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_BLUE_BABY = 478, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_EVE = 479, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_SAMSON = 480, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_AZAZEL = 481, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_LAZARUS = 482, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_EDEN = 483, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_THE_LOST = 484, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_LILITH = 485, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_KEEPER = 486, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_APOLLYON = 487, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_THE_FORGOTTEN = 488, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_BETHANY = 489, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    PROGRESSION_KILL_BEAST_WITH_T_JACOB_AND_ESAU = 490, -- (0 for not done. 1 for normal difficulty, 2 for hard)
    MOTHER_KILLS = 491, -- Killing endboss of Corpse 2 (Does only count instances where the kill is combined with run "progression". aka in final room and spawning a trapdoor/chest/trophy)
    BEAST_KILLS = 492, -- Killing the endboss of Home
    BABY_PLUM_KILLS = 493,
    BATTERY_BUMS_KILLED = 494,
    BATTERY_BUM_COLLECTIBLE_PAYOUTS = 495, -- counts how often the battery bum paid out with a collectible item
    NUM_EVENT_COUNTERS = 496,
}
---@enum WispSubType
WispSubType = {
    SPECIAL_FLAG = 65536,
    NOTCHED_AXE_COAL = 65536, -- 0 | SPECIAL_FLAG
    NOTCHED_AXE_IRON = 65537, -- 1 | SPECIAL_FLAG
    NOTCHED_AXE_GOLD = 65538, -- etc
    NOTCHED_AXE_DIAMON = 65539,
    NOTCHED_AXE_REDSTONE = 65540,
    JAR_OF_FLIES_1 = 65541,
    JAR_OF_FLIES_2 = 65542,
    JAR_OF_FLIES_3 = 65543,
    JAR_OF_FLIES_4 = 65544,
    JAR_OF_FLIES_5 = 65545,
    FRIENDLY_BALL_NORMAL = 65546,
    FRIENDLY_BALL_EXPLOSIVE = 65547,
    FRIENDLY_BALL_HOMING = 65548,
    FRIENDLY_BALL_BRIMSTONE = 65549,
    DELIRIOUS_MONSTRO = 65550,
    DELIRIOUS_DUKE = 65551,
    DELIRIOUS_LOKI = 65552,
    DELIRIOUS_HAUNT = 65553,
    LEMEGETON_VIRTUE = 65554,
}
---@enum Language
Language = {
    ENGLISH = 0,
    JAPANESE = 2,
    FRENCH = 3,
    SPANISH = 4,
    GERMAN = 5,
    RUSSIAN = 10,
    KOREAN = 11,
    CHINESE = 13,
    KEY = 21,
}
---@enum AnnouncerVoiceMode
AnnouncerVoiceMode = {
    RANDOM = 0,
    NEVER = 1,
    OFF = 1,
    ALWAYS = 2,
}
---@enum CameraStyle
CameraStyle = {
    ACTIVE_CAM_ON = 1,
    ACTIVE_CAM_OFF = 2,
}
---@enum ConsoleFont
ConsoleFont = {
    DEFAULT = 0,
    SMALL = 1,
    TINY = 2,
}
---@enum ExtraHudStyle
ExtraHudStyle = {
    OFF = 0,
    ON = 1,
    ON_MINI = 2,
}
---@enum Ending
Ending = {
    DIE = 1,
    EPILOGUE = 2,
    CREDITS = 3,
    SATAN = 4,
    ENDING_12 = 4,
    ISAAC = 5,
    ENDING_13 = 5,
    LAMB = 6,
    ENDING_15 = 6,
    BLUE_BABY = 7,
    ENDING_14 = 7,
    MEGA_SATAN = 8,
    ENDING_16 = 8,
    ULTRA_GREED = 9,
    ENDING_18 = 9,
    HUSH = 10,
    ENDING_17 = 10,
    DELIRIUM = 11,
    ENDING_20 = 11,
    ULTRA_GREEDIER = 12,
    ENDING_19 = 12,
    MOTHER = 13,
    ENDING_21 = 13,
    BEAST = 14,
    FINAL_ENDING = 14,
}
---@enum FadeoutTarget
FadeoutTarget = {
    FILE_SELECT_MENU = 1,
    SAVEFILE_MENU = 2,
    TITLE_SCREEN = 3,
    NEW_RUN = 4,
}
---@enum MouseButton
MouseButton = {
    LEFT = 0,
    RIGHT = 1,
    SCROLLWHEEL = 2,
    BACK = 3, -- Located on the side of some mice
    FORWARD = 4, -- Located on the side of some mice
}
---@enum Giantbook
Giantbook = {
    NECRONOMICON = 1,
    MONSTER_MANUAL = 2,
    WHORE_OF_BABYLON = 3,
    HORRIBLE_NIGHT = 3,
    DEAD_SEA_SCROLLS = 4,
    THE_SUN = 5,
    ETERNAL_HEART_SOUL = 6,
    MOMS_BRA = 7,
    MOMS_PAD = 8,
    ANARCHIST_COOKBOOK = 9,
    BIBLE = 10,
    BOOK_OF_REVELATIONS = 11,
    DEATH = 12,
    ETERNAL_HEART = 13,
    HOURGLASS = 14,
    SATANIC_BIBLE = 15,
    BLACK_HEART = 16,
    D4 = 17,
    D10 = 18,
    FLUSH = 19,
    HAGALAZ = 20,
    JERA = 21,
    EHWAZ = 22,
    DAGAZ = 23,
    ANSUZ = 24,
    PERTHRO = 25,
    BERKANO = 26,
    ALGIZ = 27,
    D100 = 28,
    RAINBOW_POOP = 29,
    MISSING_PAGE = 30,
    MISSING_PAGE_2 = 31,
    SPIDER_BUTT = 32,
    SLEEP = 33,
    BOOK_OF_BELIAL = 34,
    BETRAYAL = 35,
    D8 = 36,
    D12 = 37,
    SUPER_BUM = 38,
    CLICKER = 39,
    MAMA_MEGA = 40,
    ETERNAL_HEART_EMPTY = 41,
    REVERSE_EMPRESS = 42,
    MORNING_SUN = 42,
    REVERSE_THE_SUN = 43,
    REVERSE_SUN = 43,
    SLEEP_NIGHTMARE = 44,
    DOGMA = 44,
    MEGA_MUSH = 45,
    ETERNAL_HEART_BLACK = 46,
}
---@enum DebugFlag
DebugFlag = {
    ENTITY_POSITIONS = 1 << 0,
    GRID = 1 << 1,
    INFINITE_HP = 1 << 2,
    HIGH_DAMAGE = 1 << 3,
    ROOM_INFO = 1 << 4,
    HITSPHERES = 1 << 5,
    DAMAGE_VALUES = 1 << 6,
    INFINITE_ITEM_CHARGES = 1 << 7,
    HIGH_LUCK = 1 << 8,
    QUICK_KILL = 1 << 9,
    GRID_INFO = 1 << 10,
    PLAYER_ITEM_INFO = 1 << 11,
    GRID_COLLISION_POINTS = 1 << 12,
    LUA_MEMORY_USAGE = 1 << 13,
}
---@enum CompletionType
CompletionType = {
    MOMS_HEART = 0,
    ISAAC = 1,
    SATAN = 2,
    BOSS_RUSH = 3,
    BLUE_BABY = 4,
    LAMB = 5,
    MEGA_SATAN = 6,
    ULTRA_GREED = 7,
    HUSH = 9,
    ULTRA_GREEDIER = 11,
    DELIRIUM = 12,
    MOTHER = 13,
    BEAST = 14,
}
---@enum PedestalType
PedestalType = {
    DEFAULT = 0,
    FORTUNE_TELLING_MACHINE = 1,
    BLOOD_DONATION_MACHINE = 2,
    SLOT_MACHINE = 3,
    GOLDEN_CHEST = 4,
    RED_CHEST = 5,
    STONE_CHEST = 6,
    SPIKED_CHEST = 7,
    ETERNAL_CHEST = 8,
    MOMS_DRESSING_TABLE = 9,
    CHEST = 10,
    MOMS_CHEST = 11,
    OLD_CHEST = 12,
    WOODEN_CHEST = 13,
    MEGA_CHEST = 14,
    CONFESSIONAL = 15,
    GOLDEN_CHEST_COIN_SLOT = 16,
    ETERNAL_CHEST_COIN_SLOT = 17,
    OLD_CHEST_COIN_SLOT = 18,
    MEGA_CHEST_COIN_SLOT = 19,
}
---@enum DipSubType
DipSubType = {
    NORMAL = 0,
    RED = 1,
    CORN = 2,
    GOLDEN = 3,
    RAINBOW = 4,
    BLACK = 5,
    HOLY = 6,
    PETRIFIED = 12,
    FLAMING = 13,
    POISON = 14,
    BROWNIE = 20,
}
---@enum PauseMenuStates
PauseMenuStates = {
    CLOSED = 0,
    OPEN = 1,
    OPTIONS = 2,
}
---@enum TaintedMarksGroup
TaintedMarksGroup = {
    BOTH = 0,
    SOULSTONE = 1,
    POLAROID_NEGATIVE = 2,
}
---@enum BagOfCraftingPickup
BagOfCraftingPickup = {
    BOC_NONE = 0,
    BOC_RED_HEART = 1,
    BOC_SOUL_HEART = 2,
    BOC_BLACK_HEART = 3,
    BOC_ETERNAL_HEART = 4,
    BOC_GOLD_HEART = 5,
    BOC_BONE_HEART = 6,
    BOC_ROTTEN_HEART = 7,
    BOC_PENNY = 8,
    BOC_NICKEL = 9,
    BOC_DIME = 10,
    BOC_LUCKY_PENNY = 11,
    BOC_KEY = 12,
    BOC_GOLD_KEY = 13,
    BOC_CHARGED_KEY = 14,
    BOC_BOMB = 15,
    BOC_GOLD_BOMB = 16,
    BOC_GIGA_BOMB = 17,
    BOC_MINI_BATTERY = 18,
    BOC_BATTERY = 19,
    BOC_MEGA_BATTERY = 20,
    BOC_CARD = 21,
    BOC_PILL = 22,
    BOC_RUNE = 23,
    BOC_DICE_SHARD = 24,
    BOC_CRACKED_KEY = 25,
    BOC_GOLD_PENNY = 26,
    BOC_GOLD_PILL = 27,
    BOC_GOLD_BATTERY = 28,
    BOC_POOP = 29,
}
---@enum WeaponModifier
WeaponModifier = {
    CHOCOLATE_MILK = 1 << 0,
    CURSED_EYE = 1 << 1,
    BRIMSTONE = 1 << 2,
    MONSTROS_LUNG = 1 << 3,
    LUDOVICO_TECHNIQUE = 1 << 4,
    ANTI_GRAVITY = 1 << 5,
    TRACTOR_BEAM = 1 << 6,
    SOY_MILK = 1 << 7,
    ALMOND_MILK = 1 << 7,
    NEPTUNUS = 1 << 8,
    AZAZELS_SNEEZE = 1 << 9,
    C_SECTION = 1 << 10,
    FAMILIAR = 1 << 30,
    BONE = 1 << 31,
}
---@enum ImGuiElement
ImGuiElement = {
    Window = 0,
    Menu = 1,
    MenuItem = 2,
    Popup = 3,
    CollapsingHeader = 4,
    TreeNode = 5,
    Separator = 6,
    SeparatorText = 7,
    Text = 8,
    TextWrapped = 9,
    BulletText = 10,
    SameLine = 11, -- used to render the next element in the same line
    Button = 12,
    SmallButton = 13,
    InputInt = 14,
    InputFloat = 15,
    DragInt = 16,
    DragFloat = 17,
    SliderInt = 18,
    SliderFloat = 19,
    ColorEdit = 20,
    TabBar = 21,
    Tab = 22,
    Checkbox = 23,
    RadioButton = 24,
    Combobox = 25,
    InputText = 26,
    InputTextWithHint = 27,
    InputTextMultiline = 28,
    InputController = 29,
    InputKeyboard = 30,
    PlotLines = 31,
    PlotHistogram = 32,
}
---@enum ImGuiCallback
ImGuiCallback = {
    Clicked = 0,
    Hovered = 1,
    Active = 2,
    Focused = 3,
    Visible = 4,
    Edited = 5,
    Activated = 6,
    Deactivated = 7,
    DeactivatedAfterEdit = 8,
    ToggledOpen = 9,
    Render = 10, -- Gets executed before an object gets rendered
}
---@enum ImGuiData
ImGuiData = {
    Label = 0, -- descriptive text of an element
    Value = 1, -- Used for single value Elements like Text- or Integer-Inputs, Checkboxes, or the currently selected Radiobutton
    ListValues = 2, -- Used for elements that use a table as their data source like RadioButtons, Comboboxes, Plots, etc.
    Min = 3, -- min value of a slider input
    Max = 4, -- max value of a slider input
    HintText = 5, -- hint text of a text input, or overlay texts used in plots or progressbars
    ColorValues = 6, -- Color input. 3 values = RGB, 4 values = RGBA
}
---@enum ImGuiColor
ImGuiColor = {
    Text = 0,
    TextDisabled = 1,
    WindowBg = 2, -- Background of normal windows
    ChildBg = 3, -- Background of child windows
    PopupBg = 4, -- Background of popups, menus, tooltips windows
    Border = 5,
    BorderShadow = 6,
    FrameBg = 7, -- Background of checkbox, radio button, plot, slider, text input
    FrameBgHovered = 8,
    FrameBgActive = 9,
    TitleBg = 10,
    TitleBgActive = 11,
    TitleBgCollapsed = 12,
    MenuBarBg = 13,
    ScrollbarBg = 14,
    ScrollbarGrab = 15,
    ScrollbarGrabHovered = 16,
    ScrollbarGrabActive = 17,
    CheckMark = 18,
    SliderGrab = 19,
    SliderGrabActive = 20,
    Button = 21,
    ButtonHovered = 22,
    ButtonActive = 23,
    Header = 24, -- Header* colors are used for CollapsingHeader, TreeNode, Selectable, MenuItem
    HeaderHovered = 25,
    HeaderActive = 26,
    Separator = 27,
    SeparatorHovered = 28,
    SeparatorActive = 29,
    ResizeGrip = 30, -- Resize grip in lower-right and lower-left corners of windows.
    ResizeGripHovered = 31,
    ResizeGripActive = 32,
    Tab = 33, -- TabItem in a TabBar
    TabHovered = 34,
    TabActive = 35,
    TabUnfocused = 36,
    TabUnfocusedActive = 37,
    PlotLines = 38,
    PlotLinesHovered = 39,
    PlotHistogram = 40,
    PlotHistogramHovered = 41,
    TableHeaderBg = 42, -- Table header background
    TableBorderStrong = 43, -- Table outer and header borders (prefer using Alpha=1.0 here)
    TableBorderLight = 44, -- Table inner borders (prefer using Alpha=1.0 here)
    TableRowBg = 45, -- Table row background (even rows)
    TableRowBgAlt = 46, -- Table row background (odd rows)
    TextSelectedBg = 47,
    DragDropTarget = 48, -- Rectangle highlighting a drop target
    NavHighlight = 49, -- Gamepad/keyboard: current highlighted item
    NavWindowingHighlight = 50, -- Highlight window when using CTRL+TAB
    NavWindowingDimBg = 51, -- Darken/colorize entire screen behind the CTRL+TAB window list, when active
    ModalWindowDimBg = 52, -- Darken/colorize entire screen behind a modal window, when one is active
}
---@enum PocketItemType
PocketItemType = {
    PILL = 0,
    CARD = 1,
    ACTIVE_ITEM = 2,
}
---@enum ItemAnim
ItemAnim = {
    CHARGE = 0,
    CHARGE_FULL = 1,
    SHOOT = 2,
    SHOOT_ALT = 3,
}
---@enum XMLNode
XMLNode = {
    MOD = 0,
    ENTITY = 1,
    PLAYER = 2,
    ITEM = 3,
    TRINKET = 4,
    PILL = 5,
    CARD = 6,
    MUSIC = 7,
    SOUND = 8,
    CHALLENGE = 9,
    ITEMPOOL = 10,
    NIGHTMARE = 11,
    COSTUME = 12,
    NULLCOSTUME = 13,
    WISP = 14,
    WISPCOLOR = 15,
    CURSE = 16,
    LOCUST = 17,
    LOCUSTCOLOR = 18,
    BOMBCOSTUME = 19,
    CRAFTINGRECIPE = 20,
    BOSSPOOL = 21,
    BOSSPORTRAIT = 22,
    CUTSCENE = 23,
    STAGE = 24,
    BACKDROP = 25,
    ACHIEVEMENT = 26,
    GIANTBOOK = 27,
    BOSSRUSHWAVE = 28,
    PLAYERFORM = 29,
    NULLITEM = 30,
    BOSSCOLOR = 31,
}
---@enum AutocompleteType
AutocompleteType = {
    NONE = 0,
    ENTITY = 1,
    GOTO = 2,
    STAGE = 3,
    GRID = 4,
    DEBUG_FLAG = 5,
    ITEM = 6,
    CHALLENGE = 7,
    COMBO = 8,
    CUTSCENE = 9,
    MACRO = 10,
    SFX = 11,
    CURSE = 12,
    METRO = 13,
    DELIRIOUS = 14,
    PLAYER = 15,
    ACHIEVEMENT = 16,
    CUSTOM = 17,
}
---@enum AnimRenderFlags
AnimRenderFlags = {
    GLITCH = 1 << 1, -- Rapidly distorts the spritesheet position. Likely used for glitch items generated by CORRUPTED DATA.
    COLOROFFSET_CHAMPION = 1 << 4, -- Used by champion NPCs. If not applied to a champion NPC, it will not render.
    STATIC = 1 << 5, -- Used by Dogma (boss, collectible, related effects).
    IGNORE_GAME_TIME = 1 << 6, -- If set, animated effects (static, golden) will continue animating even if the game is paused.
    GOLDEN = 1 << 7, -- Used by golden trinkets.
    ENABLE_LAYER_LIGHTING = 1 << 10, -- Layer names starting with * will become fullbright.
    ENABLE_NULL_LAYER_LIGHTING = 1 << 11, -- Null layer names starting with * will emit light.
}
---@enum DialogButtons
DialogButtons = {
    OK = 0,
    OK_CANCEL = 1,
    ABORT_RETRY_IGNORE = 2,
    YES_NO_CANCEL = 3,
    YES_NO = 4,
    RETRY_CANCEL = 5,
    CANCEL_TRY_CONTINUE = 6,
    HELP = 0x4000,
}
---@enum DialogIcons
DialogIcons = {
    ERROR = 0x10,
    HAND = 0x10,
    STOP = 0x10,
    QUESTION = 0x20,
    EXCLAMATION = 0x30,
    WARNING = 0x30,
    ASTERISK = 0x40,
    INFORMATION = 0x40,
}
---@enum DialogReturn
DialogReturn = {
    OK = 1,
    CANCEL = 2,
    ABORT = 3,
    RETRY = 4,
    IGNORE = 5,
    YES = 6,
    NO = 7,
    TRY_AGAIN = 10,
    CONTINUE = 11,
}
---@enum ProceduralEffectConditionType
ProceduralEffectConditionType = {
    ACTIVE = 0,
    TEAR_FIRE = 1,
    ENEMY_HIT = 2,
    ENEMY_KILL = 3,
    DAMAGE_TAKEN = 4,
    ROOM_CLEAR = 5,
    ENTITY_SPAWN = 6,
    PICKUP_COLLECTED = 7,
    CHAIN = 8, -- trigger if previous `ProceduralEffect` is triggered (or dropped by rate).
}
---@enum ProceduralEffectActionType
ProceduralEffectActionType = {
    USE_ACTIVE_ITEM = 0,
    ADD_TEMPRORY_EFFECT = 1,
    CONVERT_ENTITIES = 2,
    AREA_DAMAGE = 3,
    SPAWN_ENTITY = 4,
    FART = 5,
}
---@enum EntityTag
EntityTag = {
    FLY = 1 << 0,
    SPIDER = 1 << 1,
    GHOST = 1 << 3,
    NOREROLL = 1 << 4,
    CANSACRIFICE = 1 << 5,
    EXPLOSIVE_SOUL = 1 << 6,
    HOMING_SOUL = 1 << 7,
    BRIMSTONE_SOUL = 1 << 8,
    NODELIRIUM = 1 << 9,
}
---@enum GibFlag
GibFlag = {
    BLOOD = 1 << 0,
    BONE = 1 << 1,
    GUT = 1 << 2,
    EYE = 1 << 3,
    LARGE = 1 << 4,
    POOP = 1 << 5,
    WORM = 1 << 6,
    ROCK = 1 << 7,
    ROCK_SMALL = 1 << 8,
    SOUND_BABY = 1 << 9,
    SOUND_BONE = 1 << 10,
    CHAIN = 1 << 11,
    DUST = 1 << 12,
    HUGE = 1 << 13,
}
---@enum ImGuiNotificationType
ImGuiNotificationType = {
    INFO = 0,
    SUCCESS = 1,
    WARNING = 2,
    ERROR = 3,
}
---@enum PurityState
PurityState = {
    RED = 0,
    BLUE = 1,
    YELLOW = 2,
    ORANGE = 3,
}
---@enum BombCostumeLayer
BombCostumeLayer = {
    BACK = 0,
    BODY2 = 1,
    FRONT = 2,
    FRONT2 = 3,
    OVERLAY = 4,
}
---@enum DeliriumCallbacks
DeliriumCallbacks = {
    TRANSFORMATION = 1, -- This callback is fired immediately before the game transforms Delirium into a boss (this also includes when Delirium returns to its normal form).
    POST_TRANSFORMATION = 2, -- This callback is fired immediately after the game transform Delirium into a boss (this also includes when Delirium returns to its normal form or transforms into the same boss).
}
---@enum SpecialQuest
SpecialQuest = {
    DISABLED = -1,
    DEFAULT = 0,
    MIRROR = 1,
    MINESHAFT = 2,
}
---@enum BlendFactor
BlendFactor = {
    ZERO = 0,
    ONE = 1,
    SRC_COLOR = 2,
    ONE_MINUS_SRC_COLOR = 3,
    DST_COLOR = 4,
    ONE_MINUS_DST_COLOR = 5,
    SRC_ALPHA = 6,
    ONE_MINUS_SRC_ALPHA = 7,
    DST_ALPHA = 8,
    ONE_MINUS_DST_ALPHA = 9,
    CONSTANT_COLOR = 10, -- Currently nonfunctional.
    ONE_MINUS_CONSTANT_COLOR = 11, -- Currently nonfunctional.
    CONSTANT_ALPHA = 12, -- Currently nonfunctional.
    ONE_MINUS_CONSTANT_ALPHA = 13, -- Currently nonfunctional.
    SRC_ALPHA_SATURATE = 14,
}
---@enum BlendType
BlendType = {
    CONSTANT = 0, -- `{1, 0, 1, 0}`. Seems to be used to ignore any kind of source/destination modifiers.
    NORMAL = 1, -- `{1, 7, 1, 7}`
    ADDITIVE = 2, -- `{1, 1, 1, 1}`
    MULTIPLICATIVE = 3, -- `{0, 2, 0, 2}`
    OVERLAY = 4, -- `{4, 7, 4, 7}`
}
---@enum AddHealthType
AddHealthType = {
    NONE = 0,
    RED = 1 << 0,
    MAX = 1 << 1,
    SOUL = 1 << 2,
    BLACK = 1 << 3,
    ETERNAL = 1 << 4,
    GOLDEN = 1 << 5,
    BONE = 1 << 6,
    ROTTEN = 1 << 7,
    BROKEN = 1 << 8,
}
---@enum DwmWindowAttributes
DwmWindowAttributes = {
    DWMWA_NCRENDERING_ENABLED = 1,
    DWMWA_NCRENDERING_POLICY = 2,
    DWMWA_TRANSITIONS_FORCEDISABLED = 3,
    DWMWA_ALLOW_NCPAINT = 4,
    DWMWA_CAPTION_BUTTON_BOUNDS = 5,
    DWMWA_NONCLIENT_RTL_LAYOUT = 6,
    DWMWA_FORCE_ICONIC_REPRESENTATION = 7,
    DWMWA_FLIP3D_POLICY = 8,
    DWMWA_EXTENDED_FRAME_BOUNDS = 9,
    DWMWA_HAS_ICONIC_BITMAP = 10,
    DWMWA_DISALLOW_PEEK = 11,
    DWMWA_EXCLUDED_FROM_PEEK = 12,
    DWMWA_CLOAK = 13, -- Blocked
    DWMWA_CLOAKED = 14, -- Blocked
    DWMWA_FREEZE_REPRESENTATION = 15,
    DWMWA_PASSIVE_UPDATE_MODE = 16,
    DWMWA_USE_HOSTBACKDROPBRUSH = 17,
    DWMWA_USE_IMMERSIVE_DARK_MODE = 20,
    DWMWA_WINDOW_CORNER_PREFERENCE = 33,
    DWMWA_BORDER_COLOR = 34,
    DWMWA_CAPTION_COLOR = 35,
    DWMWA_TEXT_COLOR = 36,
    DWMWA_VISIBLE_FRAME_BORDER_THICKNESS = 37,
    DWMWA_SYSTEMBACKDROP_TYPE = 38,
    DWMWA_LAST = 39,
}
---@enum ButtonActionBitwise
ButtonActionBitwise = {
    ACTION_LEFT = 1<<0,
    ACTION_RIGHT = 1<<1,
    ACTION_UP = 1<<2,
    ACTION_DOWN = 1<<3,
    ACTION_SHOOTLEFT = 1<<4,
    ACTION_SHOOTRIGHT = 1<<5,
    ACTION_SHOOTUP = 1<<6,
    ACTION_SHOOTDOWN = 1<<7,
    ACTION_BOMB = 1<<8,
    ACTION_ITEM = 1<<9,
    ACTION_PILLCARD = 1<<10,
    ACTION_DROP = 1<<11,
    ACTION_PAUSE = 1<<12,
    ACTION_MAP = 1<<13,
    ACTION_MENUCONFIRM = 1<<14,
    ACTION_MENUBACK = 1<<15,
    ACTION_RESTART = 1<<16,
    ACTION_FULLSCREEN = 1<<17,
    ACTION_MUTE = 1<<18,
    ACTION_JOINMULTIPLAYER = 1<<19,
    ACTION_MENULEFT = 1<<20,
    ACTION_MENURIGHT = 1<<21,
    ACTION_MENUUP = 1<<22,
    ACTION_MENUDOWN = 1<<23,
    ACTION_MENULT = 1<<24,
    ACTION_MENURT = 1<<25,
    ACTION_MENUTAB = 1<<26,
    ACTION_CONSOLE = 1<<28,
}
---@enum MinimapState
MinimapState = {
    NORMAL = 0,
    EXPANDED_OPAQUE = 1,
    EXPANDED = 2,
}
---@enum ConceptionFamiliarFlag
ConceptionFamiliarFlag = {
    LEECH = 1<<0,
    DARK_BUM = 1<<1,
    DEMON_BABY = 1<<2,
    INCUBUS = 1<<3,
    LIL_BRIMSTONE = 1<<4,
    SUCCUBUS = 1<<5,
    GUARDIAN_ANGEL = 1<<6,
    HOLY_WATER = 1<<7,
    RELIC = 1<<8,
    SWORN_PROTECTOR = 1<<9,
    SERAPHIM = 1<<10,
    LIL_ABADDON = 1<<11,
    TWISTED_PAIR = 1<<12,
}
---@enum GetCollectibleFlag
GetCollectibleFlag = {
    BAN_ACTIVES = 1<<0, -- Bans items with Type: `ITEM_ACTIVE`.
    IGNORE_MODIFIERS = 1<<1, -- If set the game does not attempt to morph the collectible into either `Magic Skin` or `Rosary`. Does not prevent a morph into `Bible`.
    BAN_PASSIVES = 1<<2, -- Bans items with Type: `ITEM_PASSIVE`
}
