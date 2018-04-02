#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Mind Fog
//:: NW_S0_MindFog.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a bank of fog that lowers the Will save
    of all creatures within who fail a Will Save by
    -10.  Affect lasts for 2d6 rounds after leaving
    the fog
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 1, 2001
//:://////////////////////////////////////////////

void main()
{
    if(SpellSuccess()){
    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGMIND);
    location lTarget = GetSpellTargetLocation();
    int nDuration = 2 + GetCasterLevel(OBJECT_SELF) / 2;
    effect eImpact = EffectVisualEffect(262);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    int nMetaMagic = GetMetaMagicFeat();
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}
}
