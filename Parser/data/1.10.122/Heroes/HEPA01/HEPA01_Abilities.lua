local Buff = import('/lua/sim/buff.lua')
local Validate = import('/lua/common/ValidateAbility.lua')
local Abil = import('/lua/sim/ability.lua')
local Util = import('/lua/utilities.lua')
local Entity = import('/lua/sim/entity.lua').Entity
local GetRandomFloat = Util.GetRandomFloat

#################################################################################################################
# Inner Beast I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01SpeedIncrease01',
    DisplayName = '<LOC ABILITY_HEPA01_0000>Inner Beast I',
    Description = '<LOC ABILITY_HEPA01_0001>Unclean Beast taps into its latent power, increasing Attack Speed by [GetAttackSpeedBuff]% and Movement Speed by [GetMoveSpeedBuff]%.',
    AbilityType = 'Quiet',
    GetAttackSpeedBuff = function(self) return math.floor( Buffs[self.Name].Affects.RateOfFire.Mult * 100 ) end,
    GetMoveSpeedBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01SpeedIncrease01',
            DisplayName = '<LOC ABILITY_HEPA01_0000>Inner Beast I',
            Description = '<LOC ABILITY_HEPA01_0056>Attack Speed and Movement Speed increased.',
            BuffType = 'HEPA01SKIN',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                RateOfFire = {Mult = 0.03},
                MoveMult = {Mult = 0.03},
            },
        },
    },
    OnStartAbility = function(self, unit, params)
        unit:SetUnitCharacterMesh('CorrosiveSkin', true)
    end,
    Icon = '/DGUncleanBeast/NewUncleanInnerBeast01',
}

#################################################################################################################
# Inner Beast II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01SpeedIncrease02',
    DisplayName = '<LOC ABILITY_HEPA01_0002>Inner Beast II',
    Description = '<LOC ABILITY_HEPA01_0001>Unclean Beast taps into its latent power, increasing Attack Speed by [GetAttackSpeedBuff]% and Movement Speed by [GetMoveSpeedBuff]%.',
    AbilityType = 'Quiet',
    GetAttackSpeedBuff = function(self) return math.floor( Buffs[self.Name].Affects.RateOfFire.Mult * 100 ) end,
    GetMoveSpeedBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01SpeedIncrease02',
            DisplayName = '<LOC ABILITY_HEPA01_0002>Inner Beast II',
            Description = '<LOC ABILITY_HEPA01_0056>Attack Speed and Movement Speed increased.',
            BuffType = 'HEPA01SKIN',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                RateOfFire = {Mult = 0.07},
                MoveMult = {Mult = 0.07},
            },
        },
    },
    Icon = '/DGUncleanBeast/NewUncleanInnerBeast01',
}

#################################################################################################################
# Inner Beast III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01SpeedIncrease03',
    DisplayName = '<LOC ABILITY_HEPA01_0004>Inner Beast III',
    Description = '<LOC ABILITY_HEPA01_0001>Unclean Beast taps into its latent power, increasing Attack Speed by [GetAttackSpeedBuff]% and Movement Speed by [GetMoveSpeedBuff]%.',
    AbilityType = 'Quiet',
    GetAttackSpeedBuff = function(self) return math.floor( Buffs[self.Name].Affects.RateOfFire.Mult * 100 ) end,
    GetMoveSpeedBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01SpeedIncrease03',
            DisplayName = '<LOC ABILITY_HEPA01_0004>Inner Beast III',
            Description = '<LOC ABILITY_HEPA01_0056>Attack Speed and Movement Speed increased.',
            BuffType = 'HEPA01SKIN',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                RateOfFire = {Mult = 0.10},
                MoveMult = {Mult = 0.10},
            },
        },
    },
    Icon = '/DGUncleanBeast/NewUncleanInnerBeast01',
}

#################################################################################################################
# Acclimation
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01Acclimation',
    DisplayName = '<LOC ABILITY_HEPA01_0068>Acclimation',
    Description = '<LOC ABILITY_HEPA01_0069>Unclean Beast becomes more resistant to heavy blows. When an enemy deals [GetDamage] or more damage to Unclean Beast, it takes [GetReductionPercent]% less damage for [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetDamage = function(self) return Buffs['HEPA01AcclimationSelf'].DamageThreshold end,
    GetReductionPercent = function(self) return math.floor( Buffs[self.Name].Affects.DamageTakenMult.Add * -100 ) end,
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01AcclimationSelf',
            BuffType = 'HEPA01ACCLIMATION',
            Debuff = false,
            Stacks = 'REPLACE',
            DamageThreshold = 500,
            Affects = {
                Dummy = {Add = 0.1},
            },
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnTakeDamage:Add(AcclimationCheck, self)
            end,

            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnTakeDamage:Remove(AcclimationCheck, self)
            end,
        },
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastAcclimation01',
}

AcclimationCheck = function(self, unit, data)
    if data.Amount < self.DamageThreshold then
        return
    end
    Buff.ApplyBuff(unit, 'HEPA01Acclimation', unit)
end

#################################################################################################################
# Buff: Acclimation
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01Acclimation',
    DisplayName = '<LOC ABILITY_HEPA01_0070>Acclimation',
    Description = '<LOC ABILITY_HEPA01_0071>All damage taken reduced.',
    Debuff = false,
    Stacks = 'REPLACE',
    BuffType = 'HEPA01ACCLIMATIONPROC',
    Duration = 5,
    Affects = {
        DamageTakenMult = {Add = -0.40},
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastAcclimation01',
}

#################################################################################################################
# Buffs - Venom Spit I
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01VenomSpitDoT01',
    DisplayName = '<LOC ABILITY_HEPA01_0006>Venom Spit',
    Description = '<LOC ABILITY_HEPA01_0007>Taking poison damage.',
    BuffType = 'HEPA01VENOMSPIT',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'ALWAYS',
    Duration = 10,
    DurationPulse = 10,
    ArmorImmune = true,
    CanCrit = false,
    CanBackfire = false,
    IgnoreDamageRangePercent = true,
    Icon = '/DGUncleanBeast/NewUncleanVenomSpit01',
    Affects = {
        Health = {Add = -45},
    },
    Effects = 'Disease01',
    EffectsBone = -1,
}

#################################################################################################################
# Buffs - Venom Spit II
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01VenomSpitDoT02',
    DisplayName = '<LOC ABILITY_HEPA01_0006>Venom Spit',
    Description = '<LOC ABILITY_HEPA01_0007>Taking poison damage.',
    BuffType = 'HEPA01VENOMSPIT',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'ALWAYS',
    Duration = 10,
    DurationPulse = 10,
    ArmorImmune = true,
    CanCrit = false,
    CanBackfire = false,
    IgnoreDamageRangePercent = true,
    Icon = '/DGUncleanBeast/NewUncleanVenomSpit01',
    Affects = {
        Health = {Add = -80},
    },
    Effects = 'Disease01',
    EffectsBone = -1,
}

#################################################################################################################
# Buffs - Venom Spit III
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01VenomSpitDoT03',
    DisplayName = '<LOC ABILITY_HEPA01_0006>Venom Spit',
    Description = '<LOC ABILITY_HEPA01_0007>Taking poison damage.',
    BuffType = 'HEPA01VENOMSPIT',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'ALWAYS',
    Duration = 10,
    DurationPulse = 10,
    ArmorImmune = true,
    CanCrit = false,
    CanBackfire = false,
    IgnoreDamageRangePercent = true,
    Icon = '/DGUncleanBeast/NewUncleanVenomSpit01',
    Affects = {
        Health = {Add = -115},
    },
    Effects = 'Disease01',
    EffectsBone = -1,
}

#################################################################################################################
# Buffs - Venom Spit IV
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01VenomSpitDoT04',
    DisplayName = '<LOC ABILITY_HEPA01_0006>Venom Spit',
    Description = '<LOC ABILITY_HEPA01_0007>Taking poison damage.',
    BuffType = 'HEPA01VENOMSPIT',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'ALWAYS',
    Duration = 10,
    DurationPulse = 10,
    ArmorImmune = true,
    CanCrit = false,
    CanBackfire = false,
    IgnoreDamageRangePercent = true,
    Icon = '/DGUncleanBeast/NewUncleanVenomSpit01',
    Affects = {
        Health = {Add = -150},
    },
    Effects = 'Disease01',
    EffectsBone = -1,
    OnApplyBuff = function( self, unit, instigator )
        if Validate.HasAbility(instigator,'HEPA01PutridFlow') then
            ForkThread(PutridFlow, instigator, unit, 'HEPA01PutridFlow' )
        end
    end,
}

#################################################################################################################
# Venom Spit I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01VenomSpit01',
    DisplayName = '<LOC ABILITY_HEPA01_0008>Venom Spit I',
    Description = '<LOC ABILITY_HEPA01_0009>Spews a corrosive venom at its target, dealing [GetInitialDamage] damage and an additional [GetDebuffDamage] damage over [GetDebuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 500,
    Cooldown = 7,
    RangeMax = 15,
    UISlot = 1,
    HotKey = '1',
    DamageAmt = 50,
    DamageType = 'Spell',
    GetInitialDamage = function(self) return math.floor( self.DamageAmt ) end,
    GetDebuffDamage = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT01'].Affects.Health.Add * Buffs['HEPA01VenomSpitDoT01'].DurationPulse * -1 ) end,
    GetDebuffDuration = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT01'].DurationPulse ) end,
    Icon = '/DGUncleanBeast/NewUncleanVenomSpit01',
    CastAction = 'CastVenomSpit',
    CastingTime = 0.3,
    FollowThroughTime = 0.5,
    OnStartAbility = function(self, unit, params)
        DoVenomSpit(self, unit, params, ParseEntityCategoryEx(self.TargetCategory), 'HEPA01VenomSpitDoT01')
    end,
    OnStartCasting = function(self, unit)
        # create venom spit launch spray effects
        FxVenomSpitLaunch(unit)
    end,
}

#################################################################################################################
# Venom Spit II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01VenomSpit02',
    DisplayName = '<LOC ABILITY_HEPA01_0010>Venom Spit II',
    Description = '<LOC ABILITY_HEPA01_0009>Spews a corrosive venom at its target, dealing [GetInitialDamage] damage and an additional [GetDebuffDamage] damage over [GetDebuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 650,
    Cooldown = 7,
    RangeMax = 15,
    UISlot = 1,
    HotKey = '1',
    Buffs = {},
    DamageAmt = 100,
    DamageType = 'Spell',
    GetInitialDamage = function(self) return math.floor( self.DamageAmt ) end,
    GetDebuffDamage = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT02'].Affects.Health.Add * Buffs['HEPA01VenomSpitDoT02'].DurationPulse * -1 ) end,
    GetDebuffDuration = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT02'].DurationPulse ) end,
    Icon = '/DGUncleanBeast/NewUncleanVenomSpit01',
    CastAction = 'CastVenomSpit',
    CastingTime = 0.3,
    FollowThroughTime = 0.5,
    OnStartAbility = function(self, unit, params)
        DoVenomSpit(self, unit, params, ParseEntityCategoryEx(self.TargetCategory), 'HEPA01VenomSpitDoT02')
    end,
    OnStartCasting = function(self, unit)
        # create venom spit launch spray effects
        FxVenomSpitLaunch(unit)
    end,
}

#################################################################################################################
# Venom Spit III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01VenomSpit03',
    DisplayName = '<LOC ABILITY_HEPA01_0012>Venom Spit III',
    Description = '<LOC ABILITY_HEPA01_0009>Spews a corrosive venom at its target, dealing [GetInitialDamage] damage and an additional [GetDebuffDamage] damage over [GetDebuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 800,
    Cooldown = 7,
    RangeMax = 15,
    UISlot = 1,
    HotKey = '1',
    Buffs = {},
    DamageAmt = 150,
    DamageType = 'Spell',
    Icon = '/DGUncleanBeast/NewUncleanVenomSpit01',
    CastAction = 'CastVenomSpit',
    CastingTime = 0.3,
    GetInitialDamage = function(self) return math.floor( self.DamageAmt ) end,
    GetDebuffDamage = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT03'].Affects.Health.Add * Buffs['HEPA01VenomSpitDoT03'].DurationPulse * -1 ) end,
    GetDebuffDuration = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT03'].DurationPulse ) end,
    FollowThroughTime = 0.5,
    OnStartAbility = function(self, unit, params)
        DoVenomSpit(self, unit, params, ParseEntityCategoryEx(self.TargetCategory), 'HEPA01VenomSpitDoT03')
    end,
    OnStartCasting = function(self, unit)
        # create venom spit launch spray effects
        FxVenomSpitLaunch(unit)
    end,
}

