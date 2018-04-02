//::///////////////////////////////////////////////
//:: FileName giverubykey
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/5/2002 3:16:33 PM
//:://////////////////////////////////////////////
#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("rubykey_NOD", GetPCSpeaker(), 1);
    dhAddJournalQuestEntry("mainquest", 3, GetPCSpeaker(), FALSE);
}
