local Puzzle_Cube = {}
local game = Game()

mod.TRINKET_PUZZLE_CUBE = Isaac.GetTrinketIdByName("Puzzle Cube")
TrinketType.TRINKET_PUZZLE_CUBE = Isaac.GetTrinketIdByName("Puzzle Cube")

local CLEAR_DELAY = 30 -- update frames the room must stay enemy free before the puzzle gets solved
local PLATE_PRESSED_STATE = 3
local clearTimer = 0

function Puzzle_Cube:postUpdate()

    local function anyPlayerHasTrinket()
        for i = 0, game:GetNumPlayers() - 1 do
            if game:GetPlayer(i):HasTrinket(TrinketType.TRINKET_PUZZLE_CUBE) then
                return true
            end
        end
        return false
    end

    -- Pressure plate variants: 0 = trigger/puzzle button, 1 = reward plate,
    -- 2 = greed plate (spawns enemy waves, marks a trap room)
    local function getPlateCounts(room)
        local counts = { trigger = 0, unpressed = 0, trap = 0 }
        for i = 0, room:GetGridSize() - 1 do
            local grid = room:GetGridEntity(i)
            if grid and grid:GetType() == GridEntityType.GRID_PRESSURE_PLATE then
                local variant = grid.Desc.Variant
                if variant == 0 then
                    counts.trigger = counts.trigger + 1
                    if grid.State ~= PLATE_PRESSED_STATE then
                        counts.unpressed = counts.unpressed + 1
                    end
                elseif variant == 2 then
                    counts.trap = counts.trap + 1
                end
            end
        end
        return counts
    end

    -- Presses every unpressed puzzle button as if the player stepped on it
    local function pressTriggerPlates(room)
        for i = 0, room:GetGridSize() - 1 do
            local grid = room:GetGridEntity(i)
            if grid and grid:GetType() == GridEntityType.GRID_PRESSURE_PLATE
            and grid.Desc.Variant == 0 and grid.State ~= PLATE_PRESSED_STATE then
                grid.State = PLATE_PRESSED_STATE
                local sprite = grid:GetSprite()
                if sprite then
                    sprite:Play("Switched", true)
                end
            end
        end
    end

    -- An enemy only blocks the auto clear if the game counts it for room
    -- clear (CanShutDoors) and it can actually be hurt. Permanently
    -- invulnerable hazards (Pokys, Grudges, Mockulus, stone turrets, Wall
    -- Huggers and the like) never pass the vulnerability check, so the room
    -- clears with them still alive. Enemies that only hide for a moment
    -- (Hosts, Needles) are remembered once they have been vulnerable, so
    -- they keep blocking while they hide mid fight.
    local function findBlockingEnemy()
        local blocker = nil
        for _, entity in ipairs(Isaac.GetRoomEntities()) do
            local npc = entity:ToNPC()
            if npc and npc:IsActiveEnemy(false) and npc.CanShutDoors and not npc:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
                local data = npc:GetData()
                if npc:IsVulnerableEnemy() then
                    data.PuzzleCubeSeenVulnerable = true
                end
                if data.PuzzleCubeSeenVulnerable and blocker == nil then
                    blocker = npc
                end
            end
        end
        return blocker
    end

    -- Opens any normal door that is still shut, used as a fallback in case
    -- the game does not react to the plates or the clear on its own
    local function openDoors(room)
        local opened = false
        for i = 0, DoorSlot.NUM_DOOR_SLOTS - 1 do
            local door = room:GetDoor(i)
            if door and not door:IsOpen() and not door:IsLocked()
            and door.TargetRoomType ~= RoomType.ROOM_SECRET
            and door.TargetRoomType ~= RoomType.ROOM_SUPERSECRET
            and door.TargetRoomType ~= RoomType.ROOM_ULTRASECRET then
                door:Open()
                opened = true
            end
        end
        return opened
    end

    function Puzzle_Cube:onNewRoom()
        clearTimer = 0
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Puzzle_Cube.onNewRoom)

    function Puzzle_Cube:Update()
        -- Greed mode rooms are wave based, the trinket does nothing there
        if game:IsGreedMode() then
            return
        end

        local room = game:GetRoom()
        local plates = getPlateCounts(room)

        -- Button rooms can count as already clear, the unpressed plates only
        -- hold the doors shut. So the room needs attention when it is either
        -- uncleared or still has unpressed buttons.
        if room:IsClear() and plates.unpressed == 0 then
            clearTimer = 0
            return
        end

        -- Wave based rooms keep spawning enemies after entry and get left
        -- alone. These room types cover every wave mechanic outside greed
        -- mode, which is already excluded above.
        local roomType = room:GetType()
        if roomType == RoomType.ROOM_BOSS
        or roomType == RoomType.ROOM_CHALLENGE
        or roomType == RoomType.ROOM_BOSSRUSH then
            return
        end

        if not anyPlayerHasTrinket() or findBlockingEnemy() then
            clearTimer = 0
            return
        end

        -- The room has to stay enemy free for a moment so enemies that spawn
        -- things on death (Mulligans, Envy heads, etc) still get counted
        clearTimer = clearTimer + 1
        if clearTimer < CLEAR_DELAY then
            return
        end
        clearTimer = 0

        -- Greed plates spawn enemy waves when pressed, those rooms are traps
        -- and get left alone
        if plates.trap > 0 then
            return
        end

        -- Press the puzzle buttons like the player stepped on them, the game
        -- then reacts to the pressed plates on its own
        if plates.unpressed > 0 then
            pressTriggerPlates(room)
        end

        -- If the room is genuinely uncleared on top of the buttons, clear it
        -- too. REPENTOGON does it properly (doors open, clear award spawns),
        -- otherwise it gets done by hand.
        if not room:IsClear() then
            local cleared = pcall(function()
                room:TriggerClear(true)
            end)
            if not cleared or not room:IsClear() then
                room:SetClear(true)
            end
        end

        -- Whatever held the doors, make sure the normal ones end up open
        if openDoors(room) then
            SFXManager():Play(SoundEffect.SOUND_DOOR_HEAVY_OPEN, 1, 0, false, 1)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Puzzle_Cube.Update)

end

return Puzzle_Cube