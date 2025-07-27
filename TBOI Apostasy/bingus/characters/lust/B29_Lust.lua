local B29_Lust = {}
local Game = Game()

local LustLump = Isaac.GetCostumeIdByPath("gfx/characters/character_b29_lust.anm2")
local LustGuy = Isaac.GetPlayerTypeByName("B29_Lust", true)
EffectVariant.CHARMCLOUD = Isaac.GetEntityVariantByName("Charm Cloud")
local sfxManager = SFXManager()

local B29_LustStats = {
    DAMAGE = 0,
    SPEED = 0.3,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0),
    CLOUDDAMAGE = 0.25,
    SCALING = 1
}

local LustPills = {
  BadGas = false,
  BadTrip = false,
  BallsOfSteel = false,
  BombsAreKey = false,
  ExplosiveDiarrhea = false,
  FullHealth = false,
  HealthDown = false,
  HealthUp = false,
  IFoundPills = false,
  Puberty = false,
  PrettyFly = false,
  RangeDown = false,
  RangeUp = false,
  RangeDown2 = false,
  RangeUp2 = false,
  SpeedDown = false,
  SpeedUp = false,
  TearsDown = false,
  TearsUp = false,
  LuckDown = false,
  LuckUp = false,
  Telepills = false,
  HourEnergy = false,
  Hematemasis = false,
  Paralysis = false,
  ICanSeeForever = false,
  Pheromones = false,
  Amnesia = false,
  LemonParty = false,
  RUAWizard = false,
  Percs = false,
  Addicted = false,
  ReLax = false,
  Question = false,
  OneLarger = false,
  OneSmaller = false,
  InfestedPoop = false,
  InfestedEnemy = false,
  PowerPill = false,
  RetroVision = false,
  FriendsTillTheEnd = false,
  XLax = false,
  SomethingsWrong = false,
  IDrowsy = false,
  IExcited = false,
  Gulp = false,
  Horf = false,
  FeelsLikeSunshine = false,
  Vurp = false,
  ShotSpeedDown = false,
  ShotSpeedUp = false,
  Experimental = false,
}

local LustPillsCnt = {
  BadGas = 0,
  BadTrip = 0,
  BallsOfSteel = 0,
  BombsAreKey = 0,
  ExplosiveDiarrhea = 0,
  FullHealth = 0,
  HealthDown = 0,
  HealthUp = 0,
  IFoundPills = 0,
  Puberty = 0,
  PrettyFly = 0,
  RangeDown = 0,
  RangeUp = 0,
  SpeedDown = 0,
  SpeedUp = 0,
  TearsDown = 0,
  TearsUp = 0,
  LuckDown = 0,
  LuckUp = 0,
  Telepills = 0,
  HourEnergy = 0,
  Hematemasis = 0,
  Paralysis = 0,
  ICanSeeForever = 0,
  Pheromones = 0,
  Amnesia = 0,
  LemonParty = 0,
  RUAWizard = 0,
  Percs = 0,
  Addicted = 0,
  ReLax = 0,
  Question = 0,
  OneLarger = 0,
  OneSmaller = 0,
  InfestedPoop = 0,
  InfestedEnemy = 0,
  PowerPill = 0,
  RetroVision = 0,
  FriendsTillTheEnd = 0,
  XLax = 0,
  SomethingsWrong = 0,
  IDrowsy = 0,
  IExcited = 0,
  Gulp = 0,
  Horf = 0,
  FeelsLikeSunshine = 0,
  Vurp = 0,
  ShotSpeedDown = 0,
  ShotSpeedUp = 0,
  Experimental = 0,
}

local aura = false
local cloud
local latestpill
local creep
local enemy
local explode
local exploded

local ExplosiveDiarrhea = {
  quantity = 5,
  radius = 8,
  delay = 90,
  red_shift = Color(1,0,0,1,0,0,0),
  no_shift = Color(1,1,1,1,0,0,0),
  target = nil
}

local Trench = {
  Size1 = .75,
  Size2 = 1,
  Chance = 20
}


