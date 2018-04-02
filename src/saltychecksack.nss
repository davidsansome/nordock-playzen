//::///////////////////////////////////////////////
//:: FileName saltychecksack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/30/2002 1:06:13 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "SackofSupplies"))
        return FALSE;

    return TRUE;
}
