//::///////////////////////////////////////////////
//:: FileName pav_retrieved
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2002-11-14 19:52:04
//:://////////////////////////////////////////////
#include "apts_inc_ptok"

int StartingConditional()
{

    // Inspect local variables
    if(((GetLocalInt(GetPCSpeaker(), "sPaladinQuestOnProcess") == 1) || GetItemPossessor(GetObjectByTag("LordTyrmonsSignetRing")) == GetPCSpeaker()) && (GetTokenBool(GetPCSpeaker(), "PaladinQuestComplete") == 0))
        return TRUE;

    return FALSE;
}