#################################################################################################################
# Venom Spit IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01VenomSpit04',
    DisplayName = '<LOC ABILITY_HEPA01_0065>Venom Spit IV',
    Description = '<LOC ABILITY_HEPA01_0009>Spews a corrosive venom at its target, dealing [GetInitialDamage] damage and an additional [GetDebuffDamage] damage over [GetDebuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 950,
    Cooldown = 7,
    RangeMax = 15,
    UISlot = 1,
    HotKey = '1',
    Buffs = {},
    DamageAmt = 150,
    DamageType = 'Spell',
    Icon = '/DGUncleanBeast/NewUncleanVenomSpit01',
    CastAction = 'CastVenomSpit',
    CastingTime = 0.3,
    Audio = {
                 OnFinishCasting = {Sound = 'Forge/DEMIGODS/Unclean_Beast/snd_dg_unclean_special_ability',},
             },
    GetInitialDamage = function(self) return math.floor( self.DamageAmt ) end,
    GetDebuffDamage = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT04'].Affects.Health.Add * Buffs['HEPA01VenomSpitDoT04'].DurationPulse * -1 ) end,
    GetDebuffDuration = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT04'].DurationPulse ) end,
    FollowThroughTime = 0.5,
    OnStartAbility = function(self, unit, params)
        DoVenomSpit(self, unit, params, ParseEntityCategoryEx(self.TargetCategory), 'HEPA01VenomSpitDoT04')
    end,
    OnStartCasting = function(self, unit)
        # create venom spit launch spray effects
        FxVenomSpitLaunch(unit)
    end,
}

#################################################################################################################
# Putrid Flow
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01PutridFlow',
    DisplayName = '<LOC ABILITY_HEPA01_0072>Putrid Flow',
    Description = '<LOC ABILITY_HEPA01_0073>When Venom Spit lands, it leaves a toxic pool around the victim, dealing [GetDamage] over [GetDuration] seconds.',
    Damage = 100,
    Duration = 5,
    Radius = 6,
    GetDamage = function(self) return math.floor(self.Damage * self.Duration) end,
    GetDuration = function(self) return self.Duration end,
    AbilityType = 'Quiet',
    
}

#################################################################################################################
# Putrid Flow CE
#################################################################################################################
function PutridFlow(instigator, unit, abdata)
    local pos = table.copy(unit:GetPosition())
    pos[2] = 100
    local army = instigator:GetArmy()
    local AftermathEffects01 = {}

    ## Start playing the ground decal ooze prior to explosion since it takes time to fade in.
    FxAftermathEntity ( instigator, pos, 10, 6, AftermathEffects01 )
    FxAftermathEntity ( instigator, pos, 8, 4, AftermathEffects01 )
    FxAftermathEntity ( instigator, pos, 4, 2, AftermathEffects01 )

    local emitters = CreateTemplatedEffectAtPos( 'UncleanBeast', nil, 'AfterMathCenter01', army, pos )
    for k, v in emitters do
        table.insert( AftermathEffects01, v )
    end

    local data = {
        Radius = Ability[abdata].Radius,
        Type = 'Spell',
        DamageSelf = false,
        CanBeEvaded = false,
        CanBackfire = false,
        CanDamageReturn = false,
        DamageFriendly = false,
        ArmorImmune = true,
        CanCrit = false,
        CanMagicResist = true,
        Group = "UNITS",
    }

    data.Instigator = instigator
    data.InstigatorBp = instigator:GetBlueprint()
    data.InstigatorArmy = army
    data.Origin = pos
    data.DamageAction = 'HEPA01PutridFlow'
    data.Amount = Ability[abdata].Damage
    for i = 1, Ability[abdata].Duration do
        DamageArea(data)
        WaitSeconds(1)
    end

    if AftermathEffects01 then
        for kEffect, vEffect in AftermathEffects01 do
            vEffect:Destroy()
        end
    end
end

#################################################################################################################
# VFX
# Venom Spit I
#################################################################################################################
function FxVenomSpitLaunch(unit)
    AttachEffectAtBone( unit, 'UncleanBeast', 'VenomSpitLaunch01', 'sk_Unclean_Beast_Beast_Jaw' )
    AttachEffectAtBone( unit, 'UncleanBeast', 'VenomSpitLaunch02', -2 )
end

function DoVenomSpit(def, unit, params, category, buff)
    local target = params.Targets[1]
    local unitpos = table.copy(unit:GetPosition())

    # Get a position/vector in front of and above root position of hero
    local dir = 3.65 * VNormal(VDiff(target:GetPosition(),unitpos))
    dir[2] = dir[2]+3.5

    local proj = unit:CreateProjectile( '/projectiles/Venomspit01/Venomspit01_proj.bp', dir[1], dir[2], dir[3], 0, 0, 1 )
    proj:SetOrientation(OrientFromDir(dir), true)
    proj:SetNewTarget(target)

    # Adjust angle of shot slightly downward
    dir[2] = dir[2]-2.0

    proj:SetVelocityVector(dir)
    proj:SetVelocity(30)
    proj:SetAcceleration(10)
    proj:PassDamageData(unit,
        {
            Amount = def.DamageAmt,
            Radius = 0,
            Type = def.DamageType,
            DamageAction = def.Name,
            CanBeEvaded = false,
            ArmorImmune = true,
            CanBackfire = false,
            CanDamageReturn = false,
            CanMagicResist = true,
            CanCrit = false,
            IgnoreDamageRangePercent = true,
            Group = 'UNITS',
            Buff = buff,
        }
    )
end

#################################################################################################################
# VFX
# Ooze
#################################################################################################################
function CreateOoze( unit, scale, trash )
    local radius = 3.5 * scale
    local steamScale = { 0.3 * scale, 1.0 * scale }
    local oozeScale = { 0.4 * scale, 0.7 * scale }
    local x = Util.GetRandomFloat( -radius, radius )
    local z = Util.GetRandomFloat( -radius, radius )
    local army = unit:GetArmy()
    local fx = nil

    local bonetable = {
        'sk_Unclean_Beast_RightShoulder',
        'sk_Unclean_Beast_LeftShoulder',
        'sk_Unclean_Beast_Spine04',
        'sk_Unclean_Beast_Spine02',
        'sk_Unclean_Beast_RightElbow',
        'sk_Unclean_Beast_LeftElbow',
        'sk_Unclean_Beast_Head',
    }

    # Create ooze drips
    AttachCharacterEffectsAtBones( unit, 'unclean_beast', 'OozeDrip01', bonetable, trash )

    bonetable = {
        'sk_Unclean_Beast_RightShoulder',
        'sk_Unclean_Beast_LeftShoulder',
        'sk_Unclean_Beast_Spine04',
        'sk_Unclean_Beast_Spine02',
        'sk_Unclean_Beast_RightElbow',
        'sk_Unclean_Beast_LeftElbow',
        'sk_Unclean_Beast_Head',
        'sk_Unclean_Beast_Neck',
    }

    # Create ooze gas/steam
    AttachCharacterEffectsAtBones( unit, 'unclean_beast', 'OozeGas01', bonetable, trash )

    while not unit:IsDead() do
        # Create ooze gas/steam
        fx = CreateCharacterEffectsAtPos( unit, 'unclean_beast', 'OozeGround01', unit:GetPosition() )

        for k, v in fx do
            v:ScaleEmitter( Util.GetRandomFloat( oozeScale[1], oozeScale[2] ) )
            v:SetEmitterCurveParam( 'X_POSITION_CURVE', x, 0.0 )
            v:SetEmitterCurveParam( 'Z_POSITION_CURVE', z, 0.0 )
        end

        WaitSeconds(0.2)
        x = Util.GetRandomFloat( -radius, radius )
        z = Util.GetRandomFloat( -radius, radius )
    end
end

#################################################################################################################
# Buffs - Ooze
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01OozeOnDisable',
    DisplayName = 'Ooze On Abilities Disabled',
    BuffType = 'HEPA01OOZEONDISABLE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    AbilityCategory = 'HEPA01OOZEON',
    Affects = {
        AbilityEnable = {Bool = true,},
    },
    SoundLoop = 'Forge/DEMIGODS/Unclean_Beast/snd_dg_unclean_ooze_lp',
}

#################################################################################################################
# Buffs - Ooze
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01OozeOffDisable',
    DisplayName = 'Ooze Off Abilities Disabled',
    BuffType = 'HEPA01OOZEOFFDISABLE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    AbilityCategory = 'HEPA01OOZEOFF',
    Affects = {
        AbilityEnable = {Bool = true,},
    },
}

#################################################################################################################
# CE - Ooze On Functionality
#################################################################################################################
function OozeFunctionalityEntrance(unit)
    Buff.ApplyBuff(unit, 'HEPA01OozeOnDisable', unit)
    if Buff.HasBuff(unit, 'HEPA01OozeOffDisable') then
        Buff.RemoveBuff(unit, 'HEPA01OozeOffDisable')
    end
    unit.AbilityData.OozeOn = true
    if Validate.HasAbility(unit,'HEPA01Ooze01') then
        Abil.SetAbilityState(unit, 'HEPA01Ooze01', false)
    elseif Validate.HasAbility(unit,'HEPA01Ooze02') then
        Abil.SetAbilityState(unit, 'HEPA01Ooze02', false)
    elseif Validate.HasAbility(unit,'HEPA01Ooze03') then
        Abil.SetAbilityState(unit, 'HEPA01Ooze03', false)
    elseif Validate.HasAbility(unit,'HEPA01Ooze04') then
        Abil.SetAbilityState(unit, 'HEPA01Ooze04', false)
    end
end

#################################################################################################################
# CE - Ooze Off Functionality
#################################################################################################################
function OozeFunctionalityExit(unit)
    Buff.ApplyBuff(unit, 'HEPA01OozeOffDisable', unit)
    if Buff.HasBuff(unit, 'HEPA01OozeOnDisable') then
        Buff.RemoveBuff(unit, 'HEPA01OozeOnDisable')
    end
    unit.AbilityData.OozeOn = false
    if Validate.HasAbility(unit,'HEPA01Ooze01') then
        Abil.SetAbilityState(unit, 'HEPA01Ooze01', true)
    elseif Validate.HasAbility(unit,'HEPA01Ooze02') then
        Abil.SetAbilityState(unit, 'HEPA01Ooze02', true)
    elseif Validate.HasAbility(unit,'HEPA01Ooze03') then
        Abil.SetAbilityState(unit, 'HEPA01Ooze03', true)
    elseif Validate.HasAbility(unit,'HEPA01Ooze04') then
        Abil.SetAbilityState(unit, 'HEPA01Ooze04', true)
    end
end

#################################################################################################################
# Ooze - Ooze On
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01OozeOn',
    DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
    Description = '<LOC ABILITY_HEPA01_0015>Oozes virulent bodily fluids. Enemies in range take damage per second and their Attack Speed is slowed.\n\nUnclean Beast loses Health while Ooze is active.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    Cooldown = 1,
    SharedCooldown = 'HEPA01OozeSwitch',
    EnergyCost = 0,
    UISlot = 3,
    HotKey = '3',
    AffectRadius = 8,
    Tooltip = {
        TargetAlliance = 'Enemy',
        Cooldown = 1,
        EnergyCost = 0,
    },
    Audio = {
        OnStartCasting = {Sound = 'Forge/DEMIGODS/Unclean_Beast/snd_dg_unclean_ooze_start',},
        OnAbortCasting = {Sound = 'Forge/UI/Lobby/snd_ui_lobby_lobby_unique_fail',},               #PLACEHOLDER
    },
    AbilityCategory = 'HEPA01OOZEON',
    OnStartAbility = function(self, unit, params)
        OozeFunctionalityEntrance(unit)
        Abil.HideAbility(unit, 'HEPA01OozeOn')
        Abil.ShowAbility(unit, 'HEPA01OozeOff')
    end,
    Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
}

