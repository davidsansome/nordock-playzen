//::///////////////////////////////////////////////
//:: FileName mcgornnote
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/4/2002 9:42:20 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("notetosgtmcgorn", GetPCSpeaker(), 1);
    dhAddJournalQuestEntry("trondor", 2, GetPCSpeaker(), FALSE);
}
