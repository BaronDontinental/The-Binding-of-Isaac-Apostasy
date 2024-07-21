local Rotgut = {}
local game = Game()
local sound = SFXManager()

mod.COLLECTIBLE_ROTGUT = Isaac.GetItemIdByName("Rotgut")
CollectibleType.COLLECTIBLE_ROTGUT = Isaac.GetItemIdByName("Rotgut")
SoundEffect.SOUND_SPLURGE = Isaac.GetSoundIdByName("AlexBarf")
local Shot = nil
local TEAR_SPEED = 8
local direction = Vector(0,1)

function Rotgut:postUpdate()
    local RotFlags = {
        MIN_TIME = 300,
        ROT_CHANCE = 5,
        SCALE_1 = 0.9,
        SCALE_2 = 1.2,
        FLY_1 = 18,
        FLY_2 = 1.25,
        SPEED_1 = 5,
        AMT_TEAR = 14,
        TEARFLAG = TearFlags.TEAR_POISON,
        ROT_VARIANT = TearVariant.BOOGER
    }

    function Rotgut.onPassive(player)

        --[[if game:GetFrameCount() == 1 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_ROTGUT, Vector(320,300), Vector(0,0), nil)
        end ]]
        local player = Isaac.GetPlayer(0)
        local copyCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ROTGUT)
        player:EvaluateItems()

        local firedirection = player:GetFireDirection()
        if firedirection == Direction.LEFT then
            direction = Vector(-1, 0)
        elseif firedirection == Direction.RIGHT then
            direction = Vector(1, 0)
        elseif firedirection == Direction.DOWN then
            direction = Vector(0,1)
        elseif firedirection == Direction.UP then
            direction = Vector(0, -1)
        end

        local velocity = direction * TEAR_SPEED + player:GetTearMovementInheritance(direction)
       

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
                                    Tear:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear.TearFlags = Tear.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear:SetSize(Tear.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear.SpriteScale = Tear.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear.Height = Tear.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1)
                                    Tear.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)
                                    sound:Play(SoundEffect.SOUND_SPLURGE, 1, 0, false, 1)
                                    
                                    local Tear2 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear2:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear2.TearFlags = Tear2.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear2:SetSize(Tear2.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear2.SpriteScale = Tear2.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear2.Height = Tear2.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear2.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear2.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear3 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear3:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear3.TearFlags = Tear3.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear3:SetSize(Tear3.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear3.SpriteScale = Tear3.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear3.Height = Tear3.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear3.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear3.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear4 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear4:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear4.TearFlags = Tear4.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear4:SetSize(Tear4.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear4.SpriteScale = Tear4.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear4.Height = Tear4.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear4.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear4.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear5 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear5:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear5.TearFlags = Tear5.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear5:SetSize(Tear5.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear5.SpriteScale = Tear5.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear5.Height = Tear5.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear5.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear5.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear6 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear6:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear6.TearFlags = Tear6.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear6:SetSize(Tear6.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear6.SpriteScale = Tear6.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear6.Height = Tear6.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear6.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear6.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear7 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear7:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear7.TearFlags = Tear7.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear7:SetSize(Tear7.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear7.SpriteScale = Tear7.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear7.Height = Tear7.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear7.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear7.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear8 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear8:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear8.TearFlags = Tear8.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear8:SetSize(Tear8.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear8.SpriteScale = Tear8.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear8.Height = Tear8.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear8.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear8.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear9 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear9:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear9.TearFlags = Tear9.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear9:SetSize(Tear9.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear9.SpriteScale = Tear9.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear9.Height = Tear9.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear9.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear9.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear10 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear10:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear10.TearFlags = Tear10.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear10:SetSize(Tear10.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear10.SpriteScale = Tear10.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear10.Height = Tear10.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear10.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear10.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear11 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear11:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear11.TearFlags = Tear11.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear11:SetSize(Tear11.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear11.SpriteScale = Tear11.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear11.Height = Tear11.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear11.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear11.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear12 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear12:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear12.TearFlags = Tear12.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear12:SetSize(Tear12.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear12.SpriteScale = Tear12.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear12.Height = Tear12.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear12.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear12.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear13 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear13:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear13.TearFlags = Tear13.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear13:SetSize(Tear13.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear13.SpriteScale = Tear13.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear13.Height = Tear13.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear13.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear13.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)

                                    local Tear14 = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, player.Position, velocity * (math.random(50, 150) / 100), player):ToTear()
                                    Tear14:SetColor(Color(0.79, 0.89, 0.27, 1.0, 0, 0, 0), 100, 100, false, false)
                                    Tear14.TearFlags = Tear14.TearFlags | RotFlags.TEARFLAG 
                                    TearData.RotSize = math.random(25)
                                    Tear14:SetSize(Tear14.Size * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100)), Vector(1,1), 8)
                                    Tear14.SpriteScale = Tear14.SpriteScale * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear14.Height = Tear14.Height * (RotFlags.SCALE_1 + RotFlags.SCALE_2 * (TearData.RotSize / 100))
                                    Tear14.FallingSpeed = player.TearFallingSpeed - (RotFlags.FLY_1 + math.random(-15,10))
                                    Tear14.FallingAcceleration = player.TearFallingAcceleration + (RotFlags.FLY_2 + math.random(-50, 200) / 100)


                                
                            end
                        else
                            TearData.RotType = 0
                        end
                    end
                end
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Rotgut.onPassive)

end

return Rotgut