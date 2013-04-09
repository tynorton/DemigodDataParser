local Buff = import('/lua/sim/buff.lua')
local Validate = import('/lua/common/ValidateAbility.lua')
local Abil = import('/lua/sim/ability.lua')
local Utils = import('/lua/utilities.lua')
local RippleWorld = import('/lua/utilities.lua').RippleWorld
local GetRandomFloat = import('/lua/utilities.lua').GetRandomFloat

#################################################################################################################
# Buffs: Queen Pack/Unpack ability management
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenUnpackedAbilityDisable',
    Debuff = false,
    DisplayName = 'Packed',
    BuffType = 'HQUEENUNPACKEDABILITYDISABLED',
    Stacks = 'REPLACE',
    Duration = -1,
    AbilityCategory = 'HQUEENUNPACKED',
    Affects = {
        AbilityEnable = {Bool = true,},
    },
}

BuffBlueprint {
    Name = 'HQueenAbilityDisable',
    Debuff = false,
    DisplayName = 'Unpacked',
    BuffType = 'HQUEENPACKEDABILITYDISABLED',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        AbilityEnable = {Bool = true,},
    },
}

#################################################################################################################
# Buffs: Queen Packed State Buffs
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenPackedBuffs',
    Debuff = false,
    DisplayName = '<LOC ABILITY_Queen_0056>Closed',
    Description = '<LOC ABILITY_Queen_0057>Armor increased.\nMana Per Second increased.\nHealth Per Second increased.',
    BuffType = 'HQUEENREGEN',
    Stacks = 'IGNORE',
    Duration = -1,
    Affects = {
        Armor = {Mult = 0.1},
        EnergyRegen = {Mult = 0.5},
        Regen = {Add = 10},
        RateOfFire = {Mult = 0},
        MoveMult = {Mult = 0},
    },
    Icon = '/dgqueenofthorns/NewQueenClose',
}

#################################################################################################################
# FX: Packing and Unpacking
#################################################################################################################
function FxUnPack(unit)
    local pos = table.copy(unit:GetPosition())
    pos[2] = 100
    CreateCharacterEffectsAtPos( unit, 'queen', 'UnPack01', pos )
end

#################################################################################################################
# Pack Up
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenPack',
    DisplayName = '<LOC ABILITY_Queen_0000>Close',
    Description = '<LOC ABILITY_Queen_0001>Queen of Thorns sinks into her flower, granting her new abilities as well as enhanced Armor, Mana Per Second, Health Per Second, and splash damage.',
    AbilityType = 'Instant',
    EnergyCost = 0,
    Cooldown = 1,
    SharedCooldown = 'HQueenPackSwitch',
    UISlot = 4,
    HotKey = '4',
    Tooltip = {
        EnergyCost = 0,
        Cooldown = 1,
    },
    CanCastWhileMoving = true,
    AbilityCategory = 'HQUEENUNPACKED',
    NotSilenceable = true,
    OnStartAbility = function(self, unit, params)
        Buff.ApplyBuff(unit, 'HQueenAbilityDisable', unit)
        ChangeState(unit, unit.PackedState)
    end,
    Icon = '/dgqueenofthorns/NewQueenClose',
}

#################################################################################################################
# Unpack
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenUnpack',
    DisplayName = '<LOC ABILITY_Queen_0002>Open',
    Description = '<LOC ABILITY_Queen_0003>Queen of Thorns comes out of her flower, granting her new abilities.',
    AbilityType = 'Instant',
    EnergyCost = 0,
    Cooldown = 1,
    SharedCooldown = 'HQueenPackSwitch',
    UISlot = 4,
    HotKey = '4',
    Tooltip = {
        EnergyCost = 0,
        Cooldown = 1,
    },
    CanCastWhileMoving = true,
    AbilityCategory = 'HQUEENPACKED',
    NotSilenceable = true,
    OnStartAbility = function(self, unit, params)
        Buff.ApplyBuff(unit, 'HQueenAbilityDisable', unit)
        ChangeState(unit, unit.UnpackedState)

        # play pack up effects
        ForkThread(FxUnPack, unit)
    end,
    Icon = '/dgqueenofthorns/NewQueenOpen01',
}

#################################################################################################################
# VFX
# Create Shamblers
#################################################################################################################

function FxShamblerWarmup01(self, unit)
    # Casting effects on left and right wrists.
    AttachEffectsAtBone( unit, EffectTemplates.Queenofthorns.CastShambler01, 'sk_Queen_LeftWrist' )
    AttachEffectsAtBone( unit, EffectTemplates.Queenofthorns.CastShambler01, 'sk_Queen_RightWrist' )

    # Glow at base
    AttachEffectsAtBone( unit, EffectTemplates.Queenofthorns.CastShambler02, -2 )
end

#################################################################################################################
# CE: Count Shamblers
#################################################################################################################
function CountShamblers(maxShamblers, shambler)

    # Get the tracking table for shamblers, or create it if it's new
    local aiBrain = shambler:GetAIBrain()
    local queen = aiBrain.AbilityData
    if not queen.ShamblerList then
        queen.ShamblerList = {}
    end

    # Add this shambler to the queen's tracking table
    queen.Counter = (queen.Counter or 0) + 1
    queen.ShamblerList[queen.Counter] = shambler

    # Clean out dead shamblers from the list
    for k, v in queen.ShamblerList do
        if v:IsDead() then
            queen.ShamblerList[k] = nil
        end
    end

    # If we're at the max number of shamblers, destroy the oldest one
    if table.getsize(queen.ShamblerList) > maxShamblers then
        local key = table.keys(queen.ShamblerList)[1]
        if not queen.ShamblerList[key].KillData then
            queen.ShamblerList[key].KillData = {}
        end
        queen.ShamblerList[key]:Kill()
        queen.ShamblerList[key] = nil
    end
end

#################################################################################################################
# CE: Create Shamblers
#################################################################################################################
function SpawnShambler(unit, def, params)
    local numShamblers = def.NumShamblers

    unit:OccupyGround(true)
    local nearbyUnits = unit:GetAIBrain():GetUnitsAroundPoint( categories.MOBILE, unit.Position, 10 )
    for k,v in nearbyUnits do
        v:OccupyGround(true)
    end

    local newUnits = {}
    local orient = unit:GetOrientation()
    for x = 1, numShamblers do
        local loc = unit:FindEmptySpotNear(unit.Position)
        if not loc then
            loc = unit:GetPosition()
        end
        local brainNum = unit:GetArmy()
        local shambler = CreateUnitHPR( 'HQueenEnt', brainNum, loc[1], loc[2], loc[3], orient[1], orient[2],orient[3])
        if not shambler then
            break
        end

        table.insert( newUnits, shambler )
        shambler:OccupyGround(true)
        IssueGuard({shambler}, unit)
        # Apply Entourage to new Shamblers
        for i = 1, 3 do
            if(Validate.HasAbility(unit, 'HQueenEntourage0' .. i)) then
                Buff.ApplyBuff(shambler, 'HQueenEntourageBuff0' .. i, unit)
            end
        end
        CountShamblers(def.MaxShamblers, shambler)

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
# Create Shamblers I
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenShambler01',
    DisplayName = '<LOC ABILITY_Queen_0004>Summon Shambler I',
    Description = '<LOC ABILITY_Queen_0005>Queen of Thorns summons [GetShamblersSummoned] Shamblers from her thorns to protect her. She may have [GetMaxShamblers] Shamblers active.',
    AbilityType = 'Instant',
    EnergyCost = 450,
    Cooldown = 5,
    UISlot = 1,
    HotKey = '1',
    NumShamblers = 1,
    MaxShamblers = 2,
    CastingTime = 0.5,
    CastAction = 'Summon',
    FollowThroughTime = 0.1,
    AbilityCategory = 'HQUEENPACKED',
    Icon = '/dgqueenofthorns/NewQueenSummonShambler01',
    GetShamblersSummoned = function(self) return math.floor( self.NumShamblers ) end,
    GetMaxShamblers = function(self) return math.floor( self.MaxShamblers ) end,
    OnStartCasting = function(self, unit)
        # Casting effects
        FxShamblerWarmup01( self, unit )
    end,
    OnStartAbility = function(self, unit, params)
        unit:ForkThread(SpawnShambler, self, params)
    end,
}

#################################################################################################################
# Create Shamblers II
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenShambler02',
    DisplayName = '<LOC ABILITY_Queen_0006>Summon Shambler II',
    Description = '<LOC ABILITY_Queen_0005>Queen of Thorns summons [GetShamblersSummoned] Shamblers from her thorns to protect her. She may have [GetMaxShamblers] Shamblers active.',
    AbilityType = 'Instant',
    EnergyCost = 625,
    Cooldown = 5,
    UISlot = 1,
    HotKey = '1',
    NumShamblers = 2,
    MaxShamblers = 2,
    CastingTime = 0.5,
    CastAction = 'Summon',
    FollowThroughTime = 0.1,
    AbilityCategory = 'HQUEENPACKED',
    GetShamblersSummoned = function(self) return math.floor( self.NumShamblers ) end,
    GetMaxShamblers = function(self) return math.floor( self.MaxShamblers ) end,
    Icon = '/dgqueenofthorns/NewQueenSummonShambler01',
    OnStartCasting = function(self, unit)
        # Casting effects
        FxShamblerWarmup01( self, unit )
    end,
    OnStartAbility = function(self, unit, params)
        unit:ForkThread(SpawnShambler, self, params)
    end,
}

#################################################################################################################
# Create Shamblers III
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenShambler03',
    DisplayName = '<LOC ABILITY_Queen_0008>Summon Shambler III',
    Description = '<LOC ABILITY_Queen_0005>Queen of Thorns summons [GetShamblersSummoned] Shamblers from her thorns to protect her. She may have [GetMaxShamblers] Shamblers active.',
    AbilityType = 'Instant',
    EnergyCost = 625,
    Cooldown = 5,
    UISlot = 1,
    HotKey = '1',
    NumShamblers = 2,
    MaxShamblers = 4,
    CastingTime = 0.5,
    CastAction = 'Summon',
    FollowThroughTime = 0.1,
    AbilityCategory = 'HQUEENPACKED',
    Icon = '/dgqueenofthorns/NewQueenSummonShambler01',
    GetShamblersSummoned = function(self) return math.floor( self.NumShamblers ) end,
    GetMaxShamblers = function(self) return math.floor( self.MaxShamblers ) end,
    OnStartCasting = function(self, unit)
        # Casting effects
        FxShamblerWarmup01( self, unit )
    end,
    OnStartAbility = function(self, unit, params)
        unit:ForkThread(SpawnShambler, self, params)
    end,
}

