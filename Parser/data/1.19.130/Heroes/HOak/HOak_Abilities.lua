local Buff = import('/lua/sim/buff.lua')
local Validate = import('/lua/common/ValidateAbility.lua')
local Abil = import('/lua/sim/ability.lua')
local RippleWorld = import('/lua/utilities.lua').RippleWorld
local GetRandomFloat = import('/lua/utilities.lua').GetRandomFloat
local MsgsFailure = import('/lua/ui/game/HUD_msgs_failure.lua').ShowFailureMsg

#################################################################################################################
# VFX
# Shield
#################################################################################################################
function FxShieldActivate(unit)
    AttachBuffEffectAtBone( unit, 'ShieldActivate01', -2 );
end

function FxShieldDeActivate(unit)
    AttachBuffEffectAtBone( unit, 'ShieldDeactivate01', -2 );
end

#################################################################################################################
# Shield I
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKShield01',
    DisplayName = '<LOC ABILITY_HOak_0000>Shield I',
    Description = '<LOC ABILITY_HOak_0062>Oak grants a shield to a target, making them immune to damage for [GetBuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    EnergyCost = 400,
    RangeMax = 20,
    Cooldown = 35,
    CastingTime = 0.1,
    FollowThroughTime = 0.7,
    CastAction = 'Shield',
    UISlot = 1,
    HotKey = '1',
    GetBuffDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKShield01',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HOak_0002>Shield',
            Description = '<LOC ABILITY_HOak_0003>Invincible.',
            BuffType = 'HOAKSHIELD',
            Stacks = 'REPLACE',
            Duration = 3,
            Affects = {
                Invincible = { Bool = true },
                #DebuffImmune = { Bool = true },
            },
            Effects = 'Shield01',
            EffectsBone = -2,
            Icon = '/DGOak/NewOakShield01',
            OnBuffAffect = function(self, unit, instigator)
                Buff.RemoveBuffsByDebuff(unit, true)
                unit:SetInvulnerableMesh(true)

                # Shield activation effects
                FxShieldActivate( unit )
            end,
            OnBuffRemove = function(self, unit )
                # Shield deactivation effects
                FxShieldDeActivate( unit )
                unit:PlaySound('Forge/DEMIGODS/Oak/snd_dg_oak_shield_end')
                unit:SetInvulnerableMesh(false)
            end,
        },
    },
    Icon = '/DGOak/NewOakShield01',
}

#################################################################################################################
# Shield II
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKShield02',
    DisplayName = '<LOC ABILITY_HOak_0004>Shield II',
    Description = '<LOC ABILITY_HOak_0062>Oak grants a shield to a target, making them immune to damage for [GetBuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    EnergyCost = 500,
    RangeMax = 20,
    Cooldown = 35,
    CastingTime = 0.1,
    FollowThroughTime = 0.7,
    CastAction = 'Shield',
    UISlot = 1,
    HotKey = '1',
    GetBuffDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKShield02',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HOak_0002>Shield',
            Description = '<LOC ABILITY_HOak_0003>Invincible.',
            BuffType = 'HOAKSHIELD',
            Stacks = 'REPLACE',
            Duration = 4,
            Affects = {
                Invincible = { Bool = true },
                #DebuffImmune = { Bool = true },
            },
            Effects = 'Shield01',
            EffectsBone = -2,
            Icon = '/DGOak/NewOakShield01',
            OnBuffAffect = function(self, unit, instigator)
                Buff.RemoveBuffsByDebuff(unit, true)
                unit:SetInvulnerableMesh(true)

                # Shield activation effects
                FxShieldActivate( unit )
            end,
            OnBuffRemove = function(self, unit )
                # Shield deactivation effects
                FxShieldDeActivate( unit )
                unit:PlaySound('Forge/DEMIGODS/Oak/snd_dg_oak_shield_end')
                unit:SetInvulnerableMesh(false)
            end,
        },
    },
    Icon = '/DGOak/NewOakShield01',
}

#################################################################################################################
# Shield III
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKShield03',
    DisplayName = '<LOC ABILITY_HOak_0006>Shield III',
    Description = '<LOC ABILITY_HOak_0001>Oak grants a shield to a target, making them immune to damage for [GetBuffDuration] seconds. This more powerful variant of Shield also removes debuffs.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    EnergyCost = 600,
    RangeMax = 20,
    Cooldown = 35,
    CastingTime = 0.1,
    FollowThroughTime = 0.7,
    CastAction = 'Shield',
    UISlot = 1,
    HotKey = '1',
    GetBuffDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKShield03',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HOak_0002>Shield',
            Description = '<LOC ABILITY_HOak_0003>Invincible.',
            BuffType = 'HOAKSHIELD',
            Stacks = 'REPLACE',
            Duration = 6,
            Affects = {
                Invincible = { Bool = true },
                DebuffImmune = { Bool = true },

            },
            Effects = 'Shield01',
            EffectsBone = -2,
            Icon = '/DGOak/NewOakShield01',
            OnBuffAffect = function(self, unit, instigator)
                Buff.RemoveBuffsByDebuff(unit, true)
                unit:SetInvulnerableMesh(true)

                # Shield activation effects
                FxShieldActivate( unit )
            end,
            OnBuffRemove = function(self, unit )
                # Shield deactivation effects
                FxShieldDeActivate( unit )
                unit:PlaySound('Forge/DEMIGODS/Oak/snd_dg_oak_shield_end')
                unit:SetInvulnerableMesh(false)
            end,
        },
    },
    Icon = '/DGOak/NewOakShield01',
}

#################################################################################################################
# Shield IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKShield04',
    DisplayName = '<LOC ABILITY_HOak_0066>Shield IV',
    Description = '<LOC ABILITY_HOak_0063>Oak grants a shield to a target, making them immune to damage [GetBuffDuration] seconds. Also, this powerful version of Shield removes debuffs and heals for [GetHealAmount].',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    EnergyCost = 700,
    RangeMax = 20,
    Cooldown = 35,
    CastingTime = 0.1,
    FollowThroughTime = 0.7,
    HealAmt = 600,
    CastAction = 'Shield',
    UISlot = 1,
    HotKey = '1',
    GetBuffDuration = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetHealAmount = function(self) return math.floor( self.HealAmt ) end,
    OnStartAbility = function(self, unit, params)
        Heal01(self, unit, params)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKShield04',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HOak_0002>Shield',
            Description = '<LOC ABILITY_HOak_0003>Invincible.',
            BuffType = 'HOAKSHIELD',
            Stacks = 'REPLACE',
            Duration = 6,
            Affects = {
                Invincible = { Bool = true },
                DebuffImmune = { Bool = true },

            },
            Effects = 'Shield01',
            EffectsBone = -2,
            Icon = '/DGOak/NewOakShield01',
            OnBuffAffect = function(self, unit, instigator)
                Buff.RemoveBuffsByDebuff(unit, true)
                unit:SetInvulnerableMesh(true)

                # Shield activation effects
                FxShieldActivate( unit )

                if(Validate.HasAbility(instigator, 'HOakPurity')) and unit != instigator then
                    Buff.ApplyBuff(instigator, 'HOakPurity', instigator)
                end
            end,
            OnBuffRemove = function(self, unit )
                # Shield deactivation effects
                FxShieldDeActivate( unit )
                unit:PlaySound('Forge/DEMIGODS/Oak/snd_dg_oak_shield_end')
                unit:SetInvulnerableMesh(false)
            end,
        },
    },
    Icon = '/DGOak/NewOakShield01',
}
#################################################################################################################
# CE
# Heal I
#################################################################################################################
function Heal01(def, unit, params)
    local data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = unit:GetArmy(),
        Amount = def.HealAmt * -1,
        IgnoreDamageRangePercent = true,
        Type = 'Spell',
        DamageAction = def.Name,
        DamageSelf = true,
        DamageFriendly = true,
        Origin = unit:GetPosition(),
        CanDamageReturn = false,
        CanCrit = false,
        CanBackfire = false,
        CanBeEvaded = false,
        CanMagicResist = true,
        ArmorImmune = true,
        Group = "UNITS",
    }
    if(unit and not unit:IsDead()) then
        # Heal Target
        DealDamage(data, params.Targets[1])
    end

    # Create Sedna heal effects
    #FxHeal01( unit, params.Targets[1] )
end

#################################################################################################################
# Purity
#################################################################################################################
AbilityBlueprint {
    Name = 'HOakPurity',
    DisplayName = '<LOC ABILITY_HOAK_0000>Purity',
    Description = '<LOC ABILITY_HOAK_0001>When Oak uses Shield on an ally, all of his negative effects are removed, and he is immune to all negative effects for [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
}

BuffBlueprint {
    Name = 'HOakPurity',
    DisplayName = '<LOC ABILITY_HOAK_0002>Purity',
    Description = '<LOC ABILITY_HOAK_0003>Immune to all negative effects.',
    BuffType = 'HOAKPURITY',
    Stacks = 'REPLACE',
    Duration = 6,
    EntityCategory = 'MOBILE - UNTARGETABLE',
    Debuff = false,
    Affects = {
        DebuffImmune = { Bool = true },
    },
    Effects = 'Shield01',
    EffectsBone = -2,
    Icon = '/DGOak/NewOakPurity01',
    OnBuffAffect = function(self, unit, instigator)
        Buff.RemoveBuffsByDebuff(unit, true)
        # Shield activation effects
        FxShieldActivate( unit )
    end,
    OnBuffRemove = function(self, unit )
        # Shield deactivation effects
        FxShieldDeActivate( unit )
    end,
}

#################################################################################################################
# VFX
# Penitence
#################################################################################################################
function FxCastPenitence( unit )
    # Arc from Oaks axe
    AttachEffectAtBone( unit, 'Oak', 'PenitenceCast01', -2 )
end

function FxPenitence(self, unit, params)
    local OakPos = table.copy(unit:GetPosition())
    local TargetPos = params.Target.Position
    local target = params.Targets[1]
    local dir = VDiff(TargetPos,OakPos)
    local dist = VLength( dir )
    dir = VNormal(dir)

    # Target impact, scaled to unit buff classification size
    CreateTemplatedEffectAtPos( 'Oak', 'PenitenceTarget01', target:GetEffectBuffClassification(), unit:GetArmy(), TargetPos, dir )

    # Flash on Oaks axe
    AttachEffectAtBone( unit, 'Oak', 'PenitenceAxe01', 'sk_Oak_AxeTip_REF' )
    # Force arc from Oaks axe
    AttachEffectAtBone( unit, 'Oak', 'PenitenceAxe02', -2 )

    # Air force waves, from Oak to Target, adjusted for distance
    for k, v in EffectTemplates.Oak.PenitenceWave01 do
        local emit = CreateEmitterPositionVector(OakPos, dir, -1, v)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist * 0.165, 0.0)
    end

    # Ground force wake, from Oak to Target, adjusted for distance
    for k, v in EffectTemplates.Oak.PenitenceGroundWave01 do
        local emit = CreateEmitterPositionVector(OakPos, dir, -1, v)
        emit:SetEmitterParam('LIFETIME', dist * 0.2 )
    end
