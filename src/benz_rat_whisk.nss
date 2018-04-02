//::///////////////////////////////////////////////
//:: FileName has_rat_whisk
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/10/2002 11:04:57 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "Ratwhisker"))
        return FALSE;

    return TRUE;
}

