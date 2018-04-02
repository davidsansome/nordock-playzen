//::///////////////////////////////////////////////
//:: FileName burton_done
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/7/2002 12:37:20 AM
//:://////////////////////////////////////////////

#include "rr_persist"
#include "journal_include"

void main()
{
    // Set the variables
    SPI(GetPCSpeaker(), "iBurtonDone", 1);
    dhAddJournalQuestEntry("drowquest", 5, GetPCSpeaker(), FALSE);
}
