//::///////////////////////////////////////////////
//:: FileName checktoken1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/8/2002 8:50:30 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "TokenofPossession"))
        return FALSE;

    return TRUE;
}
