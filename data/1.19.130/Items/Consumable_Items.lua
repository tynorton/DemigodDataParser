#################################################################################################################
# Clickable Shop / Consumable Shop
# Shop and costs defined in //depot/forge/main/bindata/units/ug/b/ugbshop07/UGBShop07_unit.bp
#################################################################################################################

local Buff = import('/lua/sim/buff.lua')
local Entity = import('/lua/sim/entity.lua').Entity

#################################################################################################################
# Health Potion
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Health_Potion',
    DisplayName = '<LOC ITEM_Consumable_0000>Combat Health Potion',
    Description = '<LOC ITEM_Consumable_0001>Use: Heal [GetHealAmount] Health.',
    GetHealAmount = function(self) return Buffs['Item_Health_Potion'].Affects.Health.Add end,
    GetMaxRange = function(self) return Ability['Item_Health_Potion'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Health_Potion'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Health_Potion'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Health_Potion'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion1green',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Health_Potion',
            DisplayName = '<LOC ITEM_Consumable_0000>Combat Health Potion',
            AbilityType = 'Instant',
            InventoryType = 'Clickables',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'HealthPotion',
            CastingTime = 0.5,
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Health_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Health_Potion',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Health_Potion',
                    BuffType = 'POTIONHEALTH',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    DamageSelf = true,
                    DamageFriendly = true,
                    CanCrit = false,
                    ArmorImmune = true,
                    CanBackFire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    Affects = {
                        Health = {Add = 750},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Health_Potion_FX',
                    BuffType = 'POTIONHEAL01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 3,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Heal02',
                    EffectsBone = -1,
                },
            },
            Icon = 'NewIcons/potions/Potion1green',
        },
    },
    Consumable = true,
}

#################################################################################################################
# Robust Health Potion
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Large_Health_Potion',
    DisplayName = '<LOC ITEM_Consumable_0002>Robust Health Potion',
    Description = '<LOC ITEM_Consumable_0003>Use: Heal [GetHealAmount] Health.',
    GetHealAmount = function(self) return Buffs['Item_Large_Health_Potion'].Affects.Health.Add end,
    GetMaxRange = function(self) return Ability['Item_Large_Health_Potion'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Large_Health_Potion'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Large_Health_Potion'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Large_Health_Potion'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion4green',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Large_Health_Potion',
            DisplayName = '<LOC ITEM_Consumable_0002>Robust Health Potion',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'HealthPotion',
            CastingTime = 3,
            InventoryType = 'Clickables',
            CastAction = 'CastItem3sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Large_Health_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Large_Health_Potion',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Large_Health_Potion',
                    BuffType = 'POTIONHEALTH',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    DamageSelf = true,
                    DamageFriendly = true,
                    CanCrit = false,
                    ArmorImmune = true,
                    CanBackFire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    Affects = {
                        Health = {Add = 3000},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Large_Health_Potion_FX',
                    BuffType = 'POTIONHEAL01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 3,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Heal02',
                    EffectsBone = -1,
                },
            },
            Icon = 'NewIcons/potions/Potion4green',
        },
    },
    Consumable = true,
}

#################################################################################################################
# Mana Potion
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Mana_Potion',
    DisplayName = '<LOC ITEM_Consumable_0004>Combat Mana Potion',
    Description = '<LOC ITEM_Consumable_0005>Use: Restore [GetManaAmount] Mana.',
    GetManaAmount = function(self) return Buffs['Item_Mana_Potion'].Affects.Energy.Add end,
    GetMaxRange = function(self) return Ability['Item_Mana_Potion'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Mana_Potion'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Mana_Potion'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Mana_Potion'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion1Blue',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Mana_Potion',
            DisplayName = '<LOC ITEM_Consumable_0004>Combat Mana Potion',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'EnergyPotion',
            CastingTime = 0.5,
            InventoryType = 'Clickables',
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Large_Health_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Mana_Potion',
            Icon = 'NewIcons/potions/Potion1Blue',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Mana_Potion',
                    BuffType = 'POTIONENERGY',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    Affects = {
                        Energy = {Add = 1000},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Mana_Potion_FX',
                    BuffType = 'POTIONENERGY01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 3,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Energize01',
                    EffectsBone = -1,
                },
            },
        },
    },
    Consumable = true,
}

#################################################################################################################
# Robust Mana Potion
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Large_Mana_Potion',
    DisplayName = '<LOC ITEM_Consumable_0006>Robust Mana Potion',
    Description = '<LOC ITEM_Consumable_0005>Use: Restore [GetManaAmount] Mana.',
    GetManaAmount = function(self) return Buffs['Item_Large_Mana_Potion'].Affects.Energy.Add end,
    GetMaxRange = function(self) return Ability['Item_Large_Mana_Potion'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Large_Mana_Potion'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Large_Mana_Potion'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Large_Mana_Potion'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion4Blue',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Large_Mana_Potion',
            DisplayName = '<LOC ITEM_Consumable_0006>Robust Mana Potion',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            CastingTime = 2,
            InventoryType = 'Clickables',
            CastAction = 'CastItem3sec',
            SharedCooldown = 'EnergyPotion',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Large_Mana_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Large_Mana_Potion',
            Icon = 'NewIcons/potions/Potion4Blue',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Large_Mana_Potion',
                    BuffType = 'POTIONENERGY',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    Affects = {
                        Energy = {Add = 3750},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Large_Mana_Potion_FX',
                    BuffType = 'POTIONENERGY01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 3,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Energize01',
                    EffectsBone = -1,
                },
            },
        },
    },
    Consumable = true,
}

#################################################################################################################
# Rejuvenation Elixir
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Rejuv_Elixir',
    DisplayName = '<LOC ITEM_Consumable_0008>Rejuvenation Elixir',
    Description = '<LOC ITEM_Consumable_0009>Use: Restore [GetHealthAmount] Health and [GetManaAmount] Mana.',
    GetHealthAmount = function(self) return Buffs['Item_Rejuv_Elixir'].Affects.Health.Add end,
    GetManaAmount = function(self) return Buffs['Item_Rejuv_Elixir'].Affects.Energy.Add end,
    GetMaxRange = function(self) return Ability['Item_Rejuv_Elixir'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Rejuv_Elixir'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Rejuv_Elixir'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Rejuv_Elixir'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion1Purple',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Rejuv_Elixir',
            DisplayName = '<LOC ITEM_Consumable_0008>Rejuvenation Elixir',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'RejuvenationPotion',
            CastingTime = 1,
            InventoryType = 'Clickables',
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Rejuv_Elixir',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Rejuv_Elixir',
            Icon = 'NewIcons/potions/Potion1Purple',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Rejuv_Elixir',
                    BuffType = 'POTIONREJUV',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    DamageSelf = true,
                    DamageFriendly = true,
                    CanCrit = false,
                    ArmorImmune = true,
                    CanBackFire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    Affects = {
                        Energy = {Add = 750},
                        Health = {Add = 560},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Rejuv_Elixir_FX',
                    BuffType = 'POTIONREJUVENATION01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 1,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Rejuvenation02',
                    EffectsBone = -1,
                },
            },
        },
    },
    Consumable = true,
}

