#################################################################################################################
# Rings
# Shop and costs defined in //depot/forge/main/bindata/units/ug/b/ugbshop06/UGBShop06_unit.bp
#################################################################################################################
local Buff = import('/lua/sim/Buff.lua')

#################################################################################################################
# Ring of Greed
#################################################################################################################
# 11/5/2008 - Marr - Commenting out
#ItemBlueprint {
#    DisplayName = '<LOC ITEM_Ring_0000>Ring of Greed',
#    GetItemCostBonus = function(self) return math.floor( Buffs['Item_Ring_010'].Affects.ItemCost.Add * -100 ) end,
#    Tooltip = {
#        Passives = '<LOC ITEM_Ring_0001>Decreases cost of items by [GetItemCostBonus]%',
#    },
#    Mesh = '/meshes/items/rings/ring01_mesh',
#    Animation = '/meshes/items/rings/Animations/ring01_Idle_anim.gr2',
#    MeshScale = 0.10,
#    Name = 'Item_Ring_010',
#    Abilities = {
#        AbilityBlueprint {
#            AbilityType = 'Quiet',
#            DisplayName = '<LOC ITEM_Ring_0000>Ring of Greed',
#            FromItem = 'Item_Ring_010',
#            Icon = 'NewIcons/Ring/Ring3',
#            Name = 'Item_Ring_010',
#            Buffs = {
#                BuffBlueprint {
#                    Name = 'Item_Ring_010',
#                    BuffType = 'IRNGSTATSRING01',
#                    Debuff = false,
#                    DisplayName = '<LOC ITEM_Ring_0000>Ring of Greed',
#                    Duration = -1,
#                    EntityCategory = 'HERO',
#                    Stacks = 'ALWAYS',
#                    Affects = {
#                        ItemCost = {Add = -.2},
#                        #MaxEnergy = {Add = 425, AdjustEnergy = false},
#                    },
#                    Effects = 'SingleRing01',
#                },
#            },
#        },
#    },
#}

#################################################################################################################
# Bloodstone Ring
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Ring_020',
    DisplayName = '<LOC ITEM_Ring_0002>Bloodstone Ring',
    GetLifestealBonus = function(self) return math.floor( Buffs['Item_Ring_020'].Affects.LifeSteal.Add * 100 ) end,
    GetHealthBonus = function(self) return Buffs['Item_Ring_020'].Affects.MaxHealth.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0003>+[GetHealthBonus] Health',
            '<LOC ITEM_Ring_0003>+[GetLifestealBonus]% Life Steal',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Ring/Ring1',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Ring_020',
            AbilityType = 'Quiet',
            FromItem = 'Item_Ring_020',
            Icon = 'NewIcons/Ring/Ring1',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Ring_020',
                    BuffType = 'ENCHANTLIFESTEAL',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 400, AdjustEnergy = false},
                        LifeSteal = {Add = 0.03},
                    },
                    Effects = 'Lifesteal02',
                }
            },
        }
    },
}

