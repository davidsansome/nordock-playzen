//::///////////////////////////////////////////////
//:: FileName trondor_tkt_ck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/7/2002 10:48:41 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(GetLocalInt(GetPCSpeaker(), "ReceivedTrondorCoin") != 1)
        return FALSE;

    return TRUE;
}