#################################################################################################################
# Robust Rejuvenation Elixir
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Large_Rejuv_Elixir',
    DisplayName = '<LOC ITEM_Consumable_0010>Robust Rejuvenation Elixir',
    Description = '<LOC ITEM_Consumable_0009>Use: Restore [GetHealthAmount] Health and [GetManaAmount] Mana.',
    GetHealthAmount = function(self) return Buffs['Item_Large_Rejuv_Elixir'].Affects.Health.Add end,
    GetManaAmount = function(self) return Buffs['Item_Large_Rejuv_Elixir'].Affects.Energy.Add end,
    GetMaxRange = function(self) return Ability['Item_Large_Rejuv_Elixir'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Large_Rejuv_Elixir'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Large_Rejuv_Elixir'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Large_Rejuv_Elixir'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion4Purple',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Large_Rejuv_Elixir',
            DisplayName = '<LOC ITEM_Consumable_0010>Robust Rejuvenation Elixir',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'RejuvenationPotion',
            CastingTime = 3,
            InventoryType = 'Clickables',
            CastAction = 'CastItem3sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Large_Health_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Large_Rejuv_Elixir',
            Icon = 'NewIcons/potions/Potion4Purple',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Large_Rejuv_Elixir',
                    BuffType = 'POTIONREJUV',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    DamageSelf = true,
                    DamageFriendly = true,
                    CanCrit = false,
                    ArmorImmune = true,
                    CanBackFire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    Affects = {
                        Energy = {Add = 2800},
                        Health = {Add = 2250},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Large_Rejuv_Elixir_FX',
                    BuffType = 'POTIONREJUVENATION01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 1,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Rejuvenation02',
                    EffectsBone = -1,
                },
            },
        },
    },
    Consumable = true,
}

#################################################################################################################
# Scroll of Teleportating
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_010',
    DisplayName = '<LOC ITEM_Consumable_0012>Scroll of Teleporting',
    Description = '<LOC ITEM_Consumable_0013>Use: Teleport yourself and your army to targeted friendly structure.',
    GetMaxRange = function(self) return Ability['Item_Consumable_010'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_010'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_010'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_010'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Scroll/Scroll3',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_010',
            DisplayName = '<LOC ITEM_Consumable_0012>Scroll of Teleporting',
            AbilityType = 'TargetedUnit',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'STRUCTURE', # This item allows you to teleport to untargetable structures.
            TargetingMethod = 'ALLYSTRUCTURE',
            EnergyCost = 0,
            RangeMax = 5000,
            Cooldown = 30,
            CastingTime = 3,
            SharedCooldown = 'TeleportItems',
            InventoryType = 'Clickables',
            CastAction = 'CastItem3sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_010',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            WarpToLocation = true,
            WarpMinions = true,
            IgnoreFacing = true,
            FromItem = 'Item_Consumable_010',
            Icon = 'NewIcons/Scroll/Scroll3',
            OnCastingEffects = {
                Base = 'Items',
                Group = 'Relics',
                Template = 'PortalScroll01',
            },
            OnStartCasting = function(self, unit, params)
                if not params then
                    WARN('params nil in TeleportScroll OnStartCasting')
                else
            	    local pos = unit:FindAdjacentSpot(params)
                    if not pos then
                        WARN('pos nil in TeleportScroll OnStartCasting')
                    else
		                CreateTemplatedEffectAtPos( 'Items', 'Relics', 'PortalScroll01', unit:GetArmy(), pos )
                    end
                end            
		    end,
        }
    },
    Consumable = true,
}

#################################################################################################################
# Observer Ward / Totem of Revelation
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_020',
    DisplayName = '<LOC ITEM_Consumable_0014>Totem of Revelation',
    Description = '<LOC ITEM_Consumable_0015>Use: Place an observer ward that can reveal cloaked enemies. Can also reveal mines.',
    Tooltip = {
        Bonuses = {
          	'<LOC ITEM_Achievement_0011>+[GetVisionBonus] vision radius',
          },
    },
    GetVisionBonus = function(self) return Buffs['Item_Consumable_Buff_020'].Affects.VisionRadius.Add end,
    GetMaxRange = function(self) return Ability['Item_Consumable_020'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_020'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_020'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_020'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Gadget/Totemofrevelation',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Consumable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_020',
            DisplayName = '<LOC ITEM_Consumable_0014>Totem of Revelation',
            AbilityType = 'TargetedArea',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Any',
            TargetCategory = 'ALLUNITS - UNTARGETABLE',
            TargetingMethod = 'AREAARGETED',
            Icon = 'NewIcons/Gadget/Totemofrevelation',
            AffectRadius = 8,
            RangeMax = 5,
            RangeMin = 2,
            CastingTime = 1,
            InventoryType = 'Clickables',
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_020',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
            },
            ErrorMessage = '<LOC error_0030>Cannot place that here.',
            ErrorVO = 'Noplace',
            FromItem = 'Item_Consumable_020',
            Reticule = 'AoE_Revelation',
            OnStartAbility = function(self, unit, params)
                local x = params.Target.Position[1]
                local z = params.Target.Position[3]
                local tower = CreateUnitHPR( 'UGBShop01Ward01', unit:GetArmy(), x, GetSurfaceHeight(x, z), z, 0, 0, 0)

                AttachEffectsAtBone( tower, EffectTemplates.Items.Consumable.TotemOfRevelationActivate, -2 )
            end,
            OnAbilityAdded = function(self, unit)
                Buff.ApplyBuff(unit, 'Item_Consumable_Buff_020', unit)
            end,
            OnRemoveAbility = function(self, unit)
                Buff.RemoveBuff(unit, 'Item_Consumable_Buff_020')
            end,
        },
    },
}

BuffBlueprint {
    Name = 'Item_Consumable_Buff_020',
    BuffType = 'TOTEMVISION',
    Debuff = false,
    EntityCategory = 'ALLUNITS',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        VisionRadius = {Add = 5},
    },
}
#################################################################################################################
# Capture Lock
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_030',
    DisplayName = '<LOC ITEM_Consumable_0016>Capture Lock',
    Description = '<LOC ITEM_Consumable_0017>Use: Selected ally flag cannot be captured by the enemy for [GetDuration] seconds.',
    GetMaxRange = function(self) return Ability['Item_Consumable_030'].RangeMax end,
    GetDuration = function(self) return Buffs['Item_Consumable_030'].Duration end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_030'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_030'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_030'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Gadget/DefenseofVayikra',
    StacksPerSlot = 3,
    Consumable = true,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_030',
            DisplayName = '<LOC ITEM_Consumable_0016>Capture Lock',
            AbilityType = 'TargetedUnit',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'FLAG',
            TargetingMethod = 'ALLYSTRUCTURE',
            RangeMax = 15,
            Cooldown = 45,
            CastingTime = 1,
            InventoryType = 'Clickables',
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_030',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
             Buffs = {
                BuffBlueprint {
                    Name = 'Item_Consumable_030',
                    DisplayName = '<LOC ITEM_Consumable_0016>Capture Lock',
                    Description = '<LOC ITEM_Consumable_0032>Cannot be captured.',
                    BuffType = 'IUSESPRINT',
                    Debuff = false,
                    Stacks = 'ALWAYS',
                    Duration = 45,
                    Affects = {
                    },
                    Icon = 'NewIcons/Gadget/DefenseofVayikra',
                }
            },
            FromItem = 'Item_Consumable_030',
            OnStartAbility = function(self, unit, params)

                ForkThread(
                    function()
                        local blueprint = params.Targets[1]:GetBlueprint()
                        params.Targets[1].CanBeCaptured = false
                        params.Targets[1]:ShowBone(blueprint.Display.CaptureLockBone, true)
                        # Start Can Not Capture Flag Effect
                        AttachEffectsAtBone( params.Targets[1], EffectTemplates.Items.Consumable.DefenseOfVayikraActivate, -2 )
                        WaitSeconds(45)
                        if not params.Targets[1]:IsDead() then
                            params.Targets[1]:HideBone(blueprint.Display.CaptureLockBone, true)
                            params.Targets[1].CanBeCaptured = true
                        end
                        # End Can Not Capture Flag Effect
                        #AttachEffectsAtBone( params.Targets[1], EffectTemplates.Items.Achievement.PurifiedEssenceOfMagicActivate, -2 )
                    end
                )
            end,
            Icon = 'NewIcons/Gadget/DefenseofVayikra',
        }
    },
}

