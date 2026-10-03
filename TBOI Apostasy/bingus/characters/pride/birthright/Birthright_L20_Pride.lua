local Birthright_L20_Pride = {}
local PrideGuy = Isaac.GetPlayerTypeByName("L20_Pride", false)
local sfx = SFXManager()
local sprite = Sprite()
sprite:Load("gfx/ui/bookofboom.anm2", true)

local Birthright = nil
local book = nil

function Birthright_L20_Pride:postUpdate()
    function Birthright_L20_Pride:OnUpdate(player)
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
    end
  mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Birthright_L20_Pride.OnUpdate)

    function Birthright_L20_Pride:render()
      local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() ~= PrideGuy then
        return
      end
      if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
        sprite:Update()
        sprite:Render(Vector(40, 35), Vector(0,0), Vector(0,0))
       end
    end
  mod:AddCallback(ModCallbacks.MC_POST_RENDER, Birthright_L20_Pride.render)
    function Birthright_L20_Pride:birthright(item, _, player, _, slot)
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
  mod:AddCallback(ModCallbacks.MC_USE_ITEM, Birthright_L20_Pride.birthright)
end

return Birthright_L20_Pride