#################################################################################################################
# Ooze - Ooze Off
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01OozeOff',
    DisplayName = '<LOC ABILITY_HEPA01_0016>Stop Ooze',
    Description = '<LOC ABILITY_HEPA01_0017>Stop oozing bodily fluids.',
    Audio = {
        OnStartCasting = {Sound = 'Forge/DEMIGODS/Unclean_Beast/snd_dg_unclean_ooze_end',},
        OnAbortCasting = {Sound = 'Forge/UI/Lobby/snd_ui_lobby_lobby_unique_fail',},               #PLACEHOLDER
    },
    AbilityType = 'Instant',
    Cooldown = 1,
    SharedCooldown = 'HEPA01OozeSwitch',
    UISlot = 3,
    HotKey = '3',
    NotSilenceable = true,
    Tooltip = {
        Cooldown = 1,
    },
    AbilityCategory = 'HEPA01OOZEOFF',
    OnStartAbility = function(self, unit, params)
        OozeFunctionalityExit(unit)
        Abil.HideAbility(unit, 'HEPA01OozeOff')
        Abil.ShowAbility(unit, 'HEPA01OozeOn')
    end,
    Icon = '/DGUncleanBeast/NewUncleanBeastOozeOff01',
}

#################################################################################################################
# Buff - Ooze I
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01OozeSelf01',
    DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
    Description = '<LOC ABILITY_HEPA01_0018>Ooze is active. Taking poison damage.',
    Duration = 1,
    BuffType = 'HEPA01OOZESELF',
    Debuff = true,
    Stacks = 'REPLACE',
    DamageSelf = true,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    IgnoreDamageRangePercent = true,
    ArmorImmune = true,
    CanCrit = false,
    CanMagicResist = false,
    Affects = {
        Health = {Add = -20},
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
}

#################################################################################################################
# Buff - Ooze II
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01OozeSelf02',
    DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
    Description = '<LOC ABILITY_HEPA01_0018>Ooze is active. Taking poison damage.',
    Duration = 1,
    BuffType = 'HEPA01OOZESELF',
    Debuff = true,
    Stacks = 'REPLACE',
    DamageSelf = true,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    IgnoreDamageRangePercent = true,
    ArmorImmune = true,
    CanCrit = false,
    CanMagicResist = false,
    Affects = {
        Health = {Add = -30},
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
}

#################################################################################################################
# Buff - Ooze III
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01OozeSelf03',
    DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
    Description = '<LOC ABILITY_HEPA01_0018>Ooze is active. Taking poison damage.',
    Duration = 1,
    BuffType = 'HEPA01OOZESELF',
    Debuff = true,
    Stacks = 'REPLACE',
    DamageSelf = true,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    ArmorImmune = true,
    IgnoreDamageRangePercent = true,
    CanCrit = false,
    CanMagicResist = false,
    Affects = {
        Health = {Add = -40},
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
}

#################################################################################################################
# Buff - Ooze IV
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01OozeSelf04',
    DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
    Description = '<LOC ABILITY_HEPA01_0018>Ooze is active. Taking poison damage.',
    Duration = 1,
    BuffType = 'HEPA01OOZESELF',
    Debuff = true,
    Stacks = 'REPLACE',
    DamageSelf = true,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    ArmorImmune = true,
    IgnoreDamageRangePercent = true,
    CanCrit = false,
    CanMagicResist = false,
    Affects = {
        Health = {Add = -50},
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
}

#################################################################################################################
# Debuff - Ooze I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01Ooze01',
    DisplayName = '<LOC ABILITY_HEPA01_0019>Ooze I',
    Description = '<LOC ABILITY_HEPA01_0049>Unclean Beast oozes virulent bodily fluids. While active, nearby enemies take [GetDebuffDamage] damage per second and their Attack Speed is slowed by [GetDebuffSlow]%.\n\nUnclean Beast loses [GetDebuffSelfDamage] Health per second.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 8,
    AuraPulseTime = 1,
    EnergyCost = 0,
    AbilityCategory = 'HEPA01OOZE',
    GetDebuffDamage = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * -1 ) end,
    GetDebuffSlow = function(self) return math.floor( Buffs[self.Name].Affects.RateOfFire.Mult * -100 ) end,
    GetDebuffSelfDamage = function(self) return math.floor( Buffs['HEPA01OozeSelf01'].Affects.Health.Add * -1 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01Ooze01',
            DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
            Description = '<LOC ABILITY_HEPA01_0020>Taking poison damage. Attack Speed reduced.',
            BuffType = 'HEPA01OOZE',
            Debuff = true,
            CanBeDispelled = true,
            CanCrit = false,
            Stacks = 'REPLACE',
            Duration = 1,
            Affects = {
                RateOfFire = {Mult = -0.10},
                Health = {Add = -35},
            },
            #Effects = 'Poison01',
            Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
        },
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastOozeOff01',
    OnAbilityAdded = function(self,unit)
        Abil.AddAbility(unit,'HEPA01OozeOff', true)
        Abil.AddAbility(unit,'HEPA01OozeOn', true)
        Abil.HideAbility(unit, 'HEPA01OozeOff')
        unit.Sync.Abilities['HEPA01OozeOn'].Cooldown = GetGameTimeSeconds()
        if unit.AbilityData[self.Name].ActiveEffectDestroyables then
            unit.AbilityData[self.Name].ActiveEffectDestroyables:Destroy()
        end
        if not unit.AbilityData.OozeOn then
            Abil.SetAbilityState(unit, 'HEPA01Ooze01', true)
        else
            OozeFunctionalityExit(unit)
            OozeFunctionalityEntrance(unit)
        end
    end,
    OnAuraPulse = function(self, unit, params)
        if unit.AbilityData.OozeOn then
            Buff.ApplyBuff(unit, 'HEPA01OozeSelf01', unit)
            if unit:GetHealth() < 100 then
                local params = { AbilityName = 'HEPA01OozeOff'}
                Abil.HandleAbility(unit, params)
            end
        end
    end,
    CreateAbilityAmbients = function( self, unit, trash )
        if unit.AbilityData.OozeOn then
            local thd = unit:ForkThread( CreateOoze, 1, trash )
            trash:Add( thd )
        end
    end,
}

#################################################################################################################
# Debuff - Ooze II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01Ooze02',
    DisplayName = '<LOC ABILITY_HEPA01_0021>Ooze II',
    Description = '<LOC ABILITY_HEPA01_0049>Unclean Beast oozes virulent bodily fluids. While active, nearby enemies take [GetDebuffDamage] damage per second and their Attack Speed is slowed by [GetDebuffSlow]%.\n\nUnclean Beast loses [GetDebuffSelfDamage] Health per second.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 8,
    AuraPulseTime = 1,
    EnergyCost = 0,
    AbilityCategory = 'HEPA01OOZE',
    GetDebuffDamage = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * -1 ) end,
    GetDebuffSlow = function(self) return math.floor( Buffs[self.Name].Affects.RateOfFire.Mult * -100 ) end,
    GetDebuffSelfDamage = function(self) return math.floor( Buffs['HEPA01OozeSelf02'].Affects.Health.Add * -1 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01Ooze02',
            DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
            Description = '<LOC ABILITY_HEPA01_0020>Taking poison damage. Attack Speed reduced.',
            BuffType = 'HEPA01OOZE',
            Debuff = true,
            CanBeDispelled = true,
            CanCrit = false,
            Stacks = 'REPLACE',
            Duration = 1,
            Affects = {
                RateOfFire = {Mult = -0.20},
                Health = {Add = -70},
            },
            #Effects = 'Poison01',
            Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
        },
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastOozeOff01',
    OnAbilityAdded = function(self,unit)
        unit.Sync.Abilities['HEPA01OozeOn'].Cooldown = GetGameTimeSeconds()
        if not unit.AbilityData.OozeOn then
            if unit.AbilityData[self.Name].ActiveEffectDestroyables then
                unit.AbilityData[self.Name].ActiveEffectDestroyables:Destroy()
            end
            Abil.SetAbilityState(unit, 'HEPA01Ooze02', true)
        else
            OozeFunctionalityExit(unit)
            OozeFunctionalityEntrance(unit)
        end
    end,
    OnAuraPulse = function(self, unit, params)
        if unit.AbilityData.OozeOn then
            Buff.ApplyBuff(unit, 'HEPA01OozeSelf02', unit)
            if unit:GetHealth() < 100 then
                local params = { AbilityName = 'HEPA01OozeOff'}
                Abil.HandleAbility(unit, params)
            end
        end
    end,
    CreateAbilityAmbients = function( self, unit, trash )
        if unit.AbilityData.OozeOn then
            local thd = unit:ForkThread( CreateOoze, 1.3, trash )
            trash:Add( thd )
        end
    end,
}

#################################################################################################################
# Debuff - Ooze III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01Ooze03',
    DisplayName = '<LOC ABILITY_HEPA01_0022>Ooze III',
    Description = '<LOC ABILITY_HEPA01_0049>Unclean Beast oozes virulent bodily fluids. While active, nearby enemies take [GetDebuffDamage] damage per second and their Attack Speed is slowed by [GetDebuffSlow]%.\n\nUnclean Beast loses [GetDebuffSelfDamage] Health per second.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 8,
    AuraPulseTime = 1,
    EnergyCost = 0,
    AbilityCategory = 'HEPA01OOZE',
    GetDebuffDamage = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * -1 ) end,
    GetDebuffSlow = function(self) return math.floor( Buffs[self.Name].Affects.RateOfFire.Mult * -100 ) end,
    GetDebuffSelfDamage = function(self) return math.floor( Buffs['HEPA01OozeSelf03'].Affects.Health.Add * -1 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01Ooze03',
            DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
            Description = '<LOC ABILITY_HEPA01_0020>Taking poison damage. Attack Speed reduced.',
            BuffType = 'HEPA01OOZE',
            Debuff = true,
            CanBeDispelled = true,
            CanCrit = false,
            Stacks = 'REPLACE',
            Duration = 1,
            Affects = {
                RateOfFire = {Mult = -0.30},
                Health = {Add = -105},
            },
            #Effects = 'Poison01',
            Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
        },
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastOozeOff01',
    OnAbilityAdded = function(self,unit)
        unit.Sync.Abilities['HEPA01OozeOn'].Cooldown = GetGameTimeSeconds()
        if not unit.AbilityData.OozeOn then
            if unit.AbilityData[self.Name].ActiveEffectDestroyables then
                unit.AbilityData[self.Name].ActiveEffectDestroyables:Destroy()
            end
            Abil.SetAbilityState(unit, 'HEPA01Ooze03', true)
        else
            OozeFunctionalityExit(unit)
            OozeFunctionalityEntrance(unit)
        end
    end,
    OnAuraPulse = function(self, unit, params)
        if unit.AbilityData.OozeOn then
            Buff.ApplyBuff(unit, 'HEPA01OozeSelf03', unit)
            if unit:GetHealth() < 100 then
                local params = { AbilityName = 'HEPA01OozeOff'}
                Abil.HandleAbility(unit, params)
            end
        end
    end,
    CreateAbilityAmbients = function( self, unit, trash )
        if unit.AbilityData.OozeOn then
            local thd = unit:ForkThread( CreateOoze, 1.7, trash )
            trash:Add( thd )
        end
    end,
}