#################################################################################################################
# Sludge Slinger
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_040',
    DisplayName = '<LOC ITEM_Consumable_0020>Sludge Slinger',
    Description = '<LOC ITEM_Consumable_0021>Use: Decreases target\'s Attack Speed by [GetAttackSpeedReduction]% for [GetDuration] seconds.',
    GetAttackSpeedReduction = function(self) return math.floor( Buffs['Item_Consumable_040'].Affects.RateOfFire.Mult * -100 ) end,
    GetDuration = function(self) return Buffs['Item_Consumable_040'].Duration end,
    GetMaxRange = function(self) return Ability['Item_Consumable_040'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_040'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_040'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_040'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Scroll/Scroll2',
    InventoryType = 'Clickables',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_040',
            DisplayName = '<LOC ITEM_Consumable_0020>Sludge Slinger',
            AbilityType = 'TargetedUnit',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Enemy',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            TargetingMethod = 'HOSTILEMOBILE',
            RangeMax = 15,
            Cooldown = 30,
            CastingTime = 0,
            CanCastWhileMoving = true,
            InventoryType = 'Clickables',
            OnStartAbility = function(self, unit)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.PurifiedEssenceOfMagicActivate, -2 )
            end,
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_040',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Consumable_040',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Consumable_040',
                    DisplayName = '<LOC ITEM_Consumable_0020>Sludge Slinger',
                    Description = '<LOC ITEM_Consumable_0034>Attack Speed reduced.',
                    BuffType = 'IUSESLOW',
                    Debuff = true,
                    CanBeDispelled = true,
                    EntityCategory = 'MOBILE',
                    Stacks = 'REPLACE',
                    Duration = 7,
                    Affects = {
                        RateOfFire = {Mult = -0.3},
                    },
                    Effects = 'Slow01',
                    EffectsBone = -2,

                    Icon = 'NewIcons/Scroll/Scroll2',
                },
            },
            # TODO: FXTEAM
            Icon = 'NewIcons/Scroll/Scroll2',
        }
    },
}

#################################################################################################################
# Wand of Speed
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_050',
    DisplayName = '<LOC ITEM_Consumable_0023>Wand of Speed',
    Description = '<LOC ITEM_Consumable_0024>Use: Increase Movement Speed by [GetMoveSpeedBonus]% for [GetDuration] seconds.',
    GetMoveSpeedBonus = function(self) return math.floor( Buffs['Item_Consumable_050'].Affects.MoveMult.Mult * 100 ) end,
    GetDuration = function(self) return Buffs['Item_Consumable_050'].Duration end,
    GetMaxRange = function(self) return Ability['Item_Consumable_050'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_050'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_050'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_050'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Wand/Wand1',
    Useable = true,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_050',
            DisplayName = '<LOC ITEM_Consumable_0023>Wand of Speed',
            AbilityType = 'PassiveAll',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Enemy',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            Cooldown = 30,
            InventoryType = 'Clickables',
            OnStartAbility = function(self, unit)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.PurifiedEssenceOfMagicActivate, -2 )
            end,
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_050',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Consumable_050',
            CanCastWhileMoving = true,
            Icon = 'NewIcons/Wand/Wand1',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Consumable_050',
                    DisplayName = '<LOC ITEM_Consumable_0023>Wand of Speed',
                    Description = '<LOC ITEM_Consumable_0025>Movement Speed increased.',
                    BuffType = 'IUSESPRINT',
                    Debuff = false,
                    Stacks = 'ALWAYS',
                    Duration = 8,
                    Icon = 'Flash',
                    Affects = {
                        MoveMult = {Mult = 0.25},
                    },
                    Icon = 'NewIcons/Wand/Wand1',
                }
            },
        }
    },
}

#################################################################################################################
# Targeting Dummy
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_060',
    DisplayName = '<LOC ITEM_Consumable_0026>Targeting Dummy',
    Description = '<LOC ITEM_Consumable_0027>Use: Draws fire from towers of light when placed nearby.',
    GetMaxRange = function(self) return Ability['Item_Consumable_060'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_060'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_060'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_060'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Gadget/EclipsingStone',
    Consumable = true,
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_060',
            DisplayName = '<LOC ITEM_Consumable_0026>Targeting Dummy',
            AbilityType = 'TargetedArea',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Enemy',
            TargetCategory = 'LIGHTTOWER',
            TargetingMethod = 'AREAARGETED',
            RangeMax = 15,
            AffectRadius = 15,
            Cooldown = 30,
            CastingTime = 1,
            InventoryType = 'Clickables',
            Tooltip = {
                CastingTime = 1,
                Cooldown = 30,
                TargetAlliance = 'Enemy',
            },
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_060',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
            },
            FromItem = 'Item_Consumable_060',
            OnStartAbility = function(self, unit, params)
                local x = params.Target.Position[1]
                local z = params.Target.Position[3]
                local sink = CreateUnitHPR( 'UGBShop01TOLSink', unit:GetArmy(), x, GetSurfaceHeight(x, z), z, 0, 0, 0)
                Buff.ApplyBuff(sink, 'TOLSinkTarget01', sink)
                AttachEffectsAtBone( sink, EffectTemplates.Items.Consumable.TotemOfRevelationActivate, -2 )
            end,
            Icon = 'NewIcons/Gadget/EclipsingStone',
            Reticule = 'AoE_Revelation',
        }
    },
}

AbilityBlueprint {
    Name = 'TOLSinkTarget01',
    DisplayName = '<LOC ITEM_Consumable_0026>Targeting Dummy',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    TargetCategory = 'LIGHTTOWER',
    AffectRadius = 15,
    AuraPulseTime = 2,
    Buffs = {
        BuffBlueprint {
            Name = 'TOLSinkTarget01',
            DisplayName = '<LOC ITEM_Consumable_0026>Targeting Dummy',
            BuffType = 'TOLSINKTARGET',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 3,
            OnBuffAffect = function(self, unit, instigator)
                if(instigator and not instigator:IsDead() and unit != instigator) then
                    IssueClearCommands({unit})
                    IssueAttack({unit}, instigator)
                end
            end,
        }
    },
}

#################################################################################################################
# Warpstone
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_070',
    DisplayName = '<LOC ITEM_Consumable_0028>Warpstone',
    Description = '<LOC ITEM_Consumable_0029>Use: Warp to a nearby location.',
    GetMaxRange = function(self) return Ability['Item_Consumable_070'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_070'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_070'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_070'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Gadget/Warpstone',
    Useable = true,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_070',
            DisplayName = '<LOC ITEM_Consumable_0028>Warpstone',
            AbilityType = 'TargetedArea',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Enemy',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            TargetingMethod = 'AREAARGETED',
            AffectRadius = 4,
            RangeMax = 15,
            Cooldown = 45,
            CastingTime = 0.5,
            SharedCooldown = 'WarpItems',
            InventoryType = 'Clickables',
            CastAction = 'CastItem1sec',
            OnStartAbility = function(self, unit, targetData)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Artifacts.CloakOfElfinkindActivate, -2 )
            end,
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_070',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
            },
            ErrorMessage = '<LOC error_0031>Cannot move there.',
            ErrorVO = 'Nomove',
            FromItem = 'Item_Consumable_070',
            Icon = 'NewIcons/Gadget/Warpstone',
            Reticule = 'AoE_Warp',
            CasterEffect = {
                Base = 'Items',
                Group = 'Artifacts',
                Template = 'ScrotusWarp01',
            },
            WarpToLocation = true,
            WarpMinions = false,
        }
    },
}

