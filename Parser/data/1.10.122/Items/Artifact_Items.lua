#################################################################################################################
# Artifacts
# Shop and costs defined in //depot/forge/main/bindata/units/ug/b/ugbshop05/UGBShop05_unit.bp
#################################################################################################################

local Utils = import('/lua/utilities.lua')
local Entity = import('/lua/sim/entity.lua').Entity
local Buff = import('/lua/sim/Buff.lua')
local CanUseAbility = import('/lua/common/ValidateAbility.lua').CanUseAbility

#################################################################################################################
# Bracelet of Rage
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_010',
    DisplayName = '<LOC ITEM_Artifact_0000>Bracelet of Rage',
    Description = '<LOC ITEM_Artifact_0001>Use: Nearby allied Demigods gain +[GetDamageBonus] Weapon Damage for [GetDuration] seconds. In addition, nearby units gain +[GetMinionDamageBonus] Weapon Damage for [GetDuration] seconds.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0103>+[GetDamageBonusSelf] Weapon Damage',
        },
        MBonuses = {
            '<LOC MBONUS_0004>+[GetMinionDamageBonus] Minion Damage',
        },
    },
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Artifacts/braceletofrage',
    Useable = true,
    InventoryType = 'Clickables',
    GetDamageBonus = function(self) return Buffs['Item_Artifact_010_HERO'].Affects.DamageRating.Add end,
    GetDamageBonusSelf = function(self) return Buffs['Item_Artifact_010_Self'].Affects.DamageRating.Add end,
    GetMinionDamageBonus = function(self) return Buffs['Item_Artifact_010_Grunts'].Affects.DamageRating.Add end,
    GetDuration = function(self) return Buffs['Item_Artifact_010_Grunts'].Duration end,
    GetMaxRange = function(self) return Ability['Item_Artifact_010_Activate'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Artifact_010_Activate'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Artifact_010_Activate'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Artifact_010_Activate'].Cooldown end,
    GetMinionDamageBonus = function(self) return Buffs['Item_Artifact_010_Minion'].Affects.DamageRating.Add end,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_010_Activate',
            Icon = 'NewIcons/Artifacts/braceletofrage',
            AbilityType = 'Instant',
            TargetAlliance = 'Ally',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            AbilityCategory = 'USABLEITEM',
            InventoryType = 'Clickables',
            Cooldown = 45,
            EnergyCost = 0,
            AffectRadius = 15,
            FromItem = 'Item_Artifact_010',
            CanCastWhileMoving = true,
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Artifact_010_Minion', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Artifact_010_Minion', unit )
            end,
            OnStartAbility = function(self, unit)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Artifacts.BraceletOfRageProc, -2 )
            end,
            Tooltip = {
                TargetAlliance = 'Ally',
                Cooldown = 30,
            },
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Artifact/snd_item_artifact_Item_Artifact_010',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_010_Grunts',
                    BuffType = 'ARTIFACTDMGINC',
                    DisplayName = '<LOC ITEM_Artifact_0000>Bracelet of Rage',
                    Description = '<LOC ITEM_Artifact_0002>Damage increased.',
                    Icon = 'NewIcons/Artifacts/braceletofrage',
                    Debuff = false,
                    EntityCategory = 'MOBILE - HERO',
                    Stacks = 'REPLACE',
                    Duration = 10,
                    Affects = {
                        DamageRating = { Add = 25 },
                    },
                    Effects = 'Rage01',
                    EffectsBone = -2,
                },
                BuffBlueprint {
                    Name = 'Item_Artifact_010_HERO',
                    BuffType = 'ARTIFACTDMGINC_HERO',
                    DisplayName = '<LOC ITEM_Artifact_0000>Bracelet of Rage',
                    Description = '<LOC ITEM_Artifact_0002>Damage increased.',
                    Icon = 'NewIcons/Artifacts/braceletofrage',
                    Debuff = false,
                    EntityCategory = 'HERO',
                    Stacks = 'REPLACE',
                    Duration = 10,
                    Affects = {
                        DamageRating = { Add = 300 },
                    },
                    Effects = 'Rage01',
                    EffectsBone = -2,
                },
            },
        },
        AbilityBlueprint {
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_010',
            Name = 'Item_Artifact_010_Self',
            Icon = 'NewIcons/Artifacts/braceletofrage',
            Buffs = {
                BuffBlueprint {
                    BuffType = 'ARTIFACT_010_SELF',
                    Debuff = false,
                    Duration = -1,
                    EntityCategory = 'ALLUNITS',
                    Name = 'Item_Artifact_010_Self',
                    Stacks = 'ALWAYS',
                    Affects = {
                        DamageRating = {Add = 50},
                    },
                },
            },
        },
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Artifact_010_Minion',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Artifact_010_Minion',
            BuffType = 'ARTIFACT10MINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Icon = 'NewIcons/Artifacts/braceletofrage',
            Affects = {
                DamageRating = {Add = 10},
            },
        }
    }
}

