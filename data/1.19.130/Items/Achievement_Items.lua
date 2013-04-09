local Utils = import('/lua/utilities.lua')
local Entity = import('/lua/sim/entity.lua').Entity
local Buff = import('/lua/sim/Buff.lua')
local CanUseAbility = import('/lua/common/ValidateAbility.lua').CanUseAbility

#
#   Achievement Items
#     - All Achievements - Usable by anyone
#     - Assassin Achievements - Usable by Assassins
#     - General Achievements - Usable by Generals
#

#   All Achievements


#################################################################################################################
# Saam-el's Cloak
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementMovement',
    DisplayName = '<LOC ITEM_Achievement_0000>Saam-el\'s Cloak',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Boot_0003>+[GetMoveSpeedBonus]% Movement Speed',
        },
        Passives = '<LOC ITEM_Achievement_0001>Movement Speed cannot be reduced by more than [GetMovementProtection]%.',
    },
    GetMovementProtection = function(self) return math.floor( Buffs['AchievementMovement'].Affects.MoveSlowCap.Mult * -100 ) end,
    GetMoveSpeedBonus = function(self) return math.floor( Buffs['AchievementMovement'].Affects.MoveMult.Mult * 100 ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/JekimsPegasusCloak',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementMovement',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/JekimsPegasusCloak',
            FromItem = 'AchievementMovement',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementMovement',
                    BuffType = 'ACHIEVEMENTMOVEMENT',
                    Debuff = false,
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MoveSlowCap = {Mult = -0.25},
                        MoveMult = {Mult = 0.05},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Blood of the Fallen
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementHealth',
    DisplayName = '<LOC ITEM_Achievement_0002>Blood of the Fallen',
    Tooltip = {
        Bonuses = {
          	'<LOC ITEM_Achievement_0003>+[GetHealthBonus] Health',
          	'<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
          },
    },
    GetHealthBonus = function(self) return Buffs['AchievementHealth'].Affects.MaxHealth.Add end,
    GetRegenBonus = function(self) return Buffs['AchievementHealth'].Affects.Regen.Add end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/BloodoftheFallen',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementHealth',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/BloodoftheFallen',
            FromItem = 'AchievementHealth',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementHealth',
                    BuffType = 'ACHIEVEMENTHEALTH',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 800, AdjustHealth = true},
                        Regen = {Add = 5},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Staff of the Warmage
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementMana',
    DisplayName = '<LOC ITEM_Achievement_0004>Staff of the Warmage',
    Tooltip = {
        Bonuses = {
          	'<LOC ITEM_Achievement_0005>+[GetManaBonus] Mana',
          	'<LOC ITEM_Glove_0001>+[GetDamageBonus] Weapon Damage',
          },
    },
    GetManaBonus = function(self) return Buffs['AchievementMana'].Affects.MaxEnergy.Add end,
    GetDamageBonus = function(self) return Buffs['AchievementMana'].Affects.DamageRating.Add end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/StaffoftheWarmage',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementMana',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/StaffoftheWarmage',
            FromItem = 'AchievementMana',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementMana',
                    BuffType = 'ACHIEVEMENTMANA',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxEnergy = {Add = 700, AdjustEnergy = true},
                        DamageRating = {Add = 15},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Swift Anklet
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementRunSpeed',
    DisplayName = '<LOC ITEM_Achievement_0006>Swift Anklet',
    Tooltip = {
        Bonuses = {
          	'<LOC ITEM_Achievement_0007>+[GetMovementBonus]% Movement Speed',
          },
    },
    GetMovementBonus = function(self) return math.floor( Buffs['AchievementRunSpeed'].Affects.MoveMult.Mult * 100 ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/SwiftAnklet',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementRunSpeed',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/SwiftAnklet',
            FromItem = 'AchievementRunSpeed',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementRunSpeed',
                    BuffType = 'ACHIEVEMENTRUNSPEED',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MoveMult = {Mult = 0.15},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Diamond Pendant
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementCooldown',
    DisplayName = '<LOC ITEM_Achievement_0008>Diamond Pendant',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0001>+[GetManaBonus] Mana',
          	'<LOC ITEM_Achievement_0009>[GetCooldownBonus]% to ability cooldowns',
          },
    },
    GetManaBonus = function(self) return Buffs['AchievementCooldown'].Affects.MaxEnergy.Add end,
    GetCooldownBonus = function(self) return math.floor( Buffs['AchievementCooldown'].Affects.Cooldown.Mult * 100 ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/DiamondEncrustedPendant',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementCooldown',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/DiamondEncrustedPendant',
            FromItem = 'AchievementCooldown',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementCooldown',
                    BuffType = 'ACHIEVEMENTCOOLDOWN',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Cooldown = {Mult = -0.10},
                        MaxEnergy = {Add = 250, AdjustEnergy = true},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Polished Crystal Goggles
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementVision',
    DisplayName = '<LOC ITEM_Achievement_0010>Bejeweled Goggles',
    Tooltip = {
        Bonuses = {
          	'<LOC ITEM_Achievement_0011>+[GetVisionBonus] vision radius',
          },
          Passives = '<LOC ITEM_Achievement_0082>Can detect normally invisible objects.',
    },
    GetVisionBonus = function(self) return Buffs['AchievementVision'].Affects.VisionRadius.Add end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/PolishedCrystalGoggles',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementVision',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/PolishedCrystalGoggles',
            FromItem = 'AchievementVision',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementVision',
                    BuffType = 'ACHIEVEMENTVISION',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        OmniRadius = {Add = 32},
                        VisionRadius = {Add = 12},
                    },
                }
            },
        }
    },
}


#################################################################################################################
# Holy Symbol of Purity
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementPure',
    DisplayName = '<LOC ITEM_Achievement_0012>Symbol of Purity',
    Description = '<LOC ITEM_Achievement_0013>Use: Purge all negative effects. Cannot use while stunned or frozen.',
    GetHealthBonus = function(self) return Buffs['AchievementPure_Buff'].Affects.MaxHealth.Add end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0003>+[GetHealthBonus] Health',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/HolysymbolofPurity',
    InventoryType = 'Achievement',
    GetMaxRange = function(self) return Ability['AchievementPure'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementPure'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementPure'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementPure'].Cooldown end,
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementPure',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            Cooldown = 30,
            CastingTime = 0,
            CanCastWhileMoving = true,
            EnergyCost = 0,
            NotSilenceable = true,
            InventoryType = 'Achievement',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementPure',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            OnStartAbility = function(self, unit, params)
                Buff.RemoveBuffsByDebuff(unit, true)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.HolySymbolActivate, -2 )
            end,
            FromItem = 'AchievementPure',
            Icon = '/NewIcons/AchievementRewards/HolysymbolofPurity',
        },
        AbilityBlueprint {
            Name = 'AchievementPure_Buff',
            AbilityType = 'Quiet',
            FromItem = 'AchievementPure',
            Icon = 'NewIcons/Hand/Hand1',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementPure_Buff',
                    BuffType = 'PURITYBUFF',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 250, AdjustHealth = true},
                    },
                },
            },
        }
    },
}