function B29_Lust:postUpdate()
    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function B29_Lust:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "B29_Lust") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = player.Damage + B29_LustStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + B29_LustStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + B29_LustStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + B29_LustStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - B29_LustStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + B29_LustStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + B29_LustStats.LUCK
            end
            --[[if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              player.TearColor = B29_LustStats.TEARCOLOR
            end
            if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              player.TearFlags = player.TearFlags | B29_LustStats.TEARFLAG
            end]]
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, B29_Lust.OnCache)
    ---@param player EntityPlayer
    function B29_Lust:Costume(player)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
        player:AddNullCostume(LustLump)
    end 
      
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, B29_Lust.Costume)
    function B29_Lust:OnUpdate()
        local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() ~= LustGuy then
          return
        end
        if(Game:GetFrameCount() == 1 and player:GetName() == "B29_Lust") then
            player:AddTrinket(TrinketType.TRINKET_SAFETY_CAP)
            player:AddPill(math.random(1, 13))
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B29_Lust.OnUpdate)

    ---@param pilleffect PillEffect
    ---@param player EntityPlayer
    ---@param flag UseFlag
    ---@param pillcolor PillColor
    function B29_Lust:PillGrab(pilleffect, player, flag, pillcolor)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      if pilleffect == PillEffect.PILLEFFECT_BAD_GAS then
        LustPills.BadGas = true
        LustPillsCnt.BadGas = LustPillsCnt.BadGas + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_BAD_TRIP then
        LustPills.BadTrip = true
        LustPillsCnt.BadTrip = LustPillsCnt.BadTrip + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_BALLS_OF_STEEL then
        LustPills.BallsOfSteel = true
        LustPillsCnt.BallsOfSteel = LustPillsCnt.BallsOfSteel + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_BOMBS_ARE_KEYS then
        LustPills.BombsAreKey = true
        LustPillsCnt.BombsAreKey = LustPillsCnt.BombsAreKey + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_EXPLOSIVE_DIARRHEA then
        LustPills.ExplosiveDiarrhea = true
        LustPillsCnt.ExplosiveDiarrhea = LustPillsCnt.ExplosiveDiarrhea + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_FULL_HEALTH then
        LustPills.FullHealth = true
        LustPillsCnt.FullHealth = LustPillsCnt.FullHealth + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_HEALTH_DOWN then
        LustPills.HealthDown = true
        LustPillsCnt.HealthDown = LustPillsCnt.HealthDown + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_HEALTH_UP then
        LustPills.HealthUp = true
        LustPillsCnt.HealthUp = LustPillsCnt.HealthUp + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_I_FOUND_PILLS then
        LustPills.IFoundPills = true
        LustPillsCnt.IFoundPills = LustPillsCnt.IFoundPills + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_PUBERTY then
        LustPills.Puberty = true
        LustPillsCnt.Puberty = LustPillsCnt.Puberty + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_PRETTY_FLY then
        LustPills.PrettyFly = true
        LustPillsCnt.PrettyFly = LustPillsCnt.PrettyFly + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_RANGE_DOWN then
        LustPills.RangeDown = true
        LustPills.RangeDown2 = true
        LustPillsCnt.RangeDown = LustPillsCnt.RangeDown + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_RANGE_UP then
        LustPills.RangeUp = true
        LustPills.RangeUp2 = true
        LustPillsCnt.RangeUp = LustPillsCnt.RangeUp + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_SPEED_DOWN then
        LustPills.SpeedDown = true
        LustPillsCnt.SpeedDown = LustPillsCnt.SpeedDown + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_SPEED_UP then
        LustPills.SpeedUp = true
        LustPillsCnt.SpeedUp = LustPillsCnt.SpeedUp + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_TEARS_DOWN then
        LustPills.TearsDown = true
        LustPillsCnt.TearsDown = LustPillsCnt.TearsDown + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_TEARS_UP then
        LustPills.TearsUp = true
        LustPillsCnt.TearsUp = LustPillsCnt.TearsUp + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_LUCK_DOWN then
        LustPills.LuckDown = true
        LustPillsCnt.LuckDown = LustPillsCnt.LuckDown + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_LUCK_UP then
        LustPills.LuckUp = true
        LustPillsCnt.LuckUp = LustPillsCnt.LuckUp + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_TELEPILLS then
        LustPills.Telepills = true
        LustPillsCnt.Telepills = LustPillsCnt.Telepills + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_48HOUR_ENERGY then
        LustPills.HourEnergy = true
        LustPillsCnt.HourEnergy = LustPillsCnt.HourEnergy + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_HEMATEMESIS then
        LustPills.Hematemasis = true
        LustPillsCnt.Hematemasis = LustPillsCnt.Hematemasis + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_PARALYSIS then
        LustPills.Paralysis = true
        LustPillsCnt.Paralysis = LustPillsCnt.Paralysis + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_SEE_FOREVER then
        LustPills.ICanSeeForever = true
        LustPillsCnt.ICanSeeForever = LustPillsCnt.ICanSeeForever + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_PHEROMONES then
        LustPills.Pheromones = true
        LustPillsCnt.Pheromones = LustPillsCnt.Pheromones + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_AMNESIA then
        LustPills.Amnesia = true
        LustPillsCnt.Amnesia = LustPillsCnt.Amnesia + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_LEMON_PARTY then
        LustPills.LemonParty = true
        LustPillsCnt.LemonParty = LustPillsCnt.LemonParty + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_WIZARD then
        LustPills.RUAWizard = true
        LustPillsCnt.RUAWizard = LustPillsCnt.RUAWizard + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_PERCS then
        LustPills.Percs = true
        LustPillsCnt.Percs = LustPillsCnt.Percs + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_ADDICTED then
        LustPills.Addicted = true
        LustPillsCnt.Addicted = LustPillsCnt.Addicted + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_RELAX then
        LustPills.ReLax = true
        LustPillsCnt.ReLax = LustPillsCnt.ReLax + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_QUESTIONMARK then
        LustPills.Question = true
        LustPillsCnt.Question = LustPillsCnt.Question + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_LARGER then
        LustPills.OneLarger = true
        LustPillsCnt.OneLarger = LustPillsCnt.OneLarger + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_SMALLER then
        LustPills.OneSmaller = true
        LustPillsCnt.OneSmaller = LustPillsCnt.OneSmaller + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_INFESTED_EXCLAMATION then
        LustPills.InfestedPoop = true
        LustPillsCnt.InfestedPoop = LustPillsCnt.InfestedPoop + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_INFESTED_QUESTION then
        LustPills.InfestedEnemy = true
        LustPillsCnt.InfestedEnemy = LustPillsCnt.InfestedEnemy + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_POWER then
        LustPills.PowerPill = true
        LustPillsCnt.PowerPill = LustPillsCnt.PowerPill + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_RETRO_VISION then
        LustPills.RetroVision = true
        LustPillsCnt.RetroVision = LustPillsCnt.RetroVision + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_FRIENDS_TILL_THE_END then
        LustPills.FriendsTillTheEnd = true
        LustPillsCnt.FriendsTillTheEnd = LustPillsCnt.FriendsTillTheEnd + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_X_LAX then
        LustPills.XLax = true
        LustPillsCnt.XLax = LustPillsCnt.XLax + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_SOMETHINGS_WRONG then
        LustPills.SomethingsWrong = true
        LustPillsCnt.SomethingsWrong = LustPillsCnt.SomethingsWrong + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_IM_DROWSY then
        LustPills.IDrowsy = true
        LustPillsCnt.IDrowsy = LustPillsCnt.IDrowsy + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_IM_EXCITED then
        LustPills.IExcited = true
        LustPillsCnt.IExcited = LustPillsCnt.IExcited + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_GULP then
        LustPills.Gulp = true
        LustPillsCnt.Gulp = LustPillsCnt.Gulp + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_HORF then
        LustPills.Horf = true
        LustPillsCnt.Horf = LustPillsCnt.Horf + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_SUNSHINE then
        LustPills.FeelsLikeSunshine = true
        LustPillsCnt.FeelsLikeSunshine = LustPillsCnt.FeelsLikeSunshine + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_VURP then
        LustPills.Vurp = true
        LustPillsCnt.Vurp = LustPillsCnt.Vurp + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_SHOT_SPEED_DOWN then
        LustPills.ShotSpeedDown = true
        LustPillsCnt.ShotSpeedDown = LustPillsCnt.ShotSpeedDown + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_SHOT_SPEED_UP then
        LustPills.ShotSpeedUp = true
        LustPillsCnt.ShotSpeedUp = LustPillsCnt.ShotSpeedUp + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_EXPERIMENTAL then
        LustPills.Experimental = true
        LustPillsCnt.Experimental = LustPillsCnt.Experimental + 1

        local roll1 = math.random(1,6)
        local roll2 = math.random(1,6)
        
        if roll1 == 1 then
          LustPills.HealthDown = true
        elseif roll1 == 2 then
          LustPills.RangeDown = true
        elseif roll1 == 3 then
          LustPills.SpeedDown = true
        elseif roll1 == 4 then
          LustPills.TearsDown = true
        elseif roll1 == 5 then 
          LustPills.LuckDown = true
        elseif roll1 == 6 then
          LustPills.ShotSpeedDown = true
        end

        if roll2 == 1 then
          LustPills.HealthUp = true
        elseif roll2 == 2 then
          LustPills.RangeUp = true
        elseif roll2 == 3 then
          LustPills.SpeedUp = true
        elseif roll2 == 4 then
          LustPills.TearsUp = true
        elseif roll2 == 5 then 
          LustPills.LuckUp = true
        elseif roll2 == 6 then
          LustPills.ShotSpeedUp = true
        end

      end
    end
    mod:AddCallback(ModCallbacks.MC_USE_PILL, B29_Lust.PillGrab)

    function B29_Lust:NewLevel()
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, PillColor.PILL_NULL, Vector(320,320), Vector(0,0), nil):ToPickup()

      B29_LustStats = {
        DAMAGE = 0,
        SPEED = 0,
        SHOTSPEED = 0,
        MAXFIREDELAY = 0,
        TEARHEIGHT = 0,
        TEARFALLINGSPEED = 0,
        TEARFLAG = TearFlags,
        Flying = false,
        LUCK = 0,
        TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0),
        CLOUDDAMAGE = 0.25,
        SCALING = 1
      }

      LustPills = {
        BadGas = false,
        BadTrip = false,
        BallsOfSteel = false,
        BombsAreKey = false,
        ExplosiveDiarrhea = false,
        FullHealth = false,
        HealthDown = false,
        HealthUp = false,
        IFoundPills = false,
        Puberty = false,
        PrettyFly = false,
        RangeDown = false,
        RangeUp = false,
        SpeedDown = false,
        SpeedUp = false,
        TearsDown = false,
        TearsUp = false,
        LuckDown = false,
        LuckUp = false,
        Telepills = false,
        HourEnergy = false,
        Hematemasis = false,
        Paralysis = false,
        ICanSeeForever = false,
        Pheromones = false,
        Amnesia = false,
        LemonParty = false,
        RUAWizard = false,
        Percs = false,
        Addicted = false,
        ReLax = false,
        Question = false,
        OneLarger = false,
        OneSmaller = false,
        InfestedPoop = false,
        InfestedEnemy = false,
        PowerPill = false,
        RetroVision = false,
        FriendsTillTheEnd = false,
        XLax = false,
        SomethingsWrong = false,
        IDrowsy = false,
        IExcited = false,
        Gulp = false,
        Horf = false,
        FeelsLikeSunshine = false,
        Vurp = false,
        ShotSpeedDown = false,
        ShotSpeedUp = false,
        Experimental = false,
      }
      
      LustPillsCnt = {
        BadGas = 0,
        BadTrip = 0,
        BallsOfSteel = 0,
        BombsAreKey = 0,
        ExplosiveDiarrhea = 0,
        FullHealth = 0,
        HealthDown = 0,
        HealthUp = 0,
        IFoundPills = 0,
        Puberty = 0,
        PrettyFly = 0,
        RangeDown = 0,
        RangeUp = 0,
        SpeedDown = 0,
        SpeedUp = 0,
        TearsDown = 0,
        TearsUp = 0,
        LuckDown = 0,
        LuckUp = 0,
        Telepills = 0,
        HourEnergy = 0,
        Hematemasis = 0,
        Paralysis = 0,
        ICanSeeForever = 0,
        Pheromones = 0,
        Amnesia = 0,
        LemonParty = 0,
        RUAWizard = 0,
        Percs = 0,
        Addicted = 0,
        ReLax = 0,
        Question = 0,
        OneLarger = 0,
        OneSmaller = 0,
        InfestedPoop = 0,
        InfestedEnemy = 0,
        PowerPill = 0,
        RetroVision = 0,
        FriendsTillTheEnd = 0,
        XLax = 0,
        SomethingsWrong = 0,
        IDrowsy = 0,
        IExcited = 0,
        Gulp = 0,
        Horf = 0,
        FeelsLikeSunshine = 0,
        Vurp = 0,
        ShotSpeedDown = 0,
        ShotSpeedUp = 0,
        Experimental = 0,
      }
      
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, B29_Lust.NewLevel)

    ---@param player EntityPlayer
    function B29_Lust:CloudPeUpdate(player)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      local spawnpos = player.Position
      local roll = math.random(100)
          if Trench.Chance <= roll then
              local spawnpos = player.Position
              local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, spawnpos, Vector.Zero, player):ToEffect()
              creep.CollisionDamage = B29_LustStats.CLOUDDAMAGE
              creep.Scale = Trench.Size1 * (roll/100)
              creep:Update()
          end
      if not aura then
        cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CHARMCLOUD, 0, spawnpos, Vector.Zero, player):ToEffect()
