local Buff = import('/lua/sim/buff.lua')
local Abil = import('/lua/sim/ability.lua')
local Validate = import('/lua/common/ValidateAbility.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
local Utils = import('/lua/utilities.lua')

#################################################################################################################
# Max Range I
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01MaxRange01',
    DisplayName = '<LOC ABILITY_HGSA01_0000>Sniper\'s Scope I',
    Description = '<LOC ABILITY_HGSA01_0050>Regulus tunes his crossbow, increasing its range by [GetRangeBuff].',
    AbilityType = 'Quiet',
    GetRangeBuff = function(self) return math.floor( Buffs[self.Name].Affects.MaxRadius.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HGSA01MaxRange01',
            DisplayName = '<LOC ABILITY_HGSA01_0070>Sniper\'s Scope I',
            BuffType = 'HGSA01MAXRANGE',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                MaxRadius = {Add = 2},
            },
        },
    },
    Icon = '/DGRegulus/NewRegulusScope01',
}

#################################################################################################################
# Max Range II
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01MaxRange02',
    DisplayName = '<LOC ABILITY_HGSA01_0001>Sniper\'s Scope II',
    Description = '<LOC ABILITY_HGSA01_0050>Regulus tunes his crossbow, increasing its range by [GetRangeBuff].',
    AbilityType = 'Quiet',
    GetRangeBuff = function(self) return math.floor( Buffs[self.Name].Affects.MaxRadius.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HGSA01MaxRange02',
            DisplayName = '<LOC ABILITY_HGSA01_0071>Sniper\'s Scope II',
            BuffType = 'HGSA01MAXRANGE',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                MaxRadius = {Add = 4},
            },
        },
    },
    Icon = '/DGRegulus/NewRegulusScope01',
}

#################################################################################################################
# Max Range III
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01MaxRange03',
    DisplayName = '<LOC ABILITY_HGSA01_0002>Sniper\'s Scope III',
    Description = '<LOC ABILITY_HGSA01_0050>Regulus tunes his crossbow, increasing its range by [GetRangeBuff].',
    AbilityType = 'Quiet',
    GetRangeBuff = function(self) return math.floor( Buffs[self.Name].Affects.MaxRadius.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HGSA01MaxRange03',
            DisplayName = '<LOC ABILITY_HGSA01_0072>Sniper\'s Scope III',
            BuffType = 'HGSA01MAXRANGE',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                MaxRadius = {Add = 6},
            },
        },
    },
    Icon = '/DGRegulus/NewRegulusScope01',
}

#################################################################################################################
# VFX: Deadeye
#################################################################################################################

function FxDeadeyeImpact( target )
    #CreateTemplatedEffectAtPos( 'Projectiles', nil, 'Bolt01ImpactDeadeye', unit:GetArmy(), pos )
    AttachEffectAtBone( target, 'Projectiles', 'Bolt01ImpactDeadeye', -1 )
end

#################################################################################################################
# Deadeye Proc
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Deadeye01',
    DisplayName = '<LOC ABILITY_HGSA01_0003>Deadeye',
    Description = '<LOC ABILITY_HGSA01_0004>Regulus has a [GetChance]% chance of stopping his enemies dead in their tracks, stunning them for [GetDuration] seconds.',
    GetChance = function(self) return math.floor( self.WeaponProcChance ) end,
    GetDuration = function(self) return string.format("%.1f", Buffs['HGSA01DeadeyeStun01'].Duration) end,
    AbilityType = 'WeaponProc',
    WeaponProcChance = 3,
    OnWeaponProc = function(self, unit, target, damageData)
        if EntityCategoryContains(categories.MOBILE, target) and not EntityCategoryContains(categories.UNTARGETABLE, target) then
            Buff.ApplyBuff(target, 'HGSA01DeadeyeStun01', unit)
            # Play altered impact effects on top of normal effects
            #FxDeadeyeImpact(unit, damageData.Origin)
            FxDeadeyeImpact(target)
        end
    end,
    Icon = '/DGRegulus/NewRegulusDeadeye01',
}

#################################################################################################################
# Deadeye Debuff
#################################################################################################################
BuffBlueprint {
    Name = 'HGSA01DeadeyeStun01',
    DisplayName = '<LOC ABILITY_HGSA01_0073>Deadeye',
    Description = '<LOC ABILITY_HGSA01_0005>Stunned.',
    BuffType = 'HGSA01DEADEYESTUN',
    EntityCategory = 'MOBILE - UNTARGETABLE',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 0.3,
    Affects = {
        Stun = {Add = 0},
    },
    Icon = '/DGRegulus/NewRegulusDeadeye01',
}

#################################################################################################################
# CE
# Snipe
# The damage based on distance is in the Bolt02 projectile script.
#################################################################################################################
function Snipe(abilityDef, unit, params, buffs, explosion)
    # create muzzle flash effects
    AttachEffectAtBone( unit, 'Projectiles', 'Bolt02Launch', 'sk_Sniper_Turret_Muzzle_REF', unit.TrashOnKilled )
    # create push back effects at Regulus feet
    AttachEffectAtBone( unit, 'Regulus', 'Snipe01PreLaunch03', -2, unit.TrashOnKilled )

    # shoot projectile
    local target = params.Targets[1]
    local dir = VNormal( VDiff(target:GetPosition(),unit:GetPosition()) )
    local proj = unit:CreateProjectileAtBone('/projectiles/Bolt02/Bolt02_proj.bp', 'sk_Sniper_Turret_Muzzle_REF')
    proj:SetOrientation(OrientFromDir(dir), true)
    proj:SetNewTarget(target)
    proj:SetVelocityVector(dir)
    proj:SetVelocity(200)

    local damageTable = {
            Radius = 0,
            Type = 'Spell',
            DamageAction = abilityDef.Name,
            DamageFriendly = false,
            CollideFriendly = false,
            Amount = abilityDef.DamageAmt,
            CanCrit = false,
            CanBeEvaded = false,
            CanBackfire = false,
            CanDamageReturn = false,
            CanMagicResist = false,
            ArmorImmune = true,
            IgnoreDamageRangePercent = true,
            LauncherPosition = unit:GetPosition(),
            Instigator = unit,
        }

    if Validate.HasAbility(unit,'HGSA01Track') then
        damageTable.Buff = 'HGSA01Tracked'
    end
    if proj and not proj:BeenDestroyed() then
        proj:PassDamageData(unit,damageTable)
    end
end

#################################################################################################################
# Snipe I
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Snipe01',
    DisplayName = '<LOC ABILITY_HGSA01_0006>Snipe I',
    Description = '<LOC ABILITY_HGSA01_0007>Regulus takes time to set up a devastating shot, piercing a target for [GetInitialDamage] damage plus additional damage as it travels.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 450,
    RangeMax = 90,
    Cooldown = 15,
    DamageAmt = 250,
    DamageType = 'Spell',
    CastingTime = 2.0,
    FollowThroughTime = 0.5,
    UISlot = 1,
    HotKey = '1',
    LockWeapons = true,
    CastAction = 'Snipe',
    GetInitialDamage = function(self) return math.floor( self.DamageAmt ) end,
    OnStartAbility = function(self, unit, params)
        Snipe(self, unit, params)
    end,
    OnStartCasting = function(self, unit)
        # Create casting effects
        AttachCharacterEffectsAtBone( unit, 'sniper', 'Snipe01PreLaunch01', 'sk_Sniper_Turret_Muzzle_REF', unit.TrashOnKilled )
        AttachCharacterEffectsAtBone( unit, 'sniper', 'Snipe01PreLaunch02', -2, unit.TrashOnKilled )
    end,
    Icon = '/DGRegulus/NewRegulusSnipe01',
}

#################################################################################################################
# Snipe II
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Snipe02',
    DisplayName = '<LOC ABILITY_HGSA01_0008>Snipe II',
    Description = '<LOC ABILITY_HGSA01_0007>Regulus takes time to set up a devastating shot, piercing a target for [GetInitialDamage] damage plus additional damage as it travels.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 550,
    RangeMax = 90,
    Cooldown = 15,
    DamageAmt = 400,
    DamageType = 'Spell',
    CastingTime = 2.0,
    FollowThroughTime = 0.5,
    UISlot = 1,
    HotKey = '1',
    LockWeapons = true,
    CastAction = 'Snipe',
    GetInitialDamage = function(self) return math.floor( self.DamageAmt ) end,
    OnStartAbility = function(self, unit, params)
        Snipe(self, unit, params)
    end,
    OnStartCasting = function(self, unit)
        # Create casting effects
        AttachCharacterEffectsAtBone( unit, 'sniper', 'Snipe01PreLaunch01', 'sk_Sniper_Turret_Muzzle_REF', unit.TrashOnKilled )
        AttachCharacterEffectsAtBone( unit, 'sniper', 'Snipe01PreLaunch02', -2, unit.TrashOnKilled )
    end,
    Icon = '/DGRegulus/NewRegulusSnipe01',
}

#################################################################################################################
# Snipe III
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Snipe03',
    DisplayName = '<LOC ABILITY_HGSA01_0010>Snipe III',
    Description = '<LOC ABILITY_HGSA01_0007>Regulus takes time to set up a devastating shot, piercing a target for [GetInitialDamage] damage plus additional damage as it travels.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 650,
    RangeMax = 90,
    Cooldown = 15,
    DamageAmt = 550,
    DamageType = 'Spell',
    CastingTime = 2.0,
    FollowThroughTime = 0.5,
    UISlot = 1,
    HotKey = '1',
    LockWeapons = true,
    CastAction = 'Snipe',
    GetInitialDamage = function(self) return math.floor( self.DamageAmt ) end,
    OnStartAbility = function(self, unit, params)
        Snipe(self, unit, params)
    end,
    OnStartCasting = function(self, unit)
        # Create casting effects
        AttachCharacterEffectsAtBone( unit, 'sniper', 'Snipe01PreLaunch01', 'sk_Sniper_Turret_Muzzle_REF', unit.TrashOnKilled )
        AttachCharacterEffectsAtBone( unit, 'sniper', 'Snipe01PreLaunch02', -2, unit.TrashOnKilled )
    end,
    Icon = '/DGRegulus/NewRegulusSnipe01',
}

