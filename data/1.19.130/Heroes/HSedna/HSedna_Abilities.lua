local Buff = import('/lua/sim/buff.lua')
local Abil = import('/lua/sim/ability.lua')
local Validate = import('/lua/common/ValidateAbility.lua')
local GetRandomFloat = import('/lua/utilities.lua').GetRandomFloat

function FxHealingWind01( unit, trash )
    local fx = AttachCharacterEffectsAtBone( unit, 'leopard_rider', 'HealingWind01', -2, trash )
    for k, vEffect in fx do
        unit.TrashOnKilled:Add(vEffect)
    end
end

function FxHealingWind02( unit, trash )
    local fx = AttachCharacterEffectsAtBone( unit, 'leopard_rider', 'HealingWind02', -2, trash )
    for k, vEffect in fx do
        unit.TrashOnKilled:Add(vEffect)
    end
end

#################################################################################################################
# VFX
# Pounce
#################################################################################################################
function FxPounce( unit, target )
    # Arc from cats claws
    AttachEffectAtBone( unit, 'Sedna', 'Pounce01', -2 )

    # Blood on impact
    CreateTemplatedEffectAtPos( 'Sedna', nil, 'Pounce02', unit:GetArmy(), target:GetPosition(), ForwardVector(unit:GetOrientation()) )
end

#################################################################################################################
# CE
# Pounce
#################################################################################################################
function Pounce(def, unit, params)
    if(unit and not unit:IsDead()) then
        # Damage Target
        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Amount = def.DamageAmt,
            Type = 'Spell',
            DamageAction = def.Name,
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
        DealDamage(data, params.Targets[1])
        Buff.ApplyBuff(params.Targets[1], 'HSednaPounceDebuff', unit)

        # Pounce effects
        unit:ForkThread(FxPounce, params.Targets[1])
    end
end

#################################################################################################################
# Pounce I
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaPounce01',
    DisplayName = '<LOC ABILITY_Sedna_0000>Pounce I',
    Description = '<LOC ABILITY_Sedna_0001>Sedna commands her cat to pounce on an enemy, interrupting them and dealing [GetDamageAmt] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 400,
    Cooldown = 7,
    RangeMax = 9,
    DamageAmt = 400,
    DamageType = 'Spell',
    UISlot = 1,
    HotKey = '1',
    CastingTime = 0.3,
    FollowThroughTime = 1.2,
    CastAction = 'Pounce',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    OnStartAbility = function(self, unit, params)
        Pounce(self, unit, params)
    end,
    Icon = '/DGSedna/NewSednaPounce01',
}

#################################################################################################################
# Pounce II
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaPounce02',
    DisplayName = '<LOC ABILITY_Sedna_0002>Pounce II',
    Description = '<LOC ABILITY_Sedna_0001>Sedna commands her cat to pounce on an enemy, interrupting them and dealing [GetDamageAmt] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 525,
    Cooldown = 7,
    RangeMax = 9,
    DamageAmt = 600,
    DamageType = 'Spell',
    UISlot = 1,
    HotKey = '1',
    CastingTime = 0.3,
    FollowThroughTime = 1.2,
    CastAction = 'Pounce',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    OnStartAbility = function(self, unit, params)
        Pounce(self, unit, params)
    end,
    Icon = '/DGSedna/NewSednaPounce01',
}

#################################################################################################################
# Pounce III
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaPounce03',
    DisplayName = '<LOC ABILITY_Sedna_0004>Pounce III',
    Description = '<LOC ABILITY_Sedna_0001>Sedna commands her cat to pounce on an enemy, interrupting them and dealing [GetDamageAmt] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 650,
    Cooldown = 7,
    RangeMax = 9,
    DamageAmt = 800,
    DamageType = 'Spell',
    UISlot = 1,
    HotKey = '1',
    CastingTime = 0.3,
    FollowThroughTime = 1.2,
    CastAction = 'Pounce',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    OnStartAbility = function(self, unit, params)
        Pounce(self, unit, params)
    end,
    Icon = '/DGSedna/NewSednaPounce01',
}

#################################################################################################################
# Pounce IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaPounce04',
    DisplayName = '<LOC ABILITY_Sedna_0073>Pounce IV',
    Description = '<LOC ABILITY_Sedna_0001>Sedna commands her cat to pounce on an enemy, interrupting them and dealing [GetDamageAmt] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'HOSTILETARGETED',
    EnergyCost = 775,
    Cooldown = 7,
    RangeMax = 9,
    DamageAmt = 1000,
    DamageType = 'Spell',
    UISlot = 1,
    HotKey = '1',
    CastingTime = 0.3,
    FollowThroughTime = 1.2,
    CastAction = 'Pounce',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    OnStartAbility = function(self, unit, params)
        Pounce(self, unit, params)
        if Validate.HasAbility(unit, 'HSednaInspiringRoar') then
            unit:GetAIBrain():AddArmyBonus( 'HSednaInspiringRoar', self )
        end
    end,
    Icon = '/DGSedna/NewSednaPounce01',
}
#################################################################################################################
# Pounce I-IV: Interrupt
#################################################################################################################
BuffBlueprint {
    Name = 'HSednaPounceDebuff',
    BuffType = 'HSEDNAPOUNCEDEBUFF',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 0.1,
    NoFloatText = true,
    Affects = {
        Interrupt = {Add = 0},
    },
}

#################################################################################################################
# Inspiring Roar
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaInspiringRoar',
    DisplayName = '<LOC ABILITY_HSEDNA_0000>Inspiring Roar',
    Description = '<LOC ABILITY_HSEDNA_0001>When Sedna uses Pounce, her army\'s Movement Speed is increased by [GetMoveIncrease]% and their Evasion is increased by [GetEvasionIncrease]% for [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetMoveIncrease = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * 100 ) end,
    GetEvasionIncrease = function(self) return ( Buffs[self.Name].Affects.Evasion.Add ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
}