#################################################################################################################
# Mage Slayer
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_020',
    DisplayName = '<LOC ITEM_Artifact_0003>Mage Slayer',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0001>+[GetDamageBonus] Weapon Damage',
            '<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
          	'<LOC ITEM_Artifact_0031>+[GetLifeSteal]% Life Steal',
          },
          #ChanceOnHit = '<LOC ITEM_Artifact_0032>[GetProcChance]% chance on hit to stun target for [GetDuration] seconds.',
          TargetAlliance = 'Enemy',
    },
    GetLifeSteal = function(self) return math.floor( Buffs['Item_Artifact_020'].Affects.LifeSteal.Add * 100 ) end,
    GetDamageBonus = function(self) return math.floor( Buffs['Item_Artifact_020'].Affects.DamageRating.Add ) end,
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['Item_Artifact_020'].Affects.RateOfFire.Mult * 100 ) end,
    GetProcChance = function(self) return Ability['Item_Artifact_020_Proc'].WeaponProcChance end,
    GetDuration = function(self) return string.format('%0.1f', Buffs['Item_Artifact_020_Stun'].Duration) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Artifacts/mageslayer',
    SlotLimit = 1,
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_020',
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_020',
            Icon = 'NewIcons/Artifacts/mageslayer',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_020',
                    BuffType = 'IARTSTUN',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        LifeSteal = {Add = 0.12},
                        DamageRating = {Add = 45},
                        RateOfFire = {Mult = 0.25},
                    },
                    Effects = 'Lifesteal02',
                },
            },
        },
        #AbilityBlueprint {
        #    Name = 'Item_Artifact_020_Proc',
        #    AbilityType = 'WeaponProc',
        #    FromItem = 'Item_Artifact_020',
        #    Icon = 'NewIcons/Artifacts/mageslayer',
        #    WeaponProcChance = 15,
        #    WeaponProcChanceRanged = 10,
        #    OnWeaponProc = function(self, unit, target, damageData)
        #        if not target:IsDead() then
        #            Buff.ApplyBuff(target, 'Item_Artifact_020_Stun', unit)
        #        end
        #    end,
        #},
    },
}

BuffBlueprint {
    Name = 'Item_Artifact_020_Stun',
    DisplayName = '<LOC ITEM_Artifact_0003>Mage Slayer',
    Description = '<LOC ITEM_Artifact_0005>Stunned.',
    BuffType = 'IARTSTUN01STUN',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 0.2,
    Affects = {
        Stun = {Add = 0},
    },
    Effects = 'Stun01',
    EffectsBone = -2,
}

#################################################################################################################
# Cloak of Invisibility
#################################################################################################################
#ItemBlueprint {
#    Name = 'Item_Artifact_030',
#    DisplayName = '<LOC ITEM_Artifact_0006>Cloak of Invisibility',
#    Description = '<LOC ITEM_Artifact_0007>Use: Turn invisible for 20 seconds.',
#    Mesh = '/meshes/items/chest/chest_mesh',
#    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
#    MeshScale = 0.10,
#    Icon = 'NewIcons/Artifacts/cloakofinvisibility',
#    Useable = true,
#    InventoryType = 'Clickables',
#    GetEnergyCost = function(self) return Ability['Item_Artifact_030'].EnergyCost end,
#    GetCastTime = function(self) return Ability['Item_Artifact_030'].CastingTime end,
#    GetCooldown = function(self) return Ability['Item_Artifact_030'].Cooldown end,
#    Abilities = {
#        AbilityBlueprint {
#            Name = 'Item_Artifact_030',
#            Icon = 'NewIcons/Artifacts/cloakofinvisibility',
#            AbilityType = 'Instant',
#            AbilityCategory = 'USABLEITEM',
#            InventoryType = 'Clickables',
#            EnergyCost = 0,
#            Cooldown = 30,
#            TargetAlliance = 'Ally',
#            TargetCategory = 'MOBILE - UNTARGETABLE',
#            FromItem = 'Item_Artifact_030',
#            CanCastWhileMoving = true,
#            OnStartAbility = function(self, unit)
#                AttachEffectsAtBone( unit, EffectTemplates.Items.Artifacts.CloakOfInvisibilityActivate, -2 )
#            end,
#            Audio = {
#                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
#                 OnFinishCasting = {Sound = 'Forge/ITEMS/Artifact/snd_item_artifact_Item_Artifact_030',},
#                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
#             },
#            Buffs = {
#                BuffBlueprint {
#                    Name = 'Item_Artifact_030',
#                    BuffType = 'IARTINVISIBILITY',
#                    DisplayName = '<LOC ITEM_Artifact_0006>Cloak of Invisibility',
#                    Description = '<LOC ITEM_Artifact_0008>Invisible.',
#                    Icon = 'NewIcons/Artifacts/cloakofinvisibility',
#                    Debuff = false,
#                    EntityCategory = 'MOBILE',
#                    Stacks = 'IGNORE',
#                    Duration = 20,
#                    Affects = {
#                        Cloak = {Bool = true},
#                    },
#                    OnApplyBuff = function(self, unit, instigator)
#                        self.InvisibilityActive = true
#
#                        # Set conditional callbacks that trigger invisibility removal
#                        unit.Callbacks.OnTakeDamage:Add( self.Damaged, self )
#                        unit.Callbacks.OnAbilityBeginCast:Add( self.CallBackAbilityBeginCast, self )
#                        unit.Callbacks.OnWeaponFire:Add( self.CallBackWeaponFire, self )
#
#                        unit:SetInvisible( true )
#                        unit:SetInvisibleMesh( true )
#                    end,
#                    RemoveInvisibility = function( self, unit )
#                        if not self.InvisibilityActive then
#                            return
#                        end
#                        self.InvisibilityActive = false
#                        unit.Callbacks.OnTakeDamage:Remove( self.Damaged )
#                        unit.Callbacks.OnAbilityBeginCast:Remove( self.CallBackAbilityBeginCast )
#                        unit.Callbacks.OnWeaponFire:Remove( self.CallBackWeaponFire )
#                        unit:SetInvisible( false )
#                        unit:SetInvisibleMesh( false )
#                        unit:PlaySound('Forge/ITEMS/snd_item_buff_end')
#                        if Buff.HasBuff(unit, 'Item_Artifact_030') then
#                            Buff.RemoveBuff(unit, 'Item_Artifact_030')
#                        end
#                    end,
#                    Damaged = function(self, unit, data)
#                        # Don't remove invis on heals
#                        if(data.Amount and data.Amount > 0) then
#                            # Only remove invisibility if this is not self inflicted, fixes Unclean Beast and Sedna
#                            # Also if the instigator is dead then we remove as well ... this fixes epic deaths
#                            if data.Instigator:IsDead() or data.Instigator:GetEntityId() != unit:GetEntityId() then
#                                self:RemoveInvisibility( unit )
#                            end
#                        end
#                    end,
#                    CallBackAbilityBeginCast = function(self, ability, unit)
#                        self:RemoveInvisibility( unit )
#                    end,
#                    CallBackWeaponFire = function( self, unit )
#                        self:RemoveInvisibility( unit )
#                    end,
#                    OnBuffRemove= function(self,unit)
#                        self:RemoveInvisibility( unit )
#                    end,
#                },
#            },
#        },
#    },
#}
#
#################################################################################################################
# Cloak of Flames
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_040',
    DisplayName = '<LOC ITEM_Artifact_0009>Cloak of Flames',
    Description = '<LOC ITEM_Artifact_0037>Use: Cast a ring of fire around yourself, damaging enemies for [GetDamage] damage over [GetDuration] seconds.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Helm_0001>+[GetManaBonus] Mana',
            '<LOC ITEM_Boot_0012>+[GetManaRegenBonus] Mana Per Second',
          	'<LOC ITEM_Artifact_0038>+[GetAttackSpeedBoost]% Attack Speed',
          },
    },
    GetManaBonus = function(self) return math.floor( Buffs['Item_Artifact_040'].Affects.MaxEnergy.Add ) end,
    GetManaRegenBonus = function(self) return math.floor( Buffs['Item_Artifact_040'].Affects.EnergyRegen.Add ) end,
    GetAttackSpeedBoost = function(self) return math.floor( Buffs['Item_Artifact_040'].Affects.RateOfFire.Mult * 100 ) end,
    GetDamage = function(self) return Ability['Item_Artifact_040_2'].DamageAmt * Ability['Item_Artifact_040_2'].Duration end,
    GetDuration = function(self) return Ability['Item_Artifact_040_2'].Duration end,
    GetMaxRange = function(self) return Ability['Item_Artifact_040_2'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Artifact_040_2'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Artifact_040_2'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Artifact_040_2'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Artifacts/cloakofflames',
    Useable = true,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_040_2',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            InventoryType = 'Clickables',
            FromItem = 'Item_Artifact_040',
            TargetAlliance = 'Enemy',
            TargetCategory = 'ALLUNITS - UNTARGETABLE',
            TargetingMethod = 'AREAARGETED',
            Icon = 'NewIcons/Artifacts/cloakofflames',
            AffectRadius = 8,
            Cooldown = 45,
            DamageAmt = 80,
            DamageType = 'SpellFire',
            Segments = 32,
            Duration = 10,
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Artifact/snd_item_artifact_Item_Artifact_040',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            OnStartAbility = function(self, unit, targetData)
                if not unit.AbilityData.Item_Artifact_040_2.RingTrash then
                    unit.AbilityData.Item_Artifact_040_2.RingTrash = TrashBag()
                end
                unit.AbilityData.Item_Artifact_040_2.RingTrash:Add(ForkThread(CreateFireRing, self, unit, targetData ))
            end,
            OnAbortAbility = function(self, unit)
                if unit.AbilityData.Item_Artifact_040_2.RingTrash then
                    unit.AbilityData.Item_Artifact_040_2.RingTrash:Destroy()
                    unit.AbilityData.Item_Artifact_040_2.RingTrash = nil
                end
            end,
        },
        AbilityBlueprint {
            Name = 'Item_Artifact_040',
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_040',
            Icon = 'NewIcons/Artifacts/cloakofflames',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_040',
                    BuffType = 'IARTFIRE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        RateOfFire = {Mult = 0.3},
                        MaxEnergy = {Add = 1050, AdjustEnergy = false},
                        EnergyRegen = {Add = 20},
                    },
                },
            },
        }
    },
}