#################################################################################################################
# Create Shamblers IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenShambler04',
    DisplayName = '<LOC ABILITY_Queen_0084>Summon Shambler IV',
    Description = '<LOC ABILITY_Queen_0005>Queen of Thorns summons [GetShamblersSummoned] Shamblers from her thorns to protect her. She may have [GetMaxShamblers] Shamblers active.',
    AbilityType = 'Instant',
    EnergyCost = 975,
    Cooldown = 5,
    UISlot = 1,
    HotKey = '1',
    NumShamblers = 4,
    MaxShamblers = 4,
    CastingTime = 0.5,
    CastAction = 'Summon',
    FollowThroughTime = 0.1,
    AbilityCategory = 'HQUEENPACKED',
    Icon = '/dgqueenofthorns/NewQueenSummonShambler01',
    GetShamblersSummoned = function(self) return math.floor( self.NumShamblers ) end,
    GetMaxShamblers = function(self) return math.floor( self.MaxShamblers ) end,
    OnStartCasting = function(self, unit)
        # Casting effects
        FxShamblerWarmup01( self, unit )
    end,
    OnStartAbility = function(self, unit, params)
        unit:ForkThread(SpawnShambler, self, params)
    end,
}
#################################################################################################################
# CE: Consume Shambler
#################################################################################################################
function Consume(abilityDef, unit, params)
    local target = params.Targets[1]
    if not target:IsDead() then
        target.Mulch = true
        if not target.KillData then
            target.KillData = {}
        end
        target:Kill()
        Buff.ApplyBuff(unit, abilityDef.RegenBuffName, unit)

        # Temp consume effects at target
        AttachEffectAtBone( target, 'Queenofthorns', 'MulchTarget01', -2 )

        # Create uproot cast effects at Queen
        AttachEffectAtBone( unit, 'Queenofthorns', 'MulchCast01', -2 )
    
        local pos = target:GetPosition()
        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Amount = abilityDef.DamageAmt,
            Type = 'Spell',
            DamageAction = abilityDef.Name,
            Radius = abilityDef.DamageArea,
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
        WaitSeconds(2)
        DamageArea(data)
    end
end

#################################################################################################################
# Consume Shambler I
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenConsumeShambler01',
    DisplayName = '<LOC ABILITY_Queen_0010>Mulch Shambler I',
    Description = '<LOC ABILITY_Queen_0013>Queen of Thorns absorbs an allied Shambler, killing it and restoring [GetHealthRestored] Health. Enemies near the Shambler take [GetDamage] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'ENT',
    TargetingMethod = 'OWNMINION',
    EnergyCost = 250,
    Cooldown = 7,
    RangeMax = 5000,
    DamageAmt = 250,
    DamageArea = 8,
    IgnoreFacing = true,
    UISlot = 2,
    HotKey = '2',
    AbilityCategory = 'HQUEENPACKED',
    CastingTime = 0.1,
    CastAction = 'Mulch',
    FollowThroughTime = 0.5,
    RegenBuffName = 'HQueenConsumeShamblerBuff01',
    Icon = '/dgqueenofthorns/NewQueenConsumeShambler01',
    GetHealthRestored = function(self) return math.floor( Buffs['HQueenConsumeShamblerBuff01'].Affects.Health.Add ) end,
    GetDamage = function(self) return self.DamageAmt end,
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Consume, self, unit, params)
    end,
}

#################################################################################################################
# Buff: Consume Shambler I
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenConsumeShamblerBuff01',
    Debuff = false,
    DisplayName = '<LOC ABILITY_Queen_0058>Mulch Shambler Buff',
    Description = '<LOC ABILITY_Queen_0059>Mulched a Shambler for additional Health.',
    Stacks = 'REPLACE',
    BuffType = 'HQUEENCONSUME',
    DamageFriendly = true,
    DamageSelf = true,
    IgnoreDamageRangePercent = true,
    CanBeEvaded = false,
    CanCrit = false,
    CanBackfire = false,
    ArmorImmune = true,
    Affects = {
        Health = {Add = 750},
    },
}

#################################################################################################################
# Consume Shambler II
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenConsumeShambler02',
    DisplayName = '<LOC ABILITY_Queen_0012>Mulch Shambler II',
    Description = '<LOC ABILITY_Queen_0013>Queen of Thorns absorbs an allied Shambler, killing it and restoring [GetHealthRestored] Health. Enemies near the Shambler take [GetDamage] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'ENT',
    TargetingMethod = 'OWNMINION',
    EnergyCost = 250,
    Cooldown = 7,
    RangeMax = 5000,
    DamageAmt = 500,
    DamageArea = 8,
    IgnoreFacing = true,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'Mulch',
    FollowThroughTime = 0.5,
    AbilityCategory = 'HQUEENPACKED',
    CastingTime = 0.1,
    RegenBuffName = 'HQueenConsumeShamblerBuff02',
    Icon = '/dgqueenofthorns/NewQueenConsumeShambler01',
    GetHealthRestored = function(self) return math.floor( Buffs['HQueenConsumeShamblerBuff02'].Affects.Health.Add ) end,
    GetDamage = function(self) return self.DamageAmt end,
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Consume, self, unit, params)
    end,
}

#################################################################################################################
# Buff: Consume Shambler II
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenConsumeShamblerBuff02',
    Debuff = false,
    DisplayName = '<LOC ABILITY_Queen_0060>Mulch Shambler Buff',
    Description = '<LOC ABILITY_Queen_0061>Mulched a Shambler for additional Health.',
    Stacks = 'REPLACE',
    BuffType = 'HQUEENCONSUME',
    DamageFriendly = true,
    DamageSelf = true,
    IgnoreDamageRangePercent = true,
    CanBeEvaded = false,
    CanCrit = false,
    CanBackfire = false,
    ArmorImmune = true,
    Affects = {
        Health = {Add = 1500},
    },
}

#################################################################################################################
# Consume Shambler III
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenConsumeShambler03',
    DisplayName = '<LOC ABILITY_Queen_0014>Mulch Shambler III',
    Description = '<LOC ABILITY_Queen_0013>Queen of Thorns absorbs an allied Shambler, killing it and restoring [GetHealthRestored] Health. Enemies near the Shambler take [GetDamage] damage.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Ally',
    TargetCategory = 'ENT',
    TargetingMethod = 'OWNMINION',
    EnergyCost = 250,
    Cooldown = 7,
    RangeMax = 5000,
    DamageAmt = 750,
    DamageArea = 8,
    IgnoreFacing = true,
    UISlot = 2,
    HotKey = '2',
    CastAction = 'Mulch',
    FollowThroughTime = 0.5,
    AbilityCategory = 'HQUEENPACKED',
    CastingTime = 0.1,
    RegenBuffName = 'HQueenConsumeShamblerBuff03',
    Icon = '/dgqueenofthorns/NewQueenConsumeShambler01',
    GetHealthRestored = function(self) return math.floor( Buffs['HQueenConsumeShamblerBuff03'].Affects.Health.Add ) end,
    GetDamage = function(self) return self.DamageAmt end,
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Consume, self, unit, params)
    end,
}

#################################################################################################################
# Buff: Consume Shambler III
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenConsumeShamblerBuff03',
    Debuff = false,
    DisplayName = '<LOC ABILITY_Queen_0062>Mulch Shambler Buff',
    Description = '<LOC ABILITY_Queen_0063>Mulched a Shambler for additional Health.',
    Stacks = 'REPLACE',
    BuffType = 'HQUEENCONSUME',
    DamageFriendly = true,
    DamageSelf = true,
    IgnoreDamageRangePercent = true,
    CanBeEvaded = false,
    CanCrit = false,
    CanBackfire = false,
    ArmorImmune = true,
    Affects = {
        Health = {Add = 2250},
    },
}

#################################################################################################################
# CE: Entourage
#################################################################################################################
function Entourage(self, buffName, unit)
    if(unit and not unit:IsDead()) then
        # Apply Entourage buff to existing Shamblers
        local shamblers = ArmyBrains[unit:GetArmy()]:GetListOfUnits(categories.hqueenent, false)
        for k, v in shamblers do
            if(v and not v:IsDead()) then
                Buff.ApplyBuff(v, buffName, unit)
            end
        end
    end
end

#################################################################################################################
# Entourage I
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenEntourage01',
    AbilityType = 'Quiet',
    DisplayName = '<LOC ABILITY_Queen_0043>Entourage I',
    Description = '<LOC ABILITY_Queen_0044>Increases Shambler Health by [GetShamblerHealth] and damage by [GetShamblerDamage].',
    GetShamblerHealth = function(self) return math.floor( Buffs['HQueenEntourageBuff01'].Affects.MaxHealth.Add ) end,
    GetShamblerDamage = function(self) return math.floor( Buffs['HQueenEntourageBuff01'].Affects.DamageRating.Add ) end,
    TargetAlliance = 'Ally',
    TargetCategory = 'HERO - UNTARGETABLE',
    OnAbilityAdded = function(self, unit)
        Entourage(self, 'HQueenEntourageBuff01', unit)
    end,
    Icon = '/dgqueenofthorns/NewQueenEntourage01',
}

#################################################################################################################
# Buff: Entourage I
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenEntourageBuff01',
    BuffType = 'HQUEENENTOURAGEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0064>Entourage I',
    Description = '<LOC ABILITY_Queen_0065>Health and Weapon Damage increased.',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    NoFloatText = true,
    IgnoreDamageRangePercent = true,
    CanCrit = false,
    Affects = {
        DamageRating = {Add = 10},
        MaxHealth = {Add = 250, AdjustHealth = true},
    },
}

#################################################################################################################
# Entourage II
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenEntourage02',
    Description = '<LOC ABILITY_Queen_0044>Increases Shambler Health by [GetShamblerHealth] and damage by [GetShamblerDamage].',
    GetShamblerHealth = function(self) return math.floor( Buffs['HQueenEntourageBuff02'].Affects.MaxHealth.Add ) end,
    GetShamblerDamage = function(self) return math.floor( Buffs['HQueenEntourageBuff02'].Affects.DamageRating.Add ) end,
    AbilityType = 'Quiet',
    DisplayName = '<LOC ABILITY_Queen_0045>Entourage II',
    TargetAlliance = 'Ally',
    TargetCategory = 'HERO - UNTARGETABLE',
    OnAbilityAdded = function(self, unit)
        Entourage(self, 'HQueenEntourageBuff02', unit)
    end,
    Icon = '/dgqueenofthorns/NewQueenEntourage01',
}

