//::///////////////////////////////////////////////
//:: Summon Slaad
//:: NW_S0_SummSlaad
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// Create crafted automaton
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 14, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 25, 2001

void main()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    effect eSummon = EffectSummonCreature("ats_gnome_auto",VFX_FNF_SUMMON_MONSTER_3);
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    //Apply the VFX impact and summon effect
    //ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eSummon, GetSpellTargetLocation());
}