#################################################################################################################
# Snipe IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Snipe04',
    DisplayName = '<LOC ABILITY_HGSA01_0081>Snipe IV',
    Description = '<LOC ABILITY_HGSA01_0007>Regulus takes time to set up a devastating shot, piercing a target for [GetInitialDamage] damage plus additional damage as it travels.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 750,
    RangeMax = 90,
    Cooldown = 15,
    DamageAmt = 700,
    DamageType = 'Spell',
    CastingTime = 2.0,
    FollowThroughTime = 0.5,
    UISlot = 1,
    HotKey = '1',
    LockWeapons = true,
    CastAction = 'Snipe',
    GetInitialDamage = function(self) return math.floor( self.DamageAmt ) end,
    OnStartAbility = function(self, unit, params)
        Snipe(self, unit, params)
    end,
    OnStartCasting = function(self, unit)
        # Create casting effects
        AttachCharacterEffectsAtBone( unit, 'sniper', 'Snipe01PreLaunch01', 'sk_Sniper_Turret_Muzzle_REF', unit.TrashOnKilled )
        AttachCharacterEffectsAtBone( unit, 'sniper', 'Snipe01PreLaunch02', -2, unit.TrashOnKilled )
    end,
    Icon = '/DGRegulus/NewRegulusSnipe01',
}
#################################################################################################################
# Maim I
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Maim01',
    DisplayName = '<LOC ABILITY_HGSA01_0047>Maim I',
    Description = '<LOC ABILITY_HGSA01_0013>Regulus aims for the legs of his enemies, decreasing their Movement Speed by [GetSlowBuff]% when hit.\n\nLasts [GetDuration] seconds.',
    AbilityType = 'Quiet',
    TargetAlliance = 'Enemy',
    GetSlowBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnPostDamage:Add(self.MaimTarget, self)
    end,
    MaimTarget = function(self, unit, target, data)
        for k, buff in self.TargetBuffs do
            Buff.ApplyBuff(target, buff, unit)
        end
    end,
    OnRemoveAbility = function(self, unit)
        unit.Callbacks.OnPostDamage:Remove(self.MaimTarget)
    end,
    TargetBuffs = {
        BuffBlueprint {
            Name = 'HGSA01Maim01',
            DisplayName = '<LOC ABILITY_HGSA01_0012>Maim',
            Description = '<LOC ABILITY_HGSA01_0014>Movement Speed reduced.',
            BuffType = 'HGSA01MAIM',
            EntityCategory = 'MOBILE - UNTARGETABLE',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 3,
            Affects = {
                MoveMult = {Mult = -0.05},
            },
            Effects = 'Slow03',
            EffectsBone = -2,
            Icon = '/DGRegulus/NewRegulusMaim01',
        },
    },

}

#################################################################################################################
# Maim II
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Maim02',
    DisplayName = '<LOC ABILITY_HGSA01_0048>Maim II',
    Description = '<LOC ABILITY_HGSA01_0013>Regulus aims for the legs of his enemies, decreasing their Movement Speed by [GetSlowBuff]% when hit.\n\nLasts [GetDuration] seconds.',
    AbilityType = 'Quiet',
    TargetAlliance = 'Enemy',
    GetSlowBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnPostDamage:Add(self.MaimTarget, self)
    end,
    MaimTarget = function(self, unit, target, data)
        for k, buff in self.TargetBuffs do
            Buff.ApplyBuff(target, buff, unit)
        end
    end,
    OnRemoveAbility = function(self, unit)
        unit.Callbacks.OnPostDamage:Remove(self.MaimTarget)
    end,
    TargetBuffs = {
        BuffBlueprint {
            Name = 'HGSA01Maim02',
            DisplayName = '<LOC ABILITY_HGSA01_0012>Maim',
            Description = '<LOC ABILITY_HGSA01_0014>Movement Speed reduced.',
            BuffType = 'HGSA01MAIM',
            EntityCategory = 'MOBILE - UNTARGETABLE',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 3,
            Affects = {
                MoveMult = {Mult = -0.07},
            },
            Effects = 'Slow03',
            EffectsBone = -2,
            Icon = '/DGRegulus/NewRegulusMaim01',
        },
    },
}

#################################################################################################################
# Maim III
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Maim03',
    DisplayName = '<LOC ABILITY_HGSA01_0049>Maim III',
    Description = '<LOC ABILITY_HGSA01_0013>Regulus aims for the legs of his enemies, decreasing their Movement Speed by [GetSlowBuff]% when hit.\n\nLasts [GetDuration] seconds.',
    AbilityType = 'Quiet',
    TargetAlliance = 'Enemy',
    GetSlowBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnPostDamage:Add(self.MaimTarget, self)
    end,
    MaimTarget = function(self, unit, target, data)
        for k, buff in self.TargetBuffs do
            Buff.ApplyBuff(target, buff, unit)
        end
    end,
    OnRemoveAbility = function(self, unit)
        unit.Callbacks.OnPostDamage:Remove(self.MaimTarget)
    end,
    TargetBuffs = {
        BuffBlueprint {
            Name = 'HGSA01Maim03',
            DisplayName = '<LOC ABILITY_HGSA01_0012>Maim',
            Description = '<LOC ABILITY_HGSA01_0014>Movement Speed reduced.',
            BuffType = 'HGSA01MAIM',
            EntityCategory = 'MOBILE - UNTARGETABLE',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 3,
            Affects = {
                MoveMult = {Mult = -0.1},
            },
            Effects = 'Slow03',
            EffectsBone = -2,
            Icon = '/DGRegulus/NewRegulusMaim01',
        },
    },
}

#################################################################################################################
# VFX: Impedance
#################################################################################################################

function FxImpedanceImpact( army, pos )
    CreateTemplatedEffectAtPos( 'Projectiles', nil, 'Bolt01ImpactImpedance', army, pos )
end

#################################################################################################################
# Impedance Bolt Proc
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01ImpedanceBolt01',
    DisplayName = '<LOC ABILITY_HGSA01_0017>Impedance Bolt',
    Description = '<LOC ABILITY_HGSA01_0018>Regulus\' bolts have a [GetChance]% chance to cripple the flow of Mana, doubling the cost of abilities for [GetDuration] seconds.',
    GetChance = function(self) return math.floor( self.WeaponProcChance ) end,
    GetDuration = function(self) return math.floor( Buffs['HGSA01ImpedanceBoltDebuff01'].Duration ) end,
    AbilityType = 'WeaponProc',
    WeaponProcChance = 10,
    OnWeaponProc = function(self, unit, target, damageData)
        Buff.ApplyBuff(target, 'HGSA01ImpedanceBoltDebuff01', unit)

        # Play altered impact effects on top of normal effects, if the unit is a Hero
        if EntityCategoryContains(categories.HERO, target) then
            FxImpedanceImpact(unit:GetArmy(), damageData.Origin)
        end
    end,
    Icon = '/DGRegulus/NewRegulusImpedenceBolt01',
}

#################################################################################################################
# Impedance Bolt Debuff
#################################################################################################################
BuffBlueprint {
    Name = 'HGSA01ImpedanceBoltDebuff01',
    DisplayName = '<LOC ABILITY_HGSA01_0074>Impedance Bolt',
    Description = '<LOC ABILITY_HGSA01_0019>Ability Mana cost increased.',
    BuffType = 'HGSA01IMPEDANCEINCREASE',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    EntityCategory = 'HERO - UNTARGETABLE',
    Duration = 10,
    Affects = {
        SpellCostMult = {Mult = 2.0},
    },
    Effects = 'Impedance01',
    EffectsBone = -2,
    Icon = '/DGRegulus/NewRegulusImpedenceBolt01',
}

#################################################################################################################
# VFX: Mark of the Betrayer
#################################################################################################################

function FxMarkBetrayer( unit )
    local BuffClass = unit:GetEffectBuffClassification()
    local BuffOffset = 5

    if BuffClass == 'Huge' then
        BuffOffset = 10
    elseif BuffClass == 'Large' then
        BuffOffset = 6.5
    end

    AttachEffectsAtBone( unit, EffectTemplates.Regulus.MarkBetrayer01, -2, BuffOffset / 7, {0, BuffOffset, 0} )
    AttachEffectsAtBone( unit, EffectTemplates.Regulus.MarkBetrayer02, -2, BuffOffset / 7 )
end

function FxTriggerMarkBetrayer( unit )
    local BuffClass = unit:GetEffectBuffClassification()
    local BuffOffset = 2.5

    if BuffClass == 'Huge' then
        BuffOffset = 5
    elseif BuffClass == 'Large' then
        BuffOffset = 3.5
    end

    AttachEffectsAtBone( unit, EffectTemplates.Regulus.MarkBetrayer03, -2, BuffOffset / 2.5, {0, BuffOffset, 0} )
    AttachEffectsAtBone( unit, EffectTemplates.Regulus.MarkBetrayer02, -2, BuffOffset / 2.5 )
end

function FxCastMarkBetrayer( self, unit )
    AttachEffectsAtBone( unit, EffectTemplates.Regulus.MarkBetrayerCast01, -2 )
end