end

#################################################################################################################
# CE
# Penitence - This function deals damage associated with Penitence
#################################################################################################################
function Penitence(def, unit, params)
    # Damage
    local data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = unit:GetArmy(),
        Amount = def.DamageAmt,
        Origin = params.Targets[1]:GetPosition(),
        CanDamageReturn = false,
        CanCrit = false,
        CanBackfire = false,
        CanBeEvaded = false,
        CanMagicResist = true,
        Type = 'Spell',
        DamageAction = def.Name,
        ArmorImmune = true,
        IgnoreDamageRangePercent = true,
    }
    DealDamage(data,params.Targets[1])
end

#################################################################################################################
# Penitence I
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKPenitence01',
    DisplayName = '<LOC ABILITY_HOak_0008>Penitence I',
    Description = '<LOC ABILITY_HOak_0009>Oak fills a target with holy remorse, dealing [GetDamage] damage, reducing their Movement Speed by [GetMoveSpeedPercent]% and increasing all damage taken by [GetDamageIncPercent]% for [GetBuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 450,
    RangeMax = 20,
    Cooldown = 7,
    CastingTime = 0.1,
    FollowThroughTime = 0.7,
    CastAction = 'Penitence',
    UISlot = 2,
    HotKey = '2',
    DamageAmt = 200,
    DamageType = 'Spell',

    GetMoveSpeedPercent = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    GetDamageIncPercent = function(self) return math.floor( Buffs[self.Name].Affects.DamageTakenMult.Add * 100 ) end,
    GetBuffDuration = function(self) return Buffs[self.Name].Duration end,

    OnStartCasting = function(self, unit, params)
        # Penitence ability casting effects
        FxCastPenitence( unit )
    end,
    OnStartAbility = function(self, unit, params)
        # Penitence ability effects
        FxPenitence( self, unit, params )
       # Damage
        Penitence( self, unit, params)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKPenitence01',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_HOak_0010>Penitence',
            Description = '<LOC ABILITY_HOak_0011>Movement Speed reduced. All damage taken increased.',
            BuffType = 'HOAKPENITENCE',
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                MoveMult = {Mult = -0.07},
                DamageTakenMult = {Add = 0.07}
            },
            Effects = 'Slow01',
            EffectsBone = -2,
            Icon = '/DGOak/NewOakPenitence01',
        },
        BuffBlueprint {
            Name = 'HOAKPenitenceInterrupt01',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_HOak_0056>Penitence I',
            Description = '<LOC ABILITY_HOak_0057>Interrupted',
            BuffType = 'HOAKPENITENCESTUN',
            Stacks = 'REPLACE',
            Duration = 0.1,
            Affects = {
                Interrupt = {Add = 0},
            },
        },
    },
    Icon = '/DGOak/NewOakPenitence01',
}

#################################################################################################################
# Penitence II
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKPenitence02',
    DisplayName = '<LOC ABILITY_HOak_0012>Penitence II',
    Description = '<LOC ABILITY_HOak_0009>Oak fills a target with holy remorse, dealing [GetDamage] damage, reducing their Movement Speed by [GetMoveSpeedPercent]% and increasing all damage taken by [GetDamageIncPercent]% for [GetBuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 550,
    RangeMax = 20,
    Cooldown = 7,
    CastingTime = 0.1,
    FollowThroughTime = 0.7,
    CastAction = 'Penitence',
    UISlot = 2,
    HotKey = '2',
    DamageAmt = 400,
    DamageType = 'Spell',

    GetMoveSpeedPercent = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    GetDamageIncPercent = function(self) return math.floor( Buffs[self.Name].Affects.DamageTakenMult.Add * 100 ) end,
    GetBuffDuration = function(self) return Buffs[self.Name].Duration end,

    OnStartCasting = function(self, unit, params)
        # Penitence ability casting effects
        FxCastPenitence( unit )
    end,
    OnStartAbility = function(self, unit, params)
        # Penitence ability effects
        FxPenitence( self, unit, params )
        # Damage
        Penitence( self, unit, params)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKPenitence02',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_HOak_0010>Penitence',
            Description = '<LOC ABILITY_HOak_0011>Movement Speed reduced. All damage taken increased.',
            BuffType = 'HOAKPENITENCE',
            Stacks = 'REPLACE',
            Duration = 6,
            Affects = {
                MoveMult = {Mult = -0.10},
                DamageTakenMult = {Add = 0.10}
            },
            Effects = 'Slow01',
            EffectsBone = -2,
            Icon = '/DGOak/NewOakPenitence01',
        },
        BuffBlueprint {
            Name = 'HOAKPenitenceInterrupt02',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_HOak_0058>Penitence II',
            Description = '<LOC ABILITY_HOak_0059>Interrupted',
            BuffType = 'HOAKPENITENCESTUN',
            Stacks = 'REPLACE',
            Duration = 0.1,
            Affects = {
                Interrupt = {Add = 0},
            },
        },
    },
    Icon = '/DGOak/NewOakPenitence01',
}

#################################################################################################################
# Penitence III
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKPenitence03',
    DisplayName = '<LOC ABILITY_HOak_0014>Penitence III',
    Description = '<LOC ABILITY_HOak_0009>Oak fills a target with holy remorse, dealing [GetDamage] damage, reducing their Movement Speed by [GetMoveSpeedPercent]% and increasing all damage taken by [GetDamageIncPercent]% for [GetBuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 650,
    RangeMax = 20,
    Cooldown = 7,
    CastingTime = 0.1,
    FollowThroughTime = 0.7,
    CastAction = 'Penitence',
    UISlot = 2,
    HotKey = '2',
    DamageAmt = 600,
    DamageType = 'Spell',

    GetMoveSpeedPercent = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    GetDamageIncPercent = function(self) return math.floor( Buffs[self.Name].Affects.DamageTakenMult.Add * 100 ) end,
    GetBuffDuration = function(self) return Buffs[self.Name].Duration end,

    OnStartCasting = function(self, unit, params)
        # Penitence ability casting effects
        FxCastPenitence( unit )
    end,
    OnStartAbility = function(self, unit, params)
        # Penitence ability effects
        FxPenitence( self, unit, params )
        # Damage
        Penitence( self, unit, params)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKPenitence03',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_HOak_0010>Penitence',
            Description = '<LOC ABILITY_HOak_0011>Movement Speed reduced. All damage taken increased.',
            BuffType = 'HOAKPENITENCE',
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                MoveMult = {Mult = -0.13},
                DamageTakenMult = {Add = 0.13}
            },
            Effects = 'Slow01',
            EffectsBone = -2,
            Icon = '/DGOak/NewOakPenitence01',
        },
        BuffBlueprint {
            Name = 'HOAKPenitenceInterrupt03',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_HOak_0060>Penitence III',
            Description = '<LOC ABILITY_HOak_0061>Interrupted',
            BuffType = 'HOAKPENITENCESTUN',
            Stacks = 'REPLACE',
            Duration = 0.1,
            Affects = {
                Interrupt = {Add = 0},
            },
        },
    },
    Icon = '/DGOak/NewOakPenitence01',
}

#################################################################################################################
# Penitence IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKPenitence04',
    DisplayName = '<LOC ABILITY_HOak_0067>Penitence IV',
    Description = '<LOC ABILITY_HOak_0009>Oak fills a target with holy remorse, dealing [GetDamage] damage, reducing their Movement Speed by [GetMoveSpeedPercent]% and increasing all damage taken by [GetDamageIncPercent]% for [GetBuffDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 750,
    RangeMax = 20,
    Cooldown = 7,
    CastingTime = 0.1,
    FollowThroughTime = 0.7,
    CastAction = 'Penitence',
    UISlot = 2,
    HotKey = '2',
    DamageAmt = 800,
    DamageType = 'Spell',

    GetMoveSpeedPercent = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    GetDamageIncPercent = function(self) return math.floor( Buffs[self.Name].Affects.DamageTakenMult.Add * 100 ) end,
    GetBuffDuration = function(self) return Buffs[self.Name].Duration end,

    OnStartCasting = function(self, unit, params)
        # Penitence ability casting effects
        FxCastPenitence( unit )
    end,
    OnStartAbility = function(self, unit, params)
        # Penitence ability effects
        FxPenitence( self, unit, params )
        # Damage
        Penitence( self, unit, params)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKPenitence04',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_HOak_0010>Penitence',
            Description = '<LOC ABILITY_HOak_0011>Movement Speed reduced. All damage taken increased.',
            BuffType = 'HOAKPENITENCE',
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                MoveMult = {Mult = -0.16},
                DamageTakenMult = {Add = 0.16}
            },
            Effects = 'Slow01',
            EffectsBone = -2,
            Icon = '/DGOak/NewOakPenitence01',
        },
        BuffBlueprint {
            Name = 'HOAKPenitenceInterrupt04',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_HOak_0067>Penitence IV',
            Description = '<LOC ABILITY_HOak_0061>Interrupted',
            BuffType = 'HOAKPENITENCESTUN',
            Stacks = 'REPLACE',
            Duration = 0.1,
            Affects = {
                Interrupt = {Add = 0},
            },
        },
    },
    Icon = '/DGOak/NewOakPenitence01',
}
#################################################################################################################
# VFX
# Surge of Faith
#################################################################################################################

function CrossVector( v1, v2 )
	return Vector( (v1.y * v2.z) - (v1.z * v2.y), (v1.z * v2.x) - (v1.x * v2.z ), (v1.x * v2.y) - (v1.y - v2.x))
end

function FxSurgeFaith( unit, pos )
    # Main effects at base and axe
    CreateTemplatedEffectAtPos( 'Oak', nil, 'SurgeFaith01', unit:GetArmy(), pos )
    AttachEffectAtBone( unit, 'Oak', 'SurgeFaithAxe01', 'sk_Oak_AxeTip_REF' )
end

function FxSurgeFaithCharge(self, unit)
    # Create casting effects
    AttachEffectAtBone( unit, 'Oak', 'SurgeFaithAxeCharge01', 'sk_Oak_AxeTip_REF' )
    AttachEffectAtBone( unit, 'Oak', 'SurgeFaithFeetCharge01', -2 )
    AttachEffectAtBone( unit, 'Oak', 'SurgeFaithHeadCharge01', 'sk_Oak_Head' )

    local fwdVec = ForwardVector(unit:GetOrientation())
    local pos = table.copy(unit:GetPosition())
    pos[2] = 100
    local army = unit:GetArmy()

    # Side force waves
    local crossVec = CrossVector( fwdVec, Vector(0,1,0) )
    CreateTemplatedEffectAtPos( 'Oak', nil, 'SurgeFaithArcs01', army, pos, crossVec )
    CreateTemplatedEffectAtPos( 'Oak', nil, 'SurgeFaithArcs01', army, pos, {-crossVec[1], -crossVec[2], -crossVec[3]} )