#################################################################################################################
# Amulet of Teleportation
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementTeleport',
    DisplayName = '<LOC ITEM_Achievement_0014>Amulet of Teleportation',
    Description = '<LOC ITEM_Achievement_0015>Use: Teleport yourself and your army to targeted friendly structure.',
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/AmuletofTeleportation',
    InventoryType = 'Achievement',
    GetMaxRange = function(self) return Ability['AchievementTeleport'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementTeleport'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementTeleport'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementTeleport'].Cooldown end,
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementTeleport',
            AbilityType = 'TargetedUnit',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'STRUCTURE', # This item allows you to teleport to untargetable structures.
            TargetingMethod = 'ALLYSTRUCTURE',
            EnergyCost = 0,
            RangeMax = 5000,
            Cooldown = 45,
            CastingTime = 3,
            InventoryType = 'Achievement',
            CastAction = 'CastItem3sec',
            SharedCooldown = 'TeleportItems',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementTeleport',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            WarpToLocation = true,
            WarpMinions = true,
            IgnoreFacing = true,
            FromItem = 'AchievementTeleport',
            Icon = '/NewIcons/AchievementRewards/AmuletofTeleportation',
            OnCastingEffects = {
                Base = 'Items',
                Group = 'Relics',
                Template = 'PortalScroll01',
            },
            OnStartCasting = function(self, unit, params)
            	local pos = unit:FindAdjacentSpot(params)
		        CreateTemplatedEffectAtPos( 'Items', 'Relics', 'PortalScroll01', unit:GetArmy(), pos )
		    end,
        }
    },
}

#################################################################################################################
# Dark Crimson Vial
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementPotion',
    DisplayName = '<LOC ITEM_Achievement_0016>Dark Crimson Vial',
    Description = '<LOC ITEM_Achievement_0017>Use: Heal [GetHealthBonus]% of your maximum Health.',
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/DarkChrimsonVial',
    InventoryType = 'Achievement',
    GetHealthBonus = function(self) return math.floor(Ability['AchievementPotion'].RegenAmount * 100) end,
    GetMaxRange = function(self) return Ability['AchievementPotion'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementPotion'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementPotion'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementPotion'].Cooldown end,
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementPotion',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 45,
            CastingTime = 2,
            EnergyCost = 0,
            RegenAmount = 0.33,
            InventoryType = 'Achievement',
            CastAction = 'CastItem2sec',
            Icon = '/NewIcons/AchievementRewards/DarkChrimsonVial',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementPotion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'AchievementPotion',
            OnStartAbility = function(self, unit, params)
                local brain = unit:GetAIBrain()
                local amount = unit:GetMaxHealth() * self.RegenAmount * -1
                # Damage Target
                local data = {
                    Instigator = unit,
                    InstigatorBp = unit:GetBlueprint(),
                    InstigatorArmy = unit:GetArmy(),
                    Amount = amount,
                    Type = 'Spell',
                    Radius = 0,
                    DamageAction = self.Name,
                    DamageSelf = true,
                    Origin = unit:GetPosition(),
                    CanDamageReturn = false,
                    CanCrit = false,
                    CanBackfire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    DamageFriendly = true,
                    ArmorImmune = true,
                    NoFloatText = false,
                    Group = "UNITS",
                }
                DealDamage(data, unit)
            end,
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementPotionFX',
                    BuffType = 'POTIONHEAL01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 3,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Heal02',
                    EffectsBone = -2,
                },
            },
        },
    },

}

#################################################################################################################
# Cape of Plentiful Mana
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementAEMana',
    DisplayName = '<LOC ITEM_Achievement_0018>Cape of Plentiful Mana',
    Description = '<LOC ITEM_Achievement_0019>Use: +[GetRegenBonus]% Mana Per Second Aura for [GetDuration] seconds.',
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/CapeofPlentifulMana',
    InventoryType = 'Achievement',
    Useable = true,
    GetRegenBonus = function(self) return math.floor( Buffs['AchievementAEMana'].Affects.EnergyRegen.Mult * 100 ) end,
    GetDuration = function(self) return Buffs['AchievementAEMana'].Duration end,
    GetMaxRange = function(self) return Ability['AchievementAEMana'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementAEMana'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementAEMana'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementAEMana'].Cooldown end,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementAEMana',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            InventoryType = 'Achievement',
            CastingTime = 0,
            CanCastWhileMoving = true,
            TargetCategory = 'HERO - UNTARGETABLE',
            Cooldown = 45,
            AffectRadius = 8,
            EnergyCost = 0,
            Icon = '/NewIcons/AchievementRewards/CapeofPlentifulMana',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementAEMana',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'AchievementAEMana',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementAEMana',
                    BuffType = 'ACHIEVEMENTAEMana',
                    DisplayName = '<LOC ITEM_Achievement_0018>Cape of Plentiful Mana',
                    Description = '<LOC ITEM_Achievement_0073>Increased Mana Per Second',
                    Icon = '/NewIcons/AchievementRewards/CapeofPlentifulMana',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 10,
                    Affects = {
                        EnergyRegen = {Mult = 4},
                    },
                    Effects = 'Energize01',
                    EffectsBone = -2,
                }
            },
        }
    },
}

