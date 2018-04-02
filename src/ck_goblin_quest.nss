//::///////////////////////////////////////////////
//:: FileName ck_goblin_quest
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/30/2002 13:41:38
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "rr_persist"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "KlandsHead"))
        return FALSE;

    // Inspect local variables
    if(!(GPI(GetPCSpeaker(), "goblin_dead") == 0))
        return FALSE;

    return TRUE;
}
