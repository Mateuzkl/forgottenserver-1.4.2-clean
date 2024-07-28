-- Aura offers
local auraOffers = {
    ["Blue Aura"] = 1,
    ["Dark Aura"] = 2,
    ["War Bear"] = 3,
    ["Fire Aura"] = 4,
    ["Aura1"] = 5,
    ["Aura2"] = 6,
    ["Aura3"] = 7,
    ["Aura4"] = 8,
    ["Aura5"] = 9,
    ["Aura6"] = 10,
    ["Aura7"] = 11,
    ["Aura8"] = 12,
    ["Aura9"] = 13,
    ["Aura10"] = 14,
    ["Aura11"] = 15,
    ["Aura12"] = 16,
    ["Aura13"] = 17,
    ["Aura14"] = 18
    -- Add more offers as needed
}

local function getAuraID(offerName)
    return auraOffers[offerName]
end

local function playerHasAura(player, auraID)
    return player:getStorageValue(auraID) > 0
end

function onRender(player, offer)
    print("onRender called for offer:", offer:getName())
    local auraID = getAuraID(offer:getName())

    if not auraID then
        print('Aura ID for "' .. offer:getName() .. '" was not found.')
        return false, 'Aura ID for "' .. offer:getName() .. '" was not found. Please contact the administrator.'
    end

    if playerHasAura(player, auraID) then
        print("Player already has this aura.")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You already have the aura "' .. offer:getName() .. '".')
        return false, "You already have this aura!"
    end

    return true
end

function onBuy(player, offer)
    print("onBuy called for offer:", offer:getName())
    local auraID = getAuraID(offer:getName())

    if not auraID then
        print('Aura ID for "' .. offer:getName() .. '" was not found.')
        return false, 'Aura ID for "' .. offer:getName() .. '" was not found. Please contact the administrator.'
    end

    if playerHasAura(player, auraID) then
        print("Player already has this aura.")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You already have the aura "' .. offer:getName() .. '".')
        return false, "You already have this aura!"
    end

    player:addAura(auraID)
    player:setStorageValue(auraID, 1) -- Update storage to indicate the player has this aura
    print("Added aura to player:", auraID)
    player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have received the ' .. offer:getName() .. ' aura!')

    -- Simplified success message
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Thank you for your purchase! Your new aura "' .. offer:getName() .. '" is now available.')

    return true
end
