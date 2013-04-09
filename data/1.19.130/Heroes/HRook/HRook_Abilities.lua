local Buff = import('/lua/sim/buff.lua')
local Common = import('/lua/common/CommonUtils.lua')
local Validate = import('/lua/common/ValidateAbility.lua')
local RippleWorld = import('/lua/utilities.lua').RippleWorld
local MsgsFailure = import('/lua/ui/game/HUD_msgs_failure.lua').ShowFailureMsg

function FxHammerSlamRings( pos, army, segments, radius, template )
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
            local emitters = CreateTemplatedEffectAtPos( 'Rook', nil, template, army, Vector(pos[1] + x,pos[2],pos[3]+z), Vector(x, 0, z)  )
        end
    end
end

#################################################################################################################
# CE
# Hammer Slam
#################################################################################################################
function HammerSlam(def, unit, params)
    if(unit and not unit:IsDead()) then
        # Get position of Hammer
        #local hammerPos = table.copy(unit:GetPosition('sk_Rook_Hammer_Impact_REF'))
        #local target = params.Targets[1]
        #local hammerPos = table.copy(target:GetPosition())
        local hammerPos = table.copy(params.Target.Position)
        hammerPos[2] = 100
        local army = unit:GetArmy()

        # First set of radial rings
        FxHammerSlamRings ( hammerPos, army, 7, 2, 'HammerSlamRings01' )
        # Second set of radial rings
        FxHammerSlamRings ( hammerPos, army, 10, 3.4, 'HammerSlamRings02' )
        # Third set of radial rings
        FxHammerSlamRings ( hammerPos, army, 15, 4.45, 'HammerSlamRings03' )

        # Meta small area
        local metaData = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Origin = hammerPos,
            Radius = def.DamageRadius,
            Amount = def.MetaAmt,
            Category = 'METAINFANTRY',
            DamageFriendly = false,
        }
        MetaImpact(metaData)

        # Damage small area
        local data = {
            Instigator = unit,
            InstigatorBp = unit:GetBlueprint(),
            InstigatorArmy = unit:GetArmy(),
            Amount = def.DamageAmt,
            Type = 'Spell',
            DamageAction = def.Name,
            Radius = def.DamageRadius,
            DamageSelf = false,
            Origin = hammerPos,
            CanCrit = false,
            CanBackfire = false,
            CanBeEvaded = false,
            CanMagicResist = true,
            ArmorImmune = true,
            NoFloatText = false,
            Group = "UNITS",
        }
        DamageArea(data)

        # Damage large area
        data.Amount = def.SplashDamage
        data.Radius = def.SplashRadius
        DamageArea(data)
    end
end

#################################################################################################################
# Hammer Slam I
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookHammerSlam01',
    DisplayName = '<LOC ABILITY_HROOK_0000>Hammer Slam I',
    Description = '<LOC ABILITY_HROOK_0001>The Rook slams his hammer, dealing [GetSmallRadDamageAmt] damage in a small radius and [GetLargeRadDamageAmt] damage in a larger radius.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    #TargetingMethod = 'HOSTILETARGETED',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 360,
    Cooldown = 10,
    RangeMax = 9,
    RangeMin = 3,
    MetaAmt = 8,
    DamageAmt = 400,        # This is correct: inner ring damage is DamageAmt + SplashDamage, outer ring is just SplashDamage
    DamageRadius = 3,
    AffectRadius = 8,
    DamageType = 'Spell',
    SplashDamage = 100,
    SplashRadius = 8,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'CastHammerSlam',
    CastingTime = 1.5,
    FollowThroughTime = 0.5,
    GetSmallRadDamageAmt = function(self) return math.floor( self.DamageAmt + self.SplashDamage ) end,
    GetLargeRadDamageAmt = function(self) return math.floor( self.SplashDamage ) end,
    OnStartAbility = function(self, unit, params)
        HammerSlam(self, unit, params)
    end,
    Icon = '/DGRookAbilities/NewRookHammerslam01',
    Reticule = 'AoE_Boulder_Roll',
}

#################################################################################################################
# Hammer Slam II
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookHammerSlam02',
    DisplayName = '<LOC ABILITY_HROOK_0002>Hammer Slam II',
    Description = '<LOC ABILITY_HROOK_0001>The Rook slams his hammer, dealing [GetSmallRadDamageAmt] damage in a small radius and [GetLargeRadDamageAmt] damage in a larger radius.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    #TargetingMethod = 'HOSTILETARGETED',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 520,
    Cooldown = 10,
    RangeMax = 9,
    RangeMin = 3,
    MetaAmt = 8,
    DamageAmt = 700,        # This is correct: inner ring damage is DamageAmt + SplashDamage, outer ring is just SplashDamage
    DamageRadius = 3,
    AffectRadius = 8,
    DamageType = 'Spell',
    SplashDamage = 200,
    SplashRadius = 8,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'CastHammerSlam',
    CastingTime = 1.5,
    FollowThroughTime = 0.5,
    GetSmallRadDamageAmt = function(self) return math.floor( self.DamageAmt + self.SplashDamage ) end,
    GetLargeRadDamageAmt = function(self) return math.floor( self.SplashDamage ) end,
    OnStartAbility = function(self, unit, params)
        HammerSlam(self, unit, params)
    end,
    Icon = '/DGRookAbilities/NewRookHammerslam01',
    Reticule = 'AoE_Boulder_Roll',
}

#################################################################################################################
# Hammer Slam III
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookHammerSlam03',
    DisplayName = '<LOC ABILITY_HROOK_0004>Hammer Slam III',
    Description = '<LOC ABILITY_HROOK_0001>The Rook slams his hammer, dealing [GetSmallRadDamageAmt] damage in a small radius and [GetLargeRadDamageAmt] damage in a larger radius.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    #TargetingMethod = 'HOSTILETARGETED',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 680,
    Cooldown = 10,
    RangeMax = 9,
    RangeMin = 3,
    MetaAmt = 8,
    DamageAmt = 1000,        # This is correct: inner ring damage is DamageAmt + SplashDamage, outer ring is just SplashDamage
    DamageRadius = 3,
    AffectRadius = 8,
    DamageType = 'Spell',
    SplashDamage = 300,
    SplashRadius = 8,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'CastHammerSlam',
    CastingTime = 1.5,
    FollowThroughTime = 0.5,
    GetSmallRadDamageAmt = function(self) return math.floor( self.DamageAmt + self.SplashDamage ) end,
    GetLargeRadDamageAmt = function(self) return math.floor( self.SplashDamage ) end,
    OnStartAbility = function(self, unit, params)
        HammerSlam(self, unit, params)
    end,
    Icon = '/DGRookAbilities/NewRookHammerslam01',
    Reticule = 'AoE_Boulder_Roll',
}

