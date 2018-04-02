#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "TaxCollectorStage", 0);
    SPI(oPC, "TaxCollectorCompleted", 1);
    dhAddJournalQuestEntry("taxcollector", 4, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);

    GiveGoldToCreature(oPC, 250);
    GiveXPToCreature(oPC, 250);
    AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 10);
}
