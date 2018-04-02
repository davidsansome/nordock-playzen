#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Tensor's Transformation
//:: NW_S0_TensTrans.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the caster the following bonuses:
        +1 Attack per 2 levels
        +4 Natural AC
        20 STR and DEX and CON
        1d6 Bonus HP per level
        +5 on Fortitude Saves
        -10 Intelligence
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:://////////////////////////////////////////////
//: Sep2002: losing hit-points won't get rid of the rest of the bonuses

void main()
{
    if(SpellSuccess()){
    // Clear Action Queue to prevent chain casting exploit
    AssignCommand(GetSpellTargetObject(),ClearAllActions());
    //Declare major variables
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nHP, nCnt, nDuration;
    nDuration = GetCasterLevel(OBJECT_SELF);
    //Determine bonus HP
    for(nCnt; nCnt <= nLevel; nCnt++)
    {
        nHP += d6();
    }

    int nMeta = GetMetaMagicFeat();
    //Metamagic
    if(nMeta == METAMAGIC_MAXIMIZE)
    {
        nHP = nLevel * 6;
    }
    else if(nMeta == METAMAGIC_EMPOWER)
    {
        nHP = nHP + (nHP/2);
    }
    else if(nMeta == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    //Declare effects
    effect eAttack = EffectAttackIncrease(nLevel/2);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_FORT, 5);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect ePoly = EffectPolymorph(28);
    effect eSwing = EffectModifyAttacks(2);

    //Link effects
    effect eLink = EffectLinkEffects(eAttack, ePoly);

    eLink = EffectLinkEffects(eLink, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eSwing);

    effect eHP = EffectTemporaryHitpoints(nHP);

    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    //Signal Spell Event
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TENSERS_TRANSFORMATION, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
}}
