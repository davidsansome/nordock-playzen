//::///////////////////////////////////////////////
//:: FileName lockbox_check
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/20/2002 9:15:57 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "PlayerLockBox_NOD"))
        return TRUE;

    return FALSE;
}