#################################################################################################################
# Mark of the Betrayer I
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Betrayer01',
    DisplayName = '<LOC ABILITY_HGSA01_0020>Mark of the Betrayer I',
    Description = '<LOC ABILITY_HGSA01_0021>Regulus fires at a Demigod, marking them with a rune. When they perform an ability, they and their nearby allies take [GetDamageAmt] damage. Also, the Demigod\'s Movement Speed is reduced by [GetSlowBuff]% for [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'HERO - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 600,
    RangeMax = 20,
    Cooldown = 20,
    DamageType = 'Spell',
    CastingTime = 0.1,
    FollowThroughTime = 0.9,
    CastAction = 'Mark',
    UISlot = 3,
    HotKey = '3',
    GetDamageAmt = function(self) return math.floor( Buffs['HGSA01Betrayer01'].DamageAmt ) end,
    GetDuration = function(self) return ( Buffs['HGSA01BetrayerSlow01'].Duration ) end,
    GetSlowBuff = function(self) return math.floor( Buffs['HGSA01BetrayerSlow01'].Affects.MoveMult.Mult * -100 ) end,

    # Casting effects
    OnStartAbility = function(self, unit, params)
        FxCastMarkBetrayer( self, unit )
    end,

    Buffs = {
        BuffBlueprint {
            Name = 'HGSA01Betrayer01',
            DisplayName = '<LOC ABILITY_HGSA01_0022>Mark of the Betrayer',
            Description = '<LOC ABILITY_HGSA01_0023>Will take damage and be slowed on next ability use.',
            BuffType = 'HGSA01BETRAYER',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = -1,
            DamageAmt = 400,
            DamageRadius = 8,
            Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',

            # Consistent debuff effects
            Effects = 'MarkBetrayer01',
            EffectsBone = -2,

            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.HGSA01 then
                    unit.AbilityData.HGSA01 = {}
                end
                unit.AbilityData.HGSA01.BetrayerInst = instigator
                unit.AbilityData.HGSA01.BetrayerInstArmy = instigator:GetArmy()
                unit.AbilityData.HGSA01.BetrayerInstBp = instigator:GetBlueprint()
                unit.Callbacks.OnFinishCasting:Add(self.Betrayer, self)

                # Play effects on target
                FxMarkBetrayer( unit )
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnFinishCasting:Remove(self.Betrayer)
            end,
            Betrayer = function(self, ability, unit)
                local instigator = unit.AbilityData.HGSA01.BetrayerInst
                local instBp = unit.AbilityData.HGSA01.BetrayerInstBp
                local instArmy = unit.AbilityData.HGSA01.BetrayerInstArmy
                ForkThread( function()
                        local pos = table.copy(unit:GetPosition())
                        pos[2] = 100
                        local areadata = {
                            Instigator = instigator,
                            InstigatorBp = instBp,
                            InstigatorArmy = instArmy,
                            Amount = self.DamageAmt,
                            Type = 'Spell',
                            DamageAction = self.Name,
                            Radius = self.DamageRadius,
                            DamageSelf = false,
                            Origin = pos,
                            CanDamageReturn = false,
                            CanCrit = false,
                            CanBackfire = false,
                            CanBeEvaded = false,
                            CanMagicResist = true,
                            ArmorImmune = true,
                            NoFloatText = false,
                            Group = "UNITS",
                        }
                        DamageArea(areadata)
                        Buff.ApplyBuff(unit, 'HGSA01BetrayerSlow01', instigator, instArmy)
                        unit.AbilityData.HGSA01.BetrayerInst = nil
                        unit.AbilityData.HGSA01.BetrayerInstArmy = nil
                        Buff.RemoveBuff(unit, 'HGSA01Betrayer01')

                        # Play effects on unit afflicted by Mark of the Betrayer
                        FxTriggerMarkBetrayer( unit )
                    end
                )
            end,
        },
    },
    Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',
}

BuffBlueprint {
    Name = 'HGSA01BetrayerSlow01',
    DisplayName = '<LOC ABILITY_HGSA01_0076>Mark of the Betrayer',
    Description = '<LOC ABILITY_HGSA01_0024>Movement Speed reduced.',
    BuffType = 'HGSA01BETRAYEDSLOW',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Affects = {
        MoveMult = {Mult = -.2},
    },
    Effects = 'Slow03',
    EffectsBone = -2,
    Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',
}

#################################################################################################################
# Mark of the Betrayer II
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Betrayer02',
    DisplayName = '<LOC ABILITY_HGSA01_0025>Mark of the Betrayer II',
    Description = '<LOC ABILITY_HGSA01_0021>Regulus fires at a Demigod, marking them with a rune. When they perform an ability, they and their nearby allies take [GetDamageAmt] damage. Also, the Demigod\'s Movement Speed is reduced by [GetSlowBuff]% for [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'HERO - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 775,
    RangeMax = 20,
    Cooldown = 20,
    DamageType = 'Spell',
    CastingTime = 0.1,
    FollowThroughTime = 0.9,
    CastAction = 'Mark',
    UISlot = 3,
    HotKey = '3',
    LockWeapons = true,
    GetDamageAmt = function(self) return math.floor( Buffs['HGSA01Betrayer02'].DamageAmt ) end,
    GetDuration = function(self) return ( Buffs['HGSA01BetrayerSlow02'].Duration ) end,
    GetSlowBuff = function(self) return math.floor( Buffs['HGSA01BetrayerSlow02'].Affects.MoveMult.Mult * -100 ) end,

    # Casting effects
    OnStartAbility = function(self, unit, params)
        FxCastMarkBetrayer( self, unit )
    end,

    Buffs = {
        BuffBlueprint {
            Name = 'HGSA01Betrayer02',
            DisplayName = '<LOC ABILITY_HGSA01_0058>Mark of the Betrayer',
            Description = '<LOC ABILITY_HGSA01_0023>Will take damage and be slowed on next ability use.',
            BuffType = 'HGSA01BETRAYER',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = -1,
            DamageAmt = 600,
            DamageRadius = 10,
            Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',

            # Consistent debuff effects
            Effects = 'MarkBetrayer01',
            EffectsBone = -2,

            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.HGSA01 then
                    unit.AbilityData.HGSA01 = {}
                end
                unit.AbilityData.HGSA01.BetrayerInst = instigator
                unit.AbilityData.HGSA01.BetrayerInstArmy = instigator:GetArmy()
                unit.AbilityData.HGSA01.BetrayerInstBp = instigator:GetBlueprint()
                unit.Callbacks.OnFinishCasting:Add(self.Betrayer, self)

                # Play effects on target
                FxMarkBetrayer( unit )
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnFinishCasting:Remove(self.Betrayer)
            end,
            Betrayer = function(self, ability, unit)
                local instigator = unit.AbilityData.HGSA01.BetrayerInst
                local instBp = unit.AbilityData.HGSA01.BetrayerInstBp
                local instArmy = unit.AbilityData.HGSA01.BetrayerInstArmy
                ForkThread( function()
                        local pos = table.copy(unit:GetPosition())
                        pos[2] = 100
                        local areadata = {
                            Instigator = instigator,
                            InstigatorBp = instBp,
                            InstigatorArmy = instArmy,
                            Amount = self.DamageAmt,
                            Type = 'Spell',
                            DamageAction = self.Name,
                            Radius = self.DamageRadius,
                            DamageSelf = false,
                            Origin = pos,
                            CanDamageReturn = false,
                            CanCrit = false,
                            CanBackfire = false,
                            CanBeEvaded = false,
                            CanMagicResist = true,
                            ArmorImmune = true,
                            NoFloatText = false,
                            Group = "UNITS",
                        }
                        DamageArea(areadata)
                        Buff.ApplyBuff(unit, 'HGSA01BetrayerSlow02', instigator, unit.AbilityData.HGSA01.BetrayerInstArmy)
                        unit.AbilityData.HGSA01.BetrayerInst = nil
                        unit.AbilityData.HGSA01.BetrayerInstArmy = nil
                        Buff.RemoveBuff(unit, 'HGSA01Betrayer02')

                        # Play effects on unit afflicted by Mark of the Betrayer
                        FxTriggerMarkBetrayer( unit )
                    end
                )
            end,
        },
    },
    Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',
}

BuffBlueprint {
    Name = 'HGSA01BetrayerSlow02',
    DisplayName = '<LOC ABILITY_HGSA01_0060>Mark of the Betrayer',
    Description = '<LOC ABILITY_HGSA01_0061>Movement Speed reduced.',
    BuffType = 'HGSA01BETRAYEDSLOW',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Affects = {
        MoveMult = {Mult = -0.4},
    },
    Effects = 'Slow03',
    EffectsBone = -2,
    Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',
}

#################################################################################################################
# Mark of the Betrayer III
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Betrayer03',
    DisplayName = '<LOC ABILITY_HGSA01_0080>Mark of the Betrayer III',
    Description = '<LOC ABILITY_HGSA01_0021>Regulus fires at a Demigod, marking them with a rune. When they perform an ability, they and their nearby allies take [GetDamageAmt] damage. Also, the Demigod\'s Movement Speed is reduced by [GetSlowBuff]% for [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'HERO - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 950,
    RangeMax = 20,
    Cooldown = 20,
    DamageType = 'Spell',
    CastingTime = 0.1,
    FollowThroughTime = 0.9,
    CastAction = 'Mark',
    UISlot = 3,
    HotKey = '3',
    LockWeapons = true,
    GetDamageAmt = function(self) return math.floor( Buffs['HGSA01Betrayer03'].DamageAmt ) end,
    GetDuration = function(self) return ( Buffs['HGSA01BetrayerSlow03'].Duration ) end,
    GetSlowBuff = function(self) return math.floor( Buffs['HGSA01BetrayerSlow03'].Affects.MoveMult.Mult * -100 ) end,

    # Casting effects
    OnStartAbility = function(self, unit, params)
        FxCastMarkBetrayer( self, unit )
    end,

    Buffs = {
        BuffBlueprint {
            Name = 'HGSA01Betrayer03',
            DisplayName = '<LOC ABILITY_HGSA01_0058>Mark of the Betrayer',
            Description = '<LOC ABILITY_HGSA01_0023>Will take damage and be slowed on next ability use.',
            BuffType = 'HGSA01BETRAYER',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = -1,
            DamageAmt = 800,
            DamageRadius = 12,
            Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',

            # Consistent debuff effects
            Effects = 'MarkBetrayer01',
            EffectsBone = -2,

            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.HGSA01 then
                    unit.AbilityData.HGSA01 = {}
                end
                unit.AbilityData.HGSA01.BetrayerInst = instigator
                unit.AbilityData.HGSA01.BetrayerInstArmy = instigator:GetArmy()
                unit.AbilityData.HGSA01.BetrayerInstBp = instigator:GetBlueprint()
                unit.Callbacks.OnFinishCasting:Add(self.Betrayer, self)

                # Play effects on target
                FxMarkBetrayer( unit )
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnFinishCasting:Remove(self.Betrayer)
            end,
            Betrayer = function(self, ability, unit)
                local instigator = unit.AbilityData.HGSA01.BetrayerInst
                local instBp = unit.AbilityData.HGSA01.BetrayerInstBp
                local instArmy = unit.AbilityData.HGSA01.BetrayerInstArmy
                ForkThread( function()
                        local pos = table.copy(unit:GetPosition())
                        pos[2] = 100
                        local areadata = {
                            Instigator = instigator,
                            InstigatorBp = instBp,
                            InstigatorArmy = instArmy,
                            Amount = self.DamageAmt,
                            Type = 'Spell',
                            DamageAction = self.Name,
                            Radius = self.DamageRadius,
                            DamageSelf = false,
                            Origin = pos,
                            CanDamageReturn = false,
                            CanCrit = false,
                            CanBackfire = false,
                            CanBeEvaded = false,
                            CanMagicResist = true,
                            ArmorImmune = true,
                            NoFloatText = false,
                            Group = "UNITS",
                        }
                        DamageArea(areadata)
                        Buff.ApplyBuff(unit, 'HGSA01BetrayerSlow03', instigator, unit.AbilityData.HGSA01.BetrayerInstArmy)
                        unit.AbilityData.HGSA01.BetrayerInst = nil
                        unit.AbilityData.HGSA01.BetrayerInstArmy = nil
                        Buff.RemoveBuff(unit, 'HGSA01Betrayer03')

                        # Play effects on unit afflicted by Mark of the Betrayer
                        FxTriggerMarkBetrayer( unit )
                    end
                )
            end,
        },
    },
    Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',
}

