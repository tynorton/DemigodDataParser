#################################################################################################################
# Chest / Breastplate
# Shop and costs defined in //depot/forge/main/bindata/units/ug/b/ugbshop02/UGBShop02_unit.bp
#################################################################################################################
local Buff = import('/lua/sim/buff.lua')

#################################################################################################################
# Scalemail
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Chest_010',
    DisplayName = '<LOC ITEM_Chest_0000>Scalemail',
    GetArmorBonus = function(self) return Buffs['Item_Chest_010'].Affects.Armor.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0001>+[GetArmorBonus] Armor',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Chest/Chest4',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Chest_010',
            AbilityType = 'Quiet',
            FromItem = 'Item_Chest_010',
            Icon = 'NewIcons/Chest/Chest4',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Chest_010',
                    BuffType = 'CHESTARMOR',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Armor = {Add = 600},
                    },
                    Effects = 'Protection01',
                }
            },
        }
    },
}

#################################################################################################################
# Banded Armor
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Chest_020',
    DisplayName = '<LOC ITEM_Chest_0002>Banded Armor',
    GetHealthBonus = function(self) return Buffs['Item_Chest_020'].Affects.MaxHealth.Add end,
    GetRegenBonus = function(self) return Buffs['Item_Chest_020'].Affects.Regen.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0003>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Chest/Chest1',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Chest_020',
            AbilityType = 'Quiet',
            Icon = 'NewIcons/Chest/Chest1',
            FromItem = 'Item_Chest_020',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Chest_020',
                    BuffType = 'CHESTHEALTH',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 400, AdjustEnergy = false},
                        Regen = {Add = 5},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Nimoth Chest Armor
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Chest_030',
    DisplayName = '<LOC ITEM_Chest_0004>Nimoth Chest Armor',
    GetHealthBonus = function(self) return Buffs['Item_Chest_030'].Affects.MaxHealth.Add end,
    GetArmorBonus = function(self) return Buffs['Item_Chest_030'].Affects.Armor.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0003>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0001>+[GetArmorBonus] Armor',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Chest/Chest8',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Chest_030',
            AbilityType = 'Quiet',
            FromItem = 'Item_Chest_030',
            Icon = 'NewIcons/Chest/Chest8',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Chest_030',
                    BuffType = 'CHESTEVASION',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 500, AdjustEnergy = false},
                        Armor = {Add = 750},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Hauberk of Life
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Chest_040',
    DisplayName = '<LOC ITEM_Chest_0006>Hauberk of Life',
    GetHealthBonus = function(self) return Buffs['Item_Chest_040'].Affects.MaxHealth.Add end,
    GetRegenBonus = function(self) return Buffs['Item_Chest_040'].Affects.Regen.Add end,
    GetMinionHealthBonus = function(self) return Buffs['Item_Chest_040_Minion_Buff'].Affects.MaxHealth.Add end,
    GetMinionRegenBonus = function(self) return Buffs['Item_Chest_040_Minion_Buff'].Affects.Regen.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0024>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
        },
        MBonuses = {
            '<LOC MBONUS_0000>+[GetMinionHealthBonus] Minion Health',
            '<LOC MBONUS_0002>+[GetMinionRegenBonus] Minion Health Per Second',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Chest/Chest3',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Chest_040',
            AbilityType = 'Quiet',
            FromItem = 'Item_Chest_040',
            Icon = 'NewIcons/Chest/Chest3',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Chest_040',
                    BuffType = 'CHESTHEALTH',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 600, AdjustEnergy = false},
                        Regen = {Add = 10},
                    },
                    Effects = 'SingleRing01',
                    EffectsBone = -1,
                },
            },
        },
        AbilityBlueprint {
            Name = 'Item_Chest_040_Minion',
            AbilityType = 'Quiet',
            Icon = 'NewIcons/Chest/Chest3',
            FromItem = 'Item_Chest_040',
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Chest_040_Minion_Buff', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus('Item_Chest_040_Minion_Buff', unit )
            end,
        },
    },
}

