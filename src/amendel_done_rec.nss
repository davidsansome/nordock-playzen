//::///////////////////////////////////////////////
//:: FileName amendel_done_rec
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/27/2002 11:25:26 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "miracle_blade_NOD"))
        return FALSE;
    if(!CheckPartyForItem(GetPCSpeaker(), "miracle_shield_NOD"))
        return FALSE;

    return TRUE;
}
