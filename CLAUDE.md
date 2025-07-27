# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is **The Binding of Isaac: Apostasy**, a comprehensive mod for The Binding of Isaac: Repentance that introduces 6 new characters based on the seven deadly sins (excluding Greed). The mod is built using Lua and integrates with the Isaac modding API and REPENTOGON extensions.

## Architecture

### Core Structure
- **Main Entry Point**: `TBOI Apostasy/main.lua` - Initializes the mod and loads all components
- **Module Organization**: `callbacks/yoink.lua` - Central module loader that organizes all characters, items, and pools
- **Enums**: `enums.lua` - Contains custom enumerations and constants (very large file with 70k+ tokens)

### Character System
Characters are organized by sin in `bingus/characters/` with two variants each:
- **Normal Characters (L-series)**: L19_Sloth, L20_Pride, L21_Envy, L22_Gluttony, L23_Lust, L24_Wrath
- **Tainted Characters (B-series)**: B25_Sloth, B26_Pride, B27_Envy, B28_Gluttony, B29_Lust, B30_Wrath

#### Character Mechanics

**L19_Sloth (Sloth)**
- **Stats**: High damage (2.857x), slow speed (-0.2), explosive tears, +1 luck
- **Unique Mechanic**: Room clear progression system - boss doors are locked until all rooms are cleared
- **Special Features**: 
  - Sacrifice room counter (spawns Sloth Station entity at 11 sacrifices)
  - Blue tears converted to blood tears with scaling effects
  - Challenge rooms auto-unlock
  - Custom tear offset positioning

**B25_Sloth (Tainted Sloth)**
- **Stats**: Same as L19_Sloth but simplified
- **Unique Mechanic**: Starts with a random card (1-54) instead of room progression system
- **Difference**: Stripped-down version focusing on card synergy rather than room mechanics

**L20_Pride (Pride)**
- **Stats**: Moderate damage boost (1.05x), speed increase (+0.1), improved fire rate
- **Unique Mechanic**: Extensive item pool manipulation - removes 100+ items from spawn pools
- **Special Features**:
  - Starts with "Reeee!" item and "No!" trinket  
  - Birthright integration with special UI element
  - Blue tears converted to blood tears
  - Item pool "curation" removes stat-boosting items to maintain balance

**B26_Pride (Tainted Pride)**
- **Stats**: Same base stats as L20_Pride
- **Unique Mechanic**: Simplified version - starts with random card + "Reeee!" item
- **Difference**: No item pool manipulation, focuses on card/item synergy

**L21_Envy (Envy)**
- **Stats**: Baseline stats with neutral modifiers
- **Unique Mechanic**: Complex orbital familiar system with multiple variants
- **Special Features**:
  - 14 different orbital familiar types (Close, Far, Zig patterns)
  - Damage-triggered familiar spawning system
  - Hit chance mechanics for familiar generation
  - Extensive entity variant definitions

**L22_Gluttony (Gluttony)**
- **Stats**: Slower speed (-0.15), neutral damage
- **Unique Mechanic**: Custom animation system with brimstone laser integration
- **Special Features**:
  - Multiple sprite states (walking, shooting, firing)
  - Custom tear offset positioning for different directions
  - Brimstone laser compatibility
  - Complex animation state management

**Character Design Philosophy**
- **L-series (Normal)**: Complex, mechanic-heavy characters with unique gameplay systems
- **B-series (Tainted)**: Simplified versions focusing on starting items and card synergy
- **Stat Balance**: Each character has distinct stat distributions reflecting their sin theme
- **Thematic Integration**: Mechanics tie directly to deadly sin concepts (Sloth = progression locks, Pride = item curation, Envy = orbital familiars)

### Item System
Items are categorized by sin in `bingus/Items/`:
- **Sloth Items**: Slug, Rotgut, Trench_Foot, Active_Carbos, Lil_Sloth, etc.
- **Pride Items**: Chicken, The_Shaker, Salt_Lamp, Participation_Award, etc.
- **Envy Items**: Moar, Chaos2, Split_Decision, Snake_Eyes, etc.
- **Gluttony Items**: Devour, Wide_Brim_Hat, Vox_Populi, etc.
- **Lust Items**: Cooties, Epipen, Nitroglycerin, etc.
- **Wrath Items**: Transfuse, Hornfells_Horn, Bowling_Bombs, etc.

### Entity System
- **Entities**: `bingus/Entities/` - Custom entities like Sloth_Station
- **Pocket Items**: `bingus/PocketItems/` - Items like Couch_Potato
- **Pools**: `bingus/Pools/` - Custom item pools like Brownie_Pool