---@diagnostic disable-next-line: need-check-nil
        cloud:FollowParent(player)
        cloud.SpriteOffset = Vector(0, -20)
        cloud.SpriteScale = cloud.SpriteScale * 1.15
        if LustPills.RangeDown2 then
          cloud.SpriteScale = cloud.SpriteScale * (0.8) ^ LustPillsCnt.RangeDown
        end
        if LustPills.RangeUp2 then 
          cloud.SpriteScale = cloud.SpriteScale * (1.25) ^ LustPillsCnt.RangeUp
        end
        cloud.IsFollowing = true
---@diagnostic disable-next-line: need-check-nil
        cloud:Update()
      end
---@diagnostic disable-next-line: need-check-nil
      if cloud:Exists() then
        aura = true
      else
        aura = false
      end
      
      if LustPills.RangeDown then
        LustPills.RangeDown = false
        cloud.SpriteScale = cloud.SpriteScale * 0.8
        --cloud:update()
      end
      if LustPills.RangeUp then 
        LustPills.RangeUp = false
        cloud.SpriteScale = cloud.SpriteScale * 1.25
        --cloud:update()
      end

    end
  mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B29_Lust.CloudPeUpdate)

  ---@param CloudL Entity
  function B29_Lust:CloudEUpdate(CloudL)
    local player = Isaac.GetPlayer(0)
    if player:GetPlayerType() ~= LustGuy then
      return
    end
    local sprite = CloudL:GetSprite()
    local data = CloudL:GetData()
    data.CharmBlacklist = {}
    local spawnpos = player.Position
    local poggers = EntityRef(player)
    local capsule = CloudL:GetNullCapsule("capsule")

    if LustPills.BombsAreKey then                                                              --bombs are key PillEffect
      ---@diagnostic disable-next-line: param-type-mismatch
      for _, entity in ipairs(Isaac.FindInCapsule(capsule, EntityPartition.ENEMY)) do
        local ent = entity:GetData()
        local pick = entity:ToBomb()
        if pick and pick.Type == EntityType.ENTITY_BOMB and pick.Variant == BombVariant.BOMB_TROLL then
          local count = pick:GetExplosionCountdown()
          if count == 1 then
            pick:Remove()
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, _, pick.Position, Vector(0,0), nil):ToEffect()
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL, pick.Position, Vector(0,0), nil):ToPickup()
          end
        end
      end
    end

    local tearbogo
    local tearmogo
    ---@diagnostic disable-next-line: param-type-mismatch
    for _, entity in ipairs(Isaac.FindInCapsule(capsule, EntityPartition.BULLET)) do
      local ent = entity:GetData()
      local tear = entity:ToProjectile()

      if LustPills.TearsDown then
        if not ent.hit then
          ent.hit = true
          local chance = 50
          local roll = math.random(1,100)
          if roll <= chance then
            tear:Remove()
          end
        end
      end
      if LustPills.TearsUp then
        if tear then
          if tear.SpawnerEntity ~= nil then
            if not ent.hit then
              ent.hit = true
              local chance = 50
              local roll = math.random(1,100)
              if roll <= chance then
                tearbogo = Isaac.Spawn(tear.Type, tear.Variant, tear.SubType, tear.Position, (tear.Velocity:Rotated(15)), nil):ToTear()
                tearmogo = Isaac.Spawn(tear.Type, tear.Variant, tear.SubType, tear.Position, (tear.Velocity:Rotated(-15)), nil):ToTear()
              end
            end
          end
        end
      end
      if LustPills.RUAWizard then
        if not ent.hit then
          ent.hit = true
            tear:AddProjectileFlags(ProjectileFlags.SMART)
            tear.HomingStrength = .5
        end
      end
      if LustPills.OneLarger then
        if not ent.hit then
          ent.hit = true
          tear:AddScale(2)
        end
      end
      if LustPills.OneSmaller then
        if not ent.hit then
          ent.hit = true
          tear:AddScale(-2)
        end
      end
      if LustPills.ShotSpeedDown then
        tear.Velocity = tear.Velocity * 0.8
    end
    if LustPills.ShotSpeedUp then
        tear.Velocity = tear.Velocity * 1.2
    end
    end

    ---@diagnostic disable-next-line: param-type-mismatch
    for _, entity in ipairs(Isaac.FindInCapsule(capsule, EntityPartition.TEAR)) do
      local ent = entity:GetData()
      local tear = entity:ToTear()
      if LustPills.RUAWizard then
        if not ent.hit then
          ent.hit = true
            tear:AddTearFlags(TearFlags.TEAR_HOMING)
        end
      end
      if LustPills.IDrowsy then
          tear.Velocity = tear.Velocity * 0.8
      end
      if LustPills.IExcited then
          tear.Velocity = tear.Velocity * 1.2
      end
    end

