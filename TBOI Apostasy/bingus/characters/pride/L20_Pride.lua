local L20_Pride = {}
local Game = Game()
local PrideGuy = Isaac.GetPlayerTypeByName("L20_Pride", false)
local sfx = SFXManager()
local sprite = Sprite()
sprite:Load("gfx/ui/bookofboom.anm2", true)

local L20_PrideStats = {
    DAMAGE = 1.05,
    SPEED = 0.1,
    SHOTSPEED = 0.1,
    MAXFIREDELAY = -0.1,
    TEARHEIGHT = 0.5,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 1,
    TEARCOLOR = Color(0.9, 0, 0, 1, 0.1, 0, 0)
}
local Birthright = nil
local book = nil

function L20_Pride:postUpdate()
    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function L20_Pride:OnCache(player, cacheFlag)
      local player = Isaac.GetPlayer(0)

        if(player:GetName() == "L20_Pride") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage * L20_PrideStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + L20_PrideStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + L20_PrideStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + L20_PrideStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - L20_PrideStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + L20_PrideStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + L20_PrideStats.LUCK
            end
            --[[if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = L20_PrideStats.TEARCOLOR
            end ]]
            --[[if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | L20_PrideStats.TEARFLAG
            end ]]
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L20_Pride.OnCache)
    function L20_Pride:PostUpdate()
        local player = Isaac.GetPlayer(0)
        local Reeee = Isaac.GetItemIdByName("Reeee!")

        if(Game:GetFrameCount() == 1 and player:GetName() == "L20_Pride") then
            player:AddCollectible(Reeee)
            player:AddTrinket(TrinketType.TRINKET_NO)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L20_Pride.PostUpdate)

    ---@param player EntityPlayer
    function L20_Pride:PlayerInit(player)
      if player:GetName() == "L20_Pride" then
      --player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_REEEE, ActiveSlot.SLOT_pocket, true)
      local pool = Game:GetItemPool()
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_REEEE)

      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ABADDON)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ANEMIC)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ANTI_GRAVITY)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ARIES)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BLOOD_MARTYR)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BLOODY_LUST)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BLUE_CAP)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CAFFEINE_PILL)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CAPRICORN)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CAT_O_NINE_TAILS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CAT_NINE_TAILS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CEREMONIAL_ROBES)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CHAMPION_BELT)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CHARM_VAMPIRE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CHEMICAL_PEEL)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CRICKETS_BODY)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CRICKETS_HEAD)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_DARK_MATTER)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_DEATHS_TOUCH)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_GROWTH_HORMONES)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_GUILLOTINE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_IRON_BAR)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_JESUS_JUICE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_LORD_OF_THE_PIT)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MOMS_HEELS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MOMS_LIPSTICK)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MOMS_PERFUME)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MOMS_UNDERWEAR)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MONEY_IS_POWER)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MONEY_EQUALS_POWER)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_OUIJA_BOARD)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_PENTAGRAM)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_PISCES)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ROID_RAGE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ROSARY)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SAFETY_PIN)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SAGITTARIUS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SCREW)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SMB_SUPER_FAN)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SQUEEZY)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_STEVEN)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_STIGMATA)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SALT_LAMP)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_STOP_WATCH)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SYNTHOIL)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BELT)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_HALO)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MARK)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_PACT)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SAD_ONION)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_VIRUS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_TOOTH_PICKS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_TORN_PHOTO)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_WIRE_COAT_HANGER)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SPOON_BENDER)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_8_INCH_NAILS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BINKY)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CONTINUUM)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_DEAD_EYE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_EDENS_BLESSING)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_EPIPHORA) 
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_LUSTY_BLOOD)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MARKED)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MOMS_PEARLS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MR_DOLLY)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_PURITY)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_TRACTOR_BEAM)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ADRENALINE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ANALOG_STICK)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_APPLE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_GODHEAD)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_NUMBER_ONE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ODD_MUSHROOM_DAMAGE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ODD_MUSHROOM_LARGE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ODD_MUSHROOM_RATE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ODD_MUSHROOM_THIN)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_PROPTOSIS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SACRED_HEART)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_KIDNEY_STONE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ZODIAC)
      --pool:RemoveCollectible(CollectibleType.)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BOZO)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BRITTLE_BONES)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CAMO_UNDIES)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_COMPOUND_FRACTURE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_DADS_LOST_COIN)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_DARK_PRINCESS_CROWN)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_DIVORCE_PAPERS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_DOG_TOOTH)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SULFURIC_ACID)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BAR_OF_SOAP)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_ACT_OF_CONTRITION)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BINGE_EATER)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BLOOD_OATH)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_BLOODY_GUST)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_CANDY_HEART)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_EYE_DROPS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_EYE_OF_THE_OCCULT)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_GLASS_EYE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_IMMACULATE_HEART)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_IT_HURTS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MERCURIUS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MOMS_RING)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SOCKS)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_PASCHAL_CANDLE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_PLUTO)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_RED_STEW)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SAUSAGE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SOUL_LOCKET)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_STAPLER)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_TERRA)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_TROPICAMIDE)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MEAT)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_SPEED_BALL)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_WOODEN_SPOON)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MINI_MUSH)
      pool:RemoveCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, L20_Pride.PlayerInit)

    ---@param player EntityPlayer
    function L20_Pride:OnUpdate(player)
      if player:GetPlayerType() ~= PrideGuy then
        return
      end
      if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
        Birthright = true
      else
        Birthright = false
      end
      if Birthright == true and book == nil then
        sprite:Play("Hud", true)
        book = true
      end
      for _, entity in pairs(Isaac.GetRoomEntities()) do
        local data = entity:GetData()
        if entity.Type == EntityType.ENTITY_TEAR then
          local Tear = entity:ToTear()
          local TearData = entity:GetData()
          if entity.Variant == TearVariant.BLUE then
---@diagnostic disable-next-line: need-check-nil
            Tear:ChangeVariant(TearVariant.BLOOD)
          end
        end
      end
    end
  mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, L20_Pride.OnUpdate)

    function L20_Pride:render()
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= PrideGuy then
        return
      end
      if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
        sprite:Update()
        sprite:Render(Vector(40, 35), Vector(0,0), Vector(0,0))
       end
    end
  mod:AddCallback(ModCallbacks.MC_POST_RENDER, L20_Pride.render)
    ---@param item CollectibleType
    ---@param _ RNG
    ---@param player EntityPlayer
    ---@param _ UseFlags
    ---@param slot ActiveSlot
    function L20_Pride:birthright(item, _, player, _, slot)
      if player:GetPlayerType() ~= PrideGuy then
        return
      end
      if slot ~= 0 then
        return
      end
      if Birthright == true then
---@diagnostic disable-next-line: param-type-mismatch
        player:UseCard(Card.CARD_TOWER, UseFlag.USE_NOANNOUNCER)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_REEEE) then
          return
        end
        sfx:Play(SoundEffect.SOUND_BOSS_LITE_HISS, 1, 0, false, 1)
        player:AnimateHappy()
        sfx:Stop(SoundEffect.SOUND_THUMBSUP)
      end
    end
  mod:AddCallback(ModCallbacks.MC_USE_ITEM, L20_Pride.birthright)
end

return L20_Pride
