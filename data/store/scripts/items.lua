function onRender(player, offer)
    local itemType = ItemType(offer:getName())
    if itemType:getId() == 0 then
        return false, "Item not found. Please contact an administrator."
    end

    local state = tonumber(offer.state) or 0
    if state ~= 1 then
        return false, "This item is currently unavailable."
    end

    return true
end

function onBuy(player, offer, count)
    count = tonumber(count) or 1
    
    local itemType = ItemType(offer:getName())
    if not itemType or itemType:getId() == 0 then
        player:sendStoreError(STORE_ERROR_PURCHASE, "Item not found. Please contact an administrator.")
        return false
    end

    local storeInbox = player:getStoreInbox()
    if not storeInbox then
        player:sendStoreError(STORE_ERROR_PURCHASE, "Could not find your store inbox. Please try again later.")
        return false
    end

    if storeInbox:getCapacity() < 1 then
        player:sendStoreError(STORE_ERROR_PURCHASE, "Your store inbox is full. Please make room first.")
        return false
    end

    local bag = Game.createItem(2000, 1)
    if not bag then
        player:sendStoreError(STORE_ERROR_PURCHASE, "Could not create the bag.")
        return false
    end

    for i = 1, count do
        local item = Game.createItem(itemType:getId(), 1)
        if item then
            if not bag:addItem(itemType:getId(), 1) then
                player:sendStoreError(STORE_ERROR_PURCHASE, "Could not add items to the bag.")
                bag:remove()
                return false
            end
        else
            player:sendStoreError(STORE_ERROR_PURCHASE, "Could not create the items.")
            bag:remove()
            return false
        end
    end

    if storeInbox:addItemEx(bag, INDEX_WHEREEVER, FLAG_NOLIMIT) == RETURNVALUE_NOERROR then
        player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have received a bag containing %dx %s in your store inbox.", count, itemType:getName()))
        return true
    else
        bag:remove()
        player:sendStoreError(STORE_ERROR_PURCHASE, "Could not add the bag to your store inbox.")
        return false
    end
end