end

#################################################################################################################

# Body function for Surge of Faith; Applies the buffs and debuffs to allies and enemies then
# does damage in an area
function SurgeOfFaithFunction(ability, unit, params)
    local pos = table.copy(unit:GetPosition())
    local aiBrain = unit:GetAIBrain()
    local army = unit:GetArmy()

    local allies = aiBrain:GetUnitsAroundPoint( categories.ALLUNITS - categories.UNTARGETABLE, pos, ability.AffectRadius, 'Ally' )
    local enemies = aiBrain:GetUnitsAroundPoint( categories.ALLUNITS - categories.UNTARGETABLE, pos, ability.AffectRadius, 'Enemy' )

    # Create surge faith effects
    FxSurgeFaith(unit, pos)

    for k,v in allies do
        if v:IsDead() then
            continue
        end

        Buff.ApplyBuff(v, ability.BuffName, unit)
    end

# 10/6 - MDM - commenting out to remove debuffs
#    for k,v in enemies do
#        if v:IsDead() then
#            continue
#        end
#
#        Buff.ApplyBuff(v, ability.DebuffName, unit)
#    end

    local data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = army,
        Origin = pos,
        Amount = ability.DamageAmt,
        Type = ability.DamageType,
        DamageAction = ability.Name,
        Radius = ability.AffectRadius,
        DamageFriendly = false,
        DamageSelf = false,
        Group = "UNITS",
        CanBeEvaded = false,
        CanCrit = false,
        CanBackfire = true,
        CanDamageReturn = false,
        CanMagicResist = true,
        CanOverKill = false,
        ArmorImmune = true,
        NoFloatText = false,
    }

    DamageArea(data)
    RippleWorld()
end

#################################################################################################################
# Surge of Faith I
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSurgeofFaith01',
    DisplayName = '<LOC ABILITY_HOak_0016>Surge of Faith I',
    Description = '<LOC ABILITY_HOak_0017>Oak releases a wave of holy power, dealing [GetDamageAmt] damage to enemies. Increases allied unit Attack Speed by [GetAttackBuff]% and Movement Speed by [GetMovementBuff]% for [GetBuffDuration] seconds.',
    AbilityType = 'Instant',
    TargetAlliance = 'Any',
    TargetCategory = 'ALLUNITS - UNTARGETABLE - BENIGN',
    EnergyCost = 500,
    AffectRadius = 15,
    Cooldown = 10,
    UISlot = 3,
    HotKey = '3',
    DamageAmt = 300,
    DamageType = 'Spell',
    CastingTime = 1,
    FollowThroughTime = 0.5,
    CastAction = 'Surge',
    BuffName = 'SurgeofFaithBuff01',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetAttackBuff = function(self) return math.floor( Buffs[self.BuffName].Affects.RateOfFire.Mult * 100 ) end,
    GetMovementBuff = function(self) return math.floor( Buffs[self.BuffName].Affects.MoveMult.Mult * 100 ) end,
    GetBuffDuration = function(self) return math.floor( Buffs[self.BuffName].Duration ) end,
    OnStartAbility = SurgeOfFaithFunction,
    OnStartCasting = function(self, unit)
        FxSurgeFaithCharge(self, unit)
    end,
    Icon = '/DGOak/NewOakSurgeofFaith01',
}

#################################################################################################################
# Surge of Faith I Ally Buff
#################################################################################################################
BuffBlueprint {
    Name = 'SurgeofFaithBuff01',
    Debuff = false,
    DisplayName = '<LOC ABILITY_HOak_0018>Surge of Faith',
    Description = '<LOC ABILITY_HOak_0019>Attack Speed and Movement Speed increased.',
    BuffType = 'HOAKPSURGEOFFAITHBUFF',
    Stacks = 'ALWAYS',
    Duration = 7,
    Affects = {
        MoveMult = {Mult = 0.1},
        RateOfFire = {Mult = 0.10},
    },
    Effects = 'SurgeFaithActivate01',
    EffectsBone = -2,
    Icon = '/DGOak/NewOakSurgeofFaith01',
}

#################################################################################################################
# Surge of Faith II
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSurgeofFaith02',
    DisplayName = '<LOC ABILITY_HOak_0020>Surge of Faith II',
    Description = '<LOC ABILITY_HOak_0017>Oak releases a wave of holy power, dealing [GetDamageAmt] damage to enemies. Increases allied unit Attack Speed by [GetAttackBuff]% and Movement Speed by [GetMovementBuff]% for [GetBuffDuration] seconds.',
    AbilityType = 'Instant',
    TargetAlliance = 'Any',
    TargetCategory = 'ALLUNITS - UNTARGETABLE - BENIGN',
    EnergyCost = 675,
    AffectRadius = 15,
    Cooldown = 10,
    UISlot = 3,
    HotKey = '3',
    DamageAmt = 450,
    DamageType = 'Spell',
    CastingTime = 1,
    FollowThroughTime = 0.5,
    CastAction = 'Surge',
    BuffName = 'SurgeofFaithBuff02',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetAttackBuff = function(self) return math.floor( Buffs[self.BuffName].Affects.RateOfFire.Mult * 100 ) end,
    GetMovementBuff = function(self) return math.floor( Buffs[self.BuffName].Affects.MoveMult.Mult * 100 ) end,
    GetBuffDuration = function(self) return math.floor( Buffs[self.BuffName].Duration ) end,
    # 10/6 - MDM - commenting out to remove debuffs
    #DebuffName = 'SurgeofFaithDebuff02',
    OnStartAbility = SurgeOfFaithFunction,
    OnStartCasting = function(self, unit)
        FxSurgeFaithCharge(self, unit)
    end,
    Icon = '/DGOak/NewOakSurgeofFaith01',
}

#################################################################################################################
# Surge of Faith II Ally Buff
#################################################################################################################
BuffBlueprint {
    Name = 'SurgeofFaithBuff02',
    Debuff = false,
    DisplayName = '<LOC ABILITY_HOak_0018>Surge of Faith',
    Description = '<LOC ABILITY_HOak_0019>Attack Speed and Movement Speed increased.',
    BuffType = 'HOAKPSURGEOFFAITHBUFF',
    Stacks = 'ALWAYS',
    Duration = 7,
    Affects = {
        MoveMult = {Mult = 0.15},
        RateOfFire = {Mult = 0.15},
    },
    Effects = 'SurgeFaithActivate01',
    EffectsBone = -2,
    Icon = '/DGOak/NewOakSurgeofFaith01',
}

#################################################################################################################
# Surge of Faith III
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSurgeofFaith03',
    DisplayName = '<LOC ABILITY_HOak_0022>Surge of Faith III',
    Description = '<LOC ABILITY_HOak_0017>Oak releases a wave of holy power, dealing [GetDamageAmt] damage to enemies. Increases allied unit Attack Speed by [GetAttackBuff]% and Movement Speed by [GetMovementBuff]% for [GetBuffDuration] seconds.',
    AbilityType = 'Instant',
    TargetAlliance = 'Any',
    TargetCategory = 'ALLUNITS - UNTARGETABLE - BENIGN',
    EnergyCost = 850,
    AffectRadius = 15,
    Cooldown = 10,
    UISlot = 3,
    HotKey = '3',
    DamageAmt = 600,
    DamageType = 'Spell',
    CastingTime = 1,
    FollowThroughTime = 0.5,
    CastAction = 'Surge',
    BuffName = 'SurgeofFaithBuff03',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetAttackBuff = function(self) return math.floor( Buffs[self.BuffName].Affects.RateOfFire.Mult * 100 ) end,
    GetMovementBuff = function(self) return math.floor( Buffs[self.BuffName].Affects.MoveMult.Mult * 100 ) end,
    GetBuffDuration = function(self) return math.floor( Buffs[self.BuffName].Duration ) end,
    # 10/6 - MDM - commenting out to remove debuffs
    #DebuffName = 'SurgeofFaithDebuff03',
    OnStartAbility = SurgeOfFaithFunction,
    OnStartCasting = function(self, unit)
        FxSurgeFaithCharge(self, unit)
    end,
    Icon = '/DGOak/NewOakSurgeofFaith01',
}

#################################################################################################################
# Surge of Faith III Ally Buff
#################################################################################################################
BuffBlueprint {
    Name = 'SurgeofFaithBuff03',
    Debuff = false,
    DisplayName = '<LOC ABILITY_HOak_0018>Surge of Faith',
    Description = '<LOC ABILITY_HOak_0019>Attack Speed and Movement Speed increased.',
    BuffType = 'HOAKPSURGEOFFAITHBUFF',
    Stacks = 'ALWAYS',
    Duration = 7,
    Affects = {
        MoveMult = {Mult = 0.20},
        RateOfFire = {Mult = 0.20},
    },
    Effects = 'SurgeFaithActivate01',
    EffectsBone = -2,
    Icon = '/DGOak/NewOakSurgeofFaith01',
}

#################################################################################################################
# CE: Ward Count Management
#################################################################################################################
function CountWards(abil, unit, ward)
    local aiBrain = ward:GetAIBrain()

    if not unit.AbilityData.Wards then
        unit.AbilityData.Wards = {}
    end

    unit.AbilityData.WardsCounter = (unit.AbilityData.WardsCounter or 0) + 1
    unit.AbilityData.Wards[unit.AbilityData.WardsCounter] = ward

    #Clean out dead mines
    for k, mn in unit.AbilityData.Wards do
        if mn:IsDead() then
            unit.AbilityData.Wards[k] = nil
        end
    end

    #If we're at the max destroy the first mine
    if table.getsize(unit.AbilityData.Wards) > abil.WardMax then
        local key = table.keys(unit.AbilityData.Wards)[1]
        unit.AbilityData.Wards[key]:KillSelf()
        unit.AbilityData.Wards[key] = nil
    end

    # Add ward as a minion so it gets cleaned up on hero death
    unit:AddMinion( ward )
end

#################################################################################################################
# CE: Ward Positioning Management
#################################################################################################################
function GetWardLocation(unit)
    local pos = table.copy(unit:GetPosition())
    local fwdVec = ForwardVector(unit:GetOrientation())
    local forwarddist = 5
    pos[1] = pos[1] + ( fwdVec[1] * forwarddist )
    pos[2] = pos[2] + ( fwdVec[2] * forwarddist )
    pos[3] = pos[3] + ( fwdVec[3] * forwarddist )
    return pos
end