ArmyBonusBlueprint {
    Name = 'HSednaInspiringRoar',
    DisplayName = '<LOC ABILITY_HSEDNA_0002>Inspiring Roar',
    Description = '<LOC ABILITY_HSEDNA_0003>Movement Speed and Evasion increased.',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaInspiringRoar',
            DisplayName = '<LOC ABILITY_HSEDNA_0004>Inspiring Roar',
            Description = '<LOC ABILITY_HSEDNA_0005>Movement Speed and Evasion increased.',
            BuffType = 'HSEDNAINSPIRINGROAR',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 5,
            Icon = '/DGSedna/NewSednaInspiringRoar01',
            Affects = {
                Evasion = {Add = 15},
                MoveMult = {Mult = 0.15},
            },
        }
    }
}

#################################################################################################################
# VFX
# Heal
#################################################################################################################
function FxYeti01( unit )
    # Casting effects on hands
    AttachEffectsAtBone( unit, EffectTemplates.Sedna.CastYeti01, 'sk_Leopard_Rider_Sedna_Weapon_Grip_Left' )
    AttachEffectsAtBone( unit, EffectTemplates.Sedna.CastYeti01, 'sk_Leopard_Rider_Sedna_Weapon_Grip_Right' )

    # Glow at base of Sedna
    AttachEffectsAtBone( unit, EffectTemplates.Sedna.CastYeti02, -2 )
end

#################################################################################################################
# CE: Count Yeti
#################################################################################################################
function CountYeti(MaxYeti, yeti)

    # Get the tracking table for shamblers, or create it if it's new
    local aiBrain = yeti:GetAIBrain()
    local sedna = aiBrain.AbilityData
    if not sedna.YetiList then
        sedna.YetiList = {}
    end

    # Add this shambler to the queen's tracking table
    sedna.Counter = (sedna.Counter or 0) + 1
    sedna.YetiList[sedna.Counter] = yeti

    # Clean out dead shamblers from the list
    for k, v in sedna.YetiList do
        if v:IsDead() then
            sedna.YetiList[k] = nil
        end
    end

    # If we're at the max number of shamblers, destroy the oldest one
    if table.getsize(sedna.YetiList) > MaxYeti then
        local key = table.keys(sedna.YetiList)[1]
        if not sedna.YetiList[key].KillData then
            sedna.YetiList[key].KillData = {}
        end
        sedna.YetiList[key]:Kill()
        sedna.YetiList[key] = nil
    end
end

#################################################################################################################
# CE
# Horn of the Yeti
#################################################################################################################
function HornoftheYeti(unit, def, params)
    local numYetis = def.NumYetis

    unit:OccupyGround(true)
    local nearbyUnits = unit:GetAIBrain():GetUnitsAroundPoint( categories.MOBILE, unit.Position, 10 )
    for k,v in nearbyUnits do
        v:OccupyGround(true)
    end
    
    local newUnits = {}
    local orient = unit:GetOrientation()
    for x = 1, numYetis do
        local loc = unit:FindEmptySpotNear(unit.Position)
        if not loc then
            loc = unit:GetPosition()
        end
        local yeti = CreateUnitHPR( "HSednaYeti", unit:GetArmy(), loc[1], loc[2], loc[3], orient[1], orient[2], orient[3] )
        IssueGuard({yeti}, unit)
        yeti:OccupyGround(true)
        table.insert(newUnits, yeti)
        if def.YetiBuff then
            Buff.ApplyBuff(yeti, def.YetiBuff, unit)
        end
        CountYeti(def.MaxYeti, yeti)

        #WaitSeconds (GetRandomFloat( 0.0, 0.2 ))
    end
    
    unit:OccupyGround(false)
    for k,v in nearbyUnits do
        v:OccupyGround(false)
    end
    for k,v in newUnits do
        v:OccupyGround(false)
    end
end

#################################################################################################################
# Horn of the Yeti I
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaYeti01',
    DisplayName = '<LOC ABILITY_Sedna_0006>Horn of the Yeti I',
    Description = '<LOC ABILITY_Sedna_0007>Sedna summons a Yeti to defend her. She may have [GetMaxYeti] Yeti active.',
    AbilityType = 'Instant',
    EnergyCost = 550,
    Cooldown = 7,
    NumYetis = 1,
    UISlot = 2,
    HotKey = '2',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    MaxYeti = 2,
    CastAction = 'Summon',
    GetMaxYeti = function(self) return math.floor( self.MaxYeti ) end,
    OnStartAbility = function(self, unit, params)
        unit:ForkThread(HornoftheYeti, self, params)

        # Create spell effects
        FxYeti01( unit)
    end,
    Icon = '/DGSedna/NewSednaYeti01',
}

#################################################################################################################
# Horn of the Yeti II
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaYeti02',
    DisplayName = '<LOC ABILITY_Sedna_0008>Horn of the Yeti II',
    Description = '<LOC ABILITY_Sedna_0009>Sedna summons [GetNumYetis] Yetis to defend her. Yetis are more powerful than Horn of the Yeti I. She may have [GetMaxYeti] Yeti active.',
    AbilityType = 'Instant',
    EnergyCost = 750,
    Cooldown = 7,
    NumYetis = 2,
    YetiBuff = 'HSednaYetiBuff02',
    UISlot = 2,
    HotKey = '2',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    MaxYeti = 2,
    CastAction = 'Summon',
    GetNumYetis = function(self) return math.floor( self.NumYetis ) end,
    GetMaxYeti = function(self) return math.floor( self.MaxYeti ) end,
    OnStartAbility = function(self, unit, params)
        unit:ForkThread(HornoftheYeti, self, params)

        # Create spell effects
        FxYeti01( unit)
    end,
    Icon = '/DGSedna/NewSednaYeti01',
}

#################################################################################################################
# Horn of the Yeti II: Yeti Buff
#################################################################################################################
BuffBlueprint {
    Name = 'HSednaYetiBuff02',
    BuffType = 'HSEDNAYETIBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    NoFloatText = true,
    IgnoreDamageRangePercent = true,
    CanCrit = false,
    Affects = {
        DamageRating = {Add = 7},
        MaxHealth = {Add = 300, AdjustHealth = true},
    },
}

