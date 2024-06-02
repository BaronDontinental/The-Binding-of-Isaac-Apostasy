local Lil_Sloth = {}
local game = Game()

mod.COLLECTIBLE_LIL_SLOTH = Isaac.GetItemIdByName("Lil' Sloth")
CollectibleType.COLLECTIBLE_LIL_SLOTH = Isaac.GetItemIdByName("Lil' Sloth")
FamiliarVariant.LIL_SLOTH = Isaac.GetEntityVariantByName("LIL_SLOTH")

local SLOTH_COOLDOWN = 40
local SlothCount = 0
function Lil_Sloth:postUpdate()

   --[[ local function SpawnFollower(Type, player)
        return Isaac.Spawn(EntityType.ENTITY_FAMILIAR, Type, 0, player.Position, Vector(0,0), player):ToFamiliar()
    end
    local function RealignFamiliars()
        local Caboose = nil
        for _, entity in pairs(Isaac.GetRoomEntities()) do
            if entity.Type == EntityType.ENTITY_FAMILIAR and entity.Child == nil then
                if Caboose == nil then
                    Caboose = entity
                else
                    if Caboose.FrameCount < entity.FrameCount then
                        Caboose.Parent = entity
                        entity.Child = Caboose
                    else
                        Caboose.Child = entity
                        entity.Parent = Caboose
                    end
                end
            end
        end
    end 
    -- Turns out that stuff up top isnt needed anymore ig...
    function Lil_Sloth:FamInit(Sloth)
        local data = Sloth:GetData()
        if data.Charge == nil then data.Charge = 0 end
        if data.Cooldown == nil then data.Cooldown = 0 end
        Sloth.IsFollower = true
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Lil_Sloth.FamInit, FamiliarVariant.LIL_SLOTH)

    function Lil_Sloth:FamUpdate(Sloth)
        local player = Isaac.GetPlayer(0)
        local data = Sloth:GetData()
        if data.Charge == nil then data.Charge = 0 end
        if data.Cooldown == nil then data.Cooldown = 0 end
        local FireDir = player:GetFireDirection()
        local MoveDir = player:GetMovementDirection()
        if FireDir == Direction.NO_DIRECTION or data.Cooldown > 0 then

        end
        Sloth:FollowParent()
    end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lil_Sloth.FamUpdate, FamiliarVariant.LIL_SLOTH)


    function Lil_Sloth:OnCache(player, cacheFlag)
        if cacheFlag == CacheFlag.CACHE_FAMILIARS then
            for _, entity in pairs(Isaac.GetRoomEntities()) do
                if entity.Type == EntityType.ENTITY_FAMILIAR and entity.Variant == FamiliarVariant.LIL_SLOTH then
                    SlothCount = SlothCount + 1
                end
            end
            while player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LIL_SLOTH) > SlothCount do
                SpawnFollower(FamiliarVariant.LIL_SLOTH, player)
                SlothCount = SlothCount + 1
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Lil_Sloth.OnCache) ]]


end

return Lil_Sloth