#################################################################################################################
# Nature's Reckoning
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Ring_030',
    DisplayName = '<LOC ITEM_Ring_0004>Nature\'s Reckoning',
    GetProcChance = function(self) return math.floor( Ability['Item_Ring_030_WeaponProc'].WeaponProcChance ) end,
    GetDamageBonus = function(self) return math.floor( Ability['Item_Ring_030_WeaponProc'].DamageAmt ) end,
    GetManaBonus = function(self) return math.floor( Buffs['Item_Ring_030'].Affects.MaxEnergy.Add ) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0019>+[GetManaBonus] Mana',
        },
        ChanceOnHit = '<LOC ITEM_Ring_0005>[GetProcChance]% chance on hit to strike nearby enemies with lightning for [GetDamageBonus] damage',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Ring/Ring2',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Ring_030',
            AbilityType = 'Quiet',
            FromItem = 'Item_Ring_030',
            Icon = 'NewIcons/Ring/Ring2',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Ring_030',
                    BuffType = 'LIGHTNINGRING',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxEnergy = {Add = 600, AdjustEnergy = false},
                    },
                },
            },
        },
        AbilityBlueprint {
            Name = 'Item_Ring_030_WeaponProc',
            AbilityType = 'WeaponProc',
            FromItem = 'Item_Ring_030',
            Icon = 'NewIcons/Ring/Ring2',
            WeaponProcChance = 15,
            WeaponProcChanceRanged = 10,
            Chains = 10,
            ChainTime = 0.1,
            ChainAffectRadius = 5,
            Effects = {
                Base = 'Items',
                Group = 'Runes',
                Beams = 'LightningBeam01',
            },
            DamageAmt = 250,
            OnWeaponProc = function(self, unit, target, damageData)
                ForkThread(self.LightningThread, self, unit, target, damageData)
            end,
            LightningThread = function(self, unit, target, damageData)
                local weapon = unit:GetWeaponByLabel( damageData.DamageAction )

                #Only Affect weapons that aren't tagged with NoItemEffect = true,
                local wepbp = weapon:GetBlueprint()
                if wepbp.NoItemEffect then
                    return
                end

                local radius = self.ChainAffectRadius
                local beamTrash = TrashBag()
                local chainedUnits = {}

                #### Impact Emitters
                local emitIds = AttachEffectsAtBone(target, EffectTemplates.Items.Runes.LightningImpact01, -1)

                #### Beam Emitters
                emitIds = AttachBeamEffectOnEntities( self.Effects.Base, self.Effects.Group, self.Effects.Beams, unit, -1, target, -1, unit:GetArmy(), self.unit.TrashOnKilled, target.Trash )
                if emitIds then
                    for kEffect, vEffect in emitIds do
                        beamTrash:Add(vEffect)
                    end
                end

                for i = 1, self.Chains do

                    if target:IsDead() then
                        target = unit
                    end
                    local pos = target:GetPosition()
                    local rect = Rect(pos[1] - radius, pos[3] - radius, pos[1] + radius, pos[3] + radius)
                    local targets = GetUnitsInRect( rect )
                    if not targets then
                        break
                    end

                    targets = EntityCategoryFilterDown(categories.ALLUNITS - categories.UNTARGETABLE, targets)
                    local noTarget = true

                    WaitSeconds(self.ChainTime or 0)

                    for k, v in targets do

                        if not v:IsDead() then

                            local allied = IsAlly(unit:GetArmy(), v:GetArmy())

                            if not allied then
                                local notchained = true

                                for key, chndunit in chainedUnits do
                                    if chndunit == v then
                                        notchained = false
                                    end
                                end

                                if notchained or (self.ChainSameTarget and (target != v or table.getn(targets) <= 1) ) then
                                    noTarget = false

                                    #### Impact Emitters
                                    emitIds = AttachEffectsAtBone(v, EffectTemplates.Items.Runes.LightningImpact01, -1)

                                    #### Beam Emitters
                                    emitIds = AttachBeamEffectOnEntities( self.Effects.Base, self.Effects.Group, self.Effects.Beams, target, -1, v, -1, target:GetArmy(), self.target.TrashOnKilled, v.Trash )
                                    if emitIds then
                                        for kEffect, vEffect in emitIds do
                                            beamTrash:Add(vEffect)
                                        end
                                    end

                                    local data = {
                                        Instigator = unit,
                                        InstigatorBp = unit:GetBlueprint(),
                                        InstigatorArmy = unit:GetArmy(),
                                        Amount = self.DamageAmt,
                                        Origin = unit:GetPosition(),
                                        IgnoreDamageRangePercent = true,
                                        CanBackfire = false,
                                        CanLifeSteal = false,
                                        CanCrit = false,
                                        CanBeEvaded = false,
                                        Type = 'Spell',
                                        CanMagicResist = true,
                                        ArmorImmune = true,
                                    }
                                    DealDamage(data, v)


                                    target = v

                                    table.insert(chainedUnits, v)

                                    break
                                end
                            end
                        end

                    end

                    if noTarget then
                        break
                    end

                end
                beamTrash:Destroy()
                beamTrash = nil
            end,
        },
    },
}

#################################################################################################################
# Ring of the Ancients
#################################################################################################################
ItemBlueprint {
    DisplayName = '<LOC ITEM_Ring_0006>Ring of the Ancients',
    GetArmorBonus = function(self) return Buffs['Item_Ring_040'].Affects.Armor.Add end,
    GetWeaponDamageBonus = function(self) return Buffs['Item_Ring_040'].Affects.DamageRating.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Ring_0012>+[GetArmorBonus] Armor',
            '<LOC ITEM_Ring_0013>+[GetWeaponDamageBonus] Weapon Damage',
        },
        #Passives = '<LOC ITEM_Ring_0014>Increases experience gained by 10%.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Name = 'Item_Ring_040',
    Abilities = {
        AbilityBlueprint {
            AbilityType = 'Quiet',
            DisplayName = '<LOC ITEM_Ring_0006>Ring of the Ancients',
            FromItem = 'Item_Ring_040',
            Icon = 'NewIcons/Ring/Ring5',
            Name = 'Item_Ring_040',
            Buffs = {
                BuffBlueprint {
                    BuffType = 'IRNGSTATSRING02',
                    Debuff = false,
                    Duration = -1,
                    EntityCategory = 'HERO',
                    Name = 'Item_Ring_040',
                    Stacks = 'ALWAYS',
                    Affects = {
                        Armor = {Add = 400},
                        DamageRating = {Add = 30},
                        #Experience = {Add = .1},
                    },
                    Effects = 'SingleRing01',
                },
            },
        },
    },
}

