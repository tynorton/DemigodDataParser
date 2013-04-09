#################################################################################################################
# Boots
# Shop and costs defined in //depot/forge/main/bindata/units/ug/b/ugbshop01/UGBShop10_unit.bp
#################################################################################################################
local Buff = import('/lua/sim/Buff.lua')

#################################################################################################################
# Footman's Sabatons
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Boot_010',
    DisplayName = '<LOC ITEM_Boot_0000>Footman\'s Sabatons',
    GetHealthBonus = function(self) return Buffs['Item_Boot_010'].Affects.MaxHealth.Add end,
    GetManaBonus = function(self) return Buffs['Item_Boot_010'].Affects.MaxEnergy.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0003>+[GetHealthBonus] Health',
            '<LOC ITEM_Helm_0001>+[GetManaBonus] Mana',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Boots/Boot1',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Boot_010',
            AbilityType = 'Quiet',
            FromItem = 'Item_Boot_010',
            Icon = 'NewIcons/Boots/Boot1',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Boot_010',
                    BuffType = 'BOOTEVADE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 200, AdjustEnergy = false},
                        MaxEnergy = {Add = 260, AdjustEnergy = false},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Boots of Speed
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Boot_020',
    DisplayName = '<LOC ITEM_Boot_0002>Boots of Speed',
    GetMoveSpeedBonus = function(self) return math.floor( Buffs['Item_Boot_020'].Affects.MoveMult.Mult * 100 ) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Boot_0003>+[GetMoveSpeedBonus]% Movement Speed',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Boots/Boot2',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Boot_020',
            AbilityType = 'PassiveAll',
            FromItem = 'Item_Boot_020',
            Icon = 'NewIcons/Boots/Boot2',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Boot_020',
                    Debuff = false,
                    BuffType = 'BOOTSPEED',
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MoveMult = {Mult = 0.10},
                    },
                    Effects = 'RunSpeed01',
                }
            },
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Boot_020Army', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Boot_020Army', unit )
            end,
        }
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Boot_020Army',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Boot_020Army',
            BuffType = 'BOOTSPEED',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                MoveMult = {Mult = 0.10},
            },
        }
    }
}

#################################################################################################################
# Assassin's Footguards
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Boot_030',
    DisplayName = '<LOC ITEM_Boot_0004>Assassin\'s Footguards',
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['Item_Boot_030'].Affects.RateOfFire.Mult * 100 ) end,
    GetDodgeBonus = function(self) return Buffs['Item_Boot_030'].Affects.Evasion.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
            '<LOC ITEM_Boot_0013>+[GetDodgeBonus]% Dodge',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Boots/Boot7',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Boot_030',
            AbilityType = 'Quiet',
            FromItem = 'Item_Boot_030',
            Icon = 'NewIcons/Boots/Boot7',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Boot_030',
                    BuffType = 'BOOTEVADE2',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        RateOfFire = {Mult = 0.05},
                        Evasion = {Add = 10},
                    },
                    Effects = 'Protection01',
                    EffectsBone = -1,
                }
            },
        }
    },
}

#################################################################################################################
# Unbreakable Boots
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Boot_040',
    DisplayName = '<LOC ITEM_Boot_0006>Unbreakable Boots',
    GetHealthBonus = function(self) return Buffs['Item_Boot_040'].Affects.MaxHealth.Add end,
    GetRegenBonus = function(self) return Buffs['Item_Boot_040'].Affects.Regen.Add end,
    GetManaBonus = function(self) return Buffs['Item_Boot_040'].Affects.MaxEnergy.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0003>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
            '<LOC ITEM_Helm_0001>+[GetManaBonus] Mana',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Boots/Boot5',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Boot_040',
            AbilityType = 'Quiet',
            FromItem = 'Item_Boot_040',
            Icon = 'NewIcons/Boots/Boot5',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Boot_040',
                    BuffType = 'BOOTARMOR',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 600, AdjustEnergy = false},
                        Regen = {Add = 5},
                        MaxEnergy = {Add = 800, AdjustEnergy = false},
                    },
                    Effects = 'RunSpeed01',
                }
            },
        }
    },
}

