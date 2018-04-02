//::///////////////////////////////////////////////
//:: FileName bbgivenote
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/16/2002 5:24:55 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("bbquestnote", GetPCSpeaker(), 1);
    dhAddJournalQuestEntry("denzecht_vendersh", 1, GetPCSpeaker(), FALSE);
}
