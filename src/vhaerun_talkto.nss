//::///////////////////////////////////////////////
//:: FileName vhaerun_talkto
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/6/2002 11:15:25 PM
//:://////////////////////////////////////////////

#include "journal_include"
#include "rr_persist"

void main()
{
    // Set the variables
    SPI(GetPCSpeaker(), "iTalkToVhaerun", 1);
    dhAddJournalQuestEntry("drowquest", 1, GetPCSpeaker(), FALSE);

}