function CreateFireRing(abil, unit, params)
    #local pos = params.Position
    local pos = table.copy(unit:GetPosition())
    pos[2] = 100
    local points = Utils.GetPointsAroundCircle(pos, abil.AffectRadius, abil.Segments)
    local i = 1
    local army = unit:GetArmy()

    for k, v in points do
        if unit:IsDead() then
            return
        end
        if GetTerrainType(v[1], v[3]).Name != 'Void' then
            local emitters = CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FireRing01', army, v, nil, unit.Trash )
            for k, vEmit in emitters do
                unit.AbilityData.Item_Artifact_040_2.RingTrash:Add(vEmit)
            end
        end
        i = i + 1
        if i == 5 then
            i = 1
            WaitTicks(1)
        end
    end

    # Create effects around TorchBear, Distortion, Small flames inside radius.
    local emitters = CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FireCenter02', army, pos, nil, unit.Trash  )
    for k, vEmit in emitters do
        unit.AbilityData.Item_Artifact_040_2.RingTrash:Add(vEmit)
    end

    local data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = unit:GetArmy(),
        Origin = pos,
        Type = abil.DamageType,
        DamageAction = abil.Name,
        Amount = abil.DamageAmt,
        Radius = abil.AffectRadius,
        DamageFriendly = false,
        DamageSelf = false,
        Group = 'UNITS',
        CanBeEvaded = false,
        CanCrit = false,
        CanBackfire = false,
        CanMagicResist = true,
        ArmorImmune = true,
        NoFloatText = false,
    }

    local i = 0
    while i < abil.Duration do
        DamageArea(data)
        i = i + 1
        WaitSeconds(1)
    end

    if unit.AbilityData.Item_Artifact_040_2.RingTrash then
        unit.AbilityData.Item_Artifact_040_2.RingTrash:Destroy()
        unit.AbilityData.Item_Artifact_040_2.RingTrash = nil
    end
end

