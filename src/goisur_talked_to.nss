//::///////////////////////////////////////////////
//:: FileName goisur_talked_to
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/5/2002 16:00:06
//:://////////////////////////////////////////////

#include "rr_persist"
#include "journal_include"

void main()
{
    // Set the variables
    SPI(GetPCSpeaker(), "goisur_talked_to", 1);
    dhAddJournalQuestEntry("goblin_nest", 1, GetPCSpeaker(), FALSE);
}