#################################################################################################################
# Raise Dead Ward I
#   The Lifetime of this ward is set in Defense.Lifetime of HOakRaiseDeadWard01
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKRaiseDeadWard01',
    DisplayName = '<LOC ABILITY_HOak_0024>Raise Dead Ward I',
    Description = '<LOC ABILITY_HOak_0082>Oak places a ward that attracts the souls of the fallen. Units that are slain near the ward have a [GetSpiritChance]% chance to be converted to a spirit under Oak\'s control.\n\nOak can have [GetMaxSpirits] spirits active.\n\nOak can maintain [GetMaxWards] ward.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 200,
    Cooldown = 5,
    RangeMax = 5,
    CastingTime = 0.2,
    FollowThroughTime = 0.5,
    CastAction = 'DeployWard',
    AffectRadius = 25,
    WardMax = 1,
    UISlot = 4,
    HotKey = '4',
    ErrorMessage = '<LOC error_0037>Cannot place that here.',
    ErrorVO = 'Noplace',
    GetSpiritChance = function(self) return math.floor( Buffs['HOAKSpiritOfWar01'].SpiritChance ) end,
    GetMaxSpirits = function(self) return math.floor( Buffs['HOAKSpiritOfWar01'].SpiritMax ) end,
    GetMaxWards = function(self) return math.floor( self.WardMax ) end,
    OnAbilityAdded = function(self, unit)
        if not unit.AbilityData.Wards then
            unit.AbilityData.Wards = {}
        end
    end,
    PreCastCheck = function(self, unit)
        local pos = GetWardLocation(unit)
        #if IsBadSpot(unit, pos) then
        #    MsgsFailure('<LOC error_0027>Cannot build that here')
        #end
        return (not IsBadSpot(unit, pos))
    end,
    OnStartAbility = function(self, unit, params)
        local x = params.Target.Position[1]
        local z = params.Target.Position[3]
        local ward = CreateUnitHPR( 'HOakRaiseDeadWard01', unit:GetArmy(), x, GetSurfaceHeight(x, z), z, 0, 0, 0)
        CountWards(self, unit, ward)
    end,
    Icon = '/DGOak/NewOakRaiseDead01',
    Reticule = 'AoE_Spirit_Ward',
}

#################################################################################################################
# Raise Dead Ward II
#   The Lifetime of this ward is set in Defense.Lifetime of HOakRaiseDeadWard02
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKRaiseDeadWard02',
    DisplayName = '<LOC ABILITY_HOak_0026>Raise Dead Ward II',
    Description = '<LOC ABILITY_HOak_0025>Oak places a ward that attracts the souls of the fallen. Units that are slain near the ward have a [GetSpiritChance]% chance to be converted to a spirit under Oak\'s control.\n\nOak can have [GetMaxSpirits] spirits active.\n\nOak can maintain [GetMaxWards] wards.\n\nSpirits have +[GetMinionDamage] Weapon Damage and +[GetMinionHealth] Health.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 200,
    Cooldown = 5,
    RangeMax = 5,
    CastingTime = 0.2,
    FollowThroughTime = 0.5,
    CastAction = 'DeployWard',
    AffectRadius = 25,
    WardMax = 2,
    UISlot = 4,
    HotKey = '4',
    ErrorMessage = '<LOC error_0038>Cannot place that here.',
    ErrorVO = 'Noplace',
    GetSpiritChance = function(self) return math.floor( Buffs['HOAKSpiritOfWar02'].SpiritChance ) end,
    GetMaxSpirits = function(self) return math.floor( Buffs['HOAKSpiritOfWar02'].SpiritMax ) end,
    GetMaxWards = function(self) return math.floor( self.WardMax ) end,
    GetMinionDamage = function(self) return math.floor( Buffs['HOakRaiseDeadWardBuffMinion02'].Affects.DamageRating.Add ) end,
    GetMinionHealth = function(self) return math.floor( Buffs['HOakRaiseDeadWardBuffMinion02'].Affects.MaxHealth.Add ) end,
    OnAbilityAdded = function(self, unit)
        unit:GetAIBrain():AddArmyBonus('HOakRaiseDeadWardBuffMinion02')
    end,
    PreCastCheck = function(self, unit)
        local pos = GetWardLocation(unit)
        #if IsBadSpot(unit, pos) then
        #    MsgsFailure('<LOC error_0027>Cannot build that here')
        #end
        return (not IsBadSpot(unit, pos))
    end,
    OnStartAbility = function(self, unit, params)
        local x = params.Target.Position[1]
        local z = params.Target.Position[3]
        local ward = CreateUnitHPR( 'HOakRaiseDeadWard02', unit:GetArmy(), x, GetSurfaceHeight(x, z), z, 0, 0, 0)
        CountWards(self, unit, ward)
    end,
    Icon = '/DGOak/NewOakRaiseDead01',
    Reticule = 'AoE_Spirit_Ward',
}

ArmyBonusBlueprint {
    Name = 'HOakRaiseDeadWardBuffMinion02',
    ApplyArmies = 'Single',
    UnitCategory = 'SPIRIT',
    Buffs = {
        BuffBlueprint {
            Name = 'HOakRaiseDeadWardBuffMinion02',
            BuffType = 'RAISEDEADMINIONS',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'SPIRIT',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 4},
                MaxHealth = {Add = 75, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Raise Dead Ward III
#   The Lifetime of this ward is set in Defense.Lifetime of HOakRaiseDeadWard03
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKRaiseDeadWard03',
    DisplayName = '<LOC ABILITY_HOak_0028>Raise Dead Ward III',
    Description = '<LOC ABILITY_HOak_0025>Oak places a ward that attracts the souls of the fallen. Units that are slain near the ward have a [GetSpiritChance]% chance to be converted to a spirit under Oak\'s control.\n\nOak can have [GetMaxSpirits] spirits active.\n\nOak can maintain [GetMaxWards] wards.\n\nSpirits have +[GetMinionDamage] Weapon Damage and +[GetMinionHealth] Health.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 200,
    Cooldown = 5,
    RangeMax = 5,
    CastingTime = 0.2,
    FollowThroughTime = 0.5,
    CastAction = 'DeployWard',
    AffectRadius = 25,
    WardMax = 3,
    UISlot = 4,
    HotKey = '4',
    ErrorMessage = '<LOC error_0039>Cannot place that here.',
    ErrorVO = 'Noplace',
    GetSpiritChance = function(self) return math.floor( Buffs['HOAKSpiritOfWar03'].SpiritChance ) end,
    GetMaxSpirits = function(self) return math.floor( Buffs['HOAKSpiritOfWar03'].SpiritMax ) end,
    GetMaxWards = function(self) return math.floor( self.WardMax ) end,
    GetMinionDamage = function(self) return math.floor( Buffs['HOakRaiseDeadWardBuffMinion03'].Affects.DamageRating.Add ) end,
    GetMinionHealth = function(self) return math.floor( Buffs['HOakRaiseDeadWardBuffMinion03'].Affects.MaxHealth.Add ) end,
    OnAbilityAdded = function(self, unit)
        unit:GetAIBrain():AddArmyBonus('HOakRaiseDeadWardBuffMinion03')
    end,
    PreCastCheck = function(self, unit)
        local pos = GetWardLocation(unit)
        #if IsBadSpot(unit, pos) then
        #    MsgsFailure('<LOC error_0027>Cannot build that here')
        #end
        return (not IsBadSpot(unit, pos))
    end,
    OnStartAbility = function(self, unit, params)
        local x = params.Target.Position[1]
        local z = params.Target.Position[3]
        local ward = CreateUnitHPR( 'HOakRaiseDeadWard03', unit:GetArmy(), x, GetSurfaceHeight(x, z), z, 0, 0, 0)
        CountWards(self, unit, ward)
    end,
    Icon = '/DGOak/NewOakRaiseDead01',
    Reticule = 'AoE_Spirit_Ward',
}

ArmyBonusBlueprint {
    Name = 'HOakRaiseDeadWardBuffMinion03',
    ApplyArmies = 'Single',
    UnitCategory = 'SPIRIT',
    Buffs = {
        BuffBlueprint {
            Name = 'HOakRaiseDeadWardBuffMinion03',
            BuffType = 'RAISEDEADMINIONS',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'SPIRIT',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 8},
                MaxHealth = {Add = 150, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Raise Dead Ward IV
# The Lifetime of this ward is set in Defense.Lifetime of HOakRaiseDeadWard04
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKRaiseDeadWard04',
    DisplayName = '<LOC ABILITY_HOak_0068>Raise Dead Ward IV',
    Description = '<LOC ABILITY_HOak_0025>Oak places a ward that attracts the souls of the fallen. Units that are slain near the ward have a [GetSpiritChance]% chance to be converted to a spirit under Oak\'s control.\n\nOak can have [GetMaxSpirits] spirits active.\n\nOak can maintain [GetMaxWards] wards.\n\nSpirits have +[GetMinionDamage] Weapon Damage and +[GetMinionHealth] Health.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 200,
    Cooldown = 5,
    RangeMax = 5,
    CastingTime = 0.2,
    FollowThroughTime = 0.5,
    CastAction = 'DeployWard',
    AffectRadius = 25,
    WardMax = 4,
    UISlot = 4,
    HotKey = '4',
    ErrorMessage = '<LOC error_0040>Cannot place that here.',
    ErrorVO = 'Noplace',
    GetSpiritChance = function(self) return math.floor( Buffs['HOAKSpiritOfWar04'].SpiritChance ) end,
    GetMaxSpirits = function(self) return math.floor( Buffs['HOAKSpiritOfWar04'].SpiritMax ) end,
    GetMaxWards = function(self) return math.floor( self.WardMax ) end,
    GetMinionDamage = function(self) return math.floor( Buffs['HOakRaiseDeadWardBuffMinion04'].Affects.DamageRating.Add ) end,
    GetMinionHealth = function(self) return math.floor( Buffs['HOakRaiseDeadWardBuffMinion04'].Affects.MaxHealth.Add ) end,
    OnAbilityAdded = function(self, unit)
        unit:GetAIBrain():AddArmyBonus('HOakRaiseDeadWardBuffMinion04')
    end,
    PreCastCheck = function(self, unit)
        local pos = GetWardLocation(unit)
        #if IsBadSpot(unit, pos) then
        #    MsgsFailure('<LOC error_0027>Cannot build that here')
        #end
        return (not IsBadSpot(unit, pos))
    end,
    OnStartAbility = function(self, unit, params)
        local x = params.Target.Position[1]
        local z = params.Target.Position[3]
        local ward = CreateUnitHPR( 'HOakRaiseDeadWard04', unit:GetArmy(), x, GetSurfaceHeight(x, z), z, 0, 0, 0)
        CountWards(self, unit, ward)
    end,
    Icon = '/DGOak/NewOakRaiseDead01',
    Reticule = 'AoE_Spirit_Ward',
}

ArmyBonusBlueprint {
    Name = 'HOakRaiseDeadWardBuffMinion04',
    ApplyArmies = 'Single',
    UnitCategory = 'SPIRIT',
    Buffs = {
        BuffBlueprint {
            Name = 'HOakRaiseDeadWardBuffMinion04',
            BuffType = 'RAISEDEADMINIONS',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'SPIRIT',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 12},
                MaxHealth = {Add = 250, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# CE: Create Spirits
#################################################################################################################
function RaiseSpirit(abilDef, deadUnit)
    local inst = deadUnit.AbilityData.Oak.SpiritOfWarInst
    local hero = ArmyBrains[inst:GetArmy()]:GetHero()

    if not inst or inst:IsDead() or deadUnit == inst or not hero or hero:IsDead() then
        return
    end
    local rand = Random(1, 100)
    if rand > abilDef.SpiritChance then
        return
    end

    local numSpirits = ArmyBrains[inst:GetArmy()]:GetCurrentUnits(categories.hoakspirit)

    if(numSpirits < abilDef.SpiritMax) then
        local pos = deadUnit:GetPosition()
        local orient = deadUnit:GetOrientation()
        local brainNum = inst:GetArmy()
        local spirit = CreateUnitHPR( 'HOakSpirit', brainNum, pos[1], pos[2], pos[3], orient[1], orient[2],orient[3])
        if spirit then
            IssueGuard({spirit}, hero)
            #Check for Soul Power buffs, and also add a callback to check for Soul Power buffs when a spirit dies
            SpiritCounter(hero)
            spirit.Callbacks.OnKilled:Add(SpiritCounter, hero)
        end
    end
end

#################################################################################################################
# Call the Fallen I
# Raise Dead Ward I uses this ability.
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSpiritOfWar01',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 1,
    TargetAlliance = 'Any',
    TargetCategory = 'MOBILE - UNTARGETABLE - HERO - SPIRIT',
    Tooltip = {
        TargetAlliance = 'Any',
    },
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKSpiritOfWar01',
            Debuff = false,
            DisplayName = 'Spirit of War',
            BuffType = 'HOAKSPIRITOFWAR',
            Stacks = 'ALWAYS',
            Duration = 1,
            SpiritChance = 30,
            SpiritMax = 3,
            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.Oak then
                    unit.AbilityData.Oak = {}
                end
                unit.AbilityData.Oak.SpiritOfWarInst = instigator
                unit.Callbacks.OnKilled:Add(self.SpawnSpirit, self)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(self.SpawnSpirit)
            end,
            SpawnSpirit = function(self, unit)
                RaiseSpirit(self, unit)
            end,
        }
    },
}

#################################################################################################################
# Call the Fallen II
# Raise Dead Ward II uses this ability.
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSpiritOfWar02',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 1,
    TargetAlliance = 'Any',
    TargetCategory = 'MOBILE - UNTARGETABLE - HERO - SPIRIT',
    Tooltip = {
        TargetAlliance = 'Any',
    },
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKSpiritOfWar02',
            Debuff = false,
            DisplayName = 'Spirit of War',
            BuffType = 'HOAKSPIRITOFWAR',
            Stacks = 'ALWAYS',
            Duration = 1,
            SpiritChance = 45,
            SpiritMax = 5,
            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.Oak then
                    unit.AbilityData.Oak = {}
                end
                unit.AbilityData.Oak.SpiritOfWarInst = instigator
                unit.Callbacks.OnKilled:Add(self.SpawnSpirit, self)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(self.SpawnSpirit)
            end,
            SpawnSpirit = function(self, unit)
                RaiseSpirit(self, unit)
            end,
        }
    },
}

#################################################################################################################
# Call the Fallen III
# Raise Dead Ward III uses this ability.
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSpiritOfWar03',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 1,
    TargetAlliance = 'Any',
    TargetCategory = 'MOBILE - UNTARGETABLE - HERO - SPIRIT',
    Tooltip = {
        TargetAlliance = 'Any',
    },
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKSpiritOfWar03',
            Debuff = false,
            DisplayName = 'Spirit of War',
            BuffType = 'HOAKSPIRITOFWAR',
            Stacks = 'ALWAYS',
            Duration = 1,
            SpiritChance = 60,
            SpiritMax = 7,
            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.Oak then
                    unit.AbilityData.Oak = {}
                end
                unit.AbilityData.Oak.SpiritOfWarInst = instigator
                unit.Callbacks.OnKilled:Add(self.SpawnSpirit, self)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(self.SpawnSpirit)
            end,
            SpawnSpirit = function(self, unit)
                RaiseSpirit(self, unit)
            end,
        }
    },
}