#################################################################################################################
# Universal Gadget
#################################################################################################################
BuffBlueprint {
    Name = 'Item_Consumable_080_Heal',
    BuffType = 'CONSUMABLEHEAL',
    Debuff = false,
    EntityCategory = 'ALLUNITS - UNTARGETABLE',
    Stacks = 'ALWAYS',
    Duration = 0,
    CanCrit = false,
    DamageSelf = true,
    ArmorImmune = true,
    CanBeEvaded = false,
    CanMagicResist = false,
    IgnoreDamageRangePercent = true,
    Affects = {
        Health = {Add = 2000},
    },
    Effects = 'Heal02',
    EffectsBone = -2,
}

BuffBlueprint {
    Name = 'Item_Consumable_080_Damage',
    BuffType = 'CONSUMABLEDAMAGE',
    Debuff = false,
    EntityCategory = 'ALLUNITS - UNTARGETABLE',
    Stacks = 'ALWAYS',
    Duration = 0,
    CanCrit = false,
    ArmorImmune = true,
    CanBeEvaded = false,
    CanMagicResist = true,
    IgnoreDamageRangePercent = true,
    Affects = {
        Health = {Add = -650},
    },
    Effects = 'Damage02',
    EffectsBone = -2,
}

ItemBlueprint {
    Name = 'Item_Consumable_080',
    DisplayName = '<LOC ITEM_Consumable_0030>Universal Gadget',
    Description = '<LOC ITEM_Consumable_0031>Use: Heal an allied unit for [GetHealAmount] or damage an enemy unit for [GetDamageAmount].',
    GetHealAmount = function(self) return Buffs['Item_Consumable_080_Heal'].Affects.Health.Add end,
    GetDamageAmount = function(self) return math.floor( Buffs['Item_Consumable_080_Damage'].Affects.Health.Add * -1 ) end,
    GetMaxRange = function(self) return Ability['Item_Consumable_070'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_080'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_080'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_080'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Gadget/UniversalGadget',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_080',
            DisplayName = '<LOC ITEM_Consumable_0030>Universal Gadget',
            AbilityType = 'TargetedUnit',
            AbilityCategory = 'USABLEITEM',
            RangeMax = 15,
            TargetAlliance = 'Any',
            TargetCategory = 'ALLUNITS -UNTARGETABLE',
            Cooldown = 10,
            CastingTime = 2,
            InventoryType = 'Clickables',
            CastAction = 'CastItem2sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_080',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
             OnCastingEffects = {
                Base = 'Items',
                Group = 'Relics',
                Template = 'PortalScroll01',
            },
            FromItem = 'Item_Consumable_080',
            OnStartAbility = function(self, unit, params)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.PurifiedEssenceOfMagicActivate, -2 )
                target = params.Targets[1]
                if not IsEnemy( target:GetArmy(), unit:GetArmy() ) then
                    Buff.ApplyBuff( target, 'Item_Consumable_080_Heal', unit )
                else
                    Buff.ApplyBuff( target, 'Item_Consumable_080_Damage', unit )
                end
            end,
            Icon = 'NewIcons/Gadget/UniversalGadget',
        },
    },
    Consumable = true,
}


#################################################################################################################
# Restorative Scroll
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_090',
    DisplayName = '<LOC ITEM_Consumable_0035>Restorative Scroll',
    Description = '<LOC ITEM_Consumable_0036>Use: Any negative effects on your army are removed. The Demigod is not affected.',
    GetMaxRange = function(self) return Ability['Item_Consumable_090'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_090'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_090'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_090'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Scroll/Scroll1',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_090',
            DisplayName = '<LOC ITEM_Consumable_0035>Restorative Scroll',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Any',
            TargetCategory = 'ALLUNITS -UNTARGETABLE',
            Cooldown = 20,
            CastingTime = 0.25,
            InventoryType = 'Clickables',
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_080',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Consumable_090',
            OnStartAbility = function(self, unit, params)
                local brain = unit:GetAIBrain()
                local minions = brain:GetListOfUnits( ParseEntityCategoryEx( 'MINION' ), false )
                for k,v in minions do
                    if v:IsDead() then
                        continue
                    end
                    Buff.RemoveBuffsByDebuff(v, true)
                    Buff.ApplyBuff(v, 'Item_Consumable_120', unit)
                end
            end,
            Icon = 'NewIcons/Scroll/Scroll1',
        },
    },
    Consumable = true,
}

ArmyBonusBlueprint {
    Name = 'Item_Consumable_090',
    DisplayName = '<LOC ITEM_Consumable_0037>Restorative Scroll',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Consumable_090',
            BuffType = 'MINIONDEBUFFCLEAR',
            Debuff = false,
            EntityCategory = 'ALLUNITS - UNTARGETABLE',
            Stacks = 'REPLACE',
            Affects = {
                Dummy = {Add = 0.1},
            },
            Effects = 'Heal02',
            EffectsBone = -2,
        }
    }
}

#################################################################################################################
# Hex Scroll
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_100',
    DisplayName = '<LOC ITEM_Consumable_0038>Hex Scroll',
    Description = '<LOC ITEM_Consumable_0039>Use: Weapon damage dealt by the targeted Demigod and their army reduced by [GetReduction]% for [GetDuration] seconds.',
    GetMaxRange = function(self) return Ability['Item_Consumable_090'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_090'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_090'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_090'].Cooldown end,
    GetDuration = function(self) return Buffs['Item_Consumable_100_Minion'].Duration end,
    GetReduction = function(self) return math.floor( Buffs['Item_Consumable_100_Minion'].Affects.DamageBonus.Mult * -100 ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Scroll/Scroll5',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_100',
            DisplayName = '<LOC ITEM_Consumable_0038>Hex Scroll',
            AbilityType = 'TargetedUnit',
            AbilityCategory = 'USABLEITEM',
            TargetingMethod = 'HOSTILETARGETED',
            TargetAlliance = 'Enemy',
            TargetCategory = 'HERO -UNTARGETABLE',
            RangeMax = 15,
            Cooldown = 20,
            CastingTime = 0.25,
            InventoryType = 'Clickables',
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_100',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Consumable_100',
            OnStartAbility = function(self, unit, params)
                target = params.Targets[1]
                --target:GetAIBrain():AddArmyBonus( 'Item_Consumable_100_Minion', unit )
                local aiBrain = target:GetAIBrain()
                local minions = aiBrain:GetListOfUnits(categories.MINION, false)
                for _,minion in minions do
                    Buff.ApplyBuff(minion, 'Item_Consumable_100_Minion', unit)
                end
                Buff.ApplyBuff( target, 'Item_Consumable_100_Demigod', unit )
            end,
            Icon = 'NewIcons/Scroll/Scroll5',
        },
    },
    Consumable = true,
}

BuffBlueprint {
    Name = 'Item_Consumable_100_Minion',
    DisplayName = '<LOC ITEM_Consumable_0041>Hex Scroll',
    Description = '<LOC ITEM_Consumable_0042>Damage reduced.',
    BuffType = 'HEXSCROLLMINIONDAMAGEREDUCTION',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'ALLUNITS - UNTARGETABLE',
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {
        DamageBonus = { Mult = -0.30 },
    },
    Icon = 'NewIcons/Scroll/Scroll5',
}

BuffBlueprint {
    Name = 'Item_Consumable_100_Demigod',
    BuffType = 'HEXSCROLLDEMIGODDAMAGEREDUCTION',
    DisplayName = '<LOC ITEM_Consumable_0043>Hex Scroll',
    Description = '<LOC ITEM_Consumable_0044>Damage reduced.',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'ALLUNITS - UNTARGETABLE',
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {
        DamageRating = { Mult = -0.30 },
    },
    Icon = 'NewIcons/Scroll/Scroll5',
}

