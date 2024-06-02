local Active_Carbos = {}
local game = Game()

mod.COLLECTIBLE_ACTIVE_CARBOS = Isaac.GetTrinketIdByName("Active Carbos")
TrinketType.COLLECTIBLE_ACTIVE_CARBOS = Isaac.GetTrinketIdByName("Active Carbos")

function Active_Carbos:postUpdate()
    local Carbs = {
        DMG_ADD = 40,
        BASE_CHANCE = 15,
        MAX_LUCK = 10,
        Scale = 1 }
    CarbsTearFlags = {
        TEARFLAG = TearFlags.TEAR_EXPLOSIVE }
    function Active_Carbos:onPassive(player)
    --[[
        if game:GetFrameCount() == 1 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, TrinketType.COLLECTIBLE_ACTIVE_CARBOS, Vector(320,300), Vector(0,0), nil)
        end ]]

        if player:HasTrinket(TrinketType.COLLECTIBLE_ACTIVE_CARBOS) then
            for _, entity in pairs(Isaac.GetRoomEntities()) do
                if entity.Type == EntityType.ENTITY_TEAR then
                    local TearData = entity:GetData()
                    local Tear = entity:ToTear()
                    if TearData.CarbsType == nil then
                        local roll = math.random(100)
                        if roll <= ((100 - Carbs.BASE_CHANCE) * player.Luck / Carbs.MAX_LUCK) + Carbs.BASE_CHANCE then
                            TearData.CarbsType = math.random(1)
                            if TearData.CarbsType == 1 then
                                Tear:SetColor(Color(0.0, 1.0, 0, 1.0, 0, 0, 0), 100, 100, false, false)
                                Tear.TearFlags = Tear.TearFlags | CarbsTearFlags.TEARFLAG
                                Tear.CollisionDamage = Carbs.DMG_ADD
                                Tear:SetSize(Tear.Size * Carbs.Scale, Vector(1,1), 8)
                                Tear.SpriteScale = Tear.SpriteScale * Carbs.Scale
                            end
                        else
                            TearData.CarbsType = 0
                        end
                    end
                end
             end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Active_Carbos.onPassive)

end

return Active_Carbos