//::///////////////////////////////////////////////
//:: FileName sc_ironsidedomo2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2002-10-31 12:40:30
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(CheckPartyForItem(GetPCSpeaker(), "tokenofvalor"))
        return FALSE;

    return TRUE;
}
