//::///////////////////////////////////////////////
//:: FileName pav_qstfinished
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2002-11-17 00:31:16
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(GetItemPossessor(GetObjectByTag("FaithofSteel_NOD")) == GetPCSpeaker() && GetItemPossessor(GetObjectByTag("LordTyrmonsSignetRing")) != GetPCSpeaker())
        return TRUE;

    return FALSE;
}