#################################################################################################################
# Guardian Aura
# Raise Dead Ward III uses this ability.
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKGuardianAura03',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 1,
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE - NOBUFFS',
    Tooltip = {
        TargetAlliance = 'Ally',
    },
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKGuardianAura03',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HOak_0071>Guardian Aura',
            Description = '<LOC ABILITY_HOak_0072>+250 Armor',
            BuffType = 'HOAKGUARDIANAURA',
            Stacks = 'REPLACE',
            Icon = '/DGOak/NewOakRaiseDead01',
            Duration = 1,
            Affects = {
                Armor = {Add = 200},
            },
        }
    },
}

#################################################################################################################
# Call the Fallen IV
# Raise Dead Ward IV uses this ability.
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSpiritOfWar04',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 1,
    TargetAlliance = 'Any',
    TargetCategory = 'MOBILE - UNTARGETABLE - HERO - SPIRIT',
    Tooltip = {
        TargetAlliance = 'Any',
    },
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKSpiritOfWar04',
            Debuff = false,
            DisplayName = 'Spirit of War',
            BuffType = 'HOAKSPIRITOFWAR',
            Stacks = 'ALWAYS',
            Duration = 1,
            SpiritChance = 75,
            SpiritMax = 10,
            OnBuffAffect = function(self, unit, instigator)
                if not instigator or instigator:IsDead() or unit == instigator then
                    return
                end
                if not unit.AbilityData.Oak then
                    unit.AbilityData.Oak = {}
                end
                unit.AbilityData.Oak.SpiritOfWarInst = instigator
                unit.Callbacks.OnKilled:Add(self.SpawnSpirit, self)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(self.SpawnSpirit)
            end,
            SpawnSpirit = function(self, unit)
                RaiseSpirit(self, unit)
            end,
        }
    },
}

#################################################################################################################
# Guardian Aura
# Raise Dead Ward IV uses this ability.
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKGuardianAura04',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 1,
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE - NOBUFFS',
    Tooltip = {
        TargetAlliance = 'Ally',
    },
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKGuardianAura04',
            Debuff = false,
            DisplayName = '<LOC ABILITY_HOak_0073>Guardian Aura',
            Description = '<LOC ABILITY_HOak_0074>+500 Armor',
            BuffType = 'HOAKGUARDIANAURA',
            Stacks = 'REPLACE',
            Icon = '/DGOak/NewOakRaiseDead01',
            Duration = 1,
            Affects = {
                Armor = {Add = 400},
            },
        }
    },
}

#################################################################################################################
# Soul Frenzy
#################################################################################################################
AbilityBlueprint {
    Name = 'HOakSoulFrenzy',
    DisplayName = '<LOC ABILITY_HOak_0076>Soul Frenzy',
    Description = '<LOC ABILITY_HOak_0077>Oak has a [GetChance]% chance of inciting his Spirits into a berserker rage, increasing their attack speed by [GetAttackSpeedBuff]% and letting their attacks throw smaller units into the air. This effect lasts for [GetDuration] seconds.',
    GetChance = function(self) return math.floor( self.WeaponProcChance ) end,
    GetAttackSpeedBuff = function(self) return math.floor( Buffs['HOakSoulFrenzy'].Affects.RateOfFire.Mult * 100 ) end,
    GetDuration = function(self) return math.floor( Buffs['HOakSoulFrenzy'].Duration ) end,
    AbilityType = 'WeaponProc',
    WeaponProcChance = 5,
    OnWeaponProc = function(self, unit, target, damageData)
        unit:GetAIBrain():AddArmyBonus( 'HOakSoulFrenzy', self )
    end,
    Icon = '/DGOak/NewOakSoulFrenzy01',
}

ArmyBonusBlueprint {
    Name = 'HOakSoulFrenzy',
    DisplayName = '<LOC ABILITY_HOak_0078>Soul Frenzy',
    Description = '<LOC ABILITY_HOak_0079>Attack speed increased. Attacks will knock away smaller units.',
    ApplyArmies = 'Single',
    UnitCategory = 'SPIRIT',
    Buffs = {
        BuffBlueprint {
            Name = 'HOakSoulFrenzy',
            DisplayName = '<LOC ABILITY_HOak_0080>Soul Frenzy',
            Description = '<LOC ABILITY_HOak_0081>Attack speed increased. Attacks will knock away smaller units.',
            BuffType = 'HOAKSOULFRENZY',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 10,
            Icon = '/DGOak/NewOakSoulFrenzy01',
            Affects = {
                MetaAmount = {Add = 8},
                MetaRadius = {Add = 2},
                RateOfFire = {Mult = 0.25},
            },
            Effects = 'Lifesteal02',
            EffectsBone = -2,
        }
    }
}

#################################################################################################################
# VFX
# Last Stand
#################################################################################################################

function FxLastStand01( unit )
    local pos = table.copy(unit:GetPosition())
    local fwdVec = ForwardVector(unit:GetOrientation())

    # Shield and axe landing pre-death effect
    WaitSeconds(0.4)
    CreateTemplatedEffectAtPos( 'Oak', nil, 'EpicDeath01', unit:GetArmy(), pos, fwdVec )

    # Wait for fake death anim to get to the point where Oak Last Stand should appear
    WaitSeconds( 1.1 )

    # Set mesh to invuln/shield shader
    unit:SetInvulnerableMesh(true)

    # Last stand trigger effects
    AttachEffectAtBone( unit, 'Oak', 'LastStandTrigger01', -2 )

    # Create Last Stand ambient emitters and trash
    unit.AbilityData.LastStandEffects = {}
    local emitters = AttachEffectAtBone( unit, 'Oak', 'LastStandAmbientAxe01', 'sk_Oak_AxeTip_REF' )
    for k, v in emitters do
        table.insert( unit.AbilityData.LastStandEffects, v )
    end
    emitters = AttachEffectAtBone( unit, 'Oak', 'LastStandAmbientBody01', -2 )
    for k, v in emitters do
        table.insert( unit.AbilityData.LastStandEffects, v )
    end
end

#################################################################################################################
# Buff: Last Stand Introduction Buff
#################################################################################################################
BuffBlueprint {
    Name = 'HOAKLastStandTransition',
    Debuff = false,
    DisplayName = 'Last Stand Transition',
    Stacks = 'REPLACE',
    BuffType = 'HOAKLASTSTANDTRANSITION',
    Duration = -1,
    Affects = {
        FiringRandomness = { Add = 20 },
        WeaponsEnable = {Bool = false},
    },
}

#################################################################################################################
# Buff: Last Stand Cooldown Buff
#################################################################################################################
BuffBlueprint {
    Name = 'HOAKLastStandCooldown',
    Debuff = false,
    DisplayName = 'Last Stand Cooldown',
    Stacks = 'REPLACE',
    BuffType = 'HOAKLASTSTANDCOOLDOWN',
    Duration = 5,
}