## Development Environment

### Lua Configuration
The project uses Lua 5.3 with REPENTOGON extensions. Key configuration:
- **Lua Language Server**: Configured via `.luarc.json`
- **API Libraries**: Isaac Lua API with REPENTOGON extensions
- **Globals**: Extensive list of Isaac-specific globals defined in `.luarc.json`

### Module Loading Pattern
The mod uses a unique "yoink" system for module management:
```lua
local yoink = require("callbacks.yoink")
yoink:bringC() -- Load characters
yoink:bringI() -- Load items  
yoink:bringP() -- Load pools
```

Each module must implement a `postUpdate()` method that gets called during initialization.

## Development Workflow

### No Build System
This project does not use traditional build tools like npm, make, or shell scripts. Development workflow is:
1. Edit Lua files directly
2. Test in-game via Isaac mod loader
3. Use Isaac's built-in mod reload functionality

### Testing
Testing is done in-game through:
- Isaac's debug console
- Mod reload commands
- In-game testing with different characters and items

### File Organization
- **Assets**: `resources/` and `resources-dlc3/` contain sprites, animations, and audio
- **Content**: `content/` contains XML definitions for items, characters, and achievements
- **Save Data**: `savedata/` contains character-specific save files

## Common Development Tasks

### Adding New Items
1. Create Lua file in appropriate `bingus/Items/[Sin]/` directory
2. Add require statement to `callbacks/yoink.lua`
3. Add postUpdate() call to `yoink:bringI()` function
4. Add XML definition to `content/items.xml`
5. Add sprites to `resources/gfx/items/`

### Adding New Characters  
1. Create Lua file in `bingus/characters/[sin]/` directory
2. Add require statement to `callbacks/yoink.lua`
3. Add postUpdate() call to `yoink:bringC()` function
4. Add XML definition to `content/players.xml`
5. Add sprites and animations to `resources/gfx/characters/`

### Character Development Patterns

#### Required Character Structure
```lua
local CharacterName = {}
local Game = Game()
local CharacterType = Isaac.GetPlayerTypeByName("CharacterName", false)

local CharacterStats = {
    DAMAGE = 1.0,
    SPEED = 0.0,
    SHOTSPEED = 0.0,
    MAXFIREDELAY = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    TEARFLAG = TearFlags,
    LUCK = 0,
    TEARCOLOR = Color(0, 0, 0, 0, 0, 0, 0)
}

function CharacterName:postUpdate()
    -- Cache evaluation callback
    function CharacterName:OnCache(player, cacheFlag)
        if player:GetName() == "CharacterName" then
            -- Apply stat modifications
        end
    end
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, CharacterName.OnCache)
    
    -- Character-specific update logic
    function CharacterName:OnUpdate()
        -- Character mechanics
    end
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, CharacterName.OnUpdate)
end

return CharacterName
```

#### Character Callback Patterns
- **MC_EVALUATE_CACHE**: Stat modifications and tear properties
- **MC_POST_UPDATE**: Frame-by-frame character mechanics
- **MC_POST_PEFFECT_UPDATE**: Player effect updates (visual, tear modifications)  
- **MC_POST_PLAYER_INIT**: Character initialization (starting items, pool modifications)
- **MC_POST_NEW_ROOM**: Room-specific mechanics
- **MC_POST_NEW_LEVEL**: Level-specific resets
- **MC_ENTITY_TAKE_DMG**: Damage-triggered mechanics
- **MC_POST_RENDER**: Custom UI rendering

#### Common Character Mechanics
- **Tear Conversion**: Blue tears to blood tears (`Tear:ChangeVariant(TearVariant.BLOOD)`)
- **Item Pool Manipulation**: `Game:GetItemPool():RemoveCollectible()`
- **Entity Spawning**: `Isaac.Spawn()` for custom entities
- **Stat Scaling**: Multiplicative vs additive stat bonuses
- **Familiar Systems**: Custom orbital and following familiar logic
- **Animation Integration**: Custom sprite loading and state management

### Known Issues
Refer to `Reports/Bugs and to-do.txt` for current bugs and planned features:
- Random crashes when holding R or starting runs
- Sacrifice counter bugs for Sloth character
- Save/load issues with entity persistence
- Various character-specific bugs

## Important Notes

- The mod is currently in active development (version 0.0.0.4.2)
- Debug mode is enabled by default in `main.lua`
- The project uses Isaac Workshop ID: 3219505588
- All sprite work and animations are custom-made for this mod
- The mod requires both base Isaac and REPENTOGON to function properly