#################################################################################################################
# Cloak of Elfinkind
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_050',
    DisplayName = '<LOC ITEM_Artifact_0011>Cloak of Elfinkind',
    Description = '<LOC ITEM_Artifact_0042>Use: Warp to a targeted location.\n',
    Tooltip = {
        	Bonuses = {
        	    '<LOC ITEM_Chest_0001>+[GetArmorBonus] Armor',
              	'<LOC ITEM_Artifact_0043>+[GetDodgeBonus]% Dodge',
              	'<LOC ITEM_Artifact_0044>+[GetMovementBonus]% Movement Speed',
              },
    },
    GetArmorBonus = function(self) return Buffs['Item_Artifact_050'].Affects.Armor.Add end,
    GetDodgeBonus = function(self) return Buffs['Item_Artifact_050'].Affects.Evasion.Add end,
    GetMovementBonus = function(self) return math.floor( Buffs['Item_Artifact_050'].Affects.MoveMult.Mult * 100 ) end,
    GetMaxRange = function(self) return Ability['Item_Artifact_050_2'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Artifact_050_2'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Artifact_050_2'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Artifact_050_2'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Artifacts/cloakofelfinkind',
    Useable = true,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_050_2',
            OnStartAbility = function(self, unit, targetData)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Artifacts.CloakOfElfinkindActivate, -2 )
            end,
            AbilityType = 'TargetedArea',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Enemy',
            InventoryType = 'Clickables',
            TargetCategory = 'MOBILE - UNTARGETABLE',
            TargetingMethod = 'AREAARGETED',
            AffectRadius = 10,
            RangeMax = 15,
            Cooldown = 20,
            FromItem = 'Item_Artifact_050',
            CastingTime = 0,
            CanCastWhileMoving = true,
            CasterEffect = {
                Base = 'Items',
                Group = 'Artifacts',
                Template = 'ScrotusWarp01',
            },
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Artifact/snd_item_artifact_Item_Artifact_050',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
            },
            ErrorMessage = '<LOC error_0029>Cannot move there.',
            ErrorVO = 'Nomove',
            WarpToLocation = true,
            WarpMinions = false,
            Icon = 'NewIcons/Artifacts/cloakofelfinkind',
            Reticule = 'AoE_Warp',
        },
        AbilityBlueprint {
            Name = 'Item_Artifact_050',
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_050',
            Icon = 'NewIcons/Artifacts/cloakofelfinkind',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_050',
                    BuffType = 'IARTMOVEMENT',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Armor = {Add = 750},
                        Evasion = {Add = 15},
                        MoveMult = {Mult = 0.2},
                    },
                },
            },
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Artifact_050Army', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Artifact_050Army', unit )
            end,
        },
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Artifact_050Army',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Artifact_050Army',
            BuffType = 'IARTMOVEMENT',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                MoveMult = {Mult = 0.2},
            },
        }
    }
}

#################################################################################################################
# Unmaker
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_060',
    DisplayName = '<LOC ITEM_Artifact_0013>Unmaker',
    Description = '<LOC ITEM_Artifact_0014>Use: Deal +[GetDamageBonus]% Weapon Damage for [GetUseDuration] seconds.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Glove_0031>+[GetDamageBonus] Weapon Damage',
        },
        MBonuses = {
            '<LOC MBONUS_0004>+[GetMinionDamageBonus] Minion Damage',
            '<LOC MBONUS_0006>+[GetMinionROFBonus]% Minion Attack Speed',
        },
        ChanceOnHit = '<LOC ITEM_Artifact_0051>[GetProcChance]% chance to increase Attack Speed by [GetAttackSpeedBonus]% for [GetProcDuration] seconds.',
    },
    GetProcChance = function(self) return Ability['Item_Artifact_060_WeaponProc'].WeaponProcChance end,
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['Item_Artifact_060_Flurry'].Affects.RateOfFire.Mult * 100 ) end,
    GetProcDuration = function(self) return Buffs['Item_Artifact_060_Flurry'].Duration end,
    GetUseDuration = function(self) return Buffs['Item_Artifact_060'].Duration end,
    GetDamageBonus = function(self) return math.floor( Buffs['Item_Artifact_060'].Affects.DamageRating.Mult * 100 ) end,
    GetMaxRange = function(self) return Ability['Item_Artifact_060'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Artifact_060'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Artifact_060'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Artifact_060'].Cooldown end,
    GetDamageBonus = function(self) return Buffs['Item_Artifact_060_Passive'].Affects.DamageRating.Add end,
    GetMinionDamageBonus = function(self) return Buffs['Item_Artifact_60ARMY'].Affects.DamageRating.Add end,
    GetMinionROFBonus = function(self) return math.floor(Buffs['Item_Artifact_60ARMY'].Affects.RateOfFire.Mult * 100) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Artifacts/Unmaker',
    Useable = true,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_060',
            AbilityType = 'Instant',
            AbilityCategory = 'USABLEITEM',
            InventoryType = 'Clickables',
            Cooldown = 30,
            CastingTime = 0,
            CanCastWhileMoving = true,
            FromItem = 'Item_Artifact_060',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Artifact/snd_item_artifact_Item_Artifact_060',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            CasterEffect = {
                Base = 'Items',
                Group = 'Artifacts',
                Template = 'Agent01',
            },

            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_060',
                    DisplayName = '<LOC ITEM_Artifact_0013>Unmaker',
                    Description = '<LOC ITEM_Artifact_0101>Increased Weapon Damage.',
                    Stacks = 'ALWAYS',
                    Debuff = false,
                    BuffType = 'IARTCRIT2',
                    Duration = 10.0,
                    Affects = {
                        DamageRating = { Mult = .25 },
                    },
                    Icon = 'NewIcons/Artifacts/Unmaker',
                }
            },
            Icon = 'NewIcons/Artifacts/Unmaker',
        },
        AbilityBlueprint {
            Name = 'Item_Artifact_060_WeaponProc',
            AbilityType = 'WeaponProc',
            FromItem = 'Item_Artifact_060',
            Icon = 'NewIcons/Artifacts/Unmaker',
            WeaponProcChance = 20,
            WeaponProcChanceRanged = 13,
            OnWeaponProc = function(self, unit, target, damageData)
                Buff.ApplyBuff(unit, 'Item_Artifact_060_Flurry', unit)
            end,
        },
        AbilityBlueprint {
            Name = 'Item_Artifact_060_Passive',
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_060',
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Artifact_60ARMY', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Artifact_60ARMY', unit )
            end,
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_060_Passive',
                    BuffType = 'IARTCRIT2PASSIVE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        DamageRating = {Add = 20},
                    },
                },
            },
        },
    },
}

