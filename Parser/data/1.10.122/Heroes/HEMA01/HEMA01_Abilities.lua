local Utils = import('/lua/utilities.lua')
local Abil = import('/lua/sim/ability.lua')
local Buff = import('/lua/sim/buff.lua')
local Entity = import('/lua/sim/entity.lua').Entity
local RippleWorld = import('/lua/utilities.lua').RippleWorld
local GetRandomFloat = Utils.GetRandomFloat
local Validate = import('/lua/common/ValidateAbility.lua')

function FxFireAura01( unit, trash )
    AttachCharacterEffectsAtBone( unit, 'magefire', 'FireAura01', -2, trash )
end

function FxFrostAura01( unit, trash )
    AttachCharacterEffectsAtBone( unit, 'mage', 'FrostAura01', -2, trash )
end

function FxFreezeUnit(self, unit, target)
    local buffClass = target:GetEffectBuffClassification()

    # Cast effects on Torchbear
    AttachEffectsAtBone( unit, EffectTemplates.TorchBearer.Freeze01, -2 )

    # Impact effects on target
    AttachEffectsAtBone( target, EffectTemplates.TorchBearer.FreezeImpact01[buffClass], -2 )
end

#################################################################################################################
# CE
# Rain of Ice
#################################################################################################################
function CallRain( abilityDef, unit, params, projectile )
    if unit:IsDead() then
        return
    end

    # Number of waves of ice/fire to drop
    for j = 1, abilityDef.NumWaves or 1 do
        local balls = abilityDef.NumFireBalls or 10
        local radius = abilityDef.AffectRadius
        for i = 1, balls do
            local tpos = VDiff(params.Target.Position, unit:GetPosition())
            #local tpos = table.copy(params.Target.Position)
            tpos[2] = 16 + Random(2,8)

            local horizontal_angle = (2*math.pi) / balls
            local angleInitial = GetRandomFloat( 0, horizontal_angle )
            local xVec, zVec
            local angleVariation = 0.5
            local px, pz

            xVec = math.sin(angleInitial + (i*horizontal_angle) + GetRandomFloat(-angleVariation, angleVariation) )
            zVec = math.cos(angleInitial + (i*horizontal_angle) + GetRandomFloat(-angleVariation, angleVariation) )
            px = GetRandomFloat( 0.0, radius ) * xVec
            pz = GetRandomFloat( 0.0, radius ) * zVec

            local proj = unit:CreateProjectile( projectile, px+tpos[1] - 9, tpos[2], pz+tpos[3], 0, -1, 0)
            proj:TrackTarget(false)
            proj:SetVelocity( 9, Random(-20, -15), 0)
            proj:SetLifetime(20)

            # Create effects at projectile spawn point
            AttachEffectsAtBone( proj, EffectTemplates.Projectiles.FrostBallLaunch02, -2 )
        end
        local pos = params.Target.Position
        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Origin = pos,
            Amount = abilityDef.DamageAmt,
            Type = abilityDef.DamageType or 'Spell',
            DamageAction = abilityDef.Name,
            Radius = abilityDef.AffectRadius,
            DamageFriendly = false,
            DamageSelf = false,
            Group = "UNITS",
            CanBeEvaded = false,
            CanCrit = false,
            CanBackfire = false,
            CanDamageReturn = false,
            CanMagicResist = true,
            ArmorImmune = true,
        }

        WaitSeconds(1)

        if unit:IsDead() then
            return
        end

        DamageArea(data)
        
        if abilityDef.Buff1 and abilityDef.Buff2 then
            local entities = GetEntitiesInSphere("UNITS", pos, abilityDef.AffectRadius)
            for k,entity in entities do
                if IsEnemy(unit:GetArmy(),entity:GetArmy()) and not entity:IsDead() and EntityCategoryContains(categories.MOBILE, entity) and not EntityCategoryContains(categories.NOBUFFS, entity) and not EntityCategoryContains(categories.UNTARGETABLE, entity) then
                    Buff.ApplyBuff(entity, abilityDef.Buff1, unit)
                    Buff.ApplyBuff(entity, abilityDef.Buff2, unit)
                    if Validate.HasAbility(unit,'HEMA01Clarity') then
                        Buff.ApplyBuff(entity, 'HEMA01ClarityBuff', unit)
                    end
                end
            end
        end

        # Wait before dropping next wave
        if j != abilityDef.NumWaves or 1 then
            WaitSeconds(0.75)
        end
    end
end

#################################################################################################################
# CE
# Disables Fire Abilities
#################################################################################################################
BuffBlueprint {
    Name = 'HEMA01FireAbilityDisable',
    DisplayName = 'Fire Abilities Disabled',
    BuffType = 'HEMA01FIREABILITYDISABLE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    AbilityCategory = 'HEMA01FIRE',
    Affects = {
        AbilityEnable = {Bool = true,},
    },
}

#################################################################################################################
# CE
# Disables Ice Abilities
#################################################################################################################
BuffBlueprint {
    Name = 'HEMA01IceAbilityDisable',
    DisplayName = 'Ice Abilities Disabled',
    BuffType = 'HEMA01ICEABILITYDISABLE',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    AbilityCategory = 'HEMA01ICE',
    Affects = {
        AbilityEnable = {Bool = true,},
    },
}

BuffBlueprint {
    Name = 'HEMA01IceWeaponDisable',
    DisplayName = 'Ice Weapon Disabled',
    BuffType = 'MANUALWEAPONDISABLE',
    Debuff = false,
    Stacks = 'ALWAYS',
    Duration = -1,
    WeaponLabel = 'IceWeapon',
    Affects = {
        WeaponsEnable = {Bool = false,},
    },
}

BuffBlueprint {
    Name = 'HEMA01IceWeaponEnable',
    DisplayName = 'Ice Weapon Enabled',
    BuffType = 'MANUALWEAPONDISABLE',
    Debuff = false,
    Stacks = 'ALWAYS',
    Duration = -1,
    WeaponLabel = 'IceWeapon',
    Affects = {
        WeaponsEnable = {Bool = true,},
    },
}

BuffBlueprint {
    Name = 'HEMA01FireWeaponDisable',
    DisplayName = 'Fire Weapon Disabled',
    BuffType = 'MANUALWEAPONDISABLE',
    Debuff = false,
    Stacks = 'ALWAYS',
    Duration = -1,
    WeaponLabel = 'FireWeapon',
    Affects = {
        WeaponsEnable = {Bool = false,},
    },
}

BuffBlueprint {
    Name = 'HEMA01FireWeaponEnable',
    DisplayName = 'Fire Weapon Enabled',
    BuffType = 'MANUALWEAPONDISABLE',
    Debuff = false,
    Stacks = 'ALWAYS',
    Duration = -1,
    WeaponLabel = 'FireWeapon',
    Affects = {
        WeaponsEnable = {Bool = true,},
    },
}

#################################################################################################################
# Relive the Immolation
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01SwitchFire',
    DisplayName = '<LOC ABILITY_HEMA01_0000>Relive the Immolation',
    Description = '<LOC ABILITY_HEMA01_0001>The Torch Bearer relives his fiery death.\n\nMana Per Second briefly increased.\n\nFire abilities enabled.\nFrost abilities disabled.',
    AbilityType = 'Instant',
    Cooldown = 0.5,
    SharedCooldown = 'HEMA01ModeSwitch',
    UISlot = 4,
    HotKey = '4',
    AbilityCategory = 'HEMA01ICE',
    NotSilenceable = true,
    OnStartAbility = function(self, unit, params)
        unit:SetAbilities(false, false)
        ChangeState(unit, unit.FireState)
    end,
    Icon = '/dgtorchbearer/NewTorchBearReliveImmolation01',
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01ReliveImmolation',
            DisplayName = '<LOC ABILITY_HEMA01_0002>Soul of Ice',
            Description = '<LOC ABILITY_HEMA01_0003>+50% Mana Per Second',
            BuffType = 'HEMA01SOULOFICE',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 15,
            Icon = '/dgtorchbearer/NewTorchBearReliveImmolation01',
            DoNotPulseIcon = true,
            Affects = {
                EnergyRegen = {Mult = 0.5},
            },
        },
    }
}

#################################################################################################################
# Frozen Heart
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01SwitchIce',
    DisplayName = '<LOC ABILITY_HEMA01_0004>Frozen Heart',
    Description = '<LOC ABILITY_HEMA01_0005>The Torch Bearer ends his suffering and returns to his normal form. For a brief time, his Weapon Damage is increased.\n\nIce abilities enabled.\nFire abilities disabled.',
    AbilityType = 'Instant',
    Cooldown = 0.5,
    SharedCooldown = 'HEMA01ModeSwitch',
    UISlot = 4,
    HotKey = '4',
    AbilityCategory = 'HEMA01FIRE',
    NotSilenceable = true,
    OnStartAbility = function(self, unit, params)
        unit:SetAbilities(false, false)
        ChangeState(unit, unit.IceState)
    end,
    Icon = '/dgtorchbearer/NewTorchBearFrozenheart01',
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FrozenHeart',
            DisplayName = '<LOC ABILITY_HEMA01_0006>Heart of Fire',
            Description = '<LOC ABILITY_HEMA01_0007>Weapon Damage increased.',
            BuffType = 'HEMA01HEARTOFFIRE',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 15,
            Icon = '/dgtorchbearer/NewTorchBearFrozenheart01',
            DoNotPulseIcon = true,
            Affects = {
                DamageRating = {Add = 75},
            },
        },
    }
}

#################################################################################################################
# Fire Aura I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FireAura01',
    DisplayName = '<LOC ABILITY_HEMA01_0008>Fire Aura I',
    Description = '<LOC ABILITY_HEMA01_0059>Torch Bearer channels the energy of the flame around him, increasing the Attack Speed and Movement Speed of his allies.',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 20,
    AuraPulseTime = 2,
    AbilityCategory = 'HEMA01FIRE',
    CreateAbilityAmbients = function( self, unit, trash )
        FxFireAura01( unit, trash )
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FireAura01',
            DisplayName = '<LOC ABILITY_HEMA01_0009>Fire Aura',
            Description = '<LOC ABILITY_HEMA01_0010>Attack Speed and Movement Speed increased.',
            BuffType = 'HEMA01FIREAURA',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 5,
            Icon = '/dgtorchbearer/NewTorchBearFireAura01',
            DoNotPulseIcon = true,
            Affects = {
                RateOfFire = {Mult = 0.05},
                MoveMult = {Mult = 0.05},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FireAuraFx01',
            DisplayName = '<LOC ABILITY_HEMA01_0008>Fire Aura I',
            BuffType = 'HEMA01FIREAURAFX',
            Debuff = false,
            Stacks = 'IGNORE',
            Duration = 4,
            Affects = {
                Dummy = {},
            },
            OnApplyBuff = function( self, unit, instigator )
                if unit != instigator then
                    AttachBuffEffectAtBone( unit, 'Haste01', -2, unit.Buffs.BuffTable[self.BuffType][self.Name].Trash )
                end
            end,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFireAura01',
}

