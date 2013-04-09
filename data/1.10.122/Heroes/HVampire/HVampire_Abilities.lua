local Abil = import('/lua/sim/ability.lua')
local Buff = import('/lua/sim/buff.lua')
local Entity = import('/lua/sim/entity.lua').Entity
local Utils = import('/lua/utilities.lua')
local Validate = import('/lua/common/ValidateAbility.lua')
local GetRandomFloat = Utils.GetRandomFloat

#################################################################################################################
# Bat Swarm I
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireBatSwarm01',
    DisplayName = '<LOC ABILITY_Vampire_0000>Bat Swarm I',
    Description = '<LOC ABILITY_Vampire_0001>Lord Erebus transforms into a swarm of bats, teleporting him to a new location and doing [GetDamageAmt] damage to everything in his path. Range of [GetRange].',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',                   # TargetAlliance and TargetCategory aren't really used with this ability, but the fields are needed so Ability.lua doesn't error out.
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetRange = function(self) return math.floor( self.RangeMax ) end,
    RangeMax = 20,
    Cooldown = 15,
    EnergyCost = 750,
    AffectRadius = 4,
    DamageAmt = 300,
    DamageRadius = 3,
    DamageType = 'Spell',
    MetaImpactAmount = 7,
    MetaImpactRadius = 3,
    MetaImpactDamageFriendly = false,
    UISlot = 4,
    HotKey = '4',
    CastAction = 'Bats',
    CastingTime = 0.1,
    MaterializeWarpDelay = 0.2,
    ErrorMessage = '<LOC error_0045>Cannot move there.',
    ErrorVO = 'Nomove',
    AbilityCategory = 'HVAMPIREMISTOFF',
    OnStartAbility = function(self, unit, params)
        ForkThread(BatSwarm, self, unit, params)
    end,
    OnAbortAbility = function(self, unit)
        Buff.RemoveBuff(unit, 'HVampireBatSwarm01')
        Buff.RemoveBuff(unit, 'Immobile')
    end,
    Icon = '/DGVamplord/NewVamplordBatSwarm01',
    Reticule = 'AoE_Bat_Swarm'
}

#################################################################################################################
# Bat Swarm II
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireBatSwarm02',
    DisplayName = '<LOC ABILITY_Vampire_0002>Bat Swarm II',
    Description = '<LOC ABILITY_Vampire_0001>Lord Erebus transforms into a swarm of bats, teleporting him to a new location and doing [GetDamageAmt] damage to everything in his path. Range of [GetRange].',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',                   # TargetAlliance and TargetCategory aren't really used with this ability, but the fields are needed so Ability.lua doesn't error out.
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetRange = function(self) return math.floor( self.RangeMax ) end,
    RangeMax = 30,
    Cooldown = 15,
    EnergyCost = 925,
    AffectRadius = 4,
    DamageAmt = 450,
    DamageRadius = 3,
    DamageType = 'Spell',
    MetaImpactAmount = 7,
    MetaImpactRadius = 3,
    MetaImpactDamageFriendly = false,
    UISlot = 4,
    HotKey = '4',
    CastAction = 'Bats',
    CastingTime = 0.1,
    MaterializeWarpDelay = 0.2,
    ErrorMessage = '<LOC error_0046>Cannot move there.',
    ErrorVO = 'Nomove',
    AbilityCategory = 'HVAMPIREMISTOFF',
    OnStartAbility = function(self, unit, params)
        ForkThread(BatSwarm, self, unit, params)
    end,
    OnAbortAbility = function(self, unit)
        Buff.RemoveBuff(unit, 'HVampireBatSwarm01')
        Buff.RemoveBuff(unit, 'Immobile')
    end,
    Icon = '/DGVamplord/NewVamplordBatSwarm01',
    Reticule = 'AoE_Bat_Swarm',
}

#################################################################################################################
# Bat Swarm III
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireBatSwarm03',
    DisplayName = '<LOC ABILITY_Vampire_0100>Bat Swarm III',
    Description = '<LOC ABILITY_Vampire_0001>Lord Erebus transforms into a swarm of bats, teleporting him to a new location and doing [GetDamageAmt] damage to everything in his path. Range of [GetRange].',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',                   # TargetAlliance and TargetCategory aren't really used with this ability, but the fields are needed so Ability.lua doesn't error out.
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetRange = function(self) return math.floor( self.RangeMax ) end,
    RangeMax = 30,
    Cooldown = 15,
    EnergyCost = 1275,
    AffectRadius = 4,
    DamageAmt = 600,
    DamageRadius = 3,
    DamageType = 'Spell',
    MetaImpactAmount = 7,
    MetaImpactRadius = 3,
    MetaImpactDamageFriendly = false,
    UISlot = 4,
    HotKey = '4',
    CastAction = 'Bats',
    CastingTime = 0.1,
    MaterializeWarpDelay = 0.2,
    ErrorMessage = '<LOC error_0047>Cannot move there.',
    ErrorVO = 'Nomove',
    AbilityCategory = 'HVAMPIREMISTOFF',
    OnStartAbility = function(self, unit, params)
        ForkThread(BatSwarm, self, unit, params)
    end,
    OnAbortAbility = function(self, unit)
        Buff.RemoveBuff(unit, 'HVampireBatSwarm01')
        Buff.RemoveBuff(unit, 'Immobile')
    end,
    Icon = '/DGVamplord/NewVamplordBatSwarm01',
    Reticule = 'AoE_Bat_Swarm',
}
#################################################################################################################
# Buff - Bat Swarm
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireBatSwarm01',
    Debuff = false,
    BuffType = 'HVAMPIREBATSWARM',
    EntityCategory = 'MAKEVAMPIRES',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Cloak = {Bool = true},
        DisableAbilityUse = {Bool = true},
    },
}

#################################################################################################################
# VFX - Bat Swarm
#################################################################################################################
function FxBatSwarm( army, startPos, endPos, dir )
    local dist = VLength( dir )
    dir = VNormal(dir)

    # dark wisps
    for k, v in EffectTemplates.VampireLord.Batswarm01 do
        local emit = CreateEmitterPositionVector(startPos, dir, -1, v)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist * 0.3, 0.0)
    end

    # pho bats
    for k, v in EffectTemplates.VampireLord.Batswarm02 do
        local emit = CreateEmitterPositionVector(startPos, dir, -1, v)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist * 0.345, 0.0)
    end

    for k, v in EffectTemplates.VampireLord.Batswarm03 do
        local emit = CreateEmitterPositionVector(startPos, dir, -1, v)
        emit:SetEmitterParam('LIFETIME', dist * 0.266 )
    end

    # Create launch effects at start point
    for k, v in EffectTemplates.VampireLord.BatDeMaterialize01 do
        local emit = CreateEmitterPositionVector(startPos, dir, -1, v)
    end
end

MaterializeThread = function( unit )
    unit:AddEffectMeshState( 'Materialize', string.lower(unit.Character.CharBP.Meshes.Materialize), true, true )
    unit:SetAuxMeshParam( GetGameTimeSeconds() * 10 )
    WaitSeconds( 2.6 )
    unit:RemoveEffectMeshState( 'Materialize', true )
end

#################################################################################################################
# CE - Bat Swarm
#################################################################################################################
function BatSwarm(abilityDef, unit, params)
    # Destroy Vampiric Aura ambient effects
    unit:DestroyAmbientEffects()
    unit:ForkThread( MaterializeThread )

    unit:GetNavigator():AbortMove()
    unit:SetWeaponsDoNotTarget(true)
    Buff.ApplyBuff(unit, 'Immobile', unit)
    Buff.ApplyBuff(unit, 'HVampireBatSwarm01', unit)

    local instigatorBp = unit:GetBlueprint()
    local instigatorArmy = unit:GetArmy()

    local data = {
        Instigator = unit,
        InstigatorBp = instigatorBp,
        InstigatorArmy = instigatorArmy,
        Amount = abilityDef.DamageAmt,
        Type = abilityDef.DamageType,
        DamageAction = abilityDef.Name,
        Radius = abilityDef.DamageRadius,
        DamageFriendly = false,
        DamageSelf = false,
        Group = 'UNITS',
        CanBeEvaded = false,
        CanCrit = false,
        CanBackfire = false,
        CanDamageReturn = false,
        CanMagicResist = true,
        ArmorImmune = true,
    }

    local metaData = {
        Instigator = unit,
        InstigatorBp = instigatorBp,
        InstigatorArmy = instigatorArmy,
        Radius = abilityDef.MetaImpactRadius,
        Amount = abilityDef.MetaImpactAmount,
        Origin = unit.Position,
        Category = 'METAINFANTRY',
        DamageFriendly = abilityDef.MetaImpactDamageFriendly,
    }

    local startPos = unit:GetPosition()
    local endPos = params.Target.Position

    local xDiff = math.abs(startPos[1] - endPos[1])
    local zDiff = math.abs(startPos[3] - endPos[3])

    local numDamageAreas = 1
    if(xDiff > zDiff) then
        numDamageAreas = math.ceil(xDiff/abilityDef.DamageRadius)
    else
        numDamageAreas = math.ceil(zDiff/abilityDef.DamageRadius)
    end

    local xValue = xDiff/numDamageAreas
    local zValue = zDiff/numDamageAreas
    local damagePos = {0, 100, 0}
    local impactedEntities = GetEntitiesInSweptSphere( data.Group, startPos, endPos, abilityDef.DamageRadius )
    impactedEntities = EntityCategoryFilterDown( categories.ALLUNITS - categories.UNTARGETABLE, impactedEntities )
    MetaImpact(metaData, impactedEntities)
    for k,v in impactedEntities do
        DealDamage(data, v)
    end

    # Create bat swarm effects
    local dir = VDiff(endPos,startPos)
    FxBatSwarm(unit:GetArmy(), startPos, endPos, dir)

    WaitSeconds(abilityDef.MaterializeWarpDelay)

    # Create effects at end point
    for k, v in EffectTemplates.VampireLord.BatMaterialize01 do
        local emit = CreateEmitterPositionVector(endPos, dir, -1, v)
    end

    Warp(unit, endPos)

    unit:SetWeaponsDoNotTarget(false)
    Buff.RemoveBuff(unit, 'HVampireBatSwarm01')
    # This is a temp fix for Mist turning on when the bat swarm ability enable is removed.
    MistFunctionalityEnd(unit)
    Buff.RemoveBuff(unit, 'Immobile')

    # Re-Create Vampiric Aura ambient effects
    unit:CreateAmbientEffects()
end

#################################################################################################################
# Bite I
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireBite01',
    DisplayName = '<LOC ABILITY_Vampire_0004>Bite I',
    Description = '<LOC ABILITY_Vampire_0005>Lord Erebus bites a target, draining [GetAmount] Health. For [GetDuration] seconds after the bite, the target\'s Armor is reduced by [GetArmorBuff] and Movement Speed is decreased by [GetMovementBuff]%.',
    GetAmount = function(self) return math.floor( self.Amount ) end,
    GetDuration = function(self) return math.floor( Buffs['HVampireBiteTarget01'].Duration ) end,
    GetMovementBuff = function(self) return math.floor( Buffs['HVampireBiteTarget01'].Affects.MoveMult.Mult * -100 ) end,
    GetArmorBuff = function(self) return math.floor( Buffs['HVampireBiteTarget01'].Affects.Armor.Add * -1 ) end,
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 350,
    Cooldown = 7,
    RangeMax = 8,
    Amount = 250,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'Bite',
    CastingTime = 0,
    FollowThroughTime = 1.0,
    TargetBuff = 'HVampireBiteTarget01',
    AbilityCategory = 'HVAMPIREMISTOFF',
    Icon = '/DGVampLord/NewVamplordBite01',
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireBiteTarget01',
            DisplayName = '<LOC ABILITY_Vampire_0006>Bite',
            Description = '<LOC ABILITY_Vampire_0007>Armor and Movement Speed reduced.',
            BuffType = 'HVAMPIREBITETARGET',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'ALWAYS',
            Duration = 3,
            DamageSelf = true,
            CanBeEvaded = false,
            CanBackfire = false,
            DamageFriendly = true,
            ArmorImmune = true,
            CanCrit = false,
            CanMagicResist = false,
            IgnoreDamageRangePercent = true,
            Affects = {
                Armor = {Add = -250},
                MoveMult = {Mult = -0.15},
            },
            Icon = '/DGVampLord/NewVamplordBite01',
        },
    },
    OnStartAbility = function(self, unit, params)
        Bite(self, unit, params)
    end,
}

