#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Aura of Vitality
//:: NW_S0_AuraVital
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies within the AOE gain +4 Str, Con, Dex
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget;
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH,4);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY,4);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION,4);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eStr, eDex);
    eLink = EffectLinkEffects(eLink, eCon);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    float fDelay;

    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2; //Duration is +100%
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetFactionEqual(oTarget) || GetIsReactionTypeFriendly(oTarget))
        {
            fDelay = GetRandomDelay(0.4, 1.1);
            //Signal the spell cast at event
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AURA_OF_VITALITY, FALSE));
            //Apply effects and VFX to target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}}
