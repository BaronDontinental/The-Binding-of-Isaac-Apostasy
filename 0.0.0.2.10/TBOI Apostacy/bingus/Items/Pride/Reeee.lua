local Reeee = {}
local game = Game()

mod.COLLECTIBLE_REEEE = Isaac.GetItemIdByName("Reeee!")
CollectibleType.COLLECTIBLE_REEEE = Isaac.GetItemIdByName("Reeee!")


local DirectionVector = {
    UP = Vector(0,-1),
    LEFT = Vector(-1,0),
    DOWN = Vector(0,1),
    RIGHT = Vector(1,0),
    NO_DIRECTION = Vector(0,0)
}

function Reeee:postUpdate() --[[
    function Reeee.Use()
        local player = Isaac.GetPlayer(0)

        print("ur mom is gay")
    end
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Reeee.OnUpdate)
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, Reeee.Use, mod.COLLECTIBLE_REEEE)
]]
end



return Reeee