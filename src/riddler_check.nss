//::///////////////////////////////////////////////
//:: FileName riddler_check
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 3:41:05 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ATS_C_A023_N_RUB"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "ATS_C_W130_N_MIT"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "Drowheadhighpriestess"))
        return FALSE;
    return TRUE;
}
