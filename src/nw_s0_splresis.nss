#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Spell Resistance
//:: NW_S0_SplResis
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The target creature gains 12 + Caster Level SR.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 19, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 25, 2001

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = 12 + nLevel;
    effect eSR = EffectSpellResistanceIncrease(nBonus);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGIC_PROTECTION);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eDur2 = EffectVisualEffect(249);
    effect eLink = EffectLinkEffects(eSR, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SPELL_RESISTANCE, FALSE));
    //Check for metamagic extension
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nLevel = nLevel *2; //Duration is +100%
    }
    //Apply VFX impact and SR bonus effect
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nLevel));
}}
