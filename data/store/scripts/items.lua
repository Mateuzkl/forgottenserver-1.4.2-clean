function onRender(player, offer)
    local itemType = ItemType(offer:getName())
    if itemType:getId() == 0 then
        return false, "Item not found. Please contact an administrator."
    end
    return true
end

function onBuy(player, offer)
    local itemType = ItemType(offer:getName())
    local storeInbox = player:getStoreInbox()
    if storeInbox then
        local emptySlots = storeInbox:getEmptySlots()
        if emptySlots >= 1 then
            local item = Game.createItem(itemType:getId(), 1)
            if not item then
                return false
            end

            item:setStoreItem(true)
            storeInbox:addItemEx(item)

            item:setStoreItem(false)
        else
            player:sendStoreError(STORE_ERROR_PURCHASE, "Please make sure you have free slots in your store inbox.")
            return false
        end
    else
        return false
    end

    return true
end
