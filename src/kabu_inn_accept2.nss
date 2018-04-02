#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    dhAddJournalQuestEntry("kabu_inn", 2, oPC, FALSE);
    SPI(oPC, "KabuInnStage", 3);
}
