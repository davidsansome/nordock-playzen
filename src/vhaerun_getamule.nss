//::///////////////////////////////////////////////
//:: FileName vhaerun_getamule
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/7/2002 12:38:46 AM
//:://////////////////////////////////////////////

#include "rr_persist"

int StartingConditional()
{

    // Inspect local variables
    if(!(GPI(GetPCSpeaker(), "iBurtonDone") == 1))
        return FALSE;

    return TRUE;
}
