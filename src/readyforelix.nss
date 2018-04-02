//::///////////////////////////////////////////////
//:: FileName readyforelix
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/28/2002 9:13:35 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "NW_IT_MSMLMISC08"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "EmptyVial"))
        return FALSE;

    return TRUE;
}