#################################################################################################################
# Charm of Life
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementDeathReduction',
    DisplayName = '<LOC ITEM_Achievement_0021>Charm of Life',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0003>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
        },
        Passives = '<LOC ITEM_Achievement_0022>Death Penalty time reduced by [GetDeathBonus]%.',
    },
    GetHealthBonus = function(self) return Buffs['AchievementDeathReduction'].Affects.MaxHealth.Add end,
    GetRegenBonus = function(self) return Buffs['AchievementDeathReduction'].Affects.Regen.Add end,
    GetDeathBonus = function(self) return math.floor( Buffs['AchievementDeathReduction'].Affects.DeathPenaltyMult.Add * -100 ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/CharmofLife',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementDeathReduction',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/CharmofLife',
            FromItem = 'AchievementDeathReduction',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementDeathReduction',
                    BuffType = 'ACHIEVEMENTDEATHREDUCTION',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 400, AdjustHealth = true},
                        Regen = {Add = 5},
                        DeathPenaltyMult = {Add = -0.1},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Regeneration of the Seraphim
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementAERegen',
    DisplayName = '<LOC ITEM_Achievement_0023>Wings of the Seraphim',
    Description = '<LOC ITEM_Achievement_0024>Use: +[GetRegenBonus] Health Per Second Aura for [GetDuration] seconds. Any damage will break this effect.\n\nThe effect works only on Demigods.',
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/RegenerationoftheSeraphim',
    InventoryType = 'Achievement',
    GetRegenBonus = function(self) return Buffs['AchievementAERegen'].Affects.Regen.Add end,
    GetDuration = function(self) return Buffs['AchievementAERegen'].Duration end,
    GetMaxRange = function(self) return Ability['AchievementAERegen'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementAERegen'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementAERegen'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementAERegen'].Cooldown end,
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementAERegen',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            InventoryType = 'Achievement',
            TargetCategory = 'HERO - UNTARGETABLE',
            Cooldown = 45,
            EnergyCost = 0,
            AffectRadius = 8,
            Icon = '/NewIcons/AchievementRewards/RegenerationoftheSeraphim',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_regen_seraphim',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'AchievementAERegen',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementAERegen',
                    DisplayName = '<LOC ITEM_Achievement_0023>Wings of the Seraphim',
                    Description = '<LOC ITEM_Achievement_0078>Increased Health Per Second.',
                    BuffType = 'ACHIEVEMENTAEREGEN',
                    Icon = '/NewIcons/AchievementRewards/RegenerationoftheSeraphim',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 10,
                    Affects = {
                        Regen = {Add = 200},
                    },
                    Effects = 'Heal02',
                    EffectsBone = -2,
                    OnApplyBuff = function(self, unit, instigator)
                        unit.Callbacks.OnTakeDamage:Add(self.SeraphimDamaged, self)
                    end,
                    SeraphimDamaged = function(self, unit, data)
                        if Buff.HasBuff(unit, 'AchievementAERegen') then
                            Buff.RemoveBuff(unit, 'AchievementAERegen')
                        end
                        unit.Callbacks.OnTakeDamage:Remove(self.SeraphimDamaged)
                    end,
                    OnBuffRemove= function(self,unit)
                        unit.Callbacks.OnTakeDamage:Remove(self.SeraphimDamaged)
                    end,
                }
            },
        }
    },
}

#################################################################################################################
# Magical Coin Pouch
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementGoldIncome',
    DisplayName = '<LOC ITEM_Achievement_0026>Magical Coin Pouch',
    Tooltip = {
          Passives = '<LOC ITEM_Achievement_0027>Decreases cost of items by [GetCostBonus]%.',
    },
    GetCostBonus = function(self) return math.floor( Buffs['AchievementGoldIncome'].Affects.ItemCost.Add * -100 )end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/MagicalCoinPouch',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementGoldIncome',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/MagicalCoinPouch',
            FromItem = 'AchievementGoldIncome',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementGoldIncome',
                    BuffType = 'ACHIEVEMENTGOLDINCOME',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        ItemCost = {Add = -0.1},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Brilliant Bauble
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementXPIncome',
    DisplayName = '<LOC ITEM_Achievement_0028>Brilliant Bauble',
    Tooltip = {
          Passives = '<LOC ITEM_Achievement_0029>Increases experience gained by [GetExperienceBonus]%.',
    },
    GetExperienceBonus = function(self) return math.floor( Buffs['AchievementXPIncome'].Affects.Experience.Add * 100 )end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/BrilliantBauble',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementXPIncome',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/BrilliantBauble',
            FromItem = 'AchievementXPIncome',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementXPIncome',
                    BuffType = 'ACHIEVEMENTXPINCOME',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Experience = {Add = 0.1},
                    },
                }
            },
        }
    },
}

