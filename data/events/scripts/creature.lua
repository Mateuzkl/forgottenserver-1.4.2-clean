function Creature:onChangeOutfit(outfit)
	if hasEventCallback(EVENT_CALLBACK_ONCHANGEMOUNT) then
		if not EventCallback(EVENT_CALLBACK_ONCHANGEMOUNT, self, outfit.lookMount) then
			return false
		end
	end
	if hasEventCallback(EVENT_CALLBACK_ONCHANGEOUTFIT) then
		return EventCallback(EVENT_CALLBACK_ONCHANGEOUTFIT, self, outfit)
	else
		return true
	end
end

function Creature:onAreaCombat(tile, isAggressive)
	if hasEventCallback(EVENT_CALLBACK_ONAREACOMBAT) then
		return EventCallback(EVENT_CALLBACK_ONAREACOMBAT, self, tile, isAggressive)
	else
		return RETURNVALUE_NOERROR
	end
end

function Creature:onTargetCombat(target)
	if hasEventCallback(EVENT_CALLBACK_ONTARGETCOMBAT) then
		return EventCallback(EVENT_CALLBACK_ONTARGETCOMBAT, self, target)
	else
		return RETURNVALUE_NOERROR
	end
end

function Creature:onHear(speaker, words, type)
	if hasEventCallback(EVENT_CALLBACK_ONHEAR) then
		EventCallback(EVENT_CALLBACK_ONHEAR, self, speaker, words, type)
	end
end

function Creature:onBuffAdded(buff)
	if hasEventCallback(EVENT_CALLBACK_BUFF_ADD) then
		EventCallback(EVENT_CALLBACK_BUFF_ADD, self, buff)
	end

	if self:isPlayer() then
		local buffData = {
			id = buff:getId(),
			name = buff:getName(),
			description = buff:getDescription(),
			icon = buff:getIcon(),
			border = buff:getBorder(),
			stacks = buff:getStacks(),
			ticks = buff:getTicks(),
			endTime = buff:getEndTime(),
			server_time = os.time(),
			debuff = buff:isDebuff()
		}
		self:sendExtendedOpcode(ExtendedOPCodes.CODE_BUFF, json.encode({action = "add", data = buffData}))
	end
end

function Creature:onBuffUpdated(buff)
	if hasEventCallback(EVENT_CALLBACK_BUFF_UPDATE) then
		EventCallback(EVENT_CALLBACK_BUFF_UPDATE, self, buff)
	end

	if self:isPlayer() then
		local buffData = {
			id = buff:getId(),
			icon = buff:getIcon(),
			stacks = buff:getStacks(),
			ticks = buff:getTicks(),
			endTime = buff:getEndTime(),
			server_time = os.time(),
			debuff = buff:isDebuff()
		}
		self:sendExtendedOpcode(ExtendedOPCodes.CODE_BUFF, json.encode({action = "update", data = buffData}))
	end
end

function Creature:onBuffRemoved(buff)
	if hasEventCallback(EVENT_CALLBACK_BUFF_REMOVE) then
		EventCallback(EVENT_CALLBACK_BUFF_REMOVE, self, buff)
	end

	if self:isPlayer() then
		local buffData = {
			id = buff:getId(),
			debuff = buff:isDebuff()
		}
		self:sendExtendedOpcode(ExtendedOPCodes.CODE_BUFF, json.encode({action = "remove", data = buffData}))
	end
end