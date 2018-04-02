#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Lesser Dispel
//:: NW_S0_LsDispel.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    object oTarget = GetSpellTargetObject();
    location lLocal = GetSpellTargetLocation();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);

    if(nCasterLevel > 5)
    {
        nCasterLevel = 5;
    }
    effect eDispel;
    if (GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_DISPEL));
        }
        else
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_DISPEL, FALSE));
        }
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

            if(GetIsEnemy(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_DISPEL));
            }
            else
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_DISPEL, FALSE));
            }
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDispel, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        }
    }
}}
