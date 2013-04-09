#################################################################################################################
# Helms
# Shop and costs defined in //depot/forge/main/bindata/units/ug/b/ugbshop04/UGBShop04_unit.bp
#################################################################################################################

local Buff = import('/lua/sim/Buff.lua')

#################################################################################################################
# Scaled Helm
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Helm_010',
    DisplayName = '<LOC ITEM_Helm_0000>Scaled Helm',
    GetManaBonus = function(self) return Buffs['Item_Helm_010'].Affects.MaxEnergy.Add end,
    GetManaRegenBonus = function(self) return Buffs['Item_Helm_010'].Affects.EnergyRegen.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0001>+[GetManaBonus] Mana',
            '<LOC ITEM_Boot_0012>+[GetManaRegenBonus] Mana Per Second',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Helm/Helm5',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Helm_010',
            AbilityType = 'Quiet',
            FromItem = 'Item_Helm_010',
            Icon = 'NewIcons/Helm/Helm5',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Helm_010',
                    BuffType = 'GLYPHMAGIC',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxEnergy = {Add = 525, AdjustEnergy = false},
                        EnergyRegen = {Add = 4},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Plate Visor
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Helm_020',
    DisplayName = '<LOC ITEM_Helm_0002>Plate Visor',
    GetManaRegenBonus = function(self) return math.floor( Buffs['Item_Helm_020'].Affects.EnergyRegen.Mult * 100 ) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0003>+[GetManaRegenBonus]% Mana Per Second',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Helm/Helm6',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Helm_020',
            AbilityType = 'Quiet',
            FromItem = 'Item_Helm_020',
            Icon = 'NewIcons/Helm/Helm6',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Helm_020',
                    BuffType = 'GLYPHDAMAGE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        EnergyRegen = {Mult = 0.35},
                    },
                    Effects = 'Damage01',
                }
            },
        }
    },
}

#################################################################################################################
# Plenor Battlecrown
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Helm_030',
    DisplayName = '<LOC ITEM_Helm_0004>Plenor Battlecrown',
    GetManaBonus = function(self) return Buffs['Item_Helm_030'].Affects.MaxEnergy.Add end,
    GetManaRegenBonus = function(self) return math.floor(Buffs['Item_Helm_030'].Affects.EnergyRegen.Mult * 100) end,
    #GetCooldownBonus = function(self) return math.floor( Buffs['Item_Helm_030'].Affects.Cooldown.Mult * 100 ) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0015>+[GetManaBonus] Mana',
            '<LOC ITEM_Helm_0020>+[GetManaRegenBonus]% Mana Per Second',
            #'<LOC ITEM_Helm_0016>[GetCooldownBonus]% to ability cooldowns',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Helm/Helm3',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Helm_030',
            AbilityType = 'Quiet',
            FromItem = 'Item_Helm_030',
            Icon = 'NewIcons/Helm/Helm3',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Helm_030',
                    BuffType = 'GLYPHENERGY',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxEnergy = {Add = 1575, AdjustEnergy = false},
                        EnergyRegen = {Mult = .70},
                        #Cooldown = {Mult = -0.15},
                    },
                    Effects = 'SingleRing01',
                    EffectsBone = -1,
                }
            },
        }
    },
}

