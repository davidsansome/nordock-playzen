//::///////////////////////////////////////////////
//:: FileName ck_permision
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/25/2002 22:39:19
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "SewerPermit"))
        return FALSE;

    return TRUE;
}
