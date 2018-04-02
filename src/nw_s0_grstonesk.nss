#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Greater Stoneskin
//:: NW_S0_GrStoneSk
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the gives the creature touched 20/+5
    damage reduction.  This lasts for 1 hour per
    caster level or until 10 * Caster Level (150 Max)
    is dealt to the person.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 16 , 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 10, 2001
#include "nw_i0_spells"


void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nAmount = GetCasterLevel(OBJECT_SELF);
    int nDuration = nAmount;
    if (nAmount > 15)
    {
        nAmount = 15;
    }
    int nDamage = nAmount * 10;
    if (GetMetaMagicFeat() == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }

    effect eVis2 = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect eStone = EffectDamageReduction(20, DAMAGE_POWER_PLUS_FIVE, nDamage);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Link the texture replacement and the damage reduction effect
    effect eLink = EffectLinkEffects(eVis, eStone);
    eLink = EffectLinkEffects(eLink, eDur);
    RemoveEffectsFromSpell(OBJECT_SELF, SPELL_GREATER_STONESKIN);
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_STONESKIN, FALSE));
    //Apply the linked effect
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(nDuration));
}}