BuffBlueprint {
    Name = 'HGSA01BetrayerSlow03',
    DisplayName = '<LOC ABILITY_HGSA01_0060>Mark of the Betrayer',
    Description = '<LOC ABILITY_HGSA01_0061>Movement Speed reduced.',
    BuffType = 'HGSA01BETRAYEDSLOW',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Affects = {
        MoveMult = {Mult = -0.6},
    },
    Effects = 'Slow03',
    EffectsBone = -2,
    Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',
}
#################################################################################################################
# VFX: Mine throwing projectile from Regulus to impact location
#################################################################################################################
function FxThrowMine(unit, endPos)
    # Get vector to mine land position, offset correctly to account for launch/hand position
    local height = 2
    local startPos = table.copy(unit:GetPosition())

    if unit.Character.CharBP.Name != 'Sniper' then
        height = 4
        # Cast arc effects
        AttachEffectAtBone( unit, 'Regulus', 'MineThrow02', -2 )
    else
        # Cast arc effects
        AttachEffectAtBone( unit, 'Regulus', 'MineThrow01', -2 )
    end

    startPos[2] = startPos[2] + height

    local direction = VNormal(endPos - startPos)
    endPos = Vector(endPos[1] - direction[1], endPos[2], endPos[3] - direction[3])
    direction = VNormal(endPos - startPos)

    # Create mine projectile
    local proj = unit:CreateProjectile('/projectiles/Mine01/Mine01_proj.bp', direction[1] * 1.5, height, direction[3] * 1.5, direction[1], direction[2], direction[3])
end

#################################################################################################################
# CE
# Create Mines
#################################################################################################################

function CreateSingleMine ( self, unit, pos, delay )
    # Create mine projectile to target location
    local endPos = Vector(pos[1],pos[2],pos[3])
    FxThrowMine(unit, endPos)

    # Wait for mine projectile to be approximately at target position
    WaitSeconds(delay)

    # Create mine object at target
    local x = pos[1]
    local z = pos[3]
    if GetTerrainType(pos[1], pos[3]).Name != 'Void' then
        local mine = CreateUnitHPR( 'HGSA01Mine01', unit:GetArmy(), x, GetSurfaceHeight(x, z), z, 0, 0, 0)
        mine:GetWeapon(1):SetDamageBonus(self.DamageAmt)
        CountMines(self, mine)
    end
end

function CreateMines ( self, unit, points, delay, mineType)
    # Create mine projectile to target location
    for k, v in points do
        #if GetTerrainType(v[1], v[3]).Name != 'Void' then
            FxThrowMine(unit, v)
        #end
    end

    # Wait for mine projectiles to be approximately at target position
    WaitSeconds(delay)

     # Create mine object at target
    for k, v in points do
        if GetTerrainType(v[1], v[3]).Name != 'Void' then
            local mine = CreateUnitHPR( mineType, unit:GetArmy(), v[1], GetSurfaceHeight(v[1], v[2]), v[3], 0, 0, 0)
            mine:GetWeapon(1):SetDamageBonus(self.DamageAmt)
            CountMines(self, mine)
        end
    end
end

#################################################################################################################
# CE
# Count Mines
#################################################################################################################
function CountMines(abil, mine)
    #Check the mine tracking tables and make sure they're setup properly.
    local aiBrain = mine:GetAIBrain()
    local at = aiBrain.AbilityData
    if not at.Regulus then
        at.Regulus = {}
    end
    local atr = at.Regulus
    if not atr.Mines then
        atr.Mines = {}
    end

    atr.Counter = (atr.Counter or 0) + 1
    atr.Mines[atr.Counter] = mine
    #Clean out dead mines
    for k, mn in atr.Mines do
        if mn:IsDead() then
            atr.Mines[k] = nil
        end
    end

    #If we're at the max destroy the first mine
    if table.getsize(atr.Mines) > abil.MineMax then
        local key = table.keys(atr.Mines)[1]
        atr.Mines[key]:KillSelf()
        atr.Mines[key] = nil
    end
    #LOG("*DEBUG: Mine Table: ", repr(atr.Mines))
end

#################################################################################################################
# Explosive Mine I
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01ExplosiveMine01',
    DisplayName = '<LOC ABILITY_HGSA01_0027>Explosive Mine I',
    Description = '<LOC ABILITY_HGSA01_0028>Regulus sets an explosive proximity mine that deals [GetDamage] damage when it explodes.\n\nUp to [GetMineMax] mines may be active at a time.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Any',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    Cooldown = 10,
    EnergyCost = 440,
    Icon = '/DGRegulus/NewRegulusExplosiveMine01',
    AffectRadius = 3,
    RangeMax = 15,
    RangeMin = 1,
    MineMax = 6,
    UISlot = 4,
    HotKey = '4',
    CastingTime = 1,
    DamageAmt = 300,
    DamageType = 'Spell',
    CastAction = 'Mine',
    ErrorMessage = '<LOC error_0033>Cannot place that here.',
    ErrorVO = 'Noplace',
    GetDamage = function(self) return math.floor( self.DamageAmt ) end,
    GetMineMax = function(self) return math.floor( self.MineMax ) end,
    OnStartAbility = function(self, unit, params)
        # Get distance from Regulus to target position, use that as a delay between mine projectile spawn and landing
        local dir = VDiff(params.Target.Position,unit:GetPosition())
        local dist = VLength( dir )

        # Create mine projectiles, delay and then actual mine.
        ForkThread(CreateSingleMine, self, unit, params.Target.Position, dist * 0.028)
    end,
    Reticule = 'AoE_Mine',
}

#################################################################################################################
# Explosive Mine II
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01ExplosiveMine02',
    DisplayName = '<LOC ABILITY_HGSA01_0029>Explosive Mine II',
    Description = '<LOC ABILITY_HGSA01_0083>Regulus sets two explosive proximity mines that deals [GetDamage] damage when it explodes.\n\nUp to [GetMineMax] mines may be active at a time.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Any',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    Cooldown = 10,
    EnergyCost = 550,
    Icon = '/DGRegulus/NewRegulusExplosiveMine01',
    AffectRadius = 4.5,
    RangeMax = 15,
    RangeMin = 1,
    MineMax = 6,
    ArcRadius = 5.2,
    ArcSize = .18,
    ArcOffset = 0.84,
    NumMines = 2,
    UISlot = 4,
    HotKey = '4',
    CastingTime = 1,
    DamageAmt = 350,
    DamageType = 'Spell',
    CastAction = 'Mine',
    ErrorMessage = '<LOC error_0034>Cannot place that here.',
    ErrorVO = 'Noplace',
    GetDamage = function(self) return math.floor( self.DamageAmt ) end,
    GetMineMax = function(self) return math.floor( self.MineMax ) end,
    OnStartAbility = function(self, unit, params)
        local heading = unit:GetHeading()
        local actualpoint = Utils.GetPointsAroundArc(params.Target.Position, 5, 1, 0, heading, 0)
        local positionoffset = VDiff(actualpoint[1], params.Target.Position)
        local newposition = VDiff(params.Target.Position, positionoffset)
        local points = Utils.GetPointsAroundArc(newposition, self.ArcRadius, self.NumMines, self.ArcSize, heading, self.ArcOffset)

        # Get distance from Regulus to target position, use that as a delay between mine projectile spawn and landing
        local dir = VDiff(params.Target.Position,unit:GetPosition())
        local dist = VLength( dir )

        # Create mine projectiles, delay and then actual mine.
        ForkThread(CreateMines, self, unit, points, dist * 0.028, 'HGSA01Mine02')
    end,
    Reticule = 'AoE_Mine',
}

