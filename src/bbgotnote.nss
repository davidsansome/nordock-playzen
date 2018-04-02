//::///////////////////////////////////////////////
//:: FileName bbgotnote
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/16/2002 5:17:33 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "bbquestnote") && (GetTokenBool(GetPCSpeaker(), "denzecht_vendersh") == 0))
        return TRUE;

    return FALSE;
}
