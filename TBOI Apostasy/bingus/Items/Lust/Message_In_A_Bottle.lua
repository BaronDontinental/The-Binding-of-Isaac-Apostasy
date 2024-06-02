local Message_In_A_Bottle = {}
local game = Game()

mod.COLLECTIBLE_MESSAGE_IN_A_BOTTLE = Isaac.GetItemIdByName("Message In A Bottle")
CollectibleType.COLLECTIBLE_MESSAGE_IN_A_BOTTLE = Isaac.GetItemIdByName("Message In A Bottle")

function Message_In_A_Bottle:postUpdate()
end

return Message_In_A_Bottle