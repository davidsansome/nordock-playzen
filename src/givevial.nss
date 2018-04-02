//::///////////////////////////////////////////////
//:: FileName givevial
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/28/2002 8:56:07 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("emptyvial", GetPCSpeaker(), 1);

    dhAddJournalQuestEntry("redbeetle", 1, GetPCSpeaker(), FALSE);

}