#################################################################################################################
# Horn of the Yeti III
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaYeti03',
    DisplayName = '<LOC ABILITY_Sedna_0010>Horn of the Yeti III',
    Description = '<LOC ABILITY_Sedna_0011>Sedna summons [GetNumYetis] mighty Yeti to defend her. Yetis are more powerful than Horn of the Yeti II. She may have [GetMaxYeti] Yeti active.',
    AbilityType = 'Instant',
    EnergyCost = 950,
    Cooldown = 7,
    NumYetis = 2,
    YetiBuff = 'HSednaYetiBuff03',
    UISlot = 2,
    HotKey = '2',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    MaxYeti = 4,
    CastAction = 'Summon',
    GetNumYetis = function(self) return math.floor( self.NumYetis ) end,
    GetMaxYeti = function(self) return math.floor( self.MaxYeti ) end,
    OnStartAbility = function(self, unit, params)
        unit:ForkThread(HornoftheYeti, self, params)

        # Create spell effects
        FxYeti01( unit)
    end,
    Icon = '/DGSedna/NewSednaYeti01',
}

#################################################################################################################
# Horn of the Yeti III: Yeti Buff
#################################################################################################################
BuffBlueprint {
    Name = 'HSednaYetiBuff03',
    BuffType = 'HSEDNAYETIBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    NoFloatText = true,
    IgnoreDamageRangePercent = true,
    CanCrit = false,
    Affects = {
        DamageRating = {Add = 14},
        MaxHealth = {Add = 600, AdjustHealth = true},
    },
}

#################################################################################################################
# Horn of the Yeti IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaYeti04',
    DisplayName = '<LOC ABILITY_Sedna_0074>Horn of the Yeti IV',
    Description = '<LOC ABILITY_Sedna_0075>Sedna summons [GetNumYetis] mighty Yeti to defend her. Yetis are more powerful than Horn of the Yeti III. She may have [GetMaxYeti] Yeti active.',
    AbilityType = 'Instant',
    EnergyCost = 1150,
    Cooldown = 7,
    NumYetis = 4,
    YetiBuff = 'HSednaYetiBuff03',
    UISlot = 2,
    HotKey = '2',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    MaxYeti = 4,
    CastAction = 'Summon',
    GetNumYetis = function(self) return math.floor( self.NumYetis ) end,
    GetMaxYeti = function(self) return math.floor( self.MaxYeti ) end,
    OnStartAbility = function(self, unit, params)
        unit:ForkThread(HornoftheYeti, self, params)

        # Create spell effects
        FxYeti01( unit)
    end,
    Icon = '/DGSedna/NewSednaYeti01',
}

#################################################################################################################
# Horn of the Yeti IV: Yeti Buff
#################################################################################################################
BuffBlueprint {
    Name = 'HSednaYetiBuff04',
    BuffType = 'HSEDNAYETIBUFF',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    NoFloatText = true,
    IgnoreDamageRangePercent = true,
    CanCrit = false,
    Affects = {
        DamageRating = {Add = 21},
        MaxHealth = {Add = 900, AdjustHealth = true},
    },
}

#################################################################################################################
# Wild Swings
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaWildSwings',
    DisplayName = '<LOC ABILITY_HSEDNA_0006>Wild Swings',
    Description = '<LOC ABILITY_HSEDNA_0007>Sedna\'s Yetis strike with wide swings, damaging nearby enemies for [GetDamageMult]% damage.',
    AbilityType = 'Quiet',
    GetDamageMult = function(self) return math.floor( Buffs[self.Name].Affects.DamageSplash.Mult * 100 + 100 ) end,
    OnAbilityAdded = function(self, unit)
        unit:GetAIBrain():AddArmyBonus( 'HSednaWildSwings', self )
    end,
}

ArmyBonusBlueprint {
    Name = 'HSednaWildSwings',
    DisplayName = '<LOC ABILITY_HSEDNA_0008>Wild Swings',
    Description = '<LOC ABILITY_HSEDNA_0009>Sedna\'s Yetis strike with wide swings, damaging nearby enemies for [GetDamageMult]% damage.',
    ApplyArmies = 'Single',
    UnitCategory = 'YETI',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaWildSwings',
            DisplayName = '<LOC ABILITY_HSEDNA_0010>Wild Swings',
            Description = '<LOC ABILITY_HSEDNA_0011>Attacks deal damage to nearby enemies.',
            BuffType = 'HSEDNAWILDSWINGS',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = -1,
            Icon = '/DGSedna/NewSednaWildSwings01',
            Affects = {
                DamageRadius = {Add = 2},
                DamageSplash = {Mult = -0.25},
            },
        }
    }
}

#################################################################################################################
# VFX
# Heal
#################################################################################################################
function FxHeal01( unit, target )
    # Casting effects on hand
    AttachEffectsAtBone( unit, EffectTemplates.Sedna.CastHeal01, 'sk_Leopard_Rider_Sedna_Weapon_Grip_Left' )

    # Glow at base of Sedna
    AttachEffectsAtBone( unit, EffectTemplates.Sedna.CastHeal02, -2 )

    # Heal effects at targeted unit
    AttachBuffEffectAtBone( target, 'SednaHeal01', -2 );
end

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
    FxHeal01( unit, params.Targets[1] )
end

#################################################################################################################
# Heal I
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaHeal01',
    DisplayName = '<LOC ABILITY_Sedna_0012>Heal I',
    Description = '<LOC ABILITY_Sedna_0013>Sedna heals a friendly target for [GetHealAmt] Health.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    EnergyCost = 375,
    Cooldown = 7,
    RangeMax = 20,
    HealAmt = 600,
    DamageType = 'Spell',
    UISlot = 3,
    HotKey = '3',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    CastAction = 'Heal',
    GetHealAmt = function(self) return math.floor( self.HealAmt ) end,
    OnStartAbility = function(self, unit, params)
        Heal01(self, unit, params)
    end,
    Icon = '/DGSedna/NewSednaHeal01',
}

#################################################################################################################
# CE
# Heal II
#################################################################################################################
function Heal02(def, unit, params)
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
    FxHeal01( unit, params.Targets[1] )
end