#################################################################################################################
# Fire Aura II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FireAura02',
    DisplayName = '<LOC ABILITY_HEMA01_0011>Fire Aura II',
    Description = '<LOC ABILITY_HEMA01_0060>Torch Bearer channels the energy of the flame around him, increasing the Attack Speed and Movement Speed of his allies.\n\nTorch Bearer\'s Weapon Damage is increased.',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 20,
    AuraPulseTime = 2,
    AbilityCategory = 'HEMA01FIRE',
    CreateAbilityAmbients = function( self, unit, trash )
        FxFireAura01( unit, trash )
    end,
    OnAuraPulse = function(self, unit, params)
        Buff.ApplyBuff(unit, 'HEMA01FireAuraDamageBuff02', unit)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FireAura02',
            DisplayName = '<LOC ABILITY_HEMA01_0009>Fire Aura',
            Description = '<LOC ABILITY_HEMA01_0010>Attack Speed and Movement Speed increased.',
            BuffType = 'HEMA01FIREAURA',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 5,
            Icon = '/dgtorchbearer/NewTorchBearFireAura01',
            DoNotPulseIcon = true,
            Affects = {
                RateOfFire = {Mult = 0.1},
                MoveMult = {Mult = 0.1},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FireAuraFx02',
            DisplayName = '<LOC ABILITY_HEMA01_0009>Fire Aura',
            BuffType = 'HEMA01FIREAURAFX',
            Debuff = false,
            Stacks = 'IGNORE',
            Duration = 4,
            Affects = {
                Dummy = {},
            },
            OnApplyBuff = function( self, unit, instigator )
                if unit != instigator then
                    AttachBuffEffectAtBone( unit, 'Haste01', -2, unit.Buffs.BuffTable[self.BuffType][self.Name].Trash )
                end
            end,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFireAura01',
}

BuffBlueprint {
    Name = 'HEMA01FireAuraDamageBuff02',
    DisplayName = '<LOC ABILITY_HEMA01_0009>Fire Aura',
    Description = '<LOC ABILITY_HEMA01_0012>Weapon Damage increased.',
    BuffType = 'HEMA01FIREAURADAMAGEBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 5,
    DoNotPulseIcon = true,
    Affects = {
        DamageRating = {Add = 15},
    },
}

#################################################################################################################
# Fire Aura III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FireAura03',
    DisplayName = '<LOC ABILITY_HEMA01_0013>Fire Aura III',
    Description = '<LOC ABILITY_HEMA01_0061>Torch Bearer channels the energy of the flame around him, increasing the Attack Speed and Movement Speed of his allies.\n\nTorch Bearer\'s Weapon Damage is increased.',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 20,
    AuraPulseTime = 2,
    AbilityCategory = 'HEMA01FIRE',
    CreateAbilityAmbients = function( self, unit, trash )
        FxFireAura01( unit, trash )
    end,
    OnAuraPulse = function(self, unit, params)
        Buff.ApplyBuff(unit, 'HEMA01FireAuraDamageBuff03', unit)
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FireAura03',
            DisplayName = '<LOC ABILITY_HEMA01_0009>Fire Aura',
            Description = '<LOC ABILITY_HEMA01_0010>Attack Speed and Movement Speed increased.',
            BuffType = 'HEMA01FIREAURA',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 5,
            Icon = '/dgtorchbearer/NewTorchBearFireAura01',
            DoNotPulseIcon = true,
            Affects = {
                RateOfFire = {Mult = 0.15},
                MoveMult = {Mult = 0.15},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FireAuraFx03',
            DisplayName = '<LOC ABILITY_HEMA01_0013>Fire Aura III',
            BuffType = 'HEMA01FIREAURAFX',
            Debuff = false,
            Stacks = 'IGNORE',
            Duration = 4,
            Affects = {
                Dummy = {},
            },
            OnApplyBuff = function( self, unit, instigator )
                if unit != instigator then
                    AttachBuffEffectAtBone( unit, 'Haste01', -2, unit.Buffs.BuffTable[self.BuffType][self.Name].Trash )
                end
            end,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFireAura01',
}

BuffBlueprint {
    Name = 'HEMA01FireAuraDamageBuff03',
    DisplayName = '<LOC ABILITY_HEMA01_0009>Fire Aura',
    Description = '<LOC ABILITY_HEMA01_0012>Weapon Damage increased.',
    BuffType = 'HEMA01FIREAURADAMAGEBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 5,
    DoNotPulseIcon = true,
    Affects = {
        DamageRating = {Add = 30},
    },
}

#################################################################################################################
# Fireball
#################################################################################################################
function Fireball(abilityDef, unit, params)
    if unit:IsDead() or params.Targets[1]:IsDead() then
        return
    end
    local unitpos = unit:GetPosition()
    local bonepos = unit:GetPosition('sk_TorchBearer_Staff_Muzzle_REF')
    local targpos = params.Targets[1]:GetPosition()
    local direction = VNormal(targpos-bonepos)

    local projpos = VDiff(bonepos, unitpos)
    local proj = unit:CreateProjectile('/projectiles/Fireball03/Fireball03_proj.bp', projpos[1], projpos[2], projpos[3], direction[1], direction[2], direction[3])
    
    local damage = abilityDef.DamageAmt
    if Validate.HasAbility(unit,'HEMA01FireandIce') then
       damage = damage + unit.AbilityData.FireballDamage
    end
    
    local damageTable = {
            Radius = abilityDef.DamageRadius or 0,
            Type = 'SpellFire',
            DamageAction = abilityDef.Name,
            DamageFriendly = false,
            CollideFriendly = false,
            Amount = damage,
            CanCrit = false,
            CanBackfire = false,
            CanDamageReturn = false,
            CanBeEvaded = false,
            IgnoreDamageRangePercent = true,
            CanMagicResist = true,
            ArmorImmune = true,
        }
           
    if proj and not proj:BeenDestroyed() then
        proj:PassDamageData(unit,damageTable)
    end
    proj:SetNewTarget(params.Targets[1])
    proj:SetVelocityVector(direction * 30)
    proj:TrackTarget(true)
end

#################################################################################################################
# Fireball I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01Fireball01',
    DisplayName = '<LOC ABILITY_HEMA01_0014>Fireball I',
    Description = '<LOC ABILITY_HEMA01_0015>Hurls a fiery ball at a target dealing [GetDamageAmt] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 300,
    RangeMax = 20,
    Cooldown = 7,
    DamageAmt = 300,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastFireball',
    CastingTime = 1.0,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    FollowThroughTime = 0.3,
    AbilityCategory = 'HEMA01FIRE',
    OnStartAbility = function(self, unit, params)
        Fireball(self, unit, params)
    end,
    Icon = '/dgtorchbearer/NewTorchBearFireball01',
}

#################################################################################################################
# Fireball II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01Fireball02',
    DisplayName = '<LOC ABILITY_HEMA01_0016>Fireball II',
    Description = '<LOC ABILITY_HEMA01_0015>Hurls a fiery ball at a target dealing [GetDamageAmt] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 380,
    RangeMax = 20,
    Cooldown = 7,
    DamageAmt = 525,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastFireball',
    CastingTime = 1.0,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    FollowThroughTime = 0.3,
    AbilityCategory = 'HEMA01FIRE',
    OnStartAbility = function(self, unit, params)
        Fireball(self, unit, params)
    end,
    Icon = '/dgtorchbearer/NewTorchBearFireball01',
}

#################################################################################################################
# Fireball III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01Fireball03',
    DisplayName = '<LOC ABILITY_HEMA01_0018>Fireball III',
    Description = '<LOC ABILITY_HEMA01_0015>Hurls a fiery ball at a target dealing [GetDamageAmt] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 460,
    RangeMax = 20,
    Cooldown = 7,
    DamageAmt = 850,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastFireball',
    CastingTime = 1.0,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    FollowThroughTime = 0.3,
    AbilityCategory = 'HEMA01FIRE',
    OnStartAbility = function(self, unit, params)
        Fireball(self, unit, params)
    end,
    Icon = '/dgtorchbearer/NewTorchBearFireball01',
}

#################################################################################################################
# Fireball IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01Fireball04',
    DisplayName = '<LOC ABILITY_HEMA01_0070>Fireball IV',
    Description = '<LOC ABILITY_HEMA01_0015>Hurls a fiery ball at a target dealing [GetDamageAmt] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 540,
    RangeMax = 20,
    Cooldown = 7,
    DamageAmt = 1050,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastFireball',
    CastingTime = 1.0,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    FollowThroughTime = 0.3,
    AbilityCategory = 'HEMA01FIRE',
    OnStartAbility = function(self, unit, params)
        Fireball(self, unit, params)
    end,
    Icon = '/dgtorchbearer/NewTorchBearFireball01',
}
#################################################################################################################
# VFX
# Fire Nova
#################################################################################################################
function FxFireNova( unit, pos )
    local army = unit:GetArmy()
    pos[2] = 100
    CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FireNova01', army, pos )
    CreateLightParticleIntel( unit, 0, army, 30, 4, 'glow/gl_0002_44', 'ramp/ra_0096_peach' )
    FxFireNovaEntity ( unit, pos, 12, 1 )
end

function FxFireNovaEntity( unit, pos, segments, radius )
    local angle = (2*math.pi) / segments

    for i = 1, segments do
        local s = math.sin(i*angle)
        local c = math.cos(i*angle)
        local x = s * radius
        local z = c * radius

        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FireNovaEntity01', unit:GetArmy(), Vector(pos[1] + x,pos[2],pos[3]+z), Vector(x, 0, z) )
    end
end

#################################################################################################################
# Fire Nova I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FireNova01',
    DisplayName = '<LOC ABILITY_HEMA01_0020>Fire Nova I',
    Description = '<LOC ABILITY_HEMA01_0021>A wave a fire radiates outward from the Torch Bearer, dealing [GetDamageAmt] damage and throwing smaller units into the air.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 775,
    AffectRadius = 15,
    Cooldown = 15,
    UISlot = 1,
    HotKey = '1',
    DamageAmt = 400,
    DamageType = 'SpellFire',
    CastAction = 'CastFireNova',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    AbilityCategory = 'HEMA01FIRE',
    OnStartCasting = function(self, unit)
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FireNovaCast01', unit:GetArmy(), table.copy(unit:GetPosition()) )
    end,
    OnStartAbility = function(self, unit, params)
        local pos = table.copy(unit:GetPosition())

        # Create Fire Nova VFX
        FxFireNova( unit, pos )

        pos[2] = GetSurfaceHeight(pos[1], pos[3]) - 0.25

		# Cache all entities in sphere
        local entities = GetEntitiesInSphere('UNITS', pos, self.AffectRadius )
		local affectedEntities = {}
        local metaEntities = {}

		# Filter untargetables
        for k, vEntity in entities do
            if not EntityCategoryContains(categories.UNTARGETABLE,vEntity) then
                table.insert(affectedEntities, vEntity)

				# Create a collection of entities to meta and remove frozen debuff on.
				if EntityCategoryContains(categories.METAINFANTRY,vEntity) then
					table.insert(metaEntities, vEntity)
					Buff.RemoveBuffsByAffect(vEntity, 'Freeze')
				end
            end
        end

        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Origin = pos,
            Radius = self.AffectRadius,
            Amount = 7,
            Category = 'METAINFANTRY',
        }
        MetaImpact( data, metaEntities  )

        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Origin = unit:GetPosition(),
            Amount = self.DamageAmt,
            Type = self.DamageType,
            DamageAction = self.Name,
            Radius = self.AffectRadius,
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
            NoFloatText = false,
        }
        DamageArea( data, affectedEntities )
        RippleWorld()
    end,
    Icon = '/dgtorchbearer/NewTorchBearFireNova01',
}