#################################################################################################################
# Debuff - Ooze IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01Ooze04',
    DisplayName = '<LOC ABILITY_HEPA01_0066>Ooze IV',
    Description = '<LOC ABILITY_HEPA01_0049>Unclean Beast oozes virulent bodily fluids. While active, nearby enemies take [GetDebuffDamage] damage per second and their Attack Speed is slowed by [GetDebuffSlow]%.\n\nUnclean Beast loses [GetDebuffSelfDamage] Health per second.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 8,
    AuraPulseTime = 1,
    EnergyCost = 0,
    AbilityCategory = 'HEPA01OOZE',
    GetDebuffDamage = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * -1 ) end,
    GetDebuffSlow = function(self) return math.floor( Buffs[self.Name].Affects.RateOfFire.Mult * -100 ) end,
    GetDebuffSelfDamage = function(self) return math.floor( Buffs['HEPA01OozeSelf04'].Affects.Health.Add * -1 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01Ooze04',
            DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
            Description = '<LOC ABILITY_HEPA01_0020>Taking poison damage. Attack Speed reduced.',
            BuffType = 'HEPA01OOZE',
            Debuff = true,
            CanBeDispelled = true,
            CanCrit = false,
            Stacks = 'REPLACE',
            Duration = 1,
            Affects = {
                RateOfFire = {Mult = -0.40},
                Health = {Add = -140},
            },
            #Effects = 'Poison01',
            Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
        },
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastOozeOff01',
    OnAbilityAdded = function(self,unit)
        unit.Sync.Abilities['HEPA01OozeOn'].Cooldown = GetGameTimeSeconds()
        if not unit.AbilityData.OozeOn then
            if unit.AbilityData[self.Name].ActiveEffectDestroyables then
                unit.AbilityData[self.Name].ActiveEffectDestroyables:Destroy()
            end
            Abil.SetAbilityState(unit, 'HEPA01Ooze04', true)
        else
            OozeFunctionalityExit(unit)
            OozeFunctionalityEntrance(unit)
        end
    end,
    OnAuraPulse = function(self, unit, params)
        if unit.AbilityData.OozeOn then
            Buff.ApplyBuff(unit, 'HEPA01OozeSelf04', unit)
            if unit:GetHealth() < 100 then
                local params = { AbilityName = 'HEPA01OozeOff'}
                Abil.HandleAbility(unit, params)
            end
        end
    end,
    CreateAbilityAmbients = function( self, unit, trash )
        if unit.AbilityData.OozeOn then
            local thd = unit:ForkThread( CreateOoze, 1.7, trash )
            trash:Add( thd )
        end
    end,
}

#################################################################################################################
# Bestial Wrath I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01BestialWrath01',
    DisplayName = '<LOC ABILITY_HEPA01_0023>Bestial Wrath I',
    Description = '<LOC ABILITY_HEPA01_0024>Unclean Beast enters a frenzy for [GetDuration] seconds.\n\nWeapon Damage increased by [GetDamageBuff]%.',
    AbilityType = 'Instant',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    EnergyCost = 550,
    Cooldown = 15,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastWrath',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    OnAbilityAdded = function(self, unit)
       unit.BestialSplashRadius = 1
    end,
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDamageBuff = function(self) return math.floor( Buffs[self.Name].Affects.DamageRating.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01BestialWrath01',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HEPA01_0023>Bestial Wrath I',
            Description = '<LOC ABILITY_HEPA01_0025>Weapon Damage increased.',
            BuffType = 'HEPABESTIALWRATH',
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                DamageRating = {Mult = 0.25},
            },
            OnApplyBuff = function( self, unit, instigator )
                unit.BestialWrathActive = true
                unit:AddEffectMeshState( 'BestialWrath', unit.Character.CharBP.Meshes.BestialWrath, true, true )
            end,
            OnBuffRemove = function(self,unit)
                unit.BestialWrathActive = false
                unit:RemoveEffectMeshState( 'BestialWrath', true )
            end,
            Icon = '/DGUncleanBeast/NewUncleanBestialWrath01',
        }
    },
    Icon = '/DGUncleanBeast/NewUncleanBestialWrath01',
}

#################################################################################################################
# Bestial Wrath II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01BestialWrath02',
    DisplayName = '<LOC ABILITY_HEPA01_0026>Bestial Wrath II',
    Description = '<LOC ABILITY_HEPA01_0024>Unclean Beast enters a frenzy for [GetDuration] seconds.\n\nWeapon Damage increased by [GetDamageBuff]%.',
    AbilityType = 'Instant',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    EnergyCost = 700,
    Cooldown = 15,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastWrath',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    OnAbilityAdded = function(self, unit)
       unit.BestialSplashRadius = 1.5
    end,
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDamageBuff = function(self) return math.floor( Buffs[self.Name].Affects.DamageRating.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01BestialWrath02',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HEPA01_0026>Bestial Wrath II',
            Description = '<LOC ABILITY_HEPA01_0025>Weapon Damage increased.',
            BuffType = 'HEPABESTIALWRATH',
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                DamageRating = {Mult = 0.35},
            },
            OnApplyBuff = function( self, unit, instigator )
                unit.BestialWrathActive = true
                unit:AddEffectMeshState( 'BestialWrath', unit.Character.CharBP.Meshes.BestialWrath, true, true )
            end,
            OnBuffRemove = function(self,unit)
                unit.BestialWrathActive = false
                unit:RemoveEffectMeshState( 'BestialWrath', true )
            end,
            Icon = '/DGUncleanBeast/NewUncleanBestialWrath01',
        }
    },
    Icon = '/DGUncleanBeast/NewUncleanBestialWrath01',
}

#################################################################################################################
# Bestial Wrath III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01BestialWrath03',
    DisplayName = '<LOC ABILITY_HEPA01_0028>Bestial Wrath III',
    Description = '<LOC ABILITY_HEPA01_0024>Unclean Beast enters a frenzy for [GetDuration] seconds.\n\nWeapon Damage increased by [GetDamageBuff]%.',
    AbilityType = 'Instant',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    EnergyCost = 850,
    Cooldown = 15,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastWrath',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    OnAbilityAdded = function(self, unit)
       unit.BestialSplashRadius = 2
    end,
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDamageBuff = function(self) return math.floor( Buffs[self.Name].Affects.DamageRating.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01BestialWrath03',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HEPA01_0028>Bestial Wrath III',
            Description = '<LOC ABILITY_HEPA01_0025>Weapon Damage increased.',
            BuffType = 'HEPABESTIALWRATH',
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                DamageRating = {Mult = 0.45},
            },
            OnApplyBuff = function( self, unit, instigator )
                unit.BestialWrathActive = true
                unit:AddEffectMeshState( 'BestialWrath', unit.Character.CharBP.Meshes.BestialWrath, true, true )
            end,
            OnBuffRemove = function(self,unit)
                unit.BestialWrathActive = false
                unit:RemoveEffectMeshState( 'BestialWrath', true )
            end,
            Icon = '/DGUncleanBeast/NewUncleanBestialWrath01',
        }
    },
    Icon = '/DGUncleanBeast/NewUncleanBestialWrath01',
}

#################################################################################################################
# Bestial Wrath IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01BestialWrath04',
    DisplayName = '<LOC ABILITY_HEPA01_0067>Bestial Wrath IV',
    Description = '<LOC ABILITY_HEPA01_0024>Unclean Beast enters a frenzy for [GetDuration] seconds.\n\nWeapon Damage increased by [GetDamageBuff]%.',
    AbilityType = 'Instant',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    EnergyCost = 1000,
    Cooldown = 15,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastWrath',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    OnAbilityAdded = function(self, unit)
       unit.BestialSplashRadius = 2
    end,
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDamageBuff = function(self) return math.floor( Buffs[self.Name].Affects.DamageRating.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01BestialWrath04',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HEPA01_0067>Bestial Wrath IV',
            Description = '<LOC ABILITY_HEPA01_0025>Weapon Damage increased.',
            BuffType = 'HEPABESTIALWRATH',
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                DamageRating = {Mult = 0.55},
            },
            OnApplyBuff = function( self, unit, instigator )
                unit.BestialWrathActive = true
                unit:AddEffectMeshState( 'BestialWrath', unit.Character.CharBP.Meshes.BestialWrath, true, true )
            end,
            OnBuffRemove = function(self,unit)
                unit.BestialWrathActive = false
                unit:RemoveEffectMeshState( 'BestialWrath', true )
            end,
            Icon = '/DGUncleanBeast/NewUncleanBestialWrath01',
        }
    },
    Icon = '/DGUncleanBeast/NewUncleanBestialWrath01',
}

#################################################################################################################
# Unrelenting
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01BestialWrath05',
    DisplayName = '<LOC ABILITY_HEPA01_0074>Unrelenting Wrath',
    Description = '<LOC ABILITY_HEPA01_0075>Unclean Beast enters a frenzy for [GetDuration] seconds.\n\nWeapon Damage increased by [GetDamageBuff]%. His movement speed cannot be reduced in this state.',
    AbilityType = 'Instant',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    EnergyCost = 1000,
    Cooldown = 20,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastWrath',
    CastingTime = 0.5,
    Audio = {
                 OnFinishCasting = {Sound = 'Forge/DEMIGODS/Unclean_Beast/snd_dg_unclean_special_ability',},
             },
    FollowThroughTime = 0.5,
    OnAbilityAdded = function(self, unit)
       unit.BestialSplashRadius = 2
    end,
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDamageBuff = function(self) return math.floor( Buffs[self.Name].Affects.DamageRating.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01BestialWrath05',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HEPA01_0076>Unrelenting Wrath',
            Description = '<LOC ABILITY_HEPA01_0077>Weapon Damage increased. Unaffected by slows.',
            BuffType = 'HEPABESTIALWRATH',
            Stacks = 'REPLACE',
            Duration = 10,
            Affects = {
                DamageRating = {Mult = 0.65},
                MoveSlowCap = {Mult = 0.0},
            },
            OnApplyBuff = function( self, unit, instigator )
                unit.BestialWrathActive = true
                unit:AddEffectMeshState( 'BestialWrath', unit.Character.CharBP.Meshes.BestialWrath, true, true )
            end,
            OnBuffRemove = function(self,unit)
                unit.BestialWrathActive = false
                unit:RemoveEffectMeshState( 'BestialWrath', true )
            end,
            Icon = '/DGUncleanBeast/NewUncleanBeastUnrelentingWrath01',
        }
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastUnrelentingWrath01',
}

#################################################################################################################
# Buff - Diseased Claws I
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01DiseasedClaws01',
    DisplayName = '<LOC ABILITY_HEPA01_0030>Diseased Claws',
    Description = '<LOC ABILITY_HEPA01_0031>Movement Speed reduced.',
    BuffType = 'HEPA01DISEASED',
    EntityCategory = 'MOBILE',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 4,
    Affects = {
        MoveMult = {Mult = -0.05},
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastDiseasedclaw01',
}

AbilityBlueprint {
    Name = 'HEPA01DiseasedClaws01',
    DisplayName = '<LOC ABILITY_HEPA01_0032>Diseased Claws I',
    Description = '<LOC ABILITY_HEPA01_0033>Unclean Beast\'s claws reduce the target\'s Movement Speed by [GetSplashMultBuff]%.\n\nLasts [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetSplashMultBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01DiseasedClawsSelf01',
            DisplayName = '<LOC ABILITY_HEPA01_0032>Diseased Claws I',
            Description = '<LOC ABILITY_HEPA01_0060>Unclean Beast\'s claws reduce the target\'s Movement Speed.',
            BuffType = 'HEPA01CLAWS',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                Dummy = {Add = 0.1},
            },
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnWeaponFire:Add(self.Clawed, self)
            end,
            Clawed = function(self, unit)
                local target = unit:GetWeapon(1):GetTarget():GetRealTargetEntity()
                Buff.ApplyBuff(target, 'HEPA01DiseasedClaws01', unit, unit:GetArmy())
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnWeaponFire:Remove(self.Clawed)
            end,
        },
    },
    OnStartAbility = function(self, unit, params)
        unit:SetUnitCharacterMesh('DiseasedClaws', true)
    end,
    Icon = '/DGUncleanBeast/NewUncleanBeastDiseasedclaw01',
}