#################################################################################################################
# Heal II
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaHeal02',
    DisplayName = '<LOC ABILITY_Sedna_0014>Heal II',
    Description = '<LOC ABILITY_Sedna_0013>Sedna heals a friendly target for [GetHealAmt] Health.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    EnergyCost = 500,
    Cooldown = 7,
    RangeMax = 20,
    HealAmt = 900,
    DamageType = 'Spell',
    UISlot = 3,
    HotKey = '3',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    CastAction = 'Heal',
    GetHealAmt = function(self) return math.floor( self.HealAmt ) end,
    OnStartAbility = function(self, unit, params)
        Heal02(self, unit, params)
    end,
    Icon = '/DGSedna/NewSednaHeal01',
}

#################################################################################################################
# CE
# Heal III
#################################################################################################################
function Heal03(def, unit, params)
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
    # Clear Debuffs
    Buff.RemoveBuffsByDebuff(params.Targets[1], true)

    # Create Sedna heal effects
    FxHeal01( unit, params.Targets[1] )
end

#################################################################################################################
# Heal III
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaHeal03',
    DisplayName = '<LOC ABILITY_Sedna_0016>Heal III',
    Description = '<LOC ABILITY_Sedna_0015>Sedna heals a friendly target for [GetHealAmt] Health and cleanses their negative effects.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    EnergyCost = 625,
    Cooldown = 7,
    RangeMax = 20,
    HealAmt = 1200,
    DebuffClear = false,
    DamageType = 'Spell',
    UISlot = 3,
    HotKey = '3',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    CastAction = 'Heal',
    GetHealAmt = function(self) return math.floor( self.HealAmt ) end,
    OnStartAbility = function(self, unit, params)
        Heal03(self, unit, params)
    end,
    Icon = '/DGSedna/NewSednaHeal01',
}

#################################################################################################################
# CE
# Heal IV
#################################################################################################################
function Heal04(def, unit, params)
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
    # Clear Debuffs
    Buff.RemoveBuffsByDebuff(params.Targets[1], true)
    # Damage Enemies
    data.Amount = def.DamageAmt
    data.Radius = def.DamageRadius
    data.DamageFriendly = false
    data.DamageSelf = false
    DamageArea(data)

    # Create Sedna heal effects
    FxHeal01( unit, params.Targets[1] )
end

#################################################################################################################
# Heal IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaHeal04',
    DisplayName = '<LOC ABILITY_Sedna_0076>Heal IV',
    Description = '<LOC ABILITY_Sedna_0017>Sedna heals a friendly target for [GetHealAmt] Health, cleanses their negative effects, and damages nearby enemies for [GetDamageAmt] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    EnergyCost = 750,
    Cooldown = 7,
    RangeMax = 20,
    HealAmt = 1500,
    DebuffClear = false,
    DamageAmt = 200,
    DamageRadius = 15,
    DamageType = 'Spell',
    UISlot = 3,
    HotKey = '3',
    CastingTime = 0.5,
    FollowThroughTime = 0.5,
    CastAction = 'Heal',
    GetHealAmt = function(self) return math.floor( self.HealAmt ) end,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    OnStartAbility = function(self, unit, params)
        Heal04(self, unit, params)
    end,
    Icon = '/DGSedna/NewSednaHeal01',
}

#################################################################################################################
# Life's Child
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaLifesChild',
    AbilityType = 'Aura',
    DisplayName = '<LOC ABILITY_HSEDNA_0012>Life\'s Child',
    Description = '<LOC ABILITY_HSEDNA_0013>The forces of life guard Sedna. Whenever she is under [GetTriggerPercent]% health, her Health Per Second increases by [GetHealthRegen].',
    GetTriggerPercent = function(self) return math.floor( self.HealthPercentTrigger * 100 ) end,
    GetHealthRegen = function(self) return math.floor( Buffs[self.Name].Affects.Regen.Add ) end,
    AffectRadius = 1,
    AuraPulseTime = 1,
    TargetAlliance = 'Ally',
    TargetCategory = 'HERO',
    HealthPercentTrigger = .30,
    Icon = '/DGSedna/NewSednaLifesChild01',
    OnAuraPulse = function(self, unit, params)
        if unit:GetHealth()/unit:GetMaxHealth() >= self.HealthPercentTrigger then
            if Buff.HasBuff(unit, 'HSednaLifesChild') then
                Buff.RemoveBuff(unit, 'HSednaLifesChild')
            end
        else
            Buff.ApplyBuff(unit, 'HSednaLifesChild', unit)
        end
    end,
}

BuffBlueprint {
    Name = 'HSednaLifesChild',
    DisplayName = '<LOC ABILITY_HSEDNA_0014>Life\'s Child',
    Description = '<LOC ABILITY_HSEDNA_0015>Health Per Second increased.',
    BuffType = 'HSEDNALIFECHILD',
    Debuff = false,
    Stacks = 'REPLACE',
    Affects = {
        Regen = {Add = 50},
    },
    Icon = '/DGSedna/NewSednaLifesChild01',
}

#################################################################################################################
# Inner Grace I
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaInnerGrace01',
    DisplayName = '<LOC ABILITY_Sedna_0018>Inner Grace I',
    Description = '<LOC ABILITY_Sedna_0057>Sedna focuses her divine grace.\n\n+[GetMoveBuff]% Movement Speed\n+[GetRegenBuff] Health Per Second',
    AbilityType = 'Quiet',
    GetRegenBuff = function(self) return math.floor( Buffs[self.Name].Affects.Regen.Add ) end,
    GetMoveBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaInnerGrace01',
            DisplayName = '<LOC ABILITY_Sedna_0065>Inner Grace I',
            Description = '<LOC ABILITY_Sedna_0066>+10% Movement Speed.\n+5 Health Per Second.',
            BuffType = 'HSEDNAINNERGRACE',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                Regen = {Add = 10},
                MoveMult = {Mult = 0.05},
            },
        },
    },
    OnStartAbility = function(self, unit, params)
        unit:AddEffectMeshState( 'InnerGrace', string.lower(unit.Character.CharBP.Meshes.InnerGrace), true, true )
    end,
    Icon = '/DGSedna/NewSednaInnerGrace01',
}