#################################################################################################################
# CE:
# Last Stand functionality
#################################################################################################################

function LastStandApply(ability, unit, data)
    if data.Amount < unit:GetHealth() or Buff.HasBuff(unit, 'HOAKLastStandCooldown') then
        return
    end

    local buffName = ability.LastStandBuff
    Buff.ApplyBuff(unit, 'Immobile', unit)
    Buff.ApplyBuff(unit, 'HOAKLastStandTransition', unit)
    Buff.ApplyBuff(unit, buffName, unit)

    ForkThread(function()
        unit.Character:PlayAction("LastStand")
        # This is the length of the animation.
        WaitSeconds(1.5)
        unit:SetHealth(unit:GetMaxHealth())
        WaitSeconds(2.5)
        Buff.RemoveBuff(unit, 'Immobile')
        Buff.RemoveBuff(unit, 'HOAKLastStandTransition')
    end )

    # Last Stand trigger effects
    unit:ForkThread(FxLastStand01)

    local instigatorBp = data.InstigatorBp
    if(not instigatorBp) then
        if(data.Instigator and not data.Instigator:IsDead()) then
            instigatorBp = data.Instigator:GetBlueprint()
        end
    end

    ForkThread( function()
        WaitSeconds( ability.LastStandDuration )
        Buff.RemoveBuff(unit, buffName)

        # Try to grab the instigator bp and army if we didn't get it earlier
        if(not instigatorBp) then
            if(data.Instigator and not data.Instigator:IsDead()) then
                instigatorBp = data.Instigator:GetBlueprint()
            end
        end

        unit.KillData = {
            Instigator = data.Instigator,
            InstigatorBp = instigatorBp,
            InstigatorArmy = data.InstigatorArmy,
            KillLocation = unit:GetPosition(),
            DamageAction = data.DamageAction,
        }

        unit:Kill()

        # Destroy Last Stand effects
        if unit.AbilityData.LastStandEffects then
            for kEffect, vEffect in unit.AbilityData.LastStandEffects do
                vEffect:Destroy()
            end
        end
    end )
end

#################################################################################################################
# Buff: Last Stand I
#################################################################################################################
BuffBlueprint {
    Name = 'HOAKLastStand01',
    Debuff = false,
    DisplayName = '<LOC ABILITY_HOak_0033>Last Stand',
    Description = '<LOC ABILITY_HOak_0034>Invincible. Damage, Movement Speed and Attack Speed increased.',
    Stacks = 'REPLACE',
    BuffType = 'HOAKLASTSTAND',
    Affects = {
        Invincible = { Bool = true },
        DamageRating = { Mult = 0.30 },
        RateOfFire = {Mult = 0.30},
        MoveMult = {Mult = 0.3},
        DebuffImmune = { Bool = true },
        Silence = {Bool = true},
    },
    OnBuffAffect = function(self, unit, instigator)
        Buff.RemoveBuffsByDebuff(unit, true)
    end,
    Icon = '/DGOak/NewOakLastStand01',
    OnBuffRemove = function(self, unit)
        unit:SetInvulnerableMesh(false)
        Buff.ApplyBuff(unit, 'HOAKLastStandCooldown', unit)
    end,
}

#################################################################################################################
# Last Stand I
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKLastStand01',
    DisplayName = '<LOC ABILITY_HOak_0035>Last Stand I',
    Description = '<LOC ABILITY_HOak_0036>The spirit of Oak refuses to leave a battle unfinished. Should he fall, he will enter an invincible berserker fury, increasing his damage, move speed and Attack Speed by [GetBerserkPercent]% for [GetDuration] seconds before finally dying.',
    AbilityType = 'Quiet',
    GetBerserkPercent = function(self) return math.floor( Buffs[self.Name].Affects.DamageRating.Mult * 100 ) end,
    GetDuration = function(self) return math.floor( self.LastStandDuration - 4 ) end,
    EnergyCost = 0,
    NoCastAnim = true,
    LastStandBuff = 'HOAKLastStand01',
    LastStandDuration = 14, # This should be the length of the animation plus the duration of the buff.
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnTakeDamage:Add(LastStandApply, self)
    end,
    OnRemoveAbility = function(self, unit)
        unit.Callbacks.OnTakeDamage:Remove(LastStandApply)
    end,
    Icon = '/DGOak/NewOakLastStand01',
}

#################################################################################################################
# Buff: Last Stand II
#################################################################################################################
BuffBlueprint {
    Name = 'HOAKLastStand02',
    Debuff = false,
    DisplayName = '<LOC ABILITY_HOak_0033>Last Stand',
    Description = '<LOC ABILITY_HOak_0034>Invincible. Damage, Movement Speed and Attack Speed increased.',
    Stacks = 'REPLACE',
    BuffType = 'HOAKLASTSTAND',
    Affects = {
        Invincible = { Bool = true },
        DamageRating = { Mult = 0.50 },
        RateOfFire = {Mult = 0.50},
        MoveMult = {Mult = 0.5},
        DebuffImmune = { Bool = true },
        Silence = {Bool = true},
    },
    OnBuffAffect = function(self, unit, instigator)
        Buff.RemoveBuffsByDebuff(unit, true)
    end,
    Icon = '/DGOak/NewOakLastStand01',
    OnBuffRemove = function(self, unit)
        unit:SetInvulnerableMesh(false)
        Buff.ApplyBuff(unit, 'HOAKLastStandCooldown', unit)
    end,
}

#################################################################################################################
# Last Stand II
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKLastStand02',
    DisplayName = '<LOC ABILITY_HOak_0037>Last Stand II',
    Description = '<LOC ABILITY_HOak_0036>The spirit of Oak refuses to leave a battle unfinished. Should he fall, he will enter an invincible berserker fury, increasing his damage, move speed and Attack Speed by [GetBerserkPercent]% for [GetDuration] seconds before finally dying.',
    AbilityType = 'Quiet',
    GetBerserkPercent = function(self) return math.floor( Buffs[self.Name].Affects.DamageRating.Mult * 100 ) end,
    GetDuration = function(self) return math.floor( self.LastStandDuration - 4 ) end,
    EnergyCost = 0,
    NoCastAnim = true,
    LastStandBuff = 'HOAKLastStand02',
    LastStandDuration = 14, # This should be the length of the animation plus the duration of the buff.
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnTakeDamage:Add(LastStandApply, self)
    end,
    OnRemoveAbility = function(self, unit)
        unit.Callbacks.OnTakeDamage:Remove(LastStandApply)
    end,
    Icon = '/DGOak/NewOakLastStand01',
}

#################################################################################################################
# VFX
# Divine Justice
#################################################################################################################
function FxDivineJustice(unit, unitKilled)
    local pos = table.copy(unitKilled:GetPosition())
    pos[2] = 100
    CreateTemplatedEffectAtPos( 'Oak', 'DivineJustice01', unitKilled:GetEffectBuffClassification(), unit:GetArmy(), pos )
end

#################################################################################################################
# CE: Divine Justice
# Body function for DivineJustice buff; this is passed in the buff data and calculates the proper amount of
# energy and Health to give to all the allies in the buff specified area upon unit death
#################################################################################################################
function DivineJusticeBuffFunction(buff, unit, unitKilled)
    #Structures are omitted from Divine Justice
    if EntityCategoryContains(categories.STRUCTURE, unitKilled) then
        return
    end

    local herokilled = false
    # Heroes trigger Rally
    if EntityCategoryContains(categories.HERO, unitKilled) and (Validate.HasAbility(unit, 'HOakRally')) then
        herokilled = true
    end

    # Create trigger effects on killed unit
    if not EntityCategoryContains(categories.UNTARGETABLE, unitKilled) and not EntityCategoryContains(categories.NOBUFFS, unitKilled) then
        FxDivineJustice(unit, unitKilled)
    end

    local aiBrain = unit:GetAIBrain()
    local amount = unitKilled:GetMaxHealth() * buff.RegenAmount * -1
    local allies = aiBrain:GetUnitsAroundPoint( categories.MOBILE, unit.Position, buff.AffectRadius, 'Ally' )

    local data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = unit:GetArmy(),
        Amount = amount,
        Type = 'Spell',
        Radius = 0,
        DamageAction = buff.Name,
        DamageSelf = true,
        Origin = unit:GetPosition(),
        CanDamageReturn = false,
        CanCrit = false,
        CanBackfire = false,
        CanBeEvaded = false,
        CanMagicResist = false,
        DamageFriendly = true,
        ArmorImmune = true,
        Group = "UNITS",
    }

    for k,v in allies do
        if (v and not v:IsDead() and not EntityCategoryContains(categories.NOBUFFS, v) and not EntityCategoryContains(categories.UNTARGETABLE, v)) then
            DealDamage(data, v)
            if v:GetMaxEnergy() > (v:GetEnergy() - amount) then
                v:SetEnergy(v:GetEnergy() - amount)
            else
                v:SetEnergy(v:GetMaxEnergy())
            end
            # If a hero died and Oak has Rally, apply the Rally buff
            if herokilled then
                Buff.ApplyBuff(v, 'HOakRally', unit)
                Buff.ApplyBuff(v, 'HOakRallyHeal', unit)
            end
        end
    end
end

#################################################################################################################
# Divine Justice I
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKDivineJustice01',
    DisplayName = '<LOC ABILITY_HOak_0039>Divine Justice I',
    Description = '<LOC ABILITY_HOak_0044>When Oak kills a target, he and his allies receive Health and Mana equal to [GetRegenPercent]% of the unit\'s maximum Health.',
    AbilityType = 'Quiet',
    GetRegenPercent = function(self) return math.floor( Buffs['HOAKDivineJusticeSelf01'].RegenAmount * 100 ) end,
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKDivineJusticeSelf01',
            DisplayName = '<LOC ABILITY_HOak_0039>Divine Justice I',
            Description = '<LOC ABILITY_HOak_0044>When Oak kills a target, he and his allies receive Health and Mana equal to [GetRegenPercent]% of the unit\'s maximum Health.',
            GetRegenPercent = function(self) return math.floor( self.RegenAmount * 100 ) end,
            BuffType = 'HOAKDIVINEJUSTICE',
            Debuff = false,
            Stacks = 'REPLACE',
            RegenAmount = 0.1,
            AffectRadius = 15,
            Affects = {
                Dummy = {Add = 0.1},
            },
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnKilledUnit:Add(self.Regeneration, self)
            end,
            Regeneration = DivineJusticeBuffFunction,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilledUnit:Remove(self.Regeneration)
            end,
        },
    },
    Icon = '/DGOak/NewOakDevineJustice01',
}