#################################################################################################################
# Hammer Slam IV
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookHammerSlam04',
    DisplayName = '<LOC ABILITY_HROOK_0040>Hammer Slam IV',
    Description = '<LOC ABILITY_HROOK_0001>The Rook slams his hammer, dealing [GetSmallRadDamageAmt] damage in a small radius and [GetLargeRadDamageAmt] damage in a larger radius.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    #TargetingMethod = 'HOSTILETARGETED',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 840,
    Cooldown = 10,
    RangeMax = 9,
    RangeMin = 3,
    MetaAmt = 8,
    DamageAmt = 1300,        # This is correct: inner ring damage is DamageAmt + SplashDamage, outer ring is just SplashDamage
    DamageRadius = 3,
    AffectRadius = 8,
    DamageType = 'Spell',
    SplashDamage = 400,
    SplashRadius = 8,
    UISlot = 1,
    HotKey = '1',
    CastAction = 'CastHammerSlam',
    CastingTime = 1.5,
    FollowThroughTime = 0.5,
    GetSmallRadDamageAmt = function(self) return math.floor( self.DamageAmt + self.SplashDamage ) end,
    GetLargeRadDamageAmt = function(self) return math.floor( self.SplashDamage ) end,
    OnStartAbility = function(self, unit, params)
        HammerSlam(self, unit, params)
        if(Validate.HasAbility(unit, 'HRookDizzyingForce')) then
            # Apply slow to all enemy entities nearby
            local army = unit:GetArmy()
            local entities = GetEntitiesInSphere("UNITS", unit:GetPosition('sk_Rook_Hammer_Impact_REF'), self.SplashRadius)
            for k,entity in entities do
                if IsEnemy(army, entity:GetArmy()) and not entity:IsDead() and not EntityCategoryContains(categories.NOBUFFS, entity) and not EntityCategoryContains(categories.UNTARGETABLE, entity) then
                    Buff.ApplyBuff(entity, 'HRookDizzyingForce', unit)
                end
            end
        end
    end,
    Icon = '/DGRookAbilities/NewRookHammerslam01',
    Reticule = 'AoE_Boulder_Roll',
}

#################################################################################################################
# Dizzying Force
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookDizzyingForce',
    DisplayName = '<LOC ABILITY_HROOK_0046>Dizzying Force',
    Description = '<LOC ABILITY_HROOK_0047>Enemies that survive The Rook\'s Hammer Slam are dazed, their Movement Speed reduced by [GetSlow]% for [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetSlow = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
}

BuffBlueprint {
    Name = 'HRookDizzyingForce',
    DisplayName = '<LOC ABILITY_HROOK_0048>Dizzying Force',
    Description = '<LOC ABILITY_HROOK_0049>Movement Speed reduced.',
    BuffType = 'HROOKDIZZY',
    Stacks = 'REPLACE',
    Duration = 3,
    EntityCategory = 'MOBILE - UNTARGETABLE',
    Debuff = true,
    CanBeDispelled = true,
    Affects = {
        MoveMult = {Mult = -0.50},
    },
    Icon = '/DGRookAbilities/NewRookDizzyingForce01',
    Effects = 'Slow03',
    EffectsBone = -2,
}

#################################################################################################################
# Archers
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookArchers01',
    DisplayName = '<LOC ABILITY_HROOK_0031>Archer Tower',
    Description = '<LOC ABILITY_HROOK_0030>A squad of archers man The Rook\'s left shoulder, independently firing down upon enemies.',
    AbilityType = 'Quiet',
    OnAbilityAdded = function(self, unit)
        for i = 1, 6 do
            local wdbuff = 'HRookWeaponDisableArrow0'..i
            if Buff.HasBuff(unit, wdbuff) then
                Buff.RemoveBuff(unit, wdbuff)
            end
        end
    end,
}

#################################################################################################################
# Tower of Light
#   NOTE: This is the should Tower of Light.  It uses the unit HRookTOL.
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookTowerOfLight01',
    DisplayName = '<LOC ABILITY_HROOK_0033>Tower Of Light',
    Description = '<LOC ABILITY_HROOK_0058>The Rook installs a Tower of Light on his shoulder, independently firing upon enemies.\n\nThe damage of The Rook\'s Archer Tower is increased.',
    AbilityType = 'Quiet',
    OnAbilityAdded = function(self, unit)
        for i = 1, 6 do
            local wdbuff = 'HRookWeaponDisableArrow0'..i
            Buff.ApplyBuff(unit, wdbuff, unit)
        end
        for i = 7, 12 do
            local wdbuff = 'HRookWeaponDisableArrow0'..i
            if Buff.HasBuff(unit, wdbuff) then
                Buff.RemoveBuff(unit, wdbuff)
            end
        end
    end,
}

#################################################################################################################
# Trebuchet
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookTrebuchet01',
    DisplayName = '<LOC ABILITY_HROOK_0035>Trebuchet',
    Description = '<LOC ABILITY_HROOK_0059>The Rook builds a trebuchet on his head, which sieges independently from long range.\n\nThe damage of The Rook\'s Tower of Light is increased.',
    AbilityType = 'Quiet',
    OnAbilityAdded = function(self, unit)
        local brain = unit:GetAIBrain()
        local teamArmy = brain:GetTeamArmy()
        if(teamArmy) then
            teamArmy:AddArmyBonus('HRookTOLDamageBoost', unit)
        end
    end,
}

BuffBlueprint {
    Name = 'HRookWeaponDisablePrimary',
    DisplayName = 'PRIMARY Weapon Disabled',
    BuffType = 'MANUALWEAPONDISABLE',
    Debuff = true,
    Stacks = 'ALWAYS',
    Duration = -1,
    WeaponLabel = 'MeleeWeapon',
    Affects = {
        WeaponsEnable = {Bool = false,},
    },
}

ArmyBonusBlueprint {
    Name = 'HRookTOLDamageBoost',
    ApplyArmies = 'Team',
    UnitCategory = 'UPGRADE * LIGHTTOWER - DEFENSETOWER',
    RemoveOnUnitDeath = true,
    Buffs = {
        # Soldier
        BuffBlueprint {
            Name = 'HRookTOLDamageBoost',
            BuffType = 'SHOULDERTOLBOOST',
            Debuff = false,
            EntityCategory = 'UPGRADE * LIGHTTOWER - DEFENSETOWER',
            Stacks = 'REPLACE',
            Affects = {
                DamageBonus = {Add = 1},
            },
        },
    },
}

#################################################################################################################
# Poisoned Arrows
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookPoison',
    DisplayName = '<LOC ABILITY_HROOK_0050>Poisoned Arrows',
    Description = '<LOC ABILITY_HROOK_0051>The Rook\'s archers dip their arrows in poison. They have a [GetChance]% chance to slow their target by [GetSlowBuff]% for [GetDuration] seconds.',
    AbilityType = 'Quiet',
    TargetAlliance = 'Enemy',
    GetChance = function(self) return ( self.TriggerChance ) end,
    GetSlowBuff = function(self) return math.floor( Buffs[self.Name].Affects.MoveMult.Mult * -100 ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
    TargetCategory = 'MOBILE - UNTARGETABLE',
    TriggerChance = 15,
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnPostDamage:Add(self.PoisonTarget, self)
    end,
    PoisonTarget = function(self, unit, target, data)
        if Random(1, 100) < self.TriggerChance and data.Type == 'Arrow' then
            for k, buff in self.TargetBuffs do
                Buff.ApplyBuff(target, buff, unit)
            end
        end
    end,
    OnRemoveAbility = function(self, unit)
        unit.Callbacks.OnPostDamage:Remove(self.PoisonTarget)
    end,
    TargetBuffs = {
        BuffBlueprint {
            Name = 'HRookPoison',
            DisplayName = '<LOC ABILITY_HROOK_0052>Poisoned Arrow',
            Description = '<LOC ABILITY_HROOK_0053>Movement Speed reduced.',
            BuffType = 'HROOKPOISON',
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
            Icon = '/DGRookAbilities/NewRookPoisonArrow01',
        },
    },

}

