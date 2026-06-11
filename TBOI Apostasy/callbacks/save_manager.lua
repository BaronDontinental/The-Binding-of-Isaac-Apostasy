--Central save data manager for the mod. Every module keeps its run state
--under its own section so nothing clobbers anything else, and the whole
--store gets written to the mod's save#.dat file as one json blob.
--
--Usage:
--  local SaveManager = require("callbacks.save_manager")
--  SaveManager.Set("MySection", myTable)   -- store and write to disk
--  SaveManager.Get("MySection")            -- read back (nil if nothing saved)
local SaveManager = {}
local json = require("json")

local store = {}
local loaded = false

--The disk file only gets read once per game session, after that the in
--memory store is the source of truth (it is what gets written out)
local function ensureLoaded()
    if loaded then
        return
    end
    loaded = true
    if mod:HasData() then
        local ok, data = pcall(json.decode, mod:LoadData())
        if ok and type(data) == "table" then
            store = data
        end
    end
end

--Returns the table that was saved under this section, or nil if there is
--nothing saved (fresh install, fresh run or unreadable data)
function SaveManager.Get(section)
    ensureLoaded()
    return store[section]
end

--Stores the section table and writes everything to disk right away
function SaveManager.Set(section, data)
    ensureLoaded()
    store[section] = data
    mod:SaveData(json.encode(store))
end

return SaveManager