# Assassin Achievement Items
#################################################################################################################
# Mard's Hammer
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementDamage',
    DisplayName = '<LOC ITEM_Achievement_0030>Mard\'s Hammer',
    Tooltip = {
        Bonuses = {
          	'<LOC ITEM_Achievement_0066>+[GetDmageBonus] Weapon Damage',
          	'<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
          },
    },
    GetDmageBonus = function(self) return Buffs['AchievementDamage'].Affects.DamageRating.Add end,
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['AchievementDamage'].Affects.RateOfFire.Mult * 100 ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/HammerofDestruction',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementDamage',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/HammerofDestruction',
            FromItem = 'AchievementDamage',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementDamage',
                    BuffType = 'ACHIEVEMENTDAMAGE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 40},
                        RateOfFire = {Mult = 0.05},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Staff of Renewal
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementRefreshCooldowns',
    DisplayName = '<LOC ITEM_Achievement_0032>Staff of Renewal',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0097>+[GetHealthBonus] Health',
            '<LOC ITEM_Artifact_0098>+[GetManaBonus] Mana',
            '<LOC ITEM_Achievement_0009>[GetCooldownBonus]% to ability cooldowns',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/StaffofRenewal',
    InventoryType = 'Achievement',
    GetCooldownBonus = function(self) return math.floor(Buffs['AchievementRefreshCooldownsPassive'].Affects.Cooldown.Mult * 100) end,
    GetHealthBonus = function(self) return Buffs['AchievementRefreshCooldownsPassive'].Affects.MaxHealth.Add end,
    GetManaBonus = function(self) return Buffs['AchievementRefreshCooldownsPassive'].Affects.MaxEnergy.Add end,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementRefreshCooldownsPassive',
            AbilityType = 'Quiet',
            FromItem = 'AchievementRefreshCooldowns',
            Icon = '/NewIcons/AchievementRewards/StaffofRenewal',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementRefreshCooldownsPassive',
                    BuffType = 'ACHIEVEMENTCOOLDOWNPASSIVE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 200, AdjustHealth = true},
                        MaxEnergy = {Add = 175, AdjustEnergy = true},
                        Cooldown = {Mult = -0.20},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Blade of the Serpent
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementManaLeech',
    DisplayName = '<LOC ITEM_Achievement_0034>Blade of the Serpent',
    Description = '<LOC ITEM_Achievement_0035>Use: 100% chance on hit to gain [GetRegenBonus]% of your damage in Mana for [GetDuration] seconds.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0098>+[GetManaBonus] Mana',
            '<LOC ITEM_Glove_0001>+[GetDamageBonus] Weapon Damage',
        },
    },
    GetRegenBonus = function(self) return math.floor( Buffs['AchievementManaLeech'].EnergyReturnPercent * 100 ) end,
    GetDuration = function(self) return Buffs['AchievementManaLeech'].Duration end,
    GetMaxRange = function(self) return Ability['AchievementManaLeech'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementManaLeech'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementManaLeech'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementManaLeech'].Cooldown end,
    GetDamageBonus = function(self) return Buffs['AchievementManaLeechPassive'].Affects.DamageRating.Add end,
    GetManaBonus = function(self) return Buffs['AchievementManaLeechPassive'].Affects.MaxEnergy.Add end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/BladeoftheSerpent',
    InventoryType = 'Achievement',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Name = 'AchievementManaLeech',
            FromItem = 'AchievementManaLeech',
            Name = 'AchievementManaLeech',
            Icon = '/NewIcons/AchievementRewards/BladeoftheSerpent',
            Cooldown = 45,
            EnergyCost = 0,
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_blade_of_the_serpent',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            Buffs = {
                BuffBlueprint {
                    BuffType = 'BLADEOFTHESERPENTLEECH',
                    DisplayName = '<LOC ITEM_Achievement_0034>Blade of the Serpent',
                    Description = '<LOC ITEM_Achievement_0077>Attacks return Mana.',
                    Debuff = false,
                    Duration = 10,
                    EntityCategory = 'ALLUNITS',
                    EnergyReturnPercent = 0.75,
                    Name = 'AchievementManaLeech',
                    Stacks = 'ALWAYS',
                    Icon = '/NewIcons/AchievementRewards/BladeoftheSerpent',
                    Affects = {
                    },
                    OnBuffAffect = function(self, unit, instigator)
                        unit.Callbacks.OnPostDamage:Add(Leech, self)
                    end,
                    OnBuffRemove = function(self, unit)
                        unit.Callbacks.OnPostDamage:Remove(Leech)
                    end,
                    Effects = 'Energize01',
                    EffectsBone = -2,
                },
            },
        },
        AbilityBlueprint {
            Name = 'AchievementManaLeechPassive',
            AbilityType = 'Quiet',
            FromItem = 'AchievementManaLeech',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementManaLeechPassive',
                    BuffType = 'ACHIEVEMENTMANALEECHPASSIVE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 25},
                        MaxEnergy = {Add = 400, AdjustEnergy = true},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# CE: Blade of the Serpent
#################################################################################################################
Leech = function(self, unit, target, data)
    damage = data.Amount
    if(damage > 0) then
        local energyReturn = damage * self.EnergyReturnPercent
        local currentEnergy = (unit.Energy or unit:GetBlueprint().Energy.EnergyStart) or 0
        local newEnergy = energyReturn + currentEnergy

        if(newEnergy > unit.EnergyMax) then
            newEnergy = unit.EnergyMax
        end

        local energyBonus = newEnergy - currentEnergy
        if(energyBonus > 0) then
            unit:SetEnergy(newEnergy)
            energyBonus = math.ceil(energyBonus)
            FloatTextAt(unit:GetFloatTextPositionOffset(0, 1, 0), '+' .. tostring(energyBonus), 'EnergyRegen', unit:GetArmy())
        end
    end
end,

#################################################################################################################
# Purified Essence of Magic
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementFreeSpells',
    DisplayName = '<LOC ITEM_Achievement_0037>Essence of Magic',
    Description = '<LOC ITEM_Achievement_0038>Use: The cost of all abilities is reduced to 0 for [GetDuration] seconds.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0098>+[GetManaBonus] Mana',
            '<LOC ITEM_Boot_0012>+[GetManaRegenBonus] Mana Per Second',
        },
    },
    GetDuration = function(self) return Buffs['AchievementFreeSpells'].Duration end,
    GetMaxRange = function(self) return Ability['AchievementFreeSpells'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementFreeSpells'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementFreeSpells'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementFreeSpells'].Cooldown end,
    GetManaRegenBonus = function(self) return Buffs['AchievementFreeSpellsPassive'].Affects.EnergyRegen.Add end,
    GetManaBonus = function(self) return Buffs['AchievementFreeSpellsPassive'].Affects.MaxEnergy.Add end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/PurifiedEssenceofMagic',
    InventoryType = 'Achievement',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementFreeSpells',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 45,
            EnergyCost = 0,
            Icon = '/NewIcons/AchievementRewards/PurifiedEssenceofMagic',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementFreeSpells',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'AchievementFreeSpells',
            OnStartAbility = function(self, unit)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.PurifiedEssenceOfMagicActivate, -2 )
            end,
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementFreeSpells',
                    BuffType = 'ACHIEVEMENTFREESPELLS',
                    DisplayName = '<LOC ITEM_Achievement_0037>Essence of Magic',
                    Description = '<LOC ITEM_Achievement_0039>Abilities have no Mana cost.',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 3,
                    Icon = '/NewIcons/AchievementRewards/PurifiedEssenceofMagic',
                    Affects = {
                        SpellCostMult = {Add = -1},
                    },
                }
            },
        },
        AbilityBlueprint {
            Name = 'AchievementFreeSpellsPassive',
            AbilityType = 'Quiet',
            FromItem = 'AchievementFreeSpells',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementFreeSpellsPassive',
                    BuffType = 'ACHIEVEMENTFREESPELLSPASSIVE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        EnergyRegen = {Add = 7},
                        MaxEnergy = {Add = 210, AdjustEnergy = true},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Poisoned Dagger
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementSnare',
    DisplayName = '<LOC ITEM_Achievement_0040>Poisoned Dagger',
    Tooltip = {
          ChanceOnHit = '<LOC ITEM_Achievement_0041>[GetProcChance]% chance on hit to reduce Movement Speed by [GetMovementSpeedReduction]% for [GetDuration] seconds.',
          TargetAlliance = 'Enemy',
          Bonuses = {
            '<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
        },
    },
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['AchievementSnarePassive'].Affects.RateOfFire.Mult * 100 ) end,
    GetProcChance = function(self) return Ability['AchievementSnare'].WeaponProcChance end,
    GetMovementSpeedReduction = function(self) return math.floor( Buffs['AchievementSnareSlow'].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return Buffs['AchievementSnareSlow'].Duration end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/PoisonedDaggerofHate',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementSnare',
            AbilityType = 'WeaponProc',
            Icon = '/NewIcons/AchievementRewards/PoisonedDaggerofHate',
            FromItem = 'AchievementSnare',
            WeaponProcChance = 20,
            WeaponProcChanceRanged = 13,
            OnWeaponProc = function(self, unit, target, damageData)
                if not target:IsDead() then
                    Buff.ApplyBuff(target, 'AchievementSnareSlow', unit)
                end
            end,
        },
        AbilityBlueprint {
            Name = 'AchievementSnarePassive',
            AbilityType = 'Quiet',
            FromItem = 'AchievementSnare',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementSnarePassive',
                    BuffType = 'ACHIEVEMENTSNAREPASSIVE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        RateOfFire = {Mult = .05},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Buff: Poisoned Dagger
#################################################################################################################
BuffBlueprint {
    Name = 'AchievementSnareSlow',
    DisplayName = '<LOC ITEM_Achievement_0040>Poisoned Dagger',
    Description = '<LOC ITEM_Achievement_0042>Movement Speed reduced.',
    BuffType = 'ACHIEVEMENTSNARESLOW',
    EntityCategory = 'MOBILE - UNTARGETABLE',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 8,
    Icon = '/NewIcons/AchievementRewards/PoisonedDaggerofHate',
    Affects = {
        MoveMult = {Mult = -0.25},
    },
    Effects = 'Slow01',
    EffectsBone = -2,
}

#################################################################################################################
# Heaven's Wrath
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementFinger',
    DisplayName = '<LOC ITEM_Achievement_0043>Heaven\'s Wrath',
    Description = '<LOC ITEM_Achievement_0044>Use: Fire a beam of searing light at the targeted location, dealing [GetDamage] damage and throwing smaller units into the air.',
    GetMaxRange = function(self) return Ability['AchievementFinger'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementFinger'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementFinger'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementFinger'].Cooldown end,
    GetDamage = function(self) return Ability['AchievementFinger'].DamageAmount end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    InventoryType = 'Achievement',
    Icon = '/NewIcons/AchievementRewards/FingerofGod',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementFinger',
            AbilityType = 'TargetedArea',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            TargetingMethod = 'AREAARGETED',
            Cooldown = 45,
            EnergyCost = 0,
            Reticule = 'AoE_Finger_of_God',
            AffectRadius = 7,
            Icon = '/NewIcons/AchievementRewards/FingerofGod',
            MetaImpactRadius = 10,
            MetaImpactAmount = 8,
            DamageAmount = 250,
            FromItem = 'AchievementFinger',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementFinger',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},

             },
            OnStartAbility = function(self, unit, params)
                local thd = ForkThread(self.SuperWeaponThread, self, unit, params)
                unit.TrashOnKilled:Add(thd)
            end,

            Effects = {
                Base = 'FingerOfGod',
                Beams = 'Beam01',
                Impact = 'Impact01',
                Muzzle = 'Muzzle01',
                Charge = 'Charge01',
            },

            SuperWeaponThread = function(self, unit, params)
                #Start Firing
                local weps = unit:GetAIBrain():GetListOfUnits(categories.SUPERWEAPON, false)
                if table.getn(weps) > 0 then
                    unit = weps[1]
                end
                local beginEnt = Entity{}
                local upos = table.copy(unit:GetPosition())
                local epos = params.Target.Position
                upos[2] = 500
                local army = unit:GetArmy()
                local emitTrash = TrashBag()
                Warp(beginEnt, upos)

                #### Muzzle Charge Emitters
                local emitIds = AttachEffectAtBone( unit, self.Effects.Base, self.Effects.Charge, 0, unit.TrashOnKilled )
                if emitIds then
                    for k, v in emitIds do
                        emitTrash:Add(v)
                    end
                end

                WaitSeconds(0.75)

                #### Muzzle Flash Emitters
                emitIds = AttachEffectAtBone( unit, self.Effects.Base, self.Effects.Muzzle, 0, unit.TrashOnKilled )

                local viz = import('/lua/sim/VizMarker.lua').VizMarker {
                    X = epos[1],
                    Z = epos[3],
                    LifeTime = 3,
                    Radius = 2 * self.AffectRadius,
                    Army = army,
                    Omni = false,
                    Radar = false,
                    WaterVision = false,
                    Vision = true,
                }

                unit.TrashOnKilled:Add(viz)
                emitTrash:Add(viz)

                WaitSeconds(0.25)

                #End!
                local endEnt1 = Entity{}
                local endEnt2 = Entity{}
                local endEntPos = table.copy(epos)
                endEntPos[2] = 500
                Warp(endEnt1, endEntPos)
                Warp(endEnt2, epos)

                unit.TrashOnKilled:Add(beginEnt)
                emitTrash:Add(beginEnt)
                unit.TrashOnKilled:Add(endEnt1)
                emitTrash:Add(endEnt1)
                unit.TrashOnKilled:Add(endEnt2)
                emitTrash:Add(endEnt2)

                endEnt2:ShakeCamera(1000, 5, 3, 0.2)
                endEnt2:PlaySound ( 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementFinger_impact');
                #IMPACT!

                #### Beam Downwards
                emitIds = AttachBeamEffectOnEntities( self.Effects.Base, nil, self.Effects.Beams, endEnt1, -1, endEnt2, -1, army, unit.TrashOnKilled )
                if emitIds then
                    for k, v in emitIds do
                        emitTrash:Add(v)
                    end
                end

                #### Impact Emitters
                local fxpos = epos
                fxpos[2] = GetSurfaceHeight(fxpos[1], fxpos[3])
                emitIds = CreateTemplatedEffectAtPos( self.Effects.Base, nil, self.Effects.Impact, unit:GetArmy(), fxpos, nil, unit.TrashOnKilled )

                local data = {
                    Instigator = unit,
                    InstigatorBp = unit:GetBlueprint(),
                    InstigatorArmy = unit:GetArmy(),
                    Origin = epos,
                    Radius = self.MetaImpactRadius,
                    Amount = self.MetaImpactAmount,
                    Category = 'METAINFANTRY',
                    DamageFriendly = false,
                }
                MetaImpact(data)

                data = {
                    Instigator = unit,
                    InstigatorBp = unit:GetBlueprint(),
                    InstigatorArmy = unit:GetArmy(),
                    Amount = self.DamageAmount,
                    Type = 'Light',
                    Radius = self.AffectRadius,
                    DamageAction = self.Name,
                    DamageSelf = false,
                    Origin = epos,
                    CanCrit = false,
                    CanBackfire = false,
                    CanBeEvaded = false,
                    CanMagicResist = true,
                    ArmorImmune = true,
                    NoFloatText = false,
                    Group = 'UNITS',
                }

                DamageArea(data)
                WaitSeconds(1.0)
                emitTrash:Destroy()
                emitTrash = nil
            end,
        }
    },
}