#################################################################################################################
# Bite II
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireBite02',
    DisplayName = '<LOC ABILITY_Vampire_0008>Bite II',
    Description = '<LOC ABILITY_Vampire_0005>Lord Erebus bites a target, draining [GetAmount] Health. For [GetDuration] seconds after the bite, the target\'s Armor is reduced by [GetArmorBuff] and Movement Speed is decreased by [GetMovementBuff]%.',
    GetAmount = function(self) return math.floor( self.Amount ) end,
    GetDuration = function(self) return math.floor( Buffs['HVampireBiteTarget02'].Duration ) end,
    GetMovementBuff = function(self) return math.floor( Buffs['HVampireBiteTarget02'].Affects.MoveMult.Mult * -100 ) end,
    GetArmorBuff = function(self) return math.floor( Buffs['HVampireBiteTarget02'].Affects.Armor.Add * -1 ) end,
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 500,
    Cooldown = 7,
    RangeMax = 8,
    Amount = 425,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'Bite',
    CastingTime = 0,
    FollowThroughTime = 1.0,
    TargetBuff = 'HVampireBiteTarget02',
    AbilityCategory = 'HVAMPIREMISTOFF',
    Icon = '/DGVampLord/NewVamplordBite01',
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireBiteTarget02',
            DisplayName = '<LOC ABILITY_Vampire_0006>Bite',
            Description = '<LOC ABILITY_Vampire_0007>Armor and Movement Speed reduced.',
            BuffType = 'HVAMPIREBITETARGET',
            Stacks = 'ALWAYS',
            Duration = 3,
            DamageSelf = true,
            Debuff = true,
            CanBeDispelled = true,
            CanBeEvaded = false,
            CanBackfire = false,
            DamageFriendly = true,
            ArmorImmune = true,
            CanCrit = false,
            CanMagicResist = false,
            IgnoreDamageRangePercent = true,
            Affects = {
                Armor = {Add = -400},
                MoveMult = {Mult = -0.20},
            },
            Icon = '/DGVampLord/NewVamplordBite01',
        },
    },
    OnStartAbility = function(self, unit, params)
        Bite(self, unit, params)
    end,
}

#################################################################################################################
# Bite III
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireBite03',
    DisplayName = '<LOC ABILITY_Vampire_0010>Bite III',
    Description = '<LOC ABILITY_Vampire_0005>Lord Erebus bites a target, draining [GetAmount] Health. For [GetDuration] seconds after the bite, the target\'s Armor is reduced by [GetArmorBuff] and Movement Speed is decreased by [GetMovementBuff]%.',
    GetAmount = function(self) return math.floor( self.Amount ) end,
    GetDuration = function(self) return math.floor( Buffs['HVampireBiteTarget03'].Duration ) end,
    GetMovementBuff = function(self) return math.floor( Buffs['HVampireBiteTarget03'].Affects.MoveMult.Mult * -100 ) end,
    GetArmorBuff = function(self) return math.floor( Buffs['HVampireBiteTarget03'].Affects.Armor.Add * -1 ) end,
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 650,
    Cooldown = 7,
    RangeMax = 8,   # Uses the same range as his melee weapon
    Amount = 600,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'Bite',
    CastingTime = 0,
    FollowThroughTime = 1.0,
    AbilityCategory = 'HVAMPIREMISTOFF',
    Icon = '/DGVampLord/NewVamplordBite01',
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireBiteTarget03',
            DisplayName = '<LOC ABILITY_Vampire_0006>Bite',
            Description = '<LOC ABILITY_Vampire_0007>Armor and Movement Speed reduced.',
            BuffType = 'HVAMPIREBITETARGET',
            Stacks = 'ALWAYS',
            Duration = 3,
            DamageSelf = true,
            Debuff = true,
            CanBeDispelled = true,
            CanBeEvaded = false,
            CanBackfire = false,
            DamageFriendly = true,
            ArmorImmune = true,
            CanCrit = false,
            CanMagicResist = false,
            IgnoreDamageRangePercent = true,
            Affects = {
                Armor = {Add = -550},
                MoveMult = {Mult = -0.25},
            },
            Icon = '/DGVampLord/NewVamplordBite01',
        },
    },
    OnStartAbility = function(self, unit, params)
        Bite(self, unit, params)
    end,
}

#################################################################################################################
# Bite IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireBite04',
    DisplayName = '<LOC ABILITY_Vampire_0102>Bite IV',
    Description = '<LOC ABILITY_Vampire_0005>Lord Erebus bites a target, draining [GetAmount] Health. For [GetDuration] seconds after the bite, the target\'s Armor is reduced by [GetArmorBuff] and Movement Speed is decreased by [GetMovementBuff]%.',
    GetAmount = function(self) return math.floor( self.Amount ) end,
    GetDuration = function(self) return math.floor( Buffs['HVampireBiteTarget04'].Duration ) end,
    GetMovementBuff = function(self) return math.floor( Buffs['HVampireBiteTarget04'].Affects.MoveMult.Mult * -100 ) end,
    GetArmorBuff = function(self) return math.floor( Buffs['HVampireBiteTarget04'].Affects.Armor.Add * -1 ) end,
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 800,
    Cooldown = 7,
    RangeMax = 8,   # Uses the same range as his melee weapon
    Amount = 775,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'Bite',
    CastingTime = 0,
    FollowThroughTime = 1.0,
    AbilityCategory = 'HVAMPIREMISTOFF',
    Icon = '/DGVampLord/NewVamplordBite01',
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireBiteTarget04',
            DisplayName = '<LOC ABILITY_Vampire_0006>Bite',
            Description = '<LOC ABILITY_Vampire_0007>Armor and Movement Speed reduced.',
            BuffType = 'HVAMPIREBITETARGET',
            Stacks = 'ALWAYS',
            Duration = 3,
            DamageSelf = true,
            Debuff = true,
            CanBeDispelled = true,
            CanBeEvaded = false,
            CanBackfire = false,
            DamageFriendly = true,
            ArmorImmune = true,
            CanCrit = false,
            CanMagicResist = false,
            IgnoreDamageRangePercent = true,
            Affects = {
                Armor = {Add = -700},
                MoveMult = {Mult = -0.3},
            },
            Icon = '/DGVampLord/NewVamplordBite01',
        },
    },
    OnStartAbility = function(self, unit, params)
        Bite(self, unit, params)
    end,
}
#################################################################################################################
# CE - Bite
#################################################################################################################
function Bite(abilityDef, unit, params)
    local target = params.Targets[1]
    local data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = unit:GetArmy(),
        Type = 'Spell',
        DamageAction = abilityDef.Name,
        Radius = 0,
        DamageSelf = true,
        DamageFriendly = true,
        ArmorImmune = true,
        CanBackfire = false,
        CanBeEvaded = false,
        CanCrit = false,
        CanMagicResist = false,
        CanOverKill = true,
        IgnoreDamageRangePercent = true,
        Group = "UNITS",
    }
    Leech( unit, target, data, abilityDef.Amount )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'Bite01', unit:GetArmy(), target:GetPosition(), ForwardVector(unit:GetOrientation()) )
end

#################################################################################################################
# Conversion Base
# Lord Erebus exudes an aura that has a chance to turn any infantry near him into a vampire on death.
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireConversion00',
    DisplayName = '<LOC ABILITY_Vampire_0012>Vampire Conversion',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 2.5,
    TargetAlliance = 'Any',
    TargetCategory = 'MOBILE - UNTARGETABLE - NOBUFFS - VAMPIRE',
    OnAbilityAdded = function(self, unit)
        Buff.ApplyBuff(unit, 'HVampireConversionSelf00', unit)
    end,
    Tooltip = {
        TargetAlliance = 'Any',
    },
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireConversion00',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Vampire_0070>Vampire Conversion',
            BuffType = 'HVAMPIRECONVERSION',
            Stacks = 'REPLACE',
            Duration = 3,
            VampireChance = 35,
            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.VampLord then
                    unit.AbilityData.VampLord = {}
                end
                unit.AbilityData.VampLord.VampireConversionInst = instigator
                unit.Callbacks.OnKilled:Add(self.SpawnVampire, self)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(self.SpawnVampire)
            end,
            SpawnVampire = function(self, unit)
                RaiseVampire(self, unit)
            end,
        }
    },
}

#################################################################################################################
# Buffs - Conversion Base
#################################################################################################################
BuffBlueprint {
    BuffType = 'HVAMPIRECONVERSIONSELF',
    Debuff = false,
    DisplayName = '<LOC ABILITY_Vampire_0013>Conversion Aura',
    Description = '<LOC ABILITY_Vampire_0014>Lord Erebus has a 20% chance to convert infantry into Vampires when they die.',
    Duration = -1,
    Name = 'HVampireConversionSelf00',
    Stacks = 'REPLACE',
}

#################################################################################################################
# Conversion I
# Lord Erebus exudes an aura that has a chance to turn any infantry near him into a vampire on death.
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireConversion01',
    DisplayName = '<LOC ABILITY_Vampire_0016>Improved Conversion Aura I',
    Description = '<LOC ABILITY_Vampire_0017>Lord Erebus has a [GetVampireChance]% chance to convert infantry into Night Walkers when they die. His Night Walkers have +[GetHealthBonus] Health.',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 2.5,
    TargetAlliance = 'Any',
    TargetCategory = 'MOBILE - UNTARGETABLE - NOBUFFS - VAMPIRE',
    OnAbilityAdded = function(self, unit)
        Buff.ApplyBuff(unit, 'HVampireConversionSelf01', unit)
        Coven(self, unit, 'HVampireConversionTarget01')
    end,
    GetVampireChance = function(self) return math.floor( Buffs[self.Name].VampireChance ) end,
    GetHealthBonus = function(self) return math.floor( Buffs['HVampireConversionTarget01'].Affects.MaxHealth.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireConversion01',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Vampire_0071>Night Walker Conversion',
            BuffType = 'HVAMPIRECONVERSION',
            Stacks = 'REPLACE',
            Duration = 3,
            VampireChance = 50,
            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.VampLord then
                    unit.AbilityData.VampLord = {}
                end
                unit.AbilityData.VampLord.VampireConversionInst = instigator
                unit.Callbacks.OnKilled:Add(self.SpawnVampire, self)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(self.SpawnVampire)
            end,
            SpawnVampire = function(self, unit)
                RaiseVampire(self, unit)
            end,
        }
    },
}

#################################################################################################################
# Buffs - Conversion I
#################################################################################################################
BuffBlueprint {
    BuffType = 'HVAMPIRECONVERSIONSELF',
    Debuff = false,
    DisplayName = '<LOC ABILITY_Vampire_0016>Improved Conversion Aura I',
    Description = '<LOC ABILITY_Vampire_0096>Lord Erebus has a 35% chance to convert infantry into  Night Walkers when they die.',
    Duration = -1,
    Name = 'HVampireConversionSelf01',
    Stacks = 'REPLACE',
}

BuffBlueprint {
    Name = 'HVampireConversionTarget01',
    BuffType = 'HVAMPIRECONVERSIONVAMPBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 100, AdjustHealth = true},
    },
}

#################################################################################################################
# Conversion II
# Lord Erebus exudes an aura that has a chance to turn any infantry near him into a vampire on death.
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireConversion02',
    DisplayName = '<LOC ABILITY_Vampire_0018>Improved Conversion Aura II',
    Description = '<LOC ABILITY_Vampire_0017>Lord Erebus has a [GetVampireChance]% chance to convert infantry into Night Walkers when they die. His Night Walkers have +[GetHealthBonus] Health.',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 2.5,
    TargetAlliance = 'Any',
    TargetCategory = 'MOBILE - UNTARGETABLE - NOBUFFS - VAMPIRE',
    OnAbilityAdded = function(self, unit)
        Buff.ApplyBuff(unit, 'HVampireConversionSelf02', unit)
        Coven(self, unit, 'HVampireConversionTarget02')
    end,
    GetVampireChance = function(self) return math.floor( Buffs[self.Name].VampireChance ) end,
    GetHealthBonus = function(self) return math.floor( Buffs['HVampireConversionTarget02'].Affects.MaxHealth.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireConversion02',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Vampire_0072>Night Walker Conversion',
            BuffType = 'HVAMPIRECONVERSION',
            Stacks = 'REPLACE',
            Duration = 3,
            VampireChance = 65,
            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.VampLord then
                    unit.AbilityData.VampLord = {}
                end
                unit.AbilityData.VampLord.VampireConversionInst = instigator
                unit.Callbacks.OnKilled:Add(self.SpawnVampire, self)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(self.SpawnVampire)
            end,
            SpawnVampire = function(self, unit)
                RaiseVampire(self, unit)
            end,
        }
    },
}

