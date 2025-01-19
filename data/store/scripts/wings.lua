-- Wing offers
local wingOffers = {
    ["wing1"] = 1,
    ["wing2"] = 2,
    ["wing3"] = 3,
    ["Fire Wings"] = 4
    -- Add more offers as needed
}

local function getWingID(offerName)
    return wingOffers[offerName]
end

local function playerHasWing(player, wingID)
    return player:getStorageValue(wingID) > 0
end

function onRender(player, offer)
    local wingID = getWingID(offer:getName())

    if not wingID then
        return false, 'Wing ID for "' .. offer:getName() .. '" was not found. Please contact the administrator.'
    end

    if playerHasWing(player, wingID) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You already have the wing "' .. offer:getName() .. '".')
        return false, "You already have this wing!"
    end

    return true
end

function onBuy(player, offer)
    local wingID = getWingID(offer:getName())

    if not wingID then
        return false, 'Wing ID for "' .. offer:getName() .. '" was not found. Please contact the administrator.'
    end

    if playerHasWing(player, wingID) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You already have the wing "' .. offer:getName() .. '".')
        return false, "You already have this wing!"
    end

    player:addWings(wingID) -- Assuming 'addWing' is the function to add a wing to the player
    player:setStorageValue(wingID, 1) -- Update storage to indicate the player has this wing
    player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have received the ' .. offer:getName() .. ' wing!')

    -- Simplified success message
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Thank you for your purchase! Your new wing "' .. offer:getName() .. '" is now available.')

    return true
end