#################################################################################################################
# Vlemish Faceguard
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Helm_040',
    DisplayName = '<LOC ITEM_Helm_0006>Vlemish Faceguard',
    GetManaRegenBonus = function(self) return Buffs['Item_Helm_040'].Affects.EnergyRegen.Add end,
    GetManaBonus = function(self) return Buffs['Item_Helm_040'].Affects.MaxEnergy.Add end,
    GetRegenBonus = function(self) return string.format('%d',Buffs['Item_Helm_040_Aura'].Affects.EnergyRegen.Add) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0015>+[GetManaBonus] Mana',
            '<LOC ITEM_Helm_0028>+[GetManaRegenBonus] Mana Per Second',
        },
        Auras = '<LOC ITEM_Helm_0007>+[GetRegenBonus] Mana Per Second Aura',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Helm_040_Aura',
            AbilityType = 'Aura',
            AffectRadius = 20,
            AuraPulseTime = 2,
            Icon = 'NewIcons/Helm/Helm1',
            TargetAlliance = 'Ally',
            TargetCategory = 'HERO - UNTARGETABLE',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Helm_040_Aura',
                    BuffType = 'IMAGMAGIC02AURA',
                    Debuff = false,
                    DisplayName = '<LOC ITEM_Helm_0006>Vlemish Faceguard',
                    Description = '<LOC ITEM_Helm_0008>Increased Mana Per Second.',
                    DoNotPulseIcon = true,
                    Duration = 5,
                    Icon = 'NewIcons/Helm/Helm1',
                    Stacks = 'REPLACE',
                    Affects = {
                        EnergyRegen = {Add = 4},   
                    },
                },
            },
        },
        AbilityBlueprint {
            Name = 'Item_Helm_040',
            AbilityType = 'Quiet',
            FromItem = 'Item_Helm_040',
            Icon = 'NewIcons/Helm/Helm1',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Helm_040',
                    BuffType = 'Buff_Item_Helm_040',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        EnergyRegen = {Add = 11},
                        MaxEnergy = {Add = 1050, AdjustEnergy = false},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Vinling Helmet
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Helm_050',
    DisplayName = '<LOC ITEM_Helm_0009>Vinling Helmet',
    GetManaBonus = function(self) return Buffs['Item_Helm_050'].Affects.MaxEnergy.Add end,
    GetManaRegenBonus = function(self) return math.floor( Buffs['Item_Helm_050'].Affects.EnergyRegen.Mult * 100 ) end,
    GetProcChance = function(self) return Ability['Item_Helm_050_WeaponProc'].ArmorProcChance end,
    GetProcManaBonus = function(self) return Buffs['Item_Helm_050_Restore'].Affects.Energy.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0019>+[GetManaBonus] Mana',
            '<LOC ITEM_Helm_0020>+[GetManaRegenBonus]% Mana Per Second',
        },
        ChanceOnHit = '<LOC ITEM_Helm_0021>[GetProcChance]% chance on being hit to restore [GetProcManaBonus] Mana.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Helm/Helm2',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Helm_050',
            AbilityType = 'Quiet',
            FromItem = 'Item_Helm_050',
            Icon = 'NewIcons/Helm/Helm2',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Helm_050',
                    BuffType = 'GLYPHCOOLDOWN',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxEnergy = {Add = 1050, AdjustEnergy = false},
                        EnergyRegen = {Mult = .70},
                    },
                    Effects = 'RunSpeed01',
                }
            },
        },
        AbilityBlueprint {
            Name = 'Item_Helm_050_WeaponProc',
            AbilityType = 'ArmorProc',
            FromItem = 'Item_Helm_050',
            Icon = 'NewIcons/Helm/Helm2',
            ArmorProcChance = 3,
            OnArmorProc = function(self, unit)
                Buff.ApplyBuff(unit, 'Item_Helm_050_Restore', unit)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Helm.GlowingFaceguardProc, -2 )
            end,
        }
    },
}

BuffBlueprint {
    Name = 'Item_Helm_050_Restore',
    BuffType = 'ITEM_HELM_050_RESTORE',
    Debuff = true,
    IgnoreDamageRangePercent = true,
    Stacks = 'REPLACE',
    Duration = 0,
    Affects = {
        Energy = {Add = 350},
    },
}

#################################################################################################################
# Hungarling's Crown
#################################################################################################################
ItemBlueprint {
    DisplayName = '<LOC ITEM_Helm_0012>Hungarling\'s Crown',
    GetSpellCostBonus = function(self) return math.floor( Buffs['Item_Helm_060'].Affects.SpellCostMult.Add * 100 ) end,
    GetManaBonus = function(self) return math.floor( Buffs['Item_Helm_060_Buff'].Affects.MaxEnergy.Add ) end,
    GetManaRegenBonus = function(self) return math.floor( Buffs['Item_Helm_060_Buff'].Affects.EnergyRegen.Add ) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0019>+[GetManaBonus] Mana',
            '<LOC ITEM_Helm_0028>+[GetManaRegenBonus] Mana Per Second',
        },
        Auras = '<LOC ITEM_Helm_0013>[GetSpellCostBonus]% Mana Cost Aura',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Name = 'Item_Helm_060',
    Abilities = {
        AbilityBlueprint {
            AbilityType = 'Aura',
            AffectRadius = 20,
            AuraPulseTime = 5,
            FromItem = 'Item_Helm_060',
            Icon = 'NewIcons/Helm/Helm4',
            Name = 'Item_Helm_060',
            TargetAlliance = 'Ally',
            TargetCategory = 'HERO - UNTARGETABLE',
            Buffs = {
                BuffBlueprint {
                    BuffType = 'IMAGENERGY',
                    Debuff = false,
                    DisplayName = '<LOC ITEM_Helm_0012>Hungarling\'s Crown',
                    Description = '<LOC ITEM_Helm_0014>-35% Mana Cost',
                    Duration = 5,
                    EntityCategory = 'HERO',
                    Icon = 'NewIcons/Helm/Helm4',
                    Name = 'Item_Helm_060',
                    Stacks = 'ALWAYS',
                    Affects = {
                        SpellCostMult = {Add = -.25},
                    },
                },
            },
        },
        AbilityBlueprint {
            Name = 'Item_Helm_060_Buff',
            AbilityType = 'Quiet',
            FromItem = 'Item_Helm_060',
            Icon = 'NewIcons/Helm/Helm2',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Helm_060_Buff',
                    BuffType = 'ITEM60BUFF',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxEnergy = {Add = 700, AdjustEnergy = false},
                        EnergyRegen = {Add = 18},
                    },
                    Effects = 'RunSpeed01',
                }
            },
        },
    },
}