#################################################################################################################
# Divine Justice II
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKDivineJustice02',
    DisplayName = '<LOC ABILITY_HOak_0042>Divine Justice II',
    Description = '<LOC ABILITY_HOak_0044>When Oak kills a target, he and his allies receive Health and Mana equal to [GetRegenPercent]% of the unit\'s maximum Health.',
    AbilityType = 'Quiet',
    GetRegenPercent = function(self) return math.floor( Buffs['HOAKDivineJusticeSelf02'].RegenAmount * 100 ) end,
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKDivineJusticeSelf02',
            DisplayName = '<LOC ABILITY_HOak_0042>Divine Justice II',
            Description = '<LOC ABILITY_HOak_0044>When Oak kills a target, he and his allies receive Health and Mana equal to [GetRegenPercent]% of the unit\'s maximum Health.',
            BuffType = 'HOAKDIVINEJUSTICE',
            GetRegenPercent = function(self) return math.floor( self.RegenAmount * 100 ) end,
            Debuff = false,
            Stacks = 'REPLACE',
            RegenAmount = 0.15,
            AffectRadius = 15,
            Affects = {
                Dummy = {Add = 0.1},
            },
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnKilledUnit:Add(self.Regeneration, self)
            end,
            Regeneration = DivineJusticeBuffFunction,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilledUnit:Remove(self.Regeneration)
            end,
        },
    },
    Icon = '/DGOak/NewOakDevineJustice01',
}

#################################################################################################################
# Divine Justice III
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKDivineJustice03',
    DisplayName = '<LOC ABILITY_HOak_0045>Divine Justice III',
    Description = '<LOC ABILITY_HOak_0044>When Oak kills a target, he and his allies receive Health and Mana equal to [GetRegenPercent]% of the unit\'s maximum Health.',
    AbilityType = 'Quiet',
    GetRegenPercent = function(self) return math.floor( Buffs['HOAKDivineJusticeSelf03'].RegenAmount * 100 ) end,
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKDivineJusticeSelf03',
            DisplayName = '<LOC ABILITY_HOak_0045>Divine Justice III',
            Description = '<LOC ABILITY_HOak_0044>When Oak kills a target, he and his allies receive Health and Mana equal to [GetRegenPercent]% of the unit\'s maximum Health.',
            BuffType = 'HOAKDIVINEJUSTICE',
            GetRegenPercent = function(self) return math.floor( self.RegenAmount * 100 ) end,
            Debuff = false,
            Stacks = 'REPLACE',
            RegenAmount = 0.2,
            AffectRadius = 15,
            Affects = {
                Dummy = {Add = 0.1},
            },
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnKilledUnit:Add(self.Regeneration, self)
            end,
            Regeneration = DivineJusticeBuffFunction,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilledUnit:Remove(self.Regeneration)
            end,
        },
    },
    Icon = '/DGOak/NewOakDevineJustice01',
}

#################################################################################################################
# Rally
#################################################################################################################
AbilityBlueprint {
    Name = 'HOakRally',
    DisplayName = '<LOC ABILITY_HOAK_0004>Rally',
    Description = '<LOC ABILITY_HOAK_0005>When Oak kills a Demigod, he and his allies receive +[GetArmor] Armor and heal [GetAmount] Health over [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetArmor = function(self) return ( Buffs[self.Name].Affects.Armor.Add ) end,
    GetAmount = function(self) return math.floor( Buffs['HOakRallyHeal'].Affects.Health.Add * Buffs['HOakRallyHeal'].Duration ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
}

BuffBlueprint {
    Name = 'HOakRally',
    DisplayName = '<LOC ABILITY_HOAK_0006>Rally',
    Description = '<LOC ABILITY_HOAK_0007>Armor increased. Healing over time.',
    BuffType = 'HOAKRALLY',
    Stacks = 'REPLACE',
    Duration = 5,
    EntityCategory = 'MOBILE - UNTARGETABLE',
    Debuff = false,
    Affects = {
        Armor = { Add = 500 },
    },
    Icon = '/DGOak/NewOakRally01',
}

BuffBlueprint {
    Name = 'HOakRallyHeal',
    BuffType = 'HOAKRALLYHEAL',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 5,
    DurationPulse = 5,
    ArmorImmune = true,
    CanCrit = false,
    CanBackfire = false,
    IgnoreDamageRangePercent = true,
    DamageSelf = true,
    DamageFriendly = true,
    Affects = {
        Health = {Add = 200},
    },
}

#################################################################################################################
# CE: SpiritCounter
# Manages the spirit counter, then checks to see if a Soul Power buff should be applied
#################################################################################################################
function SpiritCounter(unit, unitkilled)
    #LOG( 'Initial SpiritCount = ', unit.AbilityData.SpiritCount )
    #LOG( 'Initial SoulPowerLevel = ', unit.AbilityData.SoulPowerFxLevel )
    #LOG( 'Initial SoulPowerRank = ', unit.AbilityData.SoulPowerRank )
    #LOG( 'IgnoreCount = ', unit.AbilityData.IgnoreCount )

    # Is Oak even alive?
    if unit.Dead then
        return
    end

    # Check to see if we even need to consider Soul Power.
    # If we do, check to see how many buffs we jump as a result.
    if unit.AbilityData.SoulPowerRank then
        local soulPowerRank = unit.AbilityData.SoulPowerRank
        local spiritCount = 0

        # Go through the spirits Oak has and count up the ones that are still alive.
        local spirits = ArmyBrains[unit:GetArmy()]:GetListOfUnits(categories.hoakspirit, false)
        for k, v in spirits do
            if(v and not v:IsDead()) then
                spiritCount = spiritCount + 1
            end
        end
        #LOG( 'spiritCount = ', spiritCount )

        # For every 3 spirits the player controls, they receive a buff.
        # For every additional rank of Soul Power, they jump a buff.
        # That is, when a player has Soul Power II and has 3 spirits, they use the second rank buff instead of the first.
        # Additionally, Oak receives the baseline buff for his ability rank if he has even 1 spirit out.
        spiritGroups = math.floor((spiritCount) / 3)
        #LOG( 'spiritGroups = ', spiritGroups )

        if spiritGroups >= 0 and soulPowerRank + spiritGroups <= 5 and spiritCount > 0 then
            soulPowerRank = soulPowerRank + spiritGroups
            Buff.ApplyBuff(unit, 'HOakSoulPowerBuff0' .. soulPowerRank, unit)
            # VFX: Adjust Oak shader parameters to reflect rank of soul power.
            unit.AbilityData.SoulPowerFxLevel = soulPowerRank * 0.165
            unit:SetAuxMeshParam( unit.AbilityData.SoulPowerFxLevel )

            #LOG( 'SoulPowerLevel = ', unit.AbilityData.SoulPowerFxLevel )
            #LOG( 'soulPowerRank = ', soulPowerRank )

        # If for some reason there are more spirits than buffs, cap the buff. This should not happen.
        elseif soulPowerRank + spiritGroups > 5 then
            Buff.ApplyBuff(unit, 'HOakSoulPowerBuff06', unit)
            # VFX: Set Oak shader to max level
            unit:SetAuxMeshParam( 1.0 )

            #LOG( 'SoulPowerLevel (rank06) = 1.0 ' )
            #LOG( 'HOakSoulPowerBuff06' )
            #LOG( '--' )
        # Oak doesn't have enough spirits to sustain the buff, remove it.
        # Also, enforce that SpiritCount stays at 0.
        else
            for i = 1, 6 do
                if Buff.HasBuff(unit,'HOakSoulPowerBuff0' .. i) then
                    Buff.RemoveBuff(unit, 'HOakSoulPowerBuff0' .. i)
                end
            end
            unit.AbilityData.SpiritCount = 0

             # VFX: Turn off Oak shader and reset SoulPowerLevel
            unit.AbilityData.SoulPowerFxLevel = 0
        end
    end
end

#################################################################################################################
# Soul Power I
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSoulPower01',
    DisplayName = '<LOC ABILITY_HOak_0051>Soul Power I',
    Description = '<LOC ABILITY_HOak_0050>Oak\'s determination to his cause grows, increasing Weapon Damage by [GetDamageBoost]. Also, Oak gains additional Weapon Damage based on the number of spirits he has.',
    AbilityType = 'Quiet',
    GetDamageBoost = function(self) return Buffs['HOAKSoulPower01Damage'].Affects.DamageRating.Add end,
    OnAbilityAdded = function(self, unit)
        if not unit.AbilityData.SoulPowerFxLevel then
            unit.AbilityData.SoulPowerFxLevel = 0
        end
        if not unit.AbilityData.SoulPowerRank then
            unit.AbilityData.SoulPowerRank = 1
        end
        SpiritCounter(unit)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKSoulPower01Damage',
            Debuff = false,
            DisplayName = 'Soul Power Damage I',
            BuffType = 'HOAKSoulPower01Damage',
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 20},
            },
        }
    },
}

#################################################################################################################
# Soul Power II
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSoulPower02',
    DisplayName = '<LOC ABILITY_HOak_0053>Soul Power II',
    Description = '<LOC ABILITY_HOak_0050>Oak\'s determination to his cause grows, increasing Weapon Damage by [GetDamageBoost]. Also, Oak gains additional Weapon Damage based on the number of spirits he has.',
    AbilityType = 'Quiet',
    GetDamageBoost = function(self) return Buffs['HOAKSoulPower02Damage'].Affects.DamageRating.Add end,
    OnAbilityAdded = function(self, unit)
        if not unit.AbilityData.SoulPowerFxLevel then
            unit.AbilityData.SoulPowerFxLevel = 0
        end
        if unit.AbilityData.SoulPowerRank then
            unit.AbilityData.SoulPowerRank = 2
        end
        SpiritCounter(unit)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKSoulPower02Damage',
            Debuff = false,
            DisplayName = 'Soul Power Damage II',
            BuffType = 'HOAKSoulPower02Damage',
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 40},
            },
        }
    },
}

#################################################################################################################
# Soul Power III
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKSoulPower03',
    DisplayName = '<LOC ABILITY_HOak_0055>Soul Power III',
    Description = '<LOC ABILITY_HOak_0050>Oak\'s determination to his cause grows, increasing Weapon Damage by [GetDamageBoost]. Also, Oak gains additional Weapon Damage based on the number of spirits he has.',
    AbilityType = 'Quiet',
    GetDamageBoost = function(self) return Buffs['HOAKSoulPower03Damage'].Affects.DamageRating.Add end,
    OnAbilityAdded = function(self, unit)
        if not unit.AbilityData.SoulPowerFxLevel then
            unit.AbilityData.SoulPowerFxLevel = 0
        end
        if unit.AbilityData.SoulPowerRank then
            unit.AbilityData.SoulPowerRank = 3
        end
        SpiritCounter(unit)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HOAKSoulPower03Damage',
            Debuff = false,
            DisplayName = 'Soul Power Damage III',
            BuffType = 'HOAKSoulPower01Damage',
            Stacks = 'REPLACE',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 60},
            },
        }
    },
}