BuffBlueprint {
    Name = 'Item_Artifact_060_Flurry',
    DisplayName = '<LOC ITEM_Artifact_0013>Unmaker',
    Description = '<LOC ITEM_Artifact_0016>Increased Attack Speed',
    BuffType = 'IARTCRIT01FLURRY',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 5,
    Affects = {
        RateOfFire = {Mult = 0.3},
    },
    Effects = 'Haste01',
    EffectsBone = -2,

    Icon = 'NewIcons/Artifacts/Unmaker',
}

ArmyBonusBlueprint {
    Name = 'Item_Artifact_60ARMY',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Artifact_60ARMY',
            BuffType = 'IARTCRIT2ARMY',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 10},
                RateOfFire = {Mult = .15},
            },
        }
    }
}

#################################################################################################################
# Deathbringer
#################################################################################################################
ItemBlueprint {
    DisplayName = '<LOC ITEM_Artifact_0017>Deathbringer',
    Description = '<LOC ITEM_Artifact_0018>Use: Silence target, preventing any abilities for [GetDuration] seconds.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0075>+[GetHealthBonus] Health',
            '<LOC ITEM_Artifact_0054>+[GetDamageBonus] Weapon Damage',
            '<LOC ITEM_Artifact_0038>+[GetAttackSpeedBoost]% Attack Speed',
            '<LOC ITEM_Artifact_0055>+[GetManaRegenBonus]% Mana Per Second',
        },
        Cooldown = 30,
        TargetAlliance = 'Enemy',
    },
    GetManaRegenBonus = function(self) return math.floor( Buffs['Item_Artifact_070_Self'].Affects.EnergyRegen.Mult * 100 ) end,
    GetDamageBonus = function(self) return Buffs['Item_Artifact_070_Self'].Affects.DamageRating.Add end,
    GetAttackSpeedBoost = function(self) return math.floor(Buffs['Item_Artifact_070_Self'].Affects.RateOfFire.Mult * 100) end,
    GetHealthBonus = function(self) return Buffs['Item_Artifact_070_Self'].Affects.MaxHealth.Add end,
    GetDuration = function(self) return Buffs['Item_Artifact_070'].Duration end,
    GetMaxRange = function(self) return Ability['Item_Artifact_070_Target01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Artifact_070_Target01'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Artifact_070_Target01'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Artifact_070_Target01'].Cooldown end,
    InventoryType = 'Clickables',
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Name = 'Item_Artifact_070',
    Useable = true,
    Abilities = {
        AbilityBlueprint {
            AbilityType = 'TargetedUnit',
            AbilityCategory = 'USABLEITEM',
            Cooldown = 30,
            CastingTime = 0,
            CanCastWhileMoving = true,
            InventoryType = 'Clickables',
            OnStartAbility = function(self, unit)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Artifacts.DeathBringerActivate, -2 )
            end,
            FromItem = 'Item_Artifact_070',
            Icon = 'NewIcons/Artifacts/deathbringer',
            Name = 'Item_Artifact_070_Target01',
            RangeMax = 20,
            TargetAlliance = 'Enemy',
            CastAction = 'CastItem1sec',
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Artifact/snd_item_artifact_Item_Artifact_070',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            TargetCategory = 'HERO - UNTARGETABLE',
            TargetingMethod = 'HOSTILETARGETED',
            Buffs = {
                BuffBlueprint {
                    BuffType = 'IARTSILENCETARGET',
                    Debuff = true,
                    CanBeDispelled = true,
                    DisplayName = '<LOC ITEM_Artifact_0017>Deathbringer',
                    Description = '<LOC ITEM_Artifact_0102>Silenced.',
                    DoNotPulseIcon = true,
                    Duration = 5,
                    Icon = 'NewIcons/Artifacts/deathbringer',
                    Name = 'Item_Artifact_070',
                    Stacks = 'ALWAYS',
                    Affects = {
                        Silence = {Bool = true,},
                    },
                    Effects = 'Silence01',
                    EffectsBone = -2,
                },
            },
        },
        AbilityBlueprint {
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_070',
            Name = 'Item_Artifact_070_Self',
            Buffs = {
                BuffBlueprint {
                    BuffType = 'IARTSILENCESELF',
                    Debuff = false,
                    Duration = -1,
                    EntityCategory = 'ALLUNITS',
                    Name = 'Item_Artifact_070_Self',
                    Stacks = 'ALWAYS',
                    Affects = {
                        MaxHealth = {Add = 1500, AdjustEnergy = false},
                        RateOfFire = {Mult = 0.2},
                        EnergyRegen = {Mult = 1.5},
                        DamageRating = {Add = 80},
                    },
                },
            },
        },
    },
}