#################################################################################################################
# Buff: Hauberk of Life
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'Item_Chest_040_Minion_Buff',
    DisplayName = '<LOC ITEM_Chest_0006>Hauberk of Life',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Chest_040_Minion_Buff',
            BuffType = 'CHEST040MINIONHEALTH',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Icon = 'NewIcons/Chest/Chest3',
            Affects = {
                MaxHealth = {Add = 200, AdjustEnergy = false},
                Regen = {Add = 3},
            },
        }
    }
}
#################################################################################################################
# Armor of Vengeance
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Chest_050',
    DisplayName = '<LOC ITEM_Chest_0008>Armor of Vengeance',
    GetArmorBonus = function(self) return Buffs['Item_Chest_050'].Affects.Armor.Add end,
    GetThorns = function(self) return Buffs['Item_Chest_050'].Affects.DamageReturn.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0009>+[GetArmorBonus] Armor',
        },
        Passives = '<LOC ITEM_Chest_0030>When struck by melee and ranged attacks, wearers of this mystical armor reflect [GetThorns] damage back to the attacker.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Chest/Chest2',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Chest_050',
            AbilityType = 'Quiet',
            FromItem = 'Item_Chest_050',
            Icon = 'NewIcons/Chest/Chest2',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Chest_050',
                    BuffType = 'ENCHANTPOWER',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Armor = {Add = 1050},
                        DamageReturn = {Add = 35},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Platemail of the Crusader
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Chest_060',
    DisplayName = '<LOC ITEM_Chest_0010>Platemail of the Crusader',
    GetArmorBonus = function(self) return Buffs['Item_Chest_060'].Affects.Armor.Add end,
    GetRegenBonus = function(self) return Buffs['Item_Chest_060'].Affects.Regen.Add end,
    GetProcChance = function(self) return Ability['Item_Chest_060_WeaponProc'].ArmorProcChance end,
    GetHealthProc = function(self) return Buffs['Item_Chest_060_Heal'].Affects.Health.Add end,
    GetMinionHealthBonus = function(self) return Buffs['Item_Chest_060_Minion_Buff'].Affects.MaxHealth.Add end,
    GetMinionRegenBonus = function(self) return Buffs['Item_Chest_060_Minion_Buff'].Affects.Regen.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0034>+[GetRegenBonus] Health Per Second',
            '<LOC ITEM_Chest_0009>+[GetArmorBonus] Armor',
        },
        MBonuses = {
            '<LOC MBONUS_0000>+[GetMinionHealthBonus] Minion Health',
            '<LOC MBONUS_0002>+[GetMinionRegenBonus] Minion Health Per Second',
        },
        ChanceOnHit = '<LOC ITEM_Chest_0035>[GetProcChance]% chance on being hit to heal [GetHealthProc] Health',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Chest/Chest6',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Chest_060',
            AbilityType = 'Quiet',
            FromItem = 'Item_Chest_060',
            Icon = 'NewIcons/Chest/Chest6',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Chest_060',
                    Debuff = false,
                    BuffType = 'RINGARMOR',
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Armor = {Add = 1000},
                        Regen = {Add = 20},
                    },
                    Effects = 'Protection01',
                }
            },
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Chest_060_Minion_Buff', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus('Item_Chest_060_Minion_Buff', unit )
            end,
        },

        AbilityBlueprint {
            Name = 'Item_Chest_060_WeaponProc',
            AbilityType = 'ArmorProc',
            FromItem = 'Item_Chest_060',
            Icon = 'NewIcons/Chest/Chest6',
            ArmorProcChance = 1,
            OnArmorProc = function(self, unit)
                Buff.ApplyBuff(unit, 'Item_Chest_060_Heal', unit)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Breastplate.PlatemailOfTheCrusaderProc, -2 )
            end,
        }
    },
}

BuffBlueprint {
    Name = 'Item_Chest_060_Heal',
    BuffType = 'ITEM_CHEST_060_HEAL',
    Debuff = false,
    Stacks = 'REPLACE',
    DamageSelf = true,
    IgnoreDamageRangePercent = true,
    CanBeEvaded = false,
    CanBackfire = false,
    DamageFriendly = true,
    ArmorImmune = true,
    CanCrit = false,
    CanMagicResist = false,
    Duration = 0,
    Affects = {
        Health = {Add = 300},
    },
    #Icon = 'NewIcons/Boots/Boot3',
}

#################################################################################################################
# Buff: Platemail of the Crusader
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'Item_Chest_060_Minion_Buff',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Chest_060_Minion_Buff',
            BuffType = 'CHEST060MINIONHEALTH',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Affects = {
                MaxHealth = {Add = 250, AdjustEnergy = false},
                Regen = {Add = 4},
            },
        }
    }
}

#################################################################################################################
# Groffling Warplate
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Chest_070',
    DisplayName = '<LOC ITEM_Chest_0013>Groffling Warplate',

    GetArmorProcRate = function(self) return Ability['Item_Chest_070_WeaponProc'].ArmorProcChance end,
    GetArmorProcDuration = function(self) return Buffs['Item_Chest_070_Invincible'].Duration end,
    GetArmorProcBuff = function(self) return Buffs['Item_Chest_070_Invincible'].Affects.Absorption.Add end,
    GetHealthBonus = function(self) return Buffs['Item_Chest_070'].Affects.MaxHealth.Add end,
    GetArmorBonus = function(self) return Buffs['Item_Chest_070'].Affects.Armor.Add end,

    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0041>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0042>+[GetArmorBonus] Armor',
        },
        ChanceOnHit = '<LOC ITEM_Chest_0043>[GetArmorProcRate]% chance on being hit to gain a shield that absorbs [GetArmorProcBuff] damage for [GetArmorProcDuration] seconds.\n\nOnly one absorption effect may be active at a time.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Chest/Chest7',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Chest_070',
            AbilityType = 'Quiet',
            FromItem = 'Item_Chest_070',
            Icon = 'NewIcons/Chest/Chest7',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Chest_070',
                    BuffType = 'ENCHANTHEALTH',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 675, AdjustEnergy = false},
                        Armor = {Add = 1200},
                    },
                }
            },
        },
        AbilityBlueprint {
            Name = 'Item_Chest_070_WeaponProc',
            AbilityType = 'ArmorProc',
            FromItem = 'Item_Chest_070',
            Icon = 'NewIcons/Chest/Chest7',
            ArmorProcChance = 1,
            OnArmorProc = function(self, unit)
                Buff.ApplyBuff(unit, 'Item_Chest_070_Invincible', unit)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Breastplate.NuadusWarplateProc, -2 )
            end,
        }
    },
}

