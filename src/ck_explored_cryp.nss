//::///////////////////////////////////////////////
//:: FileName ck_explored_cryp
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/26/2002 16:28:44
//:://////////////////////////////////////////////

#include "rr_persist"
int StartingConditional()
{

    // Inspect local variables
    if(!(GPI(GetPCSpeaker(), "cleared_crypt") == 1))
        return FALSE;

    return TRUE;
}