#################################################################################################################
# Explosive Mine III
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01ExplosiveMine03',
    DisplayName = '<LOC ABILITY_HGSA01_0031>Explosive Mine III',
    Description = '<LOC ABILITY_HGSA01_0084>Regulus sets three explosive proximity mines that deals [GetDamage] damage when it explodes.\n\nUp to [GetMineMax] mines may be active at a time.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Any',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    Cooldown = 10,
    EnergyCost = 660,
    Icon = '/DGRegulus/NewRegulusExplosiveMine01',
    AffectRadius = 6,
    RangeMax = 15,
    RangeMin = 1,
    MineMax = 6,
    ArcRadius = 5,
    ArcSize = .28,
    ArcOffset = 1.19,
    NumMines = 3,
    UISlot = 4,
    HotKey = '4',
    CastingTime = 1,
    DamageAmt = 400,
    DamageType = 'Spell',
    CastAction = 'Mine',
    ErrorMessage = '<LOC error_0035>Cannot place that here.',
    ErrorVO = 'Noplace',
    GetDamage = function(self) return math.floor( self.DamageAmt ) end,
    GetMineMax = function(self) return math.floor( self.MineMax ) end,
    OnStartAbility = function(self, unit, params)
        local heading = unit:GetHeading()
        local actualpoint = Utils.GetPointsAroundArc(params.Target.Position, 5, 1, 0, heading, 0)
        local positionoffset = VDiff(actualpoint[1], params.Target.Position)
        local newposition = VDiff(params.Target.Position, positionoffset)
        local points = Utils.GetPointsAroundArc(newposition, self.ArcRadius, self.NumMines, self.ArcSize, heading, self.ArcOffset)

        # Get distance from Regulus to target position, use that as a delay between mine projectile spawn and landing
        local dir = VDiff(params.Target.Position,unit:GetPosition())
        local dist = VLength( dir )

        # Create mine projectiles, delay and then actual mine.
        ForkThread(CreateMines, self, unit, points, dist * 0.028, 'HGSA01Mine03')
    end,
    Reticule = 'AoE_Mine',
}

#################################################################################################################
# Shrapnel Mine
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01ShrapnelMine01',
    DisplayName = '<LOC ABILITY_HGSA01_0033>Shrapnel Mine',
    Description = '<LOC ABILITY_HGSA01_0034>Regulus sets three explosive proximity mines that deal [GetDamage] damage each and slow enemies by 30% when they explode.\n\nUp to [GetMineMax] mines may be active at a time.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Any',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    Cooldown = 10,
    EnergyCost = 770,
    Icon = '/DGRegulus/NewRegulusShrapnel01',
    AffectRadius = 6,
    RangeMax = 15,
    RangeMin = 1,
    MineMax = 6,
    ArcRadius = 5,
    ArcSize = .28,
    ArcOffset = 1.19,
    NumMines = 3,
    UISlot = 4,
    HotKey = '4',
    CastingTime = 1,
    DamageAmt = 450,
    DamageType = 'Spell',
    CastAction = 'Mine',
    ErrorMessage = '<LOC error_0036>Cannot place that here.',
    ErrorVO = 'Noplace',
    GetDamage = function(self) return math.floor( self.DamageAmt ) end,
    GetMineMax = function(self) return math.floor( self.MineMax ) end,
    OnStartAbility = function(self, unit, params)
        local heading = unit:GetHeading()
        local actualpoint = Utils.GetPointsAroundArc(params.Target.Position, 5, 1, 0, heading, 0)
        local positionoffset = VDiff(actualpoint[1], params.Target.Position)
        local newposition = VDiff(params.Target.Position, positionoffset)
        local points = Utils.GetPointsAroundArc(newposition, self.ArcRadius, self.NumMines, self.ArcSize, heading, self.ArcOffset)

        # Get distance from Regulus to target position, use that as a delay between mine projectile spawn and landing
        local dir = VDiff(params.Target.Position,unit:GetPosition())
        local dist = VLength( dir )

        # Create mine projectiles, delay and then actual mine.
        ForkThread(CreateMines, self, unit, points, dist * 0.028, 'HGSA01Mine04')
    end,
    Reticule = 'AoE_Mine',
}

BuffBlueprint {
    Name = 'HGSA01MineSlow01',
    DisplayName = '<LOC ABILITY_HGSA01_0068>Shrapnel Mine',
    Description = '<LOC ABILITY_HGSA01_0069>Movement Speed reduced.',
    BuffType = 'HGSA01MINESLOW',
    Stacks = 'REPLACE',
    Duration = 5,
    Debuff = true,
    CanBeDispelled = true,
    Affects = {
        MoveMult = {Mult = -0.3},
    },
    Icon = '/DGRegulus/NewRegulusShrapnel01',
}

#################################################################################################################
# Tracking Device
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Track',
    DisplayName = '<LOC ABILITY_HGSA01_0035>Tracking Device',
    Description = '<LOC ABILITY_HGSA01_000>Regulus\' bolts are rigged with tracking devices that allow him and his allies to see the enemies he struck for [GetDuration] seconds. Snipe will also implant a tracking device.',
    AbilityType = 'Quiet',
    GetDuration = function(self) return math.floor( Buffs['HGSA01Tracked'].Duration ) end,
    TrackTargets = function(self, unit)
        local target = unit:GetWeapon(1):GetTarget():GetRealTargetEntity()
        if target and not target:IsDead() then
            Buff.ApplyBuff(target, 'HGSA01Tracked', unit)
        end
    end,
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnWeaponFire:Add(self.TrackTargets, self)
    end,
    OnAbilityRemoved = function(self, unit)
        unit.Callbacks.OnWeaponFire:Remove(self.TrackTargets)
    end,
}

BuffBlueprint {
    Name = 'HGSA01Tracked',
    DisplayName = '<LOC ABILITY_HGSA01_0035>Tracking Device',
    Description = '<LOC ABILITY_HGSA01_0036>Your position is being tracked by Regulus.',
    BuffType = 'HGSA01TRACKING',
    Icon = '/DGRegulus/NewRegulustracking01',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 20,
    TrackVizRadius = 5,
    Affects = {},
    OnBuffAffect = function(self, unit, instigator)
        if(instigator and not instigator:IsDead()) then
            if(unit and not unit:IsDead() and EntityCategoryContains(categories.HERO, unit) and not unit.AbilityData.TrackingVizMarker) then
                local pos = unit:GetPosition()
                local viz = import('/lua/sim/VizMarker.lua').VizMarker {
                    X = pos[1],
                    Z = pos[3],
                    LifeTime = self.Duration,
                    Radius = self.TrackVizRadius,
                    Army = instigator:GetArmy(),
                    Omni = false,
                    Vision = true,
                }
                viz:AttachTo(unit, 0)
                unit.Trash:Add(viz)
                unit.AbilityData.TrackingVizMarker = viz

                local buffClass = unit:GetEffectBuffClassification()

                # Create effects on target that only Regulus can see
                AttachEffectsAtBone( unit, EffectTemplates.Buff.Tracked01[buffClass], -2, nil, nil, unit.Buffs.BuffTable[self.BuffType][self.Name].Trash, nil, instigator:GetArmy() )

                # Create effects on target that only the target can see
                AttachEffectsAtBone( unit, EffectTemplates.Buff.Tracked01[buffClass], -2, nil, nil, unit.Buffs.BuffTable[self.BuffType][self.Name].Trash )
            end
        end
    end,
    OnBuffRemove = function(self, unit)
        if unit.AbilityData.TrackingVizMarker then
            unit.AbilityData.TrackingVizMarker:Destroy()
            unit.AbilityData.TrackingVizMarker = nil
        end
    end,
}

BuffBlueprint {
    Name = 'HGSA01TrackedCooldown',
    DisplayName = '<LOC ABILITY_HGSA01_0062>Can\'t be tracked.',
    BuffType = 'HGSA01TRACKING',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {},
    OnBuffRemove = function(self, unit)
        unit.AbilityData.TrackingVizMarker = nil
    end,
}

#################################################################################################################
# Buffs - Angelic Fury Ability Toggle
#################################################################################################################
BuffBlueprint {
    Name = 'HGSA01AngelicFuryOnDisable',
    DisplayName = 'Angelic Fury On Abilities Disabled',
    BuffType = 'HGSA01ANGELICFURYONDISABLE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    AbilityCategory = 'HGSA01ANGELICFURYON',
    Affects = {
        AbilityEnable = {Bool = true,},
    },
}

#################################################################################################################
# Buffs - Angelic Fury Ability Toggle
#################################################################################################################
BuffBlueprint {
    Name = 'HGSA01AngelicFuryOffDisable',
    DisplayName = 'Angelic Fury Off Abilities Disabled',
    BuffType = 'HGSA01ANGELICFURYOFFDISABLE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    AbilityCategory = 'HGSA01ANGELICFURYOFF',
    Affects = {
        AbilityEnable = {Bool = true,},
    },
}

#################################################################################################################
# CE: Angelic Fury Added
# This is called not only when the ability is entered, but also when Angelic Fury is upgraded
#################################################################################################################
function AngelicFuryFunctionalityEntrance(unit)
    Abil.HideAbility(unit, 'HGSA01AngelicFuryOn')
    Abil.ShowAbility(unit, 'HGSA01AngelicFuryOff')
    Buff.ApplyBuff(unit, 'HGSA01AngelicFuryOnDisable', unit)
    if Buff.HasBuff(unit, 'HGSA01AngelicFuryOffDisable') then
        Buff.RemoveBuff(unit, 'HGSA01AngelicFuryOffDisable')
    end
    unit.AbilityData.AngelicFuryOn = true
    if Validate.HasAbility(unit,'HGSA01AngelicFury01') then
        Abil.SetAbilityState(unit, 'HGSA01AngelicFury01', false)
        Buff.ApplyBuff(unit, 'HGSA01AngelicFuryBuff01', unit)
    elseif Validate.HasAbility(unit,'HGSA01AngelicFury02') then
        Abil.SetAbilityState(unit, 'HGSA01AngelicFury02', false)
        Buff.ApplyBuff(unit, 'HGSA01AngelicFuryBuff02', unit)
    elseif Validate.HasAbility(unit,'HGSA01AngelicFury03') then
        Abil.SetAbilityState(unit, 'HGSA01AngelicFury03', false)
        Buff.ApplyBuff(unit, 'HGSA01AngelicFuryBuff03', unit)
    elseif Validate.HasAbility(unit,'HGSA01AngelicFury04') then
        Abil.SetAbilityState(unit, 'HGSA01AngelicFury04', false)
        Buff.ApplyBuff(unit, 'HGSA01AngelicFuryBuff04', unit)
    end
end

