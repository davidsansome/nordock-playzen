//::///////////////////////////////////////////////
//:: FileName goisur_permit
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/26/2002 15:45:05
//:://////////////////////////////////////////////

#include "rr_persist"
#include "journal_include"
void main()
{
    // Give the speaker the items
    CreateItemOnObject("sewerpermit", GetPCSpeaker(), 1);
    dhAddJournalQuestEntry("grack_sewer", 1, GetPCSpeaker(), FALSE);
}