#################################################################################################################
# Buffs - Conversion II
#################################################################################################################
BuffBlueprint {
    BuffType = 'HVAMPIRECONVERSIONSELF',
    Debuff = false,
    DisplayName = '<LOC ABILITY_Vampire_0018>Improved Conversion Aura II',
    Description = '<LOC ABILITY_Vampire_0019>Lord Erebus has a 50% chance to convert infantry into Night Walkers when they die.',
    Duration = -1,
    Name = 'HVampireConversionSelf02',
    Stacks = 'REPLACE',
}

BuffBlueprint {
    Name = 'HVampireConversionTarget02',
    BuffType = 'HVAMPIRECONVERSIONVAMPBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 250, AdjustHealth = true},
    },
}

#################################################################################################################
# Conversion III
# Lord Erebus exudes an aura that has a chance to turn any infantry near him into a vampire on death.
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireConversion03',
    DisplayName = '<LOC ABILITY_Vampire_0021>Improved Conversion Aura III',
    Description = '<LOC ABILITY_Vampire_0017>Lord Erebus has a [GetVampireChance]% chance to convert infantry into Night Walkers when they die. His Night Walkers have +[GetHealthBonus] Health.',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 2.5,
    TargetAlliance = 'Any',
    TargetCategory = 'MOBILE - UNTARGETABLE - NOBUFFS - VAMPIRE',
    OnAbilityAdded = function(self, unit)
        Buff.ApplyBuff(unit, 'HVampireConversionSelf03', unit)
        Coven(self, unit, 'HVampireConversionTarget03')
    end,
    GetVampireChance = function(self) return math.floor( Buffs[self.Name].VampireChance ) end,
    GetHealthBonus = function(self) return math.floor( Buffs['HVampireConversionTarget03'].Affects.MaxHealth.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireConversion03',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Vampire_0073>Night Walker Conversion',
            BuffType = 'HVAMPIRECONVERSION',
            Stacks = 'REPLACE',
            Duration = 3,
            VampireChance = 80,
            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.VampLord then
                    unit.AbilityData.VampLord = {}
                end
                unit.AbilityData.VampLord.VampireConversionInst = instigator
                unit.Callbacks.OnKilled:Add(self.SpawnVampire, self)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(self.SpawnVampire)
            end,
            SpawnVampire = function(self, unit)
                RaiseVampire(self, unit)
            end,
        }
    },
}

#################################################################################################################
# Buffs - Conversion III
#################################################################################################################
BuffBlueprint {
    BuffType = 'HVAMPIRECONVERSIONSELF',
    Debuff = false,
    DisplayName = '<LOC ABILITY_Vampire_0021>Improved Conversion Aura III',
    Description = '<LOC ABILITY_Vampire_0022>Lord Erebus has a 65% chance to convert infantry into Night Walkers when they die.',
    Duration = -1,
    Name = 'HVampireConversionSelf03',
    Stacks = 'REPLACE',
}

BuffBlueprint {
    Name = 'HVampireConversionTarget03',
    BuffType = 'HVAMPIRECONVERSIONVAMPBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        MaxHealth = {Add = 400, AdjustHealth = true},
    },
}

#################################################################################################################
# CE - Conversion
#################################################################################################################
function RaiseVampire(abilDef, deadUnit)
    local inst = deadUnit.AbilityData.VampLord.VampireConversionInst
    if not inst or inst:IsDead() or deadUnit == inst then
        return
    end
    local rand = Random(1, 100)
    if rand > abilDef.VampireChance then
        return
    end

    local numVampires = ArmyBrains[inst:GetArmy()]:GetCurrentUnits(categories.hvampirevampire01)
    #LOG('*DEBUG: num vampires = ' .. numVampires)
    if(numVampires < inst.AbilityData.Vampire.VampireMax) then
        local pos = deadUnit:GetPosition()
        local orient = deadUnit:GetOrientation()
        local brainNum = inst:GetArmy()
        local vampireling = CreateUnitHPR('HVampireVampire01', brainNum, pos[1], pos[2], pos[3], orient[1], orient[2],orient[3])
        if not vampireling then
            return
        end

        IssueGuard({vampireling}, inst)

        # Apply Coven buff to new vampire
        for i = 1, 3 do
            if(Validate.HasAbility(inst, 'HVampireCoven0' .. i)) then
                Buff.ApplyBuff(vampireling, 'HVampireCovenTarget0' .. i, inst)
            end
            if(Validate.HasAbility(inst, 'HVampireConversion0' .. i)) then
                Buff.ApplyBuff(vampireling, 'HVampireConversionTarget0' .. i, inst)
                vampireling:AdjustHealth(vampireling:GetMaxHealth())
            end
        end
    end
end

#################################################################################################################
# Coven - Base
# Specifies the max number of vampires allowed at a time.
# Buffs vampires Health and damage.
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireCoven00',
    DisplayName = '<LOC ABILITY_Vampire_0023>Coven',
    Description = '<LOC ABILITY_Vampire_0024>Can control up to 2 Night Walkers.',
    AbilityType = 'Quiet',
    AbilityCategory = 'HVAMPIREMISTOFF',
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireCoven00',
            DisplayName = '<LOC ABILITY_Vampire_0023>Coven',
            Description = '<LOC ABILITY_Vampire_0024>Can control up to 2 Night Walkers.',
            BuffType = 'HVAMPIRECOVEN',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            VampireMax = 2,
            OnBuffAffect = function(self, unit, instigator)
                Coven(self, unit)
            end,
        }
    },
}

#################################################################################################################
# Coven I
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireCoven01',
    DisplayName = '<LOC ABILITY_Vampire_0025>Coven I',
    Description = '<LOC ABILITY_Vampire_0026>Lord Erebus\'s control over his coven increases, allowing him to control up to [GetVampireMax] Night Walkers with their damage increased by [GetVampireBuff].',
    AbilityType = 'Quiet',
    AbilityCategory = 'HVAMPIREMISTOFF',
    GetVampireMax = function(self) return math.floor( Buffs[self.Name].VampireMax ) end,
    GetVampireBuff = function(self) return math.floor( Buffs['HVampireCovenTarget01'].Affects.DamageRating.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireCoven01',
            DisplayName = '<LOC ABILITY_Vampire_0025>Coven I',
            Description = '<LOC ABILITY_Vampire_0097>Lord Erebus\'s control over his coven increases, allowing him to control up to 4 Night Walkers and their damage increased by 8.',
            BuffType = 'HVAMPIRECOVEN',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            VampireMax = 6,
            OnBuffAffect = function(self, unit, instigator)
                Coven(self, unit, 'HVampireCovenTarget01')
            end,
        }
    },
}

#################################################################################################################
# Buffs - Coven I
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireCovenTarget01',
    DisplayName = '<LOC ABILITY_Vampire_0023>Coven',
    Description = '<LOC ABILITY_Vampire_0028>Damage and Health increased.',
    BuffType = 'HVAMPIRECOVENTARGET',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        DamageRating = {Add = 6},
    },
}

#################################################################################################################
# Coven II
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireCoven02',
    DisplayName = '<LOC ABILITY_Vampire_0029>Coven II',
    Description = '<LOC ABILITY_Vampire_0026>Lord Erebus\'s control over his coven increases, allowing him to control up to [GetVampireMax] Night Walkers with their damage increased by [GetVampireBuff].',
    AbilityType = 'Quiet',
    AbilityCategory = 'HVAMPIREMISTOFF',
    GetVampireMax = function(self) return math.floor( Buffs[self.Name].VampireMax ) end,
    GetVampireBuff = function(self) return math.floor( Buffs['HVampireCovenTarget02'].Affects.DamageRating.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireCoven02',
            DisplayName = '<LOC ABILITY_Vampire_0029>Coven II',
            Description = '<LOC ABILITY_Vampire_0098>Lord Erebus\'s control over his coven increases, allowing him to control up to 6 Night Walkers and their damage increased by 16.',
            BuffType = 'HVAMPIRECOVEN',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            VampireMax = 8,
            OnBuffAffect = function(self, unit, instigator)
                Coven(self, unit, 'HVampireCovenTarget02')
            end,
        }
    },
}

#################################################################################################################
# Buffs - Coven II
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireCovenTarget02',
    DisplayName = '<LOC ABILITY_Vampire_0074>Coven',
    Description = '<LOC ABILITY_Vampire_0075>Damage and Health increased.',
    BuffType = 'HVAMPIRECOVENTARGET',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        DamageRating = {Add = 12},
    },
}

#################################################################################################################
# Coven III
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireCoven03',
    DisplayName = '<LOC ABILITY_Vampire_0031>Coven III',
    Description = '<LOC ABILITY_Vampire_0026>Lord Erebus\'s control over his coven increases, allowing him to control up to [GetVampireMax] Night Walkers with their damage increased by [GetVampireBuff].',
    AbilityType = 'Quiet',
    AbilityCategory = 'HVAMPIREMISTOFF',
    GetVampireMax = function(self) return math.floor( Buffs[self.Name].VampireMax ) end,
    GetVampireBuff = function(self) return math.floor( Buffs['HVampireCovenTarget03'].Affects.DamageRating.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireCoven03',
            DisplayName = '<LOC ABILITY_Vampire_0031>Coven III',
            Description = '<LOC ABILITY_Vampire_0099>Lord Erebus\'s control over his coven increases, allowing him to up to control 8 Night Walkers and their damage increased by 24.',
            BuffType = 'HVAMPIRECOVEN',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            VampireMax = 10,
            OnBuffAffect = function(self, unit, instigator)
                Coven(self, unit, 'HVampireCovenTarget03')
            end,
        }
    },
}

#################################################################################################################
# Buffs - Coven III
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireCovenTarget03',
    DisplayName = '<LOC ABILITY_Vampire_0076>Coven',
    Description = '<LOC ABILITY_Vampire_0077>Damage and Health increased.',
    BuffType = 'HVAMPIRECOVENTARGET',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        DamageRating = {Add = 18},
    },
}

#################################################################################################################
# CE - Coven
#################################################################################################################
function Coven(buffDef, vampLord, buffName)
    if(vampLord and not vampLord:IsDead()) then
        if(not vampLord.AbilityData.Vampire) then
            vampLord.AbilityData.Vampire = {}
        end
        if buffDef.VampireMax then
            vampLord.AbilityData.Vampire.VampireMax = buffDef.VampireMax
        end

        # Apply Coven buff to existing vampires
        # Vampirelings Health is increased by the difference between their old max Health and their new max Health
        if(buffName) then
            local vampirelings = ArmyBrains[vampLord:GetArmy()]:GetListOfUnits(categories.hvampirevampire01, false)
            for k, v in vampirelings do
                if(v and not v:IsDead()) then
                    local oldHealth = v:GetHealth()
                    local oldMaxHealth = v:GetMaxHealth()
                    Buff.ApplyBuff(v, buffName, vampLord)
                    local newMaxHealth = v:GetMaxHealth()
                    local adjustedHealth = newMaxHealth - (oldMaxHealth - oldHealth)
                    v:AdjustHealth(adjustedHealth)
                end
            end
        end
    end
end

#################################################################################################################
# Army of the Night
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireArmyoftheNight',
    DisplayName = '<LOC ABILITY_Vampire_0108>Army of the Night',
    Description = '<LOC ABILITY_Vampire_0109>Lord Erebus leads his Night Walkers as a bloodthirsty pack. Their Attack Speed is increased by [GetAttackBonus]% and their attacks drain life.',
    AbilityType = 'Quiet',
    GetAttackBonus = function(self) return math.floor( Buffs[self.Name].Affects.RateOfFire.Mult * 100 ) end,
    OnAbilityAdded = function(self, unit)
        unit:GetAIBrain():AddArmyBonus( 'HVampireArmyoftheNight', self )
    end,
}

ArmyBonusBlueprint {
    Name = 'HVampireArmyoftheNight',
    DisplayName = '<LOC ABILITY_Vampire_0110>Army of the Night',
    Description = '<LOC ABILITY_Vampire_0111>Lord Erebus leads his Night Walkers as a bloodthirsty pack. Their Attack Speed is increased by [GetAttackBonus] and their attacks drain life.',
    ApplyArmies = 'Single',
    UnitCategory = 'VAMPIRE',
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireArmyoftheNight',
            DisplayName = '<LOC ABILITY_Vampire_0112>Army of the Night',
            Description = '<LOC ABILITY_Vampire_0113>Attack speed increased. Attacks drain life.',
            BuffType = 'HVAMPIREARMYOFTHENIGHT',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Icon = '/DGVampLord/NewVamplordArmyoftheNight01',
            Affects = {
                RateOfFire = {Mult = 0.05},
                LifeSteal = {Add = 0.10},
            },
        }
    }
}

