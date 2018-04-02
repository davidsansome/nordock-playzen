//::///////////////////////////////////////////////
//:: FileName gatekeyreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/23/2004 10:41:41 PM
//:://////////////////////////////////////////////
#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("gatekeeperhousek", GetPCSpeaker(), 1);
     dhAddJournalQuestEntry("dragons", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
}
