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
Characters are organized by sin in `bingus/characters/`:
- **Lazy Characters**: L19_Sloth, L20_Pride, L21_Envy, L22_Gluttony, L23_Lust, L24_Wrath
- **Berserk Characters**: B25_Sloth, B26_Pride, B27_Envy, B28_Gluttony, B29_Lust, B30_Wrath

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