#################################################################################################################
# CE
# Structural Transfer
#################################################################################################################
function StartTransfer(def, unit, params)
    local target = params.Targets[1]
    local thd = ForkThread(TransferThread, def, unit, target)
    unit.TrashOnKilled:Add(thd)
    unit.Trash:Add(thd)
    target.Trash:Add(thd)
    if not unit.AbilityData.Rook then
        unit.AbilityData.Rook = {}
    end
    unit.AbilityData.Rook.StructTransThread = thd
    Buff.ApplyBuff(target, 'WeaponDisable', unit)
    Buff.ApplyBuff(unit, 'HRookWeaponDisablePrimary', unit)
    if(Validate.HasAbility(unit, 'HRookArchers01')) then
        for i = 1, 6 do
            local wdbuff = 'HRookWeaponDisableArrow0'..i
            Buff.ApplyBuff(unit, wdbuff, unit)
        end
    end
    unit:GetNavigator():AbortMove()
    Buff.ApplyBuff(unit, 'Immobile', unit)
    unit.Character:PlayAction('CastDrainStart')
end

#################################################################################################################
# VFX
# Structural Transfer
#################################################################################################################
function TransferThread(def, unit, target)
    WaitSeconds(1)
    if target:IsDead() then
        EndTransfer(def, unit, target)
    end
    unit.AbilityData.Rook.StructTransTarget = target

    # create struct transfer effects at target with a vector towards the Rook.
    local unitpos = table.copy(unit:GetPosition())
    unitpos[2] = unitpos[2]+3
    local dir = VDiff(unitpos,target:GetPosition())
    local dist = VLength( dir )
    dir = VNormal(dir)
    local unitbp = target:GetBlueprint()
    local unitheight = unitbp.SizeY
    local unitwidth = (unitbp.SizeX + unitbp.SizeZ) / 2
    local unitVol = (unitbp.SizeX + unitbp.SizeZ + unitheight) / 3
    local army = unit:GetArmy()

    #LOG (repr(dist))
    #LOG (repr(unitheight))
    #LOG (repr(unitwidth))

    local fx1 = EffectTemplates.Rook.StructuralTransfer01
    local fx2 = EffectTemplates.Rook.StructuralTransfer02
    local fx3 = EffectTemplates.Rook.StructuralTransfer03
    unit.AbilityData.StructTransEffects = {}
    # Dust and Bricks
    for k, v in fx1 do
        emit = CreateAttachedEmitter( target, -2, army, v )
        emit:SetEmitterCurveParam('EMITRATE_CURVE', unitVol*3.5, 0.0)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist, dist*0.28)
        emit:SetEmitterCurveParam('XDIR_CURVE', dir[1], 0.3)
        emit:SetEmitterCurveParam('YDIR_CURVE', dir[2], 0.0)
        emit:SetEmitterCurveParam('ZDIR_CURVE', dir[3], 0.3)
        emit:SetEmitterCurveParam('X_POSITION_CURVE', 0.0, unitwidth)
        emit:SetEmitterCurveParam('Y_POSITION_CURVE', unitheight*0.4, unitheight)
        emit:SetEmitterCurveParam('Z_POSITION_CURVE', 0.0, unitwidth)
        table.insert( unit.AbilityData.StructTransEffects, emit )
    end
    # Sparks
    for k, v in fx2 do
        emit = CreateAttachedEmitter( target, -2, army, v )
        emit:SetEmitterCurveParam('EMITRATE_CURVE', unitVol*3.5, 0.0)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist*0.5, dist*0.15)
        emit:SetEmitterCurveParam('XDIR_CURVE', dir[1], 0.6)
        emit:SetEmitterCurveParam('YDIR_CURVE', dir[2], 0.0)
        emit:SetEmitterCurveParam('ZDIR_CURVE', dir[3], 0.6)
        emit:SetEmitterCurveParam('X_POSITION_CURVE', 0.0, unitwidth)
        emit:SetEmitterCurveParam('Y_POSITION_CURVE', unitheight*0.4, unitheight)
        emit:SetEmitterCurveParam('Z_POSITION_CURVE', 0.0, unitwidth)
        table.insert( unit.AbilityData.StructTransEffects, emit )
    end
    # Orange wispy plasma energy
    for k, v in fx3 do
        emit = CreateAttachedEmitter( target, -2, army, v )
        emit:SetEmitterCurveParam('EMITRATE_CURVE', unitVol*0.4, 0.0)
        emit:SetEmitterCurveParam('LIFETIME_CURVE', dist, dist*0.28)
        emit:SetEmitterCurveParam('XDIR_CURVE', dir[1], 0.3)
        emit:SetEmitterCurveParam('YDIR_CURVE', dir[2], 0.0)
        emit:SetEmitterCurveParam('ZDIR_CURVE', dir[3], 0.3)
        emit:SetEmitterCurveParam('X_POSITION_CURVE', 0.0, unitwidth)
        emit:SetEmitterCurveParam('Y_POSITION_CURVE', unitheight*0.4, unitheight)
        emit:SetEmitterCurveParam('Z_POSITION_CURVE', 0.0, unitwidth)
        table.insert( unit.AbilityData.StructTransEffects, emit )
    end

    unit.Character:PlayAction('CastDrainLoop')
    if not unit:IsDead() then
        unit.Callbacks.OnKilled:Add(EndTransfer, def)
        unit.Callbacks.OnMotionHorzEventChange:Add(EndTransfer, def)
        unit.Callbacks.OnStunned:Add(EndTransfer, def)
        unit.Callbacks.OnFrozen:Add(EndTransfer, def)
        unit.Callbacks.OnAbilityBeginCast:Add(EndTransferCancel, def)
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
            EndTransfer(def, unit, target)
        end
    end
    EndTransfer(def, unit, target)
end

function EndTransfer(def, unit, target)
    Buff.RemoveBuff(unit, 'Immobile')
    unit.Character:PlayAction('CastDrainEnd')
    local target = unit.AbilityData.Rook.StructTransTarget
    if target and not target:IsDead() then
        if Buff.HasBuff(target, 'WeaponDisable') then
            Buff.RemoveBuff(target, 'WeaponDisable')
        end
    end
    if unit.AbilityData.Rook.StructTransBeam then
        unit.AbilityData.Rook.StructTransBeam:Destroy()
        unit.AbilityData.Rook.StructTransBeam = nil
    end
    if unit.AbilityData.Rook.StructTransThread then
        unit.AbilityData.Rook.StructTransThread:Destroy()
        unit.AbilityData.Rook.StructTransThread = nil
    end
    if Buff.HasBuff(unit, 'HRookWeaponDisablePrimary') then
        Buff.RemoveBuff(unit, 'HRookWeaponDisablePrimary')
    end
    if(Validate.HasAbility(unit, 'HRookArchers01')) then
        for i = 1, 6 do
            local wdbuff = 'HRookWeaponDisableArrow0'..i
            if Buff.HasBuff(unit, wdbuff) then
                Buff.RemoveBuff(unit, wdbuff)
            end
        end
    end
    unit.Callbacks.OnKilled:Remove(EndTransfer)
    unit.Callbacks.OnMotionHorzEventChange:Remove(EndTransfer)
    unit.Callbacks.OnStunned:Remove(EndTransfer)
    unit.Callbacks.OnFrozen:Remove(EndTransfer)
    unit.Callbacks.OnAbilityBeginCast:Remove(EndTransferCancel)

    # cleanup effects
    if unit.AbilityData.StructTransEffects then
        for kEffect, vEffect in unit.AbilityData.StructTransEffects do
            vEffect:Destroy()
        end
        unit.AbilityData.StructTransEffects = nil
    end