#################################################################################################################
# Inner Grace II
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaInnerGrace02',
    DisplayName = '<LOC ABILITY_Sedna_0019>Inner Grace II',
    Description = '<LOC ABILITY_Sedna_0057>Sedna focuses her divine grace.\n\n+[GetMoveBuff]% Movement Speed\n+[GetRegenBuff] Health Per Second',
    AbilityType = 'Quiet',
    GetRegenBuff = function(self) return math.floor( Buffs[self.Name].Affects.Regen.Add ) end,
    GetMoveBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaInnerGrace02',
            DisplayName = '<LOC ABILITY_Sedna_0067>Inner Grace II',
            Description = '<LOC ABILITY_Sedna_0068>+20% Movement Speed.\n+10 Health Per Second.',
            BuffType = 'HSEDNAINNERGRACE',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                Regen = {Add = 15},
                MoveMult = {Mult = 0.1},
            },
        },
    },
    Icon = '/DGSedna/NewSednaInnerGrace01',
}

#################################################################################################################
# Inner Grace III
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaInnerGrace03',
    DisplayName = '<LOC ABILITY_Sedna_0020>Inner Grace III',
    Description = '<LOC ABILITY_Sedna_0057>Sedna focuses her divine grace.\n\n+[GetMoveBuff]% Movement Speed\n+[GetRegenBuff] Health Per Second',
    AbilityType = 'Quiet',
    GetRegenBuff = function(self) return math.floor( Buffs[self.Name].Affects.Regen.Add ) end,
    GetMoveBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * 100 ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaInnerGrace03',
            DisplayName = '<LOC ABILITY_Sedna_0069>Inner Grace III',
            Description = '<LOC ABILITY_Sedna_0070>+30% Movement Speed.\n+15 Health Per Second.',
            BuffType = 'HSEDNAINNERGRACE',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                Regen = {Add = 20},
                MoveMult = {Mult = 0.15},
            },
        },
    },
    Icon = '/DGSedna/NewSednaInnerGrace01',
}

#################################################################################################################
# VFX - Magnificent Presence
#################################################################################################################

function FxPresenceAura01(unit, trash)
    local fx = AttachEffectAtBone( unit, 'Sedna', 'PresenceAura01', -2, trash )
    for k, vEffect in fx do
        unit.TrashOnKilled:Add(vEffect)
    end
end

#################################################################################################################
# Magnificent Presence I
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaMagnificentPresence01',
    DisplayName = '<LOC ABILITY_Sedna_0021>Magnificent Presence I',
    Description = '<LOC ABILITY_Sedna_0060>Sedna\'s presence inspires nearby allies. Ability cooldown time reduced by [GetCooldownBuff]%.\n\n+[GetMinionHealth] Minion Health\n+[GetMinionROF]% Minion Attack Speed',
    AbilityType = 'Aura',
    AffectRadius = 15,
    AuraPulseTime = 5,
    TargetAlliance = 'Ally',
    GetCooldownBuff = function(self) return math.floor( Buffs[self.Name].Affects.Cooldown.Mult * -100 ) end,
    GetMinionHealth = function(self) return math.floor( Buffs['HSednaMagnificentPresence01_Minion'].Affects.MaxHealth.Add ) end,
    GetMinionROF = function(self) return math.floor( Buffs['HSednaMagnificentPresence01_Minion'].Affects.RateOfFire.Mult * 100 ) end,
    TargetCategory = 'HERO - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaMagnificentPresence01',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Sedna_0022>Magnificent Presence',
            Description = '<LOC ABILITY_Sedna_0023>Ability cooldown time reduced.',
            BuffType = 'HSEDNAMAGNIFICENTPRESENCE',
            Stacks = 'REPLACE',
            Duration = 5,
            Icon = '/DGSedna/NewSednaMagnificentPresence01',
            DoNotPulseIcon = true,
            Affects = {
                Cooldown = {Mult = -0.07},
            },
        },
    },
    CreateAbilityAmbients = function( self, unit, trash )
        FxPresenceAura01( unit, trash )
    end,
    OnAbilityAdded = function(self, unit)
        unit:GetAIBrain():AddArmyBonus( 'HSednaMagnificentPresence01_Minion', self )
    end,
}

#################################################################################################################
# Army Bonus: Magnificent Presence I
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'HSednaMagnificentPresence01_Minion',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaMagnificentPresence01_Minion',
            BuffType = 'MAGPRESENCEMINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Affects = {
                RateOfFire = {Mult = 0.05},
                MaxHealth = {Add = 100, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Magnificent Presence II
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaMagnificentPresence02',
    DisplayName = '<LOC ABILITY_Sedna_0024>Magnificent Presence II',
    Description = '<LOC ABILITY_Sedna_0060>Sedna\'s presence inspires nearby allies. Ability cooldown time reduced by [GetCooldownBuff]%.\n\n+[GetMinionHealth] Minion Health\n+[GetMinionROF]% Minion Attack Speed',
    AbilityType = 'Aura',
    AffectRadius = 15,
    AuraPulseTime = 5,
    TargetAlliance = 'Ally',
    GetCooldownBuff = function(self) return math.floor( Buffs[self.Name].Affects.Cooldown.Mult * -100 ) end,
    GetMinionHealth = function(self) return math.floor( Buffs['HSednaMagnificentPresence02_Minion'].Affects.MaxHealth.Add ) end,
    GetMinionROF = function(self) return math.floor( Buffs['HSednaMagnificentPresence02_Minion'].Affects.RateOfFire.Mult * 100 ) end,
    TargetCategory = 'HERO - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaMagnificentPresence02',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Sedna_0022>Magnificent Presence',
            Description = '<LOC ABILITY_Sedna_0023>Ability cooldown time reduced.',
            BuffType = 'HSEDNAMAGNIFICENTPRESENCE',
            Stacks = 'REPLACE',
            Duration = 5,
            Icon = '/DGSedna/NewSednaMagnificentPresence01',
            DoNotPulseIcon = true,
            Affects = {
                Cooldown = {Mult = -0.12},
            },
        },
    },
    CreateAbilityAmbients = function( self, unit, trash )
        FxPresenceAura01( unit, trash )
    end,
    OnAbilityAdded = function(self, unit)
        unit:GetAIBrain():AddArmyBonus( 'HSednaMagnificentPresence02_Minion', self )
    end,
}