#################################################################################################################
# Fire Nova II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FireNova02',
    DisplayName = '<LOC ABILITY_HEMA01_0022>Fire Nova II',
    Description = '<LOC ABILITY_HEMA01_0023>A wave a fire radiates outward from the Torch Bearer, dealing [GetDamageAmt] damage and throwing smaller units into the air.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 1075,
    AffectRadius = 15,
    Cooldown = 15,
    UISlot = 1,
    HotKey = '1',
    DamageAmt = 600,
    DamageType = 'SpellFire',
    CastAction = 'CastFireNova',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    AbilityCategory = 'HEMA01FIRE',
    OnStartCasting = function(self, unit)
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FireNovaCast01', unit:GetArmy(), table.copy(unit:GetPosition()) )
    end,
    OnStartAbility = function(self, unit, params)
        local pos = table.copy(unit:GetPosition())

        # Create Fire Nova VFX
        FxFireNova( unit, pos )

        pos[2] = GetSurfaceHeight(pos[1], pos[3]) - 0.25

		# Cache all entities in sphere
        local entities = GetEntitiesInSphere('UNITS', pos, self.AffectRadius )
		local affectedEntities = {}
        local metaEntities = {}

		# Filter untargetables
        for k, vEntity in entities do
            if not EntityCategoryContains(categories.UNTARGETABLE,vEntity) then
                table.insert(affectedEntities, vEntity)

				# Create a collection of entities to meta and remove frozen debuff on.
				if EntityCategoryContains(categories.METAINFANTRY,vEntity) then
					table.insert(metaEntities, vEntity)
					Buff.RemoveBuffsByAffect(vEntity, 'Freeze')
				end
            end
        end

        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Origin = pos,
            Radius = self.AffectRadius,
            Amount = 12,
            Category = 'METAINFANTRY',
        }
        MetaImpact( data, metaEntities )

        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Origin = unit:GetPosition(),
            Amount = self.DamageAmt,
            Type = self.DamageType,
            DamageAction = self.Name,
            Radius = self.AffectRadius,
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
            NoFloatText = false,
        }
        DamageArea( data, affectedEntities )

        RippleWorld()
    end,
    Icon = '/dgtorchbearer/NewTorchBearFireNova01',
}

#################################################################################################################
# Fire Nova III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FireNova03',
    DisplayName = '<LOC ABILITY_HEMA01_0066>Fire Nova III',
    Description = '<LOC ABILITY_HEMA01_0067>A wave a fire radiates outward from the Torch Bearer, dealing [GetDamageAmt] damage and throwing smaller units into the air.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 1375,
    AffectRadius = 15,
    Cooldown = 15,
    UISlot = 1,
    HotKey = '1',
    DamageAmt = 800,
    DamageType = 'SpellFire',
    CastAction = 'CastFireNova',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    AbilityCategory = 'HEMA01FIRE',
    OnStartCasting = function(self, unit)
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FireNovaCast01', unit:GetArmy(), table.copy(unit:GetPosition()) )
    end,
    OnStartAbility = function(self, unit, params)
        local pos = table.copy(unit:GetPosition())

        # Create Fire Nova VFX
        FxFireNova( unit, pos )

        pos[2] = GetSurfaceHeight(pos[1], pos[3]) - 0.25

		# Cache all entities in sphere
        local entities = GetEntitiesInSphere('UNITS', pos, self.AffectRadius )
		local affectedEntities = {}
        local metaEntities = {}

		# Filter untargetables
        for k, vEntity in entities do
            if not EntityCategoryContains(categories.UNTARGETABLE,vEntity) then
                table.insert(affectedEntities, vEntity)

				# Create a collection of entities to meta and remove frozen debuff on.
				if EntityCategoryContains(categories.METAINFANTRY,vEntity) then
					table.insert(metaEntities, vEntity)
					Buff.RemoveBuffsByAffect(vEntity, 'Freeze')
				end
            end
        end

        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Origin = pos,
            Radius = self.AffectRadius,
            Amount = 12,
            Category = 'METAINFANTRY',
        }
        MetaImpact( data, metaEntities )

        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Origin = unit:GetPosition(),
            Amount = self.DamageAmt,
            Type = self.DamageType,
            DamageAction = self.Name,
            Radius = self.AffectRadius,
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
            NoFloatText = false,
        }
        DamageArea( data, affectedEntities )

        RippleWorld()
    end,
    Icon = '/dgtorchbearer/NewTorchBearFireNova01',
}

#################################################################################################################
# Circle of Fire
# VFX and Damage functionality
#################################################################################################################
function CreateFireRing(abil, unit, params, version)
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
                unit.AbilityData.TorchBearer.RingTrash:Add(vEmit)
            end
        end
        i = i + 1
        if i == 5 then
            i = 1
            WaitTicks(1)
        end
    end

    # Create effects around TorchBear, Distortion, Small flames inside radius.
    local emitters = CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FireCenter0'..version, army, pos, nil, unit.Trash  )
    for k, vEmit in emitters do
        unit.AbilityData.TorchBearer.RingTrash:Add(vEmit)
    end

    local entities = GetEntitiesInSphere('UNITS', pos, abil.AffectRadius )
	local IgnoredUnits = {}

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
        Group = "UNITS",
        CanBeEvaded = false,
        CanCrit = false,
        CanBackfire = false,
        CanDamageReturn = false,
        CanMagicResist = true,
        ArmorImmune = true,
        NoFloatText = false,
        IgnoreTargets = { IgnoredUnits },
    }

    local i = 0
    while i < abil.Duration do
        DamageArea(data)
        i = i + 1
        WaitSeconds(1)
    end

    if unit.AbilityData.TorchBearer.RingTrash then
        unit.AbilityData.TorchBearer.RingTrash:Destroy()
        unit.AbilityData.TorchBearer.RingTrash = nil
    end
end

#################################################################################################################
# Circle of Fire I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01RingOfFire01',
    DisplayName = '<LOC ABILITY_HEMA01_0024>Circle of Fire I',
    Description = '<LOC ABILITY_HEMA01_0025>Torch Bearer conjures a circle of fire around him, burning anything that stands in it for [GetDamageAmt] damage over [GetDuration] seconds.',
    #AbilityType = 'TargetedArea',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 450,
    #RangeMax = 15,
    AffectRadius = 10,
    Cooldown = 10,
    UISlot = 3,
    HotKey = '3',
    DamageAmt = 60,
    DamageType = 'SpellFire',
    Segments = 32,
    Duration = 10,
    CastAction = 'CastRingOfFire',
    CastingTime = 0.8,
    FollowThroughTime = 0.5,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt * self.Duration ) end,
    GetDuration = function(self) return math.floor( self.Duration ) end,
    AbilityCategory = 'HEMA01FIRE',
    #OnStartCasting = function(self, unit, params)
    OnStartCasting = function(self, unit, targetData)
        if not unit.AbilityData.TorchBearer.RingTrash then
            unit.AbilityData.TorchBearer.RingTrash = TrashBag()
        end
        unit.AbilityData.TorchBearer.RingTrash:Add(ForkThread(CreateFireRing, self, unit, targetData, 1 ))
    end,
    OnAbortAbility = function(self, unit)
        if unit.AbilityData.TorchBearer.RingTrash then
            unit.AbilityData.TorchBearer.RingTrash:Destroy()
            unit.AbilityData.TorchBearer.RingTrash = nil
        end
    end,
    Icon = '/dgtorchbearer/NewTorchBearRingofFire01',
    #Reticule = 'AoE_Fire',
}

#################################################################################################################
# Circle of Fire II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01RingOfFire02',
    DisplayName = '<LOC ABILITY_HEMA01_0026>Circle of Fire II',
    Description = '<LOC ABILITY_HEMA01_0027>Torch Bearer conjures a circle of fire around him, burning anything that stands in it for [GetDamageAmt] damage over [GetDuration] seconds.',
    #AbilityType = 'TargetedArea',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 600,
    #RangeMax = 15,
    AffectRadius = 10,
    Cooldown = 10,
    UISlot = 3,
    HotKey = '3',
    DamageAmt = 90,
    DamageType = 'SpellFire',
    Segments = 32,
    Duration = 10,
    CastAction = 'CastRingOfFire',
    CastingTime = 0.8,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt * self.Duration ) end,
    GetDuration = function(self) return math.floor( self.Duration ) end,
    FollowThroughTime = 0.5,
    AbilityCategory = 'HEMA01FIRE',
    #OnStartCasting = function(self, unit, params)
    OnStartCasting = function(self, unit, targetData)
        if not unit.AbilityData.TorchBearer.RingTrash then
            unit.AbilityData.TorchBearer.RingTrash = TrashBag()
        end
        unit.AbilityData.TorchBearer.RingTrash:Add(ForkThread(CreateFireRing, self, unit, targetData, 2 ))
    end,
    OnAbortAbility = function(self, unit)
        if unit.AbilityData.TorchBearer.RingTrash then
            unit.AbilityData.TorchBearer.RingTrash:Destroy()
            unit.AbilityData.TorchBearer.RingTrash = nil
        end
    end,
    Icon = '/dgtorchbearer/NewTorchBearRingofFire01',
    #Reticule = 'AoE_Fire',
}

#################################################################################################################
# Circle of Fire III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01RingOfFire03',
    DisplayName = '<LOC ABILITY_HEMA01_0028>Circle of Fire III',
    Description = '<LOC ABILITY_HEMA01_0029>Torch Bearer conjures a circle of fire around him, burning anything that stands in it for [GetDamageAmt] damage over [GetDuration] seconds.',
    #AbilityType = 'TargetedArea',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 700,
    #RangeMax = 15,
    AffectRadius = 10,
    Cooldown = 10,
    UISlot = 3,
    HotKey = '3',
    DamageAmt = 120,
    DamageType = 'SpellFire',
    Segments = 32,
    Duration = 10,
    CastAction = 'CastRingOfFire',
    CastingTime = 0.8,
    FollowThroughTime = 0.5,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt * self.Duration ) end,
    GetDuration = function(self) return math.floor( self.Duration ) end,
    AbilityCategory = 'HEMA01FIRE',
    #OnStartCasting = function(self, unit, params)
    OnStartCasting = function(self, unit, targetData)
        if not unit.AbilityData.TorchBearer.RingTrash then
            unit.AbilityData.TorchBearer.RingTrash = TrashBag()
        end
        unit.AbilityData.TorchBearer.RingTrash:Add(ForkThread(CreateFireRing, self, unit, targetData, 3 ))
    end,
    OnAbortAbility = function(self, unit)
        if unit.AbilityData.TorchBearer.RingTrash then
            unit.AbilityData.TorchBearer.RingTrash:Destroy()
            unit.AbilityData.TorchBearer.RingTrash = nil
        end
    end,
    Icon = '/dgtorchbearer/NewTorchBearRingofFire01',
    #Reticule = 'AoE_Fire',
}

