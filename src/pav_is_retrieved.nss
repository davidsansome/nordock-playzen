//::///////////////////////////////////////////////
//:: FileName pav_is_retrieved
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2002-11-14 19:56:18
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if (!(HasItem(GetPCSpeaker(), "LordTyrmonsSignetRing")))
        return FALSE;

    return TRUE;
}
