local B29_Lust = {}
local Game = Game()

local LustLump = Isaac.GetCostumeIdByPath("gfx/characters/character_B29_Lust.anm2")
local LustGuy = Isaac.GetPlayerTypeByName("B29_Lust", true)
EffectVariant.CHARMCLOUD = Isaac.GetEntityVariantByName("Charm Cloud")

local B29_LustStats = {
    DAMAGE = 0,
    SPEED = 0,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0)
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

function B29_Lust:postUpdate()
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
    function B29_Lust:OnUpdate()
        local player = Isaac.GetPlayer(0)
        if(Game:GetFrameCount() == 1 and player:GetName() == "B29_Lust") then
            player:AddTrinket(TrinketType.TRINKET_SAFETY_CAP)
            player:AddPill(math.random(1, 13))
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, B29_Lust.OnUpdate)

    function B29_Lust:PillGrab(pilleffect, player, flag, pillcolor)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      if pilleffect == PillEffect.PILLEFFECT_BAD_GAS then
        LustPills.BadGas = true
        LustPillsCnt.BadGas = LustPills.BadGas + 1
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
        LustPillsCnt.RangeDown = LustPillsCnt.RangeDown + 1
      end
      if pilleffect == PillEffect.PILLEFFECT_RANGE_UP then
        LustPills.RangeUp = true
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
      if pilleffect == PillEffect.PILLEFFECT_ then
        LustPills.RUAWizard = true
        LustPillsCnt.RUAWizard = LustPillsCnt.RUAWizard + 1
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
      end
    end
    mod:AddCallback(ModCallbacks.MC_USE_PILL, B29_Lust.PillGrab)

    function B29_Lust:CloudPeUpdate(player)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
      local spawnpos = player.Position
      if not aura then
        cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CHARMCLOUD, 0, spawnpos, Vector.Zero, player):ToEffect()
---@diagnostic disable-next-line: need-check-nil
        cloud:FollowParent(player)
        cloud.SpriteOffset = Vector(0, -20)
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
    end
  mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, B29_Lust.CloudPeUpdate)

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
---@diagnostic disable-next-line: param-type-mismatch
    for _, entity in ipairs(Isaac.FindInCapsule(capsule, EntityPartition.ENEMY)) do
      local hit = entity:GetData()
      if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
          entity:AddCharmed(poggers, 90)
          entity:TakeDamage(.25, 0, poggers, 50)
      end
      if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() and not hit.Charmed then
        local roll = math.random(1, 100)
        hit.Charmed = true
        --[[if roll >= 90 then
          local fly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, 0, spawnpos, Vector.Zero, player):ToFamiliar()
        end]]
      end
    end
  end
  mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, B29_Lust.CloudEUpdate, EffectVariant.CHARMCLOUD)




end

return B29_Lust
