//::///////////////////////////////////////////////
//:: FileName burton_trinket
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/6/2002 11:44:49 PM
//:://////////////////////////////////////////////

#include "journal_include"
#include "rr_persist"

void main()
{
    // Set the variables
    SPI(GetPCSpeaker(), "iBurtonTrinket", 1);
    dhAddJournalQuestEntry("drowquest", 4, GetPCSpeaker(), FALSE);
}
