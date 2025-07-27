local L19_Sloth = {}
local Game = Game()
local level = Game:GetLevel()
local room = Game:GetRoom()
local SlothGuy = Isaac.GetPlayerTypeByName("L19_Sloth", false)
local sprite = Sprite()
sprite:Load("gfx/1000.015_poof01.anm2", true)
local sfxManager = SFXManager()


local L19_SlothStats = {
    DAMAGE = 2.857,
    SPEED = -0.2,
    SHOTSPEED = 0,
    MAXFIREDELAY = 10,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags.TEAR_EXPLOSIVE,
    Flying = false,
    LUCK = 1,
    TEARCOLOR = Color(0, 1.0, 0, 1.0, 0, 0, 0),
    MIN_TIME = 300,
    Up_CHANCE = 5,
    SCALE_1 = 0.4,
    SCALE_2 = 0.4,
    FLY_1 = 20,
    FLY_2 = 1.5
}

local clearcount = 0
local roomcount = 0
local sacrificecount = 0

function L19_Sloth:postUpdate()
    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function L19_Sloth:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "L19_Sloth") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage * L19_SlothStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + L19_SlothStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + L19_SlothStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + L19_SlothStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - L19_SlothStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + L19_SlothStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + L19_SlothStats.LUCK
            end
            if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = L19_SlothStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | L19_SlothStats.TEARFLAG   
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L19_Sloth.OnCache)
    function L19_Sloth:OnUpdate()
        local player = Isaac.GetPlayer(0)
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L19_Sloth.OnUpdate)

    ---@param player EntityPlayer
    function L19_Sloth:PEffect(player)
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
        if level:GetStage() == LevelStage.STAGE1_2 and level:GetStageType() == StageType.STAGETYPE_REPENTANCE_B then
          roomcount = level:GetRoomCount() - 5
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
            if entity.Variant == TearVariant.BLUE then
---@diagnostic disable-next-line: need-check-nil
              Tear:ChangeVariant(TearVariant.BLOOD)
              TearData.RotSize = 50
---@diagnostic disable-next-line: need-check-nil
              Tear.Height = Tear.Height * (L19_SlothStats.SCALE_1 + L19_SlothStats.SCALE_2 * (TearData.RotSize / 100))
              Tear.FallingSpeed = player.TearFallingSpeed - (L19_SlothStats.FLY_1)
              Tear.FallingAcceleration = player.TearFallingAcceleration + (L19_SlothStats.FLY_2)
            end
          end
        end
      end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, L19_Sloth.PEffect)

    function L19_Sloth:NewRoom()
        if room:IsFirstVisit() and room:IsClear() then
          clearcount = clearcount + 1
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, L19_Sloth.NewRoom)

    ---@param rng RNG
    ---@param spawn boolean
    function L19_Sloth:RoomClear(rng, spawn)
      clearcount = clearcount + 1
    end
    mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, L19_Sloth.RoomClear)
    
    function L19_Sloth:NewLevel()
      clearcount = 1
      sacrificecount = 0
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, L19_Sloth.NewLevel)

    ---@param player Entity
    ---@param _ number
    ---@param DamageFlags integer
    function L19_Sloth:TakeDmg(player, _, DamageFlags)
      player = player:ToPlayer()
      if player:GetPlayerType() ~= SlothGuy then
        return
      end 
    -- bitset integer in next line codes for damage flags of no pentaly and spikes
      if DamageFlags == 268435584 and room:GetType() == RoomType.ROOM_SACRIFICE then  
        sacrificecount = sacrificecount + 1
        if sacrificecount == 11 then
          Isaac.Spawn(EntityType.ENTITY_SLOTH_STATION, 0, 0, room:FindFreeTilePosition(Vector(320, 210), 50), Vector(0, 0), nil)
        end
      end
    end
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, L19_Sloth.TakeDmg, EntityType.ENTITY_PLAYER)

    function L19_Sloth:Render()
      sprite:Update()
      sprite:Render(Vector(320, 210), Vector.Zero, Vector.Zero)
    end 
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, L19_Sloth.Render)

end

return L19_Sloth
