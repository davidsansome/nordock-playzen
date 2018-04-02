#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    dhAddJournalQuestEntry("taxcollector", 2, GetPCSpeaker(), FALSE);

    SetLocalInt(oPC, "TaxCollectorStage", 2);
    CreateItemOnObject("dibblestaxmoney", oPC, 1);
}