end

function EndTransferCancel(def, ability, unit)
    Buff.RemoveBuff(unit, 'Immobile')
    unit.Character:PlayAction('CastDrainEnd')
    local target = unit.AbilityData.Rook.StructTransTarget
    if target and not target:IsDead() then
        if Buff.HasBuff(target, 'WeaponDisable') then
            Buff.RemoveBuff(target, 'WeaponDisable')
        end
    end
    if unit.AbilityData.Rook.StructTransBeam then
        unit.AbilityData.Rook.StructTransBeam:Destroy()
        unit.AbilityData.Rook.StructTransBeam = nil
    end
    if unit.AbilityData.Rook.StructTransThread then
        unit.AbilityData.Rook.StructTransThread:Destroy()
        unit.AbilityData.Rook.StructTransThread = nil
    end
    if Buff.HasBuff(unit, 'HRookWeaponDisablePrimary') then
        Buff.RemoveBuff(unit, 'HRookWeaponDisablePrimary')
    end
    if(Validate.HasAbility(unit, 'HRookArchers01')) then
        for i = 1, 6 do
            local wdbuff = 'HRookWeaponDisableArrow0'..i
            if Buff.HasBuff(unit, wdbuff) then
                Buff.RemoveBuff(unit, wdbuff)
            end
        end
    end
    unit.Callbacks.OnKilled:Remove(EndTransfer)
    unit.Callbacks.OnMotionHorzEventChange:Remove(EndTransfer)
    unit.Callbacks.OnStunned:Remove(EndTransfer)
    unit.Callbacks.OnFrozen:Remove(EndTransfer)
    unit.Callbacks.OnAbilityBeginCast:Remove(EndTransferCancel)

    # cleanup effects
    if unit.AbilityData.StructTransEffects then
        for kEffect, vEffect in unit.AbilityData.StructTransEffects do
            vEffect:Destroy()
        end
        unit.AbilityData.StructTransEffects = nil
    end
end

#################################################################################################################
# Structural Transfer I
#   Note: Frequency for transfer pulse set in function TransferThread.  (Line 345 as of writing)
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookStructuralTransfer01',
    DisplayName = '<LOC ABILITY_HROOK_0006>Structural Transfer I',
    Description = '<LOC ABILITY_HROOK_0007>The Rook tears a structure apart, draining [GetAmount] Health over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Any',
    TargetCategory = 'STRUCTURE - UNTARGETABLE',
    TargetingMethod = 'STRUCTURE',
    EnergyCost = 265,
    Cooldown = 20,
    RangeMax = 10,
    Pulses = 10,
    Amount = 80,
    UISlot = 2,
    HotKey = '2',
    GetAmount = function(self) return math.floor( self.Amount * self.Pulses ) end,
    GetDuration = function(self) return math.floor( self.Pulses ) end,
    Icon = '/DGRookAbilities/NewRookStructuralTransferNew01',
    OnStartAbility = function(self,unit,params)
        StartTransfer(self, unit, params)
    end,
    Moved = function(self, unit, new, old)
        if new != 'Stopping' and new != 'Stopped' then
            EndTransfer(unit)
        end
    end,
}

#################################################################################################################
# Structural Transfer II
#   Note: Frequency for transfer pulse set in function TransferThread.  (Line 345 as of writing)
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookStructuralTransfer02',
    DisplayName = '<LOC ABILITY_HROOK_0008>Structural Transfer II',
    Description = '<LOC ABILITY_HROOK_0007>The Rook tears a structure apart, draining [GetAmount] Health over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Any',
    TargetCategory = 'STRUCTURE - UNTARGETABLE',
    TargetingMethod = 'STRUCTURE',
    EnergyCost = 375,
    Cooldown = 20,
    RangeMax = 10,
    Pulses = 10,
    Amount = 120,
    UISlot = 2,
    HotKey = '2',
    GetAmount = function(self) return math.floor( self.Amount * self.Pulses ) end,
    GetDuration = function(self) return math.floor( self.Pulses ) end,
    Icon = '/DGRookAbilities/NewRookStructuralTransferNew01',
    OnStartAbility = function(self,unit,params)
        StartTransfer(self, unit, params)
    end,
    Moved = function(self, unit, new, old)
        if new != 'Stopping' and new != 'Stopped' then
            EndTransfer(unit)
        end
    end,
}

#################################################################################################################
# Structural Transfer III
#   Note: Frequency for transfer pulse set in function TransferThread.  (Line 345 as of writing)
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookStructuralTransfer03',
    DisplayName = '<LOC ABILITY_HROOK_0010>Structural Transfer III',
    Description = '<LOC ABILITY_HROOK_0007>The Rook tears a structure apart, draining [GetAmount] Health over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Any',
    TargetCategory = 'STRUCTURE - UNTARGETABLE',
    TargetingMethod = 'STRUCTURE',
    EnergyCost = 490,
    Cooldown = 20,
    RangeMax = 10,
    Pulses = 10,
    Amount = 160,
    UISlot = 2,
    HotKey = '2',
    GetAmount = function(self) return math.floor( self.Amount * self.Pulses ) end,
    GetDuration = function(self) return math.floor( self.Pulses ) end,
    Icon = '/DGRookAbilities/NewRookStructuralTransferNew01',
    OnStartAbility = function(self,unit,params)
        StartTransfer(self, unit, params)
    end,
    Moved = function(self, unit, new, old)
        if new != 'Stopping' and new != 'Stopped' then
            EndTransfer(unit)
        end
    end,
}

#################################################################################################################
# Structural Transfer IV
#   Note: Frequency for transfer pulse set in function TransferThread.  (Line 345 as of writing)
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookStructuralTransfer04',
    DisplayName = '<LOC ABILITY_HROOK_0041>Structural Transfer IV',
    Description = '<LOC ABILITY_HROOK_0007>The Rook tears a structure apart, draining [GetAmount] Health over [GetDuration] seconds.',
    AbilityType = 'TargetedUnit',
    TargetAlliance = 'Any',
    TargetCategory = 'STRUCTURE - UNTARGETABLE',
    TargetingMethod = 'STRUCTURE',
    EnergyCost = 610,
    Cooldown = 20,
    RangeMax = 10,
    Pulses = 10,
    Amount = 200,
    UISlot = 2,
    HotKey = '2',
    GetAmount = function(self) return math.floor( self.Amount * self.Pulses ) end,
    GetDuration = function(self) return math.floor( self.Pulses ) end,
    Icon = '/DGRookAbilities/NewRookStructuralTransferNew01',
    OnStartAbility = function(self,unit,params)
        StartTransfer(self, unit, params)
        if Validate.HasAbility(unit,'HRookEnergizer') then
            Buff.ApplyBuff(unit, 'HRookEnergizer', unit)
        end
    end,
    Moved = function(self, unit, new, old)
        if new != 'Stopping' and new != 'Stopped' then
            EndTransfer(unit)
        end
    end,
}

