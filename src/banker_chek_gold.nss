//::///////////////////////////////////////////////
//:: FileName banker_chek_gold
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/28/2002 11:29:17 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(GetGold(GetPCSpeaker())>= 1000)
        return TRUE;

    return FALSE;
}
