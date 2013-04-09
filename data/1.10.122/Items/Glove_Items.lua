#################################################################################################################
# Glove Items
# Shop and costs defined in //depot/forge/main/bindata/units/ug/b/ugbshop03/UGBShop03_unit.bp
#################################################################################################################
local Buff = import('/lua/sim/buff.lua')

#################################################################################################################
# Gauntlets of Brutality
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Glove_010',
    DisplayName = '<LOC ITEM_Glove_0000>Gauntlets of Brutality',
    GetDamageBonus = function(self) return Buffs['Item_Glove_010'].Affects.DamageRating.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0001>+[GetDamageBonus] Weapon Damage',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Hand/Hand1',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Glove_010',
            AbilityType = 'Quiet',
            FromItem = 'Item_Glove_010',
            Icon = 'NewIcons/Hand/Hand1',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Glove_010',
                    BuffType = 'ENCHANTDAMRADIUS',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 25},
                    },
                },
            },
        }
    },
}

#################################################################################################################
# Gladiator Gloves
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Glove_020',
    DisplayName = '<LOC ITEM_Glove_0002>Gladiator Gloves',
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['Item_Glove_020'].Affects.RateOfFire.Mult * 100 ) end,
    GetMinionDamageBonus = function(self) return Buffs['Item_Glove_020_Minion'].Affects.DamageRating.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
        },
        MBonuses = {
            '<LOC MBONUS_0004>+[GetMinionDamageBonus] Minion Damage',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Hand/Hand3',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Glove_020',
            AbilityType = 'Quiet',
            FromItem = 'Item_Glove_020',
            Icon = 'NewIcons/Hand/Hand3',
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Glove_020_Minion', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Glove_020_Minion', unit )
            end,
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Glove_020',
                    BuffType = 'RUNECRITCHANCE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        RateOfFire = {Mult = 0.05},
                    },
                }
            },
        }
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Glove_020_Minion',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Glove_020_Minion',
            BuffType = 'GLOVE20MINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Icon = 'NewIcons/Hand/Hand3',
            Affects = {
                DamageRating = {Add = 4},
            },
        }
    }
}

#################################################################################################################
# Gauntlets of Despair
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Glove_030',
    DisplayName = '<LOC ITEM_Glove_0004>Gauntlets of Despair',
    GetManaBonus = function(self) return Buffs['Item_Glove_030'].Affects.MaxEnergy.Add end,
    GetProcChance = function(self) return Ability['Item_Glove_030_WeaponProc'].WeaponProcChance end,
    GetProcDrain = function(self) return math.floor( Buffs['Item_Glove_030_Drain'].Affects.Energy.Add * -1 ) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0015>+[GetManaBonus] Mana',
        },
        ChanceOnHit = '<LOC ITEM_Glove_0017>[GetProcChance]% chance on hit to drain [GetProcDrain] Mana.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Hand/Hand5',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Glove_030',
            AbilityType = 'Quiet',
            FromItem = 'Item_Glove_030',
            Icon = 'NewIcons/Hand/Hand5',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Glove_030',
                    BuffType = 'ENCHANTCRITMULT',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxEnergy = {Add = 350, AdjustEnergy = false},
                        RateOfFire = {Mult = 0.08},
                    },
                }
            },
        },
        AbilityBlueprint {
            Name = 'Item_Glove_030_WeaponProc',
            AbilityType = 'WeaponProc',
            FromItem = 'Item_Glove_030',
            Icon = 'NewIcons/Hand/Hand6',
            WeaponProcChance = 15,
            WeaponProcChanceRanged = 10,
            OnWeaponProc = function(self, unit, target, damageData)
                if not target:IsDead() then
                    Buff.ApplyBuff(target, 'Item_Glove_030_Drain', unit)
                    AttachEffectsAtBone( unit, EffectTemplates.Items.Glove.GauntletsOfDespairProc, -2 )
                end
            end,
        }
    },
}

BuffBlueprint {
    Name = 'Item_Glove_030_Drain',
    BuffType = 'ITEM_GLOVE_030_DRAIN',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 0,
    Affects = {
        Energy = {Add = -100},
    },
    Effects = 'Manadrain01',
    EffectsBone = -2,
}