#################################################################################################################
# Army Bonus: Magnificent Presence II
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'HSednaMagnificentPresence02_Minion',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaMagnificentPresence02_Minion',
            BuffType = 'MAGPRESENCEMINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Affects = {
                RateOfFire = {Mult = 0.10},
                MaxHealth = {Add = 150, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Magnificent Presence III
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaMagnificentPresence03',
    DisplayName = '<LOC ABILITY_Sedna_0027>Magnificent Presence III',
    Description = '<LOC ABILITY_Sedna_0060>Sedna\'s presence inspires nearby allies. Ability cooldown time reduced by [GetCooldownBuff]%.\n\n+[GetMinionHealth] Minion Health\n+[GetMinionROF]% Minion Attack Speed',
    AbilityType = 'Aura',
    AffectRadius = 15,
    AuraPulseTime = 5,
    TargetAlliance = 'Ally',
    GetCooldownBuff = function(self) return math.floor( Buffs[self.Name].Affects.Cooldown.Mult * -100 ) end,
    GetMinionHealth = function(self) return math.floor( Buffs['HSednaMagnificentPresence03_Minion'].Affects.MaxHealth.Add ) end,
    GetMinionROF = function(self) return math.floor( Buffs['HSednaMagnificentPresence03_Minion'].Affects.RateOfFire.Mult * 100 ) end,
    TargetCategory = 'HERO - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaMagnificentPresence03',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Sedna_0022>Magnificent Presence',
            Description = '<LOC ABILITY_Sedna_0023>Ability cooldown time reduced.',
            BuffType = 'HSEDNAMAGNIFICENTPRESENCE',
            Stacks = 'REPLACE',
            Duration = 5,
            Icon = '/DGSedna/NewSednaMagnificentPresence01',
            DoNotPulseIcon = true,
            Affects = {
                Cooldown = {Mult = -0.17},
            },
        },
    },
    CreateAbilityAmbients = function( self, unit, trash )
        FxPresenceAura01( unit, trash )
    end,
    OnAbilityAdded = function(self, unit)
        unit:GetAIBrain():AddArmyBonus( 'HSednaMagnificentPresence03_Minion', self )
    end,
}

#################################################################################################################
# Army Bonus: Magnificent Presence III
#################################################################################################################
ArmyBonusBlueprint {
    Name = 'HSednaMagnificentPresence03_Minion',
    ApplyArmies = 'Single',
    UnitCategory = 'MINION',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaMagnificentPresence03_Minion',
            BuffType = 'MAGPRESENCEMINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'MINION',
            Duration = -1,
            Affects = {
                RateOfFire = {Mult = 0.15},
                MaxHealth = {Add = 200, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Healing Wind I
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaHealingWind01',
    DisplayName = '<LOC ABILITY_Sedna_0030>Healing Wind I',
    Description = '<LOC ABILITY_Sedna_0063>A soothing wind washes over nearby allies.\n\n+[GetRegenBuff] Health Per Second Aura.',
    AbilityType = 'Aura',
    AffectRadius = 15,
    AuraPulseTime = 5,
    TargetAlliance = 'Ally',
    GetRegenBuff = function(self) return math.floor( Buffs[self.Name].Affects.Regen.Add ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaHealingWind01',
            Debuff = false,
            Duration = 5,
            DisplayName = '<LOC ABILITY_Sedna_0031>Healing Wind',
            Description = '<LOC ABILITY_Sedna_0032>Health Per Second increased.',
            BuffType = 'HSEDNAHEALINGWIND',
            Icon = '/DGSedna/NewSednaHealingWind01',
            Stacks = 'REPLACE',
            DamageSelf = true,
            CanBeEvaded = false,
            Affects = {
                Regen = {Add = 12},
            },
        },
    },
    CreateAbilityAmbients = function( self, unit, trash )
        FxHealingWind01( unit, trash )
    end,
}

#################################################################################################################
# Healing Wind II
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaHealingWind02',
    DisplayName = '<LOC ABILITY_Sedna_0033>Healing Wind II',
    Description = '<LOC ABILITY_Sedna_0072>A soothing wind washes over nearby allies and nearby priests have increased healing power.\n\n+[GetRegenBuff] Health Per Second Aura.',
    AbilityType = 'Aura',
    AffectRadius = 15,
    AuraPulseTime = 5,
    TargetAlliance = 'Ally',
    GetRegenBuff = function(self) return math.floor( Buffs[self.Name].Affects.Regen.Add ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaHealingWind02',
            Debuff = false,
            Duration = 5,
            DisplayName = '<LOC ABILITY_Sedna_0031>Healing Wind',
            Description = '<LOC ABILITY_Sedna_0032>Health Per Second increased.',
            BuffType = 'HSEDNAHEALINGWIND',
            Icon = '/DGSedna/NewSednaHealingWind01',
            Stacks = 'REPLACE',
            DamageSelf = true,
            CanBeEvaded = false,
            Affects = {
                Regen = {Add = 24},
            },
        },
        #While this is a dummy buff, the actual work is done in the priest script.
        BuffBlueprint {
            Name = 'HSednaHealingWindPriest02',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Sedna_0031>Healing Wind',
            Description = '<LOC ABILITY_Sedna_0035>Healing power increased.',
            EntityCategory = 'PRIEST',
            BuffType = 'HSEDNAPRIESTHEALBUFF',
            Stacks = 'REPLACE',
            Duration = 5,
            Icon = '/DGSedna/NewSednaHealingWind01',
            DoNotPulseIcon = true,
            Affects = {
                Dummy = {Add = 0.1},
            },
        },
    },
    CreateAbilityAmbients = function( self, unit, trash )
        FxHealingWind02( unit, trash )
    end,
}

#################################################################################################################
# VFX
# Silence
#################################################################################################################

function FxSilenceEntity( unit, pos, segments, radius, EmitterIds )
    local angle = (2*math.pi) / segments

    for i = 1, segments do
        local s = math.sin(i*angle)
        local c = math.cos(i*angle)
        local x = s * radius
        local z = c * radius

        CreateTemplatedEffectAtPos( 'Sedna', nil, 'SilenceEntity01', unit:GetArmy(), Vector(pos[1] + x,pos[2],pos[3]+z), Vector(x, 0, z) )
    end
