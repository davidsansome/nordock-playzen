//::///////////////////////////////////////////////
//:: FileName burton_donequest
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/7/2002 12:51:14 AM
//:://////////////////////////////////////////////

#include "rr_persist"


int StartingConditional()
{

    // Inspect local variables
    if(!(GPI(GetPCSpeaker(), "iDoneBurton") == 1))
        return FALSE;

    return TRUE;
}
