local Couch_Potato = {}
local game = Game()

--Card.COUCH_POTATO = Isaac.GetCardIdByName("Couch_Potato")

function Couch_Potato:postUpdate()
    --[[local RUNE1 = "gfx/couch_potato.anm2"
    local RuneCooldown = 0
    local CustomRunes = {Card.COUCH_POTATO}
    local RuneChance = {0.02}
    local CouchChance = 0.02
    function Couch_Potato:OnUpdate(player)
        for _, entity in pairs (Isaac.GetRoomEntities()) do
            if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_TAROTCARD then
                local data = entity:GetData()
                local sprite = entity:GetSprite()
                if entity.SubType == Card.COUCH_POTATO then
                    local sprite = entity:GetSprite()
                    if sprite:GetFilename() ~= RUNE1 then
                        sprite:Load(RUNE1, true)
                        sprite:Play("Appear")
                    end
                end
            end
        end
        RuneCooldown = math.max(0, RuneCooldown - 1)
    end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Couch_Potato.OnUpdate)

    function Couch_Potato:onCard(rng, iCurrentCard, bPlaying, bRunes, bOnlyRunes)
        Isaac.DebugString(tostring(bPlaying) .. " " .. tostring(bRunes) .. " " .. tostring(bOnlyRunes))
        if bRunes then
            local roll = rng:RandomFloat()
            local index = 1
            while index <= #RuneChance and roll > RuneChance[index] do
                roll = roll - RuneChance[index]
                index = index + 1
            end
            if index <= #RuneChance then
                return CustomRunes[index]
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_GET_CARD, Couch_Potato.onCard)

    function Couch_Potato:OnUse(...)
        Isaac.GetPlayer(0):AnimateCard(Card.CARD_HOLY, "UseItem")
        local player = Isaac.GetPlayer(0)
        local level = game:GetLevel()
        level:SetStage(LevelStage.STAGE8, StageType.STAGETYPE_REPENTANCE)
        game:StartStageTransition(false, 6, player)
        player:AnimateLightTravel()
    end
mod:AddCallback(ModCallbacks.MC_USE_CARD, Couch_Potato.OnUse, Card.COUCH_POTATO) ]]
end

return Couch_Potato