#################################################################################################################
# Buff - Diseased Claws II
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01DiseasedClaws02',
    DisplayName = '<LOC ABILITY_HEPA01_0030>Diseased Claws',
    Description = '<LOC ABILITY_HEPA01_0031>Movement Speed reduced.',
    BuffType = 'HEPA01DISEASED',
    EntityCategory = 'MOBILE',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 4,
    Affects = {
        MoveMult = {Mult = -0.07},
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastDiseasedclaw01',
}

AbilityBlueprint {
    Name = 'HEPA01DiseasedClaws02',
    DisplayName = '<LOC ABILITY_HEPA01_0034>Diseased Claws II',
    Description = '<LOC ABILITY_HEPA01_0033>Unclean Beast\'s claws reduce the target\'s Movement Speed by [GetSplashMultBuff]%.\n\nLasts [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetSplashMultBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01DiseasedClawsSelf02',
            DisplayName = '<LOC ABILITY_HEPA01_0034>Diseased Claws II',
            Description = '<LOC ABILITY_HEPA01_0060>Unclean Beast\'s claws reduce the target\'s Movement Speed.',
            BuffType = 'HEPA01CLAWS',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                Dummy = {Add = 0.1},
            },
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnWeaponFire:Add(self.Clawed, self)
            end,
            Clawed = function(self, unit)
                local target = unit:GetWeapon(1):GetTarget():GetRealTargetEntity()
                Buff.ApplyBuff(target, 'HEPA01DiseasedClaws02', unit, unit:GetArmy())
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnWeaponFire:Remove(self.Clawed)
            end,
        },
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastDiseasedclaw01',
}

#################################################################################################################
# Buff - Diseased Claws III
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01DiseasedClaws03',
    DisplayName = '<LOC ABILITY_HEPA01_0030>Diseased Claws',
    Description = '<LOC ABILITY_HEPA01_0031>Movement Speed reduced.',
    BuffType = 'HEPA01DISEASED',
    EntityCategory = 'MOBILE',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 4,
    Affects = {
        MoveMult = {Mult = -0.1},
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastDiseasedclaw01',
}

AbilityBlueprint {
    Name = 'HEPA01DiseasedClaws03',
    DisplayName = '<LOC ABILITY_HEPA01_0036>Diseased Claws III',
    Description = '<LOC ABILITY_HEPA01_0033>Unclean Beast\'s claws reduce the target\'s Movement Speed by [GetSplashMultBuff]%.\n\nLasts [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetSplashMultBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEPA01DiseasedClawsSelf03',
            DisplayName = '<LOC ABILITY_HEPA01_0036>Diseased Claws III',
            Description = '<LOC ABILITY_HEPA01_0060>Unclean Beast\'s claws reduce the target\'s Movement Speed.',
            BuffType = 'HEPA01CLAWS',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                Dummy = {Add = 0.1},
            },
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnWeaponFire:Add(self.Clawed, self)
            end,
            Clawed = function(self, unit)
                local target = unit:GetWeapon(1):GetTarget():GetRealTargetEntity()
                Buff.ApplyBuff(target, 'HEPA01DiseasedClaws03', unit, unit:GetArmy())
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnWeaponFire:Remove(self.Clawed)
            end,
        },
    },
    Icon = '/DGUncleanBeast/NewUncleanBeastDiseasedclaw01',
}
#################################################################################################################
# Buff - Post Mortem
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01PostMortemEnemy01',
    DisplayName = '<LOC ABILITY_HEPA01_0038>Post Mortem',
    Description = '<LOC ABILITY_HEPA01_0039>Will explode when killed.',
    BuffType = 'HEPA01POSTMORTEMENEMY',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'MOBILE - UNTARGETABLE',
    Stacks = 'REPLACE',
    CallbackDuration = 30,
    Affects = {
        Dummy = {Add = 0},
    },
    Effects = 'PostMortem01',
    EffectsBone = -1,

    OnBuffAffect = function(self, unit, instigator)
        if instigator then
            unit.AbilityData.PostMortem = {}
            unit.AbilityData.PostMortem.Caster = instigator
            unit.AbilityData.PostMortem.CasterArmy = instigator:GetArmy()
            unit.AbilityData.PostMortem.CasterBp = instigator:GetBlueprint()
            unit.AbilityData.PostMortem.DamageRating = instigator.Sync.DamageRating
        end
        unit.Callbacks.OnKilled:Add(PMExplode, self)
        if unit.PostMortemRemoveThread then
            KillThread(unit.PostMortemRemoveThread)
        end
        unit.PostMortemRemoveThread = ForkThread(
            function()
                WaitSeconds(self.CallbackDuration)
                if not unit:IsDead() then
                    unit.Callbacks.OnKilled:Remove(PMExplode)
                end
            end
        )
    end,
    OnBuffRemove = function(self, unit)
        unit.Callbacks.OnKilled:Remove(PMExplode)
    end,
    Icon = '/DGUncleanBeast/NewUncleanPostMortem01',
}

#################################################################################################################
# CE - Post Mortem Explosion
#   Explosion damage tuning - 'DamageAmt'
#################################################################################################################
PMExplode = function(self, unit)
    #unit.IgnoreDeathThreadSequence = true
    local pos = table.copy(unit:GetPosition())
    pos[2] = 100
    local MetaImpactRadius = 3
    local MetaImpactAmount = 8
    local DamageAmt = 150
    local Damage = {
        Radius = 6,
        Type = 'Spell',
        DamageAction = 'HEPA01PostMortemEnemy01',
        DamageSelf = false,
        CanBeEvaded = false,
        CanBackfire = false,
        CanDamageReturn = false,
        DamageFriendly = false,
        ArmorImmune = true,
        CanCrit = false,
        CanMagicResist = false,
        CanOverKill = false,
        Group = "UNITS",
    }

    # create unit post mortem explosion effects
    CreateTemplatedEffectAtPos( 'UncleanBeast', nil, 'PostMortem01', unit:GetArmy(), pos )

    local data = {
        Instigator = unit.AbilityData.PostMortem.Caster,
        InstigatorBp = unit.AbilityData.PostMortem.CasterBp,
        InstigatorArmy = unit.AbilityData.PostMortem.CasterArmy,
        Origin = table.copy(unit:GetPosition()),
        Radius = MetaImpactRadius,
        Amount = MetaImpactAmount,
        Category = "METAINFANTRY",
        DamageFriendly = false,
    }
    MetaImpact(data)

    data = table.copy(Damage)
    data.Instigator = unit.AbilityData.PostMortem.Caster
    data.InstigatorBp = unit.AbilityData.PostMortem.CasterBp
    data.InstigatorArmy = unit.AbilityData.PostMortem.CasterArmy
    data.Amount = DamageAmt
    data.Origin = table.copy(unit:GetPosition())

    DamageArea(data)
    unit.AbilityData.PostMortem = nil
end,

#################################################################################################################
# Post Mortem
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01PostMortem01',
    DisplayName = '<LOC ABILITY_HEPA01_0038>Post Mortem',
    Description = '<LOC ABILITY_HEPA01_0040>When Unclean Beast attacks, enemies are afflicted with a disease. When they die, they will explode, dealing 150 damage and sending smaller units into the air.',
    AbilityType = 'WeaponProc',
    ProcType = 'PreDamage',
    WeaponProcChance = 100,
    OnWeaponProc = function(self, unit, target, damageData)
        Buff.ApplyBuff(target, 'HEPA01PostMortemEnemy01', unit, unit:GetArmy())
    end,
    Icon = '/DGUncleanBeast/NewUncleanPostMortem01',
}

#################################################################################################################
# Buff - Plague I
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01Plague01',
    DisplayName = '<LOC ABILITY_HEPA01_0061>Plague',
    Description = '<LOC ABILITY_HEPA01_0042>Taking poison damage. Spreads to allies.',
    BuffType = 'HEPA01PLAGUE',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'MOBILE - UNTARGETABLE',
    Stacks = 'IGNORE',
    Duration = 30,
    DurationPulse = 30,
    Affects = {
       Health = {Add = -10},
    },
    Effects = 'Plague01',
    EffectsBone = -2,
    DamageSelf = true,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    ArmorImmune = true,
    CanCrit = false,
    CanMagicResist = true,
    #NoFloatText = true,
    AffectRadius = 10,
    AffectChance = 100,
    NumIgnoreSpreadPulses = 1,                      # Number of pulses to wait before spreading plague
    Icon = '/DGUncleanBeast/NewUncleanPlague01',
    OnApplyBuff = function( self, unit, instigator )
        unit.Callbacks.OnKilled:Add(self.UnitOnKilledCallback, self)
    end,
    OnBuffAffect = function(self, unit, instigator)
        #LOG("*DEBUG: OnBuffAffect unit: "..unit:GetUnitId().. " inst:"..instigator:GetUnitId())
        if unit:IsDead() or instigator:IsDead() or not instigator.Plague then
            return
        end

        # Allows for ignoring OnBuffAffect pulses, so this doesn't trigger immediately on the first
        # application of plague.
        if unit.PlagueInstance.IgnoreAffectPulses then
            unit.PlagueInstance.NumIgnoredPulses = unit.PlagueInstance.NumIgnoredPulses + 1
            if unit.PlagueInstance.NumIgnoredPulses >= self.NumIgnoreSpreadPulses then
                unit.PlagueInstance.IgnoreAffectPulses = false
            end
            return
        end

        local targets = unit:GetAIBrain():GetUnitsAroundPoint((categories.MOBILE - categories.UNTARGETABLE), unit:GetPosition(), self.AffectRadius, 'Ally')
        PlagueSpread01( instigator, targets, self.AffectChance )
    end,

    OnBuffRemove = function(self, unit)
        #self:DecrementPlagueCounter(unit)
        Buff.ApplyBuff(unit, 'HEPA01PlagueImmune', unit)
    end,
    UnitOnKilledCallback = function( self, unit )
        unit.Callbacks.OnKilled:Remove(self.UnitOnKilledCallback)
        #self:DecrementPlagueCounter(unit)
    end,
    DecrementPlagueCounter = function(self, unit)
        local instigator = unit.PlagueInstance.Instigator
        if not instigator then
            LOG( 'No Instigator' )
        end
        if not instigator:IsDead() then
            instigator.Plague.NumPlaguedUnits = instigator.Plague.NumPlaguedUnits - 1
            unit.PlagueInstance = nil
        end
    end,
}

#################################################################################################################
# Buff - Plague II
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01Plague02',
    DisplayName = '<LOC ABILITY_HEPA01_0062>Plague',
    Description = '<LOC ABILITY_HEPA01_0042>Taking poison damage. Spreads to allies.',
    BuffType = 'HEPA01PLAGUE',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'MOBILE - UNTARGETABLE',
    Stacks = 'IGNORE',
    Duration = 30,
    DurationPulse = 30,
    Affects = {
       Health = {Add = -15},
    },
    Effects = 'Plague01',
    EffectsBone = -2,
    DamageSelf = true,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    ArmorImmune = true,
    CanCrit = false,
    CanMagicResist = true,
    #NoFloatText = true,
    AffectRadius = 10,
    AffectChance = 100,
    NumIgnoreSpreadPulses = 1,                      # Number of pulses to wait before spreading plague
    Icon = '/DGUncleanBeast/NewUncleanPlague01',
    OnApplyBuff = function( self, unit, instigator )
        unit.Callbacks.OnKilled:Add(self.UnitOnKilledCallback, self)
    end,
    OnBuffAffect = function(self, unit, instigator)
        #LOG("*DEBUG: OnBuffAffect unit: "..unit:GetUnitId().. " inst:"..instigator:GetUnitId())
        if unit:IsDead() or instigator:IsDead() or not instigator.Plague then
            return
        end

        # Allows for ignoring OnBuffAffect pulses, so this doesn't trigger immediately on the first
        # application of plague.
        if unit.PlagueInstance.IgnoreAffectPulses then
            unit.PlagueInstance.NumIgnoredPulses = unit.PlagueInstance.NumIgnoredPulses + 1
            if unit.PlagueInstance.NumIgnoredPulses >= self.NumIgnoreSpreadPulses then
                unit.PlagueInstance.IgnoreAffectPulses = false
            end
            return
        end

        local targets = unit:GetAIBrain():GetUnitsAroundPoint((categories.MOBILE - categories.UNTARGETABLE), unit:GetPosition(), self.AffectRadius, 'Ally')
        PlagueSpread02( instigator, targets, self.AffectChance )
    end,

    OnBuffRemove = function(self, unit)
        #self:DecrementPlagueCounter(unit)
        Buff.ApplyBuff(unit, 'HEPA01PlagueImmune', unit)
    end,
    UnitOnKilledCallback = function( self, unit )
        unit.Callbacks.OnKilled:Remove(self.UnitOnKilledCallback)
        #self:DecrementPlagueCounter(unit)
    end,
    DecrementPlagueCounter = function(self, unit)
        local instigator = unit.PlagueInstance.Instigator
        if not instigator then
            LOG( 'No Instigator' )
        end
        if not instigator:IsDead() then
            instigator.Plague.NumPlaguedUnits = instigator.Plague.NumPlaguedUnits - 1
            unit.PlagueInstance = nil
        end
    end,
}