#################################################################################################################
# Journeyman Treads
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Boot_050',
    DisplayName = '<LOC ITEM_Boot_0008>Journeyman Treads',
    GetHealthBonus = function(self) return Buffs['Item_Boot_050'].Affects.MaxHealth.Add end,
    GetMoveSpeedBonus = function(self) return math.floor( Buffs['Item_Boot_050'].Affects.MoveMult.Mult * 100 ) end,
    GetProcChance = function(self) return Ability['Item_Boot_050_WeaponProc'].ArmorProcChance end,
    GetProcMoveSpeedBonus = function(self) return math.floor( Buffs['Item_Boot_050_Wind'].Affects.MoveMult.Mult * 100 ) end,
    GetProcDuration = function(self) return Buffs['Item_Boot_050_Wind'].Duration end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Boot_0024>+[GetHealthBonus] Health',
            '<LOC ITEM_Boot_0025>+[GetMoveSpeedBonus]% Movement Speed',
        },
        ChanceOnHit = '<LOC ITEM_Boot_0026>[GetProcChance]% chance on being hit to increase Movement Speed by [GetProcMoveSpeedBonus]% for [GetProcDuration] seconds.'
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Boots/Boot3',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Boot_050',
            AbilityType = 'Quiet',
            FromItem = 'Item_Boot_050',
            Icon = 'NewIcons/Boots/Boot3',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Boot_050',
                    BuffType = 'RUNESPEED',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 400, AdjustEnergy = false},
                        MoveMult = {Mult = 0.15},
                    },
                }
            },
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Boot_050Army', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Boot_050Army', unit )
            end,
        },
        AbilityBlueprint {
            Name = 'Item_Boot_050_WeaponProc',
            DisplayName = '<LOC ITEM_Boot_0008>Journeyman Treads',
            AbilityType = 'ArmorProc',
            FromItem = 'Item_Boot_050',
            Icon = 'NewIcons/Boots/Boot3',
            ArmorProcChance = 5,
            OnArmorProc = function(self, unit)
                Buff.ApplyBuff(unit, 'Item_Boot_050_Wind', unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Boot_050_WindArmy', unit )
                AttachEffectsAtBone( unit, EffectTemplates.Items.Boot.JourneymanTreadsProc, -2 )
            end,
        }
    },
}

BuffBlueprint {
    Name = 'Item_Boot_050_Wind',
    DisplayName = '<LOC ITEM_Boot_0008>Journeyman Treads',
    Description = '<LOC ITEM_Boot_0010>Movement Speed increased.',
    BuffType = 'ITEM_BOOT_050_WIND',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {
        MoveMult = {Mult = 0.5},
    },
    Effects = 'Haste01',
    EffectsBone = -2,

    Icon = 'NewIcons/Boots/Boot3',
}

ArmyBonusBlueprint {
    Name = 'Item_Boot_050Army',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Boot_050Army',
            BuffType = 'RUNESPEED',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                MoveMult = {Mult = 0.15},
            },
        }
    }
}

ArmyBonusBlueprint {
    Name = 'Item_Boot_050_WindArmy',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Boot_050_WindArmy',
            BuffType = 'ITEM_BOOT_050_WIND',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 10,
            Affects = {
                MoveMult = {Mult = 0.5},
            },
        }
    }
}

#################################################################################################################
# Desperate Boots
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Boot_060',
    DisplayName = '<LOC ITEM_Boot_0027>Desperate Boots',
    GetHealthBonus = function(self) return Buffs['Item_Boot_060'].Affects.MaxHealth.Add end,
    GetManaBonus = function(self) return math.floor( Buffs['Item_Boot_060'].Affects.MaxEnergy.Add ) end,
    GetTriggerPercent = function(self) return math.floor(Ability['Item_Boot_060_Desperation'].HealthPercentTrigger * 100) end,
    GetEvasionPercent = function(self) return math.floor( Buffs['Item_Boot_060_Desperation'].Affects.Evasion.Add ) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0003>+[GetHealthBonus] Health',
            '<LOC ITEM_Helm_0001>+[GetManaBonus] Mana',
        },
        ChanceOnHit = '<LOC ITEM_Boot_0030>Whenever health is under [GetTriggerPercent]%, Dodge is increased by [GetEvasionPercent]%.'
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Boots/Boot6',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Boot_060',
            AbilityType = 'Quiet',
            FromItem = 'Item_Boot_060',
            Icon = 'NewIcons/Boots/Boot6',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Boot_060',
                    BuffType = 'ITEM_BOOT_060_BASE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 400, AdjustEnergy = false},
                        MaxEnergy = {Add = 350, AdjustEnergy = false},
                    },
                }
            },
        },
        AbilityBlueprint {
            Name = 'Item_Boot_060_Desperation',
            AbilityType = 'Aura',
            AffectRadius = 1,
            AuraPulseTime = 1,
            TargetAlliance = 'Ally',
            TargetCategory = 'HERO',
            HealthPercentTrigger = .30,
            OnAuraPulse = function(self, unit, params)
                if unit:GetHealth()/unit:GetMaxHealth() >= self.HealthPercentTrigger then
                    if Buff.HasBuff(unit, 'Item_Boot_060_Desperation') then
                        Buff.RemoveBuff(unit, 'Item_Boot_060_Desperation')
                    end
                else
                    Buff.ApplyBuff(unit, 'Item_Boot_060_Desperation', unit)
                end
            end,
        }
    },
}

