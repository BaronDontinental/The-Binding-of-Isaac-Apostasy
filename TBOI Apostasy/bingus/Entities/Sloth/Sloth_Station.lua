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

local Beggar = {
    ENTITY_SLOTH_STATION = 600
}
BeggarState = {
    IDLE = 0,
    PAYNOTHING = 2,
    PAYPRIZE = 3,
    PRIZE = 4,
    TELEPORT = 5
}

--ENTITY_SLOTH_STATION = Isaac.GetEntityTypeByName("Sloth Station")

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
                if Register[j].Entity.Type == Beggar.ENTITY_SLOTH_STATION then
                    local beggarFlag = EntityFlag.FLAG_NO_TARGET | EntityFlag.FLAG_NO_STATUS_EFFECTS
                    entity:ClearEntityFlags(entity:GetEntityFlags())
                    entity:AddEntityFlags(beggarFlag)
                    entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
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
        end

        local level = Game:GetLevel()
        if CurStage ~= level:GetStage() then
            Register = {}
        end
        CurStage = level:GetStage()

        Sloth_Station:SpawnRegister()
        Sloth_Station:SaveState()
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Sloth_Station.onRoom)

    function Sloth_Station:onExit(shouldSave)
        Sloth_Station:SaveState()
    end
    
end

return Sloth_Station