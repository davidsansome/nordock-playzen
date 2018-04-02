// hc_grenade
// Archaegeo 12 July 2002
// handles grenadelike attacks (oil flasks, alchemists fire, etc)

// Modified by Celedhros, 29 July 2002
// Added PHB deviation rules, enhanced visual effects, and various bug fixes

#include "hc_text_grenade"

void main()
{
    object oPC = OBJECT_SELF;
    object oItem = GetLocalObject(oPC,"GRENADE");
    object oTarget = GetLocalObject(oPC,"GRENADETARGET");
    object oSplashTarget;
    object oDeviation;
    float nRangeInc;
    float fDirection = GetFacing(oPC);
    float fDist;
    float fDeviation;
    float fDeviateDist;
    int iDirection;
    location lTarget;
    location lPC;
    vector vTarget;
    vector vDeviation;
    effect eVis;
    effect eExplode;
    effect eDam;
    effect eSplash;
    string sNM = GetTag(oItem);

//  Set Range Increment in meters
    nRangeInc = FeetToMeters(10.0);
    if (sNM == "hc_thunder")
    nRangeInc = FeetToMeters(20.0);
//  Determine if the target is an object or location and apply the correct function
    if(oTarget == OBJECT_INVALID)
    {
        lTarget = GetItemActivatedTargetLocation();
    } else {
        lTarget = GetLocation(oTarget);
    }
    lPC = GetLocation(oPC);
    fDist = GetDistanceBetweenLocations(lPC, lTarget);
//  Test for maximum range
    if(fDist > 5.0*nRangeInc)
    {
        SendMessageToPC(oPC, THROWLIMIT);
        return;
    }
//  Determine damage and effect types
    if(sNM == "hc_holywater")
    {
        eVis = EffectVisualEffect(VFX_IMP_HEALING_S);
        eExplode = EffectVisualEffect(VFX_IMP_PULSE_WATER);
        eDam = EffectDamage(d4(2), DAMAGE_TYPE_DIVINE);
        eSplash = EffectDamage(1, DAMAGE_TYPE_DIVINE);
    } else if(sNM == "hc_acidflask") {
        eVis = EffectVisualEffect(VFX_IMP_ACID_S);
        eDam = EffectDamage(d6(), DAMAGE_TYPE_ACID);
        eSplash = EffectDamage(1, DAMAGE_TYPE_ACID);
    } else if(sNM == "hc_thunder"){
        eVis = EffectVisualEffect(VFX_IMP_SONIC);
        eExplode = EffectVisualEffect(VFX_IMP_PULSE_WIND);
        eDam = EffectDeaf();
        eSplash = EffectDeaf();
    } else if(sNM == "hc_tangle") {
        eVis = EffectVisualEffect(VFX_IMP_SLOW);
        eDam = EffectEntangle();
    }
    else {
        eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
        eExplode = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
        eDam = EffectDamage(d6(), DAMAGE_TYPE_FIRE);
        eSplash = EffectDamage(1, DAMAGE_TYPE_FIRE);
    }
//  Ranged touch attack for grenadelike weapons
    int touchAttack = TouchAttackRanged(oTarget, 1);
    if(touchAttack == 1 || touchAttack == 2)
    {
        if(sNM == "hc_tangle")
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oTarget, TurnsToSeconds(1));
            //Duration of standing still (assumes that the player takes 3 rounds removing themself from the "goo")
            int iTangle = 3;
            if (d20()+ GetAbilityModifier(ABILITY_STRENGTH, oTarget) > 27)
                iTangle = 1;
            //Reflex Save to avoid 90% movement decrease (standing still)
            if (!ReflexSave(oTarget, 15))
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedDecrease(90), oTarget, RoundsToSeconds(iTangle));
            DestroyObject(oItem);
            return;
        }

        if(sNM == "hc_oilflask" && Random(100) < 50)
        {
            SendMessageToPC(oPC, FAILIGNITE);
            DestroyObject(oItem);
            return;
        }
        if(sNM == "hc_holywater" && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
        {
            SendMessageToPC(oPC, NOEFFECT);
            DestroyObject(oItem);
        }
        else {
                if (sNM == "hc_thunder")
                {
                    if (!FortitudeSave(oTarget,15))
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, oTarget);
                }
                else {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
//  Second round 1d6 Damage for Oil and Alchemist's Fire with Reflex DC15 to avoid
            if (sNM != "hc_tangle" && sNM != "hc_thunder" &&
            sNM != "hc_acidflask" && sNM != "hc_holywater" && !ReflexSave(oTarget, 15, SAVING_THROW_TYPE_FIRE))
            {
                eDam = EffectDamage(d6(), DAMAGE_TYPE_FIRE);
                DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            }
            }
        }
