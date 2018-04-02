#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Grease
//:: NW_S0_Grease.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creatures entering the zone of grease must make
    a reflex save or fall down.  Those that make
    their save have their movement reduced by 1/2.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 1, 2001
//:://////////////////////////////////////////////


void main()
{
    if(SpellSuccess()){
    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_PER_GREASE);
    location lTarget = GetSpellTargetLocation();
    int nDuration = 2 + GetCasterLevel(OBJECT_SELF) / 3;
    effect eImpact = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);
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