#################################################################################################################
# Sigil of Vitality
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_110',
    DisplayName = '<LOC ITEM_Consumable_0045>Sigil of Vitality',
    Description = '<LOC ITEM_Consumable_0046>Use: Temporarily increase Maximum Health by [GetHealthBonus]% for [GetDuration] seconds.',
    Tooltip = {
        MBonuses = {
            '<LOC MBONUS_0000>+[GetMinionHealthBonus] Minion Health',
        },
    },
    GetMinionHealthBonus = function(self) return math.floor( Buffs['Item_Consumable_110_Minion_Buff'].Affects.MaxHealth.Add ) end,
    GetHealthBonus = function(self) return math.floor( Buffs['Item_Consumable_110'].Affects.MaxHealth.Mult * 100 ) end,
    GetDuration = function(self) return Buffs['Item_Consumable_110'].Duration end,
    GetCooldown = function(self) return Ability['Item_Consumable_110'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/Scroll/Scroll4',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Consumable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_110',
            DisplayName = '<LOC ITEM_Consumable_0045>Sigil of Vitality',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            Cooldown = 30,
            InventoryType = 'Clickables',
            OnStartAbility = function(self, unit)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Achievement.PurifiedEssenceOfMagicActivate, -2 )
            end,
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_110',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
             OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Consumable_110_Minion_Buff', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus('Item_Consumable_110_Minion_Buff')
            end,
            FromItem = 'Item_Consumable_110',
            CanCastWhileMoving = true,
            Icon = 'NewIcons/Scroll/Scroll4',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Consumable_110',
                    DisplayName = '<LOC ITEM_Consumable_0047>Sigil of Vitality',
                    Description = '<LOC ITEM_Consumable_0048>Maximum Health increased.',
                    BuffType = 'IUSEVITALITY',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    Duration = 20,
                    Affects = {
                        MaxHealth = {Mult = 0.5, AdjustHealth = true},
                    },
                    Icon = 'NewIcons/Scroll/Scroll4',
                }
            },
        },
    },
}

#################################################################################################################
# Buff: Sigil of Vitality
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'Item_Consumable_110_Minion_Buff',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Consumable_110_Minion_Buff',
            BuffType = 'CHEST040MINIONHEALTH',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Affects = {
                MaxHealth = {Add = 100, AdjustEnergy = false},
            },
        }
    }
}

#################################################################################################################
# Twig of Life
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_120',
    DisplayName = '<LOC ITEM_Consumable_0049>Twig of Life',
    Description = '<LOC ITEM_Consumable_0050>Use: Your army restores [GetHealth]% of their maximum Health.',
    Tooltip = {
        MBonuses = {
            '<LOC MBONUS_0000>+[GetMinionHealthBonus] Minion Health',
        },
    },
    GetMaxRange = function(self) return Ability['Item_Consumable_120'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_120'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_120'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_120'].Cooldown end,
    GetHealth = function(self) return math.floor( Ability['Item_Consumable_120'].RegenAmount * 100 ) end,
    GetMinionHealthBonus = function(self) return math.floor(Buffs['Item_Consumable_120_Minion'].Affects.MaxHealth.Add) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Wand/Wand4',
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_120',
            DisplayName = '<LOC ITEM_Consumable_0049>Twig of Life',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'HERO -UNTARGETABLE',
            Cooldown = 30,
            CastingTime = 1,
            RegenAmount = .50,
            InventoryType = 'Clickables',
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_120',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Consumable_120',
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Consumable_120_Minion', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Consumable_120_Minion', unit )
            end,
            OnStartAbility = function(self, unit, params)
                local brain = unit:GetAIBrain()
                local minions = brain:GetListOfUnits( ParseEntityCategoryEx( 'MINION' ), false )
                for k,v in minions do
                    if v:IsDead() then
                        continue
                    end
                    local amount = v:GetMaxHealth() * self.RegenAmount * -1
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
                        NoFloatText = true,
                        Group = "UNITS",
                    }
                    DealDamage(data, v)
                    Buff.ApplyBuff(v, 'Item_Consumable_120', unit)
                end
            end,
            Icon = 'NewIcons/Wand/Wand4',
        },
    },
    Useable = true,
}

BuffBlueprint {
    Name = 'Item_Consumable_120',
    BuffType = 'TWIGHEALTH',
    Debuff = false,
    EntityCategory = 'MINION',
    Stacks = 'REPLACE',
    Affects = {
        Dummy = { Add = 1 },
    },
    Effects = 'Heal01',
    EffectsBone = -2,
}

ArmyBonusBlueprint {
    Name = 'Item_Consumable_120_Minion',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Consumable_120_Minion',
            BuffType = 'CONSUMABLE120PASSIVE',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                MaxHealth = {Add = 150, AdjustEnergy = false},
            },
        }
    }
}

#################################################################################################################
# Warlord's Punisher
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_130',
    DisplayName = '<LOC ITEM_Consumable_0051>Warlord\'s Punisher',
    Description = '<LOC ITEM_Consumable_0052>Use: Cast a bolt of lightning at the target, dealing [GetHealth] damage and arcing to nearby enemies. Demigods struck also lose [GetMana] Mana.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0001>+[GetDamageBonus] Weapon Damage',
        },
    },

    GetMaxRange = function(self) return Ability['Item_Consumable_130'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_130'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_130'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_130'].Cooldown end,
    GetHealth = function(self) return Ability['Item_Consumable_130'].DamageAmt end,
    GetMana = function(self) return Ability['Item_Consumable_130'].ManaDrainAmt end,
    GetDamageBonus = function(self) return Buffs['Item_Consumable_130_Buff'].Affects.DamageRating.Add end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Wand/Wand3',
    InventoryType = 'Clickables',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_130',
            DisplayName = '<LOC ITEM_Consumable_0051>Warlord\'s Punisher',
            AbilityType = 'TargetedUnit',
            TargetAlliance = 'Enemy',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            AbilityType = 'TargetedUnit',
            AbilityCategory = 'USABLEITEM',
            TargetingMethod = 'HOSTILEMOBILE',
            FromItem = 'Item_Consumable_130',
            InventoryType = 'Clickables',
            CastAction = 'CastItem2sec',
            RangeMax = 15,
            Cooldown = 30,
            CastingTime = 1,
            DamageAmt = 300,
            ManaDrainAmt = 400,
            Chains = 10,
            ChainTime = 0.1,
            ChainAffectRadius = 5,
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_130',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
             Effects = {
                Base = 'Items',
                Group = 'Runes',
                Beams = 'LightningBeam01',
             },
             OnStartAbility = function(self, unit, params)
                ForkThread(self.LightningThread, self, unit, params)
             end,
             Icon = 'NewIcons/Wand/Wand3',

            LightningThread = function(self, unit, params)
                target = params.Targets[1]

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
                                    v:SetEnergy(v:GetEnergy() - self.ManaDrainAmt)

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
        AbilityBlueprint {
            Name = 'Item_Consumable_130_Buff',
            AbilityType = 'Quiet',
            FromItem = 'Item_Consumable_130',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Consumable_130_Buff',
                    BuffType = 'PUNISHERDAMAGE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'REPLACE',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 30},
                    },
                }
            },
        },
    },
}

