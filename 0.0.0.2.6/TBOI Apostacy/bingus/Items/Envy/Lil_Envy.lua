local Lil_Envy = {}
local game = Game()

mod.COLLECTIBLE_LIL_ENVY = Isaac.GetItemIdByName("Lil' Envy")
CollectibleType.COLLECTIBLE_LIL_ENVY = Isaac.GetItemIdByName("Lil' Envy")
FamiliarVariant.LIL_ENVY = Isaac.GetEntityVariantByName("Lil' Envy")

function Lil_Envy:postUpdate()
    local function SpawnFollower(Type, player)  --SpawnFollower--
        return Isaac.Spawn(EntityType.ENTITY_FAMILIAR, Type, 0, player.Position, Vector(0,0), player):ToFamiliar()
    end

    local function RealignFamiliars()  --Make Familiar Follow others--
        local Caboose = nil
        for _, entity in pairs(Isaac.GetRoomEntities()) do
            if entity.Type == EntityType.ENTITY_FAMILIAR
            and entity.Child == nil then
                if Caboose == nil then
                    Caboose =  entity
                else
                    if Caboose.FrameCount < entity.FrameCount then
                        Caboose.Parent = entity
                        entity.Child = Caboose
                    end
                end
            end
        end
    end

    function Lil_Envy:GetLilEnvy(Envy)
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Lil_Envy.GetLilEnvy, FamiliarVariant.LIL_ENVY)

    local Lil_Envy_COOLDOWN = 40
    function Lil_Envy:UpdateLilEnvy(Envy)
        local player = Isaac.GetPlayer(0)
        local data = Envy:GetData()
        if data.Charge == nil then data.charge = 0 end
        if data.Cooldown == nil then data.Cooldown = 0 end
        local sprite = Envy:GetSprite()
        local FireDir = player:GetFireDirection()
        local MoveDir = player:GetMovementDirection()
        if FireDir == Direction.NO_DIRECTION or data.Cooldown > 0 then
            Envy:FollowParent()
        end
    end
    mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lil_Envy.UpdateLilEnvy, FamiliarVariant.LIL_ENVY)

    function Lil_Envy:OnCache(player, cacheFlag)
        if cacheFlag == CacheFlag.CACHE_FAMILIARS then
            local Lil_EnvyCount = 0
            for _, entity in pairs(Isaac.GetRoomEntities()) do 
                if entity.Type == EntityType.ENTITY_FAMILIAR
                and entity.Variant == FamiliarVariant.LIL_ENVY
                then
                    Lil_EnvyCount = Lil_EnvyCount + 1
                end
            end
            while player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LIL_ENVY) > Lil_EnvyCount do
                SpawnFollower(FamiliarVariant.LIL_ENVY, player)
                RealignFamiliars()
                Lil_EnvyCount = Lil_EnvyCount + 1
            end
            RealignFamiliars()
        end
        print("This is not working D: ")
    end
    mod.AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Lil_Envy.OnCache)

end

return Lil_Envy