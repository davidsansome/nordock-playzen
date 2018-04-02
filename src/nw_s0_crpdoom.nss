#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Creeping Doom
//:: NW_S0_CrpDoom
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The druid calls forth a mass of churning insects
    and scorpians that bite and sting all those within
    a 20ft square.  The total spell effects does
    1000 damage to all withiin the area of effect
    until all damage is dealt.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On:  , 2001
//:://////////////////////////////////////////////
//Needed would require an entry into the VFX_Persistant.2DA and a new AOE constant

void main()
{
    if(SpellSuccess()){
    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_PER_CREEPING_DOOM);
    location lTarget = GetSpellTargetLocation();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}
}