#################################################################################################################
# Buff: Entourage II
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenEntourageBuff02',
    BuffType = 'HQUEENENTOURAGEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0066>Entourage II',
    Description = '<LOC ABILITY_Queen_0067>Health and Weapon Damage increased.',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    NoFloatText = true,
    IgnoreDamageRangePercent = true,
    CanCrit = false,
    Affects = {
        DamageRating = {Add = 20},
        MaxHealth = {Add = 500, AdjustHealth = true},
    },
}

#################################################################################################################
# Entourage III
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenEntourage03',
    Description = '<LOC ABILITY_Queen_0044>Increases Shambler Health by [GetShamblerHealth] and damage by [GetShamblerDamage].',
    GetShamblerHealth = function(self) return math.floor( Buffs['HQueenEntourageBuff03'].Affects.MaxHealth.Add ) end,
    GetShamblerDamage = function(self) return math.floor( Buffs['HQueenEntourageBuff03'].Affects.DamageRating.Add ) end,
    AbilityType = 'Quiet',
    DisplayName = '<LOC ABILITY_Queen_0047>Entourage III',
    TargetAlliance = 'Ally',
    TargetCategory = 'HERO - UNTARGETABLE',
    OnAbilityAdded = function(self, unit)
        Entourage(self, 'HQueenEntourageBuff03', unit)
    end,
    Icon = '/dgqueenofthorns/NewQueenEntourage01',
}

#################################################################################################################
# Buff: Entourage III
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenEntourageBuff03',
    BuffType = 'HQUEENENTOURAGEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0068>Entourage III',
    Description = '<LOC ABILITY_Queen_0069>Health and Weapon Damage increased.',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    NoFloatText = true,
    IgnoreDamageRangePercent = true,
    CanCrit = false,
    Affects = {
        DamageRating = {Add = 30},
        MaxHealth = {Add = 750, AdjustHealth = true},
    },
}

#################################################################################################################
# Tribute
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenTribute',
    DisplayName = '<LOC ABILITY_Queen_0088>Tribute',
    Description = '<LOC ABILITY_Queen_0089>Queen of Thorns demands tribute from her subjects. Gold production increased by [GetGoldBuff].',
    AbilityType = 'Quiet',
    GetGoldBuff = function(self) return Buffs[self.Name].Affects.GoldProduction.Add end,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenTribute',
            DisplayName = '<LOC ABILITY_Queen_0090>Tribute',
            Description = '<LOC ABILITY_Queen_0091>Gold production increased.',
            BuffType = 'HQUEENTRIBUTE',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                GoldProduction = {Add = 4},
            },
        },
    },
    Icon = '/dgqueenofthorns/NewQueenTribute01',
}

#################################################################################################################
# CE: Uproot
# This is not a buff because Compost affects Uproot damage.
#################################################################################################################
function Uproot(self, unit, params)
    # Create uproot effects at target
    local target = params.Targets[1]
    local pos = table.copy(target:GetPosition())
    pos[2] = 100
    local UprootEffects = {}
    local emitters = CreateTemplatedEffectAtPos( 'Buff', 'Uproot01', target:GetEffectBuffClassification(), unit:GetArmy(), pos )
    for k, v in emitters do
        table.insert( UprootEffects, v )
    end

    # Create uproot cast effects at Queen
    AttachEffectAtBone( unit, 'Queenofthorns', 'UprootCast02', -2 )

    local data = {
        Instigator = unit,
        InstigatorArmy = unit:GetArmy(),
        Amount = self.DamageAmt + unit.AbilityData.UprootBonus,
        Type = 'Spell',
        Radius = 0,
        DamageAction = self.Name,
        DamageSelf = false,
        CanDamageReturn = false,
        CanCrit = false,
        CanBackfire = false,
        CanBeEvaded = false,
        CanMagicResist = true,
        ArmorImmune = true,
        IgnoreDamageRangePercent = true,
        Group = "STRUCTURE",
    }
    
    local areadata = {}
    
    if Validate.HasAbility(unit, 'HQueenViolentSiege') then
        areadata = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Amount = self.ViolentSiegeAmt,
            Type = 'Spell',
            DamageAction = 'HQueenViolentSiege',
            Radius = self.ViolentSiegeRadius,
            DamageSelf = false,
            Origin = pos,
            CanDamageReturn = false,
            CanCrit = false,
            CanBackfire = false,
            CanBeEvaded = false,
            CanMagicResist = true,
            ArmorImmune = true,
            NoFloatText = false,
            IgnoreTargets = { target },
            Group = "UNITS",
        }
    end
    
    for i = 1, self.Pulses do
        if not target:IsDead() then
            DealDamage(data, params.Targets[1])
            if Validate.HasAbility(unit, 'HQueenViolentSiege') then
                DamageArea(areadata)
            end
        end
        WaitSeconds(1)
    end

    if UprootEffects then
        for kEffect, vEffect in UprootEffects do
            vEffect:Destroy()
        end
    end
end

#################################################################################################################
# Uproot I
# DamageAmt is for every tick of Uproot.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenUproot01',
    DisplayName = '<LOC ABILITY_Queen_0016>Uproot I',
    Description = '<LOC ABILITY_Queen_0017>Queen of Thorns sends her vines deep beneath the earth to destroy target structure\'s foundation, dealing [GetDamage] damage over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'STRUCTURE - UNTARGETABLE',
    TargetingMethod = 'HOSTILESTRUCTURE',
    EnergyCost = 425,
    Cooldown = 15,
    RangeMax = 20,
    DamageAmt = 50,
    IgnoreFacing = true,
    Pulses = 10,
    UISlot = 3,
    HotKey = '3',
    AbilityCategory = 'HQUEENUNPACKED',
    CastingTime = 0.5,
    CastAction = 'Uproot',
    FollowThroughTime = 1.0,
    Icon = '/dgqueenofthorns/NewQueenUproot01',
    GetDamage = function(self) return math.floor( self.DamageAmt * self.Pulses ) end,
    GetDuration = function(self) return math.floor( self.Pulses ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenUproot01',
            Debuff = true,
            CanBeDispelled = false,
            DisplayName = '<LOC ABILITY_Queen_0050>Uproot',
            Description = '<LOC ABILITY_Queen_0051>Taking severe damage.',
            BuffType = 'UPROOTDUMMY',
            Stacks = 'REPLACE',
            Icon = '/dgqueenofthorns/NewQueenUproot01',
            Duration = 10,
            Affects = {
            },
        }
    },
    OnAbilityAdded = function(self, unit)
        if not unit.AbilityData.UprootBonus then
            unit.AbilityData.UprootBonus = 0
        end
    end,
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Uproot, self, unit, params)
    end,
}

#################################################################################################################
# Uproot II
# DamageAmt is for every tick of Uproot.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenUproot02',
    DisplayName = '<LOC ABILITY_Queen_0018>Uproot II',
    Description = '<LOC ABILITY_Queen_0017>Queen of Thorns sends her vines deep beneath the earth to destroy target structure\'s foundation, dealing [GetDamage] damage over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'STRUCTURE - UNTARGETABLE',
    TargetingMethod = 'HOSTILESTRUCTURE',
    EnergyCost = 585,
    Cooldown = 15,
    RangeMax = 20,
    DamageAmt = 100,
    IgnoreFacing = true,
    Pulses = 10,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'Uproot',
    FollowThroughTime = 1.0,
    AbilityCategory = 'HQUEENUNPACKED',
    CastingTime = 0.5,
    Icon = '/dgqueenofthorns/NewQueenUproot01',
    GetDamage = function(self) return math.floor( self.DamageAmt * self.Pulses ) end,
    GetDuration = function(self) return math.floor( self.Pulses ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenUproot02',
            Debuff = true,
            CanBeDispelled = false,
            DisplayName = '<LOC ABILITY_Queen_0050>Uproot',
            Description = '<LOC ABILITY_Queen_0051>Taking severe damage.',
            BuffType = 'UPROOTDUMMY',
            Stacks = 'REPLACE',
            Icon = '/dgqueenofthorns/NewQueenUproot01',
            Duration = 10,
            Affects = {
            },
        }
    },
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Uproot, self, unit, params)
    end,
}

#################################################################################################################
# Uproot III
# DamageAmt is for every tick of Uproot.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenUproot03',
    DisplayName = '<LOC ABILITY_Queen_0054>Uproot III',
    Description = '<LOC ABILITY_Queen_0017>Queen of Thorns sends her vines deep beneath the earth to destroy target structure\'s foundation, dealing [GetDamage] damage over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'STRUCTURE - UNTARGETABLE',
    TargetingMethod = 'HOSTILESTRUCTURE',
    EnergyCost = 745,
    Cooldown = 15,
    RangeMax = 20,
    DamageAmt = 150,
    IgnoreFacing = true,
    Pulses = 10,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'Uproot',
    FollowThroughTime = 1.0,
    AbilityCategory = 'HQUEENUNPACKED',
    CastingTime = 0.5,
    Icon = '/dgqueenofthorns/NewQueenUproot01',
    GetDamage = function(self) return math.floor( self.DamageAmt * self.Pulses ) end,
    GetDuration = function(self) return math.floor( self.Pulses ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenUproot03',
            Debuff = true,
            CanBeDispelled = false,
            DisplayName = '<LOC ABILITY_Queen_0050>Uproot',
            Description = '<LOC ABILITY_Queen_0051>Taking severe damage.',
            BuffType = 'UPROOTDUMMY',
            Stacks = 'REPLACE',
            Icon = '/dgqueenofthorns/NewQueenUproot01',
            Duration = 10,
            Affects = {
            },
        }
    },
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Uproot, self, unit, params)
    end,
}

