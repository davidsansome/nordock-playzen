#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Holy Aura
//:: NW_S0_HolyAura.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The cleric casting this spell gains +4 AC and
    +4 to saves. Is immune to Mind-Affecting Spells
    used by evil creatures and gains an SR of 25
    versus the spells of Evil Creatures
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 28, 2001
//:://////////////////////////////////////////////

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nAlign = ALIGNMENT_EVIL;
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eAC = EffectACIncrease(4, AC_DEFLECTION_BONUS);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 4);
    //Change the effects so that it only applies when the target is evil
    effect eImmune = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    eImmune = VersusAlignmentEffect(eImmune, ALIGNMENT_ALL, nAlign);
    effect eSR = EffectSpellResistanceIncrease(25); //Check if this is a bonus or a setting.
    eSR = VersusAlignmentEffect(eSR,ALIGNMENT_ALL, nAlign);
    effect eDur = EffectVisualEffect (VFX_DUR_PROTECTION_GOOD_MAJOR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eDivine = EffectDamageShield(6, DAMAGE_BONUS_1d8, DAMAGE_TYPE_DIVINE);

    //Link effects
    effect eLink = EffectLinkEffects(eImmune, eSave);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eSR);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDivine);


    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HOLY_AURA, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}
}
