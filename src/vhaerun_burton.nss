//::///////////////////////////////////////////////
//:: FileName vhaerun_burton
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/7/2002 12:32:08 AM
//:://////////////////////////////////////////////

#include "journal_include"
#include "rr_persist"

void main()
{
    // Set the variables
    SPI(GetPCSpeaker(), "iBurton", 1);
    dhAddJournalQuestEntry("drowquest", 3, GetPCSpeaker(), FALSE);
}
