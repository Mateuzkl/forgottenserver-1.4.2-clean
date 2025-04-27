#ifndef BUFF_H
#define BUFF_H

#include "enums.h"
#include "tools.h"

class Creature;
class Player;

enum BuffId_t : uint8_t {
    BUFF_NONE = 0,          // Sempre bom ter um valor nulo
    BUFF_EXAMPLE = 1,       // Exemplo que você já tinha
    BUFF_UTANI_HUR = 2,     // Haste (utani hur)
    BUFF_EXURA = 3,         // Light Healing (exura)
    BUFF_UTANI_GRAN_HUR = 4, // Strong Haste (utani gran hur)
    BUFF_UTAMO_VITA = 5,    // Magic Shield (utamo vita)
    BUFF_UTITO_TEMPO = 6,   // Blood Rage (utito tempo)
    BUFF_UTITO_TEMPO_SAN = 7, // Sharpshooter (utito tempo san)
    BUFF_EXURA_GRAN = 8,    // Intense Healing (exura gran)
    BUFF_EXURA_VITA = 9,    // Ultimate Healing (exura vita)
    BUFF_LAST               // Marcador do último (mantém sempre no final)
};

class BuffType
{

public:
	BuffType() = default;
	BuffType(BuffId_t buffId, std::string buffName, std::string buffDescription, std::string buffIcon, std::string buffBorder, bool buffStacked, uint8_t buffMaxStacks, int32_t buffTicks, bool buffDebuff = false) :
		id(buffId), name(std::move(buffName)), description(std::move(buffDescription)), icon(std::move(buffIcon)), border(std::move(buffBorder)), stacked(buffStacked), maxStacks(buffMaxStacks), ticks(buffTicks),
		debuff(buffDebuff) {};
	virtual ~BuffType() = default;

	void setId(BuffId_t value) {
		id = value;
	}
	BuffId_t getId() const {
		return id;
	}

	void setName(std::string value) {
		name = value;
	}
	const std::string& getName() const {
		return name;
	}

	void setDescription(std::string value) {
		description = value;
	}
	const std::string& getDescription() const {
		return description;
	}

	void setIcon(std::string value) {
		icon = value;
	}
	const std::string& getIcon() const {
		return icon;
	}

	void setBorder(std::string value) {
		border = value;
	}
	const std::string& getBorder() const {
		return border;
	}

	void setStacked(bool value) {
		stacked = value;
	}
	bool isStacked() const {
		return stacked;
	}

	void setMaxStacks(uint8_t value) {
		maxStacks = value;
	}
	uint8_t getMaxStacks() const {
		return maxStacks;
	}

	void setTicks(int32_t value) {
		ticks = value;
	}
	int32_t getTicks() const {
		return ticks;
	}

	void setDebuff(bool value) {
		debuff = value;
	}
	bool isDebuff() const {
		return debuff;
	}

protected:
	BuffId_t id;

	std::string name;
	std::string description;
	std::string icon;
	std::string border;

	bool debuff = false;
	bool stacked;
	uint8_t maxStacks;

	int32_t ticks;
};

class Buff
{

public:
	Buff() = default;
	Buff(const BuffType& type) : id(type.getId()), stacks(1), ticks(type.getTicks()), endTime(ticks == -1 ? std::numeric_limits<int64_t>::max() : 0), startTicks(type.getTicks()), debuff(type.isDebuff()) {};
	virtual ~Buff() = default;

	bool executeBuff(Creature* creature, int32_t interval);
	void endBuff(Creature* creature);
	void startBuff(Creature* creature);

	void setId(BuffId_t value) {
		id = value;
	}
	BuffId_t getId() const {
		return id;
	}

	void setStacks(uint8_t value) {
		stacks = value;
		if (ticks != -1)
			refresh();
	}
	void addStacks(uint8_t value) {
		stacks += value;
		if (ticks != -1)
			refresh();
	}
	uint8_t getStacks() const {
		return stacks;
	}

	void setEndTime(int64_t value) {
		endTime = value;
	}
	int64_t getEndTime() const {
		return endTime;
	}

	void setTicks(int32_t value) {
		ticks = value;
		endTime = ticks + OTSYS_TIME();
	}
	int32_t getTicks() const {
		return ticks;
	}

	void refresh() {
		setTicks(startTicks);
	}

	void setDebuff(bool value) {
		debuff = value;
	}
	bool isDebuff() const {
		return debuff;
	}

	void setCaster(Creature* c) {
		caster = c;
	}
	Creature* getCaster() const {
		return caster;
	}

	const BuffType& getType() const;

protected:
	BuffId_t id;

	uint8_t stacks;

	int64_t endTime;
	int32_t startTicks;
	int32_t ticks;

	bool debuff = false;

	Creature* caster = nullptr;
};

#endif
