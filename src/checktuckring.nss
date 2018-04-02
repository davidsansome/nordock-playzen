//::///////////////////////////////////////////////
//:: FileName checktuckring
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/20/2002 10:41:48 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "CaptainTuckersSignet") && (GetTokenBool(GetPCSpeaker(), "tucker_ring") == 0))
        return TRUE;

    return FALSE;
}