#################################################################################################################
# Circle of Fire IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01RingOfFire04',
    DisplayName = '<LOC ABILITY_HEMA01_0071>Circle of Fire IV',
    Description = '<LOC ABILITY_HEMA01_0029>Torch Bearer conjures a circle of fire around him, burning anything that stands in it for [GetDamageAmt] damage over [GetDuration] seconds.',
    #AbilityType = 'TargetedArea',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 800,
    #RangeMax = 15,
    AffectRadius = 10,
    Cooldown = 10,
    UISlot = 3,
    HotKey = '3',
    DamageAmt = 150,
    DamageType = 'SpellFire',
    Segments = 32,
    Duration = 10,
    CastAction = 'CastRingOfFire',
    CastingTime = 0.8,
    FollowThroughTime = 0.5,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt * self.Duration ) end,
    GetDuration = function(self) return math.floor( self.Duration ) end,
    AbilityCategory = 'HEMA01FIRE',
    #OnStartCasting = function(self, unit, params)
    OnStartCasting = function(self, unit, targetData)
        if not unit.AbilityData.TorchBearer.RingTrash then
            unit.AbilityData.TorchBearer.RingTrash = TrashBag()
        end
        unit.AbilityData.TorchBearer.RingTrash:Add(ForkThread(CreateFireRing, self, unit, targetData, 3 ))
    end,
    OnAbortAbility = function(self, unit)
        if unit.AbilityData.TorchBearer.RingTrash then
            unit.AbilityData.TorchBearer.RingTrash:Destroy()
            unit.AbilityData.TorchBearer.RingTrash = nil
        end
    end,
    Icon = '/dgtorchbearer/NewTorchBearRingofFire01',
    #Reticule = 'AoE_Fire',
}

#################################################################################################################
# Inspirational Flame
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01InspFlame',
    DisplayName = '<LOC ABILITY_HEMA01_0074>Inspirational Flame',
    Description = '<LOC ABILITY_HEMA01_0075>Torch Bearer draws power from the flame, gaining [GetEnergy]% Mana and [GetEnergyRegen]% Mana Per Second.',
    AbilityType = 'Quiet',
    GetEnergy = function(self) return math.floor( Buffs[self.Name].Affects.MaxEnergy.Mult * 100 ) end,
    GetEnergyRegen = function(self) return math.floor( Buffs[self.Name].Affects.EnergyRegen.Mult * 100) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01InspFlame',
            DisplayName = '<LOC ABILITY_HEMA01_0076>Inspirational Flame',
            BuffType = 'HEMA01INSPFLAME',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                MaxEnergy = {Mult = .15, AdjustEnergy = true},
                EnergyRegen = {Mult = 2},
            },
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearInspirationalFlame01',
}

#################################################################################################################
# Perma Frost I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FrostAura01',
    DisplayName = '<LOC ABILITY_HEMA01_0030>Permafrost I',
    Description = '<LOC ABILITY_HEMA01_0062>Torch Bearer exudes an aura of extreme cold, reducing the Attack Speed and Movement Speed of nearby enemies.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 20,
    AuraPulseTime = 2,
    AbilityCategory = 'HEMA01ICE',
    CreateAbilityAmbients = function( self, unit, trash )
        FxFrostAura01( unit, trash )
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FrostAura01',
            DisplayName = '<LOC ABILITY_HEMA01_0032>Permafrost',
            Description = '<LOC ABILITY_HEMA01_0033>Attack Speed and Movement Speed reduced.',
            BuffType = 'HEMA01FROSTAURA',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 5,
            DoNotPulseIcon = true,
            Icon = '/dgtorchbearer/NewTorchBearFrostAura01',
            Affects = {
                RateOfFire = {Mult = -.03},
                MoveMult = {Mult = -0.03},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FrostAuraFx01',
            DisplayName = '<LOC ABILITY_HEMA01_0030>Permafrost I',
            BuffType = 'HEMA01FROSTAURAFX',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFrostAura01',
}

#################################################################################################################
# Perma Frost II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FrostAura02',
    DisplayName = '<LOC ABILITY_HEMA01_0034>Permafrost II',
    Description = '<LOC ABILITY_HEMA01_0063>Torch Bearer exudes an aura of extreme cold, reducing the Attack Speed and Movement Speed of nearby enemies.\n\nThe chill energizes his allies, increasing their Mana Per Second.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 20,
    AuraPulseTime = 2,
    AbilityCategory = 'HEMA01ICE',
    CreateAbilityAmbients = function( self, unit, trash )
        FxFrostAura01( unit, trash )
    end,
    OnAbilityAdded = function(self, unit)
        Abil.AddAbility(unit,'HEMA01FrostAuraFriendly02', true)
    end,
    OnRemoveAbility = function(self, unit)
        Abil.RemoveAbility(unit,'HEMA01FrostAuraFriendly02')
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FrostAura02',
            DisplayName = '<LOC ABILITY_HEMA01_0032>Permafrost',
            Description = '<LOC ABILITY_HEMA01_0033>Attack Speed and Movement Speed reduced.',
            BuffType = 'HEMA01FROSTAURA',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 5,
            DoNotPulseIcon = true,
            Icon = '/dgtorchbearer/NewTorchBearFrostAura01',
            Affects = {
                RateOfFire = {Mult = -0.10},
                MoveMult = {Mult = -0.05},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FrostAuraFx02',
            DisplayName = '<LOC ABILITY_HEMA01_0034>Permafrost II',
            BuffType = 'HEMA01FROSTAURAFX',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFrostAura01',
}

AbilityBlueprint {
    Name = 'HEMA01FrostAuraFriendly02',
    DisplayName = '<LOC ABILITY_HEMA01_0032>Permafrost',
    Description = '<LOC ABILITY_HEMA01_0035>Mana Per Second increased.',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'HERO - UNTARGETABLE',
    AffectRadius = 20,
    AuraPulseTime = 2,
    AbilityCategory = 'HEMA01ICE',
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FrostAuraFriendly02',
            DisplayName = '<LOC ABILITY_HEMA01_0032>Permafrost',
            Description = '<LOC ABILITY_HEMA01_0035>Mana Per Second increased.',
            BuffType = 'HEMA01FROSTAURAFRIENDLY',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 5,
            DoNotPulseIcon = true,
            Icon = '/dgtorchbearer/NewTorchBearFrostAura01',
            Affects = {
                EnergyRegen = {Add = 4.5},
            },
        },
    },
}

#################################################################################################################
# Perma Frost III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FrostAura03',
    DisplayName = '<LOC ABILITY_HEMA01_0036>Permafrost III',
    Description = '<LOC ABILITY_HEMA01_0063>Torch Bearer exudes an aura of extreme cold, reducing the Attack Speed and Movement Speed of nearby enemies.\n\nThe chill energizes his allies, increasing their Mana Per Second.',
    AbilityType = 'Aura',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    AffectRadius = 20,
    AuraPulseTime = 2,
    AbilityCategory = 'HEMA01ICE',
    CreateAbilityAmbients = function( self, unit, trash )
        FxFrostAura01( unit, trash )
    end,
    OnAbilityAdded = function(self, unit)
        Abil.AddAbility(unit,'HEMA01FrostAuraFriendly03', true)
    end,
    OnRemoveAbility = function(self, unit)
        Abil.RemoveAbility(unit,'HEMA01FrostAuraFriendly03')
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FrostAura03',
            DisplayName = '<LOC ABILITY_HEMA01_0032>Permafrost',
            Description = '<LOC ABILITY_HEMA01_0033>Attack Speed and Movement Speed reduced.',
            BuffType = 'HEMA01FROSTAURA',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 5,
            DoNotPulseIcon = true,
            Icon = '/dgtorchbearer/NewTorchBearFrostAura01',
            Affects = {
                RateOfFire = {Mult = -.15},
                MoveMult = {Mult = -0.07},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FrostAuraFx03',
            DisplayName = '<LOC ABILITY_HEMA01_0036>Permafrost III',
            BuffType = 'HEMA01FROSTAURAFX',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFrostAura01',
}

AbilityBlueprint {
    Name = 'HEMA01FrostAuraFriendly03',
    DisplayName = '<LOC ABILITY_HEMA01_0032>Permafrost',
    Description = '<LOC ABILITY_HEMA01_0035>Mana Per Second increased.',
    AbilityType = 'Aura',
    TargetAlliance = 'Ally',
    TargetCategory = 'HERO - UNTARGETABLE',
    AffectRadius = 20,
    AuraPulseTime = 2,
    AbilityCategory = 'HEMA01ICE',
    Tooltip = {
        TargetAlliance = 'Ally',
    },
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FrostAuraFriendly03',
            DisplayName = '<LOC ABILITY_HEMA01_0032>Permafrost',
            Description = '<LOC ABILITY_HEMA01_0035>Mana Per Second increased.',
            BuffType = 'HEMA01FROSTAURAFRIENDLY',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 5,
            DoNotPulseIcon = true,
            Icon = '/dgtorchbearer/NewTorchBearFrostAura01',
            Affects = {
                EnergyRegen = {Add = 9},
            },
        },
    },
}

#################################################################################################################
# Deep Freeze Damage
#################################################################################################################
function DeepFreezeDamage(self, unit, target)
    local damage = self.DamagePerBuff
    if Validate.HasAbility(unit,'HEMA01FireandIce') then
       damage = damage + unit.AbilityData.FreezeDamage
    end
    local damagetotal = 0
    if Buff.HasBuff(target, 'HEMA01NovaSlow01') then
        Buff.RemoveBuff(target, 'HEMA01NovaSlow01')
        damagetotal = damagetotal + 1
    end
    if Buff.HasBuff(target, 'HEMA01NovaSlow02') then
        Buff.RemoveBuff(target, 'HEMA01NovaSlow03')
        damagetotal = damagetotal + 1
    end
    if Buff.HasBuff(target, 'HEMA01NovaSlow03') then
        Buff.RemoveBuff(target, 'HEMA01NovaSlow03')
        damagetotal = damagetotal + 1
    end
    if Buff.HasBuff(target, 'HEMA01RainSlow01') then
        Buff.RemoveBuff(target, 'HEMA01RainSlow01')
        damagetotal = damagetotal + 1
    end
    if Buff.HasBuff(target, 'HEMA01RainSlow02') then
        Buff.RemoveBuff(target, 'HEMA01RainSlow02')
        damagetotal = damagetotal + 1
    end
    if Buff.HasBuff(target, 'HEMA01RainSlow03') then
        Buff.RemoveBuff(target, 'HEMA01RainSlow03')
        damagetotal = damagetotal + 1
    end
    if Buff.HasBuff(target, 'HEMA01RainSlow04') then
        Buff.RemoveBuff(target, 'HEMA01RainSlow04')
        damagetotal = damagetotal + 1
    end
    if Buff.HasBuff(target, 'HEMA01ClarityBuff') then
        Buff.RemoveBuff(target, 'HEMA01ClarityBuff')
        damagetotal = damagetotal + 1
    end
    if damagetotal > 0 then
        local string = LOCF("<LOC floattext_0014>%dX SHATTER", damagetotal)
        FloatTextAt(table.copy(target:GetFloatTextPosition()), string, 'Shatter')
        # Damage Target
        damagetotal = damagetotal * damage
        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Amount = damagetotal,
            Type = 'Spell',
            DamageAction = self.Name,
            DamageSelf = false,
            Origin = unit:GetPosition(),
            CanCrit = false,
            IgnoreDamageRangePercent = true,
            CanBackfire = false,
            CanBeEvaded = false,
            CanMagicResist = true,
            ArmorImmune = true,
            Group = "UNITS",
        }
        DealDamage(data, target)
    end