#################################################################################################################
# Magus Rod
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_140',
    DisplayName = '<LOC ITEM_Consumable_0053>Magus Rod',
    Description = '<LOC ITEM_Consumable_0054>Use: The cost of abilities is reduced by [GetReduction]% for [GetDuration] seconds.',
    GetManaRegenBonus = function(self) return math.floor( Buffs['Item_Consumable_140_Buff'].Affects.EnergyRegen.Mult * 100 ) end,
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0020>+[GetManaRegenBonus]% Mana Per Second',
        },
    },
    GetMaxRange = function(self) return Ability['Item_Consumable_140'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_140'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_140'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_140'].Cooldown end,
    GetReduction = function(self) return math.floor( Buffs['Item_Consumable_140'].Affects.SpellCostMult.Add * -100 ) end,
    GetDuration = function(self) return math.floor( Buffs['Item_Consumable_140'].Duration ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Wand/Wand2',
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_140',
            DisplayName = '<LOC ITEM_Consumable_0053>Magus Rod',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'HERO -UNTARGETABLE',
            Cooldown = 15,
            CanCastWhileMoving = true,
            InventoryType = 'Clickables',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_140',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Consumable_140',
            OnStartAbility = function(self, unit, params)
                Buff.ApplyBuff(unit, 'Item_Consumable_140', unit)
            end,
            Icon = 'NewIcons/Wand/Wand2',
        },
        AbilityBlueprint {
            Name = 'Item_Consumable_140_Buff',
            AbilityType = 'Quiet',
            FromItem = 'Item_Consumable_140',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Consumable_140_Buff',
                    BuffType = 'MAGUSBUFF',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        EnergyRegen = {Mult = .5},
                    },
                },
            },
        },
    },
    Useable = true,
}

BuffBlueprint {
    Name = 'Item_Consumable_140',
    DisplayName = '<LOC ITEM_Consumable_0055>Magus Rod',
    Description = '<LOC ITEM_Consumable_0056>Cost of abilities reduced.',
    Icon = 'NewIcons/Wand/Wand2',
    BuffType = 'MAGUSROD',
    Debuff = false,
    EntityCategory = 'ALLUNITS - UNTARGETABLE',
    Stacks = 'REPLACE',
    Duration = 5,
    Affects = {
        SpellCostMult = {Add = -.50},
    },
}

#################################################################################################################
# Orb of Defiance
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_150',
    DisplayName = '<LOC ITEM_Consumable_0057>Orb of Defiance',
    Description = '<LOC ITEM_Consumable_0058>Use: Become invulnerable for [GetDuration] seconds. Cannot move, attack or use abilities.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Consumable_0059>+[GetHealth] Health',
            '<LOC ITEM_Consumable_0060>+[GetArmor] Armor',
        },
    },
    GetMaxRange = function(self) return Ability['Item_Consumable_150_Use'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_150_Use'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_150_Use'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_150_Use'].Cooldown end,
    GetArmor = function(self) return math.floor( Buffs['Item_Consumable_150'].Affects.Armor.Add ) end,
    GetHealth = function(self) return math.floor( Buffs['Item_Consumable_150'].Affects.MaxHealth.Add ) end,
    GetDuration = function(self) return math.floor( Buffs['Item_Consumable_150_Use'].Duration ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Orb/Orb1',
    InventoryType = 'Clickables',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_150_Use',
            DisplayName = '<LOC ITEM_Consumable_0057>Orb of Defiance',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'HERO -UNTARGETABLE',
            Cooldown = 35,
            CastingTime = 0,
            CanCastWhileMoving = true,
            InventoryType = 'Clickables',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_150',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Consumable_150',
            OnStartAbility = function(self, unit, params)
                Buff.ApplyBuff(unit, 'Item_Consumable_150_Use', unit)
            end,
            Icon = 'NewIcons/Orb/Orb1',
        },
        AbilityBlueprint {
            Name = 'Item_Consumable_150',
            AbilityType = 'Quiet',
            FromItem = 'Item_Consumable_150',
            Icon = 'NewIcons/Orb/Orb1',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Consumable_150',
                    BuffType = 'DEFIANCEARMOR',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Armor = {Add = 500},
                        MaxHealth = {Add = 500, AdjustEnergy = false},
                    },
                }
            },
        },
    },
}

BuffBlueprint {
    Name = 'Item_Consumable_150_Use',
    DisplayName = '<LOC ITEM_Consumable_0061>Orb of Defiance',
    Description = '<LOC ITEM_Consumable_0062>Invulnerable. Cannot move, attack or use abilities.',
    Icon = 'NewIcons/Orb/Orb1',
    BuffType = 'DEFIANCEUSE',
    Debuff = false,
    EntityCategory = 'ALLUNITS - UNTARGETABLE',
    Stacks = 'REPLACE',
    Duration = 5,
    Affects = {
        UnitImmobile = {Bool = true},
        DisableAbilityUse = {Bool = true,},
        Invincible = { Bool = true },
        WeaponsEnable = {Bool = false},
    },
    OnBuffAffect = function(self, unit, instigator)
        Buff.RemoveBuffsByDebuff(unit, true)
        if not Buff.HasBuff(unit, 'HOAKShield01') and not Buff.HasBuff(unit, 'HOAKShield02') and not Buff.HasBuff(unit, 'HOAKShield03') and not Buff.HasBuff(unit, 'HOAKShield04') then
            unit:SetInvulnerableMesh(true)
        end
        unit:SetBusy(true)
        for k, anim in unit.Character.AnimStateControllers do
            anim:SetPaused(true)
        end
        unit.Character.IsFrozen = true
    end,
    OnBuffRemove = function(self, unit )
        unit:PlaySound('Forge/DEMIGODS/Oak/snd_dg_oak_shield_end')
        if not Buff.HasBuff(unit, 'HOAKShield01') and not Buff.HasBuff(unit, 'HOAKShield02') and not Buff.HasBuff(unit, 'HOAKShield03') and not Buff.HasBuff(unit, 'HOAKShield04') then
            unit:SetInvulnerableMesh(false)
        end
        for k, anim in unit.Character.AnimStateControllers do
            anim:SetPaused(false)
        end
        unit:SetBusy(false)
        unit.Character.IsFrozen = false
    end,
}

#################################################################################################################
# Heart of Life
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_160',
    DisplayName = '<LOC ITEM_Consumable_0063>Heart of Life',
    Description = '<LOC ITEM_Consumable_0064>Use: Restore [GetHealth] Health and [GetMana] Mana over [GetDuration] seconds. Any damage will break this effect.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Consumable_0065>+[GetHealthRegen] Health Per Second',
            '<LOC ITEM_Consumable_0066>+[GetManRegen]% Mana Per Second',
        },
    },
    GetMaxRange = function(self) return Ability['Item_Consumable_160_Use'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_160_Use'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_160_Use'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_160_Use'].Cooldown end,
    GetHealthRegen = function(self) return math.floor( Buffs['Item_Consumable_160'].Affects.Regen.Add ) end,
    GetManRegen = function(self) return math.floor( Buffs['Item_Consumable_160'].Affects.EnergyRegen.Mult * 100 ) end,
    GetDuration = function(self) return math.floor( Buffs['Item_Consumable_160_Use'].Duration ) end,
    GetHealth = function(self) return math.floor( Buffs['Item_Consumable_160_Use'].Affects.Regen.Add * Buffs['Item_Consumable_160_Use'].Duration ) end,
    GetMana = function(self) return math.floor( Buffs['Item_Consumable_160_Use'].Affects.EnergyRegen.Add * Buffs['Item_Consumable_160_Use'].Duration ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Orb/Orb2',
    InventoryType = 'Clickables',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_160_Use',
            DisplayName = '<LOC ITEM_Consumable_0063>Heart of Life',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Ally',
            TargetCategory = 'HERO -UNTARGETABLE',
            Cooldown = 60,
            CastingTime = 0,
            CanCastWhileMoving = true,
            InventoryType = 'Clickables',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_160',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Consumable_160',
            OnStartAbility = function(self, unit, params)
                Buff.ApplyBuff(unit, 'Item_Consumable_160_Use', unit)
            end,
            Icon = 'NewIcons/Orb/Orb2',
        },
        AbilityBlueprint {
            Name = 'Item_Consumable_160',
            AbilityType = 'Quiet',
            FromItem = 'Item_Consumable_160',
            Icon = 'NewIcons/Orb/Orb2',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Consumable_160',
                    BuffType = 'HEARTREGEN',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Regen = {Add = 30},
                        EnergyRegen = {Mult = 0.75},
                    },
                }
            },
        },
    },
}

