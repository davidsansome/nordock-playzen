//::///////////////////////////////////////////////
//:: FileName vhaerun_tomechek
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/6/2002 11:13:21 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "tome_vhaerun"))
        return FALSE;

    return TRUE;
}