end

#################################################################################################################
# Deep Freeze I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FreezeStructure01',
    DisplayName = '<LOC ABILITY_HEMA01_0037>Deep Freeze I',
    Description = '<LOC ABILITY_HEMA01_0038>Torch Bearer blasts a target with intense cold. Interrupts abilities and increases target\'s cooldown time by [GetCooldownBuff]%. Lasts for [GetDuration] seconds.\n\nIf the target is affected by Frost Nova or Rain of Ice, Deep Freeze consumes each effect and deals [GetDamage] damage for each effect.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 350,
    RangeMax = 18,
    Cooldown = 15,
    DamagePerBuff = 100,
    UISlot = 3,
    HotKey = '3',
    GetCooldownBuff = function(self) return math.floor( (Buffs['HEMA01FreezeSlow01'].Affects.Cooldown.Mult )* 100 ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01FreezeSlow01'].Duration  ) end,
    GetDamage = function(self) return self.DamagePerBuff end,
    CastAction = 'CastFreezeStructure',
    CastingTime = 0.1,
    FollowThroughTime = 1.0,
    AbilityCategory = 'HEMA01ICE',
    OnStartCasting = function(self, unit, params)
        # Casting effects on Torchbear
        AttachEffectsAtBone( unit, EffectTemplates.TorchBearer.FreezeCast01, -2 )
    end,
    OnStartAbility = function(self, unit, params)
        ForkThread(FxFreezeUnit, self, unit, params.Targets[1])
        ForkThread(DeepFreezeDamage, self, unit, params.Targets[1])
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01DeepFreeze01',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            BuffType = 'HEMADEEPFREEZE01',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = .1,
            Affects = {
                Interrupt = {Add = 0},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FreezeSlow01',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            Description = '<LOC ABILITY_HEMA01_0040>Cooldowns increased. Attack and Movement Speed reduced.',
            BuffType = 'SLOWUNIT',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'MOBILE',
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                Cooldown = {Mult = 1.3},
            },
            Icon = '/dgtorchbearer/NewTorchBearFreezeStructure01',
        },
        BuffBlueprint {
            Name = 'HEMA01FreezeSlowFx01',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            BuffType = 'SLOWUNITFX',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFreezeStructure01',
}

#################################################################################################################
# Deep Freeze II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FreezeStructure02',
    DisplayName = '<LOC ABILITY_HEMA01_0041>Deep Freeze II',
    Description = '<LOC ABILITY_HEMA01_0038>Torch Bearer blasts a target with intense cold. Interrupts abilities and increases target\'s cooldown time by [GetCooldownBuff]%. Lasts for [GetDuration] seconds.\n\nIf the target is affected by Frost Nova or Rain of Ice, Deep Freeze consumes each effect and deals [GetDamage] damage for each effect.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 475,
    RangeMax = 18,
    Cooldown = 15,
    DamagePerBuff = 175,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'CastFreezeStructure',
    CastingTime = 0.1,
    FollowThroughTime = 1.0,
    GetCooldownBuff = function(self) return math.floor( (Buffs['HEMA01FreezeSlow02'].Affects.Cooldown.Mult )* 100 ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01FreezeSlow02'].Duration  ) end,
    GetDamage = function(self) return self.DamagePerBuff end,
    AbilityCategory = 'HEMA01ICE',
    OnStartCasting = function(self, unit, params)
        # Casting effects on Torchbear
        AttachEffectsAtBone( unit, EffectTemplates.TorchBearer.FreezeCast01, -2 )
    end,
    OnStartAbility = function(self, unit, params)
        ForkThread(FxFreezeUnit, self, unit, params.Targets[1])
        ForkThread(DeepFreezeDamage, self, unit, params.Targets[1])
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01DeepFreeze02',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            BuffType = 'HEMADEEPFREEZE02',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = .1,
            Affects = {
                Interrupt = {Add = 0},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FreezeSlow02',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            Description = '<LOC ABILITY_HEMA01_0040>Cooldowns increased. Attack and Movement Speed reduced.',
            BuffType = 'SLOWUNIT',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'MOBILE',
            Stacks = 'REPLACE',
            Duration = 6,
            CanBeDispelled = true,
            Affects = {
                Cooldown = {Mult = 1.6},
            },
            Icon = '/dgtorchbearer/NewTorchBearFreezeStructure01',
        },
        BuffBlueprint {
            Name = 'HEMA01FreezeSlowFx02',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            BuffType = 'SLOWUNITFX',
            Debuff = true,
            Stacks = 'REPLACE',
            Duration = 6,
            CanBeDispelled = true,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFreezeStructure01',
}

#################################################################################################################
# Deep Freeze III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FreezeStructure03',
    DisplayName = '<LOC ABILITY_HEMA01_0043>Deep Freeze III',
    Description = '<LOC ABILITY_HEMA01_0038>Torch Bearer blasts a target with intense cold. Interrupts abilities and increases target\'s cooldown time by [GetCooldownBuff]%. Lasts for [GetDuration] seconds.\n\nIf the target is affected by Frost Nova or Rain of Ice, Deep Freeze consumes each effect and deals [GetDamage] damage for each effect.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 600,
    RangeMax = 20,
    Cooldown = 15,
    DamagePerBuff = 250,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'CastFreezeStructure',
    CastingTime = 0.1,
    GetCooldownBuff = function(self) return math.floor( (Buffs['HEMA01FreezeSlow03'].Affects.Cooldown.Mult )* 100 ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01FreezeSlow03'].Duration  ) end,
    GetDamage = function(self) return self.DamagePerBuff end,
    FollowThroughTime = 1.0,
    AbilityCategory = 'HEMA01ICE',
    OnStartCasting = function(self, unit, params)
        # Casting effects on Torchbear
        AttachEffectsAtBone( unit, EffectTemplates.TorchBearer.FreezeCast01, -2 )
    end,
    OnStartAbility = function(self, unit, params)
        ForkThread(FxFreezeUnit, self, unit, params.Targets[1])
        ForkThread(DeepFreezeDamage, self, unit, params.Targets[1])
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01DeepFreeze03',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            BuffType = 'HEMADEEPFREEZE03',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = .1,
            Affects = {
                Interrupt = {Add = 0},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FreezeSlow03',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            Description = '<LOC ABILITY_HEMA01_0040>Cooldowns increased. Attack and Movement Speed reduced.',
            BuffType = 'SLOWUNIT',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'MOBILE',
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                Cooldown = {Mult = 1.9},
            },
            Icon = '/dgtorchbearer/NewTorchBearFreezeStructure01',
        },
        BuffBlueprint {
            Name = 'HEMA01FreezeSlowFx03',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            BuffType = 'SLOWUNITFX',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFreezeStructure01',
}

#################################################################################################################
# Deep Freeze IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FreezeStructure04',
    DisplayName = '<LOC ABILITY_HEMA01_0072>Deep Freeze IV',
    Description = '<LOC ABILITY_HEMA01_0038>Torch Bearer blasts a target with intense cold. Interrupts abilities and increases target\'s cooldown time by [GetCooldownBuff]%. Lasts for [GetDuration] seconds.\n\nIf the target is affected by Frost Nova or Rain of Ice, Deep Freeze consumes each effect and deals [GetDamage] damage for each effect.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'HOSTILEMOBILE',
    EnergyCost = 725,
    RangeMax = 20,
    Cooldown = 15,
    DamagePerBuff = 325,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'CastFreezeStructure',
    CastingTime = 0.1,
    GetCooldownBuff = function(self) return math.floor( (Buffs['HEMA01FreezeSlow04'].Affects.Cooldown.Mult )* 100 ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01FreezeSlow04'].Duration  ) end,
    GetDamage = function(self) return self.DamagePerBuff end,
    FollowThroughTime = 1.0,
    AbilityCategory = 'HEMA01ICE',
    OnStartCasting = function(self, unit, params)
        # Casting effects on Torchbear
        AttachEffectsAtBone( unit, EffectTemplates.TorchBearer.FreezeCast01, -2 )
    end,
    OnStartAbility = function(self, unit, params)
        ForkThread(FxFreezeUnit, self, unit, params.Targets[1])
        ForkThread(DeepFreezeDamage, self, unit, params.Targets[1])
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01DeepFreeze04',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            BuffType = 'HEMADEEPFREEZE03',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = .1,
            Affects = {
                Interrupt = {Add = 0},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FreezeSlow04',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            Description = '<LOC ABILITY_HEMA01_0040>Cooldowns increased. Attack and Movement Speed reduced.',
            BuffType = 'SLOWUNIT',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'MOBILE',
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                Cooldown = {Mult = 2.2},
            },
            Icon = '/dgtorchbearer/NewTorchBearFreezeStructure01',
        },
        BuffBlueprint {
            Name = 'HEMA01FreezeSlowFx04',
            DisplayName = '<LOC ABILITY_HEMA01_0039>Deep Freeze',
            BuffType = 'SLOWUNITFX',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFreezeStructure01',
}
       
##################################################################################################################
## Fire and Ice
##################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FireandIce',
    DisplayName = '<LOC ABILITY_HEMA01_0081>Fire and Ice',
    Description = '<LOC ABILITY_HEMA01_0082>Torch Bearer weaves his elemental powers into a cataclysmic force. Fireball\'s damage is increased by [GetFireballDamage]. Deep Freeze deals [GetFreezeDamage] additional damage for each effect consumed.',
    AbilityType = 'Quiet',
    Icon = '/dgtorchbearer/NewTorchBearFireandIce01',
    FireballDamage = 300,
    FreezeDamage = 100,
    GetFireballDamage = function(self) return self.FireballDamage end,
    GetFreezeDamage = function(self) return self.FreezeDamage end,
    OnAbilityAdded = function(self, unit)
        if not unit.AbilityData.FireballDamage then
            unit.AbilityData.FireballDamage = self.FireballDamage
        end
        if not unit.AbilityData.FreezeDamage then
            unit.AbilityData.FreezeDamage = self.FreezeDamage
        end
    end,
}

#################################################################################################################
# VFX
# Frost Nova
#################################################################################################################
function FxFrostNovaEntity( unit, pos, segments, radius, EmitterIds )
    local angle = (2*math.pi) / segments

    for i = 1, segments do
        local s = math.sin(i*angle)
        local c = math.cos(i*angle)
        local x = s * radius
        local z = c * radius

        if GetTerrainType(pos[1]+x, pos[3]+z).Name != 'Void' then
            CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FrostNovaEntity01', unit:GetArmy(), Vector(pos[1] + x,pos[2],pos[3]+z), Vector(x, 0, z) )
        end
    end
end

function FxFrostNovaTendrils( unit, pos, segments, radius )
    local angle = (2*math.pi) / segments

    for i = 1, segments do
        local s = math.sin(i*angle)
        local c = math.cos(i*angle)
        local x = s * radius
        local z = c * radius

        local proj = unit:CreateProjectile( '/projectiles/fireball01/fireball01_proj.bp', pos[1], pos[2]+10, pos[3], 0, 1, 0 )
        proj:SetVelocity(15)
        proj:SetLifetime(20)
    end
