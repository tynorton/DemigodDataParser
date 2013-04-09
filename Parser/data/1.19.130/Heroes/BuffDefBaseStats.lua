#################################################################
# Regulus
#################################################################
BuffBlueprint {
    Name = 'RegulusLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'RegulusLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 105, AdjustHealth = true},
        Armor = {Add = 31},
        MaxEnergy = {Add = 64, AdjustEnergy = true},
        RateOfFire = {Add = 0.017},
        DamageRating = {Add = 8.4},
        Regen = {Add = 0.166},
        EnergyRegen = {Add = 0.263},
    },
}

BuffBlueprint {
    Name = 'RegulusLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'RegulusLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 105},
       #Health = {Add = 21},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}

#################################################################
# Torch
#################################################################
BuffBlueprint {
    Name = 'TorchbearerLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'TorchbearerLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 110, AdjustHealth = true},
        Armor = {Add = 30},
        MaxEnergy = {Add = 150, AdjustEnergy = true},
        RateOfFire = {Add = 0.013},
        DamageRating = {Add = 9.2},
        Regen = {Add = 0.153},
        EnergyRegen = {Add = 0.463},
    },
}

BuffBlueprint {
    Name = 'TorchbearerLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'TorchbearerLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 150},
       #Health = {Add = 36},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}

#################################################################
# Rook
#################################################################
BuffBlueprint {
    Name = 'RookLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'RookLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 150, AdjustHealth = true},
        RateOfFire = {Add = 0.0146},
        Armor = {Add = 22},
        MaxEnergy = {Add = 87, AdjustEnergy = true},
        DamageRating = {Add = 10.1},
        Regen = {Add = 0.306},
        EnergyRegen = {Add = 0.288},
    },
}

BuffBlueprint {
    Name = 'RookLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'RookLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 87},
       #Health = {Add = 72},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}

#################################################################
# Unclean Beast
#################################################################
BuffBlueprint {
    Name = 'UncleanBeastLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'UncleanBeastLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 135, AdjustHealth = true},
        RateOfFire = {Add = 0.0166},
        Armor = {Add = 32},
        MaxEnergy = {Add = 104, AdjustEnergy = true},
        DamageRating = {Add = 6.5},
        Regen = {Add = 0.18},
        EnergyRegen = {Add = 0.32},
    },
}

BuffBlueprint {
    Name = 'UncleanBeastLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'UncleanBeastLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 104},
       #Health = {Add = 57},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}

#################################################################
# Oak
#################################################################
BuffBlueprint {
    Name = 'OakLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'OakLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 140, AdjustHealth = true},
        RateOfFire = {Add = 0.012},
        Armor = {Add = 25},
        MaxEnergy = {Add = 65, AdjustEnergy = true},
        DamageRating = {Add = 8.2},
        Regen = {Add = 0.253},
        EnergyRegen = {Add = 0.2},
    },
}

BuffBlueprint {
    Name = 'OakLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'OakLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 62},
       #Health = {Add = 60},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}

#################################################################
# Sedna
#################################################################
BuffBlueprint {
    Name = 'SednaLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'SednaLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 115, AdjustHealth = true},
        Armor = {Add = 22},
        MaxEnergy = {Add = 100, AdjustEnergy = true},
        RateOfFire = {Add = 0.00917},
        DamageRating = {Add = 10},
        Regen = {Add = 0.288},
        EnergyRegen = {Add = 0.303},
    },
}

BuffBlueprint {
    Name = 'SednaLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'SednaLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 94},
       #Health = {Add = 27},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}

#################################################################
# Erebus / Vampire Lord
#################################################################
BuffBlueprint {
    Name = 'VampireLordLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'VampireLordLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 145, AdjustHealth = true},
        Armor = {Add = 35},
        MaxEnergy = {Add = 91, AdjustEnergy = true},
        RateOfFire = {Add = 0.0113},
        DamageRating = {Add = 8.9},
        Regen = {Add = 0.213},
        EnergyRegen = {Add = 0.280},
    },
}

BuffBlueprint {
    Name = 'VampireLordLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'VampireLordLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 86},
       #Health = {Add = 57},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}

#################################################################
# Queen
#################################################################
BuffBlueprint {
    Name = 'QueenLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'QueenLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 105, AdjustHealth = true},
        Armor = {Add = 25},
        MaxEnergy = {Add = 120, AdjustEnergy = true},
        RateOfFire = {Add = 0.0119},
        DamageRating = {Add = 9},
        Regen = {Add = 0.180},
        EnergyRegen = {Add = 0.320},
    },
}

BuffBlueprint {
    Name = 'QueenLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'QueenLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 104},
       #Health = {Add = 48},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}

#################################################################
# Oculus
#################################################################
BuffBlueprint {
    Name = 'OculusLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'OculusLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 120, AdjustHealth = true},
        Armor = {Add = 25},
        MaxEnergy = {Add = 118, AdjustEnergy = true},
        RateOfFire = {Add = 0.00917},
        DamageRating = {Add = 10},
        Regen = {Add = 0.236},
        EnergyRegen = {Add = 0.337},
    },
}

BuffBlueprint {
    Name = 'OculusLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'OculusLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 118},
       #Health = {Add = 120},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}

#################################################################
# Demon Assassin
#################################################################
BuffBlueprint {
    Name = 'DemonLevelUp',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'DemonLevelUp',
    Stacks = 'ALWAYS',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 125, AdjustHealth = true},
        Armor = {Add = 29},
        MaxEnergy = {Add = 100, AdjustEnergy = true},
        RateOfFire = {Add = 0.0168},
        DamageRating = {Add = 8.55},
        Regen = {Add = 0.201},
        EnergyRegen = {Add = 0.334},
    },
}

BuffBlueprint {
    Name = 'DemonLevelUpHealthEnergyGain',
    Debuff = false,
    BuffType = 'HEROLEVEL',
    DisplayName = 'DemonLevelUpHealthEnergyGain',
    Stacks = 'ALWAYS',
    Affects = {
        Energy = {Add = 100},
       #Health = {Add = 125},
    },
    DamageSelf = true,
    CanBeEvaded = false,
}