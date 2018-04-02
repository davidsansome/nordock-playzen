//::///////////////////////////////////////////////
//:: FileName henchman_recog
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/13/2002 12:18:47 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if (GetHitDice(GetPCSpeaker())>8)
        return FALSE;

    return TRUE;
}