end

#################################################################################################################
# Frost Nova I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FrostNova01',
    DisplayName = '<LOC ABILITY_HEMA01_0045>Frost Nova I',
    Description = '<LOC ABILITY_HEMA01_0046>Releases a wave of frost, freezing all enemies around the Torch Bearer, stunning them for [GetStun] seconds. Demigods are stunned for [GetDemigodStun] seconds.\n\nAll units have [GetMovementSlow]% Movement Speed for [GetDuration] seconds.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 750,
    AffectRadius = 15,
    Cooldown = 15,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'CastFrostNova',
    CastingTime = 0.9,
    FollowThroughTime = 0.6,
    GetStun = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDemigodStun = function(self) return math.floor( Buffs['HEMA01FrostNova01Hero'].Duration  ) end,
    GetMovementSlow = function(self) return math.floor( Buffs['HEMA01NovaSlow01'].Affects.MoveMult.Mult * 100  ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01NovaSlow01'].Duration  ) end,
    AbilityCategory = 'HEMA01ICE',
    OnStartCasting = function(self, unit)
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FrostNovaCast01', unit:GetArmy(), table.copy(unit:GetPosition()) )
    end,
    OnStartAbility = function(self, unit, params)
        local pos = table.copy(unit:GetPosition())
        pos[2] = 100
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FrostNova01', unit:GetArmy(), pos )
        CreateLightParticleIntel( unit, 0, unit:GetArmy(), 30, 2.5, 'glow/gl_0002_44', 'ramp/ra_0098_bluefast' )
        FxFrostNovaEntity ( unit, pos, 9, 6 )
        #FxFrostNovaTendrils ( unit, pos, 5, 6 )
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FrostNova01',
            DisplayName = '<LOC ABILITY_HEMA01_0047>Frost Nova',
            Description = '<LOC ABILITY_HEMA01_0048>Frozen.',
            BuffType = 'FREEZESTRUCTURE',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'ALLUNITS - HERO - UNTARGETABLE',
            Stacks = 'REPLACE',
            Duration = 6,
            TriggersStunImmune = true,
            Affects = {
                Freeze = {Add = 0},
            },
            Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
        },
        BuffBlueprint {
            Name = 'HEMA01FrostNova01Hero',
            DisplayName = '<LOC ABILITY_HEMA01_0047>Frost Nova',
            Description = '<LOC ABILITY_HEMA01_0048>Frozen.',
            BuffType = 'FREEZEUNIT',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'HERO',
            Stacks = 'REPLACE',
            Duration = 1,
            TriggersStunImmune = true,
            Affects = {
                Freeze = {Add = 0},
            },
            Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
        },
        BuffBlueprint {
            Name = 'HEMA01FrostNova01Immune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'MINION',
            Stacks = 'IGNORE',
            Duration = 12,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FrostNova01HeroImmune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'IGNORE',
            Duration = 2,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01NovaSlow01',
            DisplayName = '<LOC ABILITY_HEMA01_0047>Frost Nova',
            Description = '<LOC ABILITY_HEMA01_0094>Movement Speed reduced.',
            BuffType = 'SLOWUNITNOVA',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'MOBILE',
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                MoveMult = {Mult = -0.10},
            },
            Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
        },
        BuffBlueprint {
            Name = 'HEMA01NovaSlowFx01',
            BuffType = 'SLOWUNITFX',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
}

#################################################################################################################
# Frost Nova II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FrostNova02',
    AbilityType = 'Instant',
    DisplayName = '<LOC ABILITY_HEMA01_0049>Frost Nova II',
    Description = '<LOC ABILITY_HEMA01_0046>Releases a wave of frost, freezing all enemies around the Torch Bearer, stunning them for [GetStun] seconds. Demigods are stunned for [GetDemigodStun] seconds.\n\nAll units have [GetMovementSlow]% Movement Speed for [GetDuration] seconds.',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 1000,
    AffectRadius = 15,
    Cooldown = 15,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'CastFrostNova',
    CastingTime = 0.9,
    FollowThroughTime = 0.6,
    GetStun = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDemigodStun = function(self) return math.floor( Buffs['HEMA01FrostNova02Hero'].Duration  ) end,
    GetMovementSlow = function(self) return math.ceil( Buffs['HEMA01NovaSlow02'].Affects.MoveMult.Mult * 100  ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01NovaSlow02'].Duration  ) end,
    AbilityCategory = 'HEMA01ICE',
    OnStartCasting = function(self, unit)
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FrostNovaCast01', unit:GetArmy(), table.copy(unit:GetPosition()) )
    end,
    OnStartAbility = function(self, unit, params)
        local pos = table.copy(unit:GetPosition())
        pos[2] = 100
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FrostNova01', unit:GetArmy(), pos )
        CreateLightParticleIntel( unit, 0, unit:GetArmy(), 30, 2.5, 'glow/gl_0002_44', 'ramp/ra_0098_bluefast' )
        FxFrostNovaEntity ( unit, pos, 9, 6 )
        #FxFrostNovaTendrils ( unit, pos, 5, 6 )
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FrostNova02',
            DisplayName = '<LOC ABILITY_HEMA01_0047>Frost Nova',
            Description = '<LOC ABILITY_HEMA01_0048>Frozen.',
            BuffType = 'FREEZESTRUCTURE',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'ALLUNITS - HERO - UNTARGETABLE',
            Stacks = 'REPLACE',
            Duration = 8,
            TriggersStunImmune = true,
            Affects = {
                Freeze = {Add = 0},
            },
            Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
        },
        BuffBlueprint {
            Name = 'HEMA01FrostNova02Hero',
            DisplayName = '<LOC ABILITY_HEMA01_0047>Frost Nova',
            Description = '<LOC ABILITY_HEMA01_0048>Frozen.',
            BuffType = 'FREEZEUNIT',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'HERO',
            Stacks = 'REPLACE',
            Duration = 2,
            TriggersStunImmune = true,
            Affects = {
                Freeze = {Add = 0},
            },
            Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
        },
        BuffBlueprint {
            Name = 'HEMA01FrostNova02Immune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'MINION',
            Stacks = 'IGNORE',
            Duration = 16,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FrostNova02HeroImmune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'IGNORE',
            Duration = 4,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01NovaSlow02',
            DisplayName = '<LOC ABILITY_HEMA01_0047>Frost Nova',
            Description = '<LOC ABILITY_HEMA01_0095>Movement Speed reduced.',
            BuffType = 'SLOWUNITNOVA',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'MOBILE',
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                MoveMult = {Mult = -0.15},
            },
            Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
        },
        BuffBlueprint {
            Name = 'HEMA01NovaSlowFx02',
            BuffType = 'SLOWUNITFX',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 7,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
}

#################################################################################################################
# Frost Nova III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01FrostNova03',
    AbilityType = 'Instant',
    DisplayName = '<LOC ABILITY_HEMA01_0068>Frost Nova III',
    Description = '<LOC ABILITY_HEMA01_0046>Releases a wave of frost, freezing all enemies around the Torch Bearer, stunning them for [GetStun] seconds. Demigods are stunned for [GetDemigodStun] seconds.\n\nAll units have [GetMovementSlow]% Movement Speed for [GetDuration] seconds.',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 1250,
    AffectRadius = 15,
    Cooldown = 15,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'CastFrostNova',
    CastingTime = 0.9,
    FollowThroughTime = 0.6,
    GetStun = function(self) return math.floor( Buffs[self.Name].Duration ) end,
    GetDemigodStun = function(self) return math.floor( Buffs['HEMA01FrostNova03Hero'].Duration  ) end,
    GetMovementSlow = function(self) return math.ceil(( Buffs['HEMA01NovaSlow03'].Affects.MoveMult.Mult * 100)) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01NovaSlow03'].Duration  ) end,
    AbilityCategory = 'HEMA01ICE',
    OnStartCasting = function(self, unit)
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FrostNovaCast01', unit:GetArmy(), table.copy(unit:GetPosition()) )
    end,
    OnStartAbility = function(self, unit, params)
        local pos = table.copy(unit:GetPosition())
        pos[2] = 100
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'FrostNova01', unit:GetArmy(), pos )
        CreateLightParticleIntel( unit, 0, unit:GetArmy(), 30, 2.5, 'glow/gl_0002_44', 'ramp/ra_0098_bluefast' )
        FxFrostNovaEntity ( unit, pos, 9, 6 )
        #FxFrostNovaTendrils ( unit, pos, 5, 6 )
    end,
    Buffs = {
        BuffBlueprint {
            Name = 'HEMA01FrostNova03',
            DisplayName = '<LOC ABILITY_HEMA01_0047>Frost Nova',
            Description = '<LOC ABILITY_HEMA01_0048>Frozen.',
            BuffType = 'FREEZESTRUCTURE',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'ALLUNITS - HERO - UNTARGETABLE',
            Stacks = 'REPLACE',
            Duration = 10,
            TriggersStunImmune = true,
            Affects = {
                Freeze = {Add = 0},
            },
            Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
        },
        BuffBlueprint {
            Name = 'HEMA01FrostNova03Hero',
            DisplayName = '<LOC ABILITY_HEMA01_0047>Frost Nova',
            Description = '<LOC ABILITY_HEMA01_0048>Frozen.',
            BuffType = 'FREEZEUNIT',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'HERO',
            Stacks = 'REPLACE',
            Duration = 3,
            TriggersStunImmune = true,
            Affects = {
                Freeze = {Add = 0},
            },
            Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
        },
        BuffBlueprint {
            Name = 'HEMA01FrostNova03Immune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'MINION',
            Stacks = 'IGNORE',
            Duration = 20,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01FrostNova03HeroImmune',
            Debuff = false,
            BuffType = 'STUNIMMUNE',
            EntityCategory = 'HERO - UNTARGETABLE',
            Stacks = 'IGNORE',
            Duration = 6,
            Affects = {
                StunImmune = {Bool = true,},
            },
        },
        BuffBlueprint {
            Name = 'HEMA01NovaSlow03',
            DisplayName = '<LOC ABILITY_HEMA01_0047>Frost Nova',
            Description = '<LOC ABILITY_HEMA01_0096>Movement Speed reduced.',
            BuffType = 'SLOWUNITNOVA',
            Debuff = true,
            CanBeDispelled = true,
            EntityCategory = 'MOBILE',
            Stacks = 'REPLACE',
            Duration = 5,
            Affects = {
                MoveMult = {Mult = -0.20},
            },
            Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
        },
        BuffBlueprint {
            Name = 'HEMA01NovaSlowFx03',
            BuffType = 'SLOWUNITFX',
            Debuff = true,
            CanBeDispelled = true,
            Stacks = 'REPLACE',
            Duration = 10,
            Affects = {
                Dummy = {},
            },
            Effects = 'Slow01',
            EffectsBone = -2,
        },
    },
    Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
}

