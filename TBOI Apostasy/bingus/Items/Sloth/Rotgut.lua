local Rotgut = {}
local game = Game()
local sound = SFXManager()

mod.COLLECTIBLE_ROTGUT = Isaac.GetItemIdByName("Rotgut")
CollectibleType.COLLECTIBLE_ROTGUT = Isaac.GetItemIdByName("Rotgut")
SoundEffect.SOUND_SPLURGE = Isaac.GetSoundIdByName("AlexBarf")
local Shot = nil

function Rotgut:postUpdate()
    local RotFlags = {
        MIN_TIME = 300,
        ROT_CHANCE = 5,
        SCALE_1 = 0.9,
        SCALE_2 = 1.2,
        FLY_1 = 20,
        FLY_2 = 1.5,
        SPEED_1 = 5,
        AMT_TEAR = 14,
        ROT_TYPE = WeaponType.WEAPON_MONSTROS_LUNGS,
        TEARFLAG = TearFlags.TEAR_POISON,
        ROT_VARIANT = TearVariant.BOOGER
    }

    function Rotgut.onPassive(player)

        --[[if game:GetFrameCount() == 1 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_ROTGUT, Vector(320,300), Vector(0,0), nil)
        end ]]
        local player = Isaac.GetPlayer(0)
        local copyCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ROTGUT)
        local Weapon = Isaac.GetPlayer(0):GetWeapon(1)
        player:EvaluateItems()
        player:AddCacheFlags(CacheFlag.CACHE_WEAPON)
        -- player.FireDelay = player.MaxFireDelay (stops firing)

        if copyCount > 0 then
            for _, entity in pairs(Isaac.GetRoomEntities()) do
                if entity.Type == EntityType.ENTITY_TEAR then
                    local TearData = entity:GetData()
                    local Tear = entity:ToTear()
                    if TearData.RotType == nil then
                        local roll = math.random(100)
                        if roll <= RotFlags.ROT_CHANCE then
                            TearData.RotType = math.random(1)
                            if TearData.RotType == 1 then
                                    player:AddCacheFlags(CacheFlag.CACHE_WEAPON) 
                                    Tear:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear.TearFlags = Tear.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(100)
                                    Tear:SetSize(Tear.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear.SpriteScale = Tear.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear.Height = Tear.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1)
                                    Tear.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(1, 10) / 10)
                                    sound:Play(SoundEffect.SOUND_SPLURGE, 1, 0, false, 1)
                                    Shot = true
                            end
                        else
                            player:AddCacheFlags(CacheFlag.CACHE_WEAPON)
                            TearData.RotType = 0
                            Shot = false
                        end
                    end
                end
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Rotgut.onPassive)

    function Rotgut.OnCache(player, cacheFlag)
        if Shot == true then
            if (cacheFlag == CacheFlag.CACHE_WEAPON) then
                player.EnableWeaponType(player, WeaponType.WEAPON_MONSTROS_LUNGS, true)
                player.EnableWeaponType(player, WeaponType.WEAPON_TEARS, false)
            end
        else
            if (cacheFlag == CacheFlag.CACHE_WEAPON) then
                player.EnableWeaponType(player, WeaponType.WEAPON_MONSTROS_LUNGS, false)
                player.EnableWeaponType(player, WeaponType.WEAPON_TEARS, true)
            end
        end
    end
  mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Rotgut.OnCache)

end

return Rotgut