#################################################################################################################
# Narmoth's Ring
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Ring_050',
    DisplayName = '<LOC ITEM_Ring_0008>Narmoth\'s Ring',
    GetLifeStealBonus = function(self) return math.floor( Buffs['Item_Ring_050'].Affects.LifeSteal.Add * 100 ) end,
    GetThorns = function(self) return Buffs['Item_Ring_050'].Affects.DamageReturn.Add end,
    GetHealthBonus = function(self) return Buffs['Item_Ring_050'].Affects.MaxHealth.Add end,
    GetRegenBonus = function(self) return Buffs['Item_Ring_050'].Affects.Regen.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0024>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
            '<LOC ITEM_Ring_0021>+[GetLifeStealBonus]% Life Steal',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Ring/Ring4',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Ring_050',
            AbilityType = 'Quiet',
            FromItem = 'Item_Ring_050',
            Icon = 'NewIcons/Ring/Ring4',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Ring_050',
                    BuffType = 'RINGLIFESTEAL',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        LifeSteal = {Add = 0.08},
                        MaxHealth = {Add = 750, AdjustEnergy = false},
                        Regen = {Add = 20},
                    },
                    Effects = 'Lifesteal02',
                }
            },
        }
    },
}

#################################################################################################################
# Forest Band
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Ring_060',
    DisplayName = '<LOC ITEM_Ring_0023>Forest Band',
    GetProcChance = function(self) return Ability['Item_Ring_060'].WeaponProcChance end,
    GetHealth = function(self) return math.floor(Buffs['Item_Ring_060_Minion_Buff'].Affects.Health.Add) end,
    GetMinionArmorBonus = function(self) return math.floor(Buffs['Item_Ring_060_Minion'].Affects.Armor.Add) end,
    Tooltip = {
        MBonuses = {
            '<LOC MBONUS_0003>+[GetMinionArmorBonus] Minion Armor',
        },
        ChanceOnHit = '<LOC ITEM_Ring_0024>[GetProcChance]% on attack to heal your army for [GetHealth] health.',
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Ring/Ring3',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Ring_060',
            AbilityType = 'WeaponProc',
            FromItem = 'Item_Ring_060',
            Icon = 'NewIcons/Ring/Ring3',
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Ring_060_Minion', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Ring_060_Minion', unit )
            end,
            WeaponProcChance = 15,
            OnWeaponProc = function(self, unit, target, damageData)
                unit:GetAIBrain():AddArmyBonus( 'Item_Ring_060_Minion_Buff', unit )
            end,
        }
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Ring_060_Minion',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Ring_060_Minion',
            BuffType = 'RING60MINIONPASSIVEBUFF',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                Armor = {Add = 200},
            },
        }
    }
}

ArmyBonusBlueprint {
    Name = 'Item_Ring_060_Minion_Buff',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Ring_060_Minion_Buff',
            BuffType = 'RING06MINIONBUFF',
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
                Health = {Add = 250},
            },
        }
    }
}

############################################
# Eric's Ring - Not used in game.
# For debug/testing.
############################################
ItemBlueprint {
    Name = 'EricsRing',
    DisplayName = '<LOC ITEM_Ring_0010>Eric\'s Ring',
    Description = '<LOC ITEM_Ring_0011>Never gonna give you up, never gonna let you down.',
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Ring/Ring6',
    Abilities = {
        AbilityBlueprint {
            Name = 'EricsRing',
            AbilityType = 'Quiet',
            FromItem = 'EricsRing',
            Icon = 'NewIcons/Ring/Ring6',
            Buffs = {
                BuffBlueprint {
                    Name = 'EricsRing',
                    BuffType = 'ERICSRING',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Cooldown = {Mult = -3},
                        MaxHealth = {Add = 10000, AdjustHealth = true},
                        MaxEnergy = {Add = 10000, AdjustEnergy = true},
                        MoveMult = {Mult = 2},
                        Armor = {Add = 500},
                        DamageRating = {Add = 2000},
                        Regen = {Add = 500},
                        EnergyRegen = {Add = 500},
                        RateOfFire = {Mult = 5},
                    },
                }
            },
        }
    },
}


__moduleinfo.auto_reload = true
