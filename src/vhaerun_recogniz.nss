//::///////////////////////////////////////////////
//:: FileName vhaerun_recogniz
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/6/2002 11:16:10 PM
//:://////////////////////////////////////////////

#include "rr_persist"

int StartingConditional()
{

    // Inspect local variables
    if(!(GPI(GetPCSpeaker(), "iTalkToVhaerun") == 1))
        return FALSE;

    return TRUE;
}