#################################################################################################################
# CE: Angelic Fury Exited
# This is called not only when the ability is entered, but also when Angelic Fury is upgraded
#################################################################################################################
function AngelicFuryFunctionalityEnd(unit)
    Abil.HideAbility(unit, 'HGSA01AngelicFuryOff')
    Abil.ShowAbility(unit, 'HGSA01AngelicFuryOn')
    Buff.ApplyBuff(unit, 'HGSA01AngelicFuryOffDisable', unit)
    if Buff.HasBuff(unit, 'HGSA01AngelicFuryOnDisable') then
        Buff.RemoveBuff(unit, 'HGSA01AngelicFuryOnDisable')
    end
    unit.AbilityData.AngelicFuryOn = false
    if Validate.HasAbility(unit,'HGSA01AngelicFury01') then
        if Buff.HasBuff(unit, 'HGSA01AngelicFuryBuff01') then
            Buff.RemoveBuff(unit, 'HGSA01AngelicFuryBuff01')
        end
    elseif Validate.HasAbility(unit,'HGSA01AngelicFury02') then
        if Buff.HasBuff(unit, 'HGSA01AngelicFuryBuff02') then
            Buff.RemoveBuff(unit, 'HGSA01AngelicFuryBuff02')
        end
    elseif Validate.HasAbility(unit,'HGSA01AngelicFury03') then
        if Buff.HasBuff(unit, 'HGSA01AngelicFuryBuff03') then
            Buff.RemoveBuff(unit, 'HGSA01AngelicFuryBuff03')
        end
    elseif Validate.HasAbility(unit,'HGSA01AngelicFury04') then
        if Buff.HasBuff(unit, 'HGSA01AngelicFuryBuff04') then
            Buff.RemoveBuff(unit, 'HGSA01AngelicFuryBuff04')
        end
    end
end

#################################################################################################################
# Angelic Fury On/Vengeance Damage Information
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01AngelicFuryOn',
    DisplayName = '<LOC ABILITY_HGSA01_0037>Angelic Fury',
    Description = '<LOC ABILITY_HGSA01_0038>Regulus enters a divine rage. His bolts deal increased damage and explode on contact. Each shot costs Mana.',
    AbilityType = 'Instant',
    Cooldown = 5,
    SharedCooldown = 'HGSA01AngelicFurySwitch',
    EnergyCost = 0,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'AngelOn',
    FollowThroughTime = 1.5,
    AbilityCategory = 'HGSA01ANGELICFURYON',
    VengAffectRadius = 10,
    VengMetaImpactAmount = 6,
    VengDamageAmt = 500,
    VengDamageType = 'Spell',
    VengDamageName = 'HGSA01Vengeance01',
    Tooltip = {
        TargetAlliance = 'Enemy',
        EnergyCost = 0,
        Cooldown = 5,
    },
    OnStartAbility = function(self, unit, params)
        # Manages adding the proper buff and proc
        AngelicFuryFunctionalityEntrance(unit)
        # Determines if we should do the damaging mode change or the normal.
        if Validate.HasAbility(unit,'HGSA01Vengeance01') then
            local thd = ForkThread(VengeanceThread, self, unit, params)
            unit.Trash:Add(thd)
        else
            local thd = ForkThread(AngelicFuryEnter, self, unit, params)
            unit.Trash:Add(thd)
        end
    end,
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
}

#################################################################################################################
# Angelic Fury Off
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01AngelicFuryOff',
    DisplayName = '<LOC ABILITY_HGSA01_0039>Angelic Fury Off',
    Description = '<LOC ABILITY_HGSA01_0040>Regulus ceases his fury, losing his wings and extra power.',
    AbilityType = 'Instant',
    Cooldown = 3,
    SharedCooldown = 'HGSA01AngelicFurySwitch',
    EnergyCost = 0,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'AngelOff',
    NotSilenceable = true,
    FollowThroughTime = 1.0,
    AbilityCategory = 'HGSA01ANGELICFURYOFF',
    Tooltip = {
        EnergyCost = 0,
        Cooldown = 3,
    },
    OnStartAbility = function(self, unit, params)
        # Manages ending the buff
        AngelicFuryFunctionalityEnd(unit)
        local thd = ForkThread(AngelicFuryExit, self, unit, params)
        unit.Trash:Add(thd)
    end,
    Icon = '/DGRegulus/NewRegulusAngelicFuryOff01',
}

#################################################################################################################
# VFX: Angelic Fury
#################################################################################################################

function FxAngelicFuryImpact( unit, pos )
    CreateTemplatedEffectAtPos( 'Projectiles', nil, 'Bolt01ImpactFury', unit:GetArmy(), pos )
    AttachEffectAtBone( unit, 'Regulus', 'ManaLoss01', -2 )
end

#################################################################################################################
# Angelic Fury I
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01AngelicFury01',
    DisplayName = '<LOC ABILITY_HGSA01_0041>Angelic Fury I',
    Description = '<LOC ABILITY_HGSA01_0053>Regulus enters a divine rage. His bolts deal [GetDamage] extra damage and explode on contact. Costs [GetCostPerShot] Mana per shot.',
    GetDamage = function(self) return math.floor( Buffs['HGSA01AngelicFuryBuff01'].Affects.DamageRating.Add ) end,
    GetCostPerShot = function(self) return math.floor( self.EnergyPerShotCost ) end,
    AbilityType = 'WeaponProc',
    AbilityCategory = 'HGSA01ANGELICFURY',
    WeaponProcChance = 100,
    EnergyPerShotCost = 40,
    OnWeaponProc = function(self, unit, target, damageData)
        if unit.AbilityData.AngelicFuryOn then
            unit:SetEnergy(unit:GetEnergy() - self.EnergyPerShotCost)
            if unit.Sync.Energy < 32 then
                local params = { AbilityName = 'HGSA01AngelicFuryOff'}
                Abil.HandleAbility(unit, params)
            end
            # Play altered impact effects on top of normal effects and loss of Energy effects on Regulus.
            FxAngelicFuryImpact(unit, damageData.Origin)
        end
    end,
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
    OnAbilityAdded = function(self,unit)
        Abil.AddAbility(unit,'HGSA01AngelicFuryOff', true)
        Abil.AddAbility(unit,'HGSA01AngelicFuryOn', true)
        Abil.HideAbility(unit, 'HGSA01AngelicFuryOff')
        if unit.AbilityData[self.Name].ActiveEffectDestroyables then
            unit.AbilityData[self.Name].ActiveEffectDestroyables:Destroy()
        end
        if not unit.AbilityData.AngelicFuryOn then
            Abil.SetAbilityState(unit, 'HGSA01AngelicFury01', true)
        else
            AngelicFuryFunctionalityEnd(unit)
            AngelicFuryFunctionalityEntrance(unit)
        end
    end,
}

#################################################################################################################
# Buff: Angelic Fury I
#################################################################################################################
BuffBlueprint {
    Name = 'HGSA01AngelicFuryBuff01',
    DisplayName = '<LOC ABILITY_HGSA01_0078>Angelic Fury I',
    Description = '<LOC ABILITY_HGSA01_0042>Damage increased. Each shot drains Mana.',
    BuffType = 'HGSA01ANGELICFURYBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        DamageRadius = {Add = 2},
        DamageSplash = {Mult = -0.30},
        DamageRating = {Add = 25},
    },
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
}

#################################################################################################################
# Angelic Fury II
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01AngelicFury02',
    DisplayName = '<LOC ABILITY_HGSA01_0043>Angelic Fury II',
    Description = '<LOC ABILITY_HGSA01_0053>Regulus enters a divine rage. His bolts deal [GetDamage] extra damage and explode on contact. Costs [GetCostPerShot] Mana per shot.',
    GetDamage = function(self) return math.floor( Buffs['HGSA01AngelicFuryBuff02'].Affects.DamageRating.Add ) end,
    GetCostPerShot = function(self) return math.floor( self.EnergyPerShotCost ) end,
    AbilityType = 'WeaponProc',
    AbilityCategory = 'HGSA01ANGELICFURY',
    WeaponProcChance = 100,
    EnergyPerShotCost = 40,
    OnWeaponProc = function(self, unit, target, damageData)
        if unit.AbilityData.AngelicFuryOn then
            unit:SetEnergy(unit:GetEnergy() - self.EnergyPerShotCost)
            if unit.Sync.Energy < 32 then
                local params = { AbilityName = 'HGSA01AngelicFuryOff'}
                Abil.HandleAbility(unit, params)
            end
            # Play altered impact effects on top of normal effects
            FxAngelicFuryImpact(unit, damageData.Origin)
        end
    end,
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
    OnAbilityAdded = function(self,unit)
        if unit.AbilityData[self.Name].ActiveEffectDestroyables then
            unit.AbilityData[self.Name].ActiveEffectDestroyables:Destroy()
        end
        if not unit.AbilityData.AngelicFuryOn then
            Abil.SetAbilityState(unit, 'HGSA01AngelicFury02', true)
        else
            AngelicFuryFunctionalityEnd(unit)
            AngelicFuryFunctionalityEntrance(unit)
        end
    end,
}

#################################################################################################################
# Buff: Angelic Fury II
#################################################################################################################
BuffBlueprint {
    Name = 'HGSA01AngelicFuryBuff02',
    DisplayName = '<LOC ABILITY_HGSA01_0063>Angelic Fury II',
    Description = '<LOC ABILITY_HGSA01_0042>Damage increased. Each shot drains Mana.',
    BuffType = 'HGSA01ANGELICFURYBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        DamageRadius = {Add = 2.0},
        DamageSplash = {Mult = -0.30},
        DamageRating = {Add = 50},
    },
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
}

