//::///////////////////////////////////////////////
//:: FileName riddlerstep1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/10/2002 4:01:39 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("riddlescroll", GetPCSpeaker(), 1);
    DestroyObject(GetObjectByTag("Riddler"),2.0);
    dhAddJournalQuestEntry("mainquest", 7, GetPCSpeaker(), FALSE);
}
