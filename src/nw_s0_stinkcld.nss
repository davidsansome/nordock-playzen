#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Stinking Cloud
//:: NW_S0_StinkCld.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Those within the area of effect must make a
    fortitude save or be dazed.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 17, 2001
//:://////////////////////////////////////////////

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGSTINK);
    location lTarget = GetSpellTargetLocation();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eImpact = EffectVisualEffect(259);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    int nMetaMagic = GetMetaMagicFeat();
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}
}