end

function FxSilence01( unit, targetPos )
    # Create ring shape wisps outward then inward
    FxSilenceEntity ( unit, targetPos, 11, 1 )

    # Base effect flash, lines, distortion
    CreateTemplatedEffectAtPos( 'Sedna', nil, 'Silence01', unit:GetArmy(), targetPos )

    # Casting effects on hand
    AttachEffectsAtBone( unit, EffectTemplates.Sedna.SilenceCast01, -2 )
end

#################################################################################################################
# Counter Healing
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaCounterHealing01',
    DisplayName = '<LOC ABILITY_Sedna_0036>Counter Healing',
    Description = '<LOC ABILITY_Sedna_0052>Sedna\'s presence counters enemy healing. Enemy priests are unable to heal when they are near Sedna.',
    AbilityType = 'Aura',
    AffectRadius = 15,
    AuraPulseTime = 5,
    TargetAlliance = 'Enemy',
    TargetCategory = 'PRIEST',
    Tooltip = {
        TargetAlliance = 'Enemy',
    },
    Buffs = {
        BuffBlueprint {
            Name = 'HSednaCounterHealing01',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Sedna_0036>Counter Healing',
            Description = '<LOC ABILITY_Sedna_0038>Unable to heal.',
            BuffType = 'HSEDNACOUNTERHEALING',
            Stacks = 'REPLACE',
            Duration = 5,
            Icon = '/DGSedna/NewSednaCounterhealing01',
            DoNotPulseIcon = true,
            Affects = {
                AbilityEnable = {Bool = true,},
            },
            Effects = 'CounterHeal01',
            EffectsBone = -2,
        },
    },
    CreateAbilityAmbients = function( self, unit, trash )
        FxHealingWind01( unit, trash )
        FxHealingWind02( unit, trash )
    end,
}

#################################################################################################################
# Silence I
# Silences enemy demigods in the area for 3 seconds.
#################################################################################################################
AbilityBlueprint {
    AbilityType = 'Instant',
    AffectRadius = 15,
    Cooldown = 15,
    DisplayName = '<LOC ABILITY_Sedna_0039>Silence I',
    Description = '<LOC ABILITY_Sedna_0055>Howling winds erupt around Sedna, preventing enemy Demigods from casting in the area for [GetDuration] seconds.',
    EnergyCost = 800,
    HotKey = '4',
    CastAction = 'Silence',
    FollowThroughTime = 0.5,
    Icon = '/DGSedna/NewSednaSilence01',
    Name = 'HSednaSilence01',
    TargetAlliance = 'Enemy',
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration) end,
    TargetCategory = 'HERO - UNTARGETABLE',
    UISlot = 4,
    Buffs = {
        BuffBlueprint {
            Affects = {
                Silence = {Bool = true},
            },
            BuffType = 'HSEDNASILENCE',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Sedna_0040>Silenced',
            Description = '<LOC ABILITY_Sedna_0041>Unable to activate abilities or items.',
            Duration = 3,
            Icon = '/DGSedna/NewSednaSilence01',
            Name = 'HSednaSilence01',
            Stacks = 'REPLACE',
        },
    },
    OnStartAbility = function(self, unit, params)
        ForkThread(FxSilence01, unit, unit:GetPosition())
    end,
}

#################################################################################################################
# Silence II
# Silences enemy demigods in the area for 5 seconds.
# Enemy demigods that are silenced while casting will take damage.
#################################################################################################################
AbilityBlueprint {
    AbilityType = 'Instant',
    AffectRadius = 15,
    Cooldown = 15,
    DisplayName = '<LOC ABILITY_Sedna_0042>Silence II',
    Description = '<LOC ABILITY_Sedna_0055>Howling winds erupt around Sedna, preventing enemy Demigods from casting in the area for [GetDuration] seconds.',
    EnergyCost = 900,
    HotKey = '4',
    CastAction = 'Silence',
    FollowThroughTime = 0.5,
    Icon = '/DGSedna/NewSednaSilence01',
    Name = 'HSednaSilence02',
    TargetAlliance = 'Enemy',
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration) end,
    TargetCategory = 'HERO - UNTARGETABLE',
    UISlot = 4,
    Buffs = {
        BuffBlueprint {
            Affects = {
                Silence = {Bool = true},
            },
            BuffType = 'HSEDNASilence',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Sedna_0040>Silenced',
            Description = '<LOC ABILITY_Sedna_0041>Unable to activate abilities or items.',
            Duration = 4,
            Icon = '/DGSedna/NewSednaSilence01',
            Name = 'HSednaSilence02',
            Stacks = 'REPLACE',
        },
    },
    OnStartAbility = function(self, unit, params)
        ForkThread(FxSilence01, unit, unit:GetPosition())
    end,
}

#################################################################################################################
# Silence III
# Silences enemy demigods in the area for 3 seconds.
#################################################################################################################
AbilityBlueprint {
    AbilityType = 'Instant',
    AffectRadius = 15,
    Cooldown = 15,
    DisplayName = '<LOC ABILITY_Sedna_0071>Silence III',
    Description = '<LOC ABILITY_Sedna_0055>Howling winds erupt around Sedna, preventing enemy Demigods from casting in the area for [GetDuration] seconds.',
    EnergyCost = 1000,
    HotKey = '4',
    CastAction = 'Silence',
    FollowThroughTime = 0.5,
    Icon = '/DGSedna/NewSednaSilence01',
    Name = 'HSednaSilence03',
    TargetAlliance = 'Enemy',
    GetDuration = function(self) return math.floor( Buffs[self.Name].Duration) end,
    TargetCategory = 'HERO - UNTARGETABLE',
    UISlot = 4,
    Buffs = {
        BuffBlueprint {
            Affects = {
                Silence = {Bool = true},
            },
            BuffType = 'HSEDNASILENCE',
            Debuff = true,
            CanBeDispelled = true,
            DisplayName = '<LOC ABILITY_Sedna_0040>Silenced',
            Description = '<LOC ABILITY_Sedna_0041>Unable to activate abilities or items.',
            Duration = 5,
            Icon = '/DGSedna/NewSednaSilence01',
            Name = 'HSednaSilence03',
            Stacks = 'REPLACE',
        },
    },
    OnStartAbility = function(self, unit, params)
        ForkThread(FxSilence01, unit, unit:GetPosition())
    end,
}
#################################################################################################################
# Epic Death
#################################################################################################################

