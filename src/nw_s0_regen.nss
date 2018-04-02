#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Regenerate
//:: NW_S0_Regen
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Grants the selected target 6 HP of regeneration
    every round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 22, 2001
//:://////////////////////////////////////////////

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eRegen = EffectRegenerate(6, 6.0);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eRegen, eDur);


    int nMeta = GetMetaMagicFeat();
    int nLevel = GetCasterLevel(OBJECT_SELF);
    //Meta-Magic Checks
    if (nMeta == METAMAGIC_EXTEND)
    {
        nLevel *= 2;

    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REGENERATE, FALSE));
    //Apply effects and VFX
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nLevel));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

}}