#################################################################################################################
# Energizer
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookEnergizer',
    DisplayName = '<LOC ABILITY_HROOK_0054>Energizer',
    Description = '<LOC ABILITY_HROOK_0055>The Rook drains the energy of structures. When he uses Structural Transfer, his Mana Per Second is increased by [GetManaRegen]% for [GetDuration] seconds.',
    AbilityType = 'Quiet',
    GetManaRegen = function(self) return math.floor( Buffs[self.Name].Affects.EnergyRegen.Mult * 100 ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
}

BuffBlueprint {
    Name = 'HRookEnergizer',
    DisplayName = '<LOC ABILITY_HROOK_0056>Energizer',
    Description = '<LOC ABILITY_HROOK_0057>Mana Per Second increased.',
    BuffType = 'HROOKENERGIZER',
    Debuff = false,
    Stacks = 'ALWAYS',
    Duration = 10,
    Affects = {
        EnergyRegen = {Mult = 1.5},
    },
    Icon = '/DGRookAbilities/NewRookEnergizer01',
}

#################################################################################################################
# CE
# Boulder Roll
#################################################################################################################
function BoulderRoll(abil, unit, params, inLevel)
    # Note: Projectile damage, meta impact, and stun application rely on AffectRadius and MetaImpactAmount
    # being the same, as a minor perf optimization.

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
        metaData = {
            Instigator = unit,
            InstigatorBp = instigatorBp,
            InstigatorArmy = instigatorArmy,
            Radius = abil.MetaImpactRadius,
            Amount = abil.MetaImpactAmount,
            Category = "METAINFANTRY",
            DamageFriendly = abil.MetaImpactDamageFriendly or false,
        },
        direction = direction,
        range = abil.RangeMax,
        scale = abil.BoulderScale,
        buff1 = abil.TargetBuff,
        buff2 = abil.TargetImmuneBuff,
        level = inLevel,
    }
    local proj = unit:CreateProjectile('/projectiles/HRookBoulder01/HRookBoulder01_proj.bp', 0, 0.625 * abil.BoulderScale, 0, direction[1], direction[2], direction[3])
    proj:SetScale(proj:GetBlueprint().Display.UniformScale * abil.BoulderScale)
    proj:PassData(projectileData)
end

#################################################################################################################
# Buff - Boulder Roll I
#################################################################################################################
BuffBlueprint {
    Name = 'HRookBoulderRoll01',
    DisplayName = '<LOC ABILITY_HROOK_0012>Boulder Roll',
    Description = '<LOC ABILITY_HROOK_0013>Stunned.',
    BuffType = 'HROOKBOULDERSTUN',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    EntityCategory = 'MOBILE',
    Duration = 1.5,
    TriggersStunImmune = true,
    Affects = {
        Stun = {Add = 0},
    },
    Icon = '/DGRookAbilities/NewBoulderRoll01',
}

BuffBlueprint {
    Name = 'HRookBoulderRoll01Immune',
    Debuff = false,
    BuffType = 'STUNIMMUNE',
    EntityCategory = 'HERO',
    Stacks = 'IGNORE',
    Duration = 3,
    Affects = {
        StunImmune = {Bool = true,},
    },
}

#################################################################################################################
# Buff - Boulder Roll II
#################################################################################################################
BuffBlueprint {
    Name = 'HRookBoulderRoll02',
    DisplayName = '<LOC ABILITY_HROOK_0012>Boulder Roll',
    Description = '<LOC ABILITY_HROOK_0013>Stunned.',
    BuffType = 'HROOKBOULDERSTUN',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    EntityCategory = 'MOBILE',
    Duration = 2,
    TriggersStunImmune = true,
    Affects = {
        Stun = {Add = 0},
    },
    Icon = '/DGRookAbilities/NewBoulderRoll01',
}

BuffBlueprint {
    Name = 'HRookBoulderRoll02Immune',
    Debuff = false,
    BuffType = 'STUNIMMUNE',
    EntityCategory = 'HERO',
    Stacks = 'IGNORE',
    Duration = 4,
    Affects = {
        StunImmune = {Bool = true,},
    },
}

#################################################################################################################
# Buff - Boulder Roll III
#################################################################################################################
BuffBlueprint {
    Name = 'HRookBoulderRoll03',
    DisplayName = '<LOC ABILITY_HROOK_0012>Boulder Roll',
    Description = '<LOC ABILITY_HROOK_0013>Stunned.',
    BuffType = 'HROOKBOULDERSTUN',
    Debuff = true,
    CanBeDispelled = true,
    Stacks = 'REPLACE',
    EntityCategory = 'MOBILE',
    Duration = 2.5,
    TriggersStunImmune = true,
    Affects = {
        Stun = {Add = 0},
    },
    Icon = '/DGRookAbilities/NewBoulderRoll01',
}

BuffBlueprint {
    Name = 'HRookBoulderRoll03Immune',
    Debuff = false,
    BuffType = 'STUNIMMUNE',
    EntityCategory = 'HERO',
    Stacks = 'IGNORE',
    Duration = 5,
    Affects = {
        StunImmune = {Bool = true,},
    },
}

#################################################################################################################
# Boulder Roll I
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookBoulderRoll01',
    DisplayName = '<LOC ABILITY_HROOK_0014>Boulder Roll I',
    Description = '<LOC ABILITY_HROOK_0015>The Rook rips a chunk of the earth and hurls it at enemies ahead of him, dealing [GetAmount] damage, stunning for [GetDuration] seconds, and throwing smaller units into the air.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 560,
    RangeMax = 35,
    Cooldown = 15,
    DamageAmt = 200,
    DamageType = 'Spell',
    AffectRadius = 2.5,
    MetaImpactAmount = 7,
    MetaImpactRadius = 2.5,
    BoulderScale = 1.5,
    TargetBuff = 'HRookBoulderRoll01',
    TargetImmuneBuff = 'HRookBoulderRoll01Immune',
    UISlot = 4,
    HotKey = '4',
    CastAction = 'Bowl',
    CastingTime = 0.4,
    FollowThroughTime = 0.5,
    GetAmount = function(self) return math.floor( self.DamageAmt ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
    OnStartAbility = function(self, unit, params)
        BoulderRoll( self, unit, params, 1 )
    end,
    Icon = '/DGRookAbilities/NewBoulderRoll01',
    Reticule = 'AoE_Boulder_Roll',
}

#################################################################################################################
# Boulder Roll II
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookBoulderRoll02',
    DisplayName = '<LOC ABILITY_HROOK_0016>Boulder Roll II',
    Description = '<LOC ABILITY_HROOK_0015>The Rook rips a chunk of the earth and hurls it at enemies ahead of him, dealing [GetAmount] damage, stunning for [GetDuration] seconds, and throwing smaller units into the air.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 800,
    RangeMax = 35,
    Cooldown = 15,
    DamageAmt = 300,
    DamageType = 'Spell',
    AffectRadius = 2.5,
    MetaImpactAmount = 7,
    MetaImpactRadius = 2.5,
    BoulderScale = 1.5,
    TargetBuff = 'HRookBoulderRoll02',
    TargetImmuneBuff = 'HRookBoulderRoll02Immune',
    UISlot = 4,
    HotKey = '4',
    CastAction = 'Bowl',
    CastingTime = 0.4,
    FollowThroughTime = 0.5,
    GetAmount = function(self) return math.floor( self.DamageAmt ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
    OnStartAbility = function(self, unit, params)
        BoulderRoll( self, unit, params, 2)
    end,
    Icon = '/DGRookAbilities/NewBoulderRoll01',
    Reticule = 'AoE_Boulder_Roll',
}

