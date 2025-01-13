local outfits = {}

-- Load outfits from XML
local function loadOutfits()
    for line in io.lines('data/XML/outfits.xml') do
        local lookType = tonumber(line:match('looktype.-=[\'"](.-)[\'"]'))
        local name = line:match('name.-=[\'"](.-)[\'"]')
        local enabled = line:match('enabled.-=[\'"](.-)[\'"]') == 'yes'

        if enabled and name and lookType then
            outfits[name:lower()] = lookType
        end
    end
end
loadOutfits()

local function hasOutfitOrAddon(player, lookType, addonNumber)
    if not lookType then return false end
    
    if addonNumber > 0 then
        return player:hasOutfit(lookType, addonNumber)
    end
    
    if player:hasOutfit(lookType, 1) and player:hasOutfit(lookType, 2) then
        return true
    end
    
    return false
end

local function parseOutfitName(outfitName)
    outfitName = outfitName:lower()
    
    local baseName = outfitName:gsub("full ", ""):gsub(" outfit", "")
    
    local addonNumber = tonumber(outfitName:match("addon (%d+)")) or 0
    baseName = baseName:gsub("addon %d+", ""):trim()
    
    return outfits[baseName], addonNumber
end

function onRender(player, offer)
    local lookType, addonNumber = parseOutfitName(offer:getName())
    
    if not lookType then
        return false, "Outfit not found!"
    end
    
    if hasOutfitOrAddon(player, lookType, addonNumber) then
        return false, "You already own this outfit or addon!"
    end
    
    return true
end

function onBuy(player, offer)
    local lookType, addonNumber = parseOutfitName(offer:getName())
    
    if not lookType then
        player:sendStoreError(STORE_ERROR_PURCHASE, "Outfit not found!")
        return false
    end
    
    if hasOutfitOrAddon(player, lookType, addonNumber) then
        player:sendStoreError(STORE_ERROR_PURCHASE, "You already own this outfit or addon!")
        return false
    end
    
    if not player:hasOutfit(lookType, 0) then
        player:addOutfit(lookType)
    end
    
    if offer:getName():lower():find("full") then
        player:addOutfitAddon(lookType, 1)
        player:addOutfitAddon(lookType, 2)
    elseif addonNumber > 0 then
        player:addOutfitAddon(lookType, addonNumber)
    end
    
    -- Purchase log
    local file = io.open("data/logs/outfit_purchases.log", "a")
    if file then
        local log = string.format("[%s] Player: %s, Outfit: %s, LookType: %d, Addon: %d",
            os.date(), player:getName(), offer:getName(), lookType, addonNumber)
        file:write(log .. "\n")
        file:close()
    end
    
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Outfit/addon added successfully!")
    return true
end