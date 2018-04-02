//::///////////////////////////////////////////////
//:: FileName arenacheckgold
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/12/2002 12:57:17 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has enough gold
    if(GetGold(GetPCSpeaker())< 300)
        return FALSE;

    return TRUE;
}
