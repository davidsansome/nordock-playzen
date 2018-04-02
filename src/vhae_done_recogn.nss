//::///////////////////////////////////////////////
//:: FileName vhae_done_recogn
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/7/2002 6:00:29 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "iDoneQuest") == 1))
        return FALSE;

    return TRUE;
}
