#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: See Invisibility
//:: NW_S0_SeeInvis.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows the mage to see creatures that are
    invisible
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSight = EffectSeeInvisible();
    effect eLink = EffectLinkEffects(eVis, eSight);
    eLink = EffectLinkEffects(eLink, eDur);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SEE_INVISIBILITY, FALSE));
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}}