#################################################################################################################
# VFX - Mass Charm
#################################################################################################################
function CrossVector( v1, v2 )
	return Vector( (v1.y * v2.z) - (v1.z * v2.y), (v1.z * v2.x) - (v1.x * v2.z ), (v1.x * v2.y) - (v1.y - v2.x))
end

function FxCharm01(self, unit)
    local fwdVec = ForwardVector(unit:GetOrientation())
    local pos = table.copy(unit:GetPosition())
    pos[2] = 100
    local army = unit:GetArmy()

    # Main flash, discharge effects
    AttachEffectsAtBone( unit, EffectTemplates.VampireLord.Charm01, -2 )

    # Side force waves
    local crossVec = CrossVector( fwdVec, Vector(0,1,0) )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmArcs01', army, pos, crossVec )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmArcs01', army, pos, {-crossVec[1], -crossVec[2], -crossVec[3]} )
    # Front and back force waves
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmArcs02', army, pos, fwdVec )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmArcs02', army, pos, {-fwdVec[1], -fwdVec[2], -fwdVec[3]} )
end

function FxCharmWarmup01(self, unit)
    local pos = table.copy(unit:GetPosition())
    local army = unit:GetArmy()

    # Charge/cast effect on hands
    AttachEffectsAtBone( unit, EffectTemplates.VampireLord.CastCharm01, 'sk_Vampire_Lord_RightWrist' )
    AttachEffectsAtBone( unit, EffectTemplates.VampireLord.CastCharm01, 'sk_Vampire_Lord_LeftWrist' )

    # Charging magic ball in front of character
    AttachEffectsAtBone( unit, EffectTemplates.VampireLord.CastCharm02, -2 )

    # Charge/cast wisps and smoke moving inward and upward.
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmWarmup01', army, {pos[1],pos[2],pos[3]+4}, {0,0,1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmWarmup01', army, {pos[1]+3,pos[2],pos[3]+3}, {1,0,1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmWarmup01', army, {pos[1]+4,pos[2],pos[3]}, {1,0,0} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmWarmup01', army, {pos[1]+3,pos[2],pos[3]-3}, {1,0,-1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmWarmup01', army, {pos[1],pos[2],pos[3]-4}, {0,0,-1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmWarmup01', army, {pos[1]-3,pos[2],pos[3]-3}, {-1,0,-1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmWarmup01', army, {pos[1]-4,pos[2],pos[3]}, {-1,0,0} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'CharmWarmup01', army, {pos[1]-3,pos[2],pos[3]+3}, {-1,0,1} )
end

#################################################################################################################
# Mass Charm I
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMassCharm01',
    DisplayName = '<LOC ABILITY_Vampire_0033>Mass Charm I',
    Description = '<LOC ABILITY_Vampire_0034>Stuns enemies around Lord Erebus for [GetMistStun] seconds. Demigods are stunned for [GetHeroMistStun] seconds.',
    AbilityCategory = 'HVAMPIREMISTOFF',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 15,
    CastAction = 'Charm',
    CastingTime = 1,
    FollowThroughTime = 1.0,
    Cooldown = 20,
    EnergyCost = 450,
    UISlot = 3,
    HotKey = '3',
    OnStartCasting = function(self, unit)
        # Casting effects
        FxCharmWarmup01( self, unit )
    end,
    OnStartAbility = function(self, unit)
        # Trigger effects
        FxCharm01( self, unit )
    end,
    GetMistStun = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetHeroMistStun = function(self) return ( Buffs['HVampireMassCharm01Hero'].Duration ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMassCharm01',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Vampire_0035>Mass Charm',
            Description = '<LOC ABILITY_Vampire_0036>Stunned.',
            BuffType = 'HVAMPIREMASSCHARM',
            EntityCategory = 'ALLUNITS - UNTARGETABLE - HERO',
            Stacks = 'REPLACE',
            Duration = 3,
            TriggersStunImmune = true,
            Affects = {
                Stun = {Add = 0},
            },
            Icon = '/DGVampLord/NewVamplordCharm01',
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm01Hero',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Vampire_0078>Mass Charm',
            Description = '<LOC ABILITY_Vampire_0079>Stunned.',
            BuffType = 'HVAMPIREMASSCHARM_HERO',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'REPLACE',
            Duration = 1,
            TriggersStunImmune = true,
            Affects = {
                Stun = {Add = 0},
            },
            Icon = '/DGVampLord/NewVamplordCharm01',
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm01Immune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'MINION',
            Stacks = 'IGNORE',
            Duration = 6,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm01HeroImmune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'IGNORE',
            Duration = 2,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
    },
    Icon = '/DGVampLord/NewVamplordCharm01',
}

#################################################################################################################
# Mass Charm II
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMassCharm02',
    DisplayName = '<LOC ABILITY_Vampire_0037>Mass Charm II',
    Description = '<LOC ABILITY_Vampire_0034>Stuns enemies around Lord Erebus for [GetMistStun] seconds. Demigods are stunned for [GetHeroMistStun] seconds.',
    AbilityCategory = 'HVAMPIREMISTOFF',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 15,
    CastAction = 'Charm',
    CastingTime = 1,
    FollowThroughTime = 1.0,
    Cooldown = 20,
    EnergyCost = 600,
    UISlot = 3,
    HotKey = '3',
    GetMistStun = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetHeroMistStun = function(self) return string.format("%.1f", Buffs['HVampireMassCharm02Hero'].Duration) end,
    OnStartCasting = function(self, unit)
        # Casting effects
        FxCharmWarmup01( self, unit )
    end,
    OnStartAbility = function(self, unit)
        # Trigger effects
        FxCharm01( self, unit )
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMassCharm02',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Vampire_0080>Mass Charm',
            Description = '<LOC ABILITY_Vampire_0081>Stunned.',
            BuffType = 'HVAMPIREMASSCHARM',
            EntityCategory = 'ALLUNITS - UNTARGETABLE - HERO',
            Stacks = 'REPLACE',
            Duration = 5,
            TriggersStunImmune = true,
            Affects = {
                Stun = {Add = 0},
            },
            Icon = '/DGVampLord/NewVamplordCharm01',
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm02Hero',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Vampire_0082>Mass Charm',
            Description = '<LOC ABILITY_Vampire_0083>Stunned.',
            BuffType = 'HVAMPIREMASSCHARM_HERO',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'REPLACE',
            Duration = 1.5,
            TriggersStunImmune = true,
            Affects = {
                Stun = {Add = 0},
            },
            Icon = '/DGVampLord/NewVamplordCharm01',
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm02Immune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'MINION',
            Stacks = 'IGNORE',
            Duration = 10,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm02HeroImmune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'IGNORE',
            Duration = 3,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
    },
    Icon = '/DGVampLord/NewVamplordCharm01',
}

#################################################################################################################
# Mass Charm III
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMassCharm03',
    DisplayName = '<LOC ABILITY_Vampire_0039>Mass Charm III',
    Description = '<LOC ABILITY_Vampire_0034>Stuns enemies around Lord Erebus for [GetMistStun] seconds. Demigods are stunned for [GetHeroMistStun] seconds.',
    AbilityCategory = 'HVAMPIREMISTOFF',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 15,
    CastAction = 'Charm',
    CastingTime = 1,
    FollowThroughTime = 1.0,
    Cooldown = 20,
    EnergyCost = 750,
    UISlot = 3,
    HotKey = '3',
    GetMistStun = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetHeroMistStun = function(self) return ( Buffs['HVampireMassCharm03Hero'].Duration ) end,
    OnStartCasting = function(self, unit)
        # Casting effects
        FxCharmWarmup01( self, unit )
    end,
    OnStartAbility = function(self, unit)
        # Trigger effects
        FxCharm01( self, unit )
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMassCharm03',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Vampire_0084>Mass Charm',
            Description = '<LOC ABILITY_Vampire_0085>Stunned.',
            BuffType = 'HVAMPIREMASSCHARM',
            EntityCategory = 'ALLUNITS - UNTARGETABLE - HERO',
            Stacks = 'REPLACE',
            Duration = 7,
            TriggersStunImmune = true,
            Affects = {
                Stun = {Add = 0},
            },
            Icon = '/DGVampLord/NewVamplordCharm01',
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm03Hero',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Vampire_0086>Mass Charm',
            Description = '<LOC ABILITY_Vampire_0087>Stunned.',
            BuffType = 'HVAMPIREMASSCHARM_HERO',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'REPLACE',
            Duration = 2,
            TriggersStunImmune = true,
            Affects = {
                Stun = {Add = 0},
            },
            Icon = '/DGVampLord/NewVamplordCharm01',
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm03Immune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'MINION',
            Stacks = 'IGNORE',
            Duration = 14,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm03HeroImmune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'IGNORE',
            Duration = 4,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
    },
    Icon = '/DGVampLord/NewVamplordCharm01',
}

#################################################################################################################
# Mass Charm IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMassCharm04',
    DisplayName = '<LOC ABILITY_Vampire_0103>Mass Charm IV',
    Description = '<LOC ABILITY_Vampire_0034>Stuns enemies around Lord Erebus for [GetMistStun] seconds. Demigods are stunned for [GetHeroMistStun] seconds.',
    AbilityCategory = 'HVAMPIREMISTOFF',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 15,
    CastAction = 'Charm',
    CastingTime = 1,
    FollowThroughTime = 1.0,
    Cooldown = 20,
    EnergyCost = 900,
    UISlot = 3,
    HotKey = '3',
    GetMistStun = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetHeroMistStun = function(self) return ( Buffs['HVampireMassCharm04Hero'].Duration ) end,
    OnStartCasting = function(self, unit)
        # Casting effects
        FxCharmWarmup01( self, unit )
    end,
    OnStartAbility = function(self, unit)
        # Trigger effects
        FxCharm01( self, unit )
        if Validate.HasAbility(unit, 'HVampireMuddle') then
            local entities = GetEntitiesInSphere("UNITS", table.copy(unit:GetPosition()), self.AffectRadius)
            for k,entity in entities do
                if IsEnemy(unit:GetArmy(), entity:GetArmy()) and not entity:IsDead() and EntityCategoryContains(categories.HERO, entity) and not EntityCategoryContains(categories.NOBUFFS, entity) and not EntityCategoryContains(categories.UNTARGETABLE, entity) then
                    Buff.ApplyBuff(entity, 'HVampireMuddle', unit)
                end
            end
        end
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMassCharm04',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Vampire_0084>Mass Charm',
            Description = '<LOC ABILITY_Vampire_0085>Stunned.',
            BuffType = 'HVAMPIREMASSCHARM',
            EntityCategory = 'ALLUNITS - UNTARGETABLE - HERO',
            Stacks = 'REPLACE',
            Duration = 9,
            TriggersStunImmune = true,
            Affects = {
                Stun = {Add = 0},
            },
            Icon = '/DGVampLord/NewVamplordCharm01',
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm04Hero',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Vampire_0086>Mass Charm',
            Description = '<LOC ABILITY_Vampire_0087>Stunned.',
            BuffType = 'HVAMPIREMASSCHARM_HERO',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'REPLACE',
            Duration = 3,
            TriggersStunImmune = true,
            Affects = {
                Stun = {Add = 0},
            },
            Icon = '/DGVampLord/NewVamplordCharm01',
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm04Immune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'MINION',
            Stacks = 'REPLACE',
            Duration = 18,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HVampireMassCharm04HeroImmune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'REPLACE',
            Duration = 6,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
    },
    Icon = '/DGVampLord/NewVamplordCharm01',
}

#################################################################################################################
# Muddle
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMuddle',
    DisplayName = '<LOC ABILITY_Vampire_0114>Muddle',
    Description = '<LOC ABILITY_Vampire_0115>Mass Charm leaves lingering effects on Demigods. Any Demigod affected by Mass Charm has their cooldowns increased by [GetCooldownMult]% for [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetCooldownMult = function(self) return math.floor( Buffs[self.Name].Affects.Cooldown.Mult * 100 ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
}

BuffBlueprint {
    Name = 'HVampireMuddle',
    DisplayName = '<LOC ABILITY_Vampire_0116>Muddle',
    Description = '<LOC ABILITY_Vampire_0117>Cooldown times increased.',
    BuffType = 'HVAMPIREMUDDLE',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 7,
    Icon = '/DGVampLord/NewVamplordMuddle01',
    Affects = {
        Cooldown = {Mult = 1.0},
    },
}

