//::///////////////////////////////////////////////
//:: FileName renalcahrmchek
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 12:25:15 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ATS_C_A921_N_GOL"))
        return FALSE;

    return TRUE;
}