#################################################################################################################
# Stormbringer
#################################################################################################################
ItemBlueprint {
    DisplayName = '<LOC ITEM_Artifact_0020>Stormbringer',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0063>+[GetManaBonus] Mana',
            '<LOC ITEM_Artifact_0055>+[GetManaRegenBonus]% Mana Per Second',
            '<LOC ITEM_Artifact_0064>-[GetCooldownBonus]% to Ability Cooldowns',
        },
        ChanceOnHit = '<LOC ITEM_Artifact_0065>[GetProcChance]% chance on hit to gain [GetProcManaGain]% of your damage in Mana.',
    },
    GetCooldownBonus = function(self) return math.floor( Buffs['Item_Artifact_080'].Affects.Cooldown.Mult * -100 ) end,
    GetManaBonus = function(self) return Buffs['Item_Artifact_080'].Affects.MaxEnergy.Add end,
    GetManaRegenBonus = function(self) return math.floor( Buffs['Item_Artifact_080'].Affects.EnergyRegen.Mult * 100 ) end,
    GetProcChance = function(self) return Ability['Item_Artifact_080_WeaponProc'].WeaponProcChance end,
    GetProcManaGain = function(self) return math.floor( Ability['Item_Artifact_080_WeaponProc'].EnergyReturnPercent * 100 ) end,

    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Name = 'Item_Artifact_080',
    Abilities = {
        AbilityBlueprint {
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_080',
            Icon = 'NewIcons/Artifacts/Stormbringer',
            Name = 'Item_Artifact_080',
            Buffs = {
                BuffBlueprint {
                    BuffType = 'IARTSTORM',
                    Debuff = false,
                    Duration = -1,
                    EntityCategory = 'ALLUNITS',
                    Name = 'Item_Artifact_080',
                    Stacks = 'ALWAYS',
                    Affects = {
                        MaxEnergy = {Add = 2100, AdjustEnergy = false},
                        EnergyRegen = {Mult = .7},
                        Cooldown = {Mult = -0.15},
                    },
                },
            },
        },
        AbilityBlueprint {
            AbilityType = 'WeaponProc',
            EnergyReturnPercent = .1,
            FromItem = 'Item_Artifact_080',
            Name = 'Item_Artifact_080_WeaponProc',
            WeaponProcChance = 100,
            OnWeaponProc = function(self, unit, target, damageData)
                AttachEffectsAtBone( unit, EffectTemplates.Items.Artifacts.StormBringerActivate, -2 )
                local damage = damageData.Amount
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
        },
    },
}

#################################################################################################################
# Girdle of the Giants
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_090',
    DisplayName = '<LOC ITEM_Artifact_0022>Girdle of the Giants',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0075>+[GetHealthBonus] Health',
            '<LOC ITEM_Artifact_0089>+[GetHealthRegen] Health Per Second',
            '<LOC ITEM_Artifact_0085>+[GetDamageBonus] Weapon Damage',
        },
        ChanceOnHit = '<LOC ITEM_Artifact_0076>[GetProcChance]% chance on hit to perform a cleaving attack, damaging nearby enemies.',
    },
    GetHealthBonus = function(self) return Buffs['Item_Artifact_090'].Affects.MaxHealth.Add end,
    GetHealthRegen = function(self) return Buffs['Item_Artifact_090'].Affects.Regen.Add end,
    GetDamageBonus = function(self) return Buffs['Item_Artifact_090'].Affects.DamageRating.Add end,
    GetProcChance = function(self) return Ability['Item_Artifact_090_WeaponProc'].WeaponProcChance end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Artifacts/girdleofgiants',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_090',
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_090',
            Icon = 'NewIcons/Artifacts/girdleofgiants',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_090',
                    BuffType = 'IARTGIRDLE',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 1600, AdjustEnergy = false},
                        Regen = {Add = 20},
                        DamageRating = {Add = 50},
                    },
                },
            },
        },
        AbilityBlueprint {
            Name = 'Item_Artifact_090_WeaponProc',
            AbilityType = 'WeaponProc',
            FromItem = 'Item_Artifact_090',
            Icon = 'NewIcons/Artifacts/girdleofgiants',
            WeaponProcChance = 100,
            WeaponProcChanceRanged = 100,
            CleaveSize = 2.5,
            OnWeaponProc = function(self, unit, target, damageData)
                local wepbp = unit:GetWeaponByLabel( damageData.DamageAction ):GetBlueprint()
                local damageAmt = wepbp.Damage + unit.Sync.DamageRating
                AttachEffectsAtBone( unit, EffectTemplates.Items.Artifacts.GirdleOfTheGiantsProc, -2 )

                local data = {
                    Instigator = unit,
                    InstigatorBp = unit:GetBlueprint(),
                    InstigatorArmy = unit:GetArmy(),
                    Origin = target:GetPosition(),
                    Amount = damageAmt,
                    Type = 'Hero',
                    DamageAction = self.Name,
                    Radius = self.CleaveSize,
                    DamageFriendly = false,
                    DamageSelf = false,
                    IgnoreTargets = { target },
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
# Ashkandor
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_100',
    DisplayName = '<LOC ITEM_Artifact_0024>Ashkandor',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0084>+[GetLifeStealBonus]% Life Steal',
            '<LOC ITEM_Artifact_0085>+[GetDamageBonus] Weapon Damage',
            '<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
        },
        MBonuses = {
            '<LOC ITEM_Glove_0040>+[GetMinionDamageBonus] Minion Damage',
            '<LOC ITEM_Glove_0041>+[GetMinionROFBonus]% Minion Attack Speed',
        },
        Passives = '<LOC ITEM_Glove_0039>[GetCritChance]% chance deal a critical strike for [GetCritDamage]x damage.',
    },
    GetLifeStealBonus = function(self) return math.floor( Buffs['Item_Artifact_100'].Affects.LifeSteal.Add * 100 ) end,
    GetDamageBonus = function(self) return Buffs['Item_Artifact_100'].Affects.DamageRating.Add end,
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['Item_Artifact_100'].Affects.RateOfFire.Mult * 100 ) end,
    GetCritChance = function(self) return Ability['Item_Artifact_100_Crit'].CritChance end,
    GetCritDamage = function(self) return Ability['Item_Artifact_100_Crit'].CritMult end,
    GetMinionDamageBonus = function(self) return Buffs['Item_Artifact_100ARMY'].Affects.DamageRating.Add end,
    GetMinionROFBonus = function(self) return math.floor( Buffs['Item_Artifact_100ARMY'].Affects.RateOfFire.Mult * 100 ) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Artifacts/ashkandor',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_100',
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_100',
            Icon = 'NewIcons/Artifacts/ashkandor',
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Artifact_100ARMY', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Artifact_100ARMY', unit )
            end,
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_100',
                    BuffType = 'IARTRING',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        LifeSteal = {Add = 0.12},
                        DamageRating = {Add = 120},
                        RateOfFire = {Mult = .25},
                    },
                    Effects = 'Lifesteal02',
                },
            },
        },
        AbilityBlueprint {
            Name = 'Item_Artifact_100_Crit',
            AbilityType = 'WeaponCrit',
            CritChance = 10,
            CritMult = 4.0,
        },
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Artifact_100ARMY',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Artifact_100ARMY',
            BuffType = 'IARTRINGARMY',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 15},
                RateOfFire = {Mult = .15},
            },
        }
    }
}