#################################################################################################################
# Uproot IV
# DamageAmt is for every tick of Uproot.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenUproot04',
    DisplayName = '<LOC ABILITY_Queen_0085>Uproot IV',
    Description = '<LOC ABILITY_Queen_0017>Queen of Thorns sends her vines deep beneath the earth to destroy target structure\'s foundation, dealing [GetDamage] damage over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Enemy',
    TargetCategory = 'STRUCTURE - UNTARGETABLE',
    TargetingMethod = 'HOSTILESTRUCTURE',
    EnergyCost = 905,
    Cooldown = 15,
    RangeMax = 20,
    DamageAmt = 200,
    IgnoreFacing = true,
    Pulses = 10,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'Uproot',
    FollowThroughTime = 1.0,
    AbilityCategory = 'HQUEENUNPACKED',
    CastingTime = 0.5,
    ViolentSiegeAmt = 100,
    ViolentSiegeRadius = 8,
    Icon = '/dgqueenofthorns/NewQueenUproot01',
    GetDamage = function(self) return math.floor( self.DamageAmt * self.Pulses ) end,
    GetDuration = function(self) return math.floor( self.Pulses ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenUproot04',
            Debuff = true,
            CanBeDispelled = false,
            DisplayName = '<LOC ABILITY_Queen_0050>Uproot',
            Description = '<LOC ABILITY_Queen_0051>Taking severe damage.',
            BuffType = 'UPROOTDUMMY',
            Stacks = 'REPLACE',
            Icon = '/dgqueenofthorns/NewQueenUproot01',
            Duration = 10,
            Affects = {
            },
        }
    },
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Uproot, self, unit, params)
    end,
}

#################################################################################################################
# Violent Siege
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenViolentSiege',
    DisplayName = '<LOC ABILITY_Queen_0092>Violent Siege',
    Description = '<LOC ABILITY_Queen_0093>When Queen of Thorns uses Uproot, the force shakes loose debris from the structure. Enemies standing near the structure take [GetDamage] damage while Uproot is active.',
    AbilityType = 'Quiet',
    GetDamage = function(self) return math.floor( Ability['HQueenUproot04'].ViolentSiegeAmt ) end,
}

#################################################################################################################
# CE: Ground Spikes
#################################################################################################################
function GroundSpikes(unit, def)
    local pos = table.copy(unit:GetPosition())
    local points = Utils.GetPointsAroundCircle(pos, 1, 11)
    local lifetime = def.ProjectileLifetime

    for k, v in points do
        CreateProjectileForQueen(unit, v[1] - pos[1], v[3] - pos[3], lifetime, GetRandomFloat( 22, 26 ) )
    end

    points = Utils.GetPointsAroundCircle(pos, 7, 23)
    for k, v in points do
        CreateProjectileForQueen(unit, v[1] - pos[1], v[3] - pos[3], lifetime, GetRandomFloat( 22, 26 ) )
    end

    local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Amount = def.DamageAmt,
            Type = 'Spell',
            DamageAction = def.Name,
            Radius = def.AffectRadius,
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
    WaitSeconds (0.5)
    DamageArea(data)
    
    # Apply debuffs to enemy entities nearby
    local entities = GetEntitiesInSphere("UNITS", table.copy(unit:GetPosition()), def.AffectRadius)

    for k,entity in entities do
        if IsEnemy(unit:GetArmy(),entity:GetArmy()) and not entity:IsDead() and not EntityCategoryContains(categories.NOBUFFS, entity) and not EntityCategoryContains(categories.UNTARGETABLE, entity) then
            Buff.ApplyBuff(entity, def.Name, unit, unit:GetArmy())
        end
    end
    
    RippleWorld()
end

function CreateProjectileForQueen(unit, x, z, lifetime, velocity )
    local proj = unit:CreateProjectile('/projectiles/spike01/spike01_proj.bp', x, 1, z, x, 0, z)
    proj:SetVelocity(velocity)
    proj:SetLifetime(lifetime)
end

#################################################################################################################
# Ground Spikes I
# ProjectileLifetime is a key variable in insuring the ability goes the right distance.
# If the AffectRadius is adjusted, please adjust ProjectileLifetime as well.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenGroundSpikes01',
    DisplayName = '<LOC ABILITY_Queen_0020>Ground Spikes I',
    Description = '<LOC ABILITY_Queen_0021>Queen of Thorns radiates a forest of spikes around her, dealing [GetDamageAmt] damage and reducing armor by [GetArmorReduction] for [GetDuration] seconds.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 500,
    Cooldown = 7,
    UISlot = 1,
    HotKey = '1',
    CastingTime = 0.5,
    CastAction = 'GroundSpikes',
    FollowThroughTime = 1.5,
    AffectRadius = 15,
    DamageAmt = 250,
    ProjectileLifetime = 0.2,
    AbilityCategory = 'HQUEENUNPACKED',
    Icon = '/dgqueenofthorns/NewQueenGroundSpikes01',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetArmorReduction = function(self) return Buffs[self.Name].Affects.Armor.Add * -1 end,
    GetDuration = function(self) return Buffs[self.Name].Duration end,
    OnStartAbility = function(self, unit, params)
        ForkThread(GroundSpikes, unit, self)
    end,

}

BuffBlueprint {
    Name = 'HQueenGroundSpikes01',
    BuffType = 'HQUEENGROUNDSPIKEDEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0020>Ground Spikes I',
    Description = '<LOC ABILITY_Queen_0105>Armor reduced.',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Icon = '/dgqueenofthorns/NewQueenGroundSpikes01',
    Affects = {
        Armor = {Add = -375},
    },
}

#################################################################################################################
# Ground Spikes II
# ProjectileLifetime is a key variable in insuring the ability goes the right distance.
# If the AffectRadius is adjusted, please adjust ProjectileLifetime as well.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenGroundSpikes02',
    DisplayName = '<LOC ABILITY_Queen_0022>Ground Spikes II',
    Description = '<LOC ABILITY_Queen_0021>Queen of Thorns radiates a forest of spikes around her, dealing [GetDamageAmt] damage and reducing armor by [GetArmorReduction] for [GetDuration] seconds.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 500,
    Cooldown = 7,
    UISlot = 1,
    HotKey = '1',
    CastingTime = 0.5,
    CastAction = 'GroundSpikes',
    FollowThroughTime = 1.5,
    AffectRadius = 15,
    DamageAmt = 375,
    ProjectileLifetime = 0.2,
    AbilityCategory = 'HQUEENUNPACKED',
    Icon = '/dgqueenofthorns/NewQueenGroundSpikes01',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetArmorReduction = function(self) return Buffs[self.Name].Affects.Armor.Add * -1 end,
    GetDuration = function(self) return Buffs[self.Name].Duration end,
    OnStartAbility = function(self, unit, params)
        ForkThread(GroundSpikes, unit, self)
    end,

}

BuffBlueprint {
    Name = 'HQueenGroundSpikes02',
    BuffType = 'HQUEENGROUNDSPIKEDEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0022>Ground Spikes II',
    Description = '<LOC ABILITY_Queen_0105>Armor reduced.',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Icon = '/dgqueenofthorns/NewQueenGroundSpikes01',
    Affects = {
        Armor = {Add = -750},
    },
}

#################################################################################################################
# Ground Spikes III
# ProjectileLifetime is a key variable in insuring the ability goes the right distance.
# If the AffectRadius is adjusted, please adjust ProjectileLifetime as well.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenGroundSpikes03',
    DisplayName = '<LOC ABILITY_Queen_0024>Ground Spikes III',
    Description = '<LOC ABILITY_Queen_0021>Queen of Thorns radiates a forest of spikes around her, dealing [GetDamageAmt] damage and reducing armor by [GetArmorReduction] for [GetDuration] seconds.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 675,
    Cooldown = 7,
    UISlot = 1,
    HotKey = '1',
    CastingTime = 0.5,
    CastAction = 'GroundSpikes',
    FollowThroughTime = 1.5,
    AffectRadius = 15,
    DamageAmt = 500,
    ProjectileLifetime = 0.2,
    AbilityCategory = 'HQUEENUNPACKED',
    Icon = '/dgqueenofthorns/NewQueenGroundSpikes01',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetArmorReduction = function(self) return Buffs[self.Name].Affects.Armor.Add * -1 end,
    GetDuration = function(self) return Buffs[self.Name].Duration end,
    OnStartAbility = function(self, unit, params)
        ForkThread(GroundSpikes, unit, self)
    end,

}

BuffBlueprint {
    Name = 'HQueenGroundSpikes03',
    BuffType = 'HQUEENGROUNDSPIKEDEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0024>Ground Spikes III',
    Description = '<LOC ABILITY_Queen_0105>Armor reduced.',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Icon = '/dgqueenofthorns/NewQueenGroundSpikes01',
    Affects = {
        Armor = {Add = -1125},
    },
}

#################################################################################################################
# Ground Spikes IV
# ProjectileLifetime is a key variable in insuring the ability goes the right distance.
# If the AffectRadius is adjusted, please adjust ProjectileLifetime as well.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenGroundSpikes04',
    DisplayName = '<LOC ABILITY_Queen_0086>Ground Spikes IV',
    Description = '<LOC ABILITY_Queen_0021>Queen of Thorns radiates a forest of spikes around her, dealing [GetDamageAmt] damage and reducing armor by [GetArmorReduction] for [GetDuration] seconds.',
    AbilityType = 'Instant',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 750,
    Cooldown = 7,
    UISlot = 1,
    HotKey = '1',
    CastingTime = 0.5,
    CastAction = 'GroundSpikes',
    FollowThroughTime = 1.5,
    AffectRadius = 15,
    DamageAmt = 625,
    ProjectileLifetime = 0.2,
    AbilityCategory = 'HQUEENUNPACKED',
    Icon = '/dgqueenofthorns/NewQueenGroundSpikes01',
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetArmorReduction = function(self) return Buffs[self.Name].Affects.Armor.Add * -1 end,
    GetDuration = function(self) return Buffs[self.Name].Duration end,
    OnStartAbility = function(self, unit, params)
        ForkThread(GroundSpikes, unit, self)
        if Validate.HasAbility(unit, 'HQueenGoddessofThorns') then
            Buff.ApplyBuff(unit, 'HQueenGoddessofThornsQueen', unit)
        end
    end,

}

BuffBlueprint {
    Name = 'HQueenGroundSpikes04',
    BuffType = 'HQUEENGROUNDSPIKEDEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0086>Ground Spikes IV',
    Description = '<LOC ABILITY_Queen_0105>Armor reduced.',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Icon = '/dgqueenofthorns/NewQueenGroundSpikes01',
    Affects = {
        Armor = {Add = -1500},
    },
}

