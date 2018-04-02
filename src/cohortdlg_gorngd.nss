//cohortdlg_gorngd, built from nw_ch_goranged
//
//Modified by Edward Beck (0100010) for Cohort system on September 2, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.

//::///////////////////////////////////////////////
//:: Set To Ranged Only
//:: nw_ch_goranged
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes the henchmen go to ranged combat.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 5th, 2002
//:://////////////////////////////////////////////
#include "paus_inc_generic"
void main()
{
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON);
    ClearAllActions();
    EquipAppropriateWeapons(OBJECT_SELF);
}
