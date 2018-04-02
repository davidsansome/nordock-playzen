//::///////////////////////////////////////////////
//:: Cure Moderate Wounds
//:: NW_S0_CurModW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// As cure light wounds, except cure moderate wounds
// cures 2d8 points of damage plus 1 point per
// caster level (up to +10).
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 25, 2001
//
// modded by Marc Richter for Temple of Life in Land of Nordock module

#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    object oTarget = GetPCSpeaker ();
    effect eHeal;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);

    int nToHeal;


    nToHeal = d8(2) + 10;



    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(GetObjectByTag("Tomar"), SPELL_CURE_MODERATE_WOUNDS, FALSE));
    //Set heal effect
    eHeal = EffectHeal(nToHeal);
    //Apply VFX impact and heal effect
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    TakeGoldFromCreature(30, oTarget, TRUE);

}
