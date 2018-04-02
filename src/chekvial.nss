//::///////////////////////////////////////////////
//:: FileName chekvial
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/28/2002 8:56:07 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "EmptyVial"))
        return FALSE;

    return TRUE;
}
