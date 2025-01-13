function onRender(player, offer)
    local hasMount = player:hasMount(offer:getName())
    local isPremium = player:isPremium()
    local enabled = not hasMount
    
    if not isPremium then
        enabled = false
    end
    
    local reason = ""
    if hasMount then
        reason = "You already have " .. offer:getName() .. " Mount."
    elseif not isPremium then
        reason = "This mount requires a Premium account. Please purchase Premium time first."
    end
    
    return enabled, reason
end

function onBuy(player, offer)
    if player:hasMount(offer:getName()) then
        player:sendStoreError(STORE_ERROR_PURCHASE, "You already have this mount!")
        return false
    end
    
    if not player:isPremium() then
        player:sendStoreError(STORE_ERROR_PURCHASE, "This mount requires a Premium account. Please purchase Premium time first.")
        return false
    end
    
    local success = player:addMount(offer:getName())
    if not success then
        player:sendStoreError(STORE_ERROR_PURCHASE, "Mount '" .. offer:getName() .. "' was not found. Please contact the administrator.")
        return false
    end
    
    return true
end