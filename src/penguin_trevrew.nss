#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    SPI(oPC, "TrevorCompleted", 1);
    GiveXPToCreature(oPC, 1000);
    GiveGoldToCreature(oPC, 1000);
    CreateItemOnObject("ringofanimalfrie", oPC);
    dhAddJournalQuestEntry("penguin_trevor", 2, oPC, FALSE, FALSE, FALSE, TRUE);
}
