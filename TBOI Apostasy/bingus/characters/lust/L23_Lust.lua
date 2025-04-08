local L23_Lust = {}
local Game = Game()

local LustLump = Isaac.GetCostumeIdByPath("gfx/characters/character_l23_lust.anm2")
local LustGuy = Isaac.GetPlayerTypeByName("L23_Lust", false)
EffectVariant.CHARMCLOUD = Isaac.GetEntityVariantByName("Charm Cloud")

local L23_LustStats = {
    DAMAGE = 0.375,
    SPEED = -0,
    SHOTSPEED = 0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    Flying = false,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0)
}

local aura = false
local cloud


function L23_Lust:postUpdate()
    function L23_Lust:OnCache(player, cacheFlag)
        local player = Isaac.GetPlayer(0)

        if(player:GetName() == "L23_Lust") then
            if(cacheFlag == CacheFlag.CACHE_DAMAGE) then
              player.Damage = (player.Damage * 0.75) + L23_LustStats.DAMAGE
            end
            if(cacheFlag == CacheFlag.CACHE_SPEED) then
              player.MoveSpeed = player.MoveSpeed + L23_LustStats.SPEED
            end
            if(cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
              player.ShotSpeed = player.ShotSpeed + L23_LustStats.SHOTSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_FIREDELAY) then
              player.MaxFireDelay = player.MaxFireDelay + L23_LustStats.MAXFIREDELAY
            end
            if(cacheFlag == CacheFlag.CACHE_RANGE) then
              player.TearHeight = player.TearHeight - L23_LustStats.TEARHEIGHT
              player.TearFallingSpeed = player.TearFallingSpeed + L23_LustStats.TEARFALLINGSPEED
            end
            if(cacheFlag == CacheFlag.CACHE_LUCK) then
              player.Luck = player.Luck + L23_LustStats.LUCK
            end
            --if(cacheFlag == CacheFlag.CACHE_TEARCOLOR) then
              --player.TearColor = L23_LustStats.TEARCOLOR
            --end
            --if(cacheFlag == CacheFlag.CACHE_TEARFLAG) then
              --player.TearFlags = player.TearFlags | L23_LustStats.TEARFLAG
            --end
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, L23_Lust.OnCache)
    function L23_Lust:OnUpdate()
        local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() ~= LustGuy then
          return
        end
        if(Game:GetFrameCount() == 1 and player:GetName() == "L23_Lust") then
            --player:AddCard(math.random(1, 54)) 
        end


    local entities = Isaac.GetRoomEntities()
    local poggers = EntityRef(player)
    local friendlyparam
    for _, entity in ipairs(entities) do
      local eData = entity:GetData()
      friendlyparam = entity:ToNPC()
      local friend = EntityRef(friendlyparam)
      if friendlyparam and friendlyparam:IsEnemy() and friendlyparam:IsActiveEnemy(true) and friend.IsCharmed and not eData.Friend and not friend.IsFriendly and not friendlyparam:IsBoss() then
        local color = friendlyparam:GetChampionColorIdx()
        if friendlyparam:IsDead() and not eData.Died and not eData.Friend then
          eData.Died = true
          local obama
          obama = Isaac.Spawn(friendlyparam.Type, friendlyparam.Variant, friendlyparam.SubType, friendlyparam.Position, Vector(0,0), player):ToNPC()
          obama:Morph(friendlyparam.Type, friendlyparam.Variant, friendlyparam.SubType, color)
          eData.Friend = true
          obama:AddEntityFlags(EntityFlag.FLAG_CHARM)
          obama:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
          obama:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
          obama.HitPoints = obama.MaxHitPoints
        end
      end
    end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, L23_Lust.OnUpdate)

    function L23_Lust:Costume(player)
      if player:GetPlayerType() ~= LustGuy then
        return
      end
        player:AddNullCostume(LustLump)
    end 
      
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, L23_Lust.Costume)

    function L23_Lust:PeUpdate(player)
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
  mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, L23_Lust.PeUpdate)

  function L23_Lust:EUpdate(CloudL)
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
  mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, L23_Lust.EUpdate, EffectVariant.CHARMCLOUD)
end

return L23_Lust
