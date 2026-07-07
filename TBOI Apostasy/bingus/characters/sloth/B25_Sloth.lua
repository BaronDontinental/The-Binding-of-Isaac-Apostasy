local B25_Sloth = {}
local Game = Game()
local level = Game:GetLevel()
local room = Game:GetRoom()
local SlothGuy = Isaac.GetPlayerTypeByName("B25_Sloth", false)
local sfxManager = SFXManager()

--set this to true if soul hearts and black hearts should be allowed on him in the future
local ALLOWSOULHEARTS = false

local B25_SlothStats = {
    DAMAGE = 2.857,
    SPEED = -0.2,
    SHOTSPEED = 0,
    MAXFIREDELAY = 20,      --quite low fire rate while dry
    CREEPFIREDELAY = 10,    --regular sloth fire rate while standing in his creep
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags.TEAR_EXPLOSIVE,
    Flying = false,
    LUCK = 1,
    TEARCOLOR = Color(0, 1.0, 0, 1.0, 0, 0, 0),
    SCALE_1 = 0.4,
    SCALE_2 = 0.4,
    FLY_1 = 20,
    FLY_2 = 1.5,
    CREEP_MIN_TIME = 60,    --fastest creep spawn, in update frames (2 seconds)
    CREEP_MAX_TIME = 150,   --slowest creep spawn, in update frames (5 seconds)
    CREEP_SCALE = 2,        --multiplier on the standard creep size
    CREEP_RADIUS = 26,      --standing range of one pool before the scale is applied
    CREEP_TIMEOUT = 90,     --how long a pool sticks around, in update frames
    CREEPCOLOR = Color(0.7, 0.9, 0.2, 1.0, 0, 0, 0)    --puke green
}

local clearcount = 0
local roomcount = 0
local creeptimer = 0
local inCreep = false
local halfdamage = 0
local flywindow = -100

function B25_Sloth:postUpdate()
    function B25_Sloth:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "B25_Sloth") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage * B25_SlothStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + B25_SlothStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + B25_SlothStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              if inCreep then
                player.MaxFireDelay = player.MaxFireDelay + B25_SlothStats.CREEPFIREDELAY
              else
                player.MaxFireDelay = player.MaxFireDelay + B25_SlothStats.MAXFIREDELAY
              end
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - B25_SlothStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + B25_SlothStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + B25_SlothStats.LUCK
            end
            if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = B25_SlothStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | B25_SlothStats.TEARFLAG
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B25_Sloth.OnCache)
    function B25_Sloth:OnUpdate()
        local player = Isaac.GetPlayer(0)

        if(Game:GetFrameCount() == 1 and player:GetName() == "B25_Sloth") then
            player:AddCard(math.random(1, 54))
            halfdamage = 0
            inCreep = false
            flywindow = -100
            creeptimer = math.random(B25_SlothStats.CREEP_MIN_TIME, B25_SlothStats.CREEP_MAX_TIME)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B25_Sloth.OnUpdate)

    function B25_Sloth:PEffect(player)
      if player:GetPlayerType() ~= SlothGuy then
        return
      end
      local displace = player:GetTearDisplacement()
      local direction =  player:GetFireDirection()
        if displace == 1 and direction ~= 1 then
          player.TearsOffset = Vector(-5,-10)
        elseif displace == -1 and direction ~= 1 then
          player.TearsOffset = Vector(5,-10)
        elseif displace == 1 and direction == 1 then
          player.TearsOffset = Vector(5,10)
        elseif displace == -1 and direction == 1 then
          player.TearsOffset = Vector(-5,10)
        end
        if level:GetStage() == LevelStage.STAGE1_2 and (level:GetStageType() == StageType.STAGETYPE_REPENTANCE_B or level:GetStageType() == StageType.STAGETYPE_REPENTANCE) then
          roomcount = level:GetRoomCount() - 5
        elseif level:GetStage() == LevelStage.STAGE7 then
          roomcount = 0
        elseif level:GetStage() == LevelStage.STAGE6 then
          roomcount = level:GetRoomCount() - 4
        else
            roomcount = level:GetRoomCount() - 3
        end
          for i = 7,0,-1 do
            local door = room:GetDoor(i)
            if door ~= nil then
              if door:IsRoomType(RoomType.ROOM_BOSS) then
                if roomcount >= clearcount then
                  door:SetLocked(true)
                  door:Close(true)
                  door:Bar()
                  door:Update()
                else
                end
              end
              if door:IsRoomType(RoomType.ROOM_CHALLENGE) and room ~= RoomType.ROOM_CHALLENGE then
                door:TryUnlock(player, true)
                sfxManager:Stop(SoundEffect.SOUND_UNLOCK00)
                door:Open()
                door:Update()
              end
            end
          end
        for _, entity in pairs(Isaac.GetRoomEntities()) do
          local data = entity:GetData()
          if entity.Type == EntityType.ENTITY_TEAR then
            local Tear = entity:ToTear()
            local TearData = entity:GetData()
            if entity.Variant == TearVariant.BLUE and not TearData.Cring then
              TearData.Cring = true
---@diagnostic disable-next-line: need-check-nil
              --Tear:ChangeVariant(TearVariant.BLOOD)
              TearData.RotSize = 50
