#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Dispel Magic
//:: NW_S0_DisMagic.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: Attempts to dispel all magic on a targeted
//:: object, or simply the most powerful that it
//:: can on every object in an area if no target
//:: specified.
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
    effect eImpact = EffectVisualEffect(VFX_FNF_DISPEL);
    object oTarget = GetSpellTargetObject();
    location lLocal = GetSpellTargetLocation();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    float fDelay;
    if(nCasterLevel > 10)
    {
        nCasterLevel = 10;
    }
    effect eDispel;
    if (GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay(1.0, 2.0);
        if(GetIsEnemy(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISPEL_MAGIC));
        }
        else
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISPEL_MAGIC, FALSE));
        }
        eDispel = EffectDispelMagicAll(nCasterLevel);
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDispel, oTarget));
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

            fDelay = GetRandomDelay(1.0, 2.0);
            if(GetIsEnemy(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISPEL_MAGIC));
            }
            else
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISPEL_MAGIC, FALSE));
            }
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDispel, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        }
    }
}


}
