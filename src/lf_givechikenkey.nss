//::///////////////////////////////////////////////
//:: FileName lf_givechikenkey
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/15/2002 12:23:47 PM
//:://////////////////////////////////////////////
#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("secretchickenkey", GetPCSpeaker(), 1);
    dhAddJournalQuestEntry("legfarm", 2, GetPCSpeaker(), FALSE);
}