#################################################################################################################
# Rain of Ice I
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01RainIce01',
    DisplayName = '<LOC ABILITY_HEMA01_0051>Rain of Ice I',
    Description = '<LOC ABILITY_HEMA01_0052>A maelstrom of hail and sleet pelts the target area dealing [GetDamageAmt] damage and slowing Attack Speed by [GetAttackSlow]% for [GetDuration] seconds.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 500,
    RangeMax = 20,
    Cooldown = 14,
    DamageAmt = 200,
    AffectRadius = 10,
    NumFireBalls = 5,
    NumWaves = 1,
    UISlot = 2,
    HotKey = '2',
    Buff1 = 'HEMA01RainSlow01',
    Buff2 = 'HEMA01FreezeSlowFx01',
    CastAction = 'CastFreeze',
    CastingTime = 0.1,
    FollowThroughTime = 0.9,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetAttackSlow = function(self) return math.floor( Buffs['HEMA01RainSlow01'].Affects.RateOfFire.Mult * 100  ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01RainSlow01'].Duration  ) end,
    AbilityCategory = 'HEMA01ICE',
    OnStartAbility = function(self, unit, params)
        ForkThread(CallRain, self, unit, params, '/projectiles/HailBall01/HailBall01_proj.bp' )
    end,
    Icon = '/dgtorchbearer/NewTorchBearRainofIce01',
    Reticule = 'AoE_Ice',
}

BuffBlueprint {
    Name = 'HEMA01RainSlow01',
    DisplayName = '<LOC ABILITY_HEMA01_0051>Rain of Ice I',
    Description = '<LOC ABILITY_HEMA01_0090>Attack Speed reduced.',
    BuffType = 'SLOWUNITRAIN',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'MOBILE',
    Stacks = 'REPLACE',
    Duration = 3,
    Affects = {
        RateOfFire = {Mult = -0.10},
    },
    Icon = '/dgtorchbearer/NewTorchBearRainofIce01',
}
BuffBlueprint {
    Name = 'HEMA01RainSlowFx01',
    BuffType = 'SLOWUNITFX',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 3,
    Affects = {
        Dummy = {},
    },
    Effects = 'Slow01',
    EffectsBone = -2,
}

#################################################################################################################
# Rain of Ice II
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01RainIce02',
    DisplayName = '<LOC ABILITY_HEMA01_0053>Rain of Ice II',
    Description = '<LOC ABILITY_HEMA01_0052>A maelstrom of hail and sleet pelts the target area dealing [GetDamageAmt] damage and slowing Attack Speed by [GetAttackSlow]% for [GetDuration] seconds.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 700,
    RangeMax = 20,
    Cooldown = 14,
    DamageAmt = 400,
    AffectRadius = 10,
    NumFireBalls = 5,
    NumWaves = 1,
    UISlot = 2,
    HotKey = '2',
    Buff1 = 'HEMA01RainSlow02',
    Buff2 = 'HEMA01FreezeSlowFx02',
    CastAction = 'CastFreeze',
    CastingTime = 0.1,
    FollowThroughTime = 0.9,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetAttackSlow = function(self) return math.floor( Buffs['HEMA01RainSlow02'].Affects.RateOfFire.Mult * 100  ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01RainSlow02'].Duration  ) end,
    AbilityCategory = 'HEMA01ICE',
    OnStartAbility = function(self, unit, params)
        ForkThread(CallRain, self, unit, params, '/projectiles/HailBall01/HailBall01_proj.bp' )
    end,
    Icon = '/dgtorchbearer/NewTorchBearRainofIce01',
    Reticule = 'AoE_Ice',
}

BuffBlueprint {
    Name = 'HEMA01RainSlow02',
    DisplayName = '<LOC ABILITY_HEMA01_0053>Rain of Ice II',
    Description = '<LOC ABILITY_HEMA01_0091>Attack Speed reduced.',
    BuffType = 'SLOWUNITRAIN',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'MOBILE',
    Stacks = 'REPLACE',
    Duration = 5,
    Affects = {
        RateOfFire = {Mult = -0.20},
    },
    Icon = '/dgtorchbearer/NewTorchBearRainofIce01',
}
BuffBlueprint {
    Name = 'HEMA01RainSlowFx02',
    BuffType = 'SLOWUNITFX',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Affects = {
        Dummy = {},
    },
    Effects = 'Slow01',
    EffectsBone = -2,
}

#################################################################################################################
# Rain of Ice III
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01RainIce03',
    DisplayName = '<LOC ABILITY_HEMA01_0055>Rain of Ice III',
    Description = '<LOC ABILITY_HEMA01_0052>A maelstrom of hail and sleet pelts the target area dealing [GetDamageAmt] damage and slowing Attack Speed by [GetAttackSlow]% for [GetDuration] seconds.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 900,
    RangeMax = 20,
    Cooldown = 14,
    DamageAmt = 600,
    AffectRadius = 10,
    NumFireBalls = 5,
    NumWaves = 1,
    UISlot = 2,
    HotKey = '2',
    Buff1 = 'HEMA01RainSlow03',
    Buff2 = 'HEMA01FreezeSlowFx03',
    CastAction = 'CastFreeze',
    CastingTime = 0.1,
    FollowThroughTime = 0.9,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetAttackSlow = function(self) return math.floor( Buffs['HEMA01RainSlow03'].Affects.RateOfFire.Mult * 100 + 1 ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01RainSlow03'].Duration  ) end,
    AbilityCategory = 'HEMA01ICE',
    OnStartAbility = function(self, unit, params)
        ForkThread(CallRain, self, unit, params, '/projectiles/HailBall01/HailBall01_proj.bp' )
    end,
    Icon = '/dgtorchbearer/NewTorchBearRainofIce01',
    Reticule = 'AoE_Ice',
}

BuffBlueprint {
    Name = 'HEMA01RainSlow03',
    DisplayName = '<LOC ABILITY_HEMA01_0055>Rain of Ice III',
    Description = '<LOC ABILITY_HEMA01_0092>Attack Speed reduced.',
    BuffType = 'SLOWUNITRAIN',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'MOBILE',
    Stacks = 'REPLACE',
    Duration = 7,
    Affects = {
        RateOfFire = {Mult = -0.30},
    },
    Icon = '/dgtorchbearer/NewTorchBearRainofIce01',
}
BuffBlueprint {
    Name = 'HEMA01RainSlowFx03',
    BuffType = 'SLOWUNITFX',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 7,
    Affects = {
        Dummy = {},
    },
    Effects = 'Slow01',
    EffectsBone = -2,
}

#################################################################################################################
# Rain of Ice IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01RainIce04',
    DisplayName = '<LOC ABILITY_HEMA01_0073>Rain of Ice IV',
    Description = '<LOC ABILITY_HEMA01_0052>A maelstrom of hail and sleet pelts the target area dealing [GetDamageAmt] damage and slowing Attack Speed by [GetAttackSlow]% for [GetDuration] seconds.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 1100,
    RangeMax = 20,
    Cooldown = 14,
    DamageAmt = 800,
    AffectRadius = 10,
    NumFireBalls = 5,
    NumWaves = 1,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'CastFreeze',
    CastingTime = 0.1,
    FollowThroughTime = 0.9,
    Buff1 = 'HEMA01RainSlow04',
    Buff2 = 'HEMA01FreezeSlowFx04',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetAttackSlow = function(self) return math.floor( Buffs['HEMA01RainSlow04'].Affects.RateOfFire.Mult * 100  ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01RainSlow04'].Duration  ) end,
    AbilityCategory = 'HEMA01ICE',
    OnStartAbility = function(self, unit, params)
        ForkThread(CallRain, self, unit, params, '/projectiles/HailBall01/HailBall01_proj.bp' )
    end,
    Icon = '/dgtorchbearer/NewTorchBearRainofIce01',
    Reticule = 'AoE_Ice',
}

BuffBlueprint {
    Name = 'HEMA01RainSlow04',
    DisplayName = '<LOC ABILITY_HEMA01_0073>Rain of Ice IV',
    Description = '<LOC ABILITY_HEMA01_0093>Attack Speed reduced.',
    BuffType = 'SLOWUNITRAIN',
    Debuff = true,
    CanBeDispelled = true,
    EntityCategory = 'MOBILE',
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {
        RateOfFire = {Mult = -0.40},
    },
    Icon = '/dgtorchbearer/NewTorchBearRainofIce01',
}
BuffBlueprint {
    Name = 'HEMA01RainSlowFx04',
    BuffType = 'SLOWUNITFX',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {
        Dummy = {},
    },
    Effects = 'Slow01',
    EffectsBone = -2,
}

#################################################################################################################
# Cold Clarity
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01Clarity',
    DisplayName = '<LOC ABILITY_HEMA01_0083>Biting Chill',
    Description = '<LOC ABILITY_HEMA01_0084>Torch Bearer\'s chill cuts to the bone. Enemies affected by Rain of Ice have their Health Per Second and Mana Per Second reduced by [GetReduction]% for [GetDuration] seconds.\n\nThis effect can be consumed by Deep Freeze for additional damage.',
    GetChance = function(self) return math.floor( self.WeaponProcChance ) end,
    GetReduction = function(self) return math.floor( (Buffs['HEMA01ClarityBuff'].Affects.Regen.Mult) * -100) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01ClarityBuff'].Duration ) end,
    AbilityType = 'Quiet',
    Icon = '/dgtorchbearer/NewTorchBearColdClarity01',
}

#################################################################################################################
# Cold Clarity Buff
#################################################################################################################
BuffBlueprint {
    Name = 'HEMA01ClarityBuff',
    DisplayName = '<LOC ABILITY_HEMA01_0083>Biting Chill',
    Description = '<LOC ABILITY_HEMA01_0086>Health Per Second and Mana Per Second Reduced.',
    Stacks = 'REPLACE',
    BuffType = 'HEMA01SOULCHILL',
    Debuff = true,
    CanBeDispelled = true,
    Duration = 10,
    Icon = '/dgtorchbearer/NewTorchBearColdClarity01',
    Affects = {
        Regen = { Mult = -.75 },
        EnergyRegen = { Mult = -.75 },
    },
}

#################################################################################################################
# Epic Deaths
#################################################################################################################
function FrostTendrils( projEnt, pos, num_projectiles, i )
    local horizontal_angle = (2*math.pi) / num_projectiles
    local angleInitial = GetRandomFloat( 0, horizontal_angle )
    local xVec, yVec, zVec
    local angleVariation = 0.5
    local px, py, pz

    xVec = math.sin(angleInitial + (i*horizontal_angle) + GetRandomFloat(-angleVariation, angleVariation) )
    yVec = GetRandomFloat( 0.5, 2.0 )
    zVec = math.cos(angleInitial + (i*horizontal_angle) + GetRandomFloat(-angleVariation, angleVariation) )
    px = GetRandomFloat( 1.0, 3.0 ) * xVec
    py = GetRandomFloat( 0.5, 1.5 ) * yVec
    pz = GetRandomFloat( 1.0, 3.0 ) * zVec

    local proj = projEnt:CreateProjectile( '/projectiles/FrostDeathEffect01/FrostDeathEffect01_proj.bp', px, py, pz, xVec, yVec, zVec )
    local velocity = GetRandomFloat( 15, 30 )
    proj:SetVelocity( velocity )
    proj:SetBallisticAcceleration( -velocity * 1.0 )
    proj:SetLifetime( velocity * 0.025 )
end

