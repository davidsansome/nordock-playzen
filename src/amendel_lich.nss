//::///////////////////////////////////////////////
//:: FileName amendel_lich
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/3/2002 1:09:38 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "sangroluskull"))
        return FALSE;

    return TRUE;
}
