//::///////////////////////////////////////////////
//:: FileName dorneryllscheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/10/2002 6:39:26 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "DorneryllsSheath") && (GetTokenBool(GetPCSpeaker(), "dorn_quest_2") == 0))
        return TRUE;

    return FALSE;
}
