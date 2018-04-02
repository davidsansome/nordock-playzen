//::///////////////////////////////////////////////
//:: FileName drowportchekgold
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/14/2002 1:20:41 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(GetGold(GetPCSpeaker())<50)
        return FALSE;

    return TRUE;
}