BuffBlueprint {
    Name = 'Item_Consumable_160_Use',
    DisplayName = '<LOC ITEM_Consumable_0063>Heart of Life',
    Description = '<LOC ITEM_Consumable_0081>Healing and Regenerating Mana.',
    Icon = 'NewIcons/Orb/Orb2',
    BuffType = 'HEARTUSE',
    Debuff = false,
    EntityCategory = 'ALLUNITS - UNTARGETABLE',
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {
        Regen = {Add = 450},
        EnergyRegen = {Add = 450},
    },
    OnApplyBuff = function(self, unit, instigator)
        unit.Callbacks.OnTakeDamage:Add(self.Damaged, self)
    end,
    Damaged = function(self, unit, data)
        if Buff.HasBuff(unit, 'Item_Consumable_160_Use') then
            Buff.RemoveBuff(unit, 'Item_Consumable_160_Use')
        end
        unit.Callbacks.OnTakeDamage:Remove(self.Damaged)
    end,
    OnBuffRemove= function(self,unit)
        unit.Callbacks.OnTakeDamage:Remove(self.Damaged)
    end
}

#################################################################################################################
# Parasite Egg
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Consumable_170',
    DisplayName = '<LOC ITEM_Consumable_0069>Parasite Egg',
    Description = '<LOC ITEM_Consumable_0070>Use: Infest target Demigod with a parasite. Whenever you deal damage to that Demigod, their minions take damage as well. The effects lasts [GetDuration] seconds.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Consumable_0071>+[GetWeaponDamage] Weapon Damage',
            '<LOC ITEM_Consumable_0072>+[GetROF]% Attack Speed',
        },
    },
    GetMaxRange = function(self) return Ability['Item_Consumable_170_Use'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Consumable_170_Use'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Consumable_170_Use'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Consumable_170_Use'].Cooldown end,
    GetWeaponDamage = function(self) return math.floor( Buffs['Item_Consumable_170'].Affects.DamageRating.Add ) end,
    GetROF = function(self) return math.floor( Buffs['Item_Consumable_170'].Affects.RateOfFire.Mult * 100 ) end,
    GetDuration = function(self) return math.floor( Buffs['Item_Consumable_170_Use'].Duration ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Orb/Orb3',
    InventoryType = 'Clickables',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Consumable_170_Use',
            DisplayName = '<LOC ITEM_Consumable_0069>Parasite Egg',
            AbilityType = 'TargetedUnit',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Enemy',
            TargetCategory = 'HERO -UNTARGETABLE',
            TargetingMethod = 'HOSTILETARGETED',
            RangeMax = 15,
            Cooldown = 30,
            CastingTime = 0,
            CanCastWhileMoving = true,
            InventoryType = 'Clickables',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Consumable_170',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Consumable_170',
            OnStartAbility = function(self, unit, params)
                local target = params.Targets[1]
                Buff.ApplyBuff(target, 'Item_Consumable_170_Use', unit)
            end,
            Icon = 'NewIcons/Orb/Orb3',
        },
        AbilityBlueprint {
            Name = 'Item_Consumable_170',
            AbilityType = 'Quiet',
            FromItem = 'Item_Consumable_170',
            Icon = 'NewIcons/Orb/Orb2',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Consumable_170',
                    BuffType = 'PARASITEDAMAGE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 30},
                        RateOfFire = {Mult = 0.10},
                    },
                }
            },
        },
    },
}

BuffBlueprint {
    Name = 'Item_Consumable_170_Use',
    DisplayName = '<LOC ITEM_Consumable_0073>Parasite Egg',
    Description = '<LOC ITEM_Consumable_0074>Minions take damage when Parasite Egg\'s owner damages you.',
    Icon = 'NewIcons/Orb/Orb3',
    BuffType = 'PARASITEUSE',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'ALLUNITS - UNTARGETABLE',
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {
        Dummy = {Add = 1},
    },
    OnApplyBuff = function(self, unit, instigator)
        if instigator then
            unit.AbilityData.ParasiteEgg = {}
            unit.AbilityData.ParasiteEgg.Caster = instigator
            unit.AbilityData.ParasiteEgg.CasterArmy = instigator:GetArmy()
            unit.AbilityData.ParasiteEgg.CasterBp = instigator:GetBlueprint()
        end
        unit.Callbacks.OnTakeDamage:Add(self.Damaged, self)
    end,
    Damaged = function(self, unit, data)
        if data.Instigator == unit.AbilityData.ParasiteEgg.Caster then
            local damagepercent = data.Amount/unit:GetMaxHealth()
            local army = ArmyBrains[unit:GetArmy()]:GetListOfUnits(categories.MINION, false)
            local data = {
                Instigator = unit.AbilityData.ParasiteEgg.Caster,
                InstigatorBp = unit.AbilityData.ParasiteEgg.CasterBp,
                InstigatorArmy = unit.AbilityData.ParasiteEgg.CasterArmy,
                Type = 'Spell',
                DamageAction = 'ParasiteEgg',
                Radius = 0,
                DamageSelf = true,
                DamageFriendly = true,
                ArmorImmune = true,
                CanBackfire = false,
                CanBeEvaded = false,
                CanCrit = false,
                CanMagicResist = false,
                CanOverKill = false,
                IgnoreDamageRangePercent = false,
                Group = "UNITS",
            }
            for k, v in army do
                if(v and not v:IsDead()) then
                    data.Amount = v:GetMaxHealth() * damagepercent
                    DealDamage(data, v)
                end
            end
        end
    end,
    OnBuffRemove = function(self,unit)
        unit.Callbacks.OnTakeDamage:Remove(self.Damaged)
    end
}

#################################################################################################################
# Health Potion
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Health_Potion_Art',
    DisplayName = '<LOC ITEM_Consumable_0075>Enhanced Health Potion',
    Description = '<LOC ITEM_Consumable_0001>Use: Heal [GetHealAmount] Health.',
    GetHealAmount = function(self) return Buffs['Item_Health_Potion_Art'].Affects.Health.Add end,
    GetMaxRange = function(self) return Ability['Item_Health_Potion_Art'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Health_Potion_Art'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Health_Potion_Art'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Health_Potion_Art'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion1green',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Health_Potion_Art',
            DisplayName = '<LOC ITEM_Consumable_0075>Enhanced Health Potion',
            AbilityType = 'Instant',
            InventoryType = 'Clickables',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'HealthPotion',
            CastingTime = 0.5,
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Health_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Health_Potion_Art',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Health_Potion_Art',
                    BuffType = 'POTIONHEALTH',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    DamageSelf = true,
                    DamageFriendly = true,
                    CanCrit = false,
                    ArmorImmune = true,
                    CanBackFire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    Affects = {
                        Health = {Add = 2250},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Health_Potion_FX_Art',
                    BuffType = 'POTIONHEAL01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 3,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Heal02',
                    EffectsBone = -1,
                },
            },
            Icon = 'NewIcons/potions/Potion1green',
        },
    },
    Consumable = true,
}

