#include "journal_include"
#include "rr_persist"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("brenvillagekey", oPC, 1);
    dhAddJournalQuestEntry("bren", 2, oPC, FALSE, FALSE, FALSE, TRUE);
    SPI(oPC, "GaldorBren", 1);
}
