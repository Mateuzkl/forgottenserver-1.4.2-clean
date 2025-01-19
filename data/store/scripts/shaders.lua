-- Shader offers
local shaderOffers = {
    ["Rainbow Outfit"] = 1,
    ["Brazil Outfit"] = 2,
    ["Gold Outfit"] = 3,
    ["Sweden Outfit"] = 4,
    ["Polska Outfit"] = 5,
    ["Stars Outfit"] = 6,
    ["Rainbow Outline"] = 7,
    ["Dual Outfit"] = 8,
    ["Red Outline"] = 9,
    ["Slim Outline"] = 10,
    ["Line Outline"] = 11,
    ["Retro Outline"] = 12,
    ["Circle Outfit"] = 13,
    ["Outline Rainbow"] = 14
    -- Add more offers as needed
}

local function getShaderID(offerName)
    return shaderOffers[offerName]
end

local function playerHasShader(player, shaderID)
    return player:getStorageValue(shaderID) > 0
end

function onRenderShader(player, offer)
    local shaderID = getShaderID(offer:getName())

    if not shaderID then
        return false, 'Shader ID for "' .. offer:getName() .. '" was not found. Please contact the administrator.'
    end

    if playerHasShader(player, shaderID) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You already have the shader "' .. offer:getName() .. '".')
        return false, "You already have this shader!"
    end

    return true
end

function onBuyShader(player, offer)
    local shaderID = getShaderID(offer:getName())

    if not shaderID then
        return false, 'Shader ID for "' .. offer:getName() .. '" was not found. Please contact the administrator.'
    end

    if playerHasShader(player, shaderID) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You already have the shader "' .. offer:getName() .. '".')
        return false, "You already have this shader!"
    end

    player:addShader(shaderID)
    player:setStorageValue(shaderID, 1) -- Update storage to indicate the player has this shader
    player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have received the ' .. offer:getName() .. ' shader!')

    -- Simplified success message
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Thank you for your purchase! Your new shader "' .. offer:getName() .. '" is now available.')

    return true
end
