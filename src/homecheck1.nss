//::///////////////////////////////////////////////
//:: FileName homechek
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/22/2003 1:29:16 PM
//:://////////////////////////////////////////////
#include "rr_persist"

int StartingConditional()
{

    // Inspect local variables
    if(!(GPI(GetPCSpeaker(), "home_owner") == 0))
        return FALSE;

    return TRUE;
}
