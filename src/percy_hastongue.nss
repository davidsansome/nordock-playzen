//::///////////////////////////////////////////////
//:: FileName percy_hastongue
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/10/2002 11:05:27 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "NW_IT_MSMLMISC10"))
        return FALSE;

    return TRUE;
}
