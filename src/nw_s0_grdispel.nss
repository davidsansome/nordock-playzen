#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Greater Dispelling
//:: NW_S0_GrDispel.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ODD);
    effect eImpact = EffectVisualEffect(VFX_FNF_DISPEL_GREATER);
    object oTarget = GetSpellTargetObject();
    location lLocal = GetSpellTargetLocation();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    float fDelay;
    if(nCasterLevel > 15)
    {
        nCasterLevel = 15;
    }
    effect eDispel;
    if (GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_DISPELLING));
        }
        else
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_DISPELLING, FALSE));
        }
        //Apply the VFX impact and effects
        eDispel = EffectDispelMagicAll(nCasterLevel);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDispel, oTarget);
    }
    else
    {
        eDispel = EffectDispelMagicBest(nCasterLevel);
        //Apply the VFX impact and effects
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        while (GetIsObjectValid(oTarget))
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                DestroyObject(oTarget, 0.0);
            }
            fDelay = GetRandomDelay(0.75, 1.75);
            if(GetIsEnemy(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_DISPELLING));
            }
            else
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_DISPELLING, FALSE));
            }
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDispel, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        }
    }
}}
