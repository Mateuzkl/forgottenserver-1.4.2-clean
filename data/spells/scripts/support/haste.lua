local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 33000)
condition:setFormula(0.3, -24, 0.3, -24)
combat:addCondition(condition)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end

    if not player:hasBuff(BUFF_UTANI_HUR) then
        print("[DEBUG] Aplicando BUFF_UTANI_HUR ao jogador: " .. player:getName())
        player:addBuff(BUFF_UTANI_HUR)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Você recebeu o Buff Utani Hur!")
    else
        print("[DEBUG] BUFF_UTANI_HUR já está ativo no jogador: " .. player:getName())
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "O Buff Utani Hur já está ativo!")
    end

    return combat:execute(creature, variant)
end