BuffBlueprint {
    Name = 'HEPA01PlagueImmune',
    DisplayName = '<LOC ABILITY_HEPA01_0053>Plague Immune',
    Description = '<LOC ABILITY_HEPA01_0054>You are immune to the Unclean Beasts\'s plague.',
    BuffType = 'HEPA01PLAGUE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 180,
    Affects = {
        Dummy = {Add = 67},
    },
}


#################################################################################################################
# Ability - Plague I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01Plague01',
    DisplayName = '<LOC ABILITY_HEPA01_0041>Plague I',
    Description = '<LOC ABILITY_HEPA01_0052>When Unclean Beast deals damage, it has a chance to start a plague, dealing [GetDamageAmt] damage over [GetDuration] seconds and spreading to nearby units.\n\nAnything that survives the plague becomes immune to it for [GetImmuneDuration] seconds.',
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDamageAmt = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * Buffs[self.Name].DurationPulse * -1 ) end,
    GetImmuneDuration = function(self) return math.floor( Buffs['HEPA01PlagueImmune'].Duration ) end,
    AbilityType = 'Quiet',
    TriggerChance = 50,                 # Chance of the Unclean Beast triggering the plague
    SpreadAffectChance = 100,           # Chance to affect other units in AffectRadius when triggered, if the hero
    SpreadAffectRadius = 10,            # Radius that units can be affected by plague when triggered
    MaxPlaguedUnits = 30,               # Max number of units that can be plagued at one time by one hero
    OnAbilityAdded = function(self, unit)
        # Setup unit plague instance data if not already
        unit.Plague = {
            NumPlaguedUnits = 0,
            MaxPlaguedUnits = self.MaxPlaguedUnits,
        }

        unit.Callbacks.OnPostDamage:Add(self.Plague, self)
    end,
    Plague = function(self, unit, target, data)
        if Random(1, 100) < self.TriggerChance then
            #LOG("*DEBUG: Applying Initial Plague to: "..target:GetUnitId())

            if unit:IsDead() or IsAlly(target:GetArmy(), unit:GetArmy()) or
               data.DamageAction == 'HEPA01Plague01' or data.DamageAction == 'HEPA01Plague02' or (data.DamageAction and Ability[data.DamageAction].FromItem) then
                return
            end

            if target:IsDead() or EntityCategoryContains(categories.STRUCTURE, target) then
                local targets = unit:GetAIBrain():GetUnitsAroundPoint((categories.MOBILE - categories.UNTARGETABLE), unit:GetPosition(), self.SpreadAffectRadius, 'Enemy')
                PlagueSpread01( unit, targets, self.SpreadAffectChance )
            else
                # Early out on application of plague here, rather than allow the buff system Manage it, to
                # properly track number of affected targets
                if Buff.HasBuff(target, 'HEPA01Plague01') or Buff.HasBuff(target, 'HEPA01PlagueImmune') or Buff.HasBuff(target, 'HEPA01Plague02') then
                    return
                end
                # Create initial triggered plague effects
                self:PlagueEffect( unit, target:GetPosition(), target:GetEffectBuffClassification() )

                # Add affected unit specific plague data
                target.PlagueInstance = {
                    Instigator = unit,
                    InstigatorBrain = unit:GetAIBrain(),
                    IgnoreAffectPulses = true,
                    NumIgnoredPulses = 0,
                }

                FloatTextAt(target:GetFloatTextPosition(), "<LOC floattext_0010>PLAGUE!", 'Plague')
                if(Validate.HasAbility(unit, 'HEPA01Plague02')) then
                    Buff.ApplyBuff(target, 'HEPA01Plague02', unit, unit:GetArmy())
                else
                    Buff.ApplyBuff(target, 'HEPA01Plague01', unit, unit:GetArmy())
                end
            end
        end
    end,
    OnRemoveAbility = function(self, unit)
        unit.Callbacks.OnPostDamage:Remove(self.Plague)
    end,
    PlagueEffect = function( self, unit, targetpos, buffClassification )
        local army = unit:GetArmy()
        local unitpos = table.copy(unit:GetPosition())

        CreateTemplatedEffectAtPos( 'UncleanBeast', 'PlagueInfectedTrigger01', buffClassification, army, targetpos )
    end,
    Icon = '/DGUncleanBeast/NewUncleanPlague01',
}

PlagueSpread01 = function( instigator, targets, chance )
    local instBrain = instigator:GetAIBrain()

    for k, vUnit in targets do
        if instigator:IsDead() or not instigator.Plague then
            return
        end

        if Random(1, 100) < chance then
            if Buff.HasBuff(vUnit, 'HEPA01PlagueImmune') or Buff.HasBuff(vUnit, 'HEPA01Plague02') or Buff.HasBuff(vUnit, 'HEPA01Plague01') then
                continue
            end

            CreateTemplatedEffectAtPos( 'UncleanBeast', 'PlagueInfectedTrigger02', vUnit:GetEffectBuffClassification(), vUnit:GetArmy(), vUnit:GetPosition()  )
            if instBrain then
                local heroes = instBrain:GetListOfUnits(categories.HERO, false)
                if table.getn(heroes) > 0 then

                    #LOG("*DEBUG: Applying Plague from "..instBrain.Name.." and hero ".. heroes[1]:GetUnitId().. " to unit ".. vUnit:GetUnitId())
                    vUnit.PlagueInstance = {
                        Instigator = instigator,
                        InstigatorBrain = instBrain,
                        IgnoreAffectPulses = true,
                        NumIgnoredPulses = 0,
                    }

                    instigator.Plague.NumPlaguedUnits = instigator.Plague.NumPlaguedUnits + 1
                    if(Validate.HasAbility(instigator, 'HEPA01Plague02')) then
                        Buff.ApplyBuff(vUnit, 'HEPA01Plague02', heroes[1], heroes[1]:GetArmy())
                    else
                        Buff.ApplyBuff(vUnit, 'HEPA01Plague01', heroes[1], heroes[1]:GetArmy())
                    end
                    FloatTextAt(vUnit:GetFloatTextPosition(), "<LOC floattext_0011>PLAGUED!", 'Plague')
                    break
                end
            end
        end
    end
end

#################################################################################################################
# Ability - Plague II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01Plague02',
    DisplayName = '<LOC ABILITY_HEPA01_0063>Plague II',
    Description = '<LOC ABILITY_HEPA01_0052>When Unclean Beast deals damage, it has a chance to start a plague, dealing [GetDamageAmt] damage over [GetDuration] seconds and spreading to nearby units.\n\nAnything that survives the plague becomes immune to it for [GetImmuneDuration] seconds.',
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDamageAmt = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * Buffs[self.Name].DurationPulse * -1 ) end,
    GetImmuneDuration = function(self) return math.floor( Buffs['HEPA01PlagueImmune'].Duration ) end,
    AbilityType = 'Quiet',
    TriggerChance = 50,                 # Chance of the Unclean Beast triggering the plague
    SpreadAffectChance = 100,           # Chance to affect other units in AffectRadius when triggered, if the hero
    SpreadAffectRadius = 10,            # Radius that units can be affected by plague when triggered
    MaxPlaguedUnits = 30,               # Max number of units that can be plagued at one time by one hero
    OnAbilityAdded = function(self, unit)
        # Setup unit plague instance data if not already
        unit.Plague = {
            NumPlaguedUnits = 0,
            MaxPlaguedUnits = self.MaxPlaguedUnits,
        }

        unit.Callbacks.OnPostDamage:Add(self.Plague, self)
    end,
    Plague = function(self, unit, target, data)
        if Random(1, 100) < self.TriggerChance then
            #LOG("*DEBUG: Applying Initial Plague to: "..target:GetUnitId())

            if unit:IsDead() or IsAlly(target:GetArmy(), unit:GetArmy()) or data.DamageAction == 'HEPA01Plague02' or (data.DamageAction and Ability[data.DamageAction].FromItem) then
                return
            end

            if target:IsDead() or EntityCategoryContains(categories.STRUCTURE, target) then
                local targets = unit:GetAIBrain():GetUnitsAroundPoint((categories.MOBILE - categories.UNTARGETABLE), unit:GetPosition(), self.SpreadAffectRadius, 'Enemy')
                PlagueSpread02( unit, targets, self.SpreadAffectChance )
            else
                # Early out on application of plague here, rather than allow the buff system Manage it, to
                # properly track number of affected targets
                if Buff.HasBuff(target, 'HEPA01Plague02') or Buff.HasBuff(target, 'HEPA01PlagueImmune') then
                    return
                end

                # Create initial triggered plague effects
                self:PlagueEffect( unit, target:GetPosition(), target:GetEffectBuffClassification() )

                # Add affected unit specific plague data
                target.PlagueInstance = {
                    Instigator = unit,
                    InstigatorBrain = unit:GetAIBrain(),
                    IgnoreAffectPulses = true,
                    NumIgnoredPulses = 0,
                }

                FloatTextAt(target:GetFloatTextPosition(), "<LOC floattext_0012>PLAGUE!", 'Plague')
                if(Validate.HasAbility(unit, 'HEPA01Plague02')) then
                    Buff.ApplyBuff(target, 'HEPA01Plague02', unit, unit:GetArmy())
                else
                    Buff.ApplyBuff(target, 'HEPA01Plague01', unit, unit:GetArmy())
                end
            end
        end
    end,
    OnRemoveAbility = function(self, unit)
        unit.Callbacks.OnPostDamage:Remove(self.Plague)
    end,
    PlagueEffect = function( self, unit, targetpos, buffClassification )
        local army = unit:GetArmy()
        local unitpos = table.copy(unit:GetPosition())

        CreateTemplatedEffectAtPos( 'UncleanBeast', 'PlagueInfectedTrigger01', buffClassification, army, targetpos )
    end,
    Icon = '/DGUncleanBeast/NewUncleanPlague01',
}

PlagueSpread02 = function( instigator, targets, chance )
    local instBrain = instigator:GetAIBrain()

    for k, vUnit in targets do
        if instigator:IsDead() or not instigator.Plague then
            return
        end

        if Random(1, 100) < chance then
            if Buff.HasBuff(vUnit, 'HEPA01Plague02') or Buff.HasBuff(vUnit, 'HEPA01PlagueImmune') then
                continue
            end

            CreateTemplatedEffectAtPos( 'UncleanBeast', 'PlagueInfectedTrigger02', vUnit:GetEffectBuffClassification(), vUnit:GetArmy(), vUnit:GetPosition()  )
            if instBrain then
                local heroes = instBrain:GetListOfUnits(categories.HERO, false)
                if table.getn(heroes) > 0 then

                    #LOG("*DEBUG: Applying Plague from "..instBrain.Name.." and hero ".. heroes[1]:GetUnitId().. " to unit ".. vUnit:GetUnitId())
                    vUnit.PlagueInstance = {
                        Instigator = instigator,
                        InstigatorBrain = instBrain,
                        IgnoreAffectPulses = true,
                        NumIgnoredPulses = 0,
                    }

                    instigator.Plague.NumPlaguedUnits = instigator.Plague.NumPlaguedUnits + 1
                    if(Validate.HasAbility(instigator, 'HEPA01Plague02')) then
                        Buff.ApplyBuff(vUnit, 'HEPA01Plague02', heroes[1], heroes[1]:GetArmy())
                    else
                        Buff.ApplyBuff(vUnit, 'HEPA01Plague01', heroes[1], heroes[1]:GetArmy())
                    end
                    FloatTextAt(vUnit:GetFloatTextPosition(), "<LOC floattext_0013>PLAGUED!", 'Plague')
                    break
                end
            end
        end
    end