#################################################################################################################
# Sword of a Thousand Blows
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementFlurry',
    DisplayName = '<LOC ITEM_Achievement_0045>Furious Blade',
    Tooltip = {
          ChanceOnHit = '<LOC ITEM_Achievement_0046>[GetProcChance]% chance on hit to increase Attack Speed by [GetMovementSpeedReduction]% for [GetDuration] seconds.',
          Bonuses = {
            '<LOC ITEM_Artifact_0097>+[GetHealthBonus] Health',
            '<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
        },
    },
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['AchievementFlurryPassive'].Affects.RateOfFire.Mult * 100 ) end,
    GetHealthBonus = function(self) return ( Buffs['AchievementFlurryPassive'].Affects.MaxHealth.Add ) end,
    GetProcChance = function(self) return Ability['AchievementFlurry'].WeaponProcChance end,
    GetMovementSpeedReduction = function(self) return math.floor( Buffs['AchievementFlurryBuff'].Affects.RateOfFire.Mult * 100 ) end,
    GetDuration = function(self) return Buffs['AchievementFlurryBuff'].Duration end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/SwordofaThousandBlows',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementFlurry',
            AbilityType = 'WeaponProc',
            Icon = '/NewIcons/AchievementRewards/SwordofaThousandBlows',
            FromItem = 'AchievementFlurry',
            WeaponProcChance = 15,
            WeaponProcChanceRanged = 10,
            OnWeaponProc = function(self, unit, target, damageData)
                Buff.ApplyBuff(unit, 'AchievementFlurryBuff', unit)
            end,

        },
        AbilityBlueprint {
            Name = 'AchievementFlurryPassive',
            AbilityType = 'Quiet',
            FromItem = 'AchievementFlurry',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementFlurryPassive',
                    BuffType = 'ACHIEVEMENTFLURRYPASSIVE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 100, AdjustHealth = true},
                        RateOfFire = {Mult = .05},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Buff: Sword of a Thousand Blows
#################################################################################################################
BuffBlueprint {
    Name = 'AchievementFlurryBuff',
    DisplayName = '<LOC ITEM_Achievement_0045>Furious Blade',
    Description = '<LOC ITEM_Achievement_0047>Increased Attack Speed',
    BuffType = 'ACHIEVEMENTFLURRYBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 5,
    Icon = '/NewIcons/AchievementRewards/SwordofaThousandBlows',
    Affects = {
        RateOfFire = {Mult = 0.3},
    },
    Effects = 'Rage01',
    EffectsBone = -2,
}

# General Achievements
#################################################################################################################
# Charred Totem of War
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementMinionDamage',
    DisplayName = '<LOC ITEM_Achievement_0048>Totem of War',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0001>+[GetDamageBonus] Weapon Damage',
            '<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
        },
        MBonuses = {
            '<LOC MBONUS_0004>+[GetMinionDamageBonus] Minion Damage',
        },
    },
    GetMinionDamageBonus = function(self) return math.floor( Buffs['AchievementMinionDamageBuff'].Affects.DamageRating.Add ) end,
    GetDamageBonus = function(self) return Buffs['AchievementMinionDamage'].Affects.DamageRating.Add end,
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['AchievementMinionDamage'].Affects.RateOfFire.Mult * 100 ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/CharredTotemofWar',
    InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementMinionDamage',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/CharredTotemofWar',
            FromItem = 'AchievementMinionDamage',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementMinionDamage',
                    BuffType = 'ACHIEVEMENTMINIONDAMAGE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 15},
                        RateOfFire = {Mult = 0.05},
                    },
                }
            },
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'AchievementMinionDamageBuff', unit )
            end,
        }
    },
}

