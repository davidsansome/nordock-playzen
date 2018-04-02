#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Premonition
//:: NW_S0_Premo
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the gives the creature touched 30/+5
    damage reduction.  This lasts for 1 hour per
    caster level or until 10 * Caster Level
    is dealt to the person.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 16 , 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
#include "nw_i0_spells"

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nLimit = nDuration * 10;
    int nMetaMagic = GetMetaMagicFeat();
    effect eStone = EffectDamageReduction(30, DAMAGE_POWER_PLUS_FIVE, nLimit);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
    //Link the visual and the damage reduction effect
    effect eLink = EffectLinkEffects(eStone, eVis);
    //Enter Metamagic conditions
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_PREMONITION, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

       RemoveEffectsFromSpell(OBJECT_SELF, SPELL_PREMONITION);

    //Apply the linked effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(nDuration));
}}