end

#################################################################################################################
# Buff - Foul Grasp
#################################################################################################################
BuffBlueprint {
    Name = 'HEPA01FoulGraspStun01',
    DisplayName = '<LOC ABILITY_HEPA01_0043>Foul Grasp',
    Description = '<LOC ABILITY_HEPA01_0044>Stunned.',
    BuffType = 'HEPA01FOULGRASPSTUN',
    Debuff = true,
    Stacks = 'ALWAYS',
    Duration = 2,
    Affects = {
        Stun = {Add = 0},
    },
    Icon = '/DGUncleanBeast/NewUncleanFoulGrasp01',
}

#################################################################################################################
# Foul Grasp I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01FoulGrasp01',
    DisplayName = '<LOC ABILITY_HEPA01_0045>Foul Grasp I',
    Description = '<LOC ABILITY_HEPA01_0046>Unclean Beast clutches a target in its claws, stunning them and draining [GetDamageAmt] life over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 800,
    Cooldown = 15,
    RangeMax = 10,
    Pulses = 4,
    UISlot = 4,
    Amount = 83,
    HotKey = '4',
    GetDuration = function(self) return math.floor( self.Pulses * 0.5 ) end,
    GetDamageAmt = function(self) return math.floor( self.Pulses * self.Amount ) end,
    Icon = '/DGUncleanBeast/NewUncleanFoulGrasp01',
    OnStartAbility = function(self,unit,params)
        local target = params.Targets[1]
        local thd = ForkThread(DrawLife, self, unit, target)
        unit.Trash:Add(thd)
        target.Trash:Add(thd)
        unit.AbilityData.FoulGraspThread = thd
    end,
}

#################################################################################################################
# Foul Grasp II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01FoulGrasp02',
    DisplayName = '<LOC ABILITY_HEPA01_0047>Foul Grasp II',
    Description = '<LOC ABILITY_HEPA01_0046>Unclean Beast clutches a target in its claws, stunning them and draining [GetDamageAmt] life over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 1100,
    Cooldown = 15,
    RangeMax = 10,
    Pulses = 4,
    UISlot = 4,
    HotKey = '4',
    Amount = 125,
    GetDuration = function(self) return math.floor( self.Pulses * 0.5 ) end,
    GetDamageAmt = function(self) return math.floor( self.Pulses * self.Amount ) end,
    Icon = '/DGUncleanBeast/NewUncleanFoulGrasp01',
    OnStartAbility = function(self,unit,params)
        local target = params.Targets[1]
        local thd = ForkThread(DrawLife, self, unit, target)
        unit.Trash:Add(thd)
        target.Trash:Add(thd)
        unit.AbilityData.FoulGraspThread = thd
    end,
}

#################################################################################################################
# Foul Grasp III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01FoulGrasp03',
    DisplayName = '<LOC ABILITY_HEPA01_0064>Foul Grasp III',
    Description = '<LOC ABILITY_HEPA01_0046>Unclean Beast clutches a target in its claws, stunning them and draining [GetDamageAmt] life over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 1400,
    Cooldown = 15,
    RangeMax = 10,
    Pulses = 4,
    UISlot = 4,
    HotKey = '4',
    Amount = 166,
    GetDuration = function(self) return math.floor( self.Pulses * 0.5 ) end,
    GetDamageAmt = function(self) return math.floor( self.Pulses * self.Amount ) end,
    Icon = '/DGUncleanBeast/NewUncleanFoulGrasp01',
    OnStartAbility = function(self,unit,params)
        local target = params.Targets[1]
        local thd = ForkThread(DrawLife, self, unit, target)
        unit.Trash:Add(thd)
        target.Trash:Add(thd)
        unit.AbilityData.FoulGraspThread = thd
    end,
}
#################################################################################################################
# CE - Foul Grasp
#################################################################################################################
DrawLife = function(def, unit, target)
    unit:GetWeapon(1):SetStayOnTarget(true)

    # Add callbacks so we can interrupt Grasp
    unit.Callbacks.OnWeaponFire:Add(EndGrasp, def)
    unit.Callbacks.OnKilled:Add(EndGrasp, def)
    unit.Callbacks.OnStunned:Add(EndGrasp, def)
    unit.Callbacks.OnFrozen:Add(EndGrasp, def)
    target.Callbacks.OnKilled:Add(EndGrasp, def)
    unit.Callbacks.OnAbilityBeginCast:Add(EndGraspCancel)

    Buff.ApplyBuff(unit, 'StayOnTarget', unit)
    Buff.ApplyBuff(target, 'WeaponDisable', unit, unit:GetArmy())
    Buff.ApplyBuff(unit, 'WeaponDisable', unit)
    target:GetNavigator():AbortMove()
    if target.Character then
        target.Character:AbortCast()
    end
    Buff.ApplyBuff(target, 'Immobile', unit, unit:GetArmy())
    Buff.ApplyBuff(target, 'HEPA01FoulGraspStun01', unit, unit:GetArmy())

    unit:GetNavigator():AbortMove()
    Buff.ApplyBuff(unit, 'Immobile', unit)

    unit.AbilityData.FoulGraspTarget = target
    
    WaitSeconds(0.1)
    unit.Character:PlayAction('CastFoulGraspStart')
    if not unit:IsDead() then
        unit.Callbacks.OnMotionHorzEventChange:Add(Moved, def)
    end
    WaitSeconds(0.3)

    # create Foul Grasp effects at target with a vector towards the Unclean Beast.
    local unitpos = table.copy(unit:GetPosition())
    unitpos[2] = unitpos[2]+3
    local dir = VDiff(unitpos,target:GetPosition())
    local dist = VLength( dir )
    local dirNorm = VNormal(dir)
    dirNorm[2] = dirNorm[2]/2
    local unitbp = target:GetBlueprint()
    local unitheight = unitbp.SizeY * 0.9
    local unitwidth = (unitbp.SizeX + unitbp.SizeZ) / 2.5
    local unitVol = (unitbp.SizeX + unitbp.SizeZ + unitheight) / 3
    local army = unit:GetArmy()

    local fx1 = EffectTemplates.UncleanBeast.FoulGrasp01
    local fx2 = EffectTemplates.UncleanBeast.FoulGrasp02
    local fx3 = EffectTemplates.UncleanBeast.FoulGrasp05
    unit.AbilityData.FoulGraspEffects = {}
    # Brown multiply wisps
    for k, v in fx1 do
        emit = CreateAttachedEmitter( target, -2, army, v )
        emit:SetEmitterCurveParam('EMITRATE_CURVE', unitVol*1.7, 0.0)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist, dist*0.45)
        emit:SetEmitterCurveParam('XDIR_CURVE', dirNorm[1], 0.3)
        emit:SetEmitterCurveParam('YDIR_CURVE', dirNorm[2], 0.0)
        emit:SetEmitterCurveParam('ZDIR_CURVE', dirNorm[3], 0.3)
        emit:SetEmitterCurveParam('X_POSITION_CURVE', 0.0, unitwidth)
        emit:SetEmitterCurveParam('Y_POSITION_CURVE', unitheight*0.4, unitheight)
        emit:SetEmitterCurveParam('Z_POSITION_CURVE', 0.0, unitwidth)
        table.insert( unit.AbilityData.FoulGraspEffects, emit )
    end
    # Dark red blood
    for k, v in fx2 do
        emit = CreateAttachedEmitter( target, -2, army, v )
        emit:SetEmitterCurveParam('EMITRATE_CURVE', unitVol*3.0, 0.0)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist*0.6, dist*0.2)
        emit:SetEmitterCurveParam('XDIR_CURVE', dirNorm[1], 0.3)
        emit:SetEmitterCurveParam('ZDIR_CURVE', dirNorm[3], 0.3)
        emit:SetEmitterCurveParam('X_POSITION_CURVE', 0.0, unitwidth)
        emit:SetEmitterCurveParam('Y_POSITION_CURVE', unitheight*0.4, unitheight)
        emit:SetEmitterCurveParam('Z_POSITION_CURVE', 0.0, unitwidth)
        table.insert( unit.AbilityData.FoulGraspEffects, emit )
    end
    # Healing wisps on Unclean Beast
    AttachEffectsAtBone( unit, EffectTemplates.UncleanBeast.FoulGrasp03, -2, nil, nil, nil, unit.AbilityData.FoulGraspEffects )
    # Blood along the ground
    AttachEffectsAtBone( unit, EffectTemplates.UncleanBeast.FoulGrasp04, -2, nil, nil, nil, unit.AbilityData.FoulGraspEffects )
    # Inward rings at target
    for k, v in fx3 do
        emit = CreateAttachedEmitter( target, -2, army, v )
        emit:SetEmitterCurveParam('BEGINSIZE_CURVE', unitwidth*2.0, unitwidth)
        table.insert( unit.AbilityData.FoulGraspEffects, emit )
    end

    local data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = unit:GetArmy(),
        Type = 'Spell',
        DamageAction = def.Name,
        Radius = 0,
        DamageSelf = true,
        DamageFriendly = true,
        ArmorImmune = true,
        CanBackfire = false,
        CanBeEvaded = false,
        CanCrit = false,
        CanDamageReturn = false,
        CanMagicResist = false,
        CanOverKill = true,
        IgnoreDamageRangePercent = true,
        Group = "UNITS",
    }

    for i = 1, def.Pulses do
        if not target:IsDead() and not unit:IsDead() and not unit.Silenced then
            Leech( unit, target, data, def.Amount )
            WaitSeconds(0.5)
        else
            EndGrasp(def, unit, target)
        end
    end
    EndGrasp(def, unit, target)
end

function Moved(def, unit, new, old)
    if new != 'Stopping' and new != 'Stopped' then
        EndGrasp(def, unit)
    end
end

function EndGrasp(def, unit)
    #LOG("*DEBUG: Ending foul grasp")
    unit.Callbacks.OnWeaponFire:Remove(EndGrasp)
    unit.Callbacks.OnKilled:Remove(EndGrasp)
    unit.Callbacks.OnStunned:Remove(EndGrasp)
    unit.Callbacks.OnFrozen:Remove(EndGrasp)
    unit.Callbacks.OnMotionHorzEventChange:Remove(Moved)
    unit.Callbacks.OnAbilityBeginCast:Remove(EndGraspCancel)

    local target = unit.AbilityData.FoulGraspTarget
    if target and not target:IsDead() then
        Buff.RemoveBuff(target, 'Immobile')
        Buff.RemoveBuff(target, 'HEPA01FoulGraspStun01')
        if Buff.HasBuff(target, 'WeaponDisable') then
            Buff.RemoveBuff(target, 'WeaponDisable')
        end
        target.Callbacks.OnKilled:Remove(EndGrasp)
    end

    if unit.AbilityData.FoulGraspEffects then
        for kEffect, vEffect in unit.AbilityData.FoulGraspEffects do
            vEffect:Destroy()
        end
        unit.AbilityData.FoulGraspEffects = nil
    end

    if unit.AbilityData.FoulGraspThread then
        unit.AbilityData.FoulGraspThread:Destroy()
        unit.AbilityData.FoulGraspThread = nil
    end
    if Buff.HasBuff(unit, 'WeaponDisable') then
        Buff.RemoveBuff(unit, 'WeaponDisable')
    end
    if Buff.HasBuff(unit, 'StayOnTarget') then
        Buff.RemoveBuff(unit, 'StayOnTarget', unit)
        #Lets make sure that the last instance of the buff is removed
        if not Buff.HasBuff(unit, 'StayOnTarget') then
            unit:GetWeapon(1):SetStayOnTarget(false)
        end
    end

    Buff.RemoveBuff(unit, 'Immobile')
    unit.Character:PlayAction('CastFoulGraspEnd')
end

function EndGraspCancel(def, unit)
    #LOG("*DEBUG: Ending foul grasp")
    unit.Callbacks.OnWeaponFire:Remove(EndGrasp)
    unit.Callbacks.OnKilled:Remove(EndGrasp)
    unit.Callbacks.OnStunned:Remove(EndGrasp)
    unit.Callbacks.OnFrozen:Remove(EndGrasp)
    unit.Callbacks.OnMotionHorzEventChange:Remove(Moved)
    unit.Callbacks.OnAbilityBeginCast:Remove(EndGraspCancel)

    local target = unit.AbilityData.FoulGraspTarget
    if target and not target:IsDead() then
        Buff.RemoveBuff(target, 'Immobile')
        Buff.RemoveBuff(target, 'HEPA01FoulGraspStun01')
        if Buff.HasBuff(target, 'WeaponDisable') then
            Buff.RemoveBuff(target, 'WeaponDisable')
        end
        target.Callbacks.OnKilled:Remove(EndGrasp)
    end

    if unit.AbilityData.FoulGraspEffects then
        for kEffect, vEffect in unit.AbilityData.FoulGraspEffects do
            vEffect:Destroy()
        end
        unit.AbilityData.FoulGraspEffects = nil
    end

    if unit.AbilityData.FoulGraspThread then
        unit.AbilityData.FoulGraspThread:Destroy()
        unit.AbilityData.FoulGraspThread = nil
    end
    if Buff.HasBuff(unit, 'WeaponDisable') then
        Buff.RemoveBuff(unit, 'WeaponDisable')
    end
    if Buff.HasBuff(unit, 'StayOnTarget') then
        Buff.RemoveBuff(unit, 'StayOnTarget', unit)
        #Lets make sure that the last instance of the buff is removed
        if not Buff.HasBuff(unit, 'StayOnTarget') then
            unit:GetWeapon(1):SetStayOnTarget(false)
        end
    end

    Buff.RemoveBuff(unit, 'Immobile')
    unit.Character:PlayAction('CastFoulGraspEnd')
end

#################################################################################################################
# VFX - Aftermath
#################################################################################################################
function FxAftermathEntity( unit, pos, segments, radius, EmitterIds )
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
            local emitters = CreateTemplatedEffectAtPos( 'UncleanBeast', nil, 'AfterMath01', unit:GetArmy(), Vector(pos[1] + x,pos[2],pos[3]+z), Vector(x, 0, z) )
            for k, v in emitters do
                table.insert( EmitterIds, v )
            end
        end
    end
end

function AfterMathTendrils( projEnt, pos )
    local num_projectiles = 10

    for i = 1,num_projectiles do
        local horizontal_angle = (2*math.pi) / num_projectiles
        local angleInitial = GetRandomFloat( 0, horizontal_angle )
        local xVec, yVec, zVec
        local angleVariation = 0.5
        local px, py, pz

        xVec = math.sin(angleInitial + (i*horizontal_angle) + GetRandomFloat(-angleVariation, angleVariation) )
        yVec = GetRandomFloat( 0.5, 2.0 )
        zVec = math.cos(angleInitial + (i*horizontal_angle) + GetRandomFloat(-angleVariation, angleVariation) )
        px = GetRandomFloat( 0.5, 1.5 ) * xVec
        py = GetRandomFloat( 1.0, 2.0 ) * yVec
        pz = GetRandomFloat( 0.5, 1.5 ) * zVec

        local proj = projEnt:CreateProjectile( '/projectiles/AfterMathEffect01/AfterMathEffect01_proj.bp', px, py, pz, xVec, yVec, zVec )
        local velocity = GetRandomFloat( 5, 15 )
        proj:SetVelocity( velocity )
        proj:SetBallisticAcceleration( -velocity * 0.6 )
        proj:SetLifetime( velocity * 0.8 )

        WaitSeconds( 0.1 )
    end
end

function Aftermath(adef, unit )
    local pos = table.copy(unit:GetPosition())
    pos[2] = 100
    local army = unit:GetArmy()

    ## Landing splat effects.
    WaitSeconds(0.6)
    AttachEffectsAtBone( unit, EffectTemplates.UncleanBeast.EpicDeath01, -2 )

    ## After landing, start spraying ooze.
    local FxBones = {
        'sk_Unclean_Beast_RightShoulder',
        'sk_Unclean_Beast_LeftShoulder',
        'sk_Unclean_Beast_Spine04',
        'sk_Unclean_Beast_Spine02',
        'sk_Unclean_Beast_RightElbow',
        'sk_Unclean_Beast_LeftElbow',
        'sk_Unclean_Beast_Head',
    }
    AttachCharacterEffectsAtBones( unit, 'unclean_beast', 'EpicDeath02', FxBones )

    local AftermathEffects = {}

    ## Explosion ooze tendrils
    local projEnt = Entity{ Owner = army }
    Warp(projEnt, pos)
    table.insert( AftermathEffects, projEnt )


    ForkThread(AfterMathTendrils, projEnt, pos )

    ## Start playing the ground decal ooze prior to explosion since it takes time to fade in.
    WaitSeconds(1.6)

    FxAftermathEntity ( unit, pos, 11, 7, AftermathEffects )
    FxAftermathEntity ( unit, pos, 9, 5, AftermathEffects )
    FxAftermathEntity ( unit, pos, 5, 3, AftermathEffects )

    local emitters = CreateTemplatedEffectAtPos( 'UncleanBeast', nil, 'AfterMathCenter01', army, pos )
    for k, v in emitters do
        table.insert( AftermathEffects, v )
    end

    ## Final explosion effect
    WaitSeconds(1.0)
    CreateTemplatedEffectAtPos( 'UncleanBeast', nil, 'EpicDeath03', army, pos )

    local data = table.copy(adef.Damage)
    data.Instigator = unit
    data.InstigatorBp = unit:GetBlueprint()
    data.InstigatorArmy = army
    data.Origin = pos
    data.DamageAction = adef.Name
    data.Amount = adef.DamageAmt
    for i = 1, adef.Pulses do
        #LOG("*DEBUG: DamageArea Origin: ", repr(data.Origin))
        DamageArea(data)
        WaitSeconds(adef.PulseDuration)
    end

    if AftermathEffects then
        for kEffect, vEffect in AftermathEffects do
            vEffect:Destroy()
        end
    end
end

#################################################################################################################
# Epic Death
#################################################################################################################
AbilityBlueprint {
    Name = 'HEPA01Death01',
    DisplayName = 'Death',
    Description = 'Unclean Beast death functional ability',
    AbilityType = 'Quiet',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    NoCastAnim = true,
    PulseDuration = 1,
    Pulses = 15,
    DamageAmt = 20,
    Damage = {
        Radius = 9,
        Type = 'Spell',
        DamageSelf = false,
        CanBeEvaded = false,
        CanBackfire = false,
        CanDamageReturn = false,
        DamageFriendly = false,
        ArmorImmune = true,
        CanCrit = false,
        CanMagicResist = true,
        Group = "UNITS",
    },
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnKilled:Add(self.Death, self)
    end,
    Death = function(self, unit)
        ForkThread(Aftermath, self, unit )
    end,
}

#################################################################################################################
# Ability Keys and Icons
#################################################################################################################
AbilityBlueprint {
    Name = 'HUncleanVenomSpitGrey01',
    DisplayName = '<LOC ABILITY_HEPA01_0008>Venom Spit I',
    Description = '<LOC ABILITY_HEPA01_0009>Spews a corrosive venom at its target, dealing [GetInitialDamage] damage and an additional [GetDebuffDamage] damage over [GetDebuffDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 1,
    HotKey = '1',
    GetMaxRange = function(self) return Ability['HEPA01VenomSpit01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HEPA01VenomSpit01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEPA01VenomSpit01'].CastingTime end,
    GetCooldown = function(self) return Ability['HEPA01VenomSpit01'].Cooldown end,
    GetInitialDamage = function(self) return math.floor( Ability['HEPA01VenomSpit01'].DamageAmt ) end,
    GetDebuffDamage = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT01'].Affects.Health.Add * Buffs['HEPA01VenomSpitDoT01'].DurationPulse * -1 ) end,
    GetDebuffDuration = function(self) return math.floor( Buffs['HEPA01VenomSpitDoT01'].DurationPulse ) end,
    NoCastAnim = true,
    Placeholder = true,
    Icon = '/DGUncleanBeast/NewUncleanVenomSpit01',
}

AbilityBlueprint {
    Name = 'HUncleanBestialWrathGrey01',
    DisplayName = '<LOC ABILITY_HEPA01_0023>Bestial Wrath I',
    Description = '<LOC ABILITY_HEPA01_0024>Unclean Beast enters a frenzy for [GetDuration] seconds.\n\nWeapon Damage increased by [GetDamageBuff]%.',
    AbilityType = 'Passive',
    TargetAlliance = 'Ally',
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HEPA01BestialWrath01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HEPA01BestialWrath01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEPA01BestialWrath01'].CastingTime end,
    GetCooldown = function(self) return Ability['HEPA01BestialWrath01'].Cooldown end,
    GetDuration = function(self) return math.floor( Buffs['HEPA01BestialWrath01'].Duration ) end,
    GetDamageBuff = function(self) return math.floor( Buffs['HEPA01BestialWrath01'].Affects.DamageRating.Mult * 100 ) end,
    Icon = '/DGUncleanBeast/NewUncleanBestialWrath01',
}

AbilityBlueprint {
    Name = 'HUncleanOozeGrey01',
    DisplayName = '<LOC ABILITY_HEPA01_0014>Ooze',
    Description = '<LOC ABILITY_HEPA01_0049>Unclean Beast oozes virulent bodily fluids. While active, nearby enemies take [GetDebuffDamage] damage per second and their Attack Speed is slowed by [GetDebuffSlow]%.\n\nUnclean Beast loses [GetDebuffSelfDamage] Health per second.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HEPA01OozeOn'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HEPA01OozeOn'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEPA01OozeOn'].CastingTime end,
    GetCooldown = function(self) return Ability['HEPA01OozeOn'].Cooldown end,
    GetDebuffDamage = function(self) return math.floor( Buffs['HEPA01Ooze01'].Affects.Health.Add * -1 ) end,
    GetDebuffSlow = function(self) return math.floor( Buffs['HEPA01Ooze01'].Affects.RateOfFire.Mult * -100 ) end,
    GetDebuffSelfDamage = function(self) return math.floor( Buffs['HEPA01OozeSelf01'].Affects.Health.Add * -1 ) end,
    Icon = '/DGUncleanBeast/NewUncleanBeastOoze01',
}

AbilityBlueprint {
    Name = 'HUncleanFoulGraspGrey01',
    DisplayName = '<LOC ABILITY_HEPA01_0045>Foul Grasp I',
    Description = '<LOC ABILITY_HEPA01_0046>Unclean Beast clutches a target in its claws, stunning them and draining [GetDamageAmt] life over [GetDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 4,
    HotKey = '4',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HEPA01FoulGrasp01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HEPA01FoulGrasp01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEPA01FoulGrasp01'].CastingTime end,
    GetCooldown = function(self) return Ability['HEPA01FoulGrasp01'].Cooldown end,
    GetDuration = function(self) return math.floor( Ability['HEPA01FoulGrasp01'].Pulses * 0.5 ) end,
    GetDamageAmt = function(self) return math.floor( Ability['HEPA01FoulGrasp01'].Pulses * Ability['HEPA01FoulGrasp01'].Amount ) end,
    Icon = '/DGUncleanBeast/NewUncleanFoulGrasp01',
}

__moduleinfo.auto_reload = true