#################################################################################################################
# CE: Compost
#################################################################################################################
function CompostUnit(unit, killedunit)
    # Is Queen even alive? Delete her Compost count if she is.
    if unit.Dead then
        unit.AbilityData.Compost = 0
        return
    end
    # If CompostUnit is called on an OnKilled callback, it will have a killedunit, and Compost will increment.
    # Otherwise, it was called on the AuraPulse, and the counter will decrement.
    if Validate.HasAbility(unit,'HQueenCompost01') or Validate.HasAbility(unit,'HQueenCompost02') or Validate.HasAbility(unit,'HQueenCompost03') then
        if killedunit and unit.AbilityData.Compost < 9 then
            unit.AbilityData.Compost = unit.AbilityData.Compost + 1

            # Create trigger effects on killed unit
            local endPos = table.copy(killedunit:GetPosition())
            local startPos = table.copy(unit:GetPosition())
            FxCompost01(startPos,endPos)

        elseif unit.AbilityData.Compost > 0 then
            unit.AbilityData.Compost = unit.AbilityData.Compost - 1
        end
        # For every 3 deaths, queen receives a buff.
        local killspercompostlevel = 3
        local CompostRank = unit.AbilityData.CompostRank
        local CompostLevel = math.floor((unit.AbilityData.Compost + 1) / killspercompostlevel)
        if CompostLevel > 0 and CompostLevel < 3 then
            Buff.ApplyBuff(unit, 'HQueenCompostPowerBuff0' .. CompostLevel + CompostRank, unit)
            unit:GetAIBrain():AddArmyBonus( 'HQueenCompostPowerBuffMinion0' .. CompostLevel + CompostRank, unit)
        elseif CompostLevel >= 3 then
            Buff.ApplyBuff(unit, 'HQueenCompostPowerBuff0'.. 3 + CompostRank , unit)
            unit:GetAIBrain():AddArmyBonus( 'HQueenCompostPowerBuffMinion03', unit)
        else
            if Buff.HasBuff(unit,'HQueenCompostPowerBuff01') then
                Buff.RemoveBuff(unit, 'HQueenCompostPowerBuff01')
                unit:GetAIBrain():RemoveArmyBonus('HQueenCompostPowerBuffMinion01')
            end
            if Buff.HasBuff(unit,'HQueenCompostPowerBuff02') then
                Buff.RemoveBuff(unit, 'HQueenCompostPowerBuff02')
                unit:GetAIBrain():RemoveArmyBonus('HQueenCompostPowerBuffMinion02')
            end
            if Buff.HasBuff(unit,'HQueenCompostPowerBuff03') then
                Buff.RemoveBuff(unit, 'HQueenCompostPowerBuff03')
                unit:GetAIBrain():RemoveArmyBonus('HQueenCompostPowerBuffMinion03')
            end
            if Buff.HasBuff(unit,'HQueenCompostPowerBuff04') then
                Buff.RemoveBuff(unit, 'HQueenCompostPowerBuff04')
                unit:GetAIBrain():RemoveArmyBonus('HQueenCompostPowerBuffMinion04')
            end
        end
    end
end

#################################################################################################################
# Buff: Queen Compost I
# Uproot Bonus is damage inflicted by every tick of Uproot.
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenCompostPowerBuff01',
    BuffType = 'HQUEENCOMPOSTQUEENBUFF',
    DisplayName = '<LOC ABILITY_Queen_0026>Compost',
    Description = '<LOC ABILITY_Queen_0073>Shambler Weapon Damage and Health increased. Uproot damage increased.',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/dgqueenofthorns/NewQueenCompost01_01',
    Affects = {
        Dummy = {Add = 0.1},
    },
    OnBuffAffect = function(self, unit, instigator)
        unit.AbilityData.UprootBonus = 20
    end,
    OnBuffRemove = function(self, unit )
        unit.AbilityData.UprootBonus = 0
    end,
}

ArmyBonusBlueprint {
    Name = 'HQueenCompostPowerBuffMinion01',
    ApplyArmies = 'Single',
    UnitCategory = 'ENT',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenCompostPowerBuffMinion01',
            BuffType = 'COMPOSTMINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'ENT',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 4},
                MaxHealth = {Add = 60, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Buff: Queen Compost II
# Uproot Bonus is damage inflicted by every tick of Uproot.
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenCompostPowerBuff02',
    BuffType = 'HQUEENCOMPOSTQUEENBUFF',
    DisplayName = '<LOC ABILITY_Queen_0070>Compost',
    Description = '<LOC ABILITY_Queen_0073>Shambler Weapon Damage and Health increased. Uproot damage increased.',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/dgqueenofthorns/NewQueenCompost01_02',
    Affects = {
        Dummy = {Add = 0.1},
    },
    OnBuffAffect = function(self, unit, instigator)
        unit.AbilityData.UprootBonus = 40
    end,
    OnBuffRemove = function(self, unit )
        unit.AbilityData.UprootBonus = 0
    end,
}

ArmyBonusBlueprint {
    Name = 'HQueenCompostPowerBuffMinion02',
    ApplyArmies = 'Single',
    UnitCategory = 'ENT',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenCompostPowerBuffMinion02',
            BuffType = 'COMPOSTMINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'ENT',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 6},
                MaxHealth = {Add = 120, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Buff: Queen Compost III
# Uproot Bonus is damage inflicted by every tick of Uproot.
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenCompostPowerBuff03',
    BuffType = 'HQUEENCOMPOSTQUEENBUFF',
    DisplayName = '<LOC ABILITY_Queen_0072>Compost',
    Description = '<LOC ABILITY_Queen_0073>Shambler Weapon Damage and Health increased. Uproot damage increased.',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/dgqueenofthorns/NewQueenCompost01_03',
    Affects = {
        Dummy = {Add = 0.1},
    },
    OnBuffAffect = function(self, unit, instigator)
        unit.AbilityData.UprootBonus = 60
    end,
    OnBuffRemove = function(self, unit )
        unit.AbilityData.UprootBonus = 0
    end,
}

ArmyBonusBlueprint {
    Name = 'HQueenCompostPowerBuffMinion03',
    ApplyArmies = 'Single',
    UnitCategory = 'ENT',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenCompostPowerBuffMinion03',
            BuffType = 'COMPOSTMINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'ENT',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 8},
                MaxHealth = {Add = 180, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Buff: Queen Compost IV
# Uproot Bonus is damage inflicted by every tick of Uproot.
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenCompostPowerBuff04',
    BuffType = 'HQUEENCOMPOSTQUEENBUFF',
    DisplayName = '<LOC ABILITY_Queen_0072>Compost',
    Description = '<LOC ABILITY_Queen_0073>Shambler Weapon Damage and Health increased. Uproot damage increased.',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/dgqueenofthorns/NewQueenCompost01_03',
    Affects = {
        Dummy = {Add = 0.1},
    },
    OnBuffAffect = function(self, unit, instigator)
        unit.AbilityData.UprootBonus = 80
    end,
    OnBuffRemove = function(self, unit )
        unit.AbilityData.UprootBonus = 0
    end,
}

ArmyBonusBlueprint {
    Name = 'HQueenCompostPowerBuffMinion04',
    ApplyArmies = 'Single',
    UnitCategory = 'ENT',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenCompostPowerBuffMinion04',
            BuffType = 'COMPOSTMINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'ENT',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 10},
                MaxHealth = {Add = 240, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Buff: Queen Compost V
# Uproot Bonus is damage inflicted by every tick of Uproot.
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenCompostPowerBuff05',
    BuffType = 'HQUEENCOMPOSTQUEENBUFF',
    DisplayName = '<LOC ABILITY_Queen_0072>Compost',
    Description = '<LOC ABILITY_Queen_0073>Shambler Weapon Damage and Health increased. Uproot damage increased.',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/dgqueenofthorns/NewQueenCompost01_03',
    Affects = {
        Dummy = {Add = 0.1},
    },
    OnBuffAffect = function(self, unit, instigator)
        unit.AbilityData.UprootBonus = 100
    end,
    OnBuffRemove = function(self, unit )
        unit.AbilityData.UprootBonus = 0
    end,
}

ArmyBonusBlueprint {
    Name = 'HQueenCompostPowerBuffMinion05',
    ApplyArmies = 'Single',
    UnitCategory = 'ENT',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenCompostPowerBuffMinion05',
            BuffType = 'COMPOSTMINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'ENT',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 12},
                MaxHealth = {Add = 300, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# Buff: Queen Compost IV
# Uproot Bonus is damage inflicted by every tick of Uproot.
#################################################################################################################
BuffBlueprint {
    Name = 'HQueenCompostPowerBuff06',
    BuffType = 'HQUEENCOMPOSTQUEENBUFF',
    DisplayName = '<LOC ABILITY_Queen_0072>Compost',
    Description = '<LOC ABILITY_Queen_0073>Shambler Weapon Damage and Health increased. Uproot damage increased.',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = -1,
    Icon = '/dgqueenofthorns/NewQueenCompost01_03',
    Affects = {
        Dummy = {Add = 0.1},
    },
    OnBuffAffect = function(self, unit, instigator)
        unit.AbilityData.UprootBonus = 120
    end,
    OnBuffRemove = function(self, unit )
        unit.AbilityData.UprootBonus = 0
    end,
}

ArmyBonusBlueprint {
    Name = 'HQueenCompostPowerBuffMinion06',
    ApplyArmies = 'Single',
    UnitCategory = 'ENT',
    RemoveOnUnitDeath = true,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenCompostPowerBuffMinion06',
            BuffType = 'COMPOSTMINION',
            Debuff = false,
            Stacks = 'REPLACE',
            EntityCategory = 'ENT',
            Duration = -1,
            Affects = {
                DamageRating = {Add = 14},
                MaxHealth = {Add = 360, AdjustHealth = true},
            },
        }
    }
}

#################################################################################################################
# VFX
# Compost
#################################################################################################################

function FxCompost01(startPos, endPos)
    local dir = VDiff(startPos, endPos)
    local dist = VLength( dir )
    dir = VNormal(dir)

    # ground dirt, velocity aligned dirt in air
    for k, v in EffectTemplates.Queenofthorns.Compost01 do
        local emit = CreateEmitterPositionVector(endPos, dir, -1, v)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist * 0.5, 0.0)
    end

    # dark wisps
    for k, v in EffectTemplates.Queenofthorns.Compost02 do
        local emit = CreateEmitterPositionVector(endPos, dir, -1, v)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist * 0.75, 0.0)
    end

    # leaves
    for k, v in EffectTemplates.Queenofthorns.Compost03 do
        local emit = CreateEmitterPositionVector(endPos, dir, -1, v)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist * 1.0, 0.0)
    end
end

function FxCompostAura01( self, unit )
    # Temp compost feedback effects
    AttachEffectAtBone( unit, 'Queenofthorns', 'Compost01', -2 )
end

function _FxCompostAura01( unit, trash, segments, radius )
    local pos = table.copy(unit:GetPosition())
    local army = unit:GetArmy()
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
            local fx = CreateCharacterEffectsAtPos( unit, 'queen_unpacked', 'GraspingTendrilAura0' .. Random(1, 3), Vector(pos[1] + x,pos[2],pos[3]+z), nil, trash )

            for k, v in fx do
                unit.TrashOnKilled:Add(v)
            end
        end
    end
end

#################################################################################################################
# Compost I
# Contains enemy buff for Compost
# This aura calls CompostUnit every pulse. Adjust AuraPulseTime to alter the decay rate of Compost kills.
# Be mindful that this will likely involve adjusting the buff's duration as well.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenCompost01',
    Description = '<LOC ABILITY_Queen_0048>As nearby enemies die, their bodies nourish Queen of Thorns. For every 3 enemies killed, Uproot increases in damage. Her Shamblers gain Weapon Damage and Health. The effects cap at 9 enemies killed, and the effects diminish over time.',
    DisplayName = '<LOC ABILITY_Queen_0049>Compost I',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 1,
    DecayTime = 7,
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenCompostBuff01',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Queen_0074>Compost',
            Description = '<LOC ABILITY_Queen_0075>Will be composted if killed.',
            BuffType = 'HQUEENCOMPOSTENEMYDEBUFF',
            Stacks = 'REPLACE',
            Duration = 1,
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnKilled:Add(CompostUnit, instigator)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(CompostUnit)
            end,
        }
    },
    CreateAbilityAmbients = function( self, unit )
        # temp fx
        #FxCompostAura01 ( self, unit )
    end,
    OnAbilityAdded = function(self, unit)
        if not unit.AbilityData.Compost then
            unit.AbilityData.Compost = 0
        end
        if not unit.AbilityData.CompostTick then
            unit.AbilityData.CompostTick = 0
        end
        unit.AbilityData.CompostDecay = self.DecayTime
        unit.AbilityData.CompostRank = 0
    end,
    OnAuraPulse = function(self, unit)
        unit.AbilityData.CompostTick = unit.AbilityData.CompostTick + 1
        if unit.AbilityData.CompostTick > unit.AbilityData.CompostDecay then
            CompostUnit(unit)
            unit.AbilityData.CompostTick = 0
        end
    end,
}

