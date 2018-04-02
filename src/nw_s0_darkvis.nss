#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Darkvision
//:: NW_S0_DarkVis
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Applies the darkvision effect to the target for
    1 hour per caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 13, 2001
//:://////////////////////////////////////////////
//Needed: New effect

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_ULTRAVISION);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eUltra = EffectUltravision();
    effect eLink = EffectLinkEffects(eVis, eDur);
    eLink = EffectLinkEffects(eLink, eVis2);
    eLink = EffectLinkEffects(eLink, eUltra);

    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DARKVISION, FALSE));
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}}
