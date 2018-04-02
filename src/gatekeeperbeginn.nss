//::///////////////////////////////////////////////
//:: FileName gatekeeperbeginn
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/22/2004 5:37:59 PM
//:://////////////////////////////////////////////
#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("kat_gatekeepersk", GetPCSpeaker(), 1);
    dhAddJournalQuestEntry("dragons", 1, GetPCSpeaker(), FALSE);
}