#################################################################################################################
# Orb of Veiled Storms
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_110',
    DisplayName = '<LOC ITEM_Artifact_0026>Orb of Veiled Storms',
    Description = '<LOC ITEM_Artifact_0027>Use: Unleash a wave of pure force in an area, dealing [GetDamage] damage.',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0089>+[GetHealthRegen] Health Per Second',
            '<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
        },
    },
    GetHealthRegen = function(self) return Buffs['Item_Artifact_110_2'].Affects.Regen.Add end,
    GetAttackSpeedBonus = function(self) return math.floor(Buffs['Item_Artifact_110_2'].Affects.RateOfFire.Mult * 100 ) end,
    GetDamage = function(self) return Ability['Item_Artifact_110'].Damage end,
    GetMaxRange = function(self) return Ability['Item_Artifact_110'].RangeMax end,
    GetEnergyCost = function(self) return Ability['Item_Artifact_110'].EnergyCost end,
    GetCastTime = function(self) return Ability['Item_Artifact_110'].CastingTime end,
    GetCooldown = function(self) return Ability['Item_Artifact_110'].Cooldown end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Artifacts/orbofveiledstorms',
    Useable = true,
    SlotLimit = 1,
    InventoryType = 'Clickables',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_110',
            FromItem = 'Item_Artifact_110',
            AbilityType = 'Instant',
            InventoryType = 'Clickables',
            AbilityCategory = 'USABLEITEM',
            TargetAlliance = 'Enemy',
            TargetCategory = 'ALLUNITS - UNTARGETABLE',
            AffectRadius = 10,
            Cooldown = 45,
            Damage = 500,
            DamageType = 'SpellForce',
            CastingTime = 0,
            CanCastWhileMoving = true,
            Audio = {
                 OnStartCasting = {Sound = 'Forge/ITEMS/snd_item_conjure',},
                 OnFinishCasting = {Sound = 'Forge/ITEMS/Artifact/snd_item_artifact_Item_Artifact_110',},
                 OnAbortCasting = {Sound = 'Forge/ITEMS/snd_item_abort',},
             },
            CasterEffect = {
                Base = 'Items',
                Group = 'Artifacts',
                Template = 'ScathisForceNova01',
            },
            OnStartAbility = function(self, unit, params)
                local pos = unit:GetPosition()

                pos[2] = GetSurfaceHeight(pos[1], pos[3]) - 0.25
                local data = {
                    Instigator = unit,
                    InstigatorBp = unit:GetBlueprint(),
                    InstigatorArmy = unit:GetArmy(),
                    Origin = pos,
                    Radius = self.AffectRadius,
                    Amount = 10,
                    Category = 'METAINFANTRY',
                }
                MetaImpact(data)
                local data = {
                    Instigator = unit,
                    InstigatorBp = unit:GetBlueprint(),
                    InstigatorArmy = unit:GetArmy(),
                    Origin = unit:GetPosition(),
                    Amount = self.Damage,
                    Type = self.DamageType,
                    DamageAction = self.Name,
                    Radius = self.AffectRadius,
                    DamageFriendly = false,
                    DamageSelf = false,
                    Group = 'UNITS',
                    CanBeEvaded = false,
                    CanCrit = false,
                    CanBackfire = true,
                    CanMagicResist = true,
                    ArmorImmune = false,
                }
                local entities = GetEntitiesInSphere('UNITS', pos, self.AffectRadius )
		        local affectedEntities = {}
                DamageArea(data)
            end,
            Icon = 'NewIcons/Artifacts/orbofveiledstorms',
        },
        AbilityBlueprint {
            Name = 'Item_Artifact_110_2',
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_110',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_110_2',
                    BuffType = 'IARTDAMAGE3',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Regen = {Add = 24},
                        RateOfFire = {Mult = .25},
                    },
                },
            },
        },
    },
}

#################################################################################################################
# Bulwark of the Ages
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_120',
    DisplayName = '<LOC ITEM_Artifact_0028>Bulwark of the Ages',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0097>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
            '<LOC ITEM_Artifact_0092>+[GetArmorBonus] Armor',
        },
        MBonuses = {
            '<LOC MBONUS_0000>+[GetMinionHealthBonus] Minion Health',
            '<LOC MBONUS_0003>+[GetMinionArmorBonus] Minion Armor',
        },
        Passives = '<LOC ITEM_Artifact_0093>All damage reduced by [GetDamageReduction]%.',
        TargetAlliance = 'Ally',
    },
    GetArmorBonus = function(self) return Buffs['Item_Artifact_120'].Affects.Armor.Add end,
    GetHealthBonus = function(self) return Buffs['Item_Artifact_120'].Affects.MaxHealth.Add end,
    GetRegenBonus = function(self) return Buffs['Item_Artifact_120'].Affects.Regen.Add end,
    GetDamageReduction = function(self) return math.floor( Buffs['Item_Artifact_120'].Affects.DamageTakenMult.Add * -100 ) end,
    GetMinionHealthBonus = function(self) return Buffs['Item_Artifact_120_Minion'].Affects.MaxHealth.Add end,
    GetMinionArmorBonus = function(self) return Buffs['Item_Artifact_120_Minion'].Affects.Armor.Add end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Artifacts/bulwarkoftheages',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_120',
            AbilityType = 'Quiet',
            FromItem = 'Item_Artifact_120',
            Icon = 'NewIcons/Artifacts/bulwarkoftheages',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_120',
                    Description = '<LOC ITEM_Artifact_0028>Bulwark of the Ages',
                    BuffType = 'IARTTHORNS',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        Armor = {Add = 1500},
                        MaxHealth = {Add = 1000, AdjustEnergy = false},
                        Regen = {Add = 20},
                        DamageTakenMult = {Add = -0.25}
                    },
                    #Effects = 'RunSpeed01',
                },
            },
        }
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Artifact_120_Minion',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Artifact_120_Minion',
            BuffType = 'ARTIFACT120MINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Icon = 'NewIcons/Artifacts/bulwarkoftheages',
            Affects = {
                MaxHealth = {Add = 250, AdjustEnergy = false},
                Armor = {Add = 375},
            },
        }
    }
}

