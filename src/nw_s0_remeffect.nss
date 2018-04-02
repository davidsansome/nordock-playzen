#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Remove Effects
//:: NW_SO_RemEffect
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Takes the place of
        Remove Disease
        Neutralize Poison
        Remove Paralysis
        Remove Curse
        Remove Blindness / Deafness
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nSpellID = GetSpellId();
    object oTarget = GetSpellTargetObject();
    int nEffect1;
    int nEffect2;
    int nEffect3;
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    //Check for which removal spell is being cast.
    if(nSpellID == SPELL_REMOVE_BLINDNESS_AND_DEAFNESS)
    {
        nEffect1 = EFFECT_TYPE_BLINDNESS;
        nEffect2 = EFFECT_TYPE_DEAF;
    }
    else if(nSpellID == SPELL_REMOVE_CURSE)
    {
        nEffect1 = EFFECT_TYPE_CURSE;
    }
    else if(nSpellID == SPELL_REMOVE_DISEASE || nSpellID == SPELLABILITY_REMOVE_DISEASE)
    {
        nEffect1 = EFFECT_TYPE_DISEASE;
        nEffect2 = EFFECT_TYPE_ABILITY_DECREASE;
    }
    else if(nSpellID == SPELL_NEUTRALIZE_POISON)
    {
        nEffect1 = EFFECT_TYPE_POISON;
        nEffect2 = EFFECT_TYPE_DISEASE;
        nEffect3 = EFFECT_TYPE_ABILITY_DECREASE;
    }

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));
    //Remove effects
    RemoveSpecificEffect(nEffect1, oTarget);
    if(nEffect2 != 0)
    {
        RemoveSpecificEffect(nEffect2, oTarget);
    }
    if(nEffect3 != 0)
    {
        RemoveSpecificEffect(nEffect3, oTarget);
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}

}