#################################################################################################################
# Boulder Roll III
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookBoulderRoll03',
    DisplayName = '<LOC ABILITY_HROOK_0036>Boulder Roll III',
    Description = '<LOC ABILITY_HROOK_0015>The Rook rips a chunk of the earth and hurls it at enemies ahead of him, dealing [GetAmount] damage, stunning for [GetDuration] seconds, and throwing smaller units into the air.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 1064,
    RangeMax = 35,
    Cooldown = 15,
    DamageAmt = 400,
    DamageType = 'Spell',
    AffectRadius = 2.5,
    MetaImpactAmount = 7,
    MetaImpactRadius = 2.5,
    BoulderScale = 1.5,
    TargetBuff = 'HRookBoulderRoll03',
    TargetImmuneBuff = 'HRookBoulderRoll03Immune',
    UISlot = 4,
    HotKey = '4',
    CastAction = 'Bowl',
    CastingTime = 0.4,
    FollowThroughTime = 0.5,
    GetAmount = function(self) return math.floor( self.DamageAmt ) end,
    GetDuration = function(self) return ( Buffs[self.Name].Duration ) end,
    OnStartAbility = function(self, unit, params)
        BoulderRoll( self, unit, params, 2)
    end,
    Icon = '/DGRookAbilities/NewBoulderRoll01',
    Reticule = 'AoE_Boulder_Roll',
}
#################################################################################################################
# CE
# Power of the Tower
#################################################################################################################
function CountTowers(abil, seed, tower, order)
    #Check the tower tracking tables and make sure they're setup properly.
    local aiBrain = tower:GetAIBrain()
    local at = aiBrain.AbilityData
    if not at.Rook then
        at.Rook = {}
    end
    local atr = at.Rook
    if not atr.Towers then
        atr.Towers = {}
    end

    atr.Counter = (atr.Counter or 0) + 1
    atr.Towers[atr.Counter] = tower
    #Clean out dead towers
    for k, mn in atr.Towers do
        if mn:IsDead() then
            atr.Towers[k] = nil
        end
    end

    #If we're at the max destroy the first tower
    if table.getsize(atr.Towers) > abil.TowerMax then
        local key = table.keys(atr.Towers)[1]
        if not atr.Towers[key].KillData then
            atr.Towers[key].KillData = {}
        end
        atr.Towers[key]:Kill()
        atr.Towers[key] = nil
    end
end

function GetTowerLocation(unit)
    local pos = table.copy(unit:GetPosition())
    local fwdVec = ForwardVector(unit:GetOrientation())
    local forwarddist = 5
    pos[1] = pos[1] + ( fwdVec[1] * forwarddist )
    pos[2] = pos[2] + ( fwdVec[2] * forwarddist )
    pos[3] = pos[3] + ( fwdVec[3] * forwarddist )
    return pos
end

function Immobilize(unit)
    local duration = unit.Character.CurrentAnimState:GetDuration() or 0
    duration = duration * 10
    if(duration > 0) then
        Buff.ApplyBuff(unit, 'Immobile', unit)
        local waitTicks = 0
        while(unit and not unit:IsDead() and waitTicks < duration) do
             WaitTicks(1)
             waitTicks = waitTicks + 1
        end
        Buff.RemoveBuff(unit, 'Immobile')
    end
end

#################################################################################################################
# Power of the Tower I
#   NOTE:  This creates the unit HRookTowerOfLight.
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookTower01',
    DisplayName = '<LOC ABILITY_HROOK_0018>Power of the Tower I',
    Description = '<LOC ABILITY_HROOK_0019>The Rook pulls a Tower of Light from the ground to defend the area.\n\nUp to [GetMaxTowers] of these towers may be active at a time.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 400,
    Cooldown = 10,
    RangeMax = 5,
    CastAction = 'CastBuild',
    CastingTime = 0.1,
    AffectRadius = 2,
    TowerMax = 2,
    UISlot = 3,
    HotKey = '3',
    ErrorMessage = '<LOC error_0041>Cannot build that here.',
    ErrorVO = 'Nobuild',
    GetMaxTowers = function(self) return math.floor( self.TowerMax ) end,
    PreCastCheck = function(self, unit)
        local pos = GetTowerLocation(unit)
        #if IsBadSpot(unit, pos) then
        #    MsgsFailure('<LOC error_0027>Cannot build that here')
        #end
        return (not IsBadSpot(unit, pos))
    end,
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Immobilize, unit)
        unit.TrashOnKilled:Add(thd)

        local pos = params.Target.Position
        local orient = unit:GetOrientation()
        local seed = CreateUnitHPR('buildseed', unit:GetArmy(), pos[1], 100, pos[3], orient[1], orient[2], orient[3] )
        local commandData = {
            TaskName = 'SeedBuild',
            BlueprintId = 'HRookTowerOfLight',
        }
        IssueScript({seed}, commandData)
        seed.Callbacks.OnStartBuild:Add(CountTowers, self)
    end,
    Icon = '/DGRookAbilities/NewRookPowerofTower01',
    Reticule = 'AoE_Power_of_the_Tower',
}

#################################################################################################################
# Power of the Tower II
#   NOTE:  This creates the unit HRookTowerOfLight.
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookTower02',
    DisplayName = '<LOC ABILITY_HROOK_0020>Power of the Tower II',
    Description = '<LOC ABILITY_HROOK_0043>The Rook pulls a Tower of Light from the ground to defend the area. This tower is more powerful than the one made by Power of the Tower I.\n\nUp to [GetMaxTowers] of these towers may be active at a time.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 400,
    Cooldown = 10,
    RangeMax = 5,
    AffectRadius = 2,
    CastAction = 'CastBuild',
    CastingTime = 0.1,
    TowerMax = 4,
    UISlot = 3,
    HotKey = '3',
    ErrorMessage = '<LOC error_0042>Cannot build that here.',
    ErrorVO = 'Nobuild',
    GetMaxTowers = function(self) return math.floor( self.TowerMax ) end,
    PreCastCheck = function(self, unit)
        local pos = GetTowerLocation(unit)
        #if IsBadSpot(unit, pos) then
        #    MsgsFailure('<LOC error_0027>Cannot build that here')
        #end
        return (not IsBadSpot(unit, pos))
    end,
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Immobilize, unit)
        unit.TrashOnKilled:Add(thd)

        local pos = params.Target.Position
        local orient = unit:GetOrientation()
        local seed = CreateUnitHPR('buildseed', unit:GetArmy(), pos[1], 100, pos[3], orient[1], orient[2], orient[3] )
        local commandData = {
            TaskName = 'SeedBuild',
            BlueprintId = 'HRookTowerOfLight02',
        }
        IssueScript({seed}, commandData)
        seed.Callbacks.OnStartBuild:Add(CountTowers, self)
    end,
    Icon = '/DGRookAbilities/NewRookPowerofTower01',
    Reticule = 'AoE_Power_of_the_Tower',
}

