//::///////////////////////////////////////////////
//:: FileName ck_cleared_crypt
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/30/2002 13:08:08
//:://////////////////////////////////////////////

#include "journal_include"

int StartingConditional()
{

    // Inspect local variables
    if(dhGetJournalQuestState("grack_sewer", GetPCSpeaker()) == 3)
        return TRUE;

    return FALSE;
}
