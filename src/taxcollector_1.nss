#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "TaxCollectorStage", 1);
    dhAddJournalQuestEntry("taxcollector", 1, oPC, FALSE);
}