#################################################################################################################
# Power of the Tower III
#   NOTE:  This creates the unit HRookTowerOfLight.
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookTower03',
    DisplayName = '<LOC ABILITY_HROOK_0022>Power of the Tower III',
    Description = '<LOC ABILITY_HROOK_0044>The Rook pulls a Tower of Light from the ground to defend the area. This tower is more powerful than the one made by Power of the Tower II.\n\nUp to [GetMaxTowers] of these towers may be active at a time.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 400,
    Cooldown = 10,
    RangeMax = 5,
    AffectRadius = 2,
    CastAction = 'CastBuild',
    CastingTime = 0.1,
    TowerMax = 6,
    UISlot = 3,
    HotKey = '3',
    ErrorMessage = '<LOC error_0043>Cannot build that here.',
    ErrorVO = 'Nobuild',
    GetMaxTowers = function(self) return math.floor( self.TowerMax ) end,
    PreCastCheck = function(self, unit)
        local pos = GetTowerLocation(unit)
        #if IsBadSpot(unit, pos) then
        #    MsgsFailure('<LOC error_0027>Cannot build that here')
        #end
        return (not IsBadSpot(unit, pos))
    end,
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Immobilize, unit)
        unit.TrashOnKilled:Add(thd)

        local pos = params.Target.Position
        local orient = unit:GetOrientation()
        local seed = CreateUnitHPR('buildseed', unit:GetArmy(), pos[1], 100, pos[3], orient[1], orient[2], orient[3] )
        local commandData = {
            TaskName = 'SeedBuild',
            BlueprintId = 'HRookTowerOfLight03',
        }
        IssueScript({seed}, commandData)
        seed.Callbacks.OnStartBuild:Add(CountTowers, self)
    end,
    Icon = '/DGRookAbilities/NewRookPowerofTower01',
    Reticule = 'AoE_Power_of_the_Tower',
}

#################################################################################################################
# Power of the Tower IV
#   NOTE:  This creates the unit HRookTowerOfLight.
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookTower04',
    DisplayName = '<LOC ABILITY_HROOK_0042>Power of the Tower IV',
    Description = '<LOC ABILITY_HROOK_0045>The Rook pulls a Tower of Light from the ground to defend the area. This tower is more powerful than the one made by Power of the Tower III.\n\nUp to [GetMaxTowers] of these towers may be active at a time.',
    AbilityType = 'TargetedArea',
    TargetAlliance = 'Ally',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    TargetingMethod = 'AREAARGETED',
    EnergyCost = 200,
    Cooldown = 10,
    RangeMax = 5,
    AffectRadius = 2,
    CastAction = 'CastBuild',
    CastingTime = 0.1,
    TowerMax = 8,
    UISlot = 3,
    HotKey = '3',
    ErrorMessage = '<LOC error_0044>Cannot build that here.',
    ErrorVO = 'Nobuild',
    GetMaxTowers = function(self) return math.floor( self.TowerMax ) end,
    PreCastCheck = function(self, unit)
        local pos = GetTowerLocation(unit)
        #if IsBadSpot(unit, pos) then
        #    MsgsFailure('<LOC error_0027>Cannot build that here')
        #end
        return (not IsBadSpot(unit, pos))
    end,
    OnStartAbility = function(self, unit, params)
        local thd = ForkThread(Immobilize, unit)
        unit.TrashOnKilled:Add(thd)

        local pos = params.Target.Position
        local orient = unit:GetOrientation()
        local seed = CreateUnitHPR('buildseed', unit:GetArmy(), pos[1], 100, pos[3], orient[1], orient[2], orient[3] )
        local commandData = {
            TaskName = 'SeedBuild',
            BlueprintId = 'HRookTowerOfLight04',
        }
        IssueScript({seed}, commandData)
        seed.Callbacks.OnStartBuild:Add(CountTowers, self)
    end,
    Icon = '/DGRookAbilities/NewRookPowerofTower01',
    Reticule = 'AoE_Power_of_the_Tower',
}

#################################################################################################################
# VFX - Gods Strength
#################################################################################################################
# Create gods strength hammer flash effect
function FxGodStrength( unit)
    unit:AddEffectMeshState( 'GodStrength', string.lower(unit.Character.CharBP.Meshes.GodStrength), true, true )
    #AttachBuffEffectAtBone( unit, 'Strength01', 'sk_Rook_RightWrist'  )
    #AttachBuffEffectAtBone( unit, 'Strength01', 'sk_Rook_LeftWrist')
    #AttachBuffEffectAtBone( unit, 'Strength01', 'sk_Rook_Hammer_Impact_REF' )
end

#################################################################################################################
# Gods Strength I
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookGodStrength01',
    DisplayName = '<LOC ABILITY_HROOK_0024>God Strength I',
    Description = '<LOC ABILITY_HROOK_0025>The Rook calls upon divine strength, increasing Weapon Damage by [GetDamageBonus].',
    AbilityType = 'Quiet',
    GetDamageBonus = function(self) return Buffs[self.Name].Affects.DamageRating.Add end,
    Buffs = {
        BuffBlueprint {
            Name = 'HRookGodStrength01',
            DisplayName = '<LOC ABILITY_HROOK_0024>God Strength I',
            Description = '<LOC ABILITY_HROOK_0037>The Rook calls upon divine strength, increasing Weapon Damage.',
            BuffType = 'HROOKGODSTRENGTH',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                DamageRating = {Add = 50},
            },
            OnApplyBuff = function( self, unit, instigator )
               FxGodStrength( unit )
            end,
        },
    },
    Icon = '/DGRookAbilities/NewRookPowerofTower01',
}

#################################################################################################################
# Gods Strength II
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookGodStrength02',
    DisplayName = '<LOC ABILITY_HROOK_0026>God Strength II',
    Description = '<LOC ABILITY_HROOK_0025>The Rook calls upon divine strength, increasing Weapon Damage by [GetDamageBonus].',
    AbilityType = 'Quiet',
    GetDamageBonus = function(self) return Buffs[self.Name].Affects.DamageRating.Add end,
    Buffs = {
        BuffBlueprint {
            Name = 'HRookGodStrength02',
            DisplayName = '<LOC ABILITY_HROOK_0026>God Strength II',
            Description = '<LOC ABILITY_HROOK_0038>The Rook calls upon divine strength, increasing Weapon Damage.',
            BuffType = 'HROOKGODSTRENGTH',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                DamageRating = {Add = 100},
            },
         },
    },
    Icon = '/DGRookAbilities/NewRookPowerofGodsNew01',
}

#################################################################################################################
# Gods Strength III
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookGodStrength03',
    DisplayName = '<LOC ABILITY_HROOK_0028>God Strength III',
    Description = '<LOC ABILITY_HROOK_0025>The Rook calls upon divine strength, increasing Weapon Damage by [GetDamageBonus].',
    AbilityType = 'Quiet',
    GetDamageBonus = function(self) return Buffs[self.Name].Affects.DamageRating.Add end,
    Buffs = {
        BuffBlueprint {
            Name = 'HRookGodStrength03',
            DisplayName = '<LOC ABILITY_HROOK_0028>God Strength III',
            Description = '<LOC ABILITY_HROOK_0039>The Rook calls upon divine strength, increasing Weapon Damage.',
            BuffType = 'HROOKGODSTRENGTH',
            Debuff = false,
            Stacks = 'REPLACE',
            Affects = {
                DamageRating = {Add = 150},
            },
        },
    },
    Icon = '/DGRookAbilities/NewRookPowerofGodsNew01',
}