#################################################################################################################
# Theurgist's Cap
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Helm_070',
    DisplayName = '<LOC ITEM_Helm_0022>Theurgist\'s Cap',
    GetRegenBonus = function(self) return Buffs['Item_Helm_070'].Affects.Regen.Add end,
    GetManaRegenBonus = function(self) return math.floor( Buffs['Item_Helm_070'].Affects.EnergyRegen.Mult * 100 ) end,
    GetProcChance = function(self) return Ability['Item_Helm_070_WeaponProc'].WeaponProcChance end,
    GetProcRegenDebuff = function(self) return math.floor(Buffs['Item_Helm_070_RegenDebuff'].Affects.Regen.Mult * -100) end,
    GetProcManaRegenDebuff = function(self) return math.floor( Buffs['Item_Helm_070_RegenDebuff'].Affects.EnergyRegen.Mult * -100 ) end,
    GetDuration = function(self) return math.floor( Buffs['Item_Helm_070_RegenDebuff'].Duration ) end,
    GetMinionHealthBonus = function(self) return Buffs['Item_Helm_070_Minion_Buff'].Affects.MaxHealth.Add end,
    GetMinionRegenBonus = function(self) return Buffs['Item_Helm_070_Minion_Buff'].Affects.Regen.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0023>+[GetRegenBonus] Health Per Second',
            '<LOC ITEM_Helm_0024>+[GetManaRegenBonus]% Mana Per Second',
        },
        MBonuses = {
            '<LOC MBONUS_0000>+[GetMinionHealthBonus] Minion Health',
            '<LOC MBONUS_0002>+[GetMinionRegenBonus] Minion Health Per Second',
        },
        ChanceOnHit = '<LOC ITEM_Helm_0025>[GetProcChance]% chance on being hit to reduce the target\'s Health Per Second by [GetProcRegenDebuff]% and Mana Per Second by [GetProcManaRegenDebuff]% for [GetDuration] seconds.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Helm/Helm7',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Helm_070',
            AbilityType = 'Quiet',
            FromItem = 'Item_Helm_070',
            Icon = 'NewIcons/Helm/Helm7',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Helm_070',
                    BuffType = 'THEURGIST',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Regen = {Add = 10},
                        EnergyRegen = {Mult = .35},
                    },
                    Effects = 'RunSpeed01',
                }
            },
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Helm_070_Minion_Buff', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus('Item_Helm_070_Minion_Buff', unit )
            end,
        },
        AbilityBlueprint {
            Name = 'Item_Helm_070_WeaponProc',
            AbilityType = 'WeaponProc',
            FromItem = 'Item_Helm_070',
            Icon = 'NewIcons/Helm/Helm7',
            WeaponProcChance = 5,
            OnWeaponProc = function(self, unit, target, damageData)
                Buff.ApplyBuff(target, 'Item_Helm_070_RegenDebuff', unit)
            end,
        }
    },
}

BuffBlueprint {
    Name = 'Item_Helm_070_RegenDebuff',
    DisplayName = '<LOC ITEM_Helm_0026>Theurgist\'s Cap',
    Description = '<LOC ITEM_Helm_0027>Reduced Health Per Second. Reduced Mana Per Second.',
    BuffType = 'ITEM_HELM_050_RESTORE',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 10,
    Icon = 'NewIcons/Helm/Helm7',
    Affects = {
        Regen = {Mult = -.50},
        EnergyRegen = {Mult = -.50},
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Helm_070_Minion_Buff',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Helm_070_Minion_Buff',
            BuffType = 'HELM70MINIONHEALTH',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Affects = {
                MaxHealth = {Add = 200, AdjustEnergy = false},
                Regen = {Add = 3},
            },
        }
    }
}

__moduleinfo.auto_reload = true