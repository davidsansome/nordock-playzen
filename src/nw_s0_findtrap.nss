#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Find Traps
//:: NW_S0_FindTrap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Finds and removes all traps within 30m.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

void main()
{
    if(SpellSuccess()){
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    int nCnt = 1;
    object oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTrap) && GetDistanceToObject(oTrap) <= 30.0)
    {
        if(GetIsTrapped(oTrap))
        {
            SetTrapDetectedBy(oTrap, OBJECT_SELF);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTrap));
            DelayCommand(2.0, SetTrapDisabled(oTrap));
        }
        nCnt++;
        oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    }
}
}
