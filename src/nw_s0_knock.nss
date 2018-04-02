#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Knock
//:: NW_S0_Knock
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Opens doors not locked by magical means.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 29, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk
//:: VFX Pass By: Preston W, On: June 22, 2001
#include "nw_i0_spells"

void main()
{
    if(SpellSuccess()){
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    float fDelay;
    while(GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay(0.5, 2.5);
        if(!GetPlotFlag(oTarget) && GetLocked(oTarget))
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            AssignCommand(oTarget, ActionUnlockObject(oTarget));
        }
        // added by EagleC so that knock has effect on some plot doors (up to a certain DC)
        else if(GetPlotFlag(oTarget) && GetLocked(oTarget) && GetLockUnlockDC(oTarget)<151 && !GetLockKeyRequired(oTarget)==TRUE)
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            AssignCommand(oTarget, ActionUnlockObject(oTarget));
        }
        // end of EagleC edits
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}}
