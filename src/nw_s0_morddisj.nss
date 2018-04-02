#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Mordenkainen's Disjunction
//:: NW_S0_MordDisj.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Massive Dispel Magic and Spell Breach rolled into one
    If the target is a general area of effect they lose
    6 spell protections.  If it is an area of effect everyone
    in the area loses 2 spells protections.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
void StripEffects(int nNumber, object oTarget);
#include "NW_I0_SPELLS"

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_BREACH);
    effect eImpact = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);
    object oTarget = GetSpellTargetObject();
    location lLocal = GetSpellTargetLocation();
    effect eSR = EffectSpellResistanceDecrease(10);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eDur, eSR);
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    float fDelay;
    if(nCasterLevel > 20)
    {
        nCasterLevel = 20;
    }
    //Apply the VFX impact and effects
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    effect eDispel;
    if (GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay(1.0, 2.0);
        if(GetIsEnemy(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MORDENKAINENS_DISJUNCTION));
            StripEffects(6, oTarget);
        }
        else
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MORDENKAINENS_DISJUNCTION, FALSE));
        }
        //Apply the VFX impact and effects
        eDispel = EffectDispelMagicAll(nCasterLevel);
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDispel, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(10)));
    }
    else
    {
        eDispel = EffectDispelMagicBest(nCasterLevel);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        while (GetIsObjectValid(oTarget))
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                DestroyObject(oTarget, 0.0);
            }
            fDelay = GetRandomDelay(1.0, 2.0);
            if(GetIsEnemy(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MORDENKAINENS_DISJUNCTION));
                StripEffects(2, oTarget);
            }
            else
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MORDENKAINENS_DISJUNCTION, FALSE));
            }
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDispel, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(10)));
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        }
    }
}}


void StripEffects(int nNumber, object oTarget)
{
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_BREACH);
    int nCnt, nIdx;
    int nTotal = nNumber;
    if(GetIsEnemy(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_SPELL_BREACH));
        //Search through and remove protections.
        while(nCnt <= 17 && nIdx < nTotal)
        {
            nIdx = nIdx + RemoveProtections(GetSpellBreachProtection(nCnt), oTarget, nCnt);
            nCnt++;
        }
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