#################################################################################################################
# Buff: Charred Totem of War
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'AchievementMinionDamageBuff',
    DisplayName = '<LOC ITEM_Achievement_0048>Totem of War',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    InventoryType = 'Achievement',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'AchievementMinionDamageBuff',
            DisplayName = '<LOC ITEM_Achievement_0048>Totem of War',
            Description = '<LOC ITEM_Achievement_0074>Increased Damage.',
            BuffType = 'ACHIEVEMENTMINIONDAMAGEBUFF',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Icon = '/NewIcons/AchievementRewards/CharredTotemofWar',
            Affects = {
                DamageRating = {Add = 5},
            },
        }
    }
}

#################################################################################################################
# Tome of Endurance
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementMinionHealth',
    DisplayName = '<LOC ITEM_Achievement_0051>Tome of Endurance',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0003>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
        },
        MBonuses = {
            '<LOC MBONUS_0000>+[GetMinionHealthBonus] Minion Health',
        },
    },
    GetHealthBonus = function(self) return Buffs['AchievementMinionHealth'].Affects.MaxHealth.Add end,
    GetRegenBonus = function(self) return Buffs['AchievementMinionHealth'].Affects.Regen.Add end,
    GetMinionHealthBonus = function(self) return math.floor( Buffs['AchievementMinionHealthBuff'].Affects.MaxHealth.Add ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/TomeofEndurance',
	InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementMinionHealth',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/TomeofEndurance',
            FromItem = 'AchievementMinionHealth',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementMinionHealth',
                    BuffType = 'ACHIEVEMENTMINIONHEALTH',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 400, AdjustHealth = true},
                        Regen = {Add = 5},
                    },
                }
            },
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'AchievementMinionHealthBuff', unit )
            end,
        }
    },
}