#################################################################################################################
# Robust Health Potion
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Large_Health_Potion_Art',
    DisplayName = '<LOC ITEM_Consumable_0076>Supreme Health Potion',
    Description = '<LOC ITEM_Consumable_0003>Use: Heal [GetHealAmount] Health.',
    GetHealAmount = function(self) return Buffs['Item_Large_Health_Potion_Art'].Affects.Health.Add end,
    GetMaxRange = function(self) return Ability['Item_Large_Health_Potion_Art'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Large_Health_Potion_Art'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Large_Health_Potion_Art'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Large_Health_Potion_Art'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion4green',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Large_Health_Potion_Art',
            DisplayName = '<LOC ITEM_Consumable_0076>Supreme Health Potion',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'HealthPotion',
            CastingTime = 3,
            InventoryType = 'Clickables',
            CastAction = 'CastItem3sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Large_Health_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Large_Health_Potion_Art',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Large_Health_Potion_Art',
                    BuffType = 'POTIONHEALTH',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    DamageSelf = true,
                    DamageFriendly = true,
                    CanCrit = false,
                    ArmorImmune = true,
                    CanBackFire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    Affects = {
                        Health = {Add = 6000},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Large_Health_Potion_FX_Art',
                    BuffType = 'POTIONHEAL01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 3,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Heal02',
                    EffectsBone = -1,
                },
            },
            Icon = 'NewIcons/potions/Potion4green',
        },
    },
    Consumable = true,
}

#################################################################################################################
# Mana Potion
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Mana_Potion_Art',
    DisplayName = '<LOC ITEM_Consumable_0077>Enhanced Mana Potion',
    Description = '<LOC ITEM_Consumable_0005>Use: Restore [GetManaAmount] Mana.',
    GetManaAmount = function(self) return Buffs['Item_Mana_Potion_Art'].Affects.Energy.Add end,
    GetMaxRange = function(self) return Ability['Item_Mana_Potion_Art'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Mana_Potion_Art'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Mana_Potion_Art'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Mana_Potion_Art'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion1Blue',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Mana_Potion_Art',
            DisplayName = '<LOC ITEM_Consumable_0077>Enhanced Mana Potion',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'EnergyPotion',
            CastingTime = 0.5,
            InventoryType = 'Clickables',
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Large_Health_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Mana_Potion_Art',
            Icon = 'NewIcons/potions/Potion1Blue',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Mana_Potion_Art',
                    BuffType = 'POTIONENERGY',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    Affects = {
                        Energy = {Add = 3000},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Mana_Potion_FX_Art',
                    BuffType = 'POTIONENERGY01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 3,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Energize01',
                    EffectsBone = -1,
                },
            },
        },
    },
    Consumable = true,
}

#################################################################################################################
# Robust Mana Potion
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Large_Mana_Potion_Art',
    DisplayName = '<LOC ITEM_Consumable_0078>Supreme Mana Potion',
    Description = '<LOC ITEM_Consumable_0005>Use: Restore [GetManaAmount] Mana.',
    GetManaAmount = function(self) return Buffs['Item_Large_Mana_Potion_Art'].Affects.Energy.Add end,
    GetMaxRange = function(self) return Ability['Item_Large_Mana_Potion_Art'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Large_Mana_Potion_Art'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Large_Mana_Potion_Art'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Large_Mana_Potion_Art'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion4Blue',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Large_Mana_Potion_Art',
            DisplayName = '<LOC ITEM_Consumable_0078>Supreme Mana Potion',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            CastingTime = 2,
            InventoryType = 'Clickables',
            CastAction = 'CastItem3sec',
            SharedCooldown = 'EnergyPotion',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Large_Mana_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Large_Mana_Potion_Art',
            Icon = 'NewIcons/potions/Potion4Blue',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Large_Mana_Potion_Art',
                    BuffType = 'POTIONENERGY',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    Affects = {
                        Energy = {Add = 7500},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Large_Mana_Potion_FX_Art',
                    BuffType = 'POTIONENERGY01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 3,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Energize01',
                    EffectsBone = -1,
                },
            },
        },
    },
    Consumable = true,
}

#################################################################################################################
# Rejuvenation Elixir
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Rejuv_Elixir_Art',
    DisplayName = '<LOC ITEM_Consumable_0079>Revitalization Elixir',
    Description = '<LOC ITEM_Consumable_0009>Use: Restore [GetHealthAmount] Health and [GetManaAmount] Mana.',
    GetHealthAmount = function(self) return Buffs['Item_Rejuv_Elixir_Art'].Affects.Health.Add end,
    GetManaAmount = function(self) return Buffs['Item_Rejuv_Elixir_Art'].Affects.Energy.Add end,
    GetMaxRange = function(self) return Ability['Item_Rejuv_Elixir_Art'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Rejuv_Elixir_Art'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Rejuv_Elixir_Art'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Rejuv_Elixir_Art'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion1Purple',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Rejuv_Elixir_Art',
            DisplayName = '<LOC ITEM_Consumable_0079>Revitalization Elixir',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'RejuvenationPotion',
            CastingTime = 1,
            InventoryType = 'Clickables',
            CastAction = 'CastItem3sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Rejuv_Elixir',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Rejuv_Elixir_Art',
            Icon = 'NewIcons/potions/Potion1Purple',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Rejuv_Elixir_Art',
                    BuffType = 'POTIONREJUV',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    DamageSelf = true,
                    DamageFriendly = true,
                    CanCrit = false,
                    ArmorImmune = true,
                    CanBackFire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    Affects = {
                        Energy = {Add = 2250},
                        Health = {Add = 2250},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Rejuv_Elixir_FX_Art',
                    BuffType = 'POTIONREJUVENATION01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 1,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Rejuvenation02',
                    EffectsBone = -1,
                },
            },
        },
    },
    Consumable = true,
}

#################################################################################################################
# Robust Rejuvenation Elixir
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Large_Rejuv_Elixir_Art',
    DisplayName = '<LOC ITEM_Consumable_0080>Supreme Revitalization Elixir',
    Description = '<LOC ITEM_Consumable_0009>Use: Restore [GetHealthAmount] Health and [GetManaAmount] Mana.',
    GetHealthAmount = function(self) return Buffs['Item_Large_Rejuv_Elixir_Art'].Affects.Health.Add end,
    GetManaAmount = function(self) return Buffs['Item_Large_Rejuv_Elixir_Art'].Affects.Energy.Add end,
    GetEnergyCost = function(self) return Ability['Item_Large_Rejuv_Elixir_Art'].EnergyCost end,
    GetMaxRange = function(self) return Ability['Item_Large_Rejuv_Elixir_Art'].RangeMax end,
    GetCastTime = function(self) return Ability['Item_Large_Rejuv_Elixir_Art'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Large_Rejuv_Elixir_Art'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.1,
    Icon = 'NewIcons/potions/Potion4Purple',
    StacksPerSlot = 3,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Large_Rejuv_Elixir_Art',
            DisplayName = '<LOC ITEM_Consumable_0080>Supreme Revitalization Elixir',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 8,
            SharedCooldown = 'RejuvenationPotion',
            CastingTime = 3,
            InventoryType = 'Clickables',
            CastAction = 'CastItem3sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Consumable/snd_item_consumable_Item_Large_Health_Potion',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            FromItem = 'Item_Large_Rejuv_Elixir_Art',
            Icon = 'NewIcons/potions/Potion4Purple',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Large_Rejuv_Elixir_Art',
                    BuffType = 'POTIONREJUV',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = 0,
                    DamageSelf = true,
                    DamageFriendly = true,
                    CanCrit = false,
                    ArmorImmune = true,
                    CanBackFire = false,
                    CanBeEvaded = false,
                    CanMagicResist = false,
                    Affects = {
                        Energy = {Add = 5625},
                        Health = {Add = 5625},
                    },
                },
                BuffBlueprint {
                    Name = 'Item_Large_Rejuv_Elixir_FX_Art',
                    BuffType = 'POTIONREJUVENATION01FX',
                    Debuff = false,
                    Stacks = 'REPLACE',
                    EntityCategory = 'HERO',
                    Duration = 1,
                    Affects = {
                        Dummy = {},
                    },
                    Effects = 'Rejuvenation02',
                    EffectsBone = -1,
                },
            },
        },
    },
    Consumable = true,
}

__moduleinfo.auto_reload = true