#################################################################################################################
# Angelic Fury III
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01AngelicFury03',
    DisplayName = '<LOC ABILITY_HGSA01_0044>Angelic Fury III',
    Description = '<LOC ABILITY_HGSA01_0053>Regulus enters a divine rage. His bolts deal [GetDamage] extra damage and explode on contact. Costs [GetCostPerShot] Mana per shot.',
    GetDamage = function(self) return math.floor( Buffs['HGSA01AngelicFuryBuff03'].Affects.DamageRating.Add ) end,
    GetCostPerShot = function(self) return math.floor( self.EnergyPerShotCost ) end,
    AbilityType = 'WeaponProc',
    AbilityCategory = 'HGSA01ANGELICFURY',
    WeaponProcChance = 100,
    EnergyPerShotCost = 40,
    OnWeaponProc = function(self, unit, target, damageData)
        if unit.AbilityData.AngelicFuryOn then
            unit:SetEnergy(unit:GetEnergy() - self.EnergyPerShotCost)
            if unit.Sync.Energy < 32 then
                local params = { AbilityName = 'HGSA01AngelicFuryOff'}
                Abil.HandleAbility(unit, params)
            end

            # Play altered impact effects on top of normal effects
            FxAngelicFuryImpact(unit, damageData.Origin)
        end
    end,
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
    OnAbilityAdded = function(self,unit)
        if unit.AbilityData[self.Name].ActiveEffectDestroyables then
            unit.AbilityData[self.Name].ActiveEffectDestroyables:Destroy()
        end
        if not unit.AbilityData.AngelicFuryOn then
            Abil.SetAbilityState(unit, 'HGSA01AngelicFury03', true)
        else
            AngelicFuryFunctionalityEnd(unit)
            AngelicFuryFunctionalityEntrance(unit)
        end
    end,
}


#################################################################################################################
# Buff: Angelic Fury III
#################################################################################################################
BuffBlueprint {
    Name = 'HGSA01AngelicFuryBuff03',
    DisplayName = '<LOC ABILITY_HGSA01_0064>Angelic Fury III',
    Description = '<LOC ABILITY_HGSA01_0042>Damage increased. Each shot drains Mana.',
    BuffType = 'HGSA01ANGELICFURYBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        DamageRadius = {Add = 2.0},
        DamageSplash = {Mult = -0.30},
        DamageRating = {Add = 75},
    },
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
}

#################################################################################################################
# Angelic Fury IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01AngelicFury04',
    DisplayName = '<LOC ABILITY_HGSA01_0082>Angelic Fury IV',
    Description = '<LOC ABILITY_HGSA01_0053>Regulus enters a divine rage. His bolts deal [GetDamage] extra damage and explode on contact. Costs [GetCostPerShot] Mana per shot.',
    GetDamage = function(self) return math.floor( Buffs['HGSA01AngelicFuryBuff04'].Affects.DamageRating.Add ) end,
    GetCostPerShot = function(self) return math.floor( self.EnergyPerShotCost ) end,
    AbilityType = 'WeaponProc',
    AbilityCategory = 'HGSA01ANGELICFURY',
    WeaponProcChance = 100,
    EnergyPerShotCost = 40,
    OnWeaponProc = function(self, unit, target, damageData)
        if unit.AbilityData.AngelicFuryOn then
            unit:SetEnergy(unit:GetEnergy() - self.EnergyPerShotCost)
            if unit.Sync.Energy < 32 then
                local params = { AbilityName = 'HGSA01AngelicFuryOff'}
                Abil.HandleAbility(unit, params)
            end

            # Play altered impact effects on top of normal effects
            FxAngelicFuryImpact(unit, damageData.Origin)
        end
    end,
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
    OnAbilityAdded = function(self,unit)
        if unit.AbilityData[self.Name].ActiveEffectDestroyables then
            unit.AbilityData[self.Name].ActiveEffectDestroyables:Destroy()
        end
        if not unit.AbilityData.AngelicFuryOn then
            Abil.SetAbilityState(unit, 'HGSA01AngelicFury04', true)
        else
            AngelicFuryFunctionalityEnd(unit)
            AngelicFuryFunctionalityEntrance(unit)
        end
    end,
}


#################################################################################################################
# Buff: Angelic Fury IV
#################################################################################################################
BuffBlueprint {
    Name = 'HGSA01AngelicFuryBuff04',
    DisplayName = '<LOC ABILITY_HGSA01_0082>Angelic Fury IV',
    Description = '<LOC ABILITY_HGSA01_0042>Damage increased. Each shot drains Mana.',
    BuffType = 'HGSA01ANGELICFURYBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        DamageRadius = {Add = 2.0},
        DamageSplash = {Mult = -0.30},
        DamageRating = {Add = 100},
    },
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
}
#################################################################################################################
# Vengeance I
#################################################################################################################
AbilityBlueprint {
    Name = 'HGSA01Vengeance01',
    DisplayName = '<LOC ABILITY_HGSA01_0057>Vengeance',
    Description = '<LOC ABILITY_HGSA01_0056>When Regulus uses Angelic Fury, he unleashes a nova of holy power around him, dealing [GetDamage] damage and sending nearby enemies flying.',
    AbilityType = 'Quiet',
    GetDamage = function(self) return math.floor( Ability['HGSA01AngelicFuryOn'].VengDamageAmt ) end,
}

#################################################################################################################
# Buff
# Vengeance
#################################################################################################################
BuffBlueprint {
    Name = 'HGSA01Vengeance01',
    Description = '<LOC ABILITY_HGSA01_0079>Invulnerable',
    Stacks = 'REPLACE',
    BuffType = 'HGSA01FURY',
    Debuff = false,
    Duration = -1,
    Affects = {
        FiringRandomness = { Add = 20 },
        WeaponsEnable = {Bool = false},
    },
}

#################################################################################################################
# VFX: Vengeance
#################################################################################################################
function FxVengeanceRunes01( unit, pos, segments, radius )
    local angle = (2*math.pi) / segments

    for i = 1, segments do
        local s = math.sin(i*angle)
        local c = math.cos(i*angle)
        local x = s * radius
        local z = c * radius
        local radiusMul = 0.75

        if GetTerrainType(pos[1]+x, pos[3]+z).Name == 'Void' then
            while radiusMul > 0.25 do
                x = s * (radius * radiusMul)
                z = c * (radius * radiusMul)
                if GetTerrainType(pos[1]+x, pos[3]+z).Name == 'Void' then
                    radiusMul = radiusMul - 0.25
                else
                    break
                end
            end
        end
        if radiusMul > 0.25 then
            local emitters = CreateTemplatedEffectAtPos( 'Regulus', nil, 'AngelicFuryRunes01', unit:GetArmy(), Vector(pos[1] + x,pos[2],pos[3]+z), Vector(x, 0, z) )
        end
    end
end

function FxVengeanceRunes02( unit, pos, segments )
    local angle = (2*math.pi) / segments
    for i = 1, segments do
        local s = math.sin(i*angle)
        local c = math.cos(i*angle)

        CreateCharacterEffectsAtPos( unit, 'sniper', 'AngelicFuryWarmup03', pos, Vector(s,0,c) )
    end
end

#################################################################################################################
# CE: Vengeance
#################################################################################################################
function VengeanceThread(def, unit, params)
    local army = unit:GetArmy()
    local pos = unit:GetPosition()
    pos[2] = 100

    Buff.ApplyBuff(unit, 'HGSA01Vengeance01', unit)
    Buff.ApplyBuff(unit, 'RangeAttackLock', unit)
    Buff.ApplyBuff(unit, 'Immobile', unit)

    if unit.Character.CharBP.Name != 'SniperFury' then
        unit.Character:SetCharacter('SniperFury', true)
    end

    # Destroy ambient blood dripping/feather effects
    unit:DestroyAmbientEffects()

    # Show wings and hide stubs
    unit:ShowBone("sk_Sniper_Rightwing1", true)
    unit:ShowBone("sk_Sniper_Leftwing1", true)
    unit:ShowBone("sk_Sniper_Wingsbase", true)
    unit:HideBone("sk_Sniper_Leftwingstub", true)
    unit:HideBone("sk_Sniper_Rightwingstub", true)
    unit:HideBone("sk_Sniper_Wingstubsbase", true)

    unit.Character:PlayAction('AngelOn')

    # Pre-Fury effects, ray of light downward/etc.
    AttachCharacterEffectsAtBone( unit, 'sniper', 'AngelicFuryWarmup01' )

    # Ring rune that holds it all together, feathers burst as wings grow
    CreateCharacterEffectsAtPos( unit, 'sniper', 'AngelicFuryWarmup02', pos )

    WaitSeconds(0.4)

    # Runes play at feet of Hero, sets of concentric rune rings
    FxVengeanceRunes01 ( unit, pos, 8, 2.75 )
    WaitSeconds(0.4)
    FxVengeanceRunes01 ( unit, pos, 15, 5 )
    WaitSeconds(0.2)

    #CreateCharacterEffectsAtPos( unit, 'sniper', 'AngelicFuryWarmup03', pos )
    FxVengeanceRunes02( unit, pos, 8 )
    #WaitSeconds(0.2)
    CreateTemplatedEffectAtPos( 'Regulus', nil, 'AngelicFuryWarmup04', unit:GetArmy(), pos, nil )

    WaitSeconds(0.3)
    AttachCharacterEffectsAtBone( unit, 'sniper', 'AngelicFuryBurst01' )

    WaitSeconds(0.2)


    if def.MetaImpactAmount then
        data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Origin = pos,
            Radius = def.VengAffectRadius,
            Amount = def.VengMetaImpactAmount,
            Category = 'METAINFANTRY',
        }
        MetaImpact(data)
    end
    data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = army,
        Origin = pos,
        Amount = def.VengDamageAmt,
        Type = def.VengDamageType,
        DamageAction = def.VengDamageName,
        Radius = def.VengAffectRadius,
        DamageFriendly = false,
        DamageSelf = false,
        Group = "UNITS",
        CanBeEvaded = false,
        CanCrit = false,
        CanBackfire = false,
        CanDamageReturn = false,
        CanMagicResist = true,
        CanOverKill = false,
        ArmorImmune = true,
    }
    DamageArea(data)

    # Create Fury impact effects
    CreateCharacterEffectsAtPos( unit, 'sniper', 'AngelicFuryImpact01', pos )

    # Wait for anim to finish
    WaitSeconds(1.2)

    # Create Angelic Fury ambient effects
    unit:CreateAmbientEffects()

    Buff.RemoveBuff(unit, 'RangeAttackLock')
    Buff.RemoveBuff(unit, 'HGSA01Vengeance01')
    Buff.RemoveBuff(unit, 'Immobile')

