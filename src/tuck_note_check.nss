//::///////////////////////////////////////////////
//:: FileName tuck_note_check
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/29/2002 12:52:09 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "rr_persist"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "bloodstainednote"))
        return FALSE;
    if(GPI(GetPCSpeaker(), "OrcShamanHeadCompleted") == 1)
        return FALSE;

    return TRUE;
}