#################################################################################################################
# Wyrmskin Handguards
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Glove_040',
    DisplayName = '<LOC ITEM_Glove_0007>Wyrmskin Handguards',
    GetDamageBonus = function(self) return Buffs['Item_Glove_040'].Affects.DamageRating.Add end,
    GetProcChance = function(self) return Ability['Item_Glove_040_WeaponProc'].WeaponProcChance end,
    GetProcDrain = function(self) return math.floor( Buffs['Item_Glove_040_SlowDD'].Affects.Health.Add * -1 ) end,
    GetSlowBuff = function(self) return math.floor( Buffs['Item_Glove_040_Slow'].Affects.RateOfFire.Mult * -100 ) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0001>+[GetDamageBonus] Weapon Damage',
        },
        ChanceOnHit = '<LOC ITEM_Glove_0008>[GetProcChance]% chance on hit to eviscerate the target dealing [GetProcDrain] damage and reducing their Attack Speed and Movement Speed [GetSlowBuff]%.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Hand/Hand4',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Glove_040',
            AbilityType = 'Quiet',
            FromItem = 'Item_Glove_040',
            Icon = 'NewIcons/Hand/Hand4',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Glove_040',
                    BuffType = 'ENCHANTCRITMULT',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 15},
                    },
                }
            },
        },
        AbilityBlueprint {
            Name = 'Item_Glove_040_WeaponProc',
            AbilityType = 'WeaponProc',
            FromItem = 'Item_Glove_040',
            Icon = 'NewIcons/Hand/Hand4',
            WeaponProcChance = 15,
            WeaponProcChanceRanged = 8,
            OnWeaponProc = function(self, unit, target, damageData)
                if not target:IsDead() then
                    Buff.ApplyBuff(target, 'Item_Glove_040_SlowDD', unit)
                    Buff.ApplyBuff(target, 'Item_Glove_040_Slow', unit)
                    AttachEffectsAtBone( unit, EffectTemplates.Items.Glove.GauntletsOfDespairProc, -2 )
                end
            end,
        }
    },
}

BuffBlueprint {
    Name = 'Item_Glove_040_SlowDD',
    BuffType = 'ITEM_GLOVE_040_STUN01',
    IgnoreDamageRangePercent = true,
    Debuff = true,
    Stacks = 'ALWAYS',
    Duration = 0,
    Affects = {
        Health = {Add = -60},
    },
}

BuffBlueprint {
    Name = 'Item_Glove_040_Slow',
    DisplayName = '<LOC ITEM_Glove_0007>Wyrmskin Handguards',
    Description = '<LOC ITEM_Glove_0010>Movement Speed and Attack Speed reduced.',
    BuffType = 'ITEM_GLOVE_040_SLOW',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Affects = {
        MoveMult = {Mult = -0.15},
        RateOfFire = {Mult = -0.15},
    },

    Effects = 'Stun01',
    EffectsBone = -2,

    Icon = 'NewIcons/Hand/Hand4',
}

#################################################################################################################
# Doomspite Grips
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Glove_050',
    DisplayName = '<LOC ITEM_Glove_0011>Doomspite Grips',
    GetDamageBonus = function(self) return Buffs['Item_Glove_050'].Affects.DamageRating.Add end,
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['Item_Glove_050'].Affects.RateOfFire.Mult * 100 ) end,
    GetProcChance = function(self) return Ability['Item_Glove_050_WeaponProc'].WeaponProcChance end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0022>+[GetDamageBonus] Weapon Damage',
            '<LOC ITEM_Glove_0023>+[GetAttackSpeedBonus]% Attack Speed',
        },
        ChanceOnHit = '<LOC ITEM_Glove_0024>[GetProcChance]% chance on hit to perform a cleaving attack, damaging nearby enemies.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Hand/Hand6',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Glove_050',
            AbilityType = 'Quiet',
            FromItem = 'Item_Glove_050',
            Icon = 'NewIcons/Hand/Hand6',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Glove_050',
                    BuffType = 'ENCHANTDAMAGE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 30.0},
                        RateOfFire= {Mult = 0.10},
                    },
                    Effects = 'Damage01',
                }
            },
        },
        AbilityBlueprint {
            Name = 'Item_Glove_050_WeaponProc',
            AbilityType = 'WeaponProc',
            FromItem = 'Item_Glove_050',
            Icon = 'NewIcons/Hand/Hand6',
            WeaponProcChance = 25,
            WeaponProcChanceRanged = 16,
            CleaveSize = 1.5,
            OnWeaponProc = function(self, unit, target, damageData)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Glove.DoomSpiteGripsProc, -2 )
                local wepbp = unit:GetWeaponByLabel( damageData.DamageAction ):GetBlueprint()
                local damageAmt = wepbp.Damage + unit.Sync.DamageRating

                local data = {
                    Instigator = unit,
                    InstigatorBp = unit:GetBlueprint(),
                    InstigatorArmy = unit:GetArmy(),
                    Origin = target:GetPosition(),
                    Amount = damageAmt,
                    Type = 'Hero',
                    DamageAction = self.Name,
                    IgnoreTargets = { target },
                    Radius = self.CleaveSize,
                    DamageFriendly = false,
                    DamageSelf = false,
                    Group = 'UNITS',
                    CanBeEvaded = true,
                    CanCrit = false,
                    CanBackfire = false,
                    CanMagicResist = false,
                    CanOverKill = true,
                    ArmorImmune = false,
                    NoFloatText = false,
                }
                DamageArea(data)
            end
        }
    },
}

