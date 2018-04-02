//::///////////////////////////////////////////////
//:: FileName silent_is_he
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/17/2002 7:26:59 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "bro_ring_NOD"))
        return FALSE;

    return TRUE;
}
