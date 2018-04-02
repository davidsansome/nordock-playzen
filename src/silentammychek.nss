//::///////////////////////////////////////////////
//:: FileName silentammychek
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/17/2002 7:17:48 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "TuckersAmulet"))
        return FALSE;

    return TRUE;
}