#################################################################################################################
# Buff: Tome of Endurance
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'AchievementMinionHealthBuff',
    DisplayName = '<LOC ITEM_Achievement_0051>Tome of Endurance',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    InventoryType = 'Achievement',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'AchievementMinionHealthBuff',
            DisplayName = '<LOC ITEM_Achievement_0051>Tome of Endurance',
            Description = '',
            Tooltip = {
                  Passives = '<LOC ITEM_Achievement_0075>Increased Health.',
            },
            BuffType = 'ACHIEVEMENTMINIONHEALTHBUFF',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            #Icon = '/NewIcons/AchievementRewards/TomeofEndurance',
            Affects = {
                MaxHealth = {Add = 130, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Pendant of Grace
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementMinionEvasion',
    DisplayName = '<LOC ITEM_Achievement_0054>Pendant of Grace',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Boot_0013>+[GetDodgeBonus]% Dodge',
        },
        MBonuses = {
            '<LOC MBONUS_0007>+[GetDodgeBuff]% Minion Dodge',
        },
    },
    GetDodgeBuff = function(self) return Buffs['AchievementMinionEvasionBuff'].Affects.Evasion.Add end,
    GetDodgeBonus = function(self) return Buffs['AchievementMinionDodge'].Affects.Evasion.Add end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/PendantofConservation',
	InventoryType = 'Achievement',
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementMinionEvasion',
            AbilityType = 'Quiet',
            Icon = '/NewIcons/AchievementRewards/PendantofConservation',
            FromItem = 'AchievementMinionEvasion',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementMinionDodge',
                    BuffType = 'ACHIEVEMENTMINIONDODGE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Evasion = {Add = 10},
                    },
                }
            },
            OnStartAbility = function(self, unit, params)
                unit:GetAIBrain():AddArmyBonus( 'AchievementMinionEvasionBuff', unit )
            end,
        }
    },
}

#################################################################################################################
# Buff: Pendant of Grace
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'AchievementMinionEvasionBuff',
    DisplayName = '<LOC ITEM_Achievement_0054>Pendant of Grace',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    InventoryType = 'Achievement',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'AchievementMinionEvasionBuff',
            DisplayName = '<LOC ITEM_Achievement_0054>Pendant of Grace',
            Description = '<LOC ITEM_Achievement_0076>Increased Dodge',
            BuffType = 'ACHIEVEMENTMINIONEVASIONBUFF',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Icon = '/NewIcons/AchievementRewards/PendantofConservation',
            Affects = {
                Evasion = {Add = 15},
            },
        }
    }
}

#################################################################################################################
# Ring of Divine Might
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementMinionMeta',
    DisplayName = '<LOC ITEM_Achievement_0056>Ring of Divine Might',
    Description = '<LOC ITEM_Achievement_0057>Use: Minions are infused with divine power, allowing them to knock away smaller units for 10 seconds.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0103>+[GetDamageBonusSelf] Weapon Damage',
        },
        MBonuses = {
            '<LOC MBONUS_0004>+[GetMinionDamageBonus] Minion Damage',
        },
    },
    GetMaxRange = function(self) return Ability['AchievementMinionMeta'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementMinionMeta'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementMinionMeta'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementMinionMeta'].Cooldown end,
    GetDamageBonusSelf = function(self) return Buffs['AchievementMinionMetaPassives'].Affects.DamageRating.Add end,
    GetMinionDamageBonus = function(self) return Buffs['AchievementMinionMetaPassive'].Affects.DamageRating.Add end,
    Mesh = '/meshes/items/rings/ring01_mesh',
    Animation = '/meshes/items/rings/Animations/ring01_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/RingoftheGeneral',
    InventoryType = 'Achievement',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementMinionMeta',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'ALLUNITS - UNTARGETABLE',
            Cooldown = 45,
            EnergyCost = 0,
            Icon = '/NewIcons/AchievementRewards/RingoftheGeneral',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementMinionMeta',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'AchievementMinionMeta',
            OnStartAbility = function(self, unit, params)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.PurifiedEssenceOfMagicActivate, -2 )
                --unit:GetAIBrain():AddArmyBonus( 'AchievementMinionMetaBuff', unit )
                local aiBrain = unit:GetAIBrain()
                local minions = aiBrain:GetListOfUnits(categories.MINION, false)
                for _,minion in minions do
                    Buff.ApplyBuff(minion, 'AchievementMinionMetaBuff', unit)
                end
            end,
        },
        AbilityBlueprint {
            Name = 'AchievementMinionMetaPassives',
            AbilityType = 'Quiet',
            FromItem = 'AchievementMinionMeta',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementMinionMetaPassives',
                    BuffType = 'ACHIEVEMENTMINIONMETAPASSIVE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 15},
                    },
                }
            },
            OnStartAbility = function(self, unit, params)
                unit:GetAIBrain():AddArmyBonus( 'AchievementMinionMetaPassive', unit )
            end,
        }
    },
}

ArmyBonusBlueprint {
    Name = 'AchievementMinionMetaPassive',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    InventoryType = 'Achievement',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'AchievementMinionMetaPassive',
            BuffType = 'ACHIEVEMENTMINIONMETAPASSIVEBUFF',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Icon = '/NewIcons/AchievementRewards/PendantofConservation',
            Affects = {
                DamageRating = {Add = 10},
            },
        }
    }
}

#################################################################################################################
# Buff: Ring of Divine Might
#################################################################################################################
BuffBlueprint {
    Name = 'AchievementMinionMetaBuff',
    DisplayName = '<LOC ITEM_Achievement_0056>Ring of Divine Might',
    Description = '<LOC ITEM_Achievement_0070>Attacks will knock away smaller units.',
    BuffType = 'ACHIEVEMENTMINIONMETABUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 10,
    Icon = '/NewIcons/AchievementRewards/RingoftheGeneral',
    Affects = {
        MetaAmount = {Add = 8},
        MetaRadius = {Add = 2},
    },
    Effects = 'Lifesteal02',
    EffectsBone = -2,
}