TorchBearerDeath = function( unit, abil )
    local army = unit:GetArmy()

    if unit.Character.CharBP.Name == 'Mage' then
        # Icemode death sequence
        local pos = table.copy(unit:GetPosition())
        pos[2] = 100

        # Frost buildup
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'EpicFrostDeath02', army, pos )

        # Staff effect going out when it hits the ground
        WaitSeconds(1.2)
        AttachEffectsAtBone( unit, EffectTemplates.TorchBearer.EpicFrostDeath01, 'sk_TorchBearer_Staff_Muzzle_REF' )
        unit:DestroyAmbientEffects()

        # Fake ice decal on ground
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'EpicFrostDeath04', army, pos )

        # Create ice block at feet
        WaitSeconds(0.5)
        local orient = unit:GetOrientation()
        local IceBlockEffect = CreateUnit( 'FrozenTorchBearer01', unit:GetArmy(), pos[1], pos[2], pos[3], orient[1], orient[2], orient[3], orient[4])
        unit.TrashOnKilled:Add(IceBlockEffect)

        # Set mesh to frozen shader
        WaitSeconds(1.0)
        unit:AddEffectMeshState( 'Frozen', string.lower(unit.Character.CharBP.Meshes.Frozen), true, true )

        # Apply slow to all enemy entities nearby
        local entities = GetEntitiesInSphere("UNITS", pos, abil.AffectRadius)
        for k,entity in entities do
            if IsEnemy(army,entity:GetArmy()) and not entity:IsDead() and not EntityCategoryContains(categories.NOBUFFS, entity) and not EntityCategoryContains(categories.UNTARGETABLE, entity) then
                Buff.ApplyBuff(entity, abil.FrostDeathDebuff, entity)
            end
        end

        # Frost projectiles
        WaitSeconds(0.5)
        local FrostEffects = {}
        local projEnt = Entity{ Owner = army }
        Warp(projEnt, pos)
        for i = 1,5 do
            ForkThread(FrostTendrils, projEnt, pos, 5, i )
        end

        # Main explosion effects
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'EpicFrostDeath03', army, pos, nil )
        projEnt:Destroy()
    else

        # Fire mode death sequence
        AttachEffectsAtBone( unit, EffectTemplates.TorchBearer.EpicFireDeath01, -2 )
        WaitSeconds(3.0)

        #local pos = table.copy(unit:GetPosition(0))
        local pos = table.copy(unit:GetPosition())
        pos[2] = 100
        CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'EpicFireDeath04', army, pos, nil )
        #CreateLightParticleIntel( unit, 0, army, 30, 4, 'glow/gl_0002_44', 'ramp/ra_0096_peach' )

        local angle = (2*math.pi) / 12
        for i = 1, 12 do
            local s = math.sin(i*angle)
            local c = math.cos(i*angle)
            local x = s * 1
            local z = c * 1

            CreateTemplatedEffectAtPos( 'TorchBearer', nil, 'EpicFireDeath03', army, Vector(pos[1] + x,pos[2],pos[3]+z), Vector(x, 0, z) )
        end

        # Do fire damage
        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = army,
            Origin = unit:GetPosition(),
            Type = abil.DamageType,
            DamageAction = abil.Name,
            Amount = abil.DamageAmt,
            Radius = abil.AffectRadius,
            DamageFriendly = false,
            DamageSelf = false,
            Group = "UNITS",
            CanBeEvaded = false,
            CanCrit = false,
            CanBackfire = false,
            CanDamageReturn = false,
            CanMagicResist = true,
            ArmorImmune = true,
            NoFloatText = false,
        }
        DamageArea(data)
    end
end

BuffBlueprint {
    Name = 'HEMA01FrostDeathSlow01',
    Debuff = true,
    CanBeDispelled = true,
    DisplayName = '<LOC ABILITY_HEMA01_0057>Tomb of Ice',
    Description = '<LOC ABILITY_HEMA01_0058>Movement Speed reduced.',
    BuffType = 'TFROSTSLOW',
    Stacks = 'REPLACE',
    Duration = 6,
    Affects = {
        MoveMult = {Mult = -0.25},
    },
    Effects = 'Slow01',
    EffectsBone = -2,
    Icon = '/dgtorchbearer/NewTorchBearFrostAura01',
}

#################################################################################################################
# Epic Death - Ice - Ability
#################################################################################################################
AbilityBlueprint {
    Name = 'HEMA01Death01',
    DisplayName = 'Death',
    Description = 'Torchbearer death functional ability',
    AbilityType = 'Quiet',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    NoCastAnim = true,
    AffectRadius = 10,
    DamageAmt = 200,
    DamageType = 'SpellFire',
    FrostDeathDebuff = 'HEMA01FrostDeathSlow01',
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnKilled:Add(self.Death, self)
    end,
    Death = function(self, unit)
        unit:ForkThread(TorchBearerDeath, self)
    end,
}

#################################################################################################################
# Icons / Key Mappings / Descriptions
#################################################################################################################
AbilityBlueprint {
    Name = 'HTorchFrostNovaGrey01',
    DisplayName = '<LOC ABILITY_HEMA01_0045>Frost Nova I',
    Description = '<LOC ABILITY_HEMA01_0046>Releases a wave of frost, freezing all enemies around the Torch Bearer, stunning them for [GetStun] seconds. Demigods are stunned for [GetDemigodStun] seconds.\n\nAll units have [GetMovementSlow]% Movement Speed for [GetDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 1,
    HotKey = '1',
    NoCastAnim = true,
    AbilityCategory = 'HEMA01ICE',
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HEMA01FrostNova01'].RangeMax end,
    GetStun = function(self) return math.floor( Buffs['HEMA01FrostNova01'].Duration ) end,
    GetDemigodStun = function(self) return math.floor( Buffs['HEMA01FrostNova01Hero'].Duration  ) end,
    GetMovementSlow = function(self) return math.floor( Buffs['HEMA01NovaSlow01'].Affects.MoveMult.Mult * 100  ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01NovaSlow01'].Duration  ) end,
    GetEnergyCost = function(self) return Ability['HEMA01FrostNova01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEMA01FrostNova01'].CastingTime end,
    GetCooldown = function(self) return Ability['HEMA01FrostNova01'].Cooldown end,
    Icon = '/dgtorchbearer/NewTorchBearFrostNova01',
}

AbilityBlueprint {
    Name = 'HTorchRainIceGrey01',
    DisplayName = '<LOC ABILITY_HEMA01_0051>Rain of Ice I',
    Description = '<LOC ABILITY_HEMA01_0052>A maelstrom of hail and sleet pelts the target area dealing [GetDamageAmt] damage and slowing Attack Speed by [GetAttackSlow]% for [GetDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    AbilityCategory = 'HEMA01ICE',
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HEMA01RainIce01'].RangeMax end,
    GetDamageAmt = function(self) return math.floor( Ability['HEMA01RainIce01'].DamageAmt ) end,
    GetAttackSlow = function(self) return math.floor( Buffs['HEMA01RainSlow01'].Affects.RateOfFire.Mult * 100  ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01RainSlow01'].Duration  ) end,
    GetEnergyCost = function(self) return Ability['HEMA01RainIce01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEMA01RainIce01'].CastingTime end,
    GetCooldown = function(self) return Ability['HEMA01RainIce01'].Cooldown end,
    Icon = '/dgtorchbearer/NewTorchBearRainofIce01',
}

AbilityBlueprint {
    Name = 'HTorchFreezeGrey01',
    DisplayName = '<LOC ABILITY_HEMA01_0037>Deep Freeze I',
    Description = '<LOC ABILITY_HEMA01_0038>Torch Bearer blasts a target with intense cold. Interrupts abilities and increases target\'s cooldown time by [GetCooldownBuff]%. Lasts for [GetDuration] seconds.\n\nIf the target is affected by Frost Nova or Rain of Ice, Deep Freeze consumes each effect and deals [GetDamage] damage for each effect.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    AbilityCategory = 'HEMA01ICE',
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HEMA01FreezeSlow01'].RangeMax end,
    GetCooldownBuff = function(self) return math.floor( (Buffs['HEMA01FreezeSlow01'].Affects.Cooldown.Mult ) * 100 ) end,
    GetDuration = function(self) return math.floor( Buffs['HEMA01FreezeSlow01'].Duration  ) end,
    GetEnergyCost = function(self) return Ability['HEMA01FreezeStructure01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEMA01FreezeStructure01'].CastingTime end,
    GetCooldown = function(self) return Ability['HEMA01FreezeStructure01'].Cooldown end,
    GetDamage = function(self) return Ability['HEMA01FreezeStructure01'].DamagePerBuff end,
    Icon = '/dgtorchbearer/NewTorchBearFreezeStructure01',
}

AbilityBlueprint {
    Name = 'HTorchFireBallGrey01',
    DisplayName = '<LOC ABILITY_HEMA01_0014>Fireball I',
    Description = '<LOC ABILITY_HEMA01_0015>Hurls a fiery ball at a target dealing [GetDamageAmt] damage.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    AbilityCategory = 'HEMA01FIRE',
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HEMA01Fireball01'].RangeMax end,
    GetDamageAmt = function(self) return math.floor( Ability['HEMA01Fireball01'].DamageAmt ) end,
    GetEnergyCost = function(self) return Ability['HEMA01Fireball01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEMA01Fireball01'].CastingTime end,
    GetCooldown = function(self) return Ability['HEMA01Fireball01'].Cooldown end,
    Icon = '/dgtorchbearer/NewTorchBearFireball01',
}

AbilityBlueprint {
    Name = 'HTorchFireNovaGrey01',
    DisplayName = '<LOC ABILITY_HEMA01_0020>Fire Nova I',
    Description = '<LOC ABILITY_HEMA01_0021>A wave a fire radiates outward from the Torch Bearer, dealing [GetDamageAmt] damage and throwing smaller units into the air.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 1,
    HotKey = '1',
    NoCastAnim = true,
    AbilityCategory = 'HEMA01FIRE',
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HEMA01FireNova01'].RangeMax end,
    GetDamageAmt = function(self) return math.floor( Ability['HEMA01FireNova01'].DamageAmt ) end,
    GetEnergyCost = function(self) return Ability['HEMA01FireNova01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEMA01FireNova01'].CastingTime end,
    GetCooldown = function(self) return Ability['HEMA01FireNova01'].Cooldown end,
    Icon = '/dgtorchbearer/NewTorchBearFireNova01',
}

AbilityBlueprint {
    Name = 'HTorchFireRingGrey01',
    DisplayName = '<LOC ABILITY_HEMA01_0024>Circle of Fire I',
    Description = '<LOC ABILITY_HEMA01_0025>Torch Bearer conjures a circle of fire around him, burning anything that stands in it for [GetDamageAmt] damage over [GetDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    AbilityCategory = 'HEMA01FIRE',
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HEMA01RingOfFire01'].RangeMax end,
    GetDamageAmt = function(self) return math.floor( Ability['HEMA01RingOfFire01'].DamageAmt * Ability['HEMA01RingOfFire01'].Duration ) end,
    GetDuration = function(self) return math.floor( Ability['HEMA01RingOfFire01'].Duration ) end,
    GetEnergyCost = function(self) return Ability['HEMA01RingOfFire01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HEMA01RingOfFire01'].CastingTime end,
    GetCooldown = function(self) return Ability['HEMA01RingOfFire01'].Cooldown end,
    Icon = '/dgtorchbearer/NewTorchBearRingofFire01',
}

__moduleinfo.auto_reload = true
