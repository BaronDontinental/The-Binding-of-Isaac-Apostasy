local Disability_Papers = {}
local game = Game()

mod.COLLECTIBLE_DISABILITY_PAPERS = Isaac.GetItemIdByName("Disability Papers")
CollectibleType.COLLECTIBLE_DISABILITY_PAPERS = Isaac.GetItemIdByName("Disability Papers")

function Disability_Papers:postUpdate()
end

return Disability_Papers