#################################################################################################################
# Gloves of Fell-Darkur
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Glove_060',
    DisplayName = '<LOC ITEM_Glove_0013>Gloves of Fell-Darkur',
    GetDamageBonus = function(self) return Buffs['Item_Glove_060'].Affects.DamageRating.Add end,
    GetProcChance = function(self) return Ability['Item_Glove_060_WeaponProc'].WeaponProcChance end,
    GetProcDamage = function(self) return math.floor( Buffs['Item_Glove_060_FireStrike'].Affects.Health.Add * -1 ) end,
    GetMinionDamageBonus = function(self) return Buffs['Item_Glove_060_Minion'].Affects.DamageRating.Add end,
    GetMinionROFBonus = function(self) return math.floor(Buffs['Item_Glove_060_Minion'].Affects.RateOfFire.Mult * 100) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0031>+[GetDamageBonus] Weapon Damage',
        },
        MBonuses = {
            '<LOC MBONUS_0004>+[GetMinionDamageBonus] Minion Damage',
            '<LOC MBONUS_0006>+[GetMinionROFBonus]% Minion Attack Speed',
        },
        ChanceOnHit = '<LOC ITEM_Glove_0033>[GetProcChance]% chance on hit to unleash a fiery blast, dealing [GetProcDamage] damage.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Hand/Hand2',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Glove_060',
            AbilityType = 'Quiet',
            FromItem = 'Item_Glove_060',
            Icon = 'NewIcons/Hand/Hand2',
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Glove_060_Minion', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Glove_060_Minion', unit )
            end,
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Glove_060',
                    BuffType = 'RUNEDAMAGE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 30},
                    },
                }
            },
        },
        AbilityBlueprint {
            Name = 'Item_Glove_060_WeaponProc',
            AbilityType = 'WeaponProc',
            FromItem = 'Item_Glove_060',
            Icon = 'NewIcons/Hand/Hand6',
            WeaponProcChance = 20,
            WeaponProcChanceRanged = 13,
            OnWeaponProc = function(self, unit, target, damageData)
                if not target:IsDead() then
                    Buff.ApplyBuff(target, 'Item_Glove_060_FireStrike', unit)
                    AttachEffectsAtBone( unit, EffectTemplates.Items.Glove.GauntletsOfDespairProc, -2 )
                end
            end,
        }
    },
}

BuffBlueprint {
    Name = 'Item_Glove_060_FireStrike',
    BuffType = 'ITEM_GLOVE_060_FIRESTRIKE',
    Debuff = true,
    IgnoreDamageRangePercent = true,
    Stacks = 'REPLACE',
    Duration = 0,
    Affects = {
        Health = {Add = -175},
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Glove_060_Minion',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Glove_060_Minion',
            BuffType = 'GLOVE60MINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Icon = 'NewIcons/Hand/Hand6',
            Affects = {
                DamageRating = {Add = 8},
                RateOfFire = {Mult = 0.05},
            },
        }
    }
}

#################################################################################################################
# Slayer's Grips
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Glove_070',
    DisplayName = '<LOC ITEM_Glove_0034>Slayer\'s Wraps',
    GetCritChance = function(self) return Ability['Item_Glove_070'].CritChance end,
    GetCritDamage = function(self) return Ability['Item_Glove_070'].CritMult end,
    GetRegenBonus = function(self) return Buffs['Item_Glove_070_Buff'].Affects.Regen.Add end,
    GetDamageBonus = function(self) return Buffs['Item_Glove_070_Buff'].Affects.DamageRating.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
            '<LOC ITEM_Glove_0031>+[GetDamageBonus] Weapon Damage',
        },
        Passives = '<LOC ITEM_Glove_0035>[GetCritChance]% chance deal a critical strike for [GetCritDamage]x damage.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Hand/Hand3',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Glove_070_Buff',
            AbilityType = 'Quiet',
            FromItem = 'Item_Glove_070',
            Icon = 'NewIcons/Hand/Hand2',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Glove_070_Buff',
                    BuffType = 'RUNEDAMAGE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 30},
                        Regen = {Add = 10},
                    },
                }
            },
        },
        AbilityBlueprint {
            Name = 'Item_Glove_070',
            AbilityType = 'WeaponCrit',
            CritChance = 10,
            CritMult = 2.0,
            Icon = 'NewIcons/Hand/Hand3',
        },
    },
}

__moduleinfo.auto_reload = true
