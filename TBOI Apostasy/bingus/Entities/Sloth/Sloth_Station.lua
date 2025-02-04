local Sloth_Station = {}
local Game = Game()
local level = Game:GetLevel()
local room = Game:GetRoom()
local SlothGuy = Isaac.GetPlayerTypeByName("L19_Sloth", false)
local sprite = Sprite()
local sound = SFXManager()
local CurrentStage
local RoomConfig
local Register
local dmgStep = 0
local roll
local completed = 0

--[[local Beggar = {
    ENTITY_SLOTH_STATION = 600
} ]]
BeggarState = {
    IDLE = 0,
    PAYNOTHING = 2,
    PAYPRIZE = 3,
    PRIZE = 4,
    TELEPORT = 5
}

EntityType.ENTITY_SLOTH_STATION = Isaac.GetEntityTypeByName("Sloth Station")

function Sloth_Station:postUpdate()
    function Sloth_Station:RemoveFromRegister(entity)
        for j = 1, #Register do
            if Register[j].Room == Game:GetLevel():GetCurrentRoomIndex()
            and Register[j].Position.X == entity.Position.X
            and Register[j].Position.Y == entity.Position.Y
            and Register[j].Entity.Type == entity.Type
            and Register[j].Entity.Variant == entity.Variant
            then
                table.remove(Register, j)
                break
            end
        end
    end
    function Sloth_Station:SpawnRegister()
        for j = 1, #Register do
            if Register[j].Room == Game:GetLevel():GetCurrentRoomIndex() then
                local entity = Isaac.Spawn(
                    Register[j].Entity.Type,
                    Register[j].Entity.Variant, 0,
                    Register[j].Position,
                    Vector(0,0), nil)
                if Register[j].Entity.Type == EntityType.ENTITY_SLOTH_STATION then
                    local beggarFlag = EntityFlag.FLAG_NO_TARGET | EntityFlag.FLAG_NO_STATUS_EFFECTS
                    entity:ClearEntityFlags(entity:GetEntityFlags())
                    entity:AddEntityFlags(beggarFlag)
                    entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                end
            end
        end
    end
    function Sloth_Station:SaveState()
        local SaveData = ""
            for j = 1, #Register do
                SaveData = SaveData
                    .. string.format("%5u",Register[j].Room)
                    .. string.format("%4u",Register[j].Position.X)
                    .. string.format("%4u",Register[j].Position.Y)
                    .. string.format("%4u",Register[j].Entity.Type)
                    .. string.format("%4u",Register[j].Entity.Variant)
            end
        mod:SaveData(SaveData)
    end
    function Sloth_Station:onStarted(fromSave)
        if fromSave then
            local ModData = mod:LoadData()
            Isaac.DebugString(ModData)
            Register = {}
            dmgStep = 0
            completed = 0
            for i = 1, ModData:len(), 21 do
                local X = tonumber(ModData:sub(i + 5, i + 8))
                local Y = tonumber(ModData:sub(i + 9, i + 12))
                table.insert(Register, 
                    {
                    Room = tonumber(ModData:sub(i, i + 4)),
                    ---@diagnostic disable-next-line: param-type-mismatch
                    Position = Vector(X, Y),
                    Entity = { Type = tonumber(ModData:sub(i + 13, i + 16)), Variant = tonumber(ModData:sub(i + 17, i + 20))}
                    }
                )
            end
            Sloth_Station:SpawnRegister()
        else
            local level = Game:GetLevel()
            CurStage = level:GetStage()
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Sloth_Station.onStarted)

    function Sloth_Station:onRoom()
        RoomConfig = {}
        local room = Game:GetRoom()
        for i = 1, room:GetGridSize() do
            local Grid = room:GetGridEntity(i)
            if Grid == nil then
                RoomConfig[i] = nil
            else
                RoomConfig[i] = {Type = Grid.Desc.Type, Variant = Grid.Desc.Variant, State = Grid.Desc.State}
            end
        end

        if Game:GetFrameCount() <= 1 then
            Register = {}
            dmgStep = 0
            completed = 0
        end

        local level = Game:GetLevel()
        if CurStage ~= level:GetStage() then
            Register = {}
            dmgStep = 0
            completed = 0
        end
        CurStage = level:GetStage()

        Sloth_Station:SpawnRegister()
        Sloth_Station:SaveState()
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Sloth_Station.onRoom)

    function Sloth_Station:onLevel()
        Sloth_Station:SaveState()
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL,Sloth_Station.onLevel)

    function Sloth_Station:onExit(shouldSave)
        Sloth_Station:SaveState()
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, Sloth_Station.onExit)

    
    function Sloth_Station:onBeggar(entity)
        local player = Isaac.GetPlayer(0)
        local entity = entity:ToNPC()
        local beggarFlag = EntityFlag.FLAG_NO_TARGET | EntityFlag.FLAG_NO_STATUS_EFFECTS
        if entity:GetEntityFlags() ~= beggarFlag then
            entity:ClearEntityFlags(entity:GetEntityFlags())
            entity:AddEntityFlags(beggarFlag)
            entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
            local roomIndex = Game:GetLevel():GetCurrentRoomIndex()
                table.insert(Register,
                {
                    Room = roomIndex,
                    Position = entity.Position,
                    Entity = {Type = entity.Type, Variant = entity.Variant}
                }
            )
        end
        local data = entity:GetData()
        if data.Position == nil then 
            data.Position = entity.Position     
        end
        entity.Velocity = data.Position - entity.Position
        local free = room:FindFreeTilePosition(entity.Position, 1000)

        local sprite = entity:GetSprite()
        if entity.State == BeggarState.IDLE then
            if entity.StateFrame == 0 then
                sprite:Play("Idle", true)
            end
            if (entity.Position - player.Position):Length() <= entity.Size + player.Size then
                if entity.Variant == 0 then
                    dmgStep = dmgStep + 1
                    roll = math.random(0,100)
                end
                if dmgStep == 1 and completed == 0 then
                    player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(entity), 0)
                    completed = completed + 1
                    Isaac.Spawn(EntityType.ENTITY_SLOT, SlotVariant.BEGGAR, 0, free, Vector(0,0), nil)
                    Isaac.Spawn(EntityType.ENTITY_SLOT, SlotVariant.BEGGAR, 0, free, Vector(0,0), nil)
                end
                if dmgStep == 2 and completed == 1 then
                    player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(entity), 0)
                    completed =  completed + 1
                    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_SOUL_CAIN, free, Vector(0,0), nil)
                    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_SOUL_CAIN, free, Vector(0,0), nil)
                    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_SOUL_CAIN, free, Vector(0,0), nil)
                    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_SOUL_CAIN, free, Vector(0,0), nil)
                    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_SOUL_CAIN, free, Vector(0,0), nil)
                end
				if dmgStep == 3 and completed == 2 then
					player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(entity), 0)
                    completed =  completed + 1
                    if roll <= 30 then
                    -- spawn red key
                    elseif roll <=60 then
                    -- spawn R key
                    else
                    -- spawn genisis
                    end 
				end
				if dmgStep == 4 and completed == 3 then
				    player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(entity), 0)
                    completed =  completed + 1
                    -- spawn mama mega 
				end
				if dmgStep == 5 and completed == 4 then
				    player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(entity), 0)
                    completed =  completed + 1
                    -- spawn angel shop stairway 
				end
				if dmgStep == 6 and completed == 5 then
				    player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(entity), 0)
                    completed =  completed + 1
                    -- spawn megachest 
				end
				if dmgStep == 7 and completed == 6 then
				    player:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(entity), 0)
                    completed =  completed + 1
                    -- spawn reverse emporer 
				end
				if dmgStep == 8 and completed == 7 then
				    qplayer:TakeDamage(2, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(entity), 0)
                    completed =  completed + 1
                    -- spawn reverse world
                end 
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, Sloth_Station.onBeggar, EntityType.ENTITY_SLOTH_STATION)
    
    Sloth_Station:onRoom()
    Sloth_Station:onLevel()

end

return Sloth_Station