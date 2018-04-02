//::///////////////////////////////////////////////
//:: FileName tucker_head
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/29/2002 1:00:21 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "rr_persist"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "OrcShamanHead"))
        return FALSE;
    if(GPI(GetPCSpeaker(), "OrcShamanHeadCompleted") == 1)
        return FALSE;

    return TRUE;
}
