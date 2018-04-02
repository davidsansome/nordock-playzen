//::///////////////////////////////////////////////
//:: FileName lf_ckchikenfthr
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/15/2002 12:31:20 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "superchickenfeather"))
        return FALSE;

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "start_chicken") == 1))
        return FALSE;

    return TRUE;
}
