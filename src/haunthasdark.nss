//::///////////////////////////////////////////////
//:: FileName haunthasdark
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/1/2002 9:23:14 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "DarktoothScimitar"))
        return FALSE;

    return TRUE;
}