function FxEpicDeathEntity( unit, pos, segments, radius )
    local angle = (2*math.pi) / segments

    for i = 1, segments do
        local s = math.sin(i*angle)
        local c = math.cos(i*angle)
        local x = s * radius
        local z = c * radius

        CreateTemplatedEffectAtPos( 'Sedna', nil, 'EpicDeath02', unit:GetArmy(), Vector(pos[1] + x,pos[2],pos[3]+z), Vector(x, 0, z) )
    end
end

SednaDeath = function( unit, abil )
    local data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = unit:GetArmy(),
        Amount = abil.HealAmt * -1,
        IgnoreDamageRangePercent = true,
        Type = 'Spell',
        DamageAction = abil.Name,
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

    # Ring wisps form around her
    AttachEffectsAtBone( unit, EffectTemplates.Sedna.EpicDeath01, -2 )

    WaitSeconds(0.5)

    # Casting effects on hand
    AttachEffectsAtBone( unit, EffectTemplates.Sedna.CastHeal01, 'sk_Leopard_Rider_Sedna_Weapon_Grip_Left' )

    WaitSeconds(0.5)

    # Create wisps outward
    FxEpicDeathEntity ( unit, unit:GetPosition(), 8, 7 )

    # Apply heal to all friendly entities nearby
    local entities = GetEntitiesInSphere("UNITS", table.copy(unit:GetPosition()), abil.AffectRadius)

    for k,entity in entities do
        if IsAlly(unit:GetArmy(),entity:GetArmy()) and not entity:IsDead() and not EntityCategoryContains(categories.NOBUFFS, entity) and not EntityCategoryContains(categories.UNTARGETABLE, entity) then
            DealDamage( data, entity )
            AttachBuffEffectAtBone( entity, 'SednaHeal01', -2 );
        end
    end

    WaitSeconds(1.5)

    # Wisps form around Sedna as she fades out, slides into ground.
    AttachEffectsAtBone( unit, EffectTemplates.Sedna.EpicDeath03, -2 )
end

AbilityBlueprint {
    Name = 'HSednaDeath01',
    DisplayName = 'Death',
    Description = 'Sedna death functional ability',
    AbilityType = 'Quiet',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    NoCastAnim = true,
    AffectRadius = 10,
    HealAmt = 300,
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnKilled:Add(self.Death, self)
    end,
    Death = function(self, unit)
        unit:ForkThread(SednaDeath, self)
    end,
}

#################################################################################################################
# Grey Abilities
#################################################################################################################
AbilityBlueprint {
    Name = 'HSednaPounceGrey01',
    DisplayName = '<LOC ABILITY_Sedna_0000>Pounce I',
    Description = '<LOC ABILITY_Sedna_0001>Sedna commands her cat to pounce on an enemy, interrupting them and dealing [GetDamageAmt] damage.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 1,
    HotKey = '1',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HSednaPounce01'].RangeMax end,
    GetDamageAmt = function(self) return math.floor( Ability['HSednaPounce01'].DamageAmt ) end,
    GetEnergyCost = function(self) return Ability['HSednaPounce01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HSednaPounce01'].CastingTime end,
    GetCooldown = function(self) return Ability['HSednaPounce01'].Cooldown end,
    Icon = '/DGSedna/NewSednaPounce01',
}

AbilityBlueprint {
    Name = 'HSednaYetiGrey01',
    DisplayName = '<LOC ABILITY_Sedna_0006>Horn of the Yeti I',
    Description = '<LOC ABILITY_Sedna_0007>Sedna summons a Yeti to defend her. She may have [GetMaxYeti] Yeti active.',
    AbilityType = 'Passive',
    TargetAlliance = 'Ally',
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HSednaYeti01'].RangeMax end,
    GetYetiLifetime = function(self) return math.floor( Ability['HSednaYeti01'].YetiLifetime ) end,
    GetMaxYeti = function(self) return math.floor( Ability['HSednaYeti01'].MaxYeti ) end,
    GetEnergyCost = function(self) return Ability['HSednaYeti01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HSednaYeti01'].CastingTime end,
    GetCooldown = function(self) return Ability['HSednaYeti01'].Cooldown end,
    Icon = '/DGSedna/NewSednaYeti01',
}

AbilityBlueprint {
    Name = 'HSednaHealGrey01',
    DisplayName = '<LOC ABILITY_Sedna_0012>Heal I',
    Description = '<LOC ABILITY_Sedna_0013>Sedna heals a friendly target for [GetHealAmt] Health.',
    AbilityType = 'Passive',
    TargetAlliance = 'Ally',
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HSednaHeal01'].RangeMax end,
    GetHealAmt = function(self) return math.floor( Ability['HSednaHeal01'].HealAmt ) end,
    GetEnergyCost = function(self) return Ability['HSednaHeal01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HSednaHeal01'].CastingTime end,
    GetCooldown = function(self) return Ability['HSednaHeal01'].Cooldown end,
    Icon = '/DGSedna/NewSednaHeal01',
}

AbilityBlueprint {
    Name = 'HSednaSilenceGrey01',
    DisplayName = '<LOC ABILITY_Sedna_0039>Silence I',
    Description = '<LOC ABILITY_Sedna_0055>Howling winds erupt around Sedna, preventing enemy Demigods from casting in the area for [GetDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 4,
    HotKey = '4',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HSednaSilence01'].RangeMax end,
    GetDuration = function(self) return math.floor( Buffs['HSednaSilence01'].Duration) end,
    GetEnergyCost = function(self) return Ability['HSednaSilence01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HSednaSilence01'].CastingTime end,
    GetCooldown = function(self) return Ability['HSednaSilence01'].Cooldown end,
    Icon = '/DGSedna/NewSednaSilence01',
}

__moduleinfo.auto_reload = true
