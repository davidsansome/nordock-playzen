#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Gate
//:: NW_S0_Gate.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: Summons a Balor to fight for the caster.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
void CreateBalor();
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    //Make metamagic extend check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Summon the Balor and apply the VFX impact
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());

    if(GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
       GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL) ||
       GetHasSpellEffect(SPELL_HOLY_AURA))
    {
        eSummon = EffectSummonCreature("NW_S_BALOR",VFX_FNF_SUMMON_GATE,3.0);
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration)));

    }
    else
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
        DelayCommand(3.0, CreateBalor());
    }
}}

void CreateBalor()
{
     CreateObject(OBJECT_TYPE_CREATURE, "NW_S_BALOR_EVIL", GetSpellTargetLocation());
}

