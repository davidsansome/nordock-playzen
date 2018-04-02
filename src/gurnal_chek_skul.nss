//::///////////////////////////////////////////////
//:: FileName gurnal_chek_skul
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/27/2002 11:26:22 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "sangroluskull") && (GetTokenBool(GetPCSpeaker(), "LichQuestComplete") == 0))
        return TRUE;

    return FALSE;
}
