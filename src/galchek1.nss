//::///////////////////////////////////////////////
//:: FileName galchek1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 10:07:28 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "rr_persist"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(GPI(GetPCSpeaker(), "nMainQuest"))
        return FALSE;

    return TRUE;
}
