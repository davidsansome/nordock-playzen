//::///////////////////////////////////////////////
//:: FileName percychekpouch
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 1:40:19 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ATS_C_L942_N_SLH"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "Blackberrygem"))
        return FALSE;

    return TRUE;
}