BuffBlueprint {
    Name = 'Item_Chest_070_Invincible',
    DisplayName = '<LOC ITEM_Chest_0013>Groffling Warplate',
    Description = '<LOC ITEM_Chest_0015>Absorbing damage.',
    BuffType = 'ITEM_CHEST_070_INVINCIBLE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {
         Absorption = { Add = 300 },
    },
    OnBuffAffect = function(self, unit, instigator)
    #    unit:SetInvulnerableMesh(true)
		AttachBuffEffectAtBone( unit, 'ShieldActivate01', -2 );
    end,
    OnBuffRemove = function(self, unit )
		AttachBuffEffectAtBone( unit, 'ShieldDeactivate01', -2 );
    #    unit:SetInvulnerableMesh(false)
    end,
    Icon = 'NewIcons/Chest/Chest7',
}

#################################################################################################################
# Godplate
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Chest_080',
    DisplayName = '<LOC ITEM_Chest_0016>Godplate',
    GetHealthBonus = function(self) return Buffs['Item_Chest_080'].Affects.MaxHealth.Add end,
    GetArmorBonus = function(self) return Buffs['Item_Chest_080'].Affects.Armor.Add end,
    GetRegenBonus = function(self) return Buffs['Item_Chest_080'].Affects.Regen.Add end,
    GetMinionHealthBonus = function(self) return Buffs['Item_Chest_080_Minion_Buff'].Affects.MaxHealth.Add end,
    GetMinionArmorBonus = function(self) return Buffs['Item_Chest_080_Minion_Buff'].Affects.Armor.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0053>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0054>+[GetArmorBonus] Armor',
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
        },
        MBonuses = {
            '<LOC MBONUS_0000>+[GetMinionHealthBonus] Minion Health',
            '<LOC MBONUS_0003>+[GetMinionArmorBonus] Minion Armor',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Chest/Chest9',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Chest_080',
            AbilityType = 'Quiet',
            FromItem = 'Item_Chest_080',
            Icon = 'NewIcons/Chest/Chest9',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Chest_080',
                    BuffType = 'ENCHANTRETRIBUTION',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 1050, AdjustEnergy = false},
                        Armor = {Add = 1200},
                        Regen = {Add = 20},
                    },
                }
            },
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Chest_080_Minion_Buff', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus('Item_Chest_080_Minion_Buff', unit )
            end,
        }
    },
}

#################################################################################################################
# Buff: Platemail of the Crusader
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'Item_Chest_080_Minion_Buff',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Chest_080_Minion_Buff',
            BuffType = 'CHEST080MINIONHEALTH',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Affects = {
                MaxHealth = {Add = 275, AdjustEnergy = false},
                Armor = {Add = 300},
            },
        }
    }
}

#################################################################################################################
# Duelist's Cuirass
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Chest_090',
    DisplayName = '<LOC ITEM_Chest_0057>Duelist\'s Cuirass',
    GetArmorBonus = function(self) return Buffs['Item_Chest_090'].Affects.Armor.Add end,
    MaxHealth = function(self) return Buffs['Item_Chest_090'].Affects.MaxHealth.Add end,
    GetCritChance = function(self) return Ability['Item_Chest_090_Crit'].CritChance end,
    GetCritDamage = function(self) return Ability['Item_Chest_090_Crit'].CritMult end,
    Tooltip = {
        Bonuses = {  
            '<LOC ITEM_Chest_0058>+[MaxHealth] Armor',
            '<LOC ITEM_Chest_0059>+[GetArmorBonus] Health',
        },
        Passives = '<LOC ITEM_Chest_0060>[GetCritChance]% chance deal a critical strike for [GetCritDamage]x damage.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Chest/Chest5',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Chest_090',
            AbilityType = 'Quiet',
            FromItem = 'Item_Chest_090',
            Icon = 'NewIcons/Chest/Chest5',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Chest_090',
                    BuffType = 'ENCHANTPOWER',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Armor = {Add = 500},
                        MaxHealth = {Add = 350, AdjustEnergy = false},
                    },
                }
            },
        },
        AbilityBlueprint {
            Name = 'Item_Chest_090_Crit',
            AbilityType = 'WeaponCrit',
            CritChance = 5,
            CritMult = 1.5,
        },
    },
}

__moduleinfo.auto_reload = true
