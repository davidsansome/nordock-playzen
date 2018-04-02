#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Create Greater Undead
//:: NW_S0_CrGrUnd.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons an undead type pegged to the character's
    level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel;
    nDuration = 24;
    effect eSummon;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    //Make metamagic extend check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Determine undead to summon based on level
    if (nCasterLevel <= 15)
    {
        eSummon = EffectSummonCreature("NW_S_VAMPIRE",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 16) && (nCasterLevel <= 17))
    {
        eSummon = EffectSummonCreature("NW_S_DOOMKGHT",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 18) && (nCasterLevel <= 19))
    {
        eSummon = EffectSummonCreature("NW_S_LICH",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
        eSummon = EffectSummonCreature("NW_S_MUMCLERIC",VFX_FNF_SUMMON_UNDEAD);
    }
    //Apply summon effect and VFX impact.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
}
}