#################################################################################################################
# Horn of Battle
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementMinionBuff',
    DisplayName = '<LOC ITEM_Achievement_0058>Horn of Battle',
    Description = '<LOC ITEM_Achievement_0059>Use: Minions gain +[GetRegenBuff] Health Per Second for [GetDuration] seconds.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
        },
    },
    GetRegenBonus = function(self) return Buffs['AchievementMinionBuffSelf'].Affects.Regen.Add end,
    GetRegenBuff = function(self) return Buffs['AchievementMinionInvulnBuff'].Affects.Regen.Add end,
    GetDuration = function(self) return Buffs['AchievementMinionInvulnBuff'].Duration end,
    GetMaxRange = function(self) return Ability['AchievementMinionBuff'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementMinionBuff'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementMinionBuff'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementMinionBuff'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/AvesheonsHornofBattle',
    InventoryType = 'Achievement',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementMinionBuff',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'ALLUNITS - UNTARGETABLE',
            Cooldown = 45,
            EnergyCost = 0,
            Icon = '/NewIcons/AchievementRewards/AvesheonsHornofBattle',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementMinionBuff',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'AchievementMinionBuff',
            OnStartAbility = function(self, unit, params)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.PurifiedEssenceOfMagicActivate, -2 )
                --unit:GetAIBrain():AddArmyBonus( 'AchievementMinionInvulnArmyBuff', unit )
                local aiBrain = unit:GetAIBrain()
                local minions = aiBrain:GetListOfUnits(categories.MINION, false)
                for _,minion in minions do
                    Buff.ApplyBuff(minion, 'AchievementMinionInvulnBuff', unit)
                end
            end,
        },
        AbilityBlueprint {
            Name = 'AchievementMinionBuffSelf',
            AbilityType = 'Quiet',
            FromItem = 'AchievementMinionBuff',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementMinionBuffSelf',
                    BuffType = 'ACHIEVEMENTMINIONBUFFSELF',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Regen = {Add = 10},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Buff: Horn of Battle
#################################################################################################################
BuffBlueprint {
    Name = 'AchievementMinionInvulnBuff',
    DisplayName = '<LOC ITEM_Achievement_0058>Horn of Battle',
    Description = '<LOC ITEM_Achievement_0072>Increased Health Per Second.',
    BuffType = 'ACHIEVEMENTMINIONHEALTHBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 10,
    Icon = '/NewIcons/AchievementRewards/AvesheonsHornofBattle',
    Affects = {
        Regen = {Add = 200},
    },
    Effects = 'Heal01',
    EffectsBone = -2,
}

#################################################################################################################
# Blood Soaked Wand
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementAEHeal',
    DisplayName = '<LOC ITEM_Achievement_0061>Blood Soaked Wand',
    Description = '<LOC ITEM_Achievement_0062>Use: Heal self and all nearby allies for [GetHealthBuff].',
    GetHealthBuff = function(self) return Buffs['AchievementAEHeal'].Affects.Health.Add end,
    GetMaxRange = function(self) return Ability['AchievementAEHeal'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementAEHeal'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementAEHeal'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementAEHeal'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/BloodSoakedWand',
    InventoryType = 'Achievement',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementAEHeal',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            Cooldown = 45,
            CastingTime = 2,
            CastAction = 'CastItem2sec',
            EnergyCost = 0,
            AffectRadius = 15,
            Icon = '/NewIcons/AchievementRewards/BloodSoakedWand',
             Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementAEHeal',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'AchievementAEHeal',
            OnStartAbility = function(self, unit, params)
                # Effects on triggering Hero, showing AoE heal
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.BloodSoakedWand01, -2 )
            end,
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementAEHeal',
                    BuffType = 'ACHIEVEMENTAEHEAL',
                    IgnoreDamageRangePercent = true,
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    DamageSelf = true,
                    DamageFriendly = true,
                    CanCrit = false,
                    ArmorImmune = true,
                    CanBackFire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Duration = -1,
                    Affects = {
                        Health = {Add = 1000},
                    },
                }
            },
        }
    },
}

#################################################################################################################
# Cloak of Night
#################################################################################################################
ItemBlueprint {
    Name = 'AchievementMinionInvis',
    DisplayName = '<LOC ITEM_Achievement_0063>Cloak of Night',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0001>+[GetManaBonus] Mana',
            '<LOC ITEM_Boot_0012>+[GetManaRegenBonus] Mana Per Second',
        },
    },
    Description = '<LOC ITEM_Achievement_0064>Use: Warp to a targeted location, dealing [GetDamage] damage upon entry.',
    GetManaBonus = function(self) return Buffs['AchievementMinionInvisSelf'].Affects.MaxEnergy.Add end,
    GetManaRegenBonus = function(self) return Buffs['AchievementMinionInvisSelf'].Affects.EnergyRegen.Add end,
    GetDamage = function(self) return Ability['AchievementMinionInvis'].DamageAmt end,
    GetMaxRange = function(self) return Ability['AchievementMinionInvis'].RangeMax end,
    GetEnergyCost = function(self) return Ability['AchievementMinionInvis'].EnergyCost end,
    GetCastTime = function(self) return Ability['AchievementMinionInvis'].CastingTime end,
    GetCooldown = function(self) return Ability['AchievementMinionInvis'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = '/NewIcons/AchievementRewards/CloakofNight',
    InventoryType = 'Achievement',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'AchievementMinionInvis',
            AbilityType = 'TargetedArea',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Enemy',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            AffectRadius = 10,
            RangeMax = 15,
            Cooldown = 60,
            SharedCooldown = 'WarpItems',
            EnergyCost = 0,
            DamageAmt = 100,
            FromItem = 'AchievementMinionInvis',
            Icon = '/NewIcons/AchievementRewards/CloakofNight',
            CasterEffect = {
                Base = 'Items',
                Group = 'Artifacts',
                Template = 'ScrotusWarp01',
            },
             Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Achievement/snd_item_achievement_AchievementMinionInvis',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            WarpToLocation = true,
            WarpMinions = false,
            Icon = 'NewIcons/Artifacts/cloakofelfinkind',
            Reticule = 'AoE_Warp',
            OnStartAbility = function(self, unit, params)
                local data = {
                    Instigator = unit,
                    InstigatorBp = unit:GetBlueprint(),
                    InstigatorArmy = unit:GetArmy(),
                    Origin = params.Target.Position,
                    Radius = self.AffectRadius,
                    Amount = self.DamageAmt,
                    Type = 'Spell',
                    DamageAction = 'AchievementMinionInvis',
                    DamageSelf = false,
                    DamageFriendly = false,
                    CanBeEvaded = false,
                    CanBackfire = false,
                    DamageFriendly = false,
                    ArmorImmune = true,
                    CanCrit = false,
                    CanMagicResist = false,
                    CanOverKill = false,
                    Group = 'UNITS',
                }
                DamageArea(data)

                # Effects at targeted position
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.CloakOfNightActivate, -2 )
            end,
        },
        AbilityBlueprint {
            Name = 'AchievementMinionInvisSelf',
            AbilityType = 'Quiet',
            FromItem = 'AchievementMinionInvis',
            Buffs = {
                BuffBlueprint {
                    Name = 'AchievementMinionInvisSelf',
                    BuffType = 'ACHIEVEMENTMINIONINVISSELF',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxEnergy = {Add = 280, AdjustEnergy = true},
                        EnergyRegen = {Add = 4},
                    },
                }
            },
        }
    },
}

__moduleinfo.auto_reload = true
