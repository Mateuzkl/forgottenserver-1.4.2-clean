BUFFS = {
    [BUFF_EXAMPLE] = {
        id = BUFF_EXAMPLE,
        name = "Example Buff",
        description = "This is an example buff for testing purposes.",
        icon = "buff_example",
        border = "buff_example_border",
        stacked = false,
        maxStacks = 1,
        ticks = -1
    },
    [BUFF_UTANI_HUR] = {
        id = BUFF_UTANI_HUR,
        name = "Haste",
        description = "Increases your speed temporarily.",
        icon = "buff_haste",
        border = "buff_haste_border",
        stacked = false,
        maxStacks = 1,
        ticks = 30000
    },
    [BUFF_EXURA] = {
        id = BUFF_EXURA,
        name = "Light Healing",
        description = "Restores a small amount of health instantly.",
        icon = "buff_light_healing",
        border = "buff_light_healing_border",
        stacked = false,
        maxStacks = 1,
        ticks = 1000
    },
    [BUFF_UTANI_GRAN_HUR] = {
        id = BUFF_UTANI_GRAN_HUR,
        name = "Strong Haste",
        description = "Greatly increases your speed temporarily.",
        icon = "buff_strong_haste",
        border = "buff_strong_haste_border",
        stacked = false,
        maxStacks = 1,
        ticks = 30000
    },
    [BUFF_UTAMO_VITA] = {
        id = BUFF_UTAMO_VITA,
        name = "Magic Shield",
        description = "Absorbs incoming damage using mana instead of health.",
        icon = "buff_cosmic_insight",
        border = "buff_cosmic_insight",
        stacked = false,
        maxStacks = 1,
        ticks = 60000
    },
    [BUFF_UTITO_TEMPO] = {
        id = BUFF_UTITO_TEMPO,
        name = "Blood Rage",
        description = "Increases your attack power at the cost of defense.",
        icon = "buff_blood_rage",
        border = "buff_blood_rage_border",
        stacked = false,
        maxStacks = 1,
        ticks = 30000
    },
    [BUFF_UTITO_TEMPO_SAN] = {
        id = BUFF_UTITO_TEMPO_SAN,
        name = "Sharpshooter",
        description = "Increases your accuracy and ranged attack power.",
        icon = "buff_sharpshooter",
        border = "buff_sharpshooter_border",
        stacked = false,
        maxStacks = 1,
        ticks = 30000
    },
    [BUFF_EXURA_GRAN] = {
        id = BUFF_EXURA_GRAN,
        name = "Intense Healing",
        description = "Restores a moderate amount of health instantly.",
        icon = "buff_intense_healing",
        border = "buff_intense_healing_border",
        stacked = false,
        maxStacks = 1,
        ticks = 1000
    },
    [BUFF_EXURA_VITA] = {
        id = BUFF_EXURA_VITA,
        name = "Ultimate Healing",
        description = "Restores a large amount of health instantly.",
        icon = "buff_ultimate_healing",
        border = "buff_ultimate_healing_border",
        stacked = false,
        maxStacks = 1,
        ticks = 1000
    }
}

DEBUFFS = {
}

-- Registrar buffs com depuração
for _, buff in pairs(BUFFS) do
    print(string.format("Registrando buff: ID=%d, Name=%s, Ticks=%d", buff.id, buff.name, buff.ticks))
    Game.registerBuffType(buff.id, buff.name, buff.description, buff.icon, buff.border, buff.stacked, buff.maxStacks, buff.ticks, false)
    print(string.format("Buff registrado com sucesso: %s", buff.name))
end

-- Registrar debuffs com depuração
for _, debuff in pairs(DEBUFFS) do
    print(string.format("Registrando debuff: ID=%d, Name=%s, Ticks=%d", debuff.id, debuff.name, debuff.ticks))
    Game.registerBuffType(debuff.id, debuff.name, debuff.description, debuff.icon, debuff.border, debuff.stacked, debuff.maxStacks, debuff.ticks, true)
    print(string.format("Debuff registrado com sucesso: %s", debuff.name))
end