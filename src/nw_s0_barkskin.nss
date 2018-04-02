#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: [Barkskin]
//:: [NW_S0_BarkSkin.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Enhances the casters Natural AC by an amount
   dependant on the caster's level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 21, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 5, 2001
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: July 20, 2001

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus;
    int nMetaMagic = GetMetaMagicFeat();
    float fDuration = HoursToSeconds(nCasterLevel);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_BARKSKIN);
    effect eHead = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eAC;
    //Signal spell cast at event
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BARKSKIN, FALSE));
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND) //Duration is +100%
    {
        fDuration = HoursToSeconds(nCasterLevel * 2);
    }

    //Determine AC Bonus based Level.
    if (nCasterLevel <= 6)
    {
        nBonus = 3;
    }
    else
    {
        if (nCasterLevel <= 12)
        {
            nBonus = 4;
        }
        else
        {
            nBonus = 5;
        }
     }
    //Make sure the Armor Bonus is of type Natural
    eAC = EffectACIncrease(nBonus, AC_NATURAL_BONUS);
    effect eLink = EffectLinkEffects(eVis, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHead, oTarget);
}}