#################################################################################################################
# Compost II
# Contains enemy buff for Compost
# This aura calls CompostUnit every pulse. Adjust AuraPulseTime to alter the decay rate of Compost kills.
# Be mindful that this will likely involve adjusting the buff's duration as well.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenCompost02',
    Description = '<LOC ABILITY_Queen_0048>As nearby enemies die, their bodies nourish Queen of Thorns. For every 3 enemies killed, Uproot increases in damage. Her Shamblers gain Weapon Damage and Health. The effects cap at 9 enemies killed, and the effects diminish over time.',
    DisplayName = '<LOC ABILITY_Queen_0082>Compost II',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 1,
    DecayTime = 7,
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenCompostBuff02',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Queen_0074>Compost',
            Description = '<LOC ABILITY_Queen_0075>Will be composted if killed.',
            BuffType = 'HQUEENCOMPOSTENEMYDEBUFF',
            Stacks = 'REPLACE',
            Duration = 1,
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnKilled:Add(CompostUnit, instigator)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(CompostUnit)
            end,
        }
    },
    CreateAbilityAmbients = function( self, unit )
        # temp fx
        #FxCompostAura01 ( self, unit )
    end,
    OnAbilityAdded = function(self, unit)
        if not unit.AbilityData.Compost then
            unit.AbilityData.Compost = 0
        end
        if not unit.AbilityData.CompostTick then
            unit.AbilityData.CompostTick = 0
        end
        unit.AbilityData.CompostDecay = self.DecayTime
        unit.AbilityData.CompostRank = 1
    end,
    OnAuraPulse = function(self, unit)
        unit.AbilityData.CompostTick = unit.AbilityData.CompostTick + 1
        if unit.AbilityData.CompostTick > unit.AbilityData.CompostDecay then
            CompostUnit(unit)
            unit.AbilityData.CompostTick = 0
        end
    end,
}

#################################################################################################################
# Compost III
# Contains enemy buff for Compost
# This aura calls CompostUnit every pulse. Adjust AuraPulseTime to alter the decay rate of Compost kills.
# Be mindful that this will likely involve adjusting the buff's duration as well.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenCompost03',
    Description = '<LOC ABILITY_Queen_0048>As nearby enemies die, their bodies nourish Queen of Thorns. For every 3 enemies killed, Uproot increases in damage. Her Shamblers gain Weapon Damage and Health. The effects cap at 9 enemies killed, and the effects diminish over time.',
    DisplayName = '<LOC ABILITY_Queen_0083>Compost III',
    AbilityType = 'Aura',
    AffectRadius = 20,
    AuraPulseTime = 1,
    DecayTime = 7,
    TargetAlliance = 'Enemy',
    TargetCategory = 'MOBILE - UNTARGETABLE',
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenCompostBuff03',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Queen_0074>Compost',
            Description = '<LOC ABILITY_Queen_0075>Will be composted if killed.',
            BuffType = 'HQUEENCOMPOSTENEMYDEBUFF',
            Stacks = 'REPLACE',
            Duration = 1,
            OnBuffAffect = function(self, unit, instigator)
                unit.Callbacks.OnKilled:Add(CompostUnit, instigator)
            end,
            OnBuffRemove = function(self, unit)
                unit.Callbacks.OnKilled:Remove(CompostUnit)
            end,
        }
    },
    CreateAbilityAmbients = function( self, unit )
        # temp fx
        #FxCompostAura01 ( self, unit )
    end,
    OnAbilityAdded = function(self, unit)
        if not unit.AbilityData.Compost then
            unit.AbilityData.Compost = 0
        end
        if not unit.AbilityData.CompostTick then
            unit.AbilityData.CompostTick = 0
        end
        unit.AbilityData.CompostDecay = self.DecayTime
        unit.AbilityData.CompostRank = 2
    end,
    OnAuraPulse = function(self, unit)
        unit.AbilityData.CompostTick = unit.AbilityData.CompostTick + 1
        if unit.AbilityData.CompostTick > unit.AbilityData.CompostDecay then
            CompostUnit(unit)
            unit.AbilityData.CompostTick = 0
        end
    end,
}

#################################################################################################################
# CE: Spike Wave
#################################################################################################################
function SpikeWave(abil, unit, params)
    local instigatorBp = unit:GetBlueprint()
    local instigatorArmy = unit:GetArmy()
    local direction = VNormal(params.Target.Position - unit:GetPosition())
    local projectileData = {
        data = {
            Instigator = unit,
            InstigatorBp = instigatorBp,
            InstigatorArmy = instigatorArmy,
            Amount = abil.DamageAmt,
            Type = abil.DamageType,
            DamageAction = abil.Name,
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
        },
        direction = direction,
        range = abil.RangeMax,
    }
    local proj = unit:CreateProjectile('/projectiles/Spike03/Spike03_proj.bp', 0, 1, 0, direction[1], 0, direction[3])
    proj:SetVelocity(27)
    proj:PassData(projectileData)
end

#################################################################################################################
# Spike Wave I
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenSpikeWave01',
    DisplayName = '<LOC ABILITY_Queen_0028>Spike Wave I',
    Description = '<LOC ABILITY_Queen_0029>Queen of Thorns sends out a powerful wave of spikes, dealing [GetDamageAmt] damage to anyone skewered and slowing enemies by [GetSlowAmount]% for [GetDuration] seconds.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 750,
    RangeMax = 20,
    Cooldown = 10,
    DamageAmt = 350,
    DamageType = 'Spell',
    AffectRadius = 5,
    UISlot = 2,
    HotKey = '2',
    AbilityCategory = 'HQUEENUNPACKED',
    CastingTime = 0.4,
    CastAction = 'SpikeWave',
    FollowThroughTime = 1.0,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetSlowAmount = function(self) return math.floor( Buffs['HQueenSpikeWave01'].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return ( Buffs['HQueenSpikeWave01'].Duration ) end,
    OnStartAbility = function(self, unit, params)
        SpikeWave( self, unit, params)
    end,
    Icon = '/dgqueenofthorns/NewQueenSpikeWave01',
    Reticule = 'AoE_Spike_Wave',
}

BuffBlueprint {
    Name = 'HQueenSpikeWave01',
    BuffType = 'HQUEENSPIKEWAVEDEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0028>Spike Wave I',
    Description = '<LOC ABILITY_HGSA01_0014>Movement Speed reduced.',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Icon = '/dgqueenofthorns/NewQueenSpikeWave01',
    Affects = {
        MoveMult = {Mult = -0.15},
    },
    Effects = 'Slow03',
}

#################################################################################################################
# Spike Wave II
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenSpikeWave02',
    DisplayName = '<LOC ABILITY_Queen_0030>Spike Wave II',
    Description = '<LOC ABILITY_Queen_0029>Queen of Thorns sends out a powerful wave of spikes, dealing [GetDamageAmt] damage to anyone skewered and slowing enemies by [GetSlowAmount]% for [GetDuration] seconds.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 1000,
    RangeMax = 25,
    Cooldown = 10,
    DamageAmt = 500,
    DamageType = 'Spell',
    AffectRadius = 5,
    UISlot = 2,
    HotKey = '2',
    AbilityCategory = 'HQUEENUNPACKED',
    CastingTime = 0.4,
    CastAction = 'SpikeWave',
    FollowThroughTime = 1.0,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetSlowAmount = function(self) return math.floor( Buffs['HQueenSpikeWave02'].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return ( Buffs['HQueenSpikeWave02'].Duration ) end,
    OnStartAbility = function(self, unit, params)
        SpikeWave( self, unit, params)
    end,
    Icon = '/dgqueenofthorns/NewQueenSpikeWave01',
    Reticule = 'AoE_Spike_Wave',
}

BuffBlueprint {
    Name = 'HQueenSpikeWave02',
    BuffType = 'HQUEENSPIKEWAVEDEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0030>Spike Wave II',
    Description = '<LOC ABILITY_HGSA01_0014>Movement Speed reduced.',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Icon = '/dgqueenofthorns/NewQueenSpikeWave01',
    Affects = {
        MoveMult = {Mult = -0.2},
    },
    Effects = 'Slow03',
}

