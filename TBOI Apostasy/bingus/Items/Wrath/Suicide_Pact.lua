local Suicide_Pact = {}
local game = Game()

mod.COLLECTIBLE_SUICIDE_PACT = Isaac.GetItemIdByName("Suicide Pact")
CollectibleType.COLLECTIBLE_SUICIDE_PACT = Isaac.GetItemIdByName("Suicide Pact")

function Suicide_Pact:postUpdate()
end

return Suicide_Pact