#################################################################################################################
# Mist On
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireMistOnDisable',
    Debuff = false,
    DisplayName = 'Mist On Abilities Disabled',
    BuffType = 'HVAMPIREMISTONDISABLE',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Silence = {Bool = true,},
    },
}

#################################################################################################################
# VFX - Mist
#################################################################################################################
function FxMistForm01(self, unit, MistEffects)
    # Dissolve the Vamp Lords shader.
    unit:AddEffectMeshState( 'Dissolve', string.lower(unit.Character.CharBP.Meshes.Dissolve), true, true )
    unit:SetAuxMeshParam( GetGameTimeSeconds() * 10 )

    # Mist Forming effects
    AttachEffectAtBone( unit, 'VampireLord', 'MistForm01', -2 )

    local pos = table.copy(unit:GetPosition())
    local army = unit:GetArmy()
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistForm02', army, pos, {0,0,1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistForm02', army, pos, {1,0,1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistForm02', army, pos, {1,0,0} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistForm02', army, pos, {1,0,-1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistForm02', army, pos, {0,0,-1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistForm02', army, pos, {-1,0,-1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistForm02', army, pos, {-1,0,0} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistForm02', army, pos, {-1,0,1} )

    # Create Mist tendril Effects
    local thd = unit:ForkThread(FxMistTendrils01, unit, MistEffects)
    table.insert(MistEffects, thd)
    thd = unit:ForkThread(FxMistTendrils02, unit, MistEffects )
    table.insert(MistEffects, thd)
    thd = unit:ForkThread(FxMistTendrils03, unit, MistEffects )
    table.insert(MistEffects, thd)

    WaitSeconds (0.5)

    # Create mist base effects
    emit = AttachCharacterEffectsAtBone( unit, 'vampire_lord', 'MistAura01', -2, unit.TrashOnKilled, MistEffects )
end

function FxMistDissolve01(self, unit)
    # Mist Dissolve effects
    local pos = table.copy(unit:GetPosition())
    local army = unit:GetArmy()
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistDissolve01', army, {pos[1],pos[2],pos[3]+4}, {0,0,1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistDissolve01', army, {pos[1]+3,pos[2],pos[3]+3}, {1,0,1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistDissolve01', army, {pos[1]+4,pos[2],pos[3]}, {1,0,0} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistDissolve01', army, {pos[1]+3,pos[2],pos[3]-3}, {1,0,-1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistDissolve01', army, {pos[1],pos[2],pos[3]-4}, {0,0,-1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistDissolve01', army, {pos[1]-3,pos[2],pos[3]-3}, {-1,0,-1} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistDissolve01', army, {pos[1]-4,pos[2],pos[3]}, {-1,0,0} )
    CreateTemplatedEffectAtPos( 'VampireLord', nil, 'MistDissolve01', army, {pos[1]-3,pos[2],pos[3]+3}, {-1,0,1} )
end

function FxMistTendrils01(self, unit, MistEffects)
    local proj = nil
    while true do
        proj = unit:CreateProjectile( '/projectiles/MistEffect01/MistEffect01_proj.bp', 0, 2.8, 0, 0, 1, 0 ):SetLifetime( 15 )
        table.insert(MistEffects, proj )
        unit.TrashOnKilled:Add( proj )

        proj = unit:CreateProjectile( '/projectiles/MistEffect02/MistEffect02_proj.bp', 0, 1.2, 0, 0, 1, 0 ):SetLifetime( 15 )
        table.insert(MistEffects, proj )
        unit.TrashOnKilled:Add( proj )
        WaitSeconds(GetRandomFloat( 0.6, 2.0 ))
    end
end

function SetRandTendrilParam( emit, curve )
    local PosOffset = GetRandomFloat( 2.5, 5.5 )
    if Random( 0, 1 ) == 1 then
        PosOffset = -PosOffset
    end
    emit:SetEmitterCurveParam( curve, PosOffset, 0.0)
end

function FxMistTendrils02(self, unit, MistEffects)
    while true do
        local proj01 = unit:CreateProjectile( '/projectiles/MistEffect03/MistEffect03_proj.bp', 0, 1.8, 0, 0, 1, 0 ):SetLifetime( GetRandomFloat( 2.0, 3.0 ) )
        table.insert( MistEffects, proj01 )
        local emit = CreateAttachedEmitter( proj01, -1, unit:GetArmy(), '/effects/emitters/projectiles/misteffect01/trail/p_mie01_t_02_fastwisps_h_emit.bp' )
        SetRandTendrilParam( emit, 'X_POSITION_CURVE' )
        SetRandTendrilParam( emit, 'Y_POSITION_CURVE' )

        WaitSeconds(GetRandomFloat( 0.3, 2.0 ))

        local proj02 = unit:CreateProjectile( '/projectiles/MistEffect03/MistEffect03_proj.bp', 0, 1.8, 0, 0, 1, 0 ):SetLifetime( GetRandomFloat( 2.0, 3.0 ) )
        table.insert( MistEffects, proj02 )
        emit = CreateAttachedEmitter( proj02, -1, unit:GetArmy(), '/effects/emitters/projectiles/misteffect01/trail/p_mie01_t_02_fastwisps_h_emit.bp' )
        SetRandTendrilParam( emit, 'X_POSITION_CURVE' )
        SetRandTendrilParam( emit, 'Y_POSITION_CURVE' )

        WaitSeconds(GetRandomFloat( 0.3, 2.0 ))
    end
end

function FxMistTendrils03(self, unit, MistEffects)
    local LoopCount = 6
    while LoopCount > 0 do
        local proj = unit:CreateProjectile( '/projectiles/MistEffect04/MistEffect04_proj.bp', 0, 2.8, 0, 0, 1, 0 ):SetLifetime( 3 )
        table.insert(MistEffects, proj )
        unit.TrashOnKilled:Add( proj )
        WaitSeconds(GetRandomFloat( 0.45, 0.75 ))

        proj = unit:CreateProjectile( '/projectiles/MistEffect05/MistEffect05_proj.bp', 0, 1.2, 0, 0, 1, 0 ):SetLifetime( 3 )
        table.insert(MistEffects, proj )
        unit.TrashOnKilled:Add( proj )
        WaitSeconds(GetRandomFloat( 0.45, 0.75 ))
        LoopCount = LoopCount - 1
    end
end

#################################################################################################################
# Mist - Debuff Immunity
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireMistImmobilize',
    BuffType = 'HVAMPIREMISTIMOBILE',
    Stacks = 'REPLACE',
    Debuff = false,
    Duration = -1,
    Affects = {
        UnitImmobile = {Bool = true},
    },
}

BuffBlueprint {
    Name = 'HVampireMistImmunity',
    BuffType = 'HVAMPIREMISTIMMUNITY',
    Stacks = 'REPLACE',
    Debuff = false,
    Duration = -1,
    Affects = {
        DebuffImmune = { Bool = true },
        Regen = {Mult = -1}
    },
}

function MistFunctionalityEntrance(unit)
    local disabled = false
    if(Validate.HasAbility(unit, 'HVampireMist01')) then
        Abil.SetAbilityState(unit, 'HVampireMist01', disabled)
        Abil.SetAbilityState(unit, 'HVampireMistAlly01', disabled)
    elseif(Validate.HasAbility(unit, 'HVampireMist02')) then
        Abil.SetAbilityState(unit, 'HVampireMist02', disabled)
        Abil.SetAbilityState(unit, 'HVampireMistAlly02', disabled)
    elseif(Validate.HasAbility(unit, 'HVampireMist03')) then
        Abil.SetAbilityState(unit, 'HVampireMist03', disabled)
        Abil.SetAbilityState(unit, 'HVampireMistAlly03', disabled)
    elseif(Validate.HasAbility(unit, 'HVampireMist04')) then
        Abil.SetAbilityState(unit, 'HVampireMist04', disabled)
        Abil.SetAbilityState(unit, 'HVampireMistAlly04', disabled)
    end
    if(Validate.HasAbility(unit, 'HVampireBloodyHazeAlly')) then
        Abil.SetAbilityState(unit, 'HVampireBloodyHazeAlly', disabled)
    end
end

function MistFunctionalityEnd(unit)
    #ChangeState(unit, unit.MistOffState)
    local disabled = true
    if(Validate.HasAbility(unit, 'HVampireMist01')) then
        Abil.SetAbilityState(unit, 'HVampireMist01', disabled)
        Abil.SetAbilityState(unit, 'HVampireMistAlly01', disabled)
        Buff.RemoveBuff(unit, 'HVampireMistSelf01')
    elseif(Validate.HasAbility(unit, 'HVampireMist02')) then
        Abil.SetAbilityState(unit, 'HVampireMist02', disabled)
        Abil.SetAbilityState(unit, 'HVampireMistAlly02', disabled)
        Buff.RemoveBuff(unit, 'HVampireMistSelf02')
    elseif(Validate.HasAbility(unit, 'HVampireMist03')) then
        Abil.SetAbilityState(unit, 'HVampireMist03', disabled)
        Abil.SetAbilityState(unit, 'HVampireMistAlly03', disabled)
        Buff.RemoveBuff(unit, 'HVampireMistSelf03')
    elseif(Validate.HasAbility(unit, 'HVampireMist04')) then
        Abil.SetAbilityState(unit, 'HVampireMist04', disabled)
        Abil.SetAbilityState(unit, 'HVampireMistAlly04', disabled)
        Buff.RemoveBuff(unit, 'HVampireMistSelf04')    end
    if(Validate.HasAbility(unit, 'HVampireBloodyHazeAlly')) then
        Abil.SetAbilityState(unit, 'HVampireBloodyHazeAlly', disabled)
    end
end

#################################################################################################################
# Mist Form - On
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMistOn',
    DisplayName = '<LOC ABILITY_Vampire_0041>Mist Form',
    Description = '<LOC ABILITY_Vampire_0042>Lord Erebus transforms into mist, draining life per second his foes while they are in the mist and transferring it to his allies.\n\n While Mist is active Lord Erebus loses Mana per second and cannot move, capture flags, be healed or use abilities.\n\nEntering Mist removes all negative effects.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    Cooldown = 10,
    SharedCooldown = 'VampMist',
    EnergyCost = 50,
    AffectRadius = 10,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'MistStart',
    AbilityCategory = 'HVAMPIREMISTOFF',
    OnStartAbility = function(self, unit, params)
        unit:GetNavigator():AbortMove()
        Buff.ApplyBuff(unit, 'HVampireMistImmobilize', unit)
        Buff.ApplyBuff(unit, 'HVampireMistInvisibility01', unit)
        ChangeState(unit, unit.MistOnState)

        # Create Mist effects
        unit.AbilityData.Vampire.MistEffects = {}
        local thd = ForkThread(FxMistForm01, self, unit, unit.AbilityData.Vampire.MistEffects)
        table.insert(unit.AbilityData.Vampire.MistEffects, thd)

        Buff.ApplyBuff(unit, 'HVampireMistOnDisable')

        Buff.ApplyBuff(unit, 'HVampireMistImmunity', unit)
        Buff.RemoveBuffsByDebuff(unit, true)

        unit.AbilityData.MistOn = true
        MistFunctionalityEntrance(unit)

        Abil.HideAbility(unit, 'HVampireMistOn')
        Abil.ShowAbility(unit, 'HVampireMistOff')
    end,
    Icon = '/DGVampLord/NewVamplordMist01',
}

#################################################################################################################
# Mist Form - Off
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMistOff',
    DisplayName = '<LOC ABILITY_Vampire_0043>Mist Off',
    Description = '<LOC ABILITY_Vampire_0044>Lord Erebus returns to his body, allowing him to move once again.',
    AbilityType = 'Instant',
    NotSilenceable = true,
    Cooldown = 3,
    SharedCooldown = 'VampMist',
    UISlot = 2,
    HotKey = '2',
    CastAction = 'MistEnd',
    AbilityCategory = 'HVAMPIREMISTON',
    MaterializeThread = function(self, unit)
        unit:RemoveEffectMeshState( 'Dissolve', false )
        unit:AddEffectMeshState( 'Materialize', string.lower(unit.Character.CharBP.Meshes.Materialize), true, true )
        unit:SetAuxMeshParam( GetGameTimeSeconds() * 10 )
        WaitSeconds( 2.6 )
        unit:RemoveEffectMeshState( 'Materialize', true )
    end,
    OnStartAbility = function(self, unit, params)
        #Destroy effects and create mist dissolution effects
        FxMistDissolve01(self, unit)
        if(unit.AbilityData.Vampire.MistEffects) then
            for k, v in unit.AbilityData.Vampire.MistEffects do
                v:Destroy()
            end
            unit.AbilityData.Vampire.MistEffects = nil
        end

        Buff.RemoveBuff(unit, 'HVampireMistImmobilize')
        Buff.RemoveBuff(unit, 'HVampireMistInvisibility01')
        Buff.RemoveBuff(unit, 'HVampireMistImmunity')
        unit:ForkThread( self.MaterializeThread, unit )
        ChangeState(unit, unit.MistOffState)

        Buff.RemoveBuff(unit, 'HVampireMistOnDisable', unit)
        unit.AbilityData.MistOn = false
        MistFunctionalityEnd(unit)

        Abil.HideAbility(unit, 'HVampireMistOff')
        Abil.ShowAbility(unit, 'HVampireMistOn')
    end,

    Icon = '/DGVampLord/NewVamplordMistOff01',
}

#################################################################################################################
# Mist Form I
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMist01',
    DisplayName = '<LOC ABILITY_Vampire_0045>Mist I',
    Description = '<LOC ABILITY_Vampire_0056>Lord Erebus transforms into mist, draining [GetDamage] life per second his foes while they are in the mist and transferring it to his allies.\n\n While Mist is active Lord Erebus loses [GetSelfMana] Mana per second and cannot move, capture flags, be healed or use abilities.\n\nEntering Mist removes all negative effects.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    GetDamage = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * -1 ) end,
    GetRegen = function(self) return math.floor( Buffs['HVampireMistAlly01'].Affects.Regen.Add ) end,
    GetSelfDamage = function(self) return ( Buffs['HVampireMistSelf01'].Affects.Health.Add * -1 ) end,
    GetSelfMana = function(self) return ( Buffs['HVampireMistSelf01'].Affects.Energy.Add * -1 ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 10,
    AuraPulseTime = 1,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMist01',
            DisplayName = '<LOC ABILITY_Vampire_0046>Mist',
            Description = '<LOC ABILITY_Vampire_0047>Taking damage.',
            BuffType = 'HVAMPIREMIST',
            Stacks = 'ALWAYS',
            DamageSelf = true,
            Debuff = true,
            CanBeDispelled = true,
            CanBeEvaded = false,
            CanBackfire = false,
            CanDamageReturn = false,
            DamageFriendly = true,
            ArmorImmune = true,
            CanCrit = false,
            CanMagicResist = false,
            IgnoreDamageRangePercent = false,
            Icon = '/DGVampLord/NewVamplordMist01',
            Duration = 1,
            DoNotPulseIcon = true,
            Affects = {
                Health = {Add = -50},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        Abil.AddAbility(unit, 'HVampireMistOff', true)
        Abil.AddAbility(unit, 'HVampireMistOn', true)
        Abil.HideAbility(unit, 'HVampireMistOff')
        if(not unit.AbilityData.MistOn) then
            local disabled = true
            Abil.SetAbilityState(unit, 'HVampireMist01', disabled)
        # This is handled when the ally mist aura is applied. Uncommenting this could lead to a sim crash. -sem
        #else
        #    MistFunctionalityEnd(unit)
        #    MistFunctionalityEntrance(unit)
        end
    end,
    OnAuraPulse = function(self, unit, params)
        if(unit.AbilityData.MistOn) then
            Buff.ApplyBuff(unit, 'HVampireMistSelf01', unit)
        end
        if unit.Sync.Energy < 50 then
            local params = { AbilityName = 'HVampireMistOff'}
            Abil.HandleAbility(unit, params)
            unit.Character:PlayAction('MistEnd')
        end
    end,
}

#################################################################################################################
# Debuff - Mist Form I
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireMistSelf01',
    DisplayName = '<LOC ABILITY_Vampire_0088>Mist I',
    Description = '<LOC ABILITY_Vampire_0048>Dealing damage per second to nearby enemies. Taking damage per second. Cannot use abilities. Immune to negative effects.',
    BuffType = 'HVAMPIREMISTSELF',
    Stacks = 'REPLACE',
    DamageSelf = true,
    Debuff = false,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    ArmorImmune = true,
    CanCrit = false,
    CanMagicResist = false,
    IgnoreDamageRangePercent = true,
    Duration = 1,
    DoNotPulseIcon = true,
    Affects = {
        #Health = {Add = -25},
        Energy = {Add = -125},
        DebuffImmune = { Bool = true },
    },
    Icon = '/DGVampLord/NewVamplordMist01',
}

#################################################################################################################
# Ally - Mist Form I
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMistAlly01',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 10,
    AuraPulseTime = 1,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMistAlly01',
            DisplayName = '<LOC ABILITY_Vampire_0088>Mist I',
            Description = '<LOC ABILITY_Vampire_0126>Healing from Lord Erebus\' mist.',
            BuffType = 'HVAMPIREMISTALLY',
            Stacks = 'REPLACE',
            Debuff = false,
            Duration = 1,
            DoNotPulseIcon = true,
            Affects = {
                Regen = {Add = 20},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        if(not unit.AbilityData.MistOn) then
            local disabled = true
            Abil.SetAbilityState(unit, 'HVampireMistAlly01', disabled)
        else
            MistFunctionalityEnd(unit)
            MistFunctionalityEntrance(unit)
        end
    end,
}

#################################################################################################################
# Mist Form II
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMist02',
    DisplayName = '<LOC ABILITY_Vampire_0049>Mist II',
    Description = '<LOC ABILITY_Vampire_0056>Lord Erebus transforms into mist, draining [GetDamage] life per second his foes while they are in the mist and transferring it to his allies.\n\n While Mist is active Lord Erebus loses [GetSelfMana] Mana per second and cannot move, capture flags, be healed or use abilities.\n\nEntering Mist removes all negative effects.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    GetDamage = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * -1 ) end,
    GetRegen = function(self) return math.floor( Buffs['HVampireMistAlly02'].Affects.Regen.Add ) end,
    GetSelfDamage = function(self) return ( Buffs['HVampireMistSelf02'].Affects.Health.Add * -1 ) end,
    GetSelfMana = function(self) return ( Buffs['HVampireMistSelf02'].Affects.Energy.Add * -1 ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 10,
    AuraPulseTime = 1,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMist02',
            DisplayName = '<LOC ABILITY_Vampire_0089>Mist',
            Description = '<LOC ABILITY_Vampire_0090>Taking damage.',
            BuffType = 'HVAMPIREMIST',
            Stacks = 'ALWAYS',
            DamageSelf = true,
            Debuff = true,
            CanBeDispelled = true,
            CanBeEvaded = false,
            CanBackfire = false,
            CanDamageReturn = false,
            DamageFriendly = true,
            ArmorImmune = true,
            CanCrit = false,
            CanMagicResist = false,
            IgnoreDamageRangePercent = false,
            Icon = '/DGVampLord/NewVamplordMist01',
            Duration = 1,
            DoNotPulseIcon = true,
            Affects = {
                Health = {Add = -75},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        if(not unit.AbilityData.MistOn) then
            local disabled = true
            Abil.SetAbilityState(unit, 'HVampireMist02', disabled)
        # This is handled when the ally mist aura is applied. Uncommenting this could lead to a sim crash. -sem
        #else
        #    MistFunctionalityEnd(unit)
        #    MistFunctionalityEntrance(unit)
        end
    end,
    OnAuraPulse = function(self, unit, params)
        if(unit.AbilityData.MistOn) then
            Buff.ApplyBuff(unit, 'HVampireMistSelf02', unit)
        end
        if unit.Sync.Energy < 150 then
            local params = { AbilityName = 'HVampireMistOff'}
            Abil.HandleAbility(unit, params)
            unit.Character:PlayAction('MistEnd')
        end
    end,
}

#################################################################################################################
# Debuff - Mist Form II
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireMistSelf02',
    DisplayName = '<LOC ABILITY_Vampire_0049>Mist II',
    Description = '<LOC ABILITY_Vampire_0050>Dealing damage per second to nearby enemies. Taking damage per second. Cannot use abilities. Immune to negative effects.',
    BuffType = 'HVAMPIREMISTSELF',
    Stacks = 'REPLACE',
    DamageSelf = true,
    Debuff = false,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    ArmorImmune = true,
    CanCrit = false,
    CanMagicResist = false,
    IgnoreDamageRangePercent = true,
    Duration = 1,
    DoNotPulseIcon = true,
    Affects = {
        #Health = {Add = -25},
        Energy = {Add = -125},
        DebuffImmune = { Bool = true },
    },
    Icon = '/DGVampLord/NewVamplordMist01',
}

#################################################################################################################
# Ally - Mist Form II
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMistAlly02',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 10,
    AuraPulseTime = 1,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMistAlly02',
            DisplayName = '<LOC ABILITY_Vampire_0049>Mist II',
            Description = '<LOC ABILITY_Vampire_0127>Healing from Lord Erebus\' mist.',
            BuffType = 'HVAMPIREMISTALLY',
            Stacks = 'REPLACE',
            Debuff = false,
            Duration = 1,
            DoNotPulseIcon = true,
            Affects = {
                Regen = {Add = 35},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        if(not unit.AbilityData.MistOn) then
            local disabled = true
            Abil.SetAbilityState(unit, 'HVampireMistAlly02', disabled)
        else
            MistFunctionalityEnd(unit)
            MistFunctionalityEntrance(unit)
        end
    end,
}

#################################################################################################################
# Mist Form III
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMist03',
    DisplayName = '<LOC ABILITY_Vampire_0051>Mist III',
    Description = '<LOC ABILITY_Vampire_0056>Lord Erebus transforms into mist, draining [GetDamage] life per second his foes while they are in the mist and transferring it to his allies.\n\n While Mist is active Lord Erebus loses [GetSelfMana] Mana per second and cannot move, capture flags, be healed or use abilities.\n\nEntering Mist removes all negative effects.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    GetDamage = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * -1 ) end,
    GetRegen = function(self) return math.floor( Buffs['HVampireMistAlly03'].Affects.Regen.Add ) end,
    GetSelfDamage = function(self) return ( Buffs['HVampireMistSelf03'].Affects.Health.Add * -1 ) end,
    GetSelfMana = function(self) return ( Buffs['HVampireMistSelf03'].Affects.Energy.Add * -1 ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 10,
    AuraPulseTime = 1,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMist03',
            DisplayName = '<LOC ABILITY_Vampire_0092>Mist',
            Description = '<LOC ABILITY_Vampire_0093>Taking damage.',
            BuffType = 'HVAMPIREMIST',
            Stacks = 'ALWAYS',
            DamageSelf = true,
            Debuff = true,
            CanBeDispelled = true,
            CanBeEvaded = false,
            CanBackfire = false,
            CanDamageReturn = false,
            DamageFriendly = true,
            ArmorImmune = true,
            CanCrit = false,
            CanMagicResist = false,
            IgnoreDamageRangePercent = false,
            Icon = '/DGVampLord/NewVamplordMist01',
            Duration = 1,
            DoNotPulseIcon = true,
            Affects = {
                Health = {Add = -100},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        if(not unit.AbilityData.MistOn) then
            local disabled = true
            Abil.SetAbilityState(unit, 'HVampireMist03', disabled)
        # This is handled when the ally mist aura is applied. Uncommenting this could lead to a sim crash. -sem
        #else
        #    MistFunctionalityEnd(unit)
        #    MistFunctionalityEntrance(unit)
        end
    end,
    OnAuraPulse = function(self, unit, params)
        if(unit.AbilityData.MistOn) then
            Buff.ApplyBuff(unit, 'HVampireMistSelf03', unit)
        end
        if unit.Sync.Energy < 225 then
            local params = { AbilityName = 'HVampireMistOff'}
            Abil.HandleAbility(unit, params)
            unit.Character:PlayAction('MistEnd')
        end
    end,
}

#################################################################################################################
# Debuff - Mist Form III
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireMistSelf03',
    BuffType = 'HVAMPIREMISTSELF',
    DisplayName = '<LOC ABILITY_Vampire_0051>Mist III',
    Description = '<LOC ABILITY_Vampire_0052>Dealing damage per second to nearby enemies. Taking damage per second. Cannot use abilities. Immune to negative effects.',
    Stacks = 'REPLACE',
    DamageSelf = true,
    Debuff = false,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    ArmorImmune = true,
    CanCrit = false,
    CanMagicResist = false,
    IgnoreDamageRangePercent = true,
    Duration = 1,
    DoNotPulseIcon = true,
    Affects = {
        #Health = {Add = -50},
        Energy = {Add = -125},
        DebuffImmune = { Bool = true },
    },
    Icon = '/DGVampLord/NewVamplordMist01',
}

#################################################################################################################
# Ally - Mist Form III
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMistAlly03',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 10,
    AuraPulseTime = 1,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMistAlly03',
            DisplayName = '<LOC ABILITY_Vampire_0094>Mist III',
            Description = '<LOC ABILITY_Vampire_0128>Healing from Lord Erebus\' mist.',
            BuffType = 'HVAMPIREMISTALLY',
            Stacks = 'REPLACE',
            Debuff = false,
            Duration = 1,
            DoNotPulseIcon = true,
            Affects = {
                Regen = {Add = 50},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        if(not unit.AbilityData.MistOn) then
            local disabled = true
            Abil.SetAbilityState(unit, 'HVampireMistAlly03', disabled)
        else
            MistFunctionalityEnd(unit)
            MistFunctionalityEntrance(unit)
        end
    end,
}

#################################################################################################################
# Mist Form IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMist04',
    DisplayName = '<LOC ABILITY_Vampire_0104>Mist IV',
    Description = '<LOC ABILITY_Vampire_0056>Lord Erebus transforms into mist, draining [GetDamage] life per second his foes while they are in the mist and transferring it to his allies.\n\n While Mist is active Lord Erebus loses [GetSelfMana] Mana per second and cannot move, capture flags, be healed or use abilities.\n\nEntering Mist removes all negative effects.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    GetDamage = function(self) return math.floor( Buffs[self.Name].Affects.Health.Add * -1 ) end,
    GetRegen = function(self) return math.floor( Buffs['HVampireMistAlly04'].Affects.Regen.Add ) end,
    GetSelfDamage = function(self) return ( Buffs['HVampireMistSelf04'].Affects.Health.Add * -1 ) end,
    GetSelfMana = function(self) return ( Buffs['HVampireMistSelf04'].Affects.Energy.Add * -1 ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 10,
    AuraPulseTime = 1,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMist04',
            DisplayName = '<LOC ABILITY_Vampire_0092>Mist',
            Description = '<LOC ABILITY_Vampire_0093>Taking damage.',
            BuffType = 'HVAMPIREMIST',
            Stacks = 'ALWAYS',
            DamageSelf = true,
            Debuff = true,
            CanBeDispelled = true,
            CanBeEvaded = false,
            CanBackfire = false,
            CanDamageReturn = false,
            DamageFriendly = true,
            ArmorImmune = true,
            CanCrit = false,
            CanMagicResist = false,
            IgnoreDamageRangePercent = false,
            Icon = '/DGVampLord/NewVamplordMist01',
            Duration = 1,
            DoNotPulseIcon = true,
            Affects = {
                Health = {Add = -125},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        if(not unit.AbilityData.MistOn) then
            local disabled = true
            Abil.SetAbilityState(unit, 'HVampireMist04', disabled)
        # This is handled when the ally mist aura is applied. Uncommenting this could lead to a sim crash. -sem
        #else
        #    MistFunctionalityEnd(unit)
        #    MistFunctionalityEntrance(unit)
        end
    end,
    OnAuraPulse = function(self, unit, params)
        if(unit.AbilityData.MistOn) then
            Buff.ApplyBuff(unit, 'HVampireMistSelf04', unit)
        end
        if unit.Sync.Energy < 300 then
            local params = { AbilityName = 'HVampireMistOff'}
            Abil.HandleAbility(unit, params)
            unit.Character:PlayAction('MistEnd')
        end
    end,
}

#################################################################################################################
# Debuff - Mist Form IV
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireMistSelf04',
    BuffType = 'HVAMPIREMISTSELF',
    DisplayName = '<LOC ABILITY_Vampire_0105>Mist IV',
    Description = '<LOC ABILITY_Vampire_0106>Dealing damage per second to nearby enemies. Taking damage per second. Cannot use abilities. Immune to negative effects.',
    Stacks = 'REPLACE',
    DamageSelf = true,
    Debuff = false,
    CanBeEvaded = false,
    CanBackfire = false,
    CanDamageReturn = false,
    DamageFriendly = true,
    ArmorImmune = true,
    CanCrit = false,
    CanMagicResist = false,
    IgnoreDamageRangePercent = true,
    Duration = 1,
    DoNotPulseIcon = true,
    Affects = {
        #Health = {Add = -300},
        Energy = {Add = -125},
        DebuffImmune = { Bool = true },
    },
    Icon = '/DGVampLord/NewVamplordMist01',
}

#################################################################################################################
# Ally - Mist Form IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireMistAlly04',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 10,
    AuraPulseTime = 1,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireMistAlly04',
            DisplayName = '<LOC ABILITY_Vampire_0105>Mist IV',
            Description = '<LOC ABILITY_Vampire_0129>Healing from Lord Erebus\' mist.',
            BuffType = 'HVAMPIREMISTALLY',
            Stacks = 'REPLACE',
            Debuff = false,
            Duration = 1,
            DoNotPulseIcon = true,
            Affects = {
                Regen = {Add = 65},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        if(not unit.AbilityData.MistOn) then
            local disabled = true
            Abil.SetAbilityState(unit, 'HVampireMistAlly04', disabled)
        else
            MistFunctionalityEnd(unit)
            MistFunctionalityEntrance(unit)
        end
    end,
}

#################################################################################################################
# Mist Form - Invisbility
#################################################################################################################
BuffBlueprint {
    Name = 'HVampireMistInvisibility01',
    BuffType = 'HVAMPIREMISTINVISIBILITY',
    Debuff = false,
    EntityCategory = 'MAKEVAMPIRES',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Cloak = {Bool = true},
    },
    OnApplyBuff = function(self, unit, instigator)
        unit:SetInvisible(true)
        unit.PriestsDoNotHeal = true
    end,
    OnBuffRemove = function(self, unit)
        unit:SetInvisible(false)
        unit.PriestsDoNotHeal = false
    end,
}

#################################################################################################################
# Bloody Haze
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireBloodyHaze',
    DisplayName = '<LOC ABILITY_Vampire_0118>Bloody Haze',
    Description = '<LOC ABILITY_Vampire_0119>Lord Erebus becomes naturally more insubstantial. Evasion increased by [GetEvasion]%. While Lord Erebus is in Mist form, he and his nearby allies receive +[GetMaxHealth] Maximum Health and an additional +[GetRegen] Health Per Second.',
    AbilityType = 'Quiet',
    GetEvasion = function(self) return math.floor( Buffs['HVampireBloodyHazeVampire'].Affects.Evasion.Add ) end,
    GetMaxHealth = function(self) return math.floor( Buffs['HVampireBloodyHazeAlly'].Affects.MaxHealth.Add ) end,
    GetRegen = function(self) return math.floor( Buffs['HVampireBloodyHazeAlly'].Affects.Regen.Add ) end,
    OnAbilityAdded = function(self, unit)
        Buff.ApplyBuff(unit, 'HVampireBloodyHazeVampire', unit)
    end,
}

BuffBlueprint {
    Name = 'HVampireBloodyHazeVampire',
    DisplayName = '<LOC ABILITY_Vampire_0120>Bloody Haze',
    Description = '<LOC ABILITY_Vampire_0121>Evasion increased.',
    BuffType = 'HVAMPIREBLOODYHAZEVAMPIRE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Evasion = {Add = 10},
    },
}

AbilityBlueprint {
    Name = 'HVampireBloodyHazeAlly',
    DisplayName = '<LOC ABILITY_Vampire_0122>Bloody Haze',
    Description = '<LOC ABILITY_Vampire_0123>Health and Health Per Second increased.',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 10,
    AuraPulseTime = 1,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireBloodyHazeAlly',
            DisplayName = '<LOC ABILITY_Vampire_0124>Bloody Haze',
            Description = '<LOC ABILITY_Vampire_0125>Health and Health Per Second increased.',
            BuffType = 'HVAMPIREBLOODYHAZEALLY',
            Stacks = 'REPLACE',
            Debuff = false,
            Icon = '/DGVampLord/NewVamplordBloodyHaze01',
            Duration = 1,
            DoNotPulseIcon = true,
            Affects = {
                MaxHealth = {Add = 500, AdjustHealth = true},
                Regen = {Add = 30},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        if(not unit.AbilityData.MistOn) then
            local disabled = true
            Abil.SetAbilityState(unit, 'HVampireBloodyHazeAlly', disabled)
        else
            MistFunctionalityEnd(unit)
            MistFunctionalityEntrance(unit)
        end
    end,
}

#################################################################################################################
# Poisoned Blood I
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampirePoisonedBlood01',
    DisplayName = '<LOC ABILITY_Vampire_0066>Poisoned Blood I',
    Description = '<LOC ABILITY_Vampire_0107>Lord Erebus\'s vampiric blood gains the ability to heal him and poison others.\n\n+[GetRegenBuff] Health Per Second.\n\nOn death, Lord Erebus drops a poisoned potion, dealing 750 damage to whoever consumes it.',
    AbilityCategory = 'HVAMPIREMISTOFF',
    AbilityType = 'Quiet',
    GetRegenBuff = function(self) return math.floor( Buffs['HVampirePoisonedBloodRegen01'].Affects.Regen.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampirePoisonedBloodRegen01',
            Debuff = false,
            Duration = -1,
            BuffType = 'HVAMPIREPOISONEDBLOOD',
            Stacks = 'REPLACE',
            DamageSelf = true,
            CanBeEvaded = false,
            Affects = {
                Regen = {Add = 15},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        unit.Loot = {
            {Loot = 'HVampirePoisonedBlood01'},#1
            {Loot = 'HVampirePoisonedBlood01'},#2
            {Loot = 'HVampirePoisonedBlood01'},#3
            {Loot = 'HVampirePoisonedBlood01'},#4
            {Loot = 'HVampirePoisonedBlood01'},#5
            {Loot = 'HVampirePoisonedBlood01'},#6
            {Loot = 'HVampirePoisonedBlood01'},#7
            {Loot = 'HVampirePoisonedBlood01'},#8
            {Loot = 'HVampirePoisonedBlood01'},#9
            {Loot = 'HVampirePoisonedBlood01'},#10
            {Loot = 'HVampirePoisonedBlood01'},#11
            {Loot = 'HVampirePoisonedBlood01'},#12
            {Loot = 'HVampirePoisonedBlood01'},#13
            {Loot = 'HVampirePoisonedBlood01'},#14
            {Loot = 'HVampirePoisonedBlood01'},#15
            {Loot = 'HVampirePoisonedBlood01'},#16
            {Loot = 'HVampirePoisonedBlood01'},#17
            {Loot = 'HVampirePoisonedBlood01'},#18
            {Loot = 'HVampirePoisonedBlood01'},#19
            {Loot = 'HVampirePoisonedBlood01'},#20
            {Loot = 'HVampirePoisonedBlood01'},#21
            {Loot = 'HVampirePoisonedBlood01'},#22
            {Loot = 'HVampirePoisonedBlood01'},#23
            {Loot = 'HVampirePoisonedBlood01'},#24
            {Loot = 'HVampirePoisonedBlood01'},#25
        }
    end,
}

#################################################################################################################
# Poisoned Blood II
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampirePoisonedBlood02',
    DisplayName = '<LOC ABILITY_Vampire_0068>Poisoned Blood II',
    Description = '<LOC ABILITY_Vampire_0059>Lord Erebus\' vampiric blood gains the ability to heal him and poison others.\n\n+[GetRegenBuff] Health Per Second.\n\nOn death, Lord Erebus drops a poisoned potion, dealing 1500 damage to whoever consumes it.',
    AbilityCategory = 'HVAMPIREMISTOFF',
    AbilityType = 'Quiet',
    GetRegenBuff = function(self) return math.floor( Buffs['HVampirePoisonedBloodRegen02'].Affects.Regen.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampirePoisonedBloodRegen02',
            Debuff = false,
            Duration = -1,
            BuffType = 'HVAMPIREPOISONEDBLOOD',
            Stacks = 'REPLACE',
            DamageSelf = true,
            CanBeEvaded = false,
            Affects = {
                Regen = {Add = 20},
            },
        },
    },
    OnAbilityAdded = function(self, unit)
        unit.Loot = {
            {Loot = 'HVampirePoisonedBlood02'},#1
            {Loot = 'HVampirePoisonedBlood02'},#2
            {Loot = 'HVampirePoisonedBlood02'},#3
            {Loot = 'HVampirePoisonedBlood02'},#4
            {Loot = 'HVampirePoisonedBlood02'},#5
            {Loot = 'HVampirePoisonedBlood02'},#6
            {Loot = 'HVampirePoisonedBlood02'},#7
            {Loot = 'HVampirePoisonedBlood02'},#8
            {Loot = 'HVampirePoisonedBlood02'},#9
            {Loot = 'HVampirePoisonedBlood02'},#10
            {Loot = 'HVampirePoisonedBlood02'},#11
            {Loot = 'HVampirePoisonedBlood02'},#12
            {Loot = 'HVampirePoisonedBlood02'},#13
            {Loot = 'HVampirePoisonedBlood02'},#14
            {Loot = 'HVampirePoisonedBlood02'},#15
            {Loot = 'HVampirePoisonedBlood02'},#16
            {Loot = 'HVampirePoisonedBlood02'},#17
            {Loot = 'HVampirePoisonedBlood02'},#18
            {Loot = 'HVampirePoisonedBlood02'},#19
            {Loot = 'HVampirePoisonedBlood02'},#20
            {Loot = 'HVampirePoisonedBlood02'},#21
            {Loot = 'HVampirePoisonedBlood02'},#22
            {Loot = 'HVampirePoisonedBlood02'},#23
            {Loot = 'HVampirePoisonedBlood02'},#24
            {Loot = 'HVampirePoisonedBlood02'},#25
        }
    end,
}

#################################################################################################################
# Vampiric Aura I
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireVampiricAura01',
    DisplayName = '<LOC ABILITY_Vampire_0053>Vampiric Aura',
    Description = '<LOC ABILITY_Vampire_0069>Lord Erebus gains a Life Steal Aura.',
    AbilityCategory = 'HVAMPIREMISTOFF',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    Tooltip = {
        TargetAlliance = 'Ally',
        DescriptionValues = {
            10,
        },
    },
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 20,
    AuraPulseTime = 2,
    Buffs = {
        BuffBlueprint {
            Name = 'HVampireVampiricAura01',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Vampire_0053>Vampiric Aura',
            Description = '<LOC ABILITY_Vampire_0054>Life Steal increased.',
            BuffType = 'HVAMPIREVAMPIRICAURA',
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                LifeSteal = {Add = 0.10},
            },
            Icon = '/DGVampLord/NewVamplordVampiricAura01',
        },
        BuffBlueprint {
            Name = 'HVampireVampiricAura01FX',
            Debuff = false,
            Description = '<LOC ABILITY_Vampire_0095>Vampiric Aura Effects',
            BuffType = 'HVAMPIRELIFESTEALAURAFX',
            Stacks = 'IGNORE',
            Duration = 6,
            Affects = {
                Dummy = {},
            },
            OnApplyBuff = function( self, unit, instigator )
                if unit != instigator then
                    AttachBuffEffectAtBone( unit, 'Lifesteal01', -2, unit.Buffs.BuffTable[self.BuffType][self.Name].Trash )
                end
            end,
        },
    },
    CreateAbilityAmbients = function(self, unit, trash)
        FxVampiricAura01(unit, trash)
    end,
    Icon = '/DGVampLord/NewVamplordVampiricAura01',
}

#################################################################################################################
# VFX - Vampiric Aura
#################################################################################################################
function FxVampiricAura01(unit, trash)
    trash:Destroy()
    local fx = AttachCharacterEffectsAtBone( unit, 'vampire_lord', 'VampiricAura01', -2, trash )
    for k, vEffect in fx do
        unit.TrashOnKilled:Add(vEffect)
    end
end

#################################################################################################################
# Epic Death
#################################################################################################################

function FxEpicDeathBats01( unit )
    local proj = nil

    DeathEffectEntity01 = import('/lua/sim/Entity.lua').Entity()
    DeathEffectEntity02 = import('/lua/sim/Entity.lua').Entity()
    local entPos = table.copy(unit:GetPosition())
    Warp(DeathEffectEntity01, entPos)
    entPos[2] = entPos[2]+20
    Warp(DeathEffectEntity02, entPos)

    local segments = 9
    local radius = 6

    local angle = (2*math.pi) / segments

    for i = 1, segments do
        local s = math.sin(i*angle)
        local c = math.cos(i*angle)
        local x = s * (radius + GetRandomFloat( -1.0, 1.0 ))
        local z = c * (radius + GetRandomFloat( -1.0, 1.0 ))

        local proj = unit:CreateProjectile( '/projectiles/BatEffect01/BatEffect01_proj.bp', x, 10, z, 0, GetRandomFloat( -1.0, -1.8 ), 0 )
        proj:SetNewTarget( DeathEffectEntity01 )

        local velocity = GetRandomFloat( 15, 25 )
        proj:SetVelocity( velocity )
        proj:SetLifetime( GetRandomFloat( 1.0, 1.3 ) )
        proj:SetTurnRate( 100 )

        WaitSeconds(GetRandomFloat( 0.1, 0.2 ))
        proj:SetTurnRate( 200 )
        proj:SetNewTarget( DeathEffectEntity02 )
    end
end

function FxEpicDeathMistTendrils01( unit )
    local LoopCount = 6
    while LoopCount > 0 do
        local proj = unit:CreateProjectile( '/projectiles/MistEffect06/MistEffect06_proj.bp', 0, 2.8, 0, 0, 1, 0 ):SetLifetime( 3 )
        WaitSeconds(GetRandomFloat( 0.2, 0.4 ))

        proj = unit:CreateProjectile( '/projectiles/MistEffect07/MistEffect07_proj.bp', 0, 1.2, 0, 0, 1, 0 ):SetLifetime( 3 )
        WaitSeconds(GetRandomFloat( 0.2, 0.4 ))
        LoopCount = LoopCount - 1
    end
end

VampireLordDeath = function( unit, abil )
    AttachEffectsAtBone( unit, EffectTemplates.VampireLord.EpicDeath01, -2 )
    #local thd = unit:ForkThread(FxEpicDeathBats01)
    local thd = unit:ForkThread(FxEpicDeathMistTendrils01)
    WaitSeconds(1)

    # Dissolve the Vamp Lords shader.
    unit:AddEffectMeshState( 'Dissolve', string.lower(unit.Character.CharBP.Meshes.Dissolve), true, true )
    unit:SetAuxMeshParam( GetGameTimeSeconds() * 10 )

    # Apply life leech to all friendly entities nearby
    local entities = GetEntitiesInSphere("UNITS", table.copy(unit:GetPosition()), abil.AffectRadius)

    for k,entity in entities do
        if IsAlly(unit:GetArmy(),entity:GetArmy()) and not entity:IsDead() and not EntityCategoryContains(categories.NOBUFFS, entity) and not EntityCategoryContains(categories.UNTARGETABLE, entity) then
            Buff.ApplyBuff(entity, abil.FriendlyDeathBuff, entity)
        end
    end
end

BuffBlueprint {
    Name = 'HVampireDeathLifeLeechBuff01',
    Debuff = true,
    CanBeDispelled = true,
    DisplayName = '<LOC ABILITY_Vampire_0055>Blood Lust',
    Description = '<LOC ABILITY_Vampire_0054>Life Steal increased.',
    BuffType = 'HVAMPIREDEATHLIFESTEAL',
    Stacks = 'REPLACE',
    Duration = 15,
    Affects = {
        LifeSteal = {Add = 0.10},
    },
    Icon = '/DGVampLord/NewVamplordVampiricAura01',

    # Temp buff effect for this event
    Effects = 'Lifesteal01',
    EffectsBone = -2,
}

AbilityBlueprint {
    Name = 'HVampireDeath01',
    DisplayName = 'Death',
    Description = 'Vampire Lord death functional ability',
    AbilityType = 'Quiet',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    NoCastAnim = true,
    AffectRadius = 10,
    FriendlyDeathBuff = 'HVampireDeathLifeLeechBuff01',
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnKilled:Add(self.Death, self)
    end,
    Death = function(self, unit)
        unit:ForkThread(VampireLordDeath, self)
    end,
}

#################################################################################################################
# Ability Icons and descriptions
#################################################################################################################
AbilityBlueprint {
    Name = 'HVampireBiteGrey01',
    DisplayName = '<LOC ABILITY_Vampire_0004>Bite I',
    Description = '<LOC ABILITY_Vampire_0005>Lord Erebus bites a target, draining [GetAmount] Health. For [GetDuration] seconds after the bite, the target\'s Armor is reduced by [GetArmorBuff] and Movement Speed is decreased by [GetMovementBuff]%.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    GetMaxRange = function(self) return Ability['HVampireBite01'].RangeMax end,
    GetAmount = function(self) return math.floor( Ability['HVampireBite01'].Amount ) end,
    GetDuration = function(self) return math.floor( Buffs['HVampireBiteTarget01'].Duration ) end,
    GetMovementBuff = function(self) return math.floor( Buffs['HVampireBiteTarget01'].Affects.MoveMult.Mult * -100 ) end,
    GetArmorBuff = function(self) return math.floor( Buffs['HVampireBiteTarget01'].Affects.Armor.Add * -1 ) end,
    GetEnergyCost = function(self) return Ability['HVampireBite01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HVampireBite01'].CastingTime end,
    GetCooldown = function(self) return Ability['HVampireBite01'].Cooldown end,
    UISlot = 1,
    HotKey = '1',
    NoCastAnim = true,
    Placeholder = true,
    Icon = '/DGVampLord/NewVamplordBite01',
}

AbilityBlueprint {
    Name = 'HVampireMistGrey01',
    DisplayName = '<LOC ABILITY_Vampire_0041>Mist Form',
    Description = '<LOC ABILITY_Vampire_0056>Lord Erebus transforms into mist, draining [GetDamage] life per second his foes while they are in the mist and transferring it to his allies.\n\n While Mist is active Lord Erebus loses [GetSelfMana] Mana per second and cannot move, capture flags, be healed or use abilities.\n\nEntering Mist removes all negative effects.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    GetMaxRange = function(self) return Ability['HVampireMist01'].RangeMax end,
    GetDamage = function(self) return math.floor( Buffs['HVampireMist01'].Affects.Health.Add * -1 ) end,
    GetRegen = function(self) return math.floor( Buffs['HVampireMistAlly01'].Affects.Regen.Add ) end,
    GetSelfDamage = function(self) return ( Buffs['HVampireMistSelf01'].Affects.Health.Add * -1 ) end,
    GetSelfMana = function(self) return ( Buffs['HVampireMistSelf01'].Affects.Energy.Add * -1 ) end,
    GetEnergyCost = function(self) return Ability['HVampireMistOn'].EnergyCost end,
    GetCastTime = function(self) return Ability['HVampireMistOn'].CastingTime end,
    GetCooldown = function(self) return Ability['HVampireMistOn'].Cooldown end,
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    Placeholder = true,
    Icon = '/DGVampLord/NewVamplordMist01',
}

AbilityBlueprint {
    Name = 'HVampireMassCharmGrey01',
    DisplayName = '<LOC ABILITY_Vampire_0033>Mass Charm I',
    Description = '<LOC ABILITY_Vampire_0034>Stuns enemies around Lord Erebus for [GetMistStun] seconds. Demigods are stunned for [GetHeroMistStun] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    GetMaxRange = function(self) return Ability['HVampireMassCharm01'].RangeMax end,
    GetMistStun = function(self) return math.floor( Buffs['HVampireMassCharm01'].Duration ) end,
    GetHeroMistStun = function(self) return ( Buffs['HVampireMassCharm01Hero'].Duration ) end,
    GetEnergyCost = function(self) return Ability['HVampireMassCharm01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HVampireMassCharm01'].CastingTime end,
    GetCooldown = function(self) return Ability['HVampireMassCharm01'].Cooldown end,
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    Placeholder = true,
    Icon = '/DGVampLord/NewVamplordcharm01',
}


AbilityBlueprint {
    Name = 'HVampireBatSwarmGrey01',
    DisplayName = '<LOC ABILITY_Vampire_0000>Bat Swarm I',
    Description = '<LOC ABILITY_Vampire_0001>Lord Erebus transforms into a swarm of bats, teleporting him to a new location and doing [GetDamageAmt] damage to everything in his path. Range of [GetRange].',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    GetMaxRange = function(self) return Ability['HVampireBatSwarm01'].RangeMax end,
    GetDamageAmt = function(self) return math.floor( Ability['HVampireBatSwarm01'].DamageAmt ) end,
    GetRange = function(self) return math.floor( Ability['HVampireBatSwarm01'].RangeMax ) end,
    GetEnergyCost = function(self) return Ability['HVampireBatSwarm01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HVampireBatSwarm01'].CastingTime end,
    GetCooldown = function(self) return Ability['HVampireBatSwarm01'].Cooldown end,
    UISlot = 4,
    HotKey = '4',
    NoCastAnim = true,
    Placeholder = true,
    Icon = '/DGVamplord/NewVamplordBatSwarm01',
}
__moduleinfo.auto_reload = true
