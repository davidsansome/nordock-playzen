//::///////////////////////////////////////////////
//:: Turn Undead
//:: NW_S2_TurnDead
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks domain powers and class to determine
    the proper turning abilities of the casting
    character.
*/
//:://////////////////////////////////////////////
//:: Created By: Nov 2, 2001
//:: Created On: Preston Watamaniuk
//:://////////////////////////////////////////////

#include "wm_include"

void main()
{
    int nClericLevel = GetLevelByClass(CLASS_TYPE_CLERIC);
    int nPaladinLevel = GetLevelByClass(CLASS_TYPE_PALADIN) - 2;
    int nTurnLevel = nClericLevel;
    int nClassLevel = nClericLevel;

    if (nPaladinLevel < 0) nPaladinLevel = 0;

    // Multiclass Turn, as per DMG
    nClassLevel = nPaladinLevel + nClericLevel;
    nTurnLevel = nPaladinLevel + nClericLevel;
    float nControlDuration = (nTurnLevel + 1.0) * 6.0;
    if(GetLocalInt(GetModule(),"MATERCOMP"))
    {
        object oHS;
        if(!GetIsObjectValid(oHS=GetItemPossessedBy(OBJECT_SELF, "HolySymbol")))
        {
            SendMessageToPC(OBJECT_SELF,"You must be wielding your holy symbol to "+
                "turn the undead.");
            return;
        }
        if(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)!=oHS)
        {
            SendMessageToPC(OBJECT_SELF,"You must be wielding your holy symbol to "+
                "turn the undead.");
            return;
        }
    }
    //Flags for bonus turning types
    int nElemental = GetHasFeat(FEAT_AIR_DOMAIN_POWER) + GetHasFeat(FEAT_EARTH_DOMAIN_POWER) + GetHasFeat(FEAT_FIRE_DOMAIN_POWER) + GetHasFeat(FEAT_WATER_DOMAIN_POWER);
    int nVermin = GetHasFeat(FEAT_PLANT_DOMAIN_POWER) + GetHasFeat(FEAT_ANIMAL_COMPANION);
    int nConstructs = GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER);
    int nOutsider = GetHasFeat(FEAT_GOOD_DOMAIN_POWER) + GetHasFeat(FEAT_EVIL_DOMAIN_POWER);

    //Flag for improved turning ability
    int nSun = GetHasFeat(FEAT_SUN_DOMAIN_POWER);

    //Make a turning check roll, modify if have the Sun Domain
    int nChrMod = GetAbilityModifier(ABILITY_CHARISMA);
    int nTurnCheck = d20() + nChrMod;              //The roll to apply to the max HD of undead that can be turned --> nTurnLevel
    int nTurnHD = d6(2) + nChrMod + nClassLevel;   //The number of HD of undead that can be turned.

    if(nSun == TRUE)
    {
        nTurnCheck += d4();
        nTurnHD += d6();
    }
    //Determine the maximum HD of the undead that can be turned.
    if(nTurnCheck <= 0)
    {
        nTurnLevel -= 4;
    }
    else if(nTurnCheck >= 1 && nTurnCheck <= 3)
    {
        nTurnLevel -= 3;
    }
    else if(nTurnCheck >= 4 && nTurnCheck <= 6)
    {
        nTurnLevel -= 2;
    }
    else if(nTurnCheck >= 7 && nTurnCheck <= 9)
    {
        nTurnLevel -= 1;
    }
    else if(nTurnCheck >= 10 && nTurnCheck <= 12)
    {
        //Stays the same
    }
    else if(nTurnCheck >= 13 && nTurnCheck <= 15)
    {
        nTurnLevel += 1;
    }
    else if(nTurnCheck >= 16 && nTurnCheck <= 18)
    {
        nTurnLevel += 2;
    }
    else if(nTurnCheck >= 19 && nTurnCheck <= 21)
    {
        nTurnLevel += 3;
    }
    else if(nTurnCheck >= 22)
    {
        nTurnLevel += 4;
    }

    //Gets all creatures in a 20m radius around the caster and turns them or not.  If the creatures
    //HD are 1/2 or less of the nClassLevel then the creature is destroyed.
    int nCnt = 1;
    int nHD, nRacial, nHDCount, bValid, nDamage;
    nHDCount = 0;
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVisTurn = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eDamage;
    effect eTurned = EffectTurned();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eVisTurn, eTurned);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eDeath = SupernaturalEffect(EffectDeath(TRUE));

    effect eImpactVis = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpactVis, GetLocation(OBJECT_SELF));

    //Get nearest enemy within 20m (60ft)
    //Why are you using GetNearest instead of GetFirstObjectInShape
    int nBiggest;
    object oPet;
    object oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC , OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget) && nHDCount < nTurnHD && GetDistanceToObject(oTarget) <= 20.0)
    {
        if(!GetIsFriend(oTarget))
        {
            nHD = GetHitDice(oTarget) + GetTurnResistanceHD(oTarget);
            nRacial = GetRacialType(oTarget);
            if(nHD <= nTurnLevel && nHD <= (nTurnHD - nHDCount))
            {
                //Check the various domain turning types
                if(nRacial == RACIAL_TYPE_UNDEAD)
                {
                    bValid = TRUE;
                }
                else if (nRacial == RACIAL_TYPE_VERMIN && nVermin > 0)
                {
                    bValid = TRUE;
                }
                else if (nRacial == RACIAL_TYPE_ELEMENTAL && nElemental > 0)
                {
                    bValid = TRUE;
                }
                else if (nRacial == RACIAL_TYPE_CONSTRUCT && nConstructs > 0)
                {
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));
                    nDamage = d3(nTurnLevel);
                    eDamage = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                    nHDCount += nHD;
                }
                else if (nRacial == RACIAL_TYPE_OUTSIDER && nOutsider > 0)
                {
                    bValid = TRUE;
                }

                //Apply results of the turn
                if( bValid == TRUE)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    //if(IntToFloat(nClassLevel)/2.0 >= IntToFloat(nHD))
                    //{

                    if((nClassLevel/2) >= nHD)
                    {
                        if(GetAlignmentGoodEvil(OBJECT_SELF)==ALIGNMENT_EVIL)
                        {
                            if(nHD>nBiggest)
                            {
                                nBiggest=nHD;
                                oPet=oTarget;
                            }
                            else
                            {
                            object oPlayer=OBJECT_SELF;
                            ChangeToStandardFaction(oTarget, STANDARD_FACTION_COMMONER);
                            AssignCommand(oTarget, ClearAllActions());
                            AssignCommand(oTarget, ActionForceFollowObject(oPlayer, 2.0));
                            SetLocalString(oTarget, "MY_MASTER_IS",
                                GetPCPlayerName(OBJECT_SELF));
                            DelayCommand(nControlDuration, ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE));
                            DelayCommand(nControlDuration, AssignCommand(oTarget, ClearAllActions()));
                            DelayCommand(nControlDuration, DeleteLocalString(oTarget, "MY_MASTER_IS"));
                            }
                        }
                        else
                        {
                            //Fire cast spell at event for the specified target
                            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));
                            //Destroy the target
                            DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                        }
                    }
                    else
                    {
                        //Turn the target
                        //Fire cast spell at event for the specified target
                        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));
                        AssignCommand(oTarget, ActionMoveAwayFromObject(OBJECT_SELF, TRUE));
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nClassLevel + 5));
                    }
                    nHDCount = nHDCount + nHD;
                }
            }
            bValid = FALSE;
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nCnt);
    }
    if(nBiggest)
    {
        SetLocalInt(OBJECT_SELF,"TURNUNDEAD",1);
        SetLocalString(oPet, "MY_MASTER_IS", GetPCPlayerName(OBJECT_SELF));
        SignalEvent(oPet, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));
        ActionCastSpellAtObject(SPELL_CONTROL_UNDEAD,
            oPet, METAMAGIC_NONE, TRUE, 0,
            PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
        DelayCommand(3.0, DeleteLocalInt(OBJECT_SELF,"TURNUNDEAD"));
    }
}