#################################################################################################################
# Spike Wave III
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenSpikeWave03',
    DisplayName = '<LOC ABILITY_Queen_0052>Spike Wave III',
    Description = '<LOC ABILITY_Queen_0029>Queen of Thorns sends out a powerful wave of spikes, dealing [GetDamageAmt] damage to anyone skewered and slowing enemies by [GetSlowAmount]% for [GetDuration] seconds.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    EnergyCost = 1250,
    RangeMax = 30,
    Cooldown = 15,
    DamageAmt = 650,
    DamageType = 'Spell',
    AffectRadius = 5,
    UISlot = 2,
    HotKey = '2',
    AbilityCategory = 'HQUEENUNPACKED',
    CastingTime = 0.4,
    CastAction = 'SpikeWave',
    FollowThroughTime = 1.0,
    GetDamageAmt = function(self) return math.floor( self.DamageAmt ) end,
    GetSlowAmount = function(self) return math.floor( Buffs['HQueenSpikeWave03'].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return ( Buffs['HQueenSpikeWave03'].Duration ) end,
    OnStartAbility = function(self, unit, params)
        SpikeWave( self, unit, params)
    end,
    Icon = '/dgqueenofthorns/NewQueenSpikeWave01',
    Reticule = 'AoE_Spike_Wave',
}

BuffBlueprint {
    Name = 'HQueenSpikeWave03',
    BuffType = 'HQUEENSPIKEWAVEDEBUFF',
    DisplayName = '<LOC ABILITY_Queen_0052>Spike Wave III',
    Description = '<LOC ABILITY_HGSA01_0014>Movement Speed reduced.',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    Duration = 5,
    Icon = '/dgqueenofthorns/NewQueenSpikeWave01',
    Affects = {
        MoveMult = {Mult = -0.25},
    },
    Effects = 'Slow03',
}

#################################################################################################################
# Bramble Shield I
# Absorption affects should always use the ABSORB bufftype, to prevent stacking with any other Absorption.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenBrambleShield01',
    DisplayName = '<LOC ABILITY_Queen_0032>Bramble Shield I',
    Description = '<LOC ABILITY_Queen_0037>Thorns form a shield around an allied unit, absorbing [GetAbsorbAmt] damage.\nOnly one absorption effect per unit may be active at a time.',
    AbilityType = 'TargetedUnit',
    EnergyCost = 400,
    Cooldown = 7,
    RangeMax = 20,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'Shield',
    FollowThroughTime = 1.5,
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    AbilityCategory = 'HQUEENPACKED',
    Icon = '/dgqueenofthorns/NewQueenBrambleShield01',
    GetAbsorbAmt = function(self) return math.floor( Buffs['HQueenBrambleShield01'].Affects.Absorption.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenBrambleShield01',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Queen_0034>Bramble Shield',
            Description = '<LOC ABILITY_Queen_0035>Protected from damage.',
            BuffType = 'ABSORB',
            Stacks = 'REPLACE',
            Icon = '/dgqueenofthorns/NewQueenBrambleShield01',
            Duration = 30,
            Affects = {
                Absorption = { Add = 700 },
            },
            SoundLoop = 'Forge/DEMIGODS/QueenOfThorns/snd_dg_qothorns_brambleshield',
            Effects = 'Bramble01',
        }
    },
}

#################################################################################################################
# Bramble Shield II
# Absorption affects should always use the ABSORB bufftype, to prevent stacking with any other Absorption.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenBrambleShield02',
    DisplayName = '<LOC ABILITY_Queen_0036>Bramble Shield II',
    Description = '<LOC ABILITY_Queen_0037>Thorns form a shield around an allied unit, absorbing [GetAbsorbAmt] damage.\nOnly one absorption effect per unit may be active at a time.',
    AbilityType = 'TargetedUnit',
    EnergyCost = 560,
    Cooldown = 7,
    RangeMax = 20,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'Shield',
    FollowThroughTime = 1.5,
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    AbilityCategory = 'HQUEENPACKED',
    Icon = '/dgqueenofthorns/NewQueenBrambleShield01',
    GetAbsorbAmt = function(self) return math.floor( Buffs['HQueenBrambleShield02'].Affects.Absorption.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenBrambleShield02',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Queen_0076>Bramble Shield',
            Description = '<LOC ABILITY_Queen_0077>Protected from damage.',
            BuffType = 'ABSORB',
            Stacks = 'REPLACE',
            Icon = '/dgqueenofthorns/NewQueenBrambleShield01',
            Duration = 30,
            Affects = {
                Absorption = { Add = 950 },
            },
            SoundLoop = 'Forge/DEMIGODS/QueenOfThorns/snd_dg_qothorns_brambleshield',
            Effects = 'Bramble01',
        }
    },
}

#################################################################################################################
# Bramble Shield III
# Absorption affects should always use the ABSORB bufftype, to prevent stacking with any other Absorption.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenBrambleShield03',
    DisplayName = '<LOC ABILITY_Queen_0038>Bramble Shield III',
    Description = '<LOC ABILITY_Queen_0037>Thorns form a shield around an allied unit, absorbing [GetAbsorbAmt] damage.\nOnly one absorption effect per unit may be active at a time.',
    AbilityType = 'TargetedUnit',
    EnergyCost = 720,
    Cooldown = 7,
    RangeMax = 20,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'Shield',
    FollowThroughTime = 1.5,
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    AbilityCategory = 'HQUEENPACKED',
    Icon = '/dgqueenofthorns/NewQueenBrambleShield01',
    GetAbsorbAmt = function(self) return math.floor( Buffs['HQueenBrambleShield03'].Affects.Absorption.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenBrambleShield03',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Queen_0078>Bramble Shield',
            Description = '<LOC ABILITY_Queen_0079>Protected from damage.',
            BuffType = 'ABSORB',
            Stacks = 'REPLACE',
            Icon = '/dgqueenofthorns/NewQueenBrambleShield01',
            Duration = 30,
            Affects = {
                Absorption = { Add = 1200 },
            },
            SoundLoop = 'Forge/DEMIGODS/QueenOfThorns/snd_dg_qothorns_brambleshield',
            Effects = 'Bramble01',
        }
    },
}

#################################################################################################################
# Bramble Shield IV
# Absorption affects should always use the ABSORB bufftype, to prevent stacking with any other Absorption.
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenBrambleShield04',
    DisplayName = '<LOC ABILITY_Queen_0087>Bramble Shield IV',
    Description = '<LOC ABILITY_Queen_0037>Thorns form a shield around an allied unit, absorbing [GetAbsorbAmt] damage.\nOnly one absorption effect per unit may be active at a time.',
    AbilityType = 'TargetedUnit',
    EnergyCost = 840,
    Cooldown = 7,
    RangeMax = 20,
    UISlot = 3,
    HotKey = '3',
    CastAction = 'Shield',
    FollowThroughTime = 1.5,
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'ALLYMOBILE',
    AbilityCategory = 'HQUEENPACKED',
    Icon = '/dgqueenofthorns/NewQueenBrambleShield01',
    GetAbsorbAmt = function(self) return math.floor( Buffs['HQueenBrambleShield04'].Affects.Absorption.Add ) end,
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenBrambleShield04',
            Debuff = false,
            DisplayName = '<LOC ABILITY_Queen_0078>Bramble Shield',
            Description = '<LOC ABILITY_Queen_0079>Protected from damage.',
            BuffType = 'ABSORB',
            Stacks = 'REPLACE',
            Icon = '/dgqueenofthorns/NewQueenBrambleShield01',
            Duration = 30,
            Affects = {
                Absorption = { Add = 1450 },
            },
            SoundLoop = 'Forge/DEMIGODS/QueenOfThorns/snd_dg_qothorns_brambleshield',
            Effects = 'Bramble01',
        }
    },
    OnStartAbility = function(self, unit, params)
        if Validate.HasAbility(unit, 'HQueenGoddessofThorns') then
            unit:GetAIBrain():AddArmyBonus( 'HQueenGoddessofThornsArmy', self )
        end
    end,
}

#################################################################################################################
# Goddess of Thorns
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenGoddessofThorns',
    DisplayName = '<LOC ABILITY_Queen_0094>Goddess of Thorns',
    Description = '<LOC ABILITY_Queen_0095>Queen of Thorns gains further mastery over nature. When she uses Ground Spikes, thorns encircle her, reducing damage taken by [GetReduction]% for [GetDuration] seconds. Whenever she uses Bramble Shield, thorns encircle her and her army, dealing [GetThorns] damage to attackers for [GetDurationThorns] seconds.',
    AbilityType = 'Quiet',
    GetReduction = function(self) return math.floor( Buffs['HQueenGoddessofThornsQueen'].Affects.DamageTakenMult.Add * -100 ) end,
    GetDuration = function(self) return math.floor( Buffs['HQueenGoddessofThornsQueen'].Duration ) end,
    GetThorns = function(self) return math.floor( Buffs['HQueenGoddessofThornsArmy'].Affects.DamageReturn.Add ) end,
    GetDurationThorns = function(self) return math.floor( Buffs['HQueenGoddessofThornsArmy'].Duration ) end,
}

BuffBlueprint {
    Name = 'HQueenGoddessofThornsQueen',
    DisplayName = '<LOC ABILITY_Queen_0096>Goddess of Thorns',
    Description = '<LOC ABILITY_Queen_0097>Damage taken reduced.',
    BuffType = 'HQUEENGODDESSQUEEN',
    Debuff = false,
    Stacks = 'REPLACE',
    Duration = 10,
    Affects = {
        DamageTakenMult = {Add = -0.15},
    },
    Icon = '/dgqueenofthorns/NewQueenGoddessofThorns01',
}

ArmyBonusBlueprint {
    Name = 'HQueenGoddessofThornsArmy',
    DisplayName = '<LOC ABILITY_Queen_0098>Goddess of Thorns',
    Description = '<LOC ABILITY_Queen_0099>Dealing damage to attackers.',
    ApplyArmies = 'Single',
    Buffs = {
        BuffBlueprint {
            Name = 'HQueenGoddessofThornsArmy',
            DisplayName = '<LOC ABILITY_Queen_0100>Goddess of Thorns',
            Description = '<LOC ABILITY_Queen_0101>Dealing damage to attackers.',
            BuffType = 'HQUEENGODDESSARMY',
            Debuff = false,
            Stacks = 'REPLACE',
            Duration = 20,
            Icon = '/dgqueenofthorns/NewQueenGoddessofThorns01',
            Affects = {
                DamageReturn = {Add = 35},
            },
        }
    }
}