end

#################################################################################################################
# CE: Angelic Fury Enter, no Vengeance
#################################################################################################################
function AngelicFuryEnter(def, unit, params)
    local army = unit:GetArmy()
    local pos = unit:GetPosition()
    pos[2] = 100

        Buff.ApplyBuff(unit, 'HGSA01Vengeance01', unit)
    Buff.ApplyBuff(unit, 'RangeAttackLock', unit)
    Buff.ApplyBuff(unit, 'Immobile', unit)

    if unit.Character.CharBP.Name != 'SniperFury' then
        unit.Character:SetCharacter('SniperFury', true)
    end

    # Destroy ambient blood dripping/feather effects, Create Angelic Fury ambient effects
    unit:DestroyAmbientEffects()
    unit:CreateAmbientEffects()

    unit.Character:PlayAction('AngelOn')

    # Show wings and hide stubs
    unit:ShowBone("sk_Sniper_Rightwing1", true)
    unit:ShowBone("sk_Sniper_Leftwing1", true)
    unit:ShowBone("sk_Sniper_Wingsbase", true)
    unit:HideBone("sk_Sniper_Leftwingstub", true)
    unit:HideBone("sk_Sniper_Rightwingstub", true)
    unit:HideBone("sk_Sniper_Wingstubsbase", true)

    WaitSeconds(2.70)

    Buff.RemoveBuff(unit, 'RangeAttackLock')
    Buff.RemoveBuff(unit, 'HGSA01Vengeance01')
    Buff.RemoveBuff(unit, 'Immobile')

end

#################################################################################################################
# CE: Angelic Fury Exit
#################################################################################################################
function AngelicFuryExit(def, unit, params)
    local army = unit:GetArmy()
    local pos = unit:GetPosition()
    pos[2] = 100

    Buff.ApplyBuff(unit, 'HGSA01Vengeance01', unit)
    Buff.ApplyBuff(unit, 'RangeAttackLock', unit)
    Buff.ApplyBuff(unit, 'Immobile', unit)

    if unit.Character.CharBP.Name != 'Sniper' then
        unit.Character:SetCharacter('Sniper', true)
    end

    # Destroy Angelic Fury ambient effects, Create landing effects
    unit:DestroyAmbientEffects()
    AttachEffectsAtBone( unit, EffectTemplates.Regulus.AngelicFuryLand01, 'sk_Sniper_Leftwing2' )
    AttachEffectsAtBone( unit, EffectTemplates.Regulus.AngelicFuryLand01, 'sk_Sniper_Leftwing3' )
    AttachEffectsAtBone( unit, EffectTemplates.Regulus.AngelicFuryLand01, 'sk_Sniper_Rightwing2' )
    AttachEffectsAtBone( unit, EffectTemplates.Regulus.AngelicFuryLand01, 'sk_Sniper_Rightwing3' )
    AttachEffectsAtBone( unit, EffectTemplates.Regulus.AngelicFuryLand02, -2 )

    unit.Character:PlayAction('AngelOff')

    unit:HideBone("sk_Sniper_Rightwing1", true)
    unit:HideBone("sk_Sniper_Leftwing1", true)
    unit:HideBone("sk_Sniper_Wingsbase", true)
    unit:ShowBone("sk_Sniper_Leftwingstub", true)
    unit:ShowBone("sk_Sniper_Rightwingstub", true)
    unit:ShowBone("sk_Sniper_Wingstubsbase", true)

    WaitSeconds(1.0)

    Buff.RemoveBuff(unit, 'RangeAttackLock')
    Buff.RemoveBuff(unit, 'HGSA01Vengeance01')
    Buff.RemoveBuff(unit, 'Immobile')

    # Create blood/feathers effects
    unit:CreateAmbientEffects()
end


#################################################################################################################
# Epic Death
#################################################################################################################
RegulusDeath = function( unit, abil )
    local army = unit:GetArmy()
    local pos = table.copy(unit:GetPosition())
    pos[2] = 100

    AttachEffectsAtBone( unit, EffectTemplates.Regulus.EpicDeath01, -2 )
    CreateTemplatedEffectAtPos( 'Regulus', nil, 'EpicDeath02', army, pos )

    WaitSeconds(3)

    # Apply slow to all enemy entities nearby
    local entities = GetEntitiesInSphere("UNITS", pos, abil.AffectRadius)

    for k,entity in entities do
        if IsAlly(army,entity:GetArmy()) and not entity:IsDead() and not EntityCategoryContains(categories.NOBUFFS, entity) and not EntityCategoryContains(categories.UNTARGETABLE, entity) then
            Buff.ApplyBuff(entity, abil.FriendlyDeathBuff, entity)
        end
    end
end

BuffBlueprint {
    Name = 'HGSA01DeathROFBoost01',
    Debuff = true,
    CanBeDispelled = true,
    DisplayName = '<LOC ABILITY_HGSA01_0045>Pure Vision',
    Description = '<LOC ABILITY_HGSA01_0046>Attack Speed increased.',
    BuffType = 'HDEATHROF',
    Stacks = 'REPLACE',
    Duration = 6,
    Affects = {
        RateOfFire = {Mult = 0.20},
    },
    # Temp buff effect for this event
    Effects = 'Slow01',
    EffectsBone = -2,
    Icon = '/DGRegulus/NewRegulusVengence01',
}

AbilityBlueprint {
    Name = 'HGSA01Death01',
    DisplayName = 'Death',
    Description = 'Regulus death functional ability',
    AbilityType = 'Quiet',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    NoCastAnim = true,
    AffectRadius = 10,
    FriendlyDeathBuff = 'HGSA01DeathROFBoost01',
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnKilled:Add(self.Death, self)
    end,
    Death = function(self, unit)
        unit:ForkThread(RegulusDeath, self)
    end,
}

#################################################################################################################
# Icons
#################################################################################################################
AbilityBlueprint {
    Name = 'HRegulusSnipeGrey01',
    DisplayName = '<LOC ABILITY_HGSA01_0006>Snipe I',
    Description = '<LOC ABILITY_HGSA01_0007>Regulus takes time to set up a devastating shot, piercing a target for [GetInitialDamage] damage plus additional damage as it travels.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 1,
    HotKey = '1',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HGSA01Snipe01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HGSA01Snipe01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HGSA01Snipe01'].CastingTime end,
    GetCooldown = function(self) return Ability['HGSA01Snipe01'].Cooldown end,
    GetInitialDamage = function(self) return math.floor( Ability['HGSA01Snipe01'].DamageAmt ) end,
    Icon = '/DGRegulus/NewRegulusSnipe01',
}

AbilityBlueprint {
    Name = 'HRegulusMineGrey01',
    DisplayName = '<LOC ABILITY_HGSA01_0027>Explosive Mine I',
    Description = '<LOC ABILITY_HGSA01_0028>Regulus sets an explosive proximity mine that deals [GetDamage] damage when it explodes.\n\nUp to [GetMineMax] mines may be active at a time.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 4,
    HotKey = '4',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HGSA01ExplosiveMine01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HGSA01ExplosiveMine01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HGSA01ExplosiveMine01'].CastingTime end,
    GetCooldown = function(self) return Ability['HGSA01ExplosiveMine01'].Cooldown end,
    GetDamage = function(self) return math.floor( Ability['HGSA01ExplosiveMine01'].DamageAmt ) end,
    GetMineMax = function(self) return math.floor( Ability['HGSA01ExplosiveMine01'].MineMax ) end,
    Icon = '/DGRegulus/NewRegulusExplosiveMine01',
}

AbilityBlueprint {
    Name = 'HRegulusBetrayerGrey01',
    DisplayName = '<LOC ABILITY_HGSA01_0020>Mark of the Betrayer I',
    Description = '<LOC ABILITY_HGSA01_0021>Regulus fires at a Demigod, marking them with a rune. When they perform an ability, they and their nearby allies take [GetDamageAmt] damage. Also, the Demigod\'s Movement Speed is reduced by [GetSlowBuff]% for [GetDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HGSA01Betrayer01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HGSA01Betrayer01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HGSA01Betrayer01'].CastingTime end,
    GetCooldown = function(self) return Ability['HGSA01Betrayer01'].Cooldown end,
    GetDamageAmt = function(self) return math.floor( Buffs['HGSA01Betrayer01'].DamageAmt ) end,
    GetDuration = function(self) return ( Buffs['HGSA01BetrayerSlow01'].Duration ) end,
    GetSlowBuff = function(self) return math.floor( Buffs['HGSA01BetrayerSlow01'].Affects.MoveMult.Mult * -100 ) end,
    Icon = '/DGRegulus/NewRegulusMarkoftheBetrayer01',
}

AbilityBlueprint {
    Name = 'HRegulusAngelicFuryGrey01',
    DisplayName = '<LOC ABILITY_HGSA01_0037>Angelic Fury',
    Description = '<LOC ABILITY_HGSA01_0053>Regulus enters a divine rage. His bolts deal [GetDamage] extra damage and explode on contact. Costs [GetCostPerShot] Mana per shot.',
    GetMaxRange = function(self) return Ability['HGSA01AngelicFuryOn'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HGSA01AngelicFuryOn'].EnergyCost end,
    GetCastTime = function(self) return Ability['HGSA01AngelicFuryOn'].CastingTime end,
    GetCooldown = function(self) return Ability['HGSA01AngelicFuryOn'].Cooldown end,
    GetDamage = function(self) return math.floor( Buffs['HGSA01AngelicFuryBuff01'].Affects.DamageRating.Add ) end,
    GetCostPerShot = function(self) return math.floor( Ability['HGSA01AngelicFury01'].EnergyPerShotCost ) end,
    AbilityType = 'Passive',
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    Placeholder = true,
    Icon = '/DGRegulus/NewRegulusAngelicFury01',
}
__moduleinfo.auto_reload = true
