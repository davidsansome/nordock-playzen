//::///////////////////////////////////////////////
//:: FileName givebooktkan
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/29/2002 6:21:32 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("bookoftkan", GetPCSpeaker(), 1);
    SetLocalInt(GetPCSpeaker(),"OnTkanQuest",1);
    dhAddJournalQuestEntry("bookoftkan", 1, GetPCSpeaker(), FALSE);
}