---@diagnostic disable-next-line: need-check-nil
              Tear.Height = Tear.Height * (B25_SlothStats.SCALE_1 + B25_SlothStats.SCALE_2 * (TearData.RotSize / 100))
              Tear.FallingSpeed = player.TearFallingSpeed - (B25_SlothStats.FLY_1)
              Tear.FallingAcceleration = player.TearFallingAcceleration + (B25_SlothStats.FLY_2)
          elseif entity.Variant == (TearVariant.BLOOD or TearVariant.EGG or TearVariant.EXPLOSIVO or TearVariant.TOOTH
            or TearVariant.FIST or TearVariant.METALLIC or TearVariant.FIRE_MIND or TearVariant.DARK_MATTER
            or TearVariant.MYSTERIOUS  or TearVariant.GODS_FLESH or TearVariant.GODS_FLESH_BLOOD or TearVariant.MULTIDIMENSIONAL
            or TearVariant.GLAUCOMA or TearVariant.GLAUCOMA_BLOOD or TearVariant.BLACK_TOOTH or TearVariant.SPORE) and not TearData.Cring then
              TearData.Cring = true
---@diagnostic disable-next-line: need-check-nil
              TearData.RotSize = 50
---@diagnostic disable-next-line: need-check-nil
              Tear.Height = Tear.Height * (B25_SlothStats.SCALE_1 + B25_SlothStats.SCALE_2 * (TearData.RotSize / 100))
              Tear.FallingSpeed = player.TearFallingSpeed - (B25_SlothStats.FLY_1)
              Tear.FallingAcceleration = player.TearFallingAcceleration + (B25_SlothStats.FLY_2)
            end
          end
        end
        --he drools out a puddle of creep every so often
        creeptimer = creeptimer - 1
        if creeptimer <= 0 then
          local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, player.Position, Vector(0,0), player):ToEffect()
---@diagnostic disable-next-line: need-check-nil
          creep.Scale = B25_SlothStats.CREEP_SCALE
---@diagnostic disable-next-line: need-check-nil
          creep.Timeout = B25_SlothStats.CREEP_TIMEOUT
---@diagnostic disable-next-line: need-check-nil
          creep.Color = B25_SlothStats.CREEPCOLOR
---@diagnostic disable-next-line: need-check-nil
          creep:Update()
          creeptimer = math.random(B25_SlothStats.CREEP_MIN_TIME, B25_SlothStats.CREEP_MAX_TIME)
        end
        --standing in a pool wakes him up to the regular sloth fire rate
        local standing = false
        for _, creep in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, -1, false, false)) do
          if (creep.Position - player.Position):Length() <= B25_SlothStats.CREEP_RADIUS * B25_SlothStats.CREEP_SCALE then
            standing = true
          end
        end
        if standing ~= inCreep then
          inCreep = standing
          player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
          player:EvaluateItems()
        end
        --his whole health pool is rotten, red healing of any kind gets rebuilt as rotten hearts
        local rotten = player:GetRottenHearts()
        local red = player:GetHearts() - rotten
        if red > 0 then
          player:AddHearts(-player:GetHearts())
          player:AddRottenHearts(rotten * 2 + math.ceil(red / 2) * 2)
        end
        if not ALLOWSOULHEARTS and player:GetSoulHearts() > 0 then
          player:AddSoulHearts(-player:GetSoulHearts())
        end
      end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B25_Sloth.PEffect)

    --soul and black hearts still spawn but pass through him, he can not pick them up
    function B25_Sloth:HeartBlock(pickup, collider, low)
      local player = collider:ToPlayer()
      if not player or player:GetPlayerType() ~= SlothGuy then
        return
      end
      if not ALLOWSOULHEARTS and (pickup.SubType == HeartSubType.HEART_SOUL
      or pickup.SubType == HeartSubType.HEART_HALF_SOUL
      or pickup.SubType == HeartSubType.HEART_BLACK) then
        return false
      end
    end
    mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, B25_Sloth.HeartBlock, PickupVariant.PICKUP_HEART)

    function B25_Sloth:NewRoom()
        if room:IsFirstVisit() and room:IsClear() and not (level:GetCurrentRoom() == (RoomType.ROOM_ANGEL or RoomType.ROOM_ERROR or RoomType.ROOM_DUNGEON or RoomType.ROOM_DEVIL or RoomType.ROOM_BLACK_MARKET or RoomType.ROOM_BLUE or RoomType.ROOM_ULTRASECRET)) then
          clearcount = clearcount + 1
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, B25_Sloth.NewRoom)

    function B25_Sloth:RoomClear(rng, spawn)
      clearcount = clearcount + 1
    end
    mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, B25_Sloth.RoomClear)

    function B25_Sloth:NewLevel()
      clearcount = 1
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, B25_Sloth.NewLevel)

    function B25_Sloth:TakeDmg(entity, amount, DamageFlags, source, countdown)
      local player = entity:ToPlayer()
      if player:GetPlayerType() ~= SlothGuy then
        return
      end
    --birthright lets him pay in halves, two half hits cost one rotten heart instead of two
      if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and amount == 1 then
        halfdamage = halfdamage + 1
        if halfdamage % 2 == 1 then
          player:SetMinDamageCooldown(60)
          sfxManager:Play(SoundEffect.SOUND_ISAAC_HURT_GRUNT, 1, 0, false, 1)
          return false
        end
      end
    --any hit that lands pops a rotten heart, mark the window so its blue flies become chargers
      flywindow = Game:GetFrameCount() + 2
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, B25_Sloth.TakeDmg, EntityType.ENTITY_PLAYER)

    function B25_Sloth:FlyInit(familiar)
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= SlothGuy then
        return
      end
      if Game:GetFrameCount() > flywindow then
        return
      end
    --rotten hearts pay out the black chargers My Shadow makes instead of blue flies
      familiar:Remove()
      local charger = Isaac.Spawn(EntityType.ENTITY_CHARGER, 0, 1, familiar.Position, Vector(0,0), player)
      charger:AddCharmed(EntityRef(player), -1)
    end
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, B25_Sloth.FlyInit, FamiliarVariant.BLUE_FLY)

end

return B25_Sloth