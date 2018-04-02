//::///////////////////////////////////////////////
//:: Name
//:: cohortdlg_ishire
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Used starting conditional when player wishes to rejoin after death.

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "cohort_inc"

int StartingConditional()
{
    if(GetWorkingForPlayer(GetPCSpeaker()) && GetDidDie())
        return TRUE;

    return FALSE;
}

