local Puzzle_Cube = {}
local game = Game()

mod.TRINKET_PUZZLE_CUBE = Isaac.GetTrinketIdByName("Puzzle Cube")

local hasAutoCleared = false

function Puzzle_Cube:postUpdate()
    function Puzzle_Cube:onNewRoom()
        hasAutoCleared = false
    end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Puzzle_Cube.onNewRoom)

    function Puzzle_Cube:Update()

        local room = game:GetRoom()
        local level = game:GetLevel()
        
        -- Check if any player has the Puzzle Cube trinket
        local hasTrinket = false
        for i = 0, game:GetNumPlayers() - 1 do
            local player = game:GetPlayer(i)
            if player:HasTrinket(mod.TRINKET_PUZZLE_CUBE) then
                hasTrinket = true
                break
            end
        end
        
        if not hasTrinket then
            return
        end
        
        -- Don't auto-clear if we've already done it this room
        if hasAutoCleared then
            return
        end
        
        -- Don't auto-clear if the room is already clear
        if room:IsClear() then
            return
        end
        
        -- Exclude rooms that shouldn't be auto-cleared
        local roomType = room:GetType()
        
        -- Don't clear boss trap rooms (they use waves)
        if roomType == RoomType.ROOM_BOSS then
            return
        end
        
        -- Don't clear in Greed Mode
        if game:IsGreedMode() then
            return
        end
        
        -- Don't clear ambush/challenge rooms that use waves
        if roomType == RoomType.ROOM_CHALLENGE or roomType == RoomType.ROOM_BOSSRUSH then
            return
        end
        
        -- Check if there are any alive enemies
        local enemies = Isaac.FindByType(EntityType.ENTITY_EFFECT, -1, -1, false, false)
        local hasEnemies = false
        
        for _, entity in ipairs(Isaac.GetRoomEntities()) do
            if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
                hasEnemies = true
                break
            end
        end
        
        -- If no enemies remain and room isn't clear, force clear it
        if not hasEnemies then
            -- Check if there are any doors that need to be opened (indicates room should be clearable)
            local doorCount = 0
            for i = 0, DoorSlot.NUM_DOOR_SLOTS - 1 do
                local door = room:GetDoor(i)
                if door and not door:IsOpen() then
                    doorCount = doorCount + 1
                end
            end
            
            -- Only auto-clear if there are closed doors (meaning it's a normal combat room)
            if doorCount > 0 then
                room:SetClear(true)
                hasAutoCleared = true
                
                -- Play the room clear sound effect
                SFXManager():Play(SoundEffect.SOUND_DOOR_HEAVY_OPEN, 1.0, 0, false, 1.0)
            end
        end
    end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Puzzle_Cube.Update)
end





return Puzzle_Cube