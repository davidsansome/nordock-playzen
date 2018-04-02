//::///////////////////////////////////////////////
//:: FileName priestfalsestone
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/10/2004 4:58:31 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "ActivationStone"))
        return TRUE;

    return FALSE;
}