//  Grenadelike weapon deviation per PHB pg. 138
    } else if (touchAttack == 0 && oTarget != OBJECT_INVALID) {
        vTarget = GetPositionFromLocation(lTarget);
        oDeviation = GetAreaFromLocation(lTarget);
        fDeviation = GetFacingFromLocation(lTarget);
        fDeviateDist = IntToFloat(d6());
        fDeviateDist = FeetToMeters(fDeviateDist) + (fDist/nRangeInc);
        fDirection = fDirection/45;
        iDirection = FloatToInt(fDirection);
        if (iDirection == 8) iDirection = 0;
        iDirection = iDirection + d8();
        if (iDirection > 8) iDirection = iDirection - 8;
        switch (iDirection)
        {
            case 1:
            vDeviation = Vector(fDeviateDist,0.0,0.0);
            break;
            case 2:
            fDeviateDist = sqrt((pow(fDeviateDist,2.0)/2));
            vDeviation = Vector(fDeviateDist,(0.0-fDeviateDist),0.0);
            break;
            case 3:
            vDeviation = Vector(0.0,(0.0-fDeviateDist),0.0);
            break;
            case 4:
            fDeviateDist = sqrt((pow(fDeviateDist,2.0)/2));
            vDeviation = Vector((0.0-fDeviateDist),(0.0-fDeviateDist),0.0);
            break;
            case 5:
            vDeviation = Vector((0.0-fDeviateDist),0.0,0.0);
            break;
            case 6:
            fDeviateDist = sqrt((pow(fDeviateDist,2.0)/2));
            vDeviation = Vector((0.0-fDeviateDist),fDeviateDist,0.0);
            break;
            case 7:
            vDeviation = Vector(0.0,fDeviateDist,0.0);
            break;
            case 8:
            fDeviateDist = sqrt((pow(fDeviateDist,2.0)/2));
            vDeviation = Vector(fDeviateDist,fDeviateDist,0.0);
            break;
        }
        vDeviation = vDeviation + vTarget;
        lTarget = Location(oDeviation,vDeviation,fDeviation);
    }
//  Apply visual effects at target location
    if (sNM == "hc_holywater" && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && touchAttack == 1)
    {
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, lTarget);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eExplode, lTarget);
    } else if (sNM != "hc_holywater"){
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, lTarget);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eExplode, lTarget);
    } else {
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eExplode, lTarget);
    }
    SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_MAGIC_MISSILE));
//  Apply splash damage radius and get first target
    float nSplashRange = FeetToMeters(5.0);
    if (sNM == "hc_thunder")
        nSplashRange = FeetToMeters(10.0);
    oSplashTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSplashRange, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oSplashTarget))
    {
//  If PC makes successful touch attack, do not apply splash damage to target
        if (oTarget == oSplashTarget && touchAttack == 1)
        {
            oSplashTarget = GetNextObjectInShape(SHAPE_SPHERE, nSplashRange, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        } else if (sNM!="hc_holywater"){
//  Apply splash damage to valid target in radius and get next valid target
            if (sNM == "hc_thunder") //Thunderstone Deafness
            {
                if (!FortitudeSave(oSplashTarget, 15))
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSplash, oSplashTarget);
            }
            else
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eSplash, oSplashTarget);
            SignalEvent(oSplashTarget, EventSpellCastAt(oPC, SPELL_MAGIC_MISSILE));
            oSplashTarget = GetNextObjectInShape(SHAPE_SPHERE, nSplashRange, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        } else if (sNM == "hc_holywater" && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD){
//  Apply holy water splash damage to valid target in radius and get next target
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eSplash, oSplashTarget);
            SignalEvent(oSplashTarget, EventSpellCastAt(oPC, SPELL_MAGIC_MISSILE));
            oSplashTarget = GetNextObjectInShape(SHAPE_SPHERE, nSplashRange, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        } else {
//  Get next valid target if holy water splash target is not undead
            oSplashTarget = GetNextObjectInShape(SHAPE_SPHERE, nSplashRange, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    DestroyObject(oItem);
    return;
}
