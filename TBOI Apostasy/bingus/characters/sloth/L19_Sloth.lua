local L19_Sloth = {}
local Game = Game()
local level = Game:GetLevel()
local room = Game:GetRoom()

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
    TEARCOLOR = Color(0, 1.0, 0, 1.0, 0, 0, 0)
}

function L19_Sloth:postUpdate()
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

        if(Game:GetFrameCount() == 1 and player:GetName() == "L19_Sloth") then
            player:AddCard(math.random(1, 54))
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L19_Sloth.OnUpdate)

    function L19_Sloth:PEffect(player)
      if(player:GetName() == "L19_Sloth") then
        --[[local clear = level:GetRoomCount()
        local door = room:GetDoor(DoorSlot.RIGHT0)
        if door ~= nil then
          if door:IsRoomType(RoomType.ROOM_BOSS) then
            print("true")
            door:SetLocked(true)
            door:Close(true)
            door:Bar()
            door:Update()
          end
        end ]] 
        for _, entity in pairs(Isaac.GetRoomEntities()) do
          local data = entity:GetData()
          if entity.Type == EntityType.ENTITY_TEAR then
            local tear = entity:ToTear()
            if entity.Variant == TearVariant.BLUE then
              tear:ChangeVariant(TearVariant.BLOOD)
            end
          end
        end
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, L19_Sloth.PEffect)

end

return L19_Sloth