#################################################################################################################
# All Father's Ring
#################################################################################################################
ItemBlueprint {
    Name = 'Item_Artifact_130',
    DisplayName = '<LOC ITEM_Artifact_0030>All Father\'s Ring',
    Tooltip = {
        Bonuses = {
            '<LOC ITEM_Artifact_0097>+[GetHealthBonus] Health',
            '<LOC ITEM_Chest_0025>+[GetRegenBonus] Health Per Second',
            '<LOC ITEM_Artifact_0098>+[GetManaBonus] Mana',
            '<LOC ITEM_Boot_0012>+[GetManaRegenBonus] Mana Per Second',
            '<LOC ITEM_Artifact_0099>+[GetArmorBonus] Armor',
            '<LOC ITEM_Glove_0001>+[GetDamageBonus] Weapon Damage',
            '<LOC ITEM_Glove_0003>+[GetAttackSpeedBonus]% Attack Speed',
            '<LOC ITEM_Artifact_0100>+[GetMovementBonus]% Movement Speed',
            '<LOC ITEM_Boot_0013>+[GetDodgeBonus]% Dodge',
        },
        MBonuses = {
            '<LOC MBONUS_0000>+[GetMinionHealthBonus] Minion Health',
            '<LOC MBONUS_0003>+[GetMinionArmorBonus] Minion Armor',
            '<LOC MBONUS_0004>+[GetMinionDamageBonus] Minion Damage',
            '<LOC MBONUS_0006>+[GetMinionROFBonus]% Minion Attack Speed',
        },
        TargetAlliance = 'Ally',
    },
    GetHealthBonus = function(self) return Buffs['Item_Artifact_130'].Affects.MaxHealth.Add end,
    GetRegenBonus = function(self) return Buffs['Item_Artifact_130'].Affects.Regen.Add end,
    GetManaBonus = function(self) return Buffs['Item_Artifact_130'].Affects.MaxEnergy.Add end,
    GetManaRegenBonus = function(self) return Buffs['Item_Artifact_130'].Affects.EnergyRegen.Add end,
    GetArmorBonus = function(self) return Buffs['Item_Artifact_130'].Affects.Armor.Add end,
    GetDamageBonus = function(self) return Buffs['Item_Artifact_130'].Affects.DamageRating.Add end,
    GetAttackSpeedBonus = function(self) return math.floor( Buffs['Item_Artifact_130'].Affects.RateOfFire.Mult * 100 ) end,
    GetMovementBonus = function(self) return math.floor( Buffs['Item_Artifact_130'].Affects.MoveMult.Mult * 100 ) end,
    GetDodgeBonus = function(self) return Buffs['Item_Artifact_130'].Affects.Evasion.Add end,
    GetMinionHealthBonus = function(self) return Buffs['Item_Artifact_130Army'].Affects.MaxHealth.Add end,
    GetMinionArmorBonus = function(self) return Buffs['Item_Artifact_130Army'].Affects.Armor.Add end,
    GetMinionDamageBonus = function(self) return Buffs['Item_Artifact_130Army'].Affects.DamageRating.Add end,
    GetMinionROFBonus = function(self) return math.floor(Buffs['Item_Artifact_130Army'].Affects.RateOfFire.Mult * 100) end,
    Mesh = '/meshes/items/chest/chest_mesh',
    Animation = '/meshes/items/chest/Animations/chest_Idle_anim.gr2',
    MeshScale = 0.10,
    Icon = 'NewIcons/Ring/Ring6',
    Abilities = {
        AbilityBlueprint {
            Name = 'Item_Artifact_130',
            AbilityType = 'Quiet',
            Icon = 'NewIcons/Ring/Ring6',
            FromItem = 'Item_Artifact_130',
            Buffs = {
                BuffBlueprint {
                    Name = 'Item_Artifact_130',
                    BuffType = 'IARTSTATSRING',
                    Debuff = false,
                    EntityCategory = 'ALLUNITS',
                    Stacks = 'ALWAYS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {Add = 1800, AdjustEnergy = false},
                        Regen = {Add = 30},
                        MaxEnergy = {Add = 2600, AdjustEnergy = false},
                        EnergyRegen = {Add = 25},
                        Armor = {Add = 1500},
                        DamageRating = {Add = 50},
                        RateOfFire = {Mult = .30},
                        MoveMult = {Mult = 0.15},
                        Evasion = {Add = 10},
                    },
                    Effects = 'SingleRing01',
                }
            },
            OnAbilityAdded = function(self, unit)
                unit:GetAIBrain():AddArmyBonus( 'Item_Artifact_130Army', unit )
            end,
            OnRemoveAbility = function(self, unit)
                unit:GetAIBrain():RemoveArmyBonus( 'Item_Artifact_130Army', unit )
            end,
        }
    },
}

ArmyBonusBlueprint {
    Name = 'Item_Artifact_130Army',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'Item_Artifact_130Army',
            BuffType = 'IARTSTATSRING',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                MaxHealth = {Add = 450, AdjustEnergy = false},
                Armor = {Add = 375},
                DamageRating = {Add = 10},
                RateOfFire = {Mult = .15},
                MoveMult = {Mult = 0.1},
            },
        }
    }
}

__moduleinfo.auto_reload = true