#################################################################################################################
# Soul Power Buffs
#################################################################################################################
BuffBlueprint {
    Name = 'HOakSoulPowerBuff01',
    DisplayName = '<LOC ABILITY_HOak_0048>Soul Power',
    Description = '<LOC ABILITY_HOak_0049>Weapon Damage increased.',
    BuffType = 'HOAKSOULPOWERDAMAGE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/DGOak/NewOakSoulPower01',
    Affects = {
        DamageRating = {Add = 20},
    },
}

BuffBlueprint {
    Name = 'HOakSoulPowerBuff02',
    DisplayName = '<LOC ABILITY_HOak_0048>Soul Power',
    Description = '<LOC ABILITY_HOak_0049>Weapon Damage increased.',
    BuffType = 'HOAKSOULPOWERDAMAGE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/DGOak/NewOakSoulPower01',
    Affects = {
        DamageRating = {Add = 40},
    },
}

BuffBlueprint {
    Name = 'HOakSoulPowerBuff03',
    DisplayName = '<LOC ABILITY_HOak_0048>Soul Power',
    Description = '<LOC ABILITY_HOak_0049>Weapon Damage increased.',
    BuffType = 'HOAKSOULPOWERDAMAGE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/DGOak/NewOakSoulPower01',
    Affects = {
        DamageRating = {Add = 60},
    },
}

BuffBlueprint {
    Name = 'HOakSoulPowerBuff04',
    DisplayName = '<LOC ABILITY_HOak_0048>Soul Power',
    Description = '<LOC ABILITY_HOak_0049>Weapon Damage increased.',
    BuffType = 'HOAKSOULPOWERDAMAGE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/DGOak/NewOakSoulPower01',
    Affects = {
        DamageRating = {Add = 80},
    },
}

BuffBlueprint {
    Name = 'HOakSoulPowerBuff05',
    DisplayName = '<LOC ABILITY_HOak_0048>Soul Power',
    Description = '<LOC ABILITY_HOak_0049>Weapon Damage increased.',
    BuffType = 'HOAKSOULPOWERDAMAGE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/DGOak/NewOakSoulPower01',
    Affects = {
        DamageRating = {Add = 100},
    },
}

BuffBlueprint {
    Name = 'HOakSoulPowerBuff06',
    DisplayName = '<LOC ABILITY_HOak_0048>Soul Power',
    Description = '<LOC ABILITY_HOak_0049>Weapon Damage increased.',
    BuffType = 'HOAKSOULPOWERDAMAGE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/DGOak/NewOakSoulPower01',
    Affects = {
        DamageRating = {Add = 120},
    },
}

#################################################################################################################
# VFX
# Epic Death
#################################################################################################################

function FxOakDeathEntity( unit, pos, segments, radius, EmitterIds )
    local angle = (2*math.pi) / segments

    for i = 1, segments do
        local s = math.sin(i*angle)
        local c = math.cos(i*angle)
        local x = s * radius
        local z = c * radius

        CreateTemplatedEffectAtPos( 'Oak', nil, 'EpicDeathEntity01', unit:GetArmy(), Vector(pos[1] + x,pos[2],pos[3]+z), Vector(x, 0, z) )
    end
end

function FxSpirits01(unit)
    local proj = nil

    OakDeathEffectEntity = import('/lua/sim/Entity.lua').Entity()
    local entPos = table.copy(unit:GetPosition())
    entPos[2] = entPos[2] + 300
    Warp(OakDeathEffectEntity, entPos)
    #OakDeathEffectEntity:SetLifeTime(2)

    local LoopCount = 20
    while LoopCount > 0 do
        local proj = unit:CreateProjectile( '/projectiles/OakDeathEffect01/OakDeathEffect01_proj.bp', 0, 1.0, 0, GetRandomFloat( -1.0, 1.0 ), 1.0, GetRandomFloat( -0.3, 1.0 ) )
        proj:SetNewTarget( OakDeathEffectEntity )

        local velocity = GetRandomFloat( 15, 25 )
        proj:SetVelocity( velocity )
        proj:SetLifetime( 1.0 )
        proj:SetBallisticAcceleration( -velocity * 0.1 )

        WaitSeconds(GetRandomFloat( 0.0, 0.1 ))
        LoopCount = LoopCount - 1
    end
end

#################################################################################################################
# Epic Death
#################################################################################################################

OakDeath = function( unit, abil )
    local pos = table.copy(unit:GetPosition())
    local fwdVec = ForwardVector(unit:GetOrientation())

    # Shield and axe landing pre-death effect
    WaitSeconds(0.4)
    CreateTemplatedEffectAtPos( 'Oak', nil, 'EpicDeath01', unit:GetArmy(), pos, fwdVec )

    # Create spirits wisping away.
    WaitSeconds(1.0)
    local thd = unit:ForkThread(FxSpirits01)

    # Start windup rays, glow
    WaitSeconds(0.5)
    CreateTemplatedEffectAtPos( 'Oak', nil, 'EpicDeath02', unit:GetArmy(), pos, fwdVec )
    unit:SetAuxMeshParam( 1.0 )

    # Final explosion
    WaitSeconds(1.4)
    CreateTemplatedEffectAtPos( 'Oak', nil, 'EpicDeath03', unit:GetArmy(), pos, fwdVec )
    FxOakDeathEntity ( unit, unit:GetPosition(), 11, 1 )

    # Refresh the ability cooldowns of friendly heroes nearby
    local entities = GetEntitiesInSphere("UNITS", table.copy(unit:GetPosition()), abil.AffectRadius)

    for k,entity in entities do
        if IsAlly(unit:GetArmy(),entity:GetArmy()) and not entity:IsDead() and EntityCategoryContains(categories.HERO, entity) then
            for kAbils in entity.Sync.Abilities do
                entity.Sync.Abilities[kAbils].Cooldown = 0
            end
            Abil.SyncAbilities(entity)
        end
    end
end

AbilityBlueprint {
    Name = 'HOAKDeath01',
    DisplayName = 'Death',
    Description = 'Oak death functional ability',
    AbilityType = 'Quiet',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    NoCastAnim = true,
    AffectRadius = 10,
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnKilled:Add(self.Death, self)
    end,
    Death = function(self, unit)
        unit:ForkThread(OakDeath, self)
    end,
}

#################################################################################################################
# Grey Abilities
#################################################################################################################
AbilityBlueprint {
    Name = 'HOAKShieldGrey01',
    DisplayName = '<LOC ABILITY_HOak_0000>Shield I',
    Description = '<LOC ABILITY_HOak_0064>Oak grants a shield to a target, making them immune to damage [GetBuffDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Ally',
    UISlot = 1,
    HotKey = '1',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HOAKShield01'].RangeMax end,
    GetBuffDuration = function(self) return math.floor( Buffs['HOAKShield01'].Duration ) end,
    GetEnergyCost = function(self) return Ability['HOAKShield01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HOAKShield01'].CastingTime end,
    GetCooldown = function(self) return Ability['HOAKShield01'].Cooldown end,
    Icon = '/DGOak/NewOakShield01',
}

AbilityBlueprint {
    Name = 'HOAKPenitenceGrey01',
    DisplayName = '<LOC ABILITY_HOak_0008>Penitence I',
    Description = '<LOC ABILITY_HOak_0009>Oak fills a target with holy remorse, dealing [GetDamage] damage, reducing their Movement Speed by [GetMoveSpeedPercent]% and increasing all damage taken by [GetDamageIncPercent]% for [GetBuffDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    Placeholder = true,

    GetMaxRange = function(self) return Ability['HOAKPenitence01'].RangeMax end,
    GetDamage = function(self) return Ability['HOAKPenitence01'].DamageAmt end,
    GetEnergyCost = function(self) return Ability['HOAKPenitence01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HOAKPenitence01'].CastingTime end,
    GetCooldown = function(self) return Ability['HOAKPenitence01'].Cooldown end,
    GetMoveSpeedPercent = function(self) return math.floor( Buffs['HOAKPenitence01'].Affects.MoveMult.Mult * -100 ) end,
    GetDamageIncPercent = function(self) return math.floor( Buffs['HOAKPenitence01'].Affects.DamageTakenMult.Add * 100 ) end,
    GetBuffDuration = function(self) return Buffs['HOAKPenitence01'].Duration end,

    Icon = '/DGOak/NewOakPenitence01',
}

AbilityBlueprint {
    Name = 'HOAKSurgeofFaithGrey01',
    DisplayName = '<LOC ABILITY_HOak_0016>Surge of Faith I',
    Description = '<LOC ABILITY_HOak_0017>Oak releases a wave of holy power, dealing [GetDamageAmt] damage to enemies. Increases allied unit Attack Speed by [GetAttackBuff]% and Movement Speed by [GetMovementBuff]% for [GetBuffDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Any',
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HOAKSurgeofFaith01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HOAKSurgeofFaith01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HOAKSurgeofFaith01'].CastingTime end,
    GetCooldown = function(self) return Ability['HOAKSurgeofFaith01'].Cooldown end,
    GetDamageAmt = function(self) return math.floor( Ability['HOAKSurgeofFaith01'].DamageAmt ) end,
    GetAttackBuff = function(self) return math.floor( Buffs['SurgeofFaithBuff01'].Affects.RateOfFire.Mult * 100 ) end,
    GetMovementBuff = function(self) return math.floor( Buffs['SurgeofFaithBuff01'].Affects.MoveMult.Mult * 100 ) end,
    GetBuffDuration = function(self) return math.floor( Buffs['SurgeofFaithBuff01'].Duration ) end,
    Icon = '/DGOak/NewOakSurgeofFaith01',
}

AbilityBlueprint {
    Name = 'HOAKRaiseDeadWardGrey01',
    DisplayName = '<LOC ABILITY_HOak_0024>Raise Dead Ward I',
    Description = '<LOC ABILITY_HOak_0083>Oak places a ward that attracts the souls of the fallen. Units that are slain near the ward have a [GetSpiritChance]% chance to be converted to a spirit under Oak\'s control.\n\nOak can have [GetMaxSpirits] spirits active.\n\nOak can maintain [GetMaxWards] ward.',
    AbilityType = 'Passive',
    TargetAlliance = 'Ally',
    UISlot = 4,
    HotKey = '4',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HOAKSurgeofFaith01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HOAKSurgeofFaith01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HOAKSurgeofFaith01'].CastingTime end,
    GetCooldown = function(self) return Ability['HOAKSurgeofFaith01'].Cooldown end,
    GetSpiritChance = function(self) return math.floor( Buffs['HOAKSpiritOfWar01'].SpiritChance ) end,
    GetMaxSpirits = function(self) return math.floor( Buffs['HOAKSpiritOfWar01'].SpiritMax ) end,
    GetMaxWards = function(self) return math.floor( Ability['HOAKRaiseDeadWard01'].WardMax ) end,
    Icon = '/DGOak/NewOakRaiseDead01',
}

__moduleinfo.auto_reload = true
