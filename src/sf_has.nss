//::///////////////////////////////////////////////
//:: FileName sf_has
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/11/2002 1:31:46 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "SoulFrag_NOD"))
        return FALSE;

    return TRUE;
}