#################################################################################################################
# Epic Death
#################################################################################################################
RookDeath = function( unit, abil )

    local bonetable = {
        'sk_Rook_RightShoulder',
        'sk_Rook_LeftShoulder',
        'sk_Rook_RightElbowpad',
        'sk_Rook_LeftElbowpad',
        'sk_Rook_RightHip',
        'sk_Rook_LeftHip',
        'sk_Rook_RightKnee',
        'sk_Rook_LeftKnee',
        'sk_Rook_LeftWrist',
        'sk_Rook_RightWrist',
    }

    # Create sand falling off Rook as he dies
    AttachCharacterEffectsAtBones( unit, 'rook', 'DeathDust01', bonetable )

    WaitSeconds(3)
    local army = unit:GetArmy()

    # Get the position of the simulated sk_Rook_LeftCollar bone here, offset to terrain height.
    # Use this position for damage and effect center, this makes it interesting, since his animations
    # fall in differing directions.
    local pos = table.copy(unit:GetPosition('sk_Rook_LeftCollar') )
    pos[2] = GetSurfaceHeight(pos[1], pos[3])

    # Do damage
    local data = {
        Instigator = unit,
        InstigatorBp = unit:GetBlueprint(),
        InstigatorArmy = army,
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
    }
    DamageArea(data)
    unit:ShakeCamera( 12, 1.0, 0.0, 1.2 )

    CreateTemplatedEffectAtPos( 'Rook', nil, 'Death01', army, pos )
    RippleWorld()

    FxHammerSlamRings( pos, army, 7, 2, 'HammerSlamRings01' )
    # Second set of radial rings
    FxHammerSlamRings( pos, army, 10, 3.4, 'HammerSlamRings02' )
    # Third set of radial rings
    FxHammerSlamRings( pos, army, 15, 4.45, 'HammerSlamRings03' )
end

AbilityBlueprint {
    Name = 'HRook01Death01',
    DisplayName = 'Death',
    Description = 'Rook death functional ability',
    AbilityType = 'Quiet',
    TargetAlliance = 'Enemy',
    TargetCategory = 'ALLUNITS - UNTARGETABLE',
    NoCastAnim = true,
    AffectRadius = 10,
    DamageAmt = 200,
    DamageType = 'Normal',
    OnAbilityAdded = function(self, unit)
        unit.Callbacks.OnKilled:Add(self.Death, self)
    end,
    Death = function(self, unit)
        unit:ForkThread(RookDeath, self)
    end,
}

#################################################################################################################
# Ability Keymappings & Icons
#################################################################################################################
AbilityBlueprint {
    Name = 'HRookHammerSlamGrey01',
    DisplayName = '<LOC ABILITY_HROOK_0000>Hammer Slam I',
    Description = '<LOC ABILITY_HROOK_0001>The Rook slams his hammer, dealing [GetSmallRadDamageAmt] damage in a small radius and [GetLargeRadDamageAmt] damage in a larger radius.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 1,
    HotKey = '1',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HRookHammerSlam01'].RangeMax end,
    GetSmallRadDamageAmt = function(self) return math.floor( Ability['HRookHammerSlam01'].DamageAmt + Ability['HRookHammerSlam01'].SplashDamage ) end,
    GetLargeRadDamageAmt = function(self) return math.floor( Ability['HRookHammerSlam01'].SplashDamage ) end,
    GetEnergyCost = function(self) return Ability['HRookHammerSlam01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HRookHammerSlam01'].CastingTime end,
    GetCooldown = function(self) return Ability['HRookHammerSlam01'].Cooldown end,
    Icon = '/DGRookAbilities/NewRookHammerslam01',
}

AbilityBlueprint {
    Name = 'HRookStructuralTransferGrey01',
    DisplayName = '<LOC ABILITY_HROOK_0006>Structural Transfer I',
    Description = '<LOC ABILITY_HROOK_0007>The Rook tears a structure apart, draining [GetAmount] Health over [GetDuration] seconds.',
    AbilityType = 'Passive',
    TargetAlliance = 'Any',
    UISlot = 2,
    HotKey = '2',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HRookStructuralTransfer01'].RangeMax end,
    GetAmount = function(self) return math.floor( Ability['HRookStructuralTransfer01'].Amount * Ability['HRookStructuralTransfer01'].Pulses ) end,
    GetDuration = function(self) return math.floor( Ability['HRookStructuralTransfer01'].Pulses ) end,
    GetEnergyCost = function(self) return Ability['HRookStructuralTransfer01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HRookStructuralTransfer01'].CastingTime end,
    GetCooldown = function(self) return Ability['HRookStructuralTransfer01'].Cooldown end,
    Icon = '/DGRookAbilities/NewRookStructuralTransferNew01',
}

AbilityBlueprint {
    Name = 'HRookPowerTowerGrey01',
    DisplayName = '<LOC ABILITY_HROOK_0018>Power of the Tower I',
    Description = '<LOC ABILITY_HROOK_0019>The Rook pulls a Tower of Light from the ground to defend the area.\n\nUp to [GetMaxTowers] of these towers may be active at a time.',
    AbilityType = 'Passive',
    TargetAlliance = 'Ally',
    UISlot = 3,
    HotKey = '3',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HRookTower01'].RangeMax end,
    GetMaxTowers = function(self) return math.floor( Ability['HRookTower01'].TowerMax ) end,
    GetEnergyCost = function(self) return Ability['HRookTower01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HRookTower01'].CastingTime end,
    GetCooldown = function(self) return Ability['HRookTower01'].Cooldown end,
    Icon = '/DGRookAbilities/NewRookPowerofTower01',
}

AbilityBlueprint {
    Name = 'HRookBoulderRollGrey01',
    DisplayName = '<LOC ABILITY_HROOK_0014>Boulder Roll I',
    Description = '<LOC ABILITY_HROOK_0015>The Rook rips a chunk of the earth and hurls it at enemies ahead of him, dealing [GetAmount] damage, stunning for [GetDuration] seconds, and throwing smaller units into the air.',
    AbilityType = 'Passive',
    TargetAlliance = 'Enemy',
    UISlot = 4,
    HotKey = '4',
    NoCastAnim = true,
    Placeholder = true,
    GetMaxRange = function(self) return Ability['HRookBoulderRoll01'].RangeMax end,
    GetAmount = function(self) return math.floor( Ability['HRookBoulderRoll01'].DamageAmt ) end,
    GetDuration = function(self) return math.floor( Buffs['HRookBoulderRoll01'].Duration ) end,
    GetEnergyCost = function(self) return Ability['HRookBoulderRoll01'].EnergyCost end,
    GetCastTime = function(self) return Ability['HRookBoulderRoll01'].CastingTime end,
    GetCooldown = function(self) return Ability['HRookBoulderRoll01'].Cooldown end,
    Icon = '/DGRookAbilities/NewBoulderRoll01',
}
__moduleinfo.auto_reload = true
