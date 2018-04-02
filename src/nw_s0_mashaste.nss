#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Mass Haste
//:: NW_S0_MasHaste.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies in a 30 ft radius from the point of
    impact become Hasted for 1 round per caster
    level.  The maximum number of allies hasted is
    1 per caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 29, 2001
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget;
    effect eHaste = EffectHaste();
    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHaste, eDur);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    //Determine spell duration as an integer for later conversion to Rounds, Turns or Hours.
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nCount;
    location lSpell = GetSpellTargetLocation();

    //Meta Magic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    //Cycle through the targets within the spell shape until an invalid object is captured or the number of
    //targets affected is equal to the caster level.
    while(GetIsObjectValid(oTarget) && nCount != nDuration)
    {
        //Make faction check on the target
        if(GetIsFriend(oTarget))
        {
            fDelay = GetRandomDelay(0.0, 1.0);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HASTE, FALSE));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            nCount++;
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }
}

}
