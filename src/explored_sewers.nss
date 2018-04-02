//::///////////////////////////////////////////////
//:: FileName explored_sewers
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/26/2002 16:11:18
//:://////////////////////////////////////////////

#include "rr_persist"
#include "journal_include"

void main()
{
    // Set the variables
    if (dhGetJournalQuestState("grack_sewer", GetEnteringObject()) == 1)
    {
        SPI(GetEnteringObject(), "explored_sewers", 1);
        dhAddJournalQuestEntry("grack_sewer", 2, GetEnteringObject(), FALSE);
    }
}