---@diagnostic disable-next-line: param-type-mismatch
    for _, entity in ipairs(Isaac.FindInCapsule(capsule, EntityPartition.ENEMY)) do
      local hit = entity:GetData()
      if entity.Type == EntityType.ENTITY_BOMB then
        return
      end
      enemy = entity:ToNPC()
      if enemy and enemy:IsEnemy() and enemy:IsActiveEnemy(true) then
        if LustPills.BadTrip then                                                            -- Bad trip effect
          if enemy:IsDead() and not hit.died then
            hit.died = true
            player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON, false, false, false, false, ActiveSlot.SLOT_PRIMARY)
          end
        end
        if LustPills.BallsOfSteel then                                                       -- balls of steel effect
          if enemy:IsDead() and not hit.died then
            hit.died = true
            local chance = 10
            local roll = math.random(1, 100)
            if roll <= chance then
              Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, enemy.Position, Vector(0,0), nil):ToPickup()
            end
          end
        end
        if LustPills.IFoundPills then                                                       -- balls of steel effect
          if enemy:IsDead() and not hit.died then
            hit.died = true
            local chance = 5
            local roll = math.random(1, 100)
            if roll <= chance then
              Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, PillColor.PILL_NULL, enemy.Position, Vector(0,0), nil):ToPickup()
            end
          end
        end
        if LustPills.HourEnergy then                                                       -- balls of steel effect
          if enemy:IsDead() and not hit.died then
            hit.died = true
            local chance = 10
            local roll = math.random(1, 100)
            if roll <= chance then
              Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MICRO, enemy.Position, Vector(0,0), nil):ToPickup()
            end
          end
        end
        if LustPills.Hematemasis then                                                       -- balls of steel effect
          if enemy:IsDead() and not hit.died then
            hit.died = true
            local chance = 10
            local roll = math.random(1, 100)
            if roll <= chance then
              Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF, enemy.Position, Vector(0,0), nil):ToPickup()
            end
          end
        end
        if LustPills.ReLax then                                                       -- balls of steel effect
          if enemy:IsDead() and not hit.died then
            hit.died = true
            local chance = 20
            local roll = math.random(1, 100)
            if roll <= chance then
              Isaac.Spawn(EntityType.ENTITY_POOP, EntityPoopVariant.NORMAL, 0, enemy.Position, Vector(0,0), nil)
            end
          end
        end
      end
      if enemy and enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
        if LustPills.BadGas then                                                             -- Bad Gas effect
          player:AddEntityFlags(EntityFlag.FLAG_MAGNETIZED)
        end
        if LustPills.HealthDown then                                                         -- Health down effect
          LustPills.HealthDown = false
          B29_LustStats.CLOUDDAMAGE = B29_LustStats.CLOUDDAMAGE * (1.5)
        end
        if LustPills.HealthUp then                                                           --Health up effect
          LustPills.HealthUp = false
          B29_LustStats.CLOUDDAMAGE = B29_LustStats.CLOUDDAMAGE * (0.5)
        end
        if LustPills.ExplosiveDiarrhea then
          enemy:AddEntityFlags(EntityFlag.FLAG_NO_FLASH_ON_DAMAGE)
        end
        if LustPills.FullHealth then
          local chance = 5
          local roll = math.random(1, 100)
          if roll <= chance then
            enemy:AddHealth((enemy.MaxHitPoints/8))
          end
        end
        if LustPills.Puberty then
            enemy.SpriteScale = enemy.SpriteScale * 1.25
        end
        if LustPills.SpeedUp and not hit.speedup then
          enemy:SetSpeedMultiplier(2)
        end
        if LustPills.SpeedDown and not hit.speeddown then
          enemy:AddSlowing(poggers, 30, 0.5, Color(1,1,1,1,0,0,0))
        end
        if LustPills.Paralysis then
          enemy:AddFreeze(poggers, 90)
        end
        if LustPills.LemonParty then
          local mogus
          local chance = 8
          local roll = math.random(1,100)
          if roll <= chance then
            mogus = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_LEMON_PARTY, 0, enemy.Position, Vector.Zero, player):ToEffect()
            mogus.Scale = mogus.Scale / 5
            mogus:Update()
          end
        end
        if LustPills.SomethingsWrong then
          local mogus
          local chance = 8
          local roll = math.random(1,100)
          if roll <= chance then
            mogus = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_BLACK, 0, enemy.Position, Vector.Zero, player):ToEffect()
          end
        end
        if LustPills.XLax then
          local mogus
          local chance = 8
          local roll = math.random(1,100)
          if roll <= chance then
            mogus = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_SLIPPERY_BROWN, 0, enemy.Position, Vector.Zero, player):ToEffect()
          end
        end
        if LustPills.FriendsTillTheEnd then
          enemy:AddCharmed(poggers, 300)
        end
        

      --Base cloud
        enemy:AddCharmed(poggers, 90)
        enemy:TakeDamage(B29_LustStats.CLOUDDAMAGE, 0, poggers, 50)
      end
      if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() and not hit.Charmed then
        hit.Charmed = true

        if LustPills.PrettyFly then
          if LustPillsCnt.PrettyFly == 1 then
            Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, spawnpos, Vector(0,0), player):ToFamiliar()
          elseif LustPillsCnt.PrettyFly == 2 then
            Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, spawnpos, Vector(0,0), player):ToFamiliar()
            Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, spawnpos, Vector(0,0), player):ToFamiliar()
          elseif LustPillsCnt.PrettyFly >= 3 then
            Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, spawnpos, Vector(0,0), player):ToFamiliar()
            Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, spawnpos, Vector(0,0), player):ToFamiliar()
            Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, spawnpos, Vector(0,0), player):ToFamiliar()
          end
        end

        if LustPills.InfestedEnemy then
          Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, 0, spawnpos, Vector(0,0), player):ToFamiliar()
        end

        if LustPills.Amnesia then
          local chance = 2
          local roll = math.random(1,100)
          if roll <= chance then
            Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.ERASER, 0, enemy.Position, Vector(0,0), player):ToTear()
          end
        end
        
        if LustPills.Percs then
          enemy.MaxHitPoints = enemy.MaxHitPoints * 2
          enemy.HitPoints = enemy.HitPoints * 2
        end

        if LustPills.Addicted then
          if not enemy:IsBoss() then
            enemy.MaxHitPoints = enemy.MaxHitPoints / 2
          else
            enemy.MaxHitPoints = enemy.MaxHitPoints * 0.90
          end
        end
        if LustPills.Question then
          local chance = 50
          local roll = math.random(1,100)
          if roll <= chance then
            enemy:Morph(enemy.Type, enemy.Variant, enemy.SubType, ChampionColor.CAMO)
          end
        end
        if LustPills.Gulp then
          sfxManager:Play(SoundEffect.SOUND_GULP, 1, 0, false, 1, 0)
        end
        if LustPills.Horf then
          local chance = 25
          local roll = math.random(1,100)
          if roll <= chance then
