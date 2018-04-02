//::///////////////////////////////////////////////
//:: FileName burton_notrinkt
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/6/2002 11:46:35 PM
//:://////////////////////////////////////////////

#include "rr_persist"

int StartingConditional()
{

    // Inspect local variables
    if(!(GPI(GetPCSpeaker(), "iBurtonTrinket") == 1))
        return FALSE;

    return TRUE;
}
