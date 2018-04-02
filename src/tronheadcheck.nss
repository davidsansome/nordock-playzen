//::///////////////////////////////////////////////
//:: FileName tronheadcheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/1/2002 10:27:18 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "GrunBaksHead") && (GetTokenBool(GetPCSpeaker(), "trgob_quest_2") == 0))
        return TRUE;

    return FALSE;
}
