#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Energy Buffer
//:: NW_S0_EneBuffer
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The caster is protected from all five energy
    types for up to 3 per caster level. When
    one element type is spent all five are
    removed.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 12, 2001
//:://////////////////////////////////////////////
#include "nw_i0_spells"

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nAmount = 60;
    int nMetaMagic = GetMetaMagicFeat();
    effect eCold = EffectDamageResistance(DAMAGE_TYPE_COLD, 40, nAmount);
    effect eFire = EffectDamageResistance(DAMAGE_TYPE_FIRE, 40, nAmount);
    effect eAcid = EffectDamageResistance(DAMAGE_TYPE_ACID, 40, nAmount);
    effect eSonic = EffectDamageResistance(DAMAGE_TYPE_SONIC, 40, nAmount);
    effect eElec = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, 40, nAmount);
    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);
    effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_ENERGY_BUFFER, FALSE));

    //Link Effects
    effect eLink = EffectLinkEffects(eCold, eFire);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eSonic);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

     RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
}
}
