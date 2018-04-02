#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "TaxCollectorStage", 0);
    SPI(oPC, "TaxCollectorCompleted", 1);
    dhAddJournalQuestEntry("taxcollector", 3, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);

    GiveXPToCreature(oPC, 500);
    AdjustAlignment(oPC, ALIGNMENT_LAWFUL, 10);
}