---@diagnostic disable-next-line: param-type-mismatch
            Isaac.Explode(enemy.Position, enemy, 100)
          end
        end
      end
    end
  end
  mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, B29_Lust.CloudEUpdate, EffectVariant.CHARMCLOUD)

  function B29_Lust:BombUpdate()
    local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() ~= LustGuy then
          return
        end
    if LustPills.ExplosiveDiarrhea then
      if ExplosiveDiarrhea.target == nil then
        local roomEntities = Isaac.GetRoomEntities()
        local boom
        for i, entity in pairs(roomEntities) do
          boom = entity:ToNPC()
          if boom and boom:HasEntityFlags(EntityFlag.FLAG_NO_FLASH_ON_DAMAGE) and boom:IsEnemy() and boom:IsActiveEnemy(false) and not boom:IsBoss() then
            ExplosiveDiarrhea.target = boom
            ExplosiveDiarrhea.frame = Game:GetFrameCount() + ExplosiveDiarrhea.delay
          end
        end
      elseif Game:GetFrameCount() == ExplosiveDiarrhea.frame then
        if ExplosiveDiarrhea.target:IsActiveEnemy(false) then
          Isaac.Explode(ExplosiveDiarrhea.target.Position, ExplosiveDiarrhea.target, 100)
          ExplosiveDiarrhea.target:Remove()
          ExplosiveDiarrhea.target = nil
        else
          ExplosiveDiarrhea.target = nil 
        end
      elseif Game:GetFrameCount() % 5 == 0 then
        if Game:GetFrameCount() % 10 == 0 then
          ExplosiveDiarrhea.target:SetColor(ExplosiveDiarrhea.no_shift, 0, 0, false, false)
        else
          ExplosiveDiarrhea.target:SetColor(ExplosiveDiarrhea.red_shift, 0, 0, false, false)
        end
      end
    end
    local entities = Isaac.GetRoomEntities()
      local poggers = EntityRef(player)
      local friendlyparam
      for _, entity in ipairs(entities) do
        local eData = entity:GetData()
        friendlyparam = entity:ToNPC()
        local friend = EntityRef(friendlyparam)
        if friendlyparam and friendlyparam:IsEnemy() and friendlyparam:IsActiveEnemy(true) and friend.IsCharmed and not eData.Friend and not friend.IsFriendly and not friendlyparam:IsBoss() then
          --[[if LustPills.PowerPill then
            if friend.IsCharmed then
              friendlyparam:SetInvincible(true)
            else
              friendlyparam:SetInvincible(false)
            end
          end]]
          
          if LustPills.Vurp then
            local color = friendlyparam:GetChampionColorIdx()
              if friendlyparam:IsDead() and not eData.Died and not eData.Friend then
                eData.Died = true
                local obama
                obama = Isaac.Spawn(friendlyparam.Type, friendlyparam.Variant, friendlyparam.SubType, friendlyparam.Position, Vector(0,0), player):ToNPC()
                obama:Morph(friendlyparam.Type, friendlyparam.Variant, friendlyparam.SubType, color)
                eData.Friend = true
                obama:AddEntityFlags(EntityFlag.FLAG_CHARM | EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_PERSISTENT)
                obama.HitPoints = obama.MaxHitPoints
              end
          end
        end
      end


  end
  mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B29_Lust.BombUpdate)

end

return B29_Lust