BuffBlueprint {
    Name = 'Item_Boot_060_Desperation',
    DisplayName = '<LOC ITEM_Boot_0031>Desperate Boots',
    Description = '<LOC ITEM_Boot_0032>Evasion increased.',
    BuffType = 'ITEM_BOOT_060_EVASION',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Evasion = {Add = 20},
    },
    Effects = 'Haste01',
    EffectsBone = -2,
    Icon = 'NewIcons/Boots/Boot6',
}

#################################################################################################################
# Ironwalkers
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Boot_070',
    DisplayName = '<LOC ITEM_Boot_0033>Ironwalkers',
    GetMinionArmorBonus = function(self) return Buffs['Item_Boot_070_Minion_Armor'].Affects.Armor.Add end,
    GetMinionRegenBonus = function(self) return Buffs['Item_Boot_070_Minion_Armor'].Affects.Regen.Add end,
    GetTriggerAmount = function(self) return math.floor(Ability['Item_Boot_070'].TriggerAmount) end,
    GetArmorBonus = function(self) return math.floor( Buffs['Item_Boot_070_Armor'].Affects.Armor.Add ) end,
    Tooltip = {
        MBonuses = {
            '<LOC MBONUS_0002>+[GetMinionRegenBonus] Minion Health Per Second',
            '<LOC MBONUS_0003>+[GetMinionArmorBonus] Minion Armor',
        },
        ChanceOnHit = '<LOC ITEM_Boot_0035>Whenever Movement Speed is under [GetTriggerAmount], Armor is increased by [GetArmorBonus].',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Boots/Boot4',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Boot_070',
            AbilityType = 'Aura',
            AffectRadius = 1,
            AuraPulseTime = 1,
            TargetAlliance = 'Ally',
            TargetCategory = 'HERO',
            TriggerAmount = 5.5,
            Icon = 'NewIcons/Boots/Boot4',
            OnAuraPulse = function(self, unit, params)
                if unit.Sync.MovementSpeed > self.TriggerAmount then
                    if Buff.HasBuff(unit, 'Item_Boot_070_Armor') then
                        Buff.RemoveBuff(unit, 'Item_Boot_070_Armor')
                    end
                else
                    Buff.ApplyBuff(unit, 'Item_Boot_070_Armor', unit)
                end
            end,
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Boot_070_Minion_Armor', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Boot_070_Minion_Armor', unit )
            end,
        }
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Boot_070_Minion_Armor',
    DisplayName = '<LOC ITEM_Boot_0036>Ironwalkers',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Boot_070_Minion_Armor',
            BuffType = 'CHEST040MINIONHEALTH',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Icon = 'NewIcons/Boots/Boot4',
            Affects = {
                Regen = {Add = 3},
                Armor = {Add = 275},
            },
        }
    }
}

BuffBlueprint {
    Name = 'Item_Boot_070_Armor',
    DisplayName = '<LOC ITEM_Boot_0037>Ironwalkers',
    Description = '<LOC ITEM_Boot_0038>Armor increased.',
    BuffType = 'ITEM_BOOT_070_ARMOR',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Armor = {Add = 1000},
    },
    Icon = 'NewIcons/Boots/Boot4',
}

__moduleinfo.auto_reload = true