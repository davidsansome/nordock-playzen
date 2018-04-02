#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    dhAddJournalQuestEntry("kabu_inn", 1, oPC, FALSE);
    SPI(oPC, "KabuInnStage", 1);
    CreateItemOnObject("kabu_necklace", oPC);
}