#################################################################################################################
# Epic Death
#################################################################################################################

function FxEpicDeathAura01( unit, segments, radius )
    local pos = table.copy(unit:GetPosition())
    local army = unit:GetArmy()
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
            CreateCharacterEffectsAtPos( unit, 'queen_unpacked', 'GraspingTendrilAura0' .. Random(1, 3), Vector(pos[1] + x,pos[2],pos[3]+z) )
        end
    end
end

QueenDeath = function( unit, abil )
    #unit:DestroyAmbientEffects()

    # Warmup/vines effects
    AttachEffectsAtBone( unit, EffectTemplates.Queenofthorns.EpicDeath01, -2 )

    WaitSeconds(2)
    # Leftover aura, AoE debuff effects
    FxEpicDeathAura01 ( unit, 11, 8 )
    FxEpicDeathAura01 ( unit, 6, 4 )

    WaitSeconds(1)
    # Impact effects
    AttachEffectsAtBone( unit, EffectTemplates.Queenofthorns.EpicDeath02, -2 )

    # Apply debuffs to enemy entities nearby
    local entities = GetEntitiesInSphere("UNITS", table.copy(unit:GetPosition()), abil.AffectRadius)

    for k,entity in entities do
        if IsEnemy(unit:GetArmy(),entity:GetArmy()) and not entity:IsDead() and not EntityCategoryContains(categories.NOBUFFS, entity) and not EntityCategoryContains(categories.UNTARGETABLE, entity) then
            Buff.ApplyBuff(entity, abil.EnemyDeathDebuff01, unit, unit:GetArmy())
            Buff.ApplyBuff(entity, abil.EnemyDeathDebuff02, unit, unit:GetArmy())
        end
    end
end

BuffBlueprint {
    Name = 'HQueenDeathDebuff01',
    Debuff = true,
    CanBeDispelled = true,
    DisplayName = '<LOC ABILITY_Queen_0040>Ensnared',
    Description = '<LOC ABILITY_Queen_0041>Movement Speed reduced, taking damage over time.',
    BuffType = 'HQQUEENDEATHDEBUFF01',
    Stacks = 'ALWAYS',
    Duration = 5,
    ArmorImmune = true,
    CanCrit = false,
    CanBackfire = false,
    IgnoreDamageRangePercent = true,
    EntityCategory = 'MOBILE -UNTARGETABLE',
    Affects = {
        MoveMult = {Mult = -0.25},
    },
    Icon = '/dgqueenofthorns/NewQueenCompost01',

    # Temp buff effect for this event
    Effects = 'Slow02',
    EffectsBone = -2,
}

BuffBlueprint {
    Name = 'HQueenDeathDebuff02',
    DisplayName = '<LOC ABILITY_Queen_0080>Ensnared DoT',
    Description = '<LOC ABILITY_Queen_0081>Taking damage over time',
    BuffType = 'HQQUEENDEATHDEBUFF02',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'ALWAYS',
    DamageSelf = true,
    Duration = 10,
    DurationPulse = 10,
    ArmorImmune = true,
    CanCrit = false,
    CanBackfire = false,
    IgnoreDamageRangePercent = true,
    EntityCategory = 'MOBILE -UNTARGETABLE',
    Affects = {
        Health = {Add = -10},
    },
}


AbilityBlueprint {
    Name = 'HQueenDeath01',
    DisplayName = 'Death',
    Description = 'Queen of Thorns death functional ability',
    AbilityType = 'Quiet',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    NoCastAnim = true,
    AffectRadius = 10,
    EnemyDeathDebuff01 = 'HQueenDeathDebuff01',
    EnemyDeathDebuff02 = 'HQueenDeathDebuff02',
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnKilled:Add(self.Death, self)
    end,
    Death = function(self, unit)
        unit:ForkThread(QueenDeath, self)
    end,
}

#################################################################################################################
# Grey Abilities
#################################################################################################################
AbilityBlueprint {
    Name = 'HQueenShamblerGrey01',
    DisplayName = '<LOC ABILITY_Queen_0004>Summon Shambler I',
    Description = '<LOC ABILITY_Queen_0005>Queen of Thorns summons [GetShamblersSummoned] Shamblers from her thorns to protect her. She may have [GetMaxShamblers] Shamblers active.',
    AbilityType = 'Passive',
    AbilityCategory = 'HQUEENPACKED',
    TargetAlliance = 'Ally',
    UISlot = 1,
    HotKey = '1',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HQueenShambler01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HQueenShambler01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HQueenShambler01'].CastingTime end,
    GetCooldown = function(self) return Ability['HQueenShambler01'].Cooldown end,
    GetShamblersSummoned = function(self) return math.floor( Ability['HQueenShambler01'].NumShamblers ) end,
    GetMaxShamblers = function(self) return math.floor( Ability['HQueenShambler01'].MaxShamblers ) end,
    Icon = '/dgqueenofthorns/NewQueenSummonShambler01',
}

AbilityBlueprint {
    Name = 'HQueenBrambleShieldGrey01',
    DisplayName = '<LOC ABILITY_Queen_0032>Bramble Shield I',
    Description = '<LOC ABILITY_Queen_0037>Thorns form a shield around an allied unit, absorbing [GetAbsorbAmt] damage.\nOnly one absorption effect per unit may be active at a time.',
    AbilityType = 'Passive',
    AbilityCategory = 'HQUEENPACKED',
    TargetAlliance = 'Ally',
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HQueenBrambleShield01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HQueenBrambleShield01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HQueenBrambleShield01'].CastingTime end,
    GetCooldown = function(self) return Ability['HQueenBrambleShield01'].Cooldown end,
    GetAbsorbAmt = function(self) return math.floor( Buffs['HQueenBrambleShield01'].Affects.Absorption.Add ) end,
    Icon = '/dgqueenofthorns/NewQueenBrambleShield01',
}

AbilityBlueprint {
    Name = 'HQueenSpikeWaveGrey01',
    DisplayName = '<LOC ABILITY_Queen_0028>Spike Wave I',
    Description = '<LOC ABILITY_Queen_0029>Queen of Thorns sends out a powerful wave of spikes, dealing [GetDamageAmt] damage to anyone skewered and slowing enemies by [GetSlowAmount]% for [GetDuration] seconds.',
    AbilityType = 'Passive',
    AbilityCategory = 'HQUEENUNPACKED',
    TargetAlliance = 'Enemy',
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HQueenSpikeWave01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HQueenSpikeWave01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HQueenSpikeWave01'].CastingTime end,
    GetCooldown = function(self) return Ability['HQueenSpikeWave01'].Cooldown end,
    GetDamageAmt = function(self) return math.floor( Ability['HQueenSpikeWave01'].DamageAmt ) end,
    GetSlowAmount = function(self) return math.floor( Buffs['HQueenSpikeWave01'].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return ( Buffs['HQueenSpikeWave01'].Duration ) end,
    Icon = '/dgqueenofthorns/NewQueenSpikeWave01',
}

AbilityBlueprint {
    Name = 'HQueenConsumeShamblerGrey01',
    DisplayName = '<LOC ABILITY_Queen_0010>Mulch Shambler I',
    Description = '<LOC ABILITY_Queen_0013>Queen of Thorns absorbs an allied Shambler, killing it and restoring [GetHealthRestored] Health. Enemies near the Shambler take [GetDamage] damage.',
    AbilityType = 'Passive',
    AbilityCategory = 'HQUEENPACKED',
    TargetAlliance = 'Ally',
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HQueenConsumeShambler01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HQueenConsumeShambler01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HQueenConsumeShambler01'].CastingTime end,
    GetCooldown = function(self) return Ability['HQueenConsumeShambler01'].Cooldown end,
    GetDamage = function(self) return Ability['HQueenConsumeShambler01'].DamageAmt end,
    GetHealthRestored = function(self) return math.floor( Buffs['HQueenConsumeShamblerBuff01'].Affects.Health.Add ) end,
    Icon = '/dgqueenofthorns/NewQueenConsumeShambler01',
}

AbilityBlueprint {
    Name = 'HQueenUprootGrey01',
    DisplayName = '<LOC ABILITY_Queen_0016>Uproot I',
    Description = '<LOC ABILITY_Queen_0017>Queen of Thorns sends her vines deep beneath the earth to destroy target structure\'s foundation, dealing [GetDamage] damage over [GetDuration] seconds.',
    AbilityType = 'Passive',
    AbilityCategory = 'HQUEENUNPACKED',
    TargetAlliance = 'Enemy',
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HQueenUproot01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HQueenUproot01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HQueenUproot01'].CastingTime end,
    GetCooldown = function(self) return Ability['HQueenUproot01'].Cooldown end,
    GetDamage = function(self) return math.floor( Ability['HQueenUproot01'].DamageAmt * Ability['HQueenUproot01'].Pulses ) end,
    GetDuration = function(self) return math.floor( Ability['HQueenUproot01'].Pulses ) end,
    Icon = '/dgqueenofthorns/NewQueenUproot01',
}

AbilityBlueprint {
    Name = 'HQueenGroundSpikesGrey01',
    DisplayName = '<LOC ABILITY_Queen_0020>Ground Spikes I',
    Description = '<LOC ABILITY_Queen_0021>Queen of Thorns radiates a forest of spikes around her, dealing [GetDamageAmt] damage and reducing armor by [GetArmorReduction] for [GetDuration] seconds.',
    AbilityType = 'Passive',
    AbilityCategory = 'HQUEENUNPACKED',
    TargetAlliance = 'Enemy',
    UISlot = 1,
    HotKey = '1',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HQueenGroundSpikes01'].RangeMax end,
    GetEnergyCost = function(self) return Ability['HQueenGroundSpikes01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HQueenGroundSpikes01'].CastingTime end,
    GetCooldown = function(self) return Ability['HQueenGroundSpikes01'].Cooldown end,
    GetDamageAmt = function(self) return math.floor( Ability['HQueenGroundSpikes01'].DamageAmt ) end,
    GetArmorReduction = function(self) return Buffs['HQueenGroundSpikes01'].Affects.Armor.Add * -1 end,
    GetDuration = function(self) return Buffs['HQueenGroundSpikes01'].Duration end,
    Icon = '/dgqueenofthorns/NewQueenGroundSpikes01',
}
__moduleinfo